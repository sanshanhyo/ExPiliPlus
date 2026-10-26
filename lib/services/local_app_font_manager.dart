import 'dart:io';
import 'dart:typed_data';

import 'package:ex_piliplus/models/common/app_font_selection.dart';
import 'package:ex_piliplus/utils/path_utils.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart' as path;

typedef LocalAppFontLoader = Future<void> Function(
  String family,
  Uint8List bytes,
);

enum LocalAppFontImportError { unsupportedFile, emptyFile }

final class LocalAppFontImportException implements Exception {
  const LocalAppFontImportException(this.error);

  final LocalAppFontImportError error;
}

/// Loads only files the user explicitly picks. Local files are stored apart
/// from the ExP font catalog and are never assigned catalog license metadata.
abstract final class LocalAppFontManager {
  static const allowedExtensions = {'ttf', 'ttc', 'otf'};
  static final Set<String> _loadedFamilies = {};
  static int _sequence = 0;

  static Directory get _localFontDirectory => Directory(
    path.join(appSupportDirPath, PathUtils.appFontDir, 'local'),
  );

  static bool supportsFileName(String name) =>
      allowedExtensions.contains(
        path.extension(name).replaceFirst('.', '').toLowerCase(),
      );

  /// Opens the platform picker only in response to an explicit user action.
  static Future<AppFontSelection?> pickAndImport() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: allowedExtensions.toList(growable: false),
    );
    if (result == null || result.files.isEmpty) return null;
    return importFile(result.files.first);
  }

  static Future<AppFontSelection> importFile(PlatformFile file) async {
    if (!supportsFileName(file.name)) {
      throw const LocalAppFontImportException(.unsupportedFile);
    }
    return importBytes(name: file.name, bytes: await file.readAsBytes());
  }

  @visibleForTesting
  static Future<AppFontSelection> importBytes({
    required String name,
    required Uint8List bytes,
    String? id,
    LocalAppFontLoader? loadFont,
  }) async {
    if (!supportsFileName(name)) {
      throw const LocalAppFontImportException(.unsupportedFile);
    }
    if (bytes.isEmpty) {
      throw const LocalAppFontImportException(.emptyFile);
    }

    final fileId = id ?? _newId();
    if (!RegExp(r'^[a-zA-Z0-9_-]+$').hasMatch(fileId)) {
      throw const LocalAppFontImportException(.unsupportedFile);
    }
    final extension = path.extension(name).toLowerCase();
    final fileName = '$fileId$extension';
    final family = 'ExPImportedFont_$fileId';
    final displayName = path.basenameWithoutExtension(name);
    final directory = _localFontDirectory;
    final file = File(path.join(directory.path, fileName));
    await directory.create(recursive: true);
    await file.writeAsBytes(bytes, flush: true);
    try {
      await (loadFont ?? _loadFont)(family, bytes);
      _loadedFamilies.add(family);
    } catch (_) {
      if (await file.exists()) await file.delete();
      rethrow;
    }

    return AppFontSelection.local(
      localFileName: fileName,
      localDisplayName: displayName,
      localFontFamily: family,
    );
  }

  static Future<bool> loadSelection(AppFontSelection selection) async {
    if (!selection.isLocal ||
        selection.localFileName == null ||
        selection.localFontFamily == null ||
        path.basename(selection.localFileName!) != selection.localFileName) {
      return false;
    }
    final family = selection.localFontFamily!;
    if (_loadedFamilies.contains(family)) return true;

    final file = File(
      path.join(_localFontDirectory.path, selection.localFileName!),
    );
    if (!await file.exists()) return false;
    try {
      await _loadFont(family, await file.readAsBytes());
      _loadedFamilies.add(family);
      return true;
    } catch (error) {
      debugPrint('Could not load selected local app font: $error');
      return false;
    }
  }

  static String? fontFamilyFor(AppFontSelection selection) {
    final family = selection.localFontFamily;
    return selection.isLocal &&
            family != null &&
            _loadedFamilies.contains(family)
        ? family
        : null;
  }

  static String _newId() =>
      '${DateTime.now().microsecondsSinceEpoch}_${_sequence++}';

  static Future<void> _loadFont(String family, Uint8List bytes) async {
    final loader = FontLoader(family)
      ..addFont(Future.value(ByteData.sublistView(bytes)));
    await loader.load();
  }
}
