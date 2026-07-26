import 'package:ex_piliplus/l10n/generated/app_localizations.dart';

enum UserOrderType {
  def('默认排序', 0, ''),
  fansDesc('粉丝数由高到低', 0, 'fans'),
  fansAsc('粉丝数由低到高', 1, 'fans'),
  levelDesc('Lv等级由高到低', 0, 'level'),
  levelAsc('Lv等级由低到高', 1, 'level'),
  ;

  final String label;
  final int orderSort;
  final String order;
  const UserOrderType(this.label, this.orderSort, this.order);

  String localizedLabel(AppLocalizations l10n) => switch (this) {
    .def => l10n.searchOrderDefault,
    .fansDesc => l10n.searchFollowersHighToLow,
    .fansAsc => l10n.searchFollowersLowToHigh,
    .levelDesc => l10n.searchLevelHighToLow,
    .levelAsc => l10n.searchLevelLowToHigh,
  };
}

enum UserType {
  all('全部用户'),
  up('UP主'),
  common('普通用户'),
  verified('认证用户'),
  ;

  final String label;
  const UserType(this.label);

  String localizedLabel(AppLocalizations l10n) => switch (this) {
    .all => l10n.searchAllUsers,
    .up => l10n.searchUploaders,
    .common => l10n.searchRegularUsers,
    .verified => l10n.searchVerifiedUsers,
  };
}
