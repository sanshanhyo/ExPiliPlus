import 'package:ex_piliplus/models/common/app_font_family.dart';
import 'package:ex_piliplus/pages/setting/models/model.dart';
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
];

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
