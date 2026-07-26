import 'package:ex_piliplus/l10n/generated/app_localizations.dart';

enum EpisodeType {
  part,
  season,
  pgc,
  ;

  String localizedTitle(AppLocalizations l10n) => switch (this) {
    .part => l10n.videoParts,
    .season => l10n.subscriptionCollection,
    .pgc => l10n.playerEpisodes,
  };
}
