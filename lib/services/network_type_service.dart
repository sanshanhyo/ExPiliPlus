import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:ex_piliplus/utils/permission_handler.dart';
import 'package:ex_piliplus/utils/platform_utils.dart';
import 'package:ex_piliplus/utils/storage.dart';
import 'package:ex_piliplus/utils/storage_key.dart';
import 'package:ex_piliplus/utils/storage_pref.dart';
import 'package:ex_piliplus/utils/extension/l10n_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

enum NetworkType { wifi, fourG, fiveG, unknown }

abstract final class NetworkTypeService {
  static const _channel = MethodChannel(
    'io.github.sanshanhyo.expiliplus/network_type',
  );
  static const _permissionPromptVersion = 1;
  static final Rx<NetworkType> current = NetworkType.unknown.obs;
  static StreamSubscription<List<ConnectivityResult>>?
  _connectivitySubscription;
  static bool _started = false;

  static NetworkType fromCellularName(String? value) => switch (value) {
    '4G' => NetworkType.fourG,
    '5G' => NetworkType.fiveG,
    _ => NetworkType.unknown,
  };

  static String label(NetworkType value) => switch (value) {
    NetworkType.wifi => 'Wi‑Fi',
    NetworkType.fourG => '4G',
    NetworkType.fiveG => '5G',
    NetworkType.unknown => '未知',
  };

  static Future<void> start() async {
    if (!PlatformUtils.isMobile || _started) return;
    _started = true;
    _connectivitySubscription = Connectivity().onConnectivityChanged.listen(
      (_) => refresh(),
      onError: (_, __) => current.value = NetworkType.unknown,
    );
    if (Platform.isAndroid) {
      try {
        await _channel.invokeMethod<void>('startCellularNetworkListener');
      } on MissingPluginException {
        // The desktop and test implementations do not expose the channel.
      } on PlatformException {
        // A missing phone permission is represented as Unknown below.
      }
    }
    await refresh();
  }

  static Future<void> stop() async {
    await _connectivitySubscription?.cancel();
    _connectivitySubscription = null;
    _started = false;
  }

  static Future<void> refresh() async {
    if (!PlatformUtils.isMobile) {
      current.value = NetworkType.unknown;
      return;
    }
    try {
      final results = await Connectivity().checkConnectivity();
      if (results.contains(ConnectivityResult.wifi)) {
        current.value = NetworkType.wifi;
      } else if (results.contains(ConnectivityResult.mobile)) {
        current.value = await _cellularType();
      } else {
        current.value = NetworkType.unknown;
      }
    } catch (_) {
      current.value = NetworkType.unknown;
    }
  }

  static Future<NetworkType> _cellularType() async {
    if (Platform.isAndroid && !(await Permission.phone.isGranted)) {
      return NetworkType.unknown;
    }
    try {
      final result = await _channel.invokeMethod<String>(
        'getCellularNetworkType',
      );
      return fromCellularName(result);
    } on MissingPluginException {
      return NetworkType.unknown;
    } on PlatformException {
      return NetworkType.unknown;
    }
  }

  static Future<void> preparePermission(BuildContext context) async {
    if (!Platform.isAndroid || !Pref.showNetworkType) return;
    if (GStorage.setting.get(
          SettingBoxKey.networkTypePermissionPromptVersion,
        ) ==
        _permissionPromptVersion) {
      return;
    }
    await GStorage.setting.put(
      SettingBoxKey.networkTypePermissionPromptVersion,
      _permissionPromptVersion,
    );
    if (await Permission.phone.isGranted) {
      await _startNativeListener();
      await refresh();
      return;
    }
    if (!context.mounted) return;
    final shouldRequest =
        await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(context.l10n.settingsFullscreenNetworkType),
            content: Text(
              context.l10n.settingsFullscreenNetworkTypeDescription,
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text(context.l10n.commonCancel),
              ),
              FilledButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text(context.l10n.commonConfirm),
              ),
            ],
          ),
        ) ??
        false;
    if (!shouldRequest) {
      await setEnabled(false);
      return;
    }
    final status = await Permission.phone.request();
    if (!status.isGranted) {
      await setEnabled(false);
    }
    await _startNativeListener();
    await refresh();
  }

  static Future<void> setEnabled(bool value) async {
    await GStorage.setting.put(SettingBoxKey.showNetworkType, value);
    if (value) {
      if (Platform.isAndroid) {
        if (await Permission.phone.isPermanentlyDenied) {
          await openAppSettings();
          return;
        }
        final status = await Permission.phone.request();
        if (!status.isGranted) {
          await GStorage.setting.put(SettingBoxKey.showNetworkType, false);
          if (status.isPermanentlyDenied) await openAppSettings();
          return;
        }
        await _startNativeListener();
      }
      await refresh();
    } else {
      current.value = NetworkType.unknown;
    }
  }

  static Future<void> _startNativeListener() async {
    if (!Platform.isAndroid) return;
    try {
      await _channel.invokeMethod<void>('startCellularNetworkListener');
    } on MissingPluginException {
      // The desktop and test implementations do not expose the channel.
    } on PlatformException {
      // A missing phone permission is represented as Unknown below.
    }
  }
}
