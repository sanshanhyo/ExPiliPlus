import 'package:ex_piliplus/common/style.dart';
import 'package:ex_piliplus/models/common/enum_with_label.dart';
import 'package:ex_piliplus/pages/setting/widgets/normal_item.dart';
import 'package:ex_piliplus/pages/setting/widgets/popup_item.dart';
import 'package:ex_piliplus/pages/setting/widgets/select_dialog.dart';
import 'package:ex_piliplus/pages/setting/widgets/switch_item.dart';
import 'package:ex_piliplus/utils/storage.dart';
import 'package:ex_piliplus/utils/extension/l10n_ext.dart';
import 'package:flutter/material.dart' hide PopupMenuItemSelected;
import 'package:flutter/services.dart' show FilteringTextInputFormatter;
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';

@immutable
sealed class SettingsModel {
  final String? subtitle;
  final Widget? leading;
  final EdgeInsetsGeometry? contentPadding;
  final TextStyle? titleStyle;

  String? get title;
  Widget get widget;
  String get effectiveTitle;
  String? get effectiveSubtitle;

  const SettingsModel({
    this.subtitle,
    this.leading,
    this.contentPadding,
    this.titleStyle,
  });
}

class SplitModel extends SettingsModel {
  const SplitModel({
    super.contentPadding,
    super.titleStyle,
    required this.normalModel,
    required this.switchModel,
  });

  @override
  String? get effectiveSubtitle => normalModel.effectiveSubtitle;

  @override
  String get effectiveTitle => normalModel.effectiveTitle;

  @override
  String? get title => normalModel.title;

  final NormalModel normalModel;

  final SwitchModel switchModel;

  @override
  Widget get widget => SetSwitchItem(
    title: effectiveTitle,
    subtitle: effectiveSubtitle,
    setKey: switchModel.setKey,
    defaultVal: switchModel.defaultVal,
    onChanged: switchModel.onChanged,
    needReboot: switchModel.needReboot,
    leading: normalModel.leading,
    onTap: switchModel.onTap,
    contentPadding: contentPadding,
    titleStyle: titleStyle,
    isSplit: true,
  );
}

class PopupModel<T extends EnumWithLabel> extends SettingsModel {
  const PopupModel({
    required this.title,
    super.leading,
    super.contentPadding,
    super.titleStyle,
    required this.value,
    required this.items,
    required this.onSelected,
    this.labelBuilder,
  });

  @override
  String? get effectiveSubtitle => null;

  @override
  String get effectiveTitle => title;

  @override
  final String title;

  final ValueGetter<T> value;
  final List<T> items;
  final PopupMenuItemSelected<T> onSelected;
  final String Function(T value)? labelBuilder;

  @override
  Widget get widget => PopupListTile<T>(
    safeArea: false,
    leading: leading,
    title: Text(title),
    value: () {
      final v = value();
      return (v, labelBuilder?.call(v) ?? v.label);
    },
    itemBuilder: (_) => items
        .map(
          (item) => PopupMenuItem(
            value: item,
            child: Text(labelBuilder?.call(item) ?? item.label),
          ),
        )
        .toList(),
    onSelected: onSelected,
  );
}

class NormalModel extends SettingsModel {
  @override
  final String? title;
  final ValueGetter<String>? getTitle;
  final ValueGetter<String>? getSubtitle;
  final Widget Function(ThemeData theme)? getTrailing;
  final void Function(BuildContext context, VoidCallback setState)? onTap;

  const NormalModel({
    super.subtitle,
    super.leading,
    super.contentPadding,
    super.titleStyle,
    this.title,
    this.getTitle,
    this.getSubtitle,
    this.getTrailing,
    this.onTap,
  }) : assert(title != null || getTitle != null);

  const NormalModel.split({
    super.subtitle,
    super.leading,
    super.contentPadding,
    super.titleStyle,
    this.title,
    this.getTitle,
    this.getSubtitle,
    this.getTrailing,
  }) : onTap = null,
       assert(title != null || getTitle != null);

  @override
  String get effectiveTitle => title ?? getTitle!();
  @override
  String? get effectiveSubtitle => subtitle ?? getSubtitle?.call();

  @override
  Widget get widget => NormalItem(
    title: title,
    getTitle: getTitle,
    subtitle: subtitle,
    getSubtitle: getSubtitle,
    leading: leading,
    getTrailing: getTrailing,
    onTap: onTap,
    contentPadding: contentPadding,
    titleStyle: titleStyle,
  );
}

class SwitchModel extends SettingsModel {
  @override
  final String? title;
  final ValueGetter<String>? getTitle;
  final ValueGetter<String>? getSubtitle;
  final String setKey;
  final bool defaultVal;
  final ValueChanged<bool>? onChanged;
  final bool needReboot;
  final void Function(BuildContext context)? onTap;
  final ValueGetter<bool>? isEnabled;
  final Future<bool> Function()? onDisabledTap;

