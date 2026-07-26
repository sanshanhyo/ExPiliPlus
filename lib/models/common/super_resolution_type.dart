import 'package:ex_piliplus/l10n/generated/app_localizations.dart';
import 'package:ex_piliplus/models/common/enum_with_label.dart';

enum SuperResolutionType with EnumWithLabel {
  disable('禁用'),
  efficiency('效率'),
  quality('画质'),
  ;

  @override
  final String label;
  const SuperResolutionType(this.label);

  String localizedLabel(AppLocalizations l10n) => switch (this) {
    .disable => l10n.commonDisabled,
    .efficiency => l10n.playerSuperResolutionEfficiency,
    .quality => l10n.playerSuperResolutionQuality,
  };
}
