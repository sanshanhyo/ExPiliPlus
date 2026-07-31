import 'package:ex_piliplus/l10n/generated/app_localizations.dart';
import 'package:ex_piliplus/models_new/history/history.dart';
import 'package:ex_piliplus/models_new/history/list.dart';
import 'package:ex_piliplus/pages/history_stats/statistics.dart';
import 'package:ex_piliplus/pages/history_stats/view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

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
}
