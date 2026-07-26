import 'package:ex_piliplus/l10n/generated/app_localizations.dart';

enum FavOrderType {
  mtime,
  view,
  pubtime,
  ;

  String localizedLabel(AppLocalizations l10n) => switch (this) {
    .mtime => l10n.favoriteOrderRecentlyAdded,
    .view => l10n.favoriteOrderMostPlayed,
    .pubtime => l10n.favoriteOrderRecentlyPublished,
  };
}
