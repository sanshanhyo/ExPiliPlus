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
      String? business = 'archive',
      int? progress = 0,
      int? duration = 1000,
      int isFav = 0,
      int? authorMid,
      String? tagName,
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
        tagName: tagName,
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
        result.contentGroups,
        const [
          HistoryStatisticsContentGroup(
            type: HistoryStatisticsContentType.video,
            partition: null,
            count: 2,
          ),
          HistoryStatisticsContentGroup(
            type: HistoryStatisticsContentType.pgc,
            partition: null,
            count: 1,
          ),
          HistoryStatisticsContentGroup(
            type: HistoryStatisticsContentType.course,
            partition: null,
            count: 1,
          ),
        ],
      );
      expect(result.hourlyCounts[9], 1);
      expect(result.hourlyCounts[20], 1);
      expect(result.hourlyCounts[21], 1);
      expect(result.topUploaders.first.name, 'Alice');
      expect(result.topUploaders.first.contentCount, 2);
      expect(result.topUploaders.first.completedCount, 1);
      expect(result.continueWatchingItems.single.title, 'EP2');
    });

    test('calculates active streaks and weekday distribution', () {
      final result = HistoryStatisticsCalculator.calculate(
        source: [
          item(
            id: 'mon',
            viewedAt: DateTime(2026, 7, 27, 9),
            author: 'A',
          ),
          item(
            id: 'tue-one',
            viewedAt: DateTime(2026, 7, 28, 9),
            author: 'A',
          ),
          item(
            id: 'tue-two',
            viewedAt: DateTime(2026, 7, 28, 10),
            author: 'B',
          ),
          item(
            id: 'thu',
            viewedAt: DateTime(2026, 7, 30, 9),
            author: 'A',
          ),
          item(
            id: 'fri',
            viewedAt: DateTime(2026, 7, 31, 9),
            author: 'A',
          ),
          item(
            id: 'sat',
            viewedAt: DateTime(2026, 8, 1, 9),
            author: 'A',
          ),
        ],
        now: now,
      );

      expect(result.currentActiveStreak, 3);
      expect(result.longestActiveStreak, 3);
      expect(result.weekdayCounts, [1, 2, 0, 1, 1, 1, 0]);
    });

    test('returns zero streaks and weekday counts for empty statistics', () {
      final result = HistoryStatisticsCalculator.calculate(
        source: const [],
        now: now,
      );

      expect(result.currentActiveStreak, 0);
      expect(result.longestActiveStreak, 0);
      expect(result.weekdayCounts, [0, 0, 0, 0, 0, 0, 0]);
    });

    test('groups only video and live records by normalized tag name', () {
      final result = HistoryStatisticsCalculator.calculate(
        source: [
          item(
            id: 'archive-animation',
            viewedAt: now,
            author: 'A',
            tagName: ' Animation ',
          ),
          item(
            id: 'archive-music',
            viewedAt: now,
            author: 'A',
            tagName: 'Music',
          ),
          item(
            id: 'archive-whitespace',
            viewedAt: now,
            author: 'A',
            tagName: '  \t ',
          ),
          item(
            id: 'archive-null',
            viewedAt: now,
            author: 'A',
          ),
          item(
            id: 'live-games',
            viewedAt: now,
            author: 'A',
            business: 'live',
            tagName: ' Games ',
          ),
          item(
            id: 'pgc',
            viewedAt: now,
            author: 'A',
            business: 'pgc',
            tagName: '',
          ),
          item(
            id: 'article',
            viewedAt: now,
            author: 'A',
            business: 'article',
            tagName: '',
          ),
          item(
            id: 'course',
            viewedAt: now,
            author: 'A',
            business: 'cheese',
            tagName: '',
          ),
          item(
            id: 'unknown',
            viewedAt: now,
            author: 'A',
            business: 'unknown',
            tagName: 'Ignored',
          ),
        ],
        now: now,
      );

      expect(
        result.contentGroups,
        const [
          HistoryStatisticsContentGroup(
            type: HistoryStatisticsContentType.video,
            partition: null,
            count: 2,
          ),
          HistoryStatisticsContentGroup(
            type: HistoryStatisticsContentType.video,
            partition: 'Animation',
            count: 1,
          ),
          HistoryStatisticsContentGroup(
            type: HistoryStatisticsContentType.video,
            partition: 'Music',
            count: 1,
          ),
          HistoryStatisticsContentGroup(
            type: HistoryStatisticsContentType.pgc,
            partition: null,
            count: 1,
          ),
          HistoryStatisticsContentGroup(
            type: HistoryStatisticsContentType.live,
            partition: 'Games',
            count: 1,
          ),
          HistoryStatisticsContentGroup(
            type: HistoryStatisticsContentType.article,
            partition: null,
            count: 1,
          ),
          HistoryStatisticsContentGroup(
            type: HistoryStatisticsContentType.course,
            partition: null,
            count: 1,
          ),
          HistoryStatisticsContentGroup(
            type: HistoryStatisticsContentType.other,
            partition: null,
            count: 1,
          ),
        ],
      );
      expect(
        result.contentGroups.fold<int>(0, (sum, group) => sum + group.count),
        result.totalContentCount,
      );
      expect(
        () => result.contentGroups.add(
          const HistoryStatisticsContentGroup(
            type: HistoryStatisticsContentType.other,
            partition: null,
            count: 1,
          ),
        ),
        throwsUnsupportedError,
      );
    });

    test('deduplicates cursor-boundary records before grouping', () {
      final result = HistoryStatisticsCalculator.calculate(
        source: [
          item(
            id: 'duplicate',
            viewedAt: now,
            author: 'A',
            tagName: 'Animation',
          ),
          item(
            id: 'duplicate',
            viewedAt: now.subtract(const Duration(hours: 1)),
            author: 'A',
            tagName: 'Music',
          ),
          item(
            id: 'unique',
            viewedAt: now,
            author: 'A',
            tagName: 'Music',
          ),
        ],
        sourceRecordCount: 3,
        now: now,
      );

      expect(result.sourceRecordCount, 3);
      expect(result.totalContentCount, 2);
      expect(
        result.contentGroups,
        const [
          HistoryStatisticsContentGroup(
            type: HistoryStatisticsContentType.video,
            partition: 'Animation',
            count: 1,
          ),
          HistoryStatisticsContentGroup(
            type: HistoryStatisticsContentType.video,
            partition: 'Music',
            count: 1,
          ),
        ],
      );
    });

    test('orders groups by count, type, and partition with null last', () {
      final result = HistoryStatisticsCalculator.calculate(
        source: [
          for (var index = 0; index < 3; index++)
            item(
              id: 'course-$index',
              viewedAt: now,
              author: 'A',
              business: 'cheese',
            ),
          for (var index = 0; index < 2; index++)
            item(
              id: 'video-zeta-$index',
              viewedAt: now,
              author: 'A',
              tagName: 'Zeta',
            ),
          for (var index = 0; index < 2; index++)
            item(
              id: 'pgc-$index',
              viewedAt: now,
              author: 'A',
              business: 'pgc',
            ),
          item(
            id: 'video-alpha',
            viewedAt: now,
            author: 'A',
            tagName: 'Alpha',
          ),
          item(
            id: 'video-beta',
            viewedAt: now,
            author: 'A',
            tagName: 'Beta',
          ),
          item(id: 'video-null', viewedAt: now, author: 'A'),
          item(
            id: 'live',
            viewedAt: now,
            author: 'A',
            business: 'live',
            tagName: 'Live',
          ),
        ],
        now: now,
      );

      expect(
        result.contentGroups,
        const [
          HistoryStatisticsContentGroup(
            type: HistoryStatisticsContentType.course,
            partition: null,
            count: 3,
          ),
          HistoryStatisticsContentGroup(
            type: HistoryStatisticsContentType.video,
            partition: 'Zeta',
            count: 2,
          ),
          HistoryStatisticsContentGroup(
            type: HistoryStatisticsContentType.pgc,
            partition: null,
            count: 2,
          ),
          HistoryStatisticsContentGroup(
            type: HistoryStatisticsContentType.video,
            partition: 'Alpha',
            count: 1,
          ),
          HistoryStatisticsContentGroup(
            type: HistoryStatisticsContentType.video,
            partition: 'Beta',
            count: 1,
          ),
          HistoryStatisticsContentGroup(
            type: HistoryStatisticsContentType.video,
            partition: null,
            count: 1,
          ),
          HistoryStatisticsContentGroup(
            type: HistoryStatisticsContentType.live,
            partition: 'Live',
            count: 1,
          ),
        ],
      );
      expect(
        result.contentGroups.fold<int>(0, (sum, group) => sum + group.count),
        result.totalContentCount,
      );
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
      HistoryStatisticsContentType.fromBusiness(null),
      HistoryStatisticsContentType.video,
    );
    expect(
      HistoryStatisticsContentType.fromBusiness(''),
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
