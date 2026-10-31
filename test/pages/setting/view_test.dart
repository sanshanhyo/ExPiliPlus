import 'dart:io';

import 'package:ex_piliplus/l10n/app_localization_delegates.dart';
import 'package:ex_piliplus/l10n/generated/app_localizations.dart';
import 'package:ex_piliplus/pages/setting/view.dart';
import 'package:ex_piliplus/pages/setting/common_setting.dart';
import 'package:ex_piliplus/models/common/setting_type.dart';
import 'package:ex_piliplus/utils/storage_key.dart';
import 'package:ex_piliplus/utils/storage_pref.dart';
import 'package:ex_piliplus/utils/accounts.dart';
import 'package:ex_piliplus/utils/accounts/account.dart';
import 'package:ex_piliplus/utils/storage.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:hive_ce/hive.dart';

void main() {
  late Directory tempDirectory;

  setUpAll(() async {
    tempDirectory = await Directory.systemTemp.createTemp(
      'expiliplus-setting-view-test-',
    );
    Hive.init(tempDirectory.path);
    GStorage.setting = await Hive.openBox<dynamic>('setting');
    GStorage.video = await Hive.openBox<dynamic>('video');
    GStorage.localCache = await Hive.openBox<dynamic>('localCache');
    Accounts.account = await Hive.openBox<LoginAccount>('account');
  });

  tearDownAll(() async {
    await Hive.close();
    await tempDirectory.delete(recursive: true);
  });

  for (final value in <dynamic>[-1, 0, 4, 8, true, false, 'bad', 99]) {
    testWidgets('ExPiliPlus settings render with saved font weight $value', (
      tester,
    ) async {
      await GStorage.setting.put(SettingBoxKey.appFontWeight, value);
      expect(
        Pref.appFontWeight,
        value is int && value >= -1 && value <= 8 ? value : -1,
      );
      // Reading legacy values must not silently rewrite user storage.
      expect(GStorage.setting.get(SettingBoxKey.appFontWeight), value);
      await tester.binding.setSurfaceSize(const Size(390, 844));
      addTearDown(() => tester.binding.setSurfaceSize(null));
      await tester.pumpWidget(
        MaterialApp(
          locale: const Locale('zh'),
          localizationsDelegates: appLocalizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          theme: ThemeData.dark(),
          home: const CommonSetting(settingType: SettingType.exPiliPlusSetting),
        ),
      );
      await tester.pumpAndSettle();
      await tester.drag(find.byType(ListView), const Offset(0, -1200));
      await tester.pumpAndSettle();
      expect(find.byType(ErrorWidget), findsNothing);
      expect(tester.takeException(), isNull);
      expect(GStorage.setting.get(SettingBoxKey.appFontWeight), value);
    });
  }

  testWidgets('desktop settings body paints below short ExPiliPlus list', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(1200, 800));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      GetMaterialApp(
        locale: const Locale('zh'),
        localizationsDelegates: appLocalizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        themeMode: ThemeMode.dark,
        home: const SettingPage(),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('ExPiliPlus 设置'));
    await tester.pumpAndSettle();

    final body = find.byKey(const ValueKey('settings-body-background'));
    expect(body, findsOneWidget);
    final bodySize = tester.getSize(body);
    expect(bodySize.height, 744);
    expect(bodySize.width, greaterThan(0));
  });
}
