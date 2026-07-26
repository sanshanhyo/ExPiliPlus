import 'package:ex_piliplus/l10n/generated/app_localizations.dart';

enum UpPanelPosition {
  top('顶部'),
  leftFixed('左侧常驻'),
  rightFixed('右侧常驻'),
  leftDrawer('左侧抽屉'),
  rightDrawer('右侧抽屉'),
  ;

  final String label;
  const UpPanelPosition(this.label);

  String localizedLabel(AppLocalizations l10n) => switch (this) {
    .top => l10n.settingsUpPositionTop,
    .leftFixed => l10n.settingsUpPositionLeftFixed,
    .rightFixed => l10n.settingsUpPositionRightFixed,
    .leftDrawer => l10n.settingsUpPositionLeftDrawer,
    .rightDrawer => l10n.settingsUpPositionRightDrawer,
  };
}
