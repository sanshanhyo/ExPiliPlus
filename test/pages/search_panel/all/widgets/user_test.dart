import 'dart:io';

import 'package:ex_piliplus/l10n/generated/app_localizations.dart';
import 'package:ex_piliplus/models/search/result.dart';
import 'package:ex_piliplus/pages/search_panel/all/widgets/user.dart';
import 'package:ex_piliplus/utils/date_utils.dart';
import 'package:ex_piliplus/utils/storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:hive_ce/hive.dart';

void main() {
  late Directory tempDirectory;

  setUpAll(() async {
    tempDirectory = await Directory.systemTemp.createTemp(
      'expiliplus-search-user-theme-test-',
    );
    Hive.init(tempDirectory.path);
    GStorage.setting = await Hive.openBox<dynamic>('setting');
    GStorage.video = await Hive.openBox<dynamic>('video');
    GStorage.localCache = await Hive.openBox<dynamic>('localCache');
  });

  tearDownAll(() async {
    await Hive.close();
    await tempDirectory.delete(recursive: true);
    Get.reset();
  });

  testWidgets('author and video text follow Flutter theme at runtime', (
    tester,
  ) async {
    final item = SearchUser(
      mid: 123,
      uname: '测试作者',
      usign: '测试签名',
      fans: 10,
      videos: 1,
      upic: '',
      level: 6,
      res: [
        SearchVideoItemModel.fromJson({
          'aid': 456,
          'bvid': 'BV1test',
          'title': '测试视频标题',
          'pic': '',
          'pubdate': 946684800,
          'duration': '01:00',
          'play': 20,
        }),
      ],
    );

    RichText renderedText(String text) => tester.widget<RichText>(
      find.descendant(
        of: find.byType(SearchAllUserItem),
        matching: find.byWidgetPredicate(
          (widget) => widget is RichText && widget.text.toPlainText() == text,
        ),
      ),
    );

    for (final theme in [
      ThemeData.light(),
      ThemeData.dark(),
      ThemeData.light(),
    ]) {
      await tester.pumpWidget(
        GetMaterialApp(
          locale: const Locale('zh'),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          theme: theme,
          themeMode: ThemeMode.light,
          home: Scaffold(
            body: Align(
              alignment: Alignment.topLeft,
              child: SearchAllUserItem(item: item),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      final actualTheme = Theme.of(
        tester.element(find.byType(SearchAllUserItem)),
      );
      final textColor = actualTheme.textTheme.bodyMedium!.color;
      expect(renderedText('测试作者').text.style!.color, textColor);
      expect(renderedText('测试视频标题').text.style!.color, textColor);
      expect(
        renderedText('10粉丝 · 1个视频').text.style!.color,
        actualTheme.colorScheme.outline,
      );
      expect(
        renderedText('测试签名').text.style!.color,
        actualTheme.colorScheme.outline,
      );
      expect(
        renderedText(
          DateFormatUtils.dateFormat(item.res!.first.pubdate),
        ).text.style!.color,
        actualTheme.colorScheme.outline,
      );
      expect(tester.takeException(), isNull);
    }
  });
}
