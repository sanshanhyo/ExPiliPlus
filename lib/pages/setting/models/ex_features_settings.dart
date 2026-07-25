import 'package:ex_piliplus/models/common/app_font_family.dart';
import 'package:ex_piliplus/models/common/theme/theme_color_type.dart';
import 'package:ex_piliplus/pages/setting/models/model.dart';
import 'package:ex_piliplus/pages/setting/slide_color_picker.dart';
import 'package:ex_piliplus/pages/setting/widgets/app_font_family_dialog.dart';
import 'package:ex_piliplus/pages/setting/widgets/slider_dialog.dart';
import 'package:ex_piliplus/services/app_font_manager.dart';
import 'package:ex_piliplus/utils/extension/get_ext.dart';
import 'package:ex_piliplus/utils/storage.dart';
import 'package:ex_piliplus/utils/storage_key.dart';
import 'package:ex_piliplus/utils/storage_pref.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';

List<SettingsModel> get exFeatureSettings => [
  NormalModel(
    title: '自定义主题色',
    getSubtitle: () {
      final color = Pref.customThemeColor;
      if (color == null) {
        return '未启用，使用动态取色或 PiliPlus 预设色';
      }
      return Pref.dynamicColor
          ? '已保存 ${_colorHex(color)}，当前由动态取色覆盖'
          : '当前：${_colorHex(color)}';
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
    title: 'App字体',
    getSubtitle: () => '当前：${Pref.appFontFamily.label}',
    leading: const Icon(Icons.font_download_outlined),
    onTap: _showAppFontFamilyDialog,
  ),
  SplitModel(
    normalModel: const NormalModel.split(
      title: 'App字体字重',
      subtitle: '点击设置',
      leading: Icon(Icons.text_fields),
    ),
    switchModel: SwitchModel.split(
      defaultVal: false,
      setKey: SettingBoxKey.appFontWeight,
      onChanged: (_) => Get.updateMyAppTheme(),
      onTap: _showFontWeightDialog,
    ),
  ),
  const SwitchModel(
    title: 'UP主页显示随机播放按钮',
    leading: Icon(Icons.shuffle),
    setKey: SettingBoxKey.showRandomVideoButton,
    defaultVal: false,
  ),
  const SwitchModel(
    title: '自动点赞点开的视频',
    subtitle: '进入视频详情后自动点赞一次，已点赞的视频会跳过',
    leading: Icon(Icons.thumb_up_alt_outlined),
    setKey: SettingBoxKey.autoLikeOpenedVideo,
    defaultVal: false,
  ),
];

String _colorHex(Color color) =>
    '#${(color.toARGB32() & 0xFFFFFF).toRadixString(16).toUpperCase().padLeft(6, '0')}';

Future<void> _showCustomThemeColorDialog(
  BuildContext context,
  VoidCallback setState,
) async {
  final current = Pref.customThemeColor;
  await showDialog<void>(
    context: context,
    builder: (dialogContext) => AlertDialog(
      clipBehavior: Clip.hardEdge,
      contentPadding: const EdgeInsets.symmetric(vertical: 16),
      title: const Text('自定义主题色'),
      content: SlideColorPicker(
        color: current ?? colorThemeTypes[Pref.customColor].color,
        showResetBtn: true,
        onChanged: (color) async {
          if (color == null) {
            await GStorage.setting.delete(SettingBoxKey.customThemeColor);
            if (context.mounted) setState();
            Get.updateMyAppTheme();
            SmartDialog.showToast('已恢复 PiliPlus 主题色');
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
          SmartDialog.showToast('主题色已设为 ${_colorHex(color)}');
        },
      ),
    ),
  );
}

Future<void> _showFontWeightDialog(BuildContext context) async {
  final res = await showDialog<double>(
    context: context,
    builder: (context) => SliderDialog(
      title: const Text('App字体字重'),
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
  final current = Pref.appFontFamily;
  final res = await showDialog<AppFontFamily>(
    context: context,
    builder: (context) => AppFontFamilyDialog(value: current),
  );
  if (res != null && res != current) {
    if (!res.isSystem) {
      SmartDialog.showLoading(msg: '正在加载字体');
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
