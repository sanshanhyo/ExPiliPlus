import 'package:ex_piliplus/l10n/generated/app_localizations.dart';

enum AccountType {
  main('主账号'),
  heartbeat('记录观看'),
  recommend('推荐'),
  video('视频取流'),
  ;

  final String title;
  const AccountType(this.title);

  String localizedTitle(AppLocalizations l10n) => switch (this) {
    .main => l10n.settingsAccountModeMain,
    .heartbeat => l10n.settingsAccountModeWatchHistory,
    .recommend => l10n.settingsAccountModeRecommendation,
    .video => l10n.settingsAccountModeVideoStream,
  };
}
