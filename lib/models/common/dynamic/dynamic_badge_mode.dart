import 'package:ex_piliplus/l10n/generated/app_localizations.dart';
import 'package:ex_piliplus/models/common/enum_with_label.dart';

enum DynamicBadgeMode implements EnumWithLabel {
  hidden('隐藏'),
  point('红点'),
  number('数字'),
  ;

  @override
  final String label;
  const DynamicBadgeMode(this.label);

  String localizedDescription(AppLocalizations l10n) => switch (this) {
    .hidden => l10n.settingsBadgeHidden,
    .point => l10n.settingsBadgeDot,
    .number => l10n.settingsBadgeNumber,
  };
}
