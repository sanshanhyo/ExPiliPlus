import 'package:ex_piliplus/models/common/enum_with_label.dart';
import 'package:ex_piliplus/l10n/generated/app_localizations.dart';

enum BarHideType with EnumWithLabel {
  instant('即时'),
  sync('同步'),
  ;

  @override
  final String label;
  const BarHideType(this.label);

  String localizedLabel(AppLocalizations l10n) => switch (this) {
    .instant => l10n.settingsBarCollapseInstant,
    .sync => l10n.settingsBarCollapseSynchronized,
  };
}
