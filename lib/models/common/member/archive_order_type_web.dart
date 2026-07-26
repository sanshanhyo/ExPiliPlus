import 'package:ex_piliplus/l10n/generated/app_localizations.dart';
import 'package:ex_piliplus/models/common/enum_with_label.dart';

enum ArchiveOrderTypeWeb with EnumWithLabel {
  pubdate('最新发布'),
  click('最多播放'),
  stow('最多收藏'),
  ;

  @override
  final String label;
  const ArchiveOrderTypeWeb(this.label);

  String localizedLabel(AppLocalizations l10n) => switch (this) {
    .pubdate => l10n.favoriteOrderRecentlyPublished,
    .click => l10n.memberOrderMostPlayed,
    .stow => l10n.memberOrderMostFavorited,
  };
}
