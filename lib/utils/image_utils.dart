import 'dart:async';
import 'dart:io' show File, Platform;
import 'dart:math' as math;
import 'dart:typed_data' show Uint8List;

import 'package:ex_piliplus/common/constants.dart';
import 'package:ex_piliplus/http/init.dart';
import 'package:ex_piliplus/l10n/generated/app_localizations.dart';
import 'package:ex_piliplus/utils/cache_manager.dart';
import 'package:ex_piliplus/utils/device_utils.dart';
import 'package:ex_piliplus/utils/extension/file_ext.dart';
import 'package:ex_piliplus/utils/extension/string_ext.dart';
import 'package:ex_piliplus/utils/global_data.dart';
import 'package:ex_piliplus/utils/path_utils.dart';
import 'package:ex_piliplus/utils/permission_handler.dart';
import 'package:ex_piliplus/utils/platform_utils.dart';
import 'package:ex_piliplus/utils/share_utils.dart';
import 'package:ex_piliplus/utils/storage_pref.dart';
import 'package:ex_piliplus/utils/utils.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:live_photo_maker/live_photo_maker.dart';
import 'package:saver_gallery/saver_gallery.dart';
import 'package:share_plus/share_plus.dart';

abstract final class ImageUtils {
  static AppLocalizations get _l10n => AppLocalizations.of(Get.context!);

  static bool silentDownImg = Pref.silentDownImg;
  static final _albumPath = Platform.isAndroid
      ? 'Pictures/${Constants.appName}'
      : Constants.appName;

  // 图片分享
  static Future<void> onShareImg(String url) async {
    try {
      SmartDialog.showLoading();
      final res = await CacheManager.manager.getSingleFile(
        url.http2https,
      );
      SmartDialog.dismiss();
      await SharePlus.instance.share(
        ShareParams(
          files: [XFile(res.path)],
          sharePositionOrigin: await ShareUtils.sharePositionOrigin,
        ),
      );
    } catch (e) {
      SmartDialog.showToast(e.toString());
    }
  }

  // 获取存储权限
  static Future<bool> requestPer() async {
    final status = Platform.isAndroid
        ? await Permission.storage.request()
        : await Permission.photos.request();
    if (status == PermissionStatus.denied ||
        status == PermissionStatus.permanentlyDenied) {
      SmartDialog.show(
        builder: (context) => AlertDialog(
          title: Text(_l10n.commonNotice),
          content: Text(_l10n.permissionStorageRequired),
          actions: [
            TextButton(
              onPressed: () {
                SmartDialog.dismiss();
                openAppSettings();
              },
              child: Text(_l10n.permissionOpenSettings),
            ),
          ],
        ),
      );
      return false;
    } else {
      return true;
    }
  }

  static FutureOr<bool> checkPermissionDependOnSdkInt() {
    if (Platform.isAndroid) {
      if (DeviceUtils.sdkInt < 29) {
        return requestPer();
      } else {
        return true;
      }
    }
    return requestPer();
  }

  static Future<bool> downloadLivePhoto({
    required String url,
    required String liveUrl,
    required int width,
    required int height,
  }) async {
    try {
      if (PlatformUtils.isMobile && !await checkPermissionDependOnSdkInt()) {
        return false;
      }
      if (!silentDownImg) SmartDialog.showLoading(msg: _l10n.commonDownloading);

      String videoName = "video_${Utils.getFileName(liveUrl)}";
      String videoPath = '$tmpDirPath/$videoName';

      final res = await Request().downloadFile(liveUrl.http2https, videoPath);
      if (res.statusCode != 200) throw '${res.statusCode}';

      if (Platform.isIOS) {
        final imageFile = await CacheManager.manager.getSingleFile(
          url.http2https,
        );
        if (!silentDownImg) SmartDialog.showLoading(msg: _l10n.commonSaving);
        bool success = await LivePhotoMaker.create(
          coverImage: imageFile.path,
          imagePath: null,
          voicePath: videoPath,
          width: width,
          height: height,
        ).whenComplete(File(videoPath).tryDel);
        if (success) {
          SmartDialog.showToast(_l10n.commonSaved);
        } else {
          SmartDialog.showToast(_l10n.commonSaveFailed);
          return false;
        }
      } else {
        if (!silentDownImg) SmartDialog.showLoading(msg: _l10n.commonSaving);
        await saveFileImg(
          filePath: videoPath,
          fileName: videoName,
          type: FileType.video,
          needToast: true,
        );
      }
      return true;
    } catch (err) {
      SmartDialog.showToast(err.toString());
      return false;
    } finally {
      if (!silentDownImg) SmartDialog.dismiss(status: SmartStatus.loading);
    }
  }

