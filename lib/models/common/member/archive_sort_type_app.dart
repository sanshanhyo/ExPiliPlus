import 'package:ex_piliplus/l10n/generated/app_localizations.dart';
import 'package:ex_piliplus/models/common/enum_with_label.dart';

enum ArchiveSortTypeApp with EnumWithLabel {
  desc('默认'),
  asc('倒序'),
  ;

  @override
  final String label;
  const ArchiveSortTypeApp(this.label);

  String localizedLabel(AppLocalizations l10n) => switch (this) {
    .desc => l10n.commonDefault,
    .asc => l10n.memberReverseOrder,
  };
}
