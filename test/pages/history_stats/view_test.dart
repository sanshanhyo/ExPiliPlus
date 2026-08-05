import 'package:ex_piliplus/l10n/generated/app_localizations.dart';
import 'package:ex_piliplus/models_new/history/history.dart';
import 'package:ex_piliplus/models_new/history/list.dart';
import 'package:ex_piliplus/pages/history_stats/statistics.dart';
import 'package:ex_piliplus/pages/history_stats/view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';

void main() {
  testWidgets('statistics dashboard fits compact layouts in every locale', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(360, 800));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    final now = DateTime(2026, 7, 29, 20);
    final items = [
      HistoryItemModel(
        title: 'A video ready to continue',
        history: History(oid: 1, bvid: 'BV1', business: 'archive'),
        videos: 1,
        authorName: 'Uploader One',
        authorMid: 42,
        viewAt: DateTime(2026, 7, 28, 20).millisecondsSinceEpoch ~/ 1000,
        progress: 300,
        duration: 600,
        isFav: 1,
        kid: 1,
      ),
      HistoryItemModel(
        title: 'A completed episode',
        history: History(oid: 2, epid: 2, business: 'pgc'),
        videos: 1,
        authorName: 'Uploader Two',
        authorMid: 43,
        viewAt: DateTime(2026, 7, 27, 9).millisecondsSinceEpoch ~/ 1000,
        progress: -1,
        duration: 1200,
        isFav: 0,
        kid: 2,
      ),
    ];
    final statistics = HistoryStatisticsCalculator.calculate(
      source: items,
      sourceRecordCount: HistoryStatistics.recordLimit,
      reachedRecordLimit: true,
      now: now,
    );

    Widget app(Locale locale) => MaterialApp(
      locale: locale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Scaffold(
        body: HistoryStatisticsContent(
          statistics: statistics,
          onRefresh: () async {},
        ),
      ),
    );

    await tester.pumpWidget(app(const Locale('en')));
    await tester.pumpAndSettle();

    expect(find.text('Recent viewing overview'), findsOneWidget);
    expect(find.text('Ready to continue'), findsOneWidget);
    expect(find.text('Activity'), findsOneWidget);
    expect(find.text('Active hours'), findsOneWidget);
    expect(find.text('Content types'), findsOneWidget);
    expect(find.text('Top uploaders'), findsOneWidget);
    expect(find.text('Continue watching'), findsOneWidget);
    expect(find.text('7 days'), findsNothing);
    expect(tester.takeException(), isNull);

    for (final locale in const [
      Locale('zh'),
      Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hant'),
    ]) {
      await tester.pumpWidget(app(locale));
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
    }
  });

  testWidgets('content chart shows type and partition entries', (tester) async {
    await tester.binding.setSurfaceSize(const Size(360, 800));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    final now = DateTime(2026, 7, 29, 20);
    final items = [
      for (final partition in [
        'Animation',
        'Music',
        'Technology',
        'Gaming',
        'Dance',
        'Food',
        'Sports',
        'Knowledge',
      ])
        HistoryItemModel(
          title: '$partition video',
          history: History(
            oid: partition.hashCode,
            bvid: 'BV$partition',
            business: 'archive',
          ),
          videos: 1,
          authorName: 'Uploader',
          viewAt: now.millisecondsSinceEpoch ~/ 1000,
          progress: -1,
          duration: 600,
          kid: partition.hashCode,
          tagName: partition,
        ),
      HistoryItemModel(
        title: 'Uncategorized video',
        history: History(oid: 100, bvid: 'BV100', business: 'archive'),
        videos: 1,
        authorName: 'Uploader',
        viewAt: now.millisecondsSinceEpoch ~/ 1000,
        progress: -1,
        duration: 600,
        kid: 100,
      ),
      HistoryItemModel(
        title: 'Live games',
        history: History(oid: 101, business: 'live'),
        videos: 1,
        authorName: 'Streamer',
        viewAt: now.millisecondsSinceEpoch ~/ 1000,
        progress: -1,
        duration: 600,
        kid: 101,
        tagName: 'Games',
      ),
      HistoryItemModel(
        title: 'Episode',
        history: History(oid: 102, epid: 102, business: 'pgc'),
        videos: 1,
        authorName: 'Uploader',
        viewAt: now.millisecondsSinceEpoch ~/ 1000,
        progress: -1,
        duration: 600,
        kid: 102,
      ),
    ];

    final statistics = HistoryStatisticsCalculator.calculate(
      source: items,
      now: now,
    );

    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('en'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: HistoryStatisticsContent(
            statistics: statistics,
            onRefresh: () async {},
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Videos · Animation'), findsOneWidget);
    expect(find.text('Videos · Uncategorized'), findsOneWidget);
    expect(find.text('Live · Games'), findsOneWidget);
    expect(find.text('Anime & TV'), findsOneWidget);
    expect(
      find.byKey(const ValueKey('statistics-content-legend-scroll')),
      findsOneWidget,
    );
    expect(tester.takeException(), isNull);
  });

  testWidgets(
    'multi-month calendar trims dates outside the active range',
    (tester) async {
      await tester.binding.setSurfaceSize(const Size(360, 800));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      final now = DateTime(2026, 7, 29, 20);
      final items = [
        HistoryItemModel(
          title: 'June item',
          history: History(oid: 10, bvid: 'BV10', business: 'archive'),
          videos: 1,
          authorName: 'Uploader One',
          authorMid: 42,
          viewAt: DateTime(2026, 6, 15, 10).millisecondsSinceEpoch ~/ 1000,
          progress: -1,
          duration: 1200,
          isFav: 0,
          kid: 10,
        ),
        HistoryItemModel(
          title: 'July item',
          history: History(oid: 20, bvid: 'BV20', business: 'archive'),
          videos: 1,
          authorName: 'Uploader Two',
          authorMid: 43,
          viewAt: DateTime(2026, 7, 20, 14).millisecondsSinceEpoch ~/ 1000,
          progress: -1,
          duration: 1200,
          isFav: 0,
          kid: 20,
        ),
      ];
      final statistics = HistoryStatisticsCalculator.calculate(
        source: items,
        now: now,
      );

      await tester.pumpWidget(
        MaterialApp(
          locale: const Locale('en'),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Scaffold(
            body: HistoryStatisticsContent(
              statistics: statistics,
              onRefresh: () async {},
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Month headings for both months in the range.
      expect(find.text('June 2026'), findsOneWidget);
      expect(find.text('July 2026'), findsOneWidget);
      // Active day numbers remain visible in both months.
      expect(find.text('15'), findsNWidgets(2));
      expect(find.text('20'), findsNWidgets(2));
      // Dates outside the first and last detectable activity are omitted.
      final context = tester.element(find.byType(HistoryStatisticsContent));
      final l10n = AppLocalizations.of(context);
      final locale = Localizations.localeOf(context).toLanguageTag();
      final dateFormat = DateFormat.MMMd(locale);
      expect(
        find.byTooltip(
          l10n.statisticsActivityTooltip(
            dateFormat.format(DateTime(2026, 6, 1)),
            0,
          ),
        ),
        findsNothing,
      );
      expect(
        find.byTooltip(
          l10n.statisticsActivityTooltip(
            dateFormat.format(DateTime(2026, 7, 29)),
            0,
          ),
        ),
        findsNothing,
      );
      // Week-alignment placeholders still render without exceptions.
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets('low and high daily counts produce different cell colors', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(360, 800));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    final now = DateTime(2026, 7, 29, 20);
    final july10 = DateTime(2026, 7, 10, 10);
    final july20 = DateTime(2026, 7, 20, 14);
    final items = [
      // 1 item on July 10 (low count).
      HistoryItemModel(
        title: 'Low count item',
        history: History(oid: 100, bvid: 'BV100', business: 'archive'),
        videos: 1,
        authorName: 'Uploader A',
        authorMid: 50,
        viewAt: july10.millisecondsSinceEpoch ~/ 1000,
        progress: -1,
        duration: 1200,
        isFav: 0,
        kid: 100,
      ),
      // 5 items on July 20 (high count, maxCount = 5).
      for (var index = 0; index < 5; index++)
        HistoryItemModel(
          title: 'High count item $index',
          history: History(
            oid: 200 + index,
            bvid: 'BV20$index',
            business: 'archive',
          ),
          videos: 1,
          authorName: 'Uploader B',
          authorMid: 51,
          viewAt: july20.millisecondsSinceEpoch ~/ 1000,
          progress: -1,
          duration: 1200,
          isFav: 0,
          kid: 200 + index,
        ),
    ];
    final statistics = HistoryStatisticsCalculator.calculate(
      source: items,
      now: now,
    );

    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('en'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: HistoryStatisticsContent(
            statistics: statistics,
            onRefresh: () async {},
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    final lowDecoration = _findDayCellDecoration(tester, '10');
    final highDecoration = _findDayCellDecoration(tester, '20');
    expect(
      lowDecoration,
      isNotNull,
      reason: 'day cell for July 10 should be present',
    );
    expect(
      highDecoration,
      isNotNull,
      reason: 'day cell for July 20 should be present',
    );
    expect(
      lowDecoration!.color,
      isNot(equals(highDecoration!.color)),
      reason: 'low-count and high-count cells must differ in color',
    );

    expect(tester.takeException(), isNull);
  });

  testWidgets('localized activity tooltip exists on day cells', (tester) async {
    await tester.binding.setSurfaceSize(const Size(360, 800));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    final now = DateTime(2026, 7, 29, 20);
    final july15 = DateTime(2026, 7, 15, 10);
    final items = [
      HistoryItemModel(
        title: 'Tooltip item',
        history: History(oid: 300, bvid: 'BV300', business: 'archive'),
        videos: 1,
        authorName: 'Uploader C',
        authorMid: 60,
        viewAt: july15.millisecondsSinceEpoch ~/ 1000,
        progress: -1,
        duration: 1200,
        isFav: 0,
        kid: 300,
      ),
    ];
    final statistics = HistoryStatisticsCalculator.calculate(
      source: items,
      now: now,
    );

    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('en'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: HistoryStatisticsContent(
            statistics: statistics,
            onRefresh: () async {},
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    // Build the expected tooltip from the same l10n + DateFormat the widget
    // uses, so the assertion stays correct if the ARB template changes.
    final context = tester.element(find.byType(HistoryStatisticsContent));
    final l10n = AppLocalizations.of(context);
    final locale = Localizations.localeOf(context).toLanguageTag();
    final dateFormat = DateFormat.MMMd(locale);
    final expectedTooltip = l10n.statisticsActivityTooltip(
      dateFormat.format(DateTime(2026, 7, 15)),
      1,
    );
    expect(find.byTooltip(expectedTooltip), findsOneWidget);

    expect(tester.takeException(), isNull);
  });
}

/// Finds the [BoxDecoration] of the day-cell [Container] whose direct child is
/// a [Text] displaying [dayText].
///
/// Filters out rank-badge circles by requiring a rectangular (non-circle)
/// shape, so only calendar day cells match.
BoxDecoration? _findDayCellDecoration(WidgetTester tester, String dayText) {
  for (final element in find.byType(Container).evaluate()) {
    final container = element.widget as Container;
    final decoration = container.decoration;
    if (decoration is BoxDecoration &&
        decoration.color != null &&
        decoration.shape != BoxShape.circle &&
        container.child is Text &&
        (container.child as Text).data == dayText) {
      return decoration;
    }
  }
  return null;
}
