import 'package:ex_piliplus/models/common/app_font_selection.dart';
import 'package:ex_piliplus/utils/storage.dart';
import 'package:ex_piliplus/utils/storage_key.dart';
import 'package:flutter/foundation.dart' show visibleForTesting;

abstract final class AppFontSelectionStore {
  @visibleForTesting
  static Map<String, Object> entriesFor(AppFontSelection selection) =>
      switch (selection.source) {
        .catalog => {
          SettingBoxKey.appFontSource: selection.source.name,
          SettingBoxKey.appFontFamily: selection.catalogFont.name,
        },
        .system => {
          SettingBoxKey.appFontSource: selection.source.name,
          SettingBoxKey.appFontSystemFamily: selection.systemFamily ?? '',
        },
        .local => {
          SettingBoxKey.appFontSource: selection.source.name,
          SettingBoxKey.appFontLocalFileName: selection.localFileName ?? '',
          SettingBoxKey.appFontLocalDisplayName:
              selection.localDisplayName ?? '',
          SettingBoxKey.appFontLocalFamily: selection.localFontFamily ?? '',
        },
      };

  static Future<void> save(AppFontSelection selection) =>
      GStorage.setting.putAll(entriesFor(selection));
}