  static Future<bool> downloadImg(List<String> imgList) async {
    if (PlatformUtils.isMobile && !await checkPermissionDependOnSdkInt()) {
      return false;
    }
    CancelToken? cancelToken;
    if (!silentDownImg) {
      cancelToken = CancelToken();
      SmartDialog.showLoading(
        msg: _l10n.commonDownloadingOriginal,
        clickMaskDismiss: true,
        onDismiss: cancelToken.cancel,
      );
    }
    try {
      final futures = imgList.map((url) async {
        final name = Utils.getFileName(url);

        final file = await CacheManager.manager.getSingleFile(
          url.http2https,
        );
        return (filePath: file.path, name: name, statusCode: 200);
      });
      final result = await Future.wait(futures, eagerError: true);
      bool success = true;
      if (PlatformUtils.isMobile) {
        final saveList = <SaveFileData>[];
        for (final i in result) {
          if (i.statusCode == 200) {
            saveList.add(
              SaveFileData(
                filePath: i.filePath,
                fileName: i.name,
                albumPath: _albumPath,
              ),
            );
          } else {
            success = false;
          }
        }
        await SaverGallery.saveFiles(saveList, skipIfExists: false);
      } else {
        for (final res in result) {
          if (res.statusCode == 200) {
            await saveFileImg(filePath: res.filePath, fileName: res.name);
          } else {
            success = false;
          }
        }
      }
      if (cancelToken?.isCancelled == true) {
        SmartDialog.showToast(_l10n.commonDownloadCanceled);
        return false;
      } else {
        SmartDialog.showToast(
          success ? _l10n.commonSaved : _l10n.commonSaveFailed,
        );
      }
      return success;
    } catch (e) {
      if (cancelToken?.isCancelled == true) {
        SmartDialog.showToast(_l10n.commonDownloadCanceled);
      } else {
        SmartDialog.showToast(e.toString());
      }
      return false;
    } finally {
      if (!silentDownImg) SmartDialog.dismiss(status: SmartStatus.loading);
    }
  }

  static final _suffixRegex = RegExp(
    r'\.(jpg|jpeg|png|webp|gif|avif)$',
    caseSensitive: false,
  );
  static String safeThumbnailUrl(String? src) {
    if (src != null && _suffixRegex.hasMatch(src)) {
      return thumbnailUrl(src);
    }
    return src.http2https;
  }

  static final _thumbRegex = RegExp(
    r'(@(\d+[a-z]_?)*)(\..*)?$',
    caseSensitive: false,
  );
  static String thumbnailUrl(String? src, [int maxQuality = 1]) {
    if (src != null && maxQuality != 100) {
      maxQuality = math.max(maxQuality, GlobalData().imgQuality);
      bool hasMatch = false;
      src = src.splitMapJoin(
        _thumbRegex,
        onMatch: (match) {
          hasMatch = true;
          String suffix = match.group(3) ?? '.webp';
          return '${match.group(1)}_${maxQuality}q$suffix';
        },
        onNonMatch: (String str) {
          return str;
        },
      );
      if (!hasMatch) {
        src += '@${maxQuality}q.webp';
      }
    }
    return src.http2https;
  }

  static Future<SaveResult?> saveByteImg({
    required Uint8List bytes,
    required String fileName,
    String ext = 'png',
  }) async {
    SaveResult? res;
    fileName += '.$ext';
    if (PlatformUtils.isMobile) {
      SmartDialog.showLoading(msg: _l10n.commonSaving);
      res = await SaverGallery.saveImage(
        bytes,
        fileName: fileName,
        albumPath: _albumPath,
        skipIfExists: false,
      );
      SmartDialog.dismiss();
      if (res.isSuccess) {
        SmartDialog.showToast(_l10n.commonSaved);
      } else {
        SmartDialog.showToast(
          _l10n.commonSaveFailedWithError('${res.errorMessage}'),
        );
      }
    } else {
      SmartDialog.dismiss();
      final savePath = await FilePicker.saveFile(
        type: FileType.image,
        fileName: fileName,
        bytes: Uint8List(0),
      );
      if (savePath == null) {
        SmartDialog.showToast(_l10n.commonSaveCanceled);
        return null;
      }
      await File(savePath).writeAsBytes(bytes);
      SmartDialog.showToast(_l10n.commonSaved);
      res = SaveResult(true, null);
    }
    return res;
  }

  static Future<void> saveFileImg({
    required String filePath,
    required String fileName,
    FileType type = FileType.image,
    bool needToast = false,
  }) async {
    final file = File(filePath);
    if (!file.existsSync()) {
      SmartDialog.showToast(_l10n.commonFileNotFound);
      return;
    }
    SaveResult? res;
    if (PlatformUtils.isMobile) {
      res = await SaverGallery.saveFile(
        filePath: filePath,
        fileName: fileName,
        albumPath: _albumPath,
        skipIfExists: false,
      );
    } else {
      final savePath = await FilePicker.saveFile(
        type: type,
        fileName: fileName,
        bytes: Uint8List(0),
      );
      if (savePath == null) {
        SmartDialog.showToast(_l10n.commonSaveCanceled);
        return;
      }
      await file.copy(savePath);
      res = SaveResult(true, null);
    }
    if (needToast) {
      if (res.isSuccess) {
        SmartDialog.showToast(_l10n.commonSaved);
      } else {
        SmartDialog.showToast(
          _l10n.commonSaveFailedWithError('${res.errorMessage}'),
        );
      }
    }
  }
}
