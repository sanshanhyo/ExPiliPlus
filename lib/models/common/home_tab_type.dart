import 'package:ex_piliplus/models/common/enum_with_label.dart';
import 'package:ex_piliplus/l10n/generated/app_localizations.dart';
import 'package:ex_piliplus/pages/common/common_controller.dart';
import 'package:ex_piliplus/pages/hot/controller.dart';
import 'package:ex_piliplus/pages/hot/view.dart';
import 'package:ex_piliplus/pages/live/controller.dart';
import 'package:ex_piliplus/pages/live/view.dart';
import 'package:ex_piliplus/pages/pgc/controller.dart';
import 'package:ex_piliplus/pages/pgc/view.dart';
import 'package:ex_piliplus/pages/rank/controller.dart';
import 'package:ex_piliplus/pages/rank/view.dart';
import 'package:ex_piliplus/pages/rcmd/controller.dart';
import 'package:ex_piliplus/pages/rcmd/view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum HomeTabType implements EnumWithLabel {
  live('直播'),
  rcmd('推荐'),
  hot('热门'),
  rank('分区'),
  bangumi('番剧'),
  cinema('影视'),
  ;

  @override
  final String label;
  const HomeTabType(this.label);

  String localizedLabel(AppLocalizations l10n) => switch (this) {
    .live => l10n.navigationLive,
    .rcmd => l10n.navigationRecommended,
    .hot => l10n.navigationTrending,
    .rank => l10n.navigationCategories,
    .bangumi => l10n.navigationAnime,
    .cinema => l10n.navigationMoviesAndTv,
  };

  ScrollOrRefreshMixin Function() get ctr => switch (this) {
    HomeTabType.live => Get.find<LiveController>,
    HomeTabType.rcmd => Get.find<RcmdController>,
    HomeTabType.hot => Get.find<HotController>,
    HomeTabType.rank => Get.find<RankController>,
    HomeTabType.bangumi ||
    HomeTabType.cinema => () => Get.find<PgcController>(tag: name),
  };

  Widget get page => switch (this) {
    HomeTabType.live => const LivePage(),
    HomeTabType.rcmd => const RcmdPage(),
    HomeTabType.hot => const HotPage(),
    HomeTabType.rank => const RankPage(),
    HomeTabType.bangumi => const PgcPage(tabType: HomeTabType.bangumi),
    HomeTabType.cinema => const PgcPage(tabType: HomeTabType.cinema),
  };
}
