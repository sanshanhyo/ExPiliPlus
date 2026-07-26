import 'package:ex_piliplus/l10n/generated/app_localizations.dart';

enum BtmProgressBehavior {
  alwaysShow('始终展示'),
  alwaysHide('始终隐藏'),
  onlyShowFullScreen('仅全屏时展示'),
  onlyHideFullScreen('仅全屏时隐藏'),
  ;

  final String desc;
  const BtmProgressBehavior(this.desc);

  String localizedDescription(AppLocalizations l10n) => switch (this) {
    .alwaysShow => l10n.settingsProgressAlwaysShow,
    .alwaysHide => l10n.settingsProgressAlwaysHide,
    .onlyShowFullScreen => l10n.settingsProgressFullscreenOnly,
    .onlyHideFullScreen => l10n.settingsProgressHideFullscreen,
  };
}
