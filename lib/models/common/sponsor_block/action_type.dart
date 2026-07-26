import 'package:ex_piliplus/l10n/generated/app_localizations.dart';

enum ActionType {
  skip('跳过'),
  mute('静音'),
  full('整个视频'),
  poi('精彩时刻'),
  ;

  final String title;
  const ActionType(this.title);

  String localizedTitle(AppLocalizations l10n) => switch (this) {
    .skip => l10n.sponsorBlockActionSkip,
    .mute => l10n.sponsorBlockActionMute,
    .full => l10n.sponsorBlockActionFullVideo,
    .poi => l10n.sponsorBlockActionHighlight,
  };
}
