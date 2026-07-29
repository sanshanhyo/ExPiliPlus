import 'dart:io' show Platform;

import 'package:ex_piliplus/build_config.dart';
import 'package:ex_piliplus/common/constants.dart';
import 'package:ex_piliplus/http/api.dart';
import 'package:ex_piliplus/http/browser_ua.dart';
import 'package:ex_piliplus/http/init.dart';
import 'package:ex_piliplus/utils/accounts/account.dart';
import 'package:ex_piliplus/utils/extension/l10n_ext.dart';
import 'package:ex_piliplus/utils/page_utils.dart';
import 'package:ex_piliplus/utils/storage.dart';
import 'package:ex_piliplus/utils/storage_key.dart';
import 'package:ex_piliplus/utils/update_policy.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';

abstract final class Update {
  // 检查更新
  static Future<void> checkUpdate([bool isAuto = true]) async {
    if (kDebugMode) return;
    final l10n = Get.context!.l10n;
    try {
      final res = await Request().get(
        Api.latestApp,
        queryParameters: const {'per_page': 100},
        options: Options(
          headers: {'user-agent': BrowserUa.mob},
          extra: {'account': const NoAccount()},
        ),
      );
      if (res.data is! List || res.data.isEmpty) {
        if (!isAuto) {
          SmartDialog.showToast(l10n.updateCheckFailed);
        }
        return;
      }
      final decision = UpdatePolicy.evaluate(
        currentVersion: BuildConfig.versionName,
        isReleaseBuild: BuildConfig.releaseBuild,
        releases: res.data,
      );
      switch (decision.type) {
        case UpdateDecisionType.selfCompiled:
          if (!isAuto) {
            SmartDialog.showToast(l10n.updateSelfCompiled);
          }
          return;
        case UpdateDecisionType.upToDate:
          if (!isAuto) {
            SmartDialog.showToast(l10n.updateAlreadyLatest);
          }
          return;
        case UpdateDecisionType.updateAvailable:
          break;
      }
      final data = decision.release!;
      SmartDialog.show(
        animationType: SmartAnimationType.centerFade_otherSlide,
        builder: (context) {
          final colorScheme = ColorScheme.of(context);
          Widget downloadBtn(String text, {String? ext}) => TextButton(
            onPressed: () => onDownload(data, ext: ext),
            child: Text(text),
          );
          return AlertDialog(
            title: Text(l10n.updateNewVersion),
            content: SizedBox(
              height: 280,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${data['tag_name']}',
                      style: const TextStyle(fontSize: 20),
                    ),
                    const SizedBox(height: 8),
                    Text('${data['body']}'),
                    TextButton(
                      onPressed: () => PageUtils.launchURL(
                        '${Constants.sourceCodeUrl}/commits/main',
                      ),
                      child: Text(
                        l10n.updateViewFullChanges,
                        style: TextStyle(color: colorScheme.primary),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              if (isAuto)
                TextButton(
                  onPressed: () {
                    SmartDialog.dismiss();
                    GStorage.setting.put(SettingBoxKey.autoUpdate, false);
                  },
                  child: Text(
                    l10n.updateStopReminding,
                    style: TextStyle(color: colorScheme.outline),
                  ),
                ),
              TextButton(
                onPressed: SmartDialog.dismiss,
                child: Text(
                  l10n.commonCancel,
                  style: TextStyle(color: colorScheme.outline),
                ),
              ),
              if (Platform.isWindows) ...[
                downloadBtn('zip', ext: 'zip'),
                downloadBtn('exe', ext: 'exe'),
              ] else if (Platform.isLinux) ...[
                downloadBtn('rpm', ext: 'rpm'),
                downloadBtn('deb', ext: 'deb'),
                downloadBtn('targz', ext: 'tar.gz'),
              ] else
                downloadBtn('Github'),
            ],
          );
        },
      );
    } catch (e) {
      if (kDebugMode) debugPrint('failed to check update: $e');
      if (!isAuto) {
        SmartDialog.showToast(l10n.updateCheckFailed);
      }
    }
  }

  // 下载适用于当前系统的安装包
  static Future<void> onDownload(Map data, {String? ext}) async {
    SmartDialog.dismiss();
    try {
      void download(String plat) {
        if (data['assets'].isNotEmpty) {
          for (Map<String, dynamic> i in data['assets']) {
            final String name = i['name'];
            if (name.contains(plat) &&
                (ext == null || ext.isEmpty ? true : name.endsWith(ext))) {
              PageUtils.launchURL(i['browser_download_url']);
              return;
            }
          }
          throw UnsupportedError('platform not found: $plat');
        }
      }

      if (Platform.isAndroid) {
        // 获取设备信息
        AndroidDeviceInfo androidInfo = await DeviceInfoPlugin().androidInfo;
        // [arm64-v8a]
        download(androidInfo.supportedAbis.first);
      } else {
        download(Platform.operatingSystem);
      }
    } catch (e) {
      if (kDebugMode) debugPrint('download error: $e');
      PageUtils.launchURL('${Constants.sourceCodeUrl}/releases/latest');
    }
  }
}
