// ignore_for_file: constant_identifier_names

import 'package:ex_piliplus/l10n/generated/app_localizations.dart';

enum LiveContributionRankType {
  online_rank('contribution_rank'),
  daily_rank('today_rank'),
  weekly_rank('current_week_rank'),
  monthly_rank('current_month_rank'),
  ;

  final String sw1tch;
  const LiveContributionRankType(this.sw1tch);

  String localizedTitle(AppLocalizations l10n) => switch (this) {
    .online_rank => l10n.liveContributionRankOnline,
    .daily_rank => l10n.liveContributionRankDaily,
    .weekly_rank => l10n.liveContributionRankWeekly,
    .monthly_rank => l10n.liveContributionRankMonthly,
  };
}
