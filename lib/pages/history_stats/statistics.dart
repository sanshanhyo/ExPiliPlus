import 'package:ex_piliplus/models_new/history/list.dart';

enum HistoryStatisticsRange {
  sevenDays(7),
  thirtyDays(30),
  ninetyDays(90);

  const HistoryStatisticsRange(this.days);

  final int days;

  DateTime startOfPeriod(DateTime now) {
    final today = DateTime(now.year, now.month, now.day);
    return today.subtract(Duration(days: days - 1));
  }
}

enum HistoryStatisticsContentType {
  video,
  pgc,
  live,
  article,
  course,
  other;

  static HistoryStatisticsContentType fromBusiness(String? business) {
    return switch (business) {
      'pgc' => pgc,
      'live' => live,
      'article' || 'article-list' => article,
      'cheese' => course,
      'archive' || null || '' => video,
      _ => other,
    };
  }
}

class HistoryUploaderStatistics {
  const HistoryUploaderStatistics({
    required this.name,
    required this.mid,
    required this.contentCount,
    required this.completedCount,
  });

  final String name;
  final int? mid;
  final int contentCount;
  final int completedCount;
}

class HistoryStatistics {
  const HistoryStatistics({
    required this.range,
    required this.periodStart,
    required this.periodEnd,
    required this.items,
    required this.totalContentCount,
    required this.completedCount,
    required this.unfinishedCount,
    required this.activeDayCount,
    required this.favoritedCount,
    required this.remainingSeconds,
    required this.contentTypeCounts,
    required this.hourBucketCounts,
    required this.activityByDay,
    required this.topUploaders,
    required this.unfinishedItems,
    required this.isPartial,
  });

  final HistoryStatisticsRange range;
  final DateTime periodStart;
  final DateTime periodEnd;
  final List<HistoryItemModel> items;
  final int totalContentCount;
  final int completedCount;
  final int unfinishedCount;
  final int activeDayCount;
  final int favoritedCount;
  final int remainingSeconds;
  final Map<HistoryStatisticsContentType, int> contentTypeCounts;

  /// Six four-hour buckets beginning at midnight.
  final List<int> hourBucketCounts;
  final Map<DateTime, int> activityByDay;
  final List<HistoryUploaderStatistics> topUploaders;
  final List<HistoryItemModel> unfinishedItems;
  final bool isPartial;
}

abstract final class HistoryStatisticsCalculator {
  static HistoryStatistics calculate({
    required Iterable<HistoryItemModel> source,
    required HistoryStatisticsRange range,
    required DateTime now,
    bool isPartial = false,
  }) {
    final periodStart = range.startOfPeriod(now);
    final periodEnd = now;
    final uniqueItems = <String, HistoryItemModel>{};

    for (final item in source) {
      final viewAt = item.viewAt;
      if (viewAt == null) continue;
      final viewedAt = DateTime.fromMillisecondsSinceEpoch(viewAt * 1000);
      if (viewedAt.isBefore(periodStart) || viewedAt.isAfter(periodEnd)) {
        continue;
      }
      uniqueItems.putIfAbsent(_contentKey(item), () => item);
    }

    final items = uniqueItems.values.toList()
      ..sort((a, b) => (b.viewAt ?? 0).compareTo(a.viewAt ?? 0));
    final typeCounts = {
      for (final type in HistoryStatisticsContentType.values) type: 0,
    };
    final hourBuckets = List<int>.filled(6, 0);
    final activityByDay = <DateTime, int>{};
    final uploaderBuilders = <String, _UploaderStatisticsBuilder>{};
    final unfinishedItems = <HistoryItemModel>[];

    var completedCount = 0;
    var favoritedCount = 0;
    var remainingSeconds = 0;

    for (final item in items) {
      final completed = item.progress == -1;
      if (completed) completedCount++;
      if (item.isFav == 1) favoritedCount++;

      final type = HistoryStatisticsContentType.fromBusiness(
        item.history.business,
      );
      typeCounts[type] = typeCounts[type]! + 1;

      final viewedAt = DateTime.fromMillisecondsSinceEpoch(
        item.viewAt! * 1000,
      );
      hourBuckets[viewedAt.hour ~/ 4]++;
      final day = DateTime(viewedAt.year, viewedAt.month, viewedAt.day);
      activityByDay.update(day, (value) => value + 1, ifAbsent: () => 1);

      final authorName = item.authorName?.trim();
      if (authorName?.isNotEmpty == true) {
        final uploaderKey = item.authorMid?.toString() ?? authorName!;
        final builder = uploaderBuilders.putIfAbsent(
          uploaderKey,
          () => _UploaderStatisticsBuilder(
            name: authorName!,
            mid: item.authorMid,
          ),
        );
        builder.contentCount++;
        if (completed) builder.completedCount++;
      }

      final progress = item.progress;
      final duration = item.duration;
      if (!completed &&
          progress != null &&
          progress > 0 &&
          duration != null &&
          duration > progress) {
        unfinishedItems.add(item);
        remainingSeconds += duration - progress;
      }
    }

    final topUploaders =
        uploaderBuilders.values
            .map(
              (item) => HistoryUploaderStatistics(
                name: item.name,
                mid: item.mid,
                contentCount: item.contentCount,
                completedCount: item.completedCount,
              ),
            )
            .toList()
          ..sort((a, b) {
            final countCompare = b.contentCount.compareTo(a.contentCount);
            return countCompare != 0 ? countCompare : a.name.compareTo(b.name);
          });

    return HistoryStatistics(
      range: range,
      periodStart: periodStart,
      periodEnd: periodEnd,
      items: List.unmodifiable(items),
      totalContentCount: items.length,
      completedCount: completedCount,
      unfinishedCount: unfinishedItems.length,
      activeDayCount: activityByDay.length,
      favoritedCount: favoritedCount,
      remainingSeconds: remainingSeconds,
      contentTypeCounts: Map.unmodifiable(typeCounts),
      hourBucketCounts: List.unmodifiable(hourBuckets),
      activityByDay: Map.unmodifiable(activityByDay),
      topUploaders: List.unmodifiable(topUploaders),
      unfinishedItems: List.unmodifiable(unfinishedItems),
      isPartial: isPartial,
    );
  }

  static String _contentKey(HistoryItemModel item) {
    final history = item.history;
    final contentId = history.business == 'pgc'
        ? history.epid ?? history.oid
        : history.bvid ?? history.oid ?? item.kid;
    if (contentId == null) {
      return '${history.business ?? 'archive'}:${item.title}:${item.viewAt}';
    }
    return '${history.business ?? 'archive'}:$contentId';
  }
}

class _UploaderStatisticsBuilder {
  _UploaderStatisticsBuilder({required this.name, required this.mid});

  final String name;
  final int? mid;
  int contentCount = 0;
  int completedCount = 0;
}
