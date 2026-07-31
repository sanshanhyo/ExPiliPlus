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
      int? progress = 0,
      int? duration = 1000,
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

    test('uses the full available record span and deduplicates content', () {
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
        sourceRecordCount: 5,
        reachedRecordLimit: true,
        now: now,
      );

      expect(result.sourceRecordCount, 5);
      expect(result.reachedRecordLimit, isTrue);
      expect(result.totalContentCount, 4);
      expect(result.completedCount, 2);
      expect(result.continueWatchingCount, 1);
      expect(result.activeDayCount, 3);
      expect(result.favoritedCount, 1);
      expect(result.remainingSeconds, 600);
      expect(result.periodStart, DateTime(2026, 7, 10));
      expect(result.periodEnd, now);
      expect(
        result.contentTypeCounts[HistoryStatisticsContentType.video],
        2,
      );
      expect(
        result.contentTypeCounts[HistoryStatisticsContentType.pgc],
        1,
      );
      expect(
        result.contentTypeCounts[HistoryStatisticsContentType.course],
        1,
      );
      expect(result.hourlyCounts[9], 1);
      expect(result.hourlyCounts[20], 1);
      expect(result.hourlyCounts[21], 1);
      expect(result.topUploaders.first.name, 'Alice');
      expect(result.topUploaders.first.contentCount, 2);
      expect(result.topUploaders.first.completedCount, 1);
      expect(result.continueWatchingItems.single.title, 'EP2');
    });

    test('keeps only progress from 5 through 95 percent', () {
      final viewedAt = DateTime(2026, 7, 29, 12);
      final result = HistoryStatisticsCalculator.calculate(
        source: [
          item(
            id: 'below',
            viewedAt: viewedAt,
            author: 'A',
            progress: 49,
          ),
          item(
            id: 'lower-bound',
            viewedAt: viewedAt,
            author: 'A',
            progress: 50,
          ),
          item(
            id: 'upper-bound',
            viewedAt: viewedAt,
            author: 'A',
            progress: 950,
          ),
          item(
            id: 'above',
            viewedAt: viewedAt,
            author: 'A',
            progress: 951,
          ),
          item(
            id: 'complete',
            viewedAt: viewedAt,
            author: 'A',
            progress: -1,
          ),
          item(
            id: 'invalid',
            viewedAt: viewedAt,
            author: 'A',
            progress: 1100,
          ),
          item(
            id: 'zero-duration',
            viewedAt: viewedAt,
            author: 'A',
            progress: 0,
            duration: 0,
          ),
        ],
        now: now,
      );

      expect(
        result.continueWatchingItems.map((item) => item.title),
        ['lower-bound', 'upper-bound'],
      );
      expect(result.remainingSeconds, 1000);
    });

    test('marks an explicitly truncated result as partial', () {
      final result = HistoryStatisticsCalculator.calculate(
        source: const [],
        now: now,
        isPartial: true,
      );

      expect(result.isPartial, isTrue);
      expect(result.totalContentCount, 0);
      expect(result.periodStart, DateTime(2026, 7, 29));
    });

    test('enriches ranked uploaders with asynchronously loaded avatars', () {
      final result = HistoryStatisticsCalculator.calculate(
        source: [
          item(
            id: 'BV1',
            viewedAt: now,
            author: 'Alice',
            authorMid: 1,
          ),
        ],
        now: now,
      ).withUploaderAvatars({1: 'https://example.com/alice.jpg'});

      expect(
        result.topUploaders.single.avatarUrl,
        'https://example.com/alice.jpg',
      );
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
