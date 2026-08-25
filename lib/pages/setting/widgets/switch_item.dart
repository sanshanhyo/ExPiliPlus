import 'package:ex_piliplus/common/widgets/dialog/dialog.dart';
import 'package:ex_piliplus/common/widgets/flutter/list_tile.dart';
import 'package:ex_piliplus/utils/storage.dart';
import 'package:ex_piliplus/utils/storage_key.dart';
import 'package:ex_piliplus/utils/storage_pref.dart';
import 'package:ex_piliplus/utils/extension/l10n_ext.dart';
import 'package:flutter/material.dart' hide ListTile;
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

class SetSwitchItem extends StatefulWidget {
  final String title;
  final String? subtitle;
  final String setKey;
  final bool defaultVal;
  final ValueChanged<bool>? onChanged;
  final bool needReboot;
  final Widget? leading;
  final void Function(BuildContext context)? onTap;
  final bool enabled;
  final Future<bool> Function()? onDisabledTap;
  final EdgeInsetsGeometry? contentPadding;
  final TextStyle? titleStyle;
  final bool isSplit;

  const SetSwitchItem({
    super.key,
    required this.title,
    this.subtitle,
    required this.setKey,
    this.defaultVal = false,
    this.onChanged,
    this.needReboot = false,
    this.leading,
    this.onTap,
    this.enabled = true,
    this.onDisabledTap,
    this.contentPadding,
    this.titleStyle,
    this.isSplit = false,
  });

  @override
  State<SetSwitchItem> createState() => _SetSwitchItemState();
}

class _SetSwitchItemState extends State<SetSwitchItem> {
  late bool val;

  void setVal() {
    if (widget.setKey == SettingBoxKey.appFontWeight) {
      val = Pref.appFontWeight != -1;
    } else {
      val = GStorage.setting.get(
        widget.setKey,
        defaultValue: widget.defaultVal,
      );
    }
  }

  @override
  void didUpdateWidget(SetSwitchItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.setKey != widget.setKey) {
      setVal();
    }
  }

  @override
  void initState() {
    super.initState();
    setVal();
  }

  Future<void> switchChange([bool? value]) async {
    val = value ?? !val;

    if (widget.setKey == SettingBoxKey.badCertificateCallback && val) {
      val = await showConfirmDialog(
        context: context,
        title: Text(context.l10n.settingsDisableSslVerification),
        content: Text(context.l10n.settingsDisableSslVerificationDescription),
      );
    }

    if (widget.setKey == SettingBoxKey.appFontWeight) {
      await GStorage.setting.put(SettingBoxKey.appFontWeight, val ? 4 : -1);
    } else {
      await GStorage.setting.put(widget.setKey, val);
    }

    widget.onChanged?.call(val);
    if (widget.needReboot) {
      SmartDialog.showToast(context.l10n.settingsRestartRequired);
    }
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> disabledTap() async {
    final enabled = await widget.onDisabledTap?.call() ?? false;
    if (!mounted || !enabled) return;
    await switchChange(true);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final titleStyle =
        widget.titleStyle ??
        theme.textTheme.titleMedium!.copyWith(
          color: !widget.enabled || widget.onTap != null && !val
              ? theme.colorScheme.outline
              : null,
        );
    final subTitleStyle = theme.textTheme.labelMedium!.copyWith(
      color: theme.colorScheme.outline,
    );
    final leading = widget.enabled || widget.leading == null
        ? widget.leading
        : IconTheme.merge(
            data: IconThemeData(color: theme.colorScheme.outline),
            child: widget.leading!,
          );

    final switchBtn = Transform.scale(
      scale: 0.8,
      alignment: .centerRight,
      child: Switch(
        value: val,
        onChanged: widget.enabled
            ? switchChange
            : (_) {
                disabledTap();
              },
        thumbColor: widget.enabled
            ? null
            : WidgetStatePropertyAll(theme.colorScheme.outline),
        trackColor: widget.enabled
            ? null
            : WidgetStatePropertyAll(theme.colorScheme.outlineVariant),
      ),
    );

    Widget child(Widget? trailing) => ListTile(
      contentPadding: widget.contentPadding,
      enabled: widget.enabled || widget.onDisabledTap != null,
      onTap: !widget.enabled && widget.onDisabledTap != null
          ? disabledTap
          : widget.onTap == null
          ? switchChange
          : () => widget.onTap!(context),
      title: Text(widget.title, style: titleStyle),
      subtitle: widget.subtitle != null
          ? Text(
              widget.subtitle!,
              style: !widget.enabled
                  ? subTitleStyle.copyWith(color: theme.colorScheme.outline)
                  : subTitleStyle,
            )
          : null,
      leading: leading,
      trailing: trailing,
    );

    if (widget.isSplit) {
      return Row(
        children: [
          Expanded(child: child(null)),
          SizedBox(
            height: 25,
            child: VerticalDivider(
              width: 1,
              color: theme.colorScheme.outline.withValues(alpha: .3),
            ),
          ),
          Padding(
            padding: const .only(left: 4, right: 24),
            child: switchBtn,
          ),
        ],
      );
    }

    return child(switchBtn);
  }
}
