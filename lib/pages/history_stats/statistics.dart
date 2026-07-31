import 'package:ex_piliplus/models_new/history/list.dart';

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
    this.avatarUrl,
  });

  final String name;
  final int? mid;
  final int contentCount;
  final int completedCount;
  final String? avatarUrl;

  HistoryUploaderStatistics copyWith({String? avatarUrl}) {
    return HistoryUploaderStatistics(
      name: name,
      mid: mid,
      contentCount: contentCount,
      completedCount: completedCount,
      avatarUrl: avatarUrl ?? this.avatarUrl,
    );
  }
}

class HistoryStatistics {
  const HistoryStatistics({
    required this.periodStart,
    required this.periodEnd,
    required this.sourceRecordCount,
    required this.reachedRecordLimit,
    required this.items,
    required this.totalContentCount,
    required this.completedCount,
    required this.activeDayCount,
    required this.favoritedCount,
    required this.remainingSeconds,
    required this.contentTypeCounts,
    required this.hourlyCounts,
    required this.activityByDay,
    required this.topUploaders,
    required this.continueWatchingItems,
    required this.isPartial,
  });

  static const recordLimit = 1200;

  final DateTime periodStart;
  final DateTime periodEnd;
  final int sourceRecordCount;
  final bool reachedRecordLimit;
  final List<HistoryItemModel> items;
  final int totalContentCount;
  final int completedCount;
  final int activeDayCount;
  final int favoritedCount;
  final int remainingSeconds;
  final Map<HistoryStatisticsContentType, int> contentTypeCounts;
  final List<int> hourlyCounts;
  final Map<DateTime, int> activityByDay;
  final List<HistoryUploaderStatistics> topUploaders;
  final List<HistoryItemModel> continueWatchingItems;
  final bool isPartial;

  int get continueWatchingCount => continueWatchingItems.length;

  HistoryStatistics withUploaderAvatars(Map<int, String> avatars) {
    if (avatars.isEmpty) return this;
    return HistoryStatistics(
      periodStart: periodStart,
      periodEnd: periodEnd,
      sourceRecordCount: sourceRecordCount,
      reachedRecordLimit: reachedRecordLimit,
      items: items,
      totalContentCount: totalContentCount,
      completedCount: completedCount,
      activeDayCount: activeDayCount,
      favoritedCount: favoritedCount,
      remainingSeconds: remainingSeconds,
      contentTypeCounts: contentTypeCounts,
      hourlyCounts: hourlyCounts,
      activityByDay: activityByDay,
      topUploaders: List.unmodifiable(
        topUploaders.map((uploader) {
          final mid = uploader.mid;
          final avatar = mid == null ? null : avatars[mid];
          return avatar == null
              ? uploader
              : uploader.copyWith(avatarUrl: avatar);
        }),
      ),
      continueWatchingItems: continueWatchingItems,
      isPartial: isPartial,
    );
  }
}

abstract final class HistoryStatisticsCalculator {
  static const _minimumContinueRatio = 0.05;
  static const _maximumContinueRatio = 0.95;

  static HistoryStatistics calculate({
    required Iterable<HistoryItemModel> source,
    required DateTime now,
    int? sourceRecordCount,
    bool reachedRecordLimit = false,
    bool isPartial = false,
  }) {
    final sourceItems = source.toList(growable: false);
    final uniqueItems = <String, HistoryItemModel>{};

    for (final item in sourceItems) {
      if (item.viewAt == null) continue;
      uniqueItems.putIfAbsent(_contentKey(item), () => item);
    }

    final items = uniqueItems.values.toList()
      ..sort((a, b) => (b.viewAt ?? 0).compareTo(a.viewAt ?? 0));
    final today = DateTime(now.year, now.month, now.day);
    final oldestViewAt = items.lastOrNull?.viewAt;
    final periodStart = oldestViewAt == null
        ? today
        : _startOfDay(
            DateTime.fromMillisecondsSinceEpoch(oldestViewAt * 1000),
          );
    final typeCounts = {
      for (final type in HistoryStatisticsContentType.values) type: 0,
    };
    final hourlyCounts = List<int>.filled(24, 0);
    final activityByDay = <DateTime, int>{};
    final uploaderBuilders = <String, _UploaderStatisticsBuilder>{};
    final continueWatchingItems = <HistoryItemModel>[];

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
      hourlyCounts[viewedAt.hour]++;
      final day = _startOfDay(viewedAt);
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
      if (_canContinueWatching(progress: progress, duration: duration)) {
        continueWatchingItems.add(item);
        remainingSeconds += duration! - progress!;
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
            if (countCompare != 0) return countCompare;
            final completedCompare = b.completedCount.compareTo(
              a.completedCount,
            );
            return completedCompare != 0
                ? completedCompare
                : a.name.compareTo(b.name);
          });

    return HistoryStatistics(
      periodStart: periodStart,
      periodEnd: now,
      sourceRecordCount: sourceRecordCount ?? sourceItems.length,
      reachedRecordLimit: reachedRecordLimit,
      items: List.unmodifiable(items),
      totalContentCount: items.length,
      completedCount: completedCount,
      activeDayCount: activityByDay.length,
      favoritedCount: favoritedCount,
      remainingSeconds: remainingSeconds,
      contentTypeCounts: Map.unmodifiable(typeCounts),
      hourlyCounts: List.unmodifiable(hourlyCounts),
      activityByDay: Map.unmodifiable(activityByDay),
      topUploaders: List.unmodifiable(topUploaders),
      continueWatchingItems: List.unmodifiable(continueWatchingItems),
      isPartial: isPartial,
    );
  }

  static bool _canContinueWatching({
    required int? progress,
    required int? duration,
  }) {
    if (progress == null ||
        duration == null ||
        progress < 0 ||
        duration <= 0 ||
        progress > duration) {
      return false;
    }
    final ratio = progress / duration;
    return ratio >= _minimumContinueRatio && ratio <= _maximumContinueRatio;
  }

  static DateTime _startOfDay(DateTime value) {
    return DateTime(value.year, value.month, value.day);
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
