import 'package:ex_piliplus/l10n/generated/app_localizations.dart';
import 'package:ex_piliplus/utils/num_utils.dart';

class UserInfo {
  final int viewCount;
  final double minutesSaved;
  final int segmentCount;

  const UserInfo({
    required this.viewCount,
    required this.minutesSaved,
    required this.segmentCount,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
    viewCount: json['viewCount'],
    minutesSaved: (json['minutesSaved'] as num).toDouble(),
    segmentCount: json['segmentCount'],
  );

  String localizedSummary(AppLocalizations l10n) =>
      l10n.sponsorBlockUserInformation(
        NumUtils.formatPositiveDecimal(segmentCount),
        NumUtils.formatPositiveDecimal(viewCount),
        NumUtils.formatPositiveDecimal(minutesSaved.round()),
      );
}
