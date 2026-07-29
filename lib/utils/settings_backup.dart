import 'package:ex_piliplus/models/common/app_language.dart';
import 'package:ex_piliplus/utils/storage_key.dart';

abstract final class SettingsBackup {
  static const int defaultThemeColorIndex = 0;
  static const String exPiliPlusSection = 'ExPiliplus';

  static const _exPiliPlusSettingKeys = {
    SettingBoxKey.appLanguage,
    SettingBoxKey.enablePermanentDynamicBlock,
    SettingBoxKey.customThemeColor,
    SettingBoxKey.showRandomVideoButton,
    SettingBoxKey.autoLikeOpenedVideo,
  };

  /// Keeps the custom theme color field in every new backup.
  ///
  /// `null` means that the user is using dynamic color or a PiliPlus preset.
  static Map<String, dynamic> prepareForExport(Map<dynamic, dynamic> source) {
    return _stringKeyed(source)
      ..putIfAbsent(
        SettingBoxKey.appLanguage,
        () => AppLanguage.simplifiedChinese.storageValue,
      )
      ..putIfAbsent(SettingBoxKey.customThemeColor, () => null)
      ..putIfAbsent(SettingBoxKey.enablePermanentDynamicBlock, () => false)
      ..putIfAbsent(SettingBoxKey.showRandomVideoButton, () => false)
      ..putIfAbsent(SettingBoxKey.autoLikeOpenedVideo, () => false);
  }

  static Map<String, dynamic> prepareExPiliPlusForExport(
    Map<dynamic, dynamic> settingSource,
    Map<dynamic, dynamic> localCacheSource,
  ) {
    final setting = prepareForExport(settingSource);
    final localCache = _stringKeyed(localCacheSource);
    return {
      for (final key in _exPiliPlusSettingKeys) key: setting[key],
      LocalCacheKey.dynamicBannedMids: _intList(
        localCache[LocalCacheKey.dynamicBannedMids],
      ),
      LocalCacheKey.dynamicBannedUpList: _dynamicBannedUpList(
        localCache[LocalCacheKey.dynamicBannedUpList],
      ),
    };
  }

  /// Makes backups created before custom theme colors deterministic.
  ///
  /// A missing or invalid custom color falls back to the original green preset,
  /// rather than inheriting the color currently stored on the device.
  static Map<String, dynamic> prepareForImport(
    Map<dynamic, dynamic> source, {
    Map<dynamic, dynamic>? exPiliPlus,
  }) {
    final result = _stringKeyed(source);
    if (exPiliPlus != null) {
      final exPiliPlusSetting = _stringKeyed(exPiliPlus);
      for (final key in _exPiliPlusSettingKeys) {
        if (exPiliPlusSetting.containsKey(key)) {
          result[key] = exPiliPlusSetting[key];
        }
      }
    }
    result[SettingBoxKey.appLanguage] = AppLanguage.fromStorage(
      result[SettingBoxKey.appLanguage],
    ).storageValue;

    final hasCustomThemeColor = result.containsKey(
      SettingBoxKey.customThemeColor,
    );
    final customThemeColor = result[SettingBoxKey.customThemeColor];
    final isValidCustomThemeColor =
        customThemeColor == null ||
        (customThemeColor is int &&
            customThemeColor >= 0 &&
            customThemeColor <= 0xFFFFFFFF);

    if (!hasCustomThemeColor || !isValidCustomThemeColor) {
      result
        ..remove(SettingBoxKey.customThemeColor)
        ..[SettingBoxKey.customColor] = defaultThemeColorIndex
        ..[SettingBoxKey.dynamicColor] = false;
    } else if (customThemeColor == null) {
      // The nullable marker only distinguishes new JSON backups from old ones.
      result.remove(SettingBoxKey.customThemeColor);
    }
    return result;
  }

  static Map<String, dynamic> prepareExPiliPlusLocalCacheForImport(
    Map<dynamic, dynamic> source,
  ) {
    final exPiliPlus = _stringKeyed(source);
    return {
      LocalCacheKey.dynamicBannedMids: _intList(
        exPiliPlus[LocalCacheKey.dynamicBannedMids],
      ).toSet(),
      LocalCacheKey.dynamicBannedUpList: _dynamicBannedUpList(
        exPiliPlus[LocalCacheKey.dynamicBannedUpList],
      ),
    };
  }

  static List<int> _intList(Object? source) {
    if (source is! Iterable) return const [];
    final result = source.whereType<int>().toSet().toList()..sort();
    return result;
  }

  static List<Map<String, Object?>> _dynamicBannedUpList(Object? source) {
    if (source is! Iterable) return const [];
    final result = <Map<String, Object?>>[];
    for (final item in source) {
      if (item is! Map || item['mid'] is! int) continue;
      result.add({
        'mid': item['mid'] as int,
        'name': item['name'] is String ? item['name'] as String : '',
        'face': item['face'] is String ? item['face'] as String : null,
      });
    }
    return result;
  }

  static Map<String, dynamic> _stringKeyed(Map<dynamic, dynamic> source) {
    return source.map(
      (key, value) => MapEntry(key.toString(), value),
    );
  }
}
