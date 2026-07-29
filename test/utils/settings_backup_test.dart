import 'dart:io';

import 'package:ex_piliplus/utils/settings_backup.dart';
import 'package:ex_piliplus/utils/set_int_adapter.dart';
import 'package:ex_piliplus/utils/storage.dart';
import 'package:ex_piliplus/utils/storage_key.dart';
import 'package:ex_piliplus/utils/storage_pref.dart';
import 'package:ex_piliplus/models/common/app_language.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_ce/hive.dart';

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

  test('blocked dynamic authors survive reopening local storage', () async {
    final tempDir = Directory.systemTemp.createTempSync(
      'dynamic-author-filter-test-',
    );
    Hive.init(tempDir.path);
    if (!Hive.isAdapterRegistered(11)) {
      Hive.registerAdapter(SetIntAdapter());
    }
    var localCache = await Hive.openBox<dynamic>('localCache');
    final setting = await Hive.openBox<dynamic>('setting');
    GStorage.localCache = localCache;
    GStorage.setting = setting;

    try {
      expect(Pref.enablePermanentDynamicBlock, isFalse);

      await Pref.setDynamicAuthorPermanentlyBlocked(
        1001,
        true,
        name: 'First uploader',
      );
      await Pref.setDynamicAuthorPermanentlyBlocked(
        1002,
        true,
        name: 'Second uploader',
        face: 'https://example.com/avatar.jpg',
      );
      await Pref.setDynamicAuthorPermanentlyBlocked(1001, false);

      expect(Pref.dynamicBannedMids, {1002});
      expect(Pref.dynamicBannedUps.single.name, 'Second uploader');
      expect(
        Pref.dynamicBannedUps.single.face,
        'https://example.com/avatar.jpg',
      );

      await localCache.close();
      localCache = await Hive.openBox<dynamic>('localCache');

      expect(
        Set<int>.from(localCache.get(LocalCacheKey.dynamicBannedMids) as Set),
        {1002},
      );
      expect(
        (localCache.get(LocalCacheKey.dynamicBannedUpList) as List).single,
        containsPair('name', 'Second uploader'),
      );
    } finally {
      await localCache.close();
      await setting.close();
      await tempDir.delete(recursive: true);
    }
  });
}
