import 'package:ex_piliplus/l10n/generated/app_localizations.dart';
import 'package:ex_piliplus/models/common/enum_with_label.dart';

enum ReplySortType implements EnumWithLabel {
  time('最新评论', '最新', label: '按时间'),
  hot('最热评论', '最热', label: '按热度'),
  select('精选评论', '精选'),
  ;

  @override
  final String label;
  final String desc;
  final String descShort;
  String get title => desc;
  String get text => label;
  const ReplySortType(this.desc, this.descShort, {this.label = ''});

  String localizedTitle(AppLocalizations l10n) => switch (this) {
    .time => l10n.replySortNewest,
    .hot => l10n.replySortHottest,
    .select => l10n.replySortFeatured,
  };

  String localizedLabel(AppLocalizations l10n) => switch (this) {
    .time => l10n.replySortNewestShort,
    .hot => l10n.replySortHottestShort,
    .select => l10n.replySortFeaturedShort,
  };
}
