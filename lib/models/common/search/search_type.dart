import 'package:ex_piliplus/l10n/generated/app_localizations.dart';

// ignore_for_file: constant_identifier_names
enum SearchType {
  // all('综合'),
  // 视频：video
  video,
  // 番剧：media_bangumi,
  media_bangumi,
  // 影视：media_ft
  media_ft,
  // 直播间及主播：live
  // live,
  // 直播间：live_room
  live_room,
  // 主播：live_user
  // live_user,
  // 话题：topic
  // topic,
  // 用户：bili_user
  bili_user,
  // 专栏：article
  article,
  ;

  // 相簿：photo
  // photo

  String localizedLabel(AppLocalizations l10n) => switch (this) {
    .video => l10n.commonVideos,
    .media_bangumi => l10n.navigationAnime,
    .media_ft => l10n.navigationMoviesAndTv,
    .live_room => l10n.commonLiveRooms,
    .bili_user => l10n.commonUsers,
    .article => l10n.commonArticles,
  };
}
