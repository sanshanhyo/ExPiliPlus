import 'package:ex_piliplus/l10n/generated/app_localizations.dart';
import 'package:ex_piliplus/models_new/history/history.dart';
import 'package:ex_piliplus/models_new/history/list.dart';
import 'package:ex_piliplus/pages/history_stats/statistics.dart';
import 'package:ex_piliplus/pages/history_stats/view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('statistics content fits a compact English layout', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(360, 800));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    final now = DateTime(2026, 7, 29, 20);
    final item = HistoryItemModel(
      title: 'A finished video',
      history: History(
        oid: 1,
        bvid: 'BV1',
        business: 'archive',
      ),
      videos: 1,
      authorName: 'Uploader',
      authorMid: 42,
      viewAt: DateTime(2026, 7, 28, 20).millisecondsSinceEpoch ~/ 1000,
      progress: -1,
      duration: 600,
      isFav: 1,
      kid: 1,
    );
    final statistics = HistoryStatisticsCalculator.calculate(
      source: [item],
      range: HistoryStatisticsRange.thirtyDays,
      now: now,
    );
    var selectedRange = HistoryStatisticsRange.thirtyDays;

    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('en'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: HistoryStatisticsContent(
            statistics: statistics,
            selectedRange: selectedRange,
            onRangeSelected: (value) => selectedRange = value,
            onRefresh: () async {},
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Overview'), findsOneWidget);
    expect(find.text('Different items viewed'), findsOneWidget);
    expect(find.text('Completed'), findsOneWidget);
    expect(find.text('Top uploaders'), findsOneWidget);
    expect(tester.takeException(), isNull);

    await tester.tap(find.text('7 days'));
    await tester.pump();
    expect(selectedRange, HistoryStatisticsRange.sevenDays);
    expect(tester.takeException(), isNull);

    for (final locale in const [
      Locale('zh'),
      Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hant'),
    ]) {
      await tester.pumpWidget(
        MaterialApp(
          locale: locale,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Scaffold(
            body: HistoryStatisticsContent(
              statistics: statistics,
              selectedRange: HistoryStatisticsRange.thirtyDays,
              onRangeSelected: (_) {},
              onRefresh: () async {},
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
    }
  });
}
