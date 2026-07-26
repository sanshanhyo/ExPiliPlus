import 'package:ex_piliplus/http/api.dart';
import 'package:ex_piliplus/l10n/generated/app_localizations.dart';

enum PgcReviewType {
  long(label: '长评', api: Api.pgcReviewL),
  short(label: '短评', api: Api.pgcReviewS),
  ;

  final String label;
  final String api;
  const PgcReviewType({
    required this.label,
    required this.api,
  });

  String localizedLabel(AppLocalizations l10n) => switch (this) {
    .long => l10n.reviewLong,
    .short => l10n.reviewShort,
  };
}

enum PgcReviewSortType {
  def('默认', 0),
  latest('最新', 1),
  ;

  final int sort;
  final String label;
  const PgcReviewSortType(this.label, this.sort);

  String localizedLabel(AppLocalizations l10n) => switch (this) {
    .def => l10n.commonDefault,
    .latest => l10n.reviewLatest,
  };
}
