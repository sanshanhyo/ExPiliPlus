import 'package:ex_piliplus/l10n/generated/app_localizations.dart';

enum RankType {
  all(rid: 0),
  anime(seasonType: 1),
  guochuang(seasonType: 4),
  douga(rid: 1005),
  music(rid: 1003),
  dance(rid: 1004),
  game(rid: 1008),
  knowledge(rid: 1010),
  tech(rid: 1012),
  sports(rid: 1018),
  car(rid: 1013),
  food(rid: 1020),
  animal(rid: 1024),
  kichiku(rid: 1007),
  fashion(rid: 1014),
  ent(rid: 1002),
  cinephile(rid: 1001),
  documentary(seasonType: 3),
  movie(seasonType: 2),
  tv(seasonType: 5),
  variety(seasonType: 7),
  ;

  final int? rid;
  final int? seasonType;
  const RankType({this.rid, this.seasonType});

  String localizedLabel(AppLocalizations l10n) => switch (this) {
    .all => l10n.searchAllZones,
    .anime => l10n.searchZoneAnime,
    .guochuang => l10n.searchZoneChineseAnimation,
    .douga => l10n.searchZoneAnimation,
    .music => l10n.searchZoneMusic,
    .dance => l10n.searchZoneDance,
    .game => l10n.searchZoneGames,
    .knowledge => l10n.searchZoneKnowledge,
    .tech => l10n.searchZoneTechnology,
    .sports => l10n.searchZoneSports,
    .car => l10n.searchZoneCars,
    .food => l10n.searchZoneFood,
    .animal => l10n.searchZoneAnimals,
    .kichiku => l10n.searchZoneKichiku,
    .fashion => l10n.searchZoneFashion,
    .ent => l10n.searchZoneEntertainment,
    .cinephile => l10n.searchZoneFilmTv,
    .documentary => l10n.searchZoneDocumentary,
    .movie => l10n.searchZoneMovies,
    .tv => l10n.searchZoneTv,
    .variety => l10n.homeVarietyShows,
  };
}
