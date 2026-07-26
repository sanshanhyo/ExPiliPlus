import 'dart:io';

import 'package:ex_piliplus/l10n/generated/app_localizations.dart';
import 'package:ex_piliplus/models/common/app_font_family.dart';
import 'package:ex_piliplus/pages/setting/widgets/app_font_family_dialog.dart';
import 'package:ex_piliplus/utils/path_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late final Directory supportDir;

  setUpAll(() {
    supportDir = Directory.systemTemp.createTempSync('piliplus-font-test-');
    appSupportDirPath = supportDir.path;
  });

  tearDownAll(() {
    supportDir.deleteSync(recursive: true);
  });

  testWidgets('offers downloads before custom fonts can be selected', (
    tester,
  ) async {
    final l10n = await AppLocalizations.delegate.load(const Locale('zh'));
    await tester.pumpWidget(
      const MaterialApp(
        locale: Locale('zh'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: AppFontFamilyDialog(value: AppFontFamily.system),
      ),
    );

    for (final font in AppFontFamily.values) {
      expect(find.text(font.localizedLabel(l10n)), findsOneWidget);
    }
    expect(find.text('24.8 MB'), findsOneWidget);
    expect(find.text('11.1 MB'), findsOneWidget);
    expect(
      find.byTooltip(l10n.settingsDownloadFont),
      findsNWidgets(AppFontFamily.values.length - 1),
    );

    final radios = tester
        .widgetList<Radio<AppFontFamily>>(
          find.byType(Radio<AppFontFamily>),
        )
        .toList(growable: false);
    expect(
      radios.map((radio) => radio.enabled),
      [true, ...List.filled(AppFontFamily.values.length - 1, false)],
    );
  });
}
