import 'package:ex_piliplus/l10n/generated/app_localizations.dart';
import 'package:ex_piliplus/models/common/enum_with_label.dart';

enum SkipType implements EnumWithLabel {
  alwaysSkip('总是跳过'),
  skipOnce('跳过一次'),
  skipManually('手动跳过'),
  showOnly('仅显示'),
  disable('禁用'),
  ;

  @override
  final String label;
  const SkipType(this.label);

  String localizedLabel(AppLocalizations l10n) => switch (this) {
    .alwaysSkip => l10n.sponsorBlockAlwaysSkip,
    .skipOnce => l10n.sponsorBlockSkipOnce,
    .skipManually => l10n.sponsorBlockManualSkip,
    .showOnly => l10n.sponsorBlockShowOnly,
    .disable => l10n.commonDisabled,
  };
}
