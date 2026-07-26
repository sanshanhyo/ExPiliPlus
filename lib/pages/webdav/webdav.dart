import 'dart:convert';

import 'package:ex_piliplus/common/constants.dart';
import 'package:ex_piliplus/common/widgets/pair.dart';
import 'package:ex_piliplus/l10n/generated/app_localizations.dart';
import 'package:ex_piliplus/services/app_locale_controller.dart';
import 'package:ex_piliplus/utils/device_utils.dart';
import 'package:ex_piliplus/utils/storage.dart';
import 'package:ex_piliplus/utils/storage_pref.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:webdav_client/webdav_client.dart' as webdav;

class WebDav {
  AppLocalizations get _l10n => AppLocalizations.of(Get.context!);
  late String _webdavBaseDirectory;
  late String _webdavDirectory;
  String? _fileName;

  webdav.Client? _client;

  WebDav._internal();
  static final WebDav _instance = WebDav._internal();
  factory WebDav() => _instance;

  Future<Pair<bool, String?>> init() async {
    final webDavUri = Pref.webdavUri;
    final webDavUsername = Pref.webdavUsername;
    final webDavPassword = Pref.webdavPassword;
    _webdavBaseDirectory = Pref.webdavDirectory;
    if (!_webdavBaseDirectory.endsWith('/')) {
      _webdavBaseDirectory += '/';
    }
    _webdavDirectory = _getAppDirectory(Constants.appName);

    try {
      _client = null;
      final client =
          webdav.newClient(
              webDavUri,
              user: webDavUsername,
              password: webDavPassword,
            )
            ..setHeaders({'accept-charset': 'utf-8'})
            ..setConnectTimeout(12000)
            ..setReceiveTimeout(12000)
            ..setSendTimeout(12000);

      await client.mkdirAll(_webdavDirectory);

      _client = client;
      return Pair(first: true, second: null);
    } catch (e) {
      return Pair(first: false, second: e.toString());
    }
  }

  String _getFileName() {
    return 'piliplus_settings_${DeviceUtils.platformName}.json';
  }

  String _getAppDirectory(String appName) => '$_webdavBaseDirectory$appName';

  Future<void> backup() async {
    if (_client == null) {
      final res = await init();
      if (!res.first) {
        SmartDialog.showToast(
          _l10n.webDavBackupConfigurationFailed('${res.second}'),
        );
        return;
      }
    }
    try {
      String data = GStorage.exportAllSettings();
      _fileName ??= _getFileName();
      final path = '$_webdavDirectory/$_fileName';
      try {
        await _client!.remove(path);
      } catch (_) {}
      await _client!.write(path, utf8.encode(data));
      SmartDialog.showToast(_l10n.webDavBackupSucceeded);
    } catch (e) {
      SmartDialog.showToast(_l10n.webDavBackupFailed('$e'));
    }
  }

  Future<void> restore() async {
    try {
      final data = await readSettingsBackup();
      await GStorage.importAllSettings(data);
      AppLocaleController.syncFromStorage();
      SmartDialog.showToast(_l10n.webDavRestoreSucceeded);
    } catch (e) {
      SmartDialog.showToast(_l10n.webDavRestoreFailed('$e'));
    }
  }

  Future<String> readSettingsBackup({
    Iterable<String> appNames = const [Constants.appName],
  }) async {
    if (_client == null) {
      final res = await init();
      if (!res.first) {
        throw _l10n.webDavCheckConfiguration('${res.second}');
      }
    }

    _fileName ??= _getFileName();
    Object? lastError;
    final names = appNames.toSet();
    for (final appName in names) {
      final path = '${_getAppDirectory(appName)}/$_fileName';
      try {
        return utf8.decode(await _client!.read(path));
      } catch (e) {
        lastError = e;
      }
    }
    throw lastError ?? _l10n.webDavBackupNotFound;
  }
}
