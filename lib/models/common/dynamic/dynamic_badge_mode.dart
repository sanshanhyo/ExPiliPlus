import 'package:ex_piliplus/l10n/generated/app_localizations.dart';

enum DynamicBadgeMode {
  hidden('隐藏'),
  point('红点'),
  number('数字'),
  ;

  final String desc;
  const DynamicBadgeMode(this.desc);

  String localizedDescription(AppLocalizations l10n) => switch (this) {
    .hidden => l10n.settingsBadgeHidden,
    .point => l10n.settingsBadgeDot,
    .number => l10n.settingsBadgeNumber,
  };
}
