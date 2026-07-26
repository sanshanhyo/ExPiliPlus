import 'package:ex_piliplus/l10n/generated/app_localizations.dart';
import 'package:ex_piliplus/models/common/enum_with_label.dart';

enum ArchiveOrderTypeApp with EnumWithLabel {
  pubdate('最新发布'),
  click('最多播放'),
  ;

  @override
  final String label;
  const ArchiveOrderTypeApp(this.label);

  String localizedLabel(AppLocalizations l10n) => switch (this) {
    .pubdate => l10n.commonNewestPublished,
    .click => l10n.commonMostViewed,
  };
}
