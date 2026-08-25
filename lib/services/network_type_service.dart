import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:ex_piliplus/utils/permission_handler.dart';
import 'package:ex_piliplus/utils/platform_utils.dart';
import 'package:ex_piliplus/utils/storage.dart';
import 'package:ex_piliplus/utils/storage_key.dart';
import 'package:ex_piliplus/utils/storage_pref.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

enum NetworkType { wifi, fourG, fiveG, unknown }

abstract final class NetworkTypeService {
  static const _channel = MethodChannel(
    'io.github.sanshanhyo.expiliplus/network_type',
  );
  static final Rx<NetworkType> current = NetworkType.unknown.obs;
  static final RxBool phonePermissionGranted = (!Platform.isAndroid).obs;
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
      await refreshPhonePermission();
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

  static Future<bool> refreshPhonePermission() async {
    if (!Platform.isAndroid) {
      phonePermissionGranted.value = true;
      return true;
    }
    final granted = await Permission.phone.isGranted;
    phonePermissionGranted.value = granted;
    if (!granted && Pref.showNetworkType) {
      await GStorage.setting.put(SettingBoxKey.showNetworkType, false);
    }
    return granted;
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
    if (Platform.isAndroid) await refreshPhonePermission();
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

  static Future<bool> requestPhonePermission() async {
    if (!Platform.isAndroid) return true;
    if (await Permission.phone.isPermanentlyDenied) {
      await openAppSettings();
      await refreshPhonePermission();
      return phonePermissionGranted.value;
    }
    final status = await Permission.phone.request();
    phonePermissionGranted.value = status.isGranted;
    if (!status.isGranted) {
      await GStorage.setting.put(SettingBoxKey.showNetworkType, false);
      if (status.isPermanentlyDenied) await openAppSettings();
      return false;
    }
    await _startNativeListener();
    await refresh();
    return true;
  }

  static Future<void> setEnabled(bool value) async {
    if (value) {
      if (Platform.isAndroid && !await requestPhonePermission()) {
        return;
      }
      await GStorage.setting.put(SettingBoxKey.showNetworkType, true);
      await refresh();
    } else {
      await GStorage.setting.put(SettingBoxKey.showNetworkType, false);
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