  const SwitchModel({
    super.subtitle,
    super.leading,
    super.contentPadding,
    super.titleStyle,
    this.title,
    this.getTitle,
    this.getSubtitle,
    required this.setKey,
    this.defaultVal = false,
    this.onChanged,
    this.needReboot = false,
    this.onTap,
    this.isEnabled,
    this.onDisabledTap,
  }) : assert(title != null || getTitle != null);

  const SwitchModel.split({
    required this.setKey,
    this.defaultVal = false,
    this.needReboot = false,
    this.onChanged,
    this.onTap,
    this.isEnabled,
    this.onDisabledTap,
  }) : title = null,
       getTitle = null,
       getSubtitle = null;

  @override
  String get effectiveTitle => title ?? getTitle!();
  @override
  String? get effectiveSubtitle => subtitle ?? getSubtitle?.call();

  @override
  Widget get widget {
    SetSwitchItem build(bool enabled) => SetSwitchItem(
      title: effectiveTitle,
      subtitle: effectiveSubtitle,
      setKey: setKey,
      defaultVal: defaultVal,
      onChanged: onChanged,
      needReboot: needReboot,
      leading: leading,
      onTap: onTap,
      enabled: enabled,
      onDisabledTap: onDisabledTap,
      contentPadding: contentPadding,
      titleStyle: titleStyle,
    );

    final getEnabled = isEnabled;
    return getEnabled == null ? build(true) : Obx(() => build(getEnabled()));
  }
}

SettingsModel getBanWordModel({
  required BuildContext context,
  required String title,
  required String key,
  required ValueChanged<RegExp> onChanged,
}) {
  String banWord = GStorage.setting.get(key, defaultValue: '');
  return NormalModel(
    leading: const Icon(Icons.filter_alt_outlined),
    title: title,
    getSubtitle: () =>
        banWord.isEmpty ? context.l10n.settingsTapToAdd : banWord,
    onTap: (context, setState) {
      String editValue = banWord;
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          constraints: Style.dialogFixedConstraints,
          title: Text(title),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(context.l10n.settingsKeywordSeparatorHelp),
              TextFormField(
                autofocus: true,
                initialValue: editValue,
                textInputAction: TextInputAction.newline,
                minLines: 1,
                maxLines: 4,
                onChanged: (value) => editValue = value,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: Get.back,
              child: Text(
                context.l10n.commonCancel,
                style: TextStyle(color: ColorScheme.of(context).outline),
              ),
            ),
            TextButton(
              child: Text(context.l10n.commonConfirm),
              onPressed: () {
                Get.back();
                banWord = editValue;
                setState();
                onChanged(RegExp(banWord, caseSensitive: false));
                SmartDialog.showToast(context.l10n.settingsSaved);
                GStorage.setting.put(key, banWord);
              },
            ),
          ],
        ),
      );
    },
  );
}

SettingsModel getVideoFilterSelectModel({
  required BuildContext context,
  required String title,
  String? subtitle,
  String? suffix,
  required String key,
  required List<int> values,
  int defaultValue = 0,
  bool isFilter = true,
  ValueChanged<int>? onChanged,
}) {
  assert(!isFilter || onChanged != null);
  int value = GStorage.setting.get(key, defaultValue: defaultValue);
  return NormalModel(
    title: isFilter ? context.l10n.settingsFilterTitle(title) : title,
    leading: const Icon(Icons.timelapse_outlined),
    subtitle: subtitle,
    getSubtitle: subtitle == null
        ? () => isFilter
              ? context.l10n.settingsFilterBelow(
                  title,
                  value,
                  suffix ?? '',
                )
              : context.l10n.settingsCurrentNamedValue(
                  title,
                  value,
                  suffix ?? '',
                )
        : null,
    onTap: (context, setState) async {
      var result = await showDialog<int>(
        context: context,
        builder: (context) => SelectDialog<int>(
          title: context.l10n.settingsChooseFilterValue(
            title,
            isFilter ? context.l10n.settingsZeroDisablesFilter : '',
          ),
          value: value,
          values:
              (values
                    ..addIf(!values.contains(value), value)
                    ..sort())
                  .map((e) => (e, suffix == null ? e.toString() : '$e $suffix'))
                  .toList()
                ..add((-1, context.l10n.settingsCustomValue)),
        ),
      );
      if (result != null) {
        if (result == -1 && context.mounted) {
          String valueStr = '';
          await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(context.l10n.settingsCustomNamedValue(title)),
              content: TextField(
                autofocus: true,
                onChanged: (value) => valueStr = value,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: InputDecoration(suffixText: suffix),
              ),
              actions: [
                TextButton(
                  onPressed: Get.back,
                  child: Text(
                    context.l10n.commonCancel,
                    style: TextStyle(color: ColorScheme.of(context).outline),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    try {
                      result = int.parse(valueStr);
                      Get.back();
                    } catch (e) {
                      SmartDialog.showToast(e.toString());
                    }
                  },
                  child: Text(context.l10n.commonConfirm),
                ),
              ],
            ),
          );
        }
        if (result != -1) {
          value = result!;
          setState();
          onChanged?.call(value);
          GStorage.setting.put(key, value);
        }
      }
    },
  );
}
