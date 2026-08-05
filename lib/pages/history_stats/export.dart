import 'dart:convert';
import 'dart:typed_data';

import 'package:ex_piliplus/models_new/history/list.dart';
import 'package:ex_piliplus/pages/history_stats/statistics.dart';

/// Serializes the currently loaded history statistics without making network
/// requests or claiming that records outside the loaded range are present.
abstract final class HistoryStatisticsExport {
  static Uint8List jsonBytes(
    HistoryStatistics statistics, {
    DateTime? exportedAt,
  }) {
    final data = _jsonData(
      statistics,
      exportedAt: exportedAt ?? DateTime.now(),
    );
    return Uint8List.fromList(utf8.encode(jsonEncode(data)));
  }

  static Uint8List csvBytes(HistoryStatistics statistics) {
    final rows = <List<String>>[
      [
        'viewed_at',
        'title',
        'business',
        'content_type',
        'partition',
        'uploader',
        'progress_seconds',
        'duration_seconds',
        'completed',
        'favorited',
      ],
      for (final item in statistics.items) _itemRow(item),
    ];
    final csv = rows.map((row) => row.map(_escapeCsv).join(',')).join('\n');
    // A UTF-8 BOM keeps Chinese titles readable in common spreadsheet apps.
    return Uint8List.fromList(utf8.encode('\uFEFF$csv\n'));
  }

  static Map<String, dynamic> _jsonData(
    HistoryStatistics statistics, {
    required DateTime exportedAt,
  }) {
    return {
      'exportVersion': 1,
      'exportedAt': exportedAt.toIso8601String(),
      'period': {
        'start': statistics.periodStart.toIso8601String(),
        'end': statistics.periodEnd.toIso8601String(),
      },
      'source': {
        'recordCount': statistics.sourceRecordCount,
        'loadedRecordCount': statistics.items.length,
        'reachedRecordLimit': statistics.reachedRecordLimit,
        'isPartial': statistics.isPartial,
      },
      'summary': {
        'totalContentCount': statistics.totalContentCount,
        'completedCount': statistics.completedCount,
        'continueWatchingCount': statistics.continueWatchingCount,
        'activeDayCount': statistics.activeDayCount,
        'currentActiveStreak': statistics.currentActiveStreak,
        'longestActiveStreak': statistics.longestActiveStreak,
        'favoritedCount': statistics.favoritedCount,
        'remainingSeconds': statistics.remainingSeconds,
      },
      'weekdayCounts': statistics.weekdayCounts,
      'hourlyCounts': statistics.hourlyCounts,
      'activityByDay': {
        for (final entry in statistics.activityByDay.entries)
          _dateKey(entry.key): entry.value,
      },
      'contentGroups': [
        for (final group in statistics.contentGroups)
          {
            'type': group.type.name,
            'partition': group.partition,
            'count': group.count,
          },
      ],
      'topUploaders': [
        for (final uploader in statistics.topUploaders)
          {
            'name': uploader.name,
            'mid': uploader.mid,
            'contentCount': uploader.contentCount,
            'completedCount': uploader.completedCount,
          },
      ],
      'items': [for (final item in statistics.items) _itemData(item)],
    };
  }

  static Map<String, dynamic> _itemData(HistoryItemModel item) {
    final viewAt = item.viewAt;
    return {
      'viewedAt': viewAt == null
          ? null
          : DateTime.fromMillisecondsSinceEpoch(
              viewAt * 1000,
            ).toIso8601String(),
      'title': item.title,
      'authorName': item.authorName,
      'authorMid': item.authorMid,
      'business': item.history.business,
      'bvid': item.history.bvid,
      'oid': item.history.oid,
      'epid': item.history.epid,
      'page': item.history.page,
      'cid': item.history.cid,
      'tagName': item.tagName,
      'progressSeconds': item.progress,
      'durationSeconds': item.duration,
      'completed': item.progress == -1,
      'favorited': item.isFav == 1,
    };
  }

  static List<String> _itemRow(HistoryItemModel item) {
    final viewAt = item.viewAt;
    return [
      viewAt == null
          ? ''
          : DateTime.fromMillisecondsSinceEpoch(
              viewAt * 1000,
            ).toIso8601String(),
      item.title ?? '',
      item.history.business ?? '',
      _contentTypeName(item),
      item.tagName ?? '',
      item.authorName ?? '',
      item.progress?.toString() ?? '',
      item.duration?.toString() ?? '',
      (item.progress == -1).toString(),
      (item.isFav == 1).toString(),
    ];
  }

  static String _contentTypeName(HistoryItemModel item) {
    return HistoryStatisticsContentType.fromBusiness(
      item.history.business,
    ).name;
  }

  static String _dateKey(DateTime value) {
    final year = value.year.toString().padLeft(4, '0');
    final month = value.month.toString().padLeft(2, '0');
    final day = value.day.toString().padLeft(2, '0');
    return '$year-$month-$day';
  }

  static String _escapeCsv(String value) {
    if (!value.contains(RegExp(r'[",\n\r]'))) return value;
    return '"${value.replaceAll('"', '""')}"';
  }
}
