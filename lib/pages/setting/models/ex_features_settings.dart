import 'package:ex_piliplus/models/common/app_font_family.dart';
import 'package:ex_piliplus/models/common/app_language.dart';
import 'package:ex_piliplus/models/common/theme/theme_color_type.dart';
import 'package:ex_piliplus/pages/setting/models/model.dart';
import 'package:ex_piliplus/pages/setting/slide_color_picker.dart';
import 'package:ex_piliplus/pages/setting/widgets/app_font_family_dialog.dart';
import 'package:ex_piliplus/pages/setting/widgets/select_dialog.dart';
import 'package:ex_piliplus/pages/setting/widgets/slider_dialog.dart';
import 'package:ex_piliplus/services/app_locale_controller.dart';
import 'package:ex_piliplus/services/app_font_manager.dart';
import 'package:ex_piliplus/utils/extension/get_ext.dart';
import 'package:ex_piliplus/utils/extension/l10n_ext.dart';
import 'package:ex_piliplus/utils/storage.dart';
import 'package:ex_piliplus/utils/storage_key.dart';
import 'package:ex_piliplus/utils/storage_pref.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';

List<SettingsModel> exFeatureSettings(BuildContext context) {
  final l10n = context.l10n;
  return [
    NormalModel(
      getTitle: () => l10n.settingsAppLanguage,
      getSubtitle: () => l10n.settingsCurrentLanguage(
        Pref.appLanguage.localizedName(l10n),
      ),
      leading: const Icon(Icons.language_outlined),
      onTap: _showAppLanguageDialog,
    ),
    NormalModel(
      getTitle: () => l10n.settingsCustomThemeColor,
      getSubtitle: () {
        final color = Pref.customThemeColor;
        if (color == null) {
          return l10n.settingsCustomThemeColorDisabled;
        }
        return Pref.dynamicColor
            ? l10n.settingsCustomThemeColorSavedOverridden(_colorHex(color))
            : l10n.settingsCurrentValue(_colorHex(color));
      },
      getTrailing: (theme) {
        final color = Pref.customThemeColor;
        return color == null
            ? const Icon(Icons.colorize_outlined)
            : Container(
                width: 22,
                height: 22,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                  border: Border.all(color: theme.colorScheme.outline),
                ),
              );
      },
      leading: const Icon(Icons.palette_outlined),
      onTap: _showCustomThemeColorDialog,
    ),
    NormalModel(
      getTitle: () => l10n.settingsAppFont,
      getSubtitle: () => l10n.settingsCurrentValue(Pref.appFontFamily.label),
      leading: const Icon(Icons.font_download_outlined),
      onTap: _showAppFontFamilyDialog,
    ),
    SplitModel(
      normalModel: NormalModel.split(
        getTitle: () => l10n.settingsAppFontWeight,
        getSubtitle: () => l10n.settingsTapToConfigure,
        leading: const Icon(Icons.text_fields),
      ),
      switchModel: SwitchModel.split(
        defaultVal: false,
        setKey: SettingBoxKey.appFontWeight,
        onChanged: (_) => Get.updateMyAppTheme(),
        onTap: _showFontWeightDialog,
      ),
    ),
    SwitchModel(
      getTitle: () => l10n.settingsUploaderProfileShuffle,
      leading: const Icon(Icons.shuffle),
      setKey: SettingBoxKey.showRandomVideoButton,
      defaultVal: false,
    ),
    SwitchModel(
      getTitle: () => l10n.settingsAutoLikeOpenedVideos,
      getSubtitle: () => l10n.settingsAutoLikeOpenedVideosDescription,
      leading: const Icon(Icons.thumb_up_alt_outlined),
      setKey: SettingBoxKey.autoLikeOpenedVideo,
      defaultVal: false,
    ),
  ];
}

String _colorHex(Color color) =>
    '#${(color.toARGB32() & 0xFFFFFF).toRadixString(16).toUpperCase().padLeft(6, '0')}';

Future<void> _showAppLanguageDialog(
  BuildContext context,
  VoidCallback setState,
) async {
  final l10n = context.l10n;
  final current = Pref.appLanguage;
  final selected = await showDialog<AppLanguage>(
    context: context,
    builder: (context) => SelectDialog<AppLanguage>(
      value: current,
      title: l10n.languagePickerTitle,
      values: AppLanguage.values
          .map((language) => (language, language.localizedName(l10n)))
          .toList(growable: false),
    ),
  );
  if (selected == null || selected == current) return;
  await AppLocaleController.setLanguage(selected);
  if (context.mounted) setState();
}

Future<void> _showCustomThemeColorDialog(
  BuildContext context,
  VoidCallback setState,
) async {
  final l10n = context.l10n;
  final current = Pref.customThemeColor;
  await showDialog<void>(
    context: context,
    builder: (dialogContext) => AlertDialog(
      clipBehavior: Clip.hardEdge,
      contentPadding: const EdgeInsets.symmetric(vertical: 16),
      title: Text(l10n.settingsCustomThemeColor),
      content: SlideColorPicker(
        color: current ?? colorThemeTypes[Pref.customColor].color,
        showResetBtn: true,
        onChanged: (color) async {
          if (color == null) {
            await GStorage.setting.delete(SettingBoxKey.customThemeColor);
            if (context.mounted) setState();
            Get.updateMyAppTheme();
            SmartDialog.showToast(l10n.settingsPiliPlusThemeRestored);
            return;
          }
          await Future.wait([
            GStorage.setting.put(
              SettingBoxKey.customThemeColor,
              color.toARGB32(),
            ),
            GStorage.setting.put(SettingBoxKey.dynamicColor, false),
          ]);
          if (context.mounted) setState();
          Get.updateMyAppTheme();
          SmartDialog.showToast(
            l10n.settingsThemeColorSet(_colorHex(color)),
          );
        },
      ),
    ),
  );
}

Future<void> _showFontWeightDialog(BuildContext context) async {
  final res = await showDialog<double>(
    context: context,
    builder: (context) => SliderDialog(
      title: Text(context.l10n.settingsAppFontWeight),
      value: Pref.appFontWeight.toDouble() + 1,
      min: 1,
      max: FontWeight.values.length.toDouble(),
      divisions: FontWeight.values.length - 1,
    ),
  );
  if (res != null) {
    await GStorage.setting.put(SettingBoxKey.appFontWeight, res.toInt() - 1);
    Get.updateMyAppTheme();
  }
}

Future<void> _showAppFontFamilyDialog(
  BuildContext context,
  VoidCallback setState,
) async {
  final l10n = context.l10n;
  final current = Pref.appFontFamily;
  final res = await showDialog<AppFontFamily>(
    context: context,
    builder: (context) => AppFontFamilyDialog(value: current),
  );
  if (res != null && res != current) {
    if (!res.isSystem) {
      SmartDialog.showLoading(msg: l10n.settingsLoadingFont);
      try {
        await AppFontManager.load(res);
      } catch (error) {
        SmartDialog.showToast(error.toString());
        return;
      } finally {
        SmartDialog.dismiss(status: SmartStatus.loading);
      }
    }
    await GStorage.setting.put(SettingBoxKey.appFontFamily, res.name);
    if (context.mounted) setState();
    Get.updateMyAppTheme();
  }
}
