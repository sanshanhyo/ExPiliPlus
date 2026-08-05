import 'dart:convert';

import 'package:ex_piliplus/models_new/history/history.dart';
import 'package:ex_piliplus/models_new/history/list.dart';
import 'package:ex_piliplus/pages/history_stats/export.dart';
import 'package:ex_piliplus/pages/history_stats/statistics.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final now = DateTime(2026, 8, 5, 12);

  HistoryStatistics statistics() {
    final item = HistoryItemModel(
      title: 'A, title',
      history: History(
        oid: 1,
        bvid: 'BV1',
        business: 'archive',
      ),
      authorName: 'Uploader',
      authorMid: 42,
      viewAt: DateTime(2026, 8, 4, 10).millisecondsSinceEpoch ~/ 1000,
      progress: 50,
      duration: 1000,
      isFav: 1,
      tagName: 'Music',
    );
    return HistoryStatisticsCalculator.calculate(
      source: [item],
      now: now,
      sourceRecordCount: 1,
    );
  }

  test('exports a JSON document with summary and loaded records', () {
    final result =
        jsonDecode(
              utf8.decode(HistoryStatisticsExport.jsonBytes(statistics())),
            )
            as Map<String, dynamic>;

    expect(result['exportVersion'], 1);
    expect(result['summary']['currentActiveStreak'], 1);
    expect(result['summary']['longestActiveStreak'], 1);
    expect(result['weekdayCounts'], [0, 1, 0, 0, 0, 0, 0]);
    expect((result['items'] as List).single['title'], 'A, title');
    expect((result['items'] as List).single['favorited'], isTrue);
  });

  test('exports CSV with a UTF-8 BOM and escaped fields', () {
    final bytes = HistoryStatisticsExport.csvBytes(statistics());
    final csv = utf8.decode(bytes);

    expect(bytes.take(3), [0xEF, 0xBB, 0xBF]);
    expect(csv.startsWith('viewed_at,title,'), isTrue);
    expect(csv, contains('"A, title"'));
    expect(csv, contains(',false,true'));
  });
}
