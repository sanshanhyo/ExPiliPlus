import 'dart:io';

import 'package:ex_piliplus/l10n/generated/app_localizations.dart';
import 'package:ex_piliplus/models/common/app_font_family.dart';
import 'package:ex_piliplus/models/common/app_font_selection.dart';
import 'package:ex_piliplus/pages/setting/widgets/app_font_selection_dialog.dart';
import 'package:ex_piliplus/utils/path_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late final Directory supportDir;

  setUpAll(() {
    supportDir = Directory.systemTemp.createTempSync('exp-font-picker-test-');
    appSupportDirPath = supportDir.path;
  });

  tearDownAll(() {
    supportDir.deleteSync(recursive: true);
  });

  testWidgets('enumerates system fonts only after the system tab is opened', (
    tester,
  ) async {
    var systemLoads = 0;
    AppFontSelection? result;
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Builder(
          builder: (context) => Scaffold(
            body: TextButton(
              onPressed: () async {
                result = await showDialog<AppFontSelection>(
                  context: context,
                  builder: (_) => AppFontSelectionDialog(
                    value: const AppFontSelection.catalog(AppFontFamily.system),
                    systemFontLoader: () async {
                      systemLoads++;
                      return {'Test Sans'};
                    },
                    systemFontsSupported: true,
                    localFontPicker: () async => null,
                  ),
                );
              },
              child: const Text('open'),
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.text('open'));
    await tester.pumpAndSettle();
    expect(systemLoads, 0);

    final l10n = await AppLocalizations.delegate.load(const Locale('en'));
    await tester.tap(find.text(l10n.settingsFontSourceSystem));
    await tester.pumpAndSettle();
    expect(systemLoads, 1);
    expect(find.text('Test Sans'), findsOneWidget);

    await tester.tap(find.text('Test Sans'));
    await tester.pumpAndSettle();
    expect(result, const AppFontSelection.system('Test Sans'));
  });

  testWidgets('enumerates system fonts when swiping to the system tab', (
    tester,
  ) async {
    var systemLoads = 0;
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Builder(
          builder: (context) => Scaffold(
            body: TextButton(
              onPressed: () => showDialog<void>(
                context: context,
                builder: (_) => AppFontSelectionDialog(
                  value: const AppFontSelection.catalog(AppFontFamily.system),
                  systemFontLoader: () async {
                    systemLoads++;
                    return {'Test Sans'};
                  },
                  systemFontsSupported: true,
                  localFontPicker: () async => null,
                ),
              ),
              child: const Text('open'),
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.text('open'));
    await tester.pumpAndSettle();
    expect(systemLoads, 0);

    await tester.drag(find.byType(TabBarView), const Offset(-300, 0));
    await tester.pumpAndSettle();
    expect(systemLoads, 1);
    expect(find.text('Test Sans'), findsOneWidget);
  });

  testWidgets('imports a local font only after the user taps the picker', (
    tester,
  ) async {
    var imports = 0;
    AppFontSelection? result;
    const local = AppFontSelection.local(
      localFileName: 'user_font.otf',
      localDisplayName: 'User Font',
      localFontFamily: 'ExPImportedFont_user',
    );
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Builder(
          builder: (context) => Scaffold(
            body: TextButton(
              onPressed: () async {
                result = await showDialog<AppFontSelection>(
                  context: context,
                  builder: (_) => AppFontSelectionDialog(
                    value: const AppFontSelection.catalog(AppFontFamily.system),
                    systemFontLoader: () async => const {},
                    systemFontsSupported: true,
                    localFontPicker: () async {
                      imports++;
                      return local;
                    },
                  ),
                );
              },
              child: const Text('open'),
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.text('open'));
    await tester.pumpAndSettle();
    expect(imports, 0);

    final l10n = await AppLocalizations.delegate.load(const Locale('en'));
    await tester.tap(find.text(l10n.settingsFontSourceLocal));
    await tester.pumpAndSettle();
    expect(imports, 0);
    await tester.tap(find.text(l10n.settingsFontChooseLocalFile));
    await tester.pumpAndSettle();

    expect(imports, 1);
    expect(result, local);
  });
}
