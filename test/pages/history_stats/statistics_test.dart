import 'package:ex_piliplus/models_new/history/history.dart';
import 'package:ex_piliplus/models_new/history/list.dart';
import 'package:ex_piliplus/pages/history_stats/statistics.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('HistoryStatisticsCalculator', () {
    final now = DateTime(2026, 7, 29, 22);

    HistoryItemModel item({
      required String id,
      required DateTime viewedAt,
      required String author,
      String business = 'archive',
      int progress = 0,
      int duration = 1000,
      int isFav = 0,
      int? authorMid,
    }) {
      return HistoryItemModel(
        title: id,
        history: History(
          oid: id.hashCode,
          epid: business == 'pgc' ? id.hashCode : null,
          bvid: business == 'archive' ? id : null,
          business: business,
        ),
        videos: 1,
        authorName: author,
        authorMid: authorMid,
        viewAt: viewedAt.millisecondsSinceEpoch ~/ 1000,
        progress: progress,
        duration: duration,
        isFav: isFav,
        kid: id.hashCode,
      );
    }

    test('deduplicates content and calculates reliable history metrics', () {
      final result = HistoryStatisticsCalculator.calculate(
        source: [
          item(
            id: 'BV1',
            viewedAt: DateTime(2026, 7, 28, 9),
            author: 'Alice',
            authorMid: 1,
            progress: -1,
            isFav: 1,
          ),
          item(
            id: 'EP2',
            viewedAt: DateTime(2026, 7, 27, 20),
            author: 'Bob',
            authorMid: 2,
            business: 'pgc',
            progress: 400,
          ),
          item(
            id: 'BV3',
            viewedAt: DateTime(2026, 7, 27, 21),
            author: 'Alice',
            authorMid: 1,
          ),
          // The API can repeat the cursor boundary item between pages.
          item(
            id: 'BV1',
            viewedAt: DateTime(2026, 7, 27, 8),
            author: 'Alice',
            authorMid: 1,
            progress: 300,
          ),
          item(
            id: 'OLD',
            viewedAt: DateTime(2026, 7, 10),
            author: 'Old uploader',
            business: 'cheese',
            progress: -1,
          ),
        ],
        range: HistoryStatisticsRange.sevenDays,
        now: now,
      );

      expect(result.totalContentCount, 3);
      expect(result.completedCount, 1);
      expect(result.unfinishedCount, 1);
      expect(result.activeDayCount, 2);
      expect(result.favoritedCount, 1);
      expect(result.remainingSeconds, 600);
      expect(
        result.contentTypeCounts[HistoryStatisticsContentType.video],
        2,
      );
      expect(
        result.contentTypeCounts[HistoryStatisticsContentType.pgc],
        1,
      );
      expect(result.hourBucketCounts[2], 1);
      expect(result.hourBucketCounts[5], 2);
      expect(result.topUploaders.first.name, 'Alice');
      expect(result.topUploaders.first.contentCount, 2);
      expect(result.topUploaders.first.completedCount, 1);
      expect(result.unfinishedItems.single.title, 'EP2');
    });

    test('marks an explicitly truncated result as partial', () {
      final result = HistoryStatisticsCalculator.calculate(
        source: const [],
        range: HistoryStatisticsRange.thirtyDays,
        now: now,
        isPartial: true,
      );

      expect(result.isPartial, isTrue);
      expect(result.totalContentCount, 0);
      expect(result.periodStart, DateTime(2026, 6, 30));
    });
  });

  test('content types map known history businesses', () {
    expect(
      HistoryStatisticsContentType.fromBusiness('archive'),
      HistoryStatisticsContentType.video,
    );
    expect(
      HistoryStatisticsContentType.fromBusiness('pgc'),
      HistoryStatisticsContentType.pgc,
    );
    expect(
      HistoryStatisticsContentType.fromBusiness('live'),
      HistoryStatisticsContentType.live,
    );
    expect(
      HistoryStatisticsContentType.fromBusiness('article-list'),
      HistoryStatisticsContentType.article,
    );
    expect(
      HistoryStatisticsContentType.fromBusiness('cheese'),
      HistoryStatisticsContentType.course,
    );
    expect(
      HistoryStatisticsContentType.fromBusiness('unknown'),
      HistoryStatisticsContentType.other,
    );
  });
}
