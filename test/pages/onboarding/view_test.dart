import 'dart:io';

import 'package:ex_piliplus/l10n/generated/app_localizations.dart';
import 'package:ex_piliplus/pages/onboarding/view.dart';
import 'package:ex_piliplus/utils/storage.dart';
import 'package:ex_piliplus/utils/storage_key.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:hive_ce/hive.dart';

void main() {
  late Directory tempDir;

  setUpAll(() async {
    tempDir = Directory.systemTemp.createTempSync('onboarding-view-test-');
    Hive.init(tempDir.path);
    GStorage.setting = await Hive.openBox<dynamic>('setting');
    GStorage.localCache = await Hive.openBox<dynamic>('localCache');
  });

  testWidgets('local import help explains PiliPlus export paths', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(360, 640));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    final l10n = await AppLocalizations.delegate.load(const Locale('en'));
    await tester.pumpWidget(
      const GetMaterialApp(
        locale: Locale('en'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: OnboardingPage(),
      ),
    );

    await tester.tap(find.text(l10n.onboardingGetStarted));
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip(l10n.onboardingImportHelp));
    await tester.pumpAndSettle();

    expect(find.text(l10n.onboardingImportHelpTitle), findsOneWidget);
    expect(find.text(l10n.onboardingImportHelpSettingsPath), findsOneWidget);
    expect(find.text(l10n.onboardingImportHelpLoginPath), findsOneWidget);
    expect(find.text(l10n.onboardingImportHelpExportHint), findsOneWidget);

    await tester.tap(find.text(l10n.commonClose));
    await tester.pumpAndSettle();
    expect(find.text(l10n.onboardingImportHelpTitle), findsNothing);

    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump();
    Get.reset();
  });

  testWidgets('finishing onboarding opened from settings returns to settings', (
    tester,
  ) async {
    final l10n = await AppLocalizations.delegate.load(const Locale('en'));
    await tester.pumpWidget(
      GetMaterialApp(
        locale: const Locale('en'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        initialRoute: '/settings',
        getPages: [
          GetPage<void>(
            name: '/settings',
            page: () => Scaffold(
              body: TextButton(
                onPressed: () => Get.toNamed<void>('/onboarding'),
                child: const Text('Settings marker'),
              ),
            ),
          ),
          GetPage<void>(
            name: '/onboarding',
            page: () => const OnboardingPage(),
          ),
        ],
      ),
    );

    await tester.tap(find.text('Settings marker'));
    await tester.pumpAndSettle();
    expect(Get.previousRoute, isNotEmpty);

    Future<void> tapPrimary(String label) async {
      final button = find.descendant(
        of: find.byType(FilledButton),
        matching: find.text(label),
      );
      expect(button, findsOneWidget);
      await tester.tap(button);
      await tester.pumpAndSettle();
    }

    await tapPrimary(l10n.onboardingGetStarted);
    await tapPrimary(l10n.onboardingStartFresh);
    await tapPrimary(l10n.commonNext);
    await tapPrimary(l10n.onboardingSkipSignIn);
    expect(Get.currentRoute, '/onboarding');
    expect(Get.previousRoute, '/settings');
    await tapPrimary(l10n.onboardingStartUsing);
    await tester.runAsync(
      () => Future<void>.delayed(const Duration(milliseconds: 100)),
    );
    await tester.pumpAndSettle();

    expect(
      GStorage.localCache.get(LocalCacheKey.onboardingVersion),
      1,
    );
    expect(find.text('Settings marker'), findsOneWidget);

    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump();
    Get.reset();
  });
}
