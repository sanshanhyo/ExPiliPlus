import 'package:ex_piliplus/l10n/generated/app_localizations.dart';

enum FollowOrderType {
  def('', '最近关注'),
  attention('attention', '最常访问'),
  ;

  final String type;
  final String title;

  const FollowOrderType(this.type, this.title);

  String localizedTitle(AppLocalizations l10n) => switch (this) {
    .def => l10n.followMostRecent,
    .attention => l10n.followMostVisited,
  };
}
