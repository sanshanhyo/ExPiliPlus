import 'package:ex_piliplus/models/common/app_language.dart';
import 'package:ex_piliplus/utils/storage_key.dart';

abstract final class SettingsBackup {
  static const int defaultThemeColorIndex = 0;

  /// Keeps the custom theme color field in every new backup.
  ///
  /// `null` means that the user is using dynamic color or a PiliPlus preset.
  static Map<String, dynamic> prepareForExport(Map<dynamic, dynamic> source) {
    return _stringKeyed(source)
      ..putIfAbsent(
        SettingBoxKey.appLanguage,
        () => AppLanguage.simplifiedChinese.storageValue,
      )
      ..putIfAbsent(SettingBoxKey.customThemeColor, () => null);
  }

  /// Makes backups created before custom theme colors deterministic.
  ///
  /// A missing or invalid custom color falls back to the original green preset,
  /// rather than inheriting the color currently stored on the device.
  static Map<String, dynamic> prepareForImport(Map<dynamic, dynamic> source) {
    final result = _stringKeyed(source);
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

  static Map<String, dynamic> _stringKeyed(Map<dynamic, dynamic> source) {
    return source.map(
      (key, value) => MapEntry(key.toString(), value),
    );
  }
}
