import 'package:ex_piliplus/l10n/generated/app_localizations.dart';

enum ArticleOrderType {
  totalrank('综合排序'),
  pubdate('最新发布'),
  click('最多点击'),
  attention('最多喜欢'),
  scores('最多评论'),
  ;

  String get order => name;
  final String label;
  const ArticleOrderType(this.label);

  String localizedLabel(AppLocalizations l10n) => switch (this) {
    .totalrank => l10n.searchOrderRelevance,
    .pubdate => l10n.searchOrderNewest,
    .click => l10n.searchOrderMostClicked,
    .attention => l10n.searchOrderMostLiked,
    .scores => l10n.searchOrderMostCommented,
  };
}

enum ArticleZoneType {
  all('全部分区', 0),
  douga('动画', 2),
  game('游戏', 1),
  cinephile('影视', 28),
  life('生活', 3),
  interest('兴趣', 29),
  novel('轻小说', 16),
  tech('科技', 17),
  note('笔记', 41),
  ;

  final String label;
  final int categoryId;
  const ArticleZoneType(this.label, this.categoryId);

  String localizedLabel(AppLocalizations l10n) => switch (this) {
    .all => l10n.searchAllZones,
    .douga => l10n.searchZoneAnimation,
    .game => l10n.searchZoneGames,
    .cinephile => l10n.searchZoneFilmTv,
    .life => l10n.searchZoneLife,
    .interest => l10n.searchZoneInterests,
    .novel => l10n.searchZoneLightNovels,
    .tech => l10n.searchZoneTechnology,
    .note => l10n.searchZoneNotes,
  };
}
