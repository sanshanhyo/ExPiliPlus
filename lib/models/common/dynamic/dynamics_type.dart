import 'package:ex_piliplus/l10n/generated/app_localizations.dart';

enum DynamicsTabType {
  all('全部'),
  video('投稿'),
  pgc('番剧'),
  article('专栏'),
  up('UP'),
  ;

  final String label;
  const DynamicsTabType(this.label);

  String localizedLabel(AppLocalizations l10n) => switch (this) {
    .all => l10n.feedAll,
    .video => l10n.feedUploads,
    .pgc => l10n.feedAnime,
    .article => l10n.feedArticles,
    .up => l10n.feedUploader,
  };
}
