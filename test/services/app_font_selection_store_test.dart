import 'package:ex_piliplus/models/common/app_font_family.dart';
import 'package:ex_piliplus/models/common/app_font_selection.dart';
import 'package:ex_piliplus/services/app_font_selection_store.dart';
import 'package:ex_piliplus/utils/storage_key.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppFontSelectionStore', () {
    test('catalog selections continue to use the existing catalog key', () {
      final entries = AppFontSelectionStore.entriesFor(
        const AppFontSelection.catalog(AppFontFamily.sourceHanSansCn),
      );

      expect(entries[SettingBoxKey.appFontSource], 'catalog');
      expect(
        entries[SettingBoxKey.appFontFamily],
        AppFontFamily.sourceHanSansCn.name,
      );
      expect(entries, isNot(contains(SettingBoxKey.appFontSystemFamily)));
    });

    test('system and local selections leave the catalog key untouched', () {
      final systemEntries = AppFontSelectionStore.entriesFor(
        const AppFontSelection.system('Noto Sans'),
      );
      final localEntries = AppFontSelectionStore.entriesFor(
        const AppFontSelection.local(
          localFileName: 'local.otf',
          localDisplayName: 'Local font',
          localFontFamily: 'ExPImportedFont_local',
        ),
      );

      expect(systemEntries[SettingBoxKey.appFontSource], 'system');
      expect(systemEntries[SettingBoxKey.appFontSystemFamily], 'Noto Sans');
      expect(systemEntries, isNot(contains(SettingBoxKey.appFontFamily)));

      expect(localEntries[SettingBoxKey.appFontSource], 'local');
      expect(localEntries[SettingBoxKey.appFontLocalFileName], 'local.otf');
      expect(localEntries, isNot(contains(SettingBoxKey.appFontFamily)));
      expect(localEntries, isNot(contains(SettingBoxKey.appFontSystemFamily)));
    });
  });
}
