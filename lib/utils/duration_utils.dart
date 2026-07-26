import 'dart:math' show pow;

import 'package:ex_piliplus/l10n/generated/app_localizations.dart';

abstract final class DurationUtils {
  static String formatDuration(num? seconds) {
    if (seconds == null || seconds == 0) {
      return '00:00';
    }
    int h = seconds ~/ 3600;
    seconds %= 3600;
    int m = seconds ~/ 60;
    seconds %= 60;
    String sms = seconds is double
        ? seconds.toStringAsFixed(3).padLeft(6, '0')
        : seconds.toString().padLeft(2, '0');
    return h == 0
        ? "${m.toString().padLeft(2, '0')}:$sms"
        : "${h.toString().padLeft(2, '0')}:${m.toString().padLeft(2, '0')}:$sms";
  }

  static final _splitRegex = RegExp(r'[:：]');
  static int parseDuration(String? data) {
    if (data == null || data.isEmpty) {
      return 0;
    }
    List<int> split = data.split(_splitRegex).reversed.map(int.parse).toList();
    int duration = 0;
    for (int i = 0; i < split.length; i++) {
      duration += split[i] * pow(60, i).toInt();
    }
    return duration;
  }

  static String formatDurationBetween(
    int startMillis,
    int endMillis,
    AppLocalizations l10n,
  ) => formatTimeDuration(
    Duration(milliseconds: endMillis - startMillis),
    l10n,
  );

  static String formatTimeDuration(
    Duration duration,
    AppLocalizations l10n,
  ) {
    final inDays = duration.inDays;
    final daysLeft = inDays % 365;
    final years = inDays ~/ 365;
    final months = daysLeft ~/ 30;
    final days = daysLeft % 30;
    final hours = duration.inHours % 24;
    final minutes = duration.inMinutes % 60;

    final format = StringBuffer();

    if (years > 0) format.write(l10n.durationYears(years));
    if (months > 0) format.write(l10n.durationMonths(months));
    if (days > 0) format.write(l10n.durationDays(days));
    if (hours > 0) format.write(l10n.durationHours(hours));
    if (minutes > 0) format.write(l10n.durationMinutes(minutes));

    return format.toString();
  }
}
