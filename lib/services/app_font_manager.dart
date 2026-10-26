import 'dart:io';

import 'package:ex_piliplus/models/common/app_font_family.dart';
import 'package:ex_piliplus/services/app_font_archive_extractor.dart';
import 'package:ex_piliplus/utils/path_utils.dart';
import 'package:ex_piliplus/utils/storage.dart';
import 'package:ex_piliplus/utils/storage_key.dart';
import 'package:ex_piliplus/utils/storage_pref.dart';
import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart' as path;

typedef AppFontDownloadProgress = ({int received, int total});

enum AppFontDownloadError {
  incompleteFile,
  loadFailed,
  http,
  licenseExtractionFailed,
  downloadFailed,
  sizeMismatch,
  checksumMismatch,
  timeout,
  network,
  saveFailed,
}

final class AppFontDownloadException implements Exception {
  const AppFontDownloadException(this.error, {this.statusCode});

  final AppFontDownloadError error;
  final int? statusCode;

  @override
  String toString() => 'App font error: ${error.name}';
}

abstract final class AppFontManager {
  static final Dio _dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(minutes: 2),
      followRedirects: true,
      maxRedirects: 8,
      headers: const {
        HttpHeaders.acceptHeader: 'application/octet-stream',
        HttpHeaders.userAgentHeader: 'PiliPlus font downloader',
      },
      validateStatus: (status) =>
          status != null && status >= 200 && status < 300,
    ),
  );

  static final Map<AppFontFamily, ValueNotifier<AppFontDownloadProgress?>>
  _progress = {
    for (final font in AppFontFamily.values)
      if (!font.isSystem) font: ValueNotifier<AppFontDownloadProgress?>(null),
  };
  static final Map<AppFontFamily, Future<void>> _downloads = {};
  static final Set<AppFontFamily> _loadedFonts = {};
  static bool _initialized = false;

  static Directory get _fontDirectory =>
      Directory(path.join(appSupportDirPath, PathUtils.appFontDir));

  static File _fontFile(AppFontFamily font) =>
      File(path.join(_fontDirectory.path, font.fileName!));

  static File? _fontLicenseFile(AppFontFamily font) {
    final fileName = font.downloadArchive?.licenseFileName;
    return fileName == null
        ? null
        : File(path.join(_fontDirectory.path, fileName));
  }

  static ValueListenable<AppFontDownloadProgress?> downloadProgressOf(
    AppFontFamily font,
  ) => _progress[font]!;

  static bool isDownloaded(AppFontFamily font) {
    if (font.isSystem) return true;
    try {
      final file = _fontFile(font);
      return file.existsSync() && file.lengthSync() == font.downloadSize;
    } catch (_) {
      return false;
    }
  }

  static String? fontFamilyFor(AppFontFamily font) =>
      _loadedFonts.contains(font) ? font.fontFamily : null;

  static Future<void> init() async {
    if (_initialized) return;
    _initialized = true;

    final selected = Pref.appFontFamily;
    try {
      await _fontDirectory.create(recursive: true);
      for (final font in AppFontFamily.values) {
        if (!font.isSystem) {
          _deleteFile(File('${_fontFile(font).path}.part'));
          _deleteFile(File('${_fontFile(font).path}.extract'));
          final licenseFile = _fontLicenseFile(font);
          if (licenseFile != null) {
            _deleteFile(File('${licenseFile.path}.part'));
          }
        }
      }

      if (selected.isSystem) return;
      if (!isDownloaded(selected)) {
        await GStorage.setting.delete(SettingBoxKey.appFontFamily);
        return;
      }
      await load(selected);
    } catch (error) {
      if (!selected.isSystem) {
        try {
          await GStorage.setting.delete(SettingBoxKey.appFontFamily);
        } catch (_) {}
      }
      if (kDebugMode) {
        debugPrint('App font restore failed: $error');
      }
    }
  }

  static Future<void> load(AppFontFamily font) async {
    if (font.isSystem || _loadedFonts.contains(font)) return;
    if (!isDownloaded(font)) {
      throw const AppFontDownloadException(.incompleteFile);
    }

    try {
      final bytes = await _fontFile(font).readAsBytes();
      final loader = FontLoader(font.fontFamily!)
        ..addFont(Future.value(ByteData.sublistView(bytes)));
      await loader.load();
      _loadedFonts.add(font);
    } catch (error, stackTrace) {
      _deleteFile(_fontFile(font));
      Error.throwWithStackTrace(
        const AppFontDownloadException(.loadFailed),
        stackTrace,
      );
    }
  }

  static Future<void> download(AppFontFamily font) {
    if (font.isSystem) return Future.value();
    if (isDownloaded(font)) return Future.value();

    final existing = _downloads[font];
    if (existing != null) return existing;

    late final Future<void> task;
    task = _download(font).whenComplete(() {
      if (identical(_downloads[font], task)) {
        _downloads.remove(font);
      }
    });
    _downloads[font] = task;
    return task;
  }

  static Future<void> _download(AppFontFamily font) async {
    final target = _fontFile(font);
    final temporary = File('${target.path}.part');
    final extracted = File('${target.path}.extract');
    final licenseTarget = _fontLicenseFile(font);
    final licenseTemporary = licenseTarget == null
        ? null
        : File('${licenseTarget.path}.part');
    final progress = _progress[font]!..value = (received: 0, total: -1);
    int lastPercent = -1;

    try {
      await _fontDirectory.create(recursive: true);
      _deleteFile(temporary);
      _deleteFile(extracted);
      if (licenseTemporary != null) _deleteFile(licenseTemporary);
      Object? lastError;
      StackTrace? lastStackTrace;
      for (final url in font.downloadUrls!) {
        try {
          _deleteFile(temporary);
          progress.value = (received: 0, total: -1);
          lastPercent = -1;
          final response = await _dio.download(
            url,
            temporary.path,
            deleteOnError: true,
            onReceiveProgress: (received, total) {
              final percent = total > 0 ? received * 100 ~/ total : -1;
              if (percent != lastPercent) {
                lastPercent = percent;
                progress.value = (received: received, total: total);
              }
            },
          );
          final statusCode = response.statusCode;
          if (statusCode == null || statusCode < 200 || statusCode >= 300) {
            throw AppFontDownloadException(
              .http,
              statusCode: statusCode,
            );
          }

          final downloadArchive = font.downloadArchive;
          await _verifyFile(
            temporary,
            downloadArchive?.downloadSize ?? font.downloadSize!,
            downloadArchive?.sha256 ?? font.sha256!,
          );

          File fontPayload = temporary;
          if (downloadArchive != null) {
            _deleteFile(extracted);
            if (licenseTemporary != null) _deleteFile(licenseTemporary);
            await compute(AppFontArchiveExtractor.extract, {
              'archivePath': temporary.path,
              'entryName': downloadArchive.entryName,
              'outputPath': extracted.path,
              'licenseEntryName': downloadArchive.licenseEntryName,
              'licenseOutputPath': licenseTemporary?.path,
            });
            await _verifyFile(extracted, font.downloadSize!, font.sha256!);
            fontPayload = extracted;
          }

          if (licenseTarget != null && licenseTemporary != null) {
            if (!licenseTemporary.existsSync()) {
              throw const AppFontDownloadException(.licenseExtractionFailed);
            }
            _deleteFile(licenseTarget);
            await licenseTemporary.rename(licenseTarget.path);
          }
          _deleteFile(target);
          await fontPayload.rename(target.path);
          _deleteFile(temporary);
          return;
        } catch (error, stackTrace) {
          _deleteFile(temporary);
          _deleteFile(extracted);
          if (licenseTemporary != null) _deleteFile(licenseTemporary);
          lastError = error is AppFontDownloadException
              ? error
              : _downloadException(error);
          lastStackTrace = stackTrace;
        }
      }
      Error.throwWithStackTrace(
        lastError ?? const AppFontDownloadException(.downloadFailed),
        lastStackTrace ?? StackTrace.current,
      );
    } catch (error, stackTrace) {
      _deleteFile(temporary);
      _deleteFile(extracted);
      if (licenseTemporary != null) _deleteFile(licenseTemporary);
      final exception = error is AppFontDownloadException
          ? error
          : _downloadException(error);
      Error.throwWithStackTrace(exception, stackTrace);
    } finally {
      progress.value = null;
    }
  }

  static Future<void> _verifyFile(
    File file,
    int expectedSize,
    String expectedSha256,
  ) async {
    if (await file.length() != expectedSize) {
      throw const AppFontDownloadException(.sizeMismatch);
    }
    final digest = await sha256.bind(file.openRead()).first;
    if (digest.toString() != expectedSha256) {
      throw const AppFontDownloadException(.checksumMismatch);
    }
  }

  static AppFontDownloadException _downloadException(Object error) {
    if (error is DioException) {
      final statusCode = error.response?.statusCode;
      if (statusCode != null) {
        return AppFontDownloadException(
          .http,
          statusCode: statusCode,
        );
      }
      if (error.type == DioExceptionType.connectionTimeout ||
          error.type == DioExceptionType.receiveTimeout ||
          error.type == DioExceptionType.sendTimeout) {
        return const AppFontDownloadException(.timeout);
      }
      return const AppFontDownloadException(.network);
    }
    if (error is FileSystemException) {
      return const AppFontDownloadException(.saveFailed);
    }
    return const AppFontDownloadException(.downloadFailed);
  }

  static void _deleteFile(File file) {
    try {
      if (file.existsSync()) file.deleteSync();
    } catch (_) {}
  }
}
