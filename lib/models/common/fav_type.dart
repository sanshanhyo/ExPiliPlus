import 'package:ex_piliplus/l10n/generated/app_localizations.dart';
import 'package:ex_piliplus/pages/fav/article/view.dart';
import 'package:ex_piliplus/pages/fav/cheese/view.dart';
import 'package:ex_piliplus/pages/fav/note/view.dart';
import 'package:ex_piliplus/pages/fav/pgc/view.dart';
import 'package:ex_piliplus/pages/fav/topic/view.dart';
import 'package:ex_piliplus/pages/fav/video/view.dart';
import 'package:flutter/material.dart';

enum FavTabType {
  video('视频', FavVideoPage()),
  bangumi('追番', FavPgcPage(type: 1)),
  cinema('追剧', FavPgcPage(type: 2)),
  article('专栏', FavArticlePage()),
  note('笔记', FavNotePage()),
  topic('话题', FavTopicPage()),
  cheese('课堂', FavCheesePage()),
  ;

  final String title;
  final Widget page;
  const FavTabType(this.title, this.page);

  String localizedTitle(AppLocalizations l10n) => switch (this) {
    .video => l10n.favoriteTabVideos,
    .bangumi => l10n.favoriteTabAnime,
    .cinema => l10n.favoriteTabSeries,
    .article => l10n.favoriteTabArticles,
    .note => l10n.favoriteTabNotes,
    .topic => l10n.favoriteTabTopics,
    .cheese => l10n.favoriteTabCourses,
  };
}
