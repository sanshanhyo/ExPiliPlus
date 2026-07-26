import 'package:intl/intl.dart' show DateFormat;
import 'package:ex_piliplus/l10n/generated/app_localizations.dart';
import 'package:get/get.dart';

abstract final class DateFormatUtils {
  static final shortFormat = DateFormat('MM-dd');
  static final longFormat = DateFormat('yyyy-MM-dd');
  static final _shortFormatD = DateFormat('MM-dd HH:mm');
  static final longFormatD = DateFormat('yyyy-MM-dd HH:mm');
  static final longFormatDs = DateFormat('yyyy-MM-dd HH:mm:ss');

  static String dateFormat(
    int? time, {
    DateFormat? short,
    DateFormat? long,
    AppLocalizations? localizations,
  }) {
    if (time == null || time == 0) {
      return '';
    }

    final now = DateTime.now();
    final date = DateTime.fromMillisecondsSinceEpoch(time * 1000);
    final diff = now.difference(date);
    final l10n = localizations ?? AppLocalizations.of(Get.context!);

    final diffInMins = diff.inMinutes;
    if (diffInMins < 1) return l10n.timeJustNow;
    if (diffInMins < 60) return l10n.timeMinutesAgo(diffInMins);

    final diffInHours = diff.inHours;
    if (diffInHours < 24) return l10n.timeHoursAgo(diffInHours);

    final today = DateTime(now.year, now.month, now.day);
    final dateDay = DateTime(date.year, date.month, date.day);
    final dayDiff = today.difference(dateDay).inDays;
    if (dayDiff == 1) {
      return l10n.timeYesterdayAt(_clockTime(date));
    }
    if (dayDiff < 4) {
      return l10n.timeDaysAgo(dayDiff);
    }
    final DateFormat sdf = now.year == date.year
        ? short ?? shortFormat
        : long ?? longFormat;
    return sdf.format(date);
  }

  static String _twoDigits(int n) => n.toString().padLeft(2, '0');

  static String chatFormat(
    int? time, {
    bool isHistory = false,
    AppLocalizations? localizations,
  }) {
    if (time == null || time == 0) {
      return '';
    }

    final now = DateTime.now();
    final date = DateTime.fromMillisecondsSinceEpoch(time * 1000);
    final l10n = localizations ?? AppLocalizations.of(Get.context!);

    final today = DateTime(now.year, now.month, now.day);
    final dateDay = DateTime(date.year, date.month, date.day);
    if (today == dateDay) {
      final timeText = _clockTime(date);
      return isHistory ? l10n.timeTodayAt(timeText) : timeText;
    }
    final isYesterday = today.subtract(const Duration(days: 1)) == dateDay;
    if (isYesterday) {
      return l10n.timeYesterdayAt(_clockTime(date));
    }
    if (isHistory) {
      final DateFormat sdf = now.year == date.year
          ? _shortFormatD
          : longFormatD;
      return sdf.format(date);
    }
    return longFormatD.format(date);
  }

  static String format(int? time, {DateFormat? format}) {
    if (time == null || time == 0) {
      return '';
    }
    final date = DateTime.fromMillisecondsSinceEpoch(time * 1000);
    return (format ?? longFormatD).format(date);
  }

  static String _clockTime(DateTime date) =>
      '${_twoDigits(date.hour)}:${_twoDigits(date.minute)}';
}
