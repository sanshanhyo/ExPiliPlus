import 'package:ex_piliplus/utils/settings_backup.dart';
import 'package:ex_piliplus/utils/storage_key.dart';
import 'package:ex_piliplus/models/common/app_language.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('SettingsBackup', () {
    test('always exports the custom theme color field', () {
      final result = SettingsBackup.prepareForExport({
        SettingBoxKey.customColor: 12,
      });

      expect(result, contains(SettingBoxKey.customThemeColor));
      expect(result[SettingBoxKey.customThemeColor], isNull);
      expect(result[SettingBoxKey.customColor], 12);
      expect(
        result[SettingBoxKey.appLanguage],
        AppLanguage.simplifiedChinese.storageValue,
      );
    });

    test('preserves an enabled custom theme color', () {
      const color = 0xFF123456;
      final result = SettingsBackup.prepareForExport({
        SettingBoxKey.customThemeColor: color,
      });

      expect(result[SettingBoxKey.customThemeColor], color);
    });

    test('old backups without the field fall back to default green', () {
      final result = SettingsBackup.prepareForImport({
        SettingBoxKey.customColor: 12,
        SettingBoxKey.dynamicColor: true,
      });

      expect(
        result[SettingBoxKey.customColor],
        SettingsBackup.defaultThemeColorIndex,
      );
      expect(result[SettingBoxKey.dynamicColor], isFalse);
      expect(result, isNot(contains(SettingBoxKey.customThemeColor)));
    });

    test('new backups with a null field preserve the selected preset', () {
      final result = SettingsBackup.prepareForImport({
        SettingBoxKey.customThemeColor: null,
        SettingBoxKey.customColor: 12,
        SettingBoxKey.dynamicColor: false,
      });

      expect(result[SettingBoxKey.customColor], 12);
      expect(result[SettingBoxKey.dynamicColor], isFalse);
      expect(result, isNot(contains(SettingBoxKey.customThemeColor)));
    });

    test('restores a valid custom theme color', () {
      const color = 0xFFABCDEF;
      final result = SettingsBackup.prepareForImport({
        SettingBoxKey.customThemeColor: color,
        SettingBoxKey.dynamicColor: false,
      });

      expect(result[SettingBoxKey.customThemeColor], color);
      expect(result[SettingBoxKey.dynamicColor], isFalse);
    });

    test(
      'preserves language and defaults old backups to simplified Chinese',
      () {
        final english = SettingsBackup.prepareForImport({
          SettingBoxKey.appLanguage: AppLanguage.english.storageValue,
          SettingBoxKey.customThemeColor: null,
        });
        final legacy = SettingsBackup.prepareForImport({
          SettingBoxKey.customThemeColor: null,
        });

        expect(
          english[SettingBoxKey.appLanguage],
          AppLanguage.english.storageValue,
        );
        expect(
          legacy[SettingBoxKey.appLanguage],
          AppLanguage.simplifiedChinese.storageValue,
        );
      },
    );
  });
}
