import 'package:ex_piliplus/utils/storage_pref.dart';
import 'package:ex_piliplus/l10n/generated/app_localizations.dart';

enum MemberTabType {
  def('默认'),
  home('主页'),
  dynamic('动态'),
  contribute('投稿'),
  favorite('收藏'),
  bangumi('番剧'),
  cheese('课堂'),
  shop('小店'),
  ;

  static bool showMemberShop = Pref.showMemberShop;

  static bool contains(String type) {
    if (type == shop.name && !showMemberShop) {
      return false;
    }
    for (final e in MemberTabType.values) {
      if (e.name == type) {
        return true;
      }
    }
    return false;
  }

  final String title;
  const MemberTabType(this.title);

  String localizedTitle(AppLocalizations l10n) => switch (this) {
    .def => l10n.memberTabDefault,
    .home => l10n.memberTabHome,
    .dynamic => l10n.memberTabFeed,
    .contribute => l10n.memberTabUploads,
    .favorite => l10n.memberTabFavorites,
    .bangumi => l10n.memberTabAnime,
    .cheese => l10n.memberTabCourses,
    .shop => l10n.memberTabShop,
  };
}
