import 'dart:async';

import 'package:ex_piliplus/common/widgets/progress_bar/audio_video_progress_bar.dart';
import 'package:ex_piliplus/l10n/generated/app_localizations.dart';
import 'package:ex_piliplus/main.dart' as app;
import 'package:ex_piliplus/models/common/app_language.dart';
import 'package:ex_piliplus/models/common/nav_bar_config.dart';
import 'package:ex_piliplus/pages/main/controller.dart';
import 'package:ex_piliplus/pages/main/view.dart';
import 'package:ex_piliplus/pages/mine/view.dart';
import 'package:ex_piliplus/pages/onboarding/view.dart';
import 'package:ex_piliplus/pages/root/view.dart';
import 'package:ex_piliplus/pages/setting/view.dart';
import 'package:ex_piliplus/pages/video/view.dart';
import 'package:ex_piliplus/plugin/pl_player/controller.dart';
import 'package:ex_piliplus/plugin/pl_player/view/view.dart';
import 'package:ex_piliplus/plugin/pl_player/widgets/gif_record_dialog.dart';
import 'package:ex_piliplus/plugin/pl_player/widgets/play_pause_btn.dart';
import 'package:ex_piliplus/utils/storage.dart';
import 'package:ex_piliplus/utils/storage_key.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets(
    'fresh install navigates settings and plays/exports a public video',
    (tester) async {
      await tester.runAsync(() => app.startApp(useScaledBinding: false));
      await tester.pump();

      await _waitFor(tester, find.byType(OnboardingPage));
      var l10n = _localizations(tester);
      await _tapText(tester, l10n.onboardingGetStarted);
      l10n = _localizations(tester);
      await _tapText(tester, l10n.onboardingStartFresh, last: true);
      l10n = _localizations(tester);
      await _tapText(tester, l10n.commonNext);
      l10n = _localizations(tester);
      await _tapText(tester, l10n.onboardingSkipSignIn, last: true);
      l10n = _localizations(tester);
      await _tapText(tester, l10n.onboardingStartUsing);
      await _waitFor(tester, find.byType(MainApp));

      final mainController = Get.find<MainController>();
      l10n = _localizations(tester);
      await _tapText(tester, l10n.navigationFeed);
      await _waitForCondition(
        tester,
        () => mainController.selectedIndex.value ==
            mainController.navigationBars.indexOf(NavigationBarType.dynamics),
        description: 'feed tab navigation',
      );
      await _tapText(tester, _localizations(tester).navigationMe);
      await _waitFor(tester, find.byType(MinePage));
      await _waitForCondition(
        tester,
        () => mainController.selectedIndex.value ==
            mainController.navigationBars.indexOf(NavigationBarType.mine),
        description: 'me tab navigation',
      );
      l10n = _localizations(tester);
      await tester.tap(find.byTooltip(l10n.settingsTitle));
      await tester.pump();
      await _waitFor(tester, find.byType(SettingPage));

      l10n = _localizations(tester);
      await _tapText(tester, l10n.settingsExPiliPlusTitle);
      await _waitFor(tester, find.text(l10n.settingsAppLanguage));

      l10n = _localizations(tester);
      await _tapText(tester, l10n.settingsAppLanguage);
      final englishLabel = AppLanguage.english.localizedName(l10n);
      await _tapText(tester, englishLabel);
      await _waitFor(
        tester,
        find.text(
          AppLocalizations.of(
            tester.element(find.byType(RootPage)),
          ).settingsAppLanguage,
        ),
      );
      l10n = _localizations(tester);
      expect(l10n.settingsTitle, 'Settings');

      final gifSetting = find.text(l10n.settingsEnableGifRecord);
      await tester.ensureVisible(gifSetting);
      await tester.tap(gifSetting);
      await tester.pump();
      await _waitForCondition(
        tester,
        () => GStorage.setting.get(SettingBoxKey.showFsGifBtn) == false,
        description: 'GIF setting turns off',
      );
      await tester.tap(gifSetting);
      await tester.pump();
      await _waitForCondition(
        tester,
        () => GStorage.setting.get(SettingBoxKey.showFsGifBtn) == true,
        description: 'GIF setting turns back on',
      );

      await tester.pageBack();
      await tester.pump();
      await tester.pageBack();
      await tester.pump();
      await _waitFor(tester, find.byType(MainApp));
      l10n = _localizations(tester);
      await tester.tap(find.byIcon(Icons.search_outlined).first);
      await tester.pump();
      final searchField = find.byType(TextField).first;
      await _waitFor(tester, searchField);
      await tester.enterText(searchField, 'BV1gA411M7RN');
      await tester.testTextInput.receiveAction(TextInputAction.search);
      await tester.pump();

      await _waitFor(
        tester,
        find.byType(VideoDetailPageV),
        timeout: const Duration(seconds: 120),
      );
      l10n = _localizations(tester);
      final manualPlay = find.byTooltip(l10n.playerPlay);
      await _waitFor(tester, manualPlay);
      await tester.tap(manualPlay);
      await tester.pump();
      await _waitForCondition(
        tester,
        () {
          final player = PlPlayerController.instance?.videoPlayerController;
          return player != null &&
              player.state.playing &&
              player.state.duration > const Duration(seconds: 10) &&
              player.state.width > 0;
        },
        description: 'native Android player opens and decodes the public video',
        timeout: const Duration(seconds: 150),
      );

      final player = PlPlayerController.instance!;
      await player.setVolume(0, showIndicator: false);
      expect(player.volume.value, 0);
      await _showPlayerControls(tester);
      await tester.tap(find.byType(PlayOrPauseButton));
      await _waitForCondition(
        tester,
        () => !player.videoPlayerController!.state.playing,
        description: 'pause control pauses native playback',
      );
      await tester.tap(find.byType(PlayOrPauseButton));
      await _waitForCondition(
        tester,
        () => player.videoPlayerController!.state.playing,
        description: 'play control resumes native playback',
      );

      l10n = _localizations(tester);
      final speedButton = find.byTooltip(l10n.playerPlaybackSpeed);
      await _waitFor(tester, speedButton);
      await tester.tap(speedButton);
      await tester.pump();
      await _tapText(tester, '1.5X');
      await _waitForCondition(
        tester,
        () => player.playbackSpeed == 1.5,
        description: 'playback speed menu changes native playback speed',
      );

      await _waitFor(tester, find.byType(ProgressBar));
      final progressRect = tester.getRect(find.byType(ProgressBar));
      await tester.tapAt(
        Offset(
          progressRect.left + progressRect.width * 0.65,
          progressRect.center.dy,
        ),
      );
      await _waitForCondition(
        tester,
        () => player.videoPlayerController!.state.position.inSeconds > 2,
        description: 'progress bar seeks the native player',
      );

      await _showPlayerControls(tester);
      l10n = _localizations(tester);
      final fullScreen = find.byTooltip(l10n.playerFullScreen);
      await _waitFor(tester, fullScreen);
      await tester.tap(fullScreen);
      await _waitForCondition(
        tester,
        () => player.isFullScreen.value,
        description: 'player enters full screen',
      );
      await _showPlayerControls(tester);
      l10n = _localizations(tester);
      final gifButton = find.byTooltip(l10n.playerGifRecord);
      await _waitFor(tester, gifButton);
      await tester.tap(gifButton);
      await _waitFor(tester, find.byType(GifRecordDialog));

      await _tapText(tester, '3s');
      await tester.tap(find.text('720p'));
      await tester.pump();
      await _tapText(tester, '480p');
      await tester.tap(find.text('12 FPS'));
      await tester.pump();
      await _tapText(tester, '10 FPS');

      l10n = _localizations(tester);
      final exportButton = find.byKey(const ValueKey('gif-export-button'));
      await tester.ensureVisible(exportButton);
      await tester.tap(exportButton);
      await tester.pump();
      await _waitForCondition(
        tester,
        () => find.byType(GifRecordDialog).evaluate().isEmpty,
        description: 'GIF export options are accepted',
      );
      await _waitFor(
        tester,
        find.text(l10n.commonSaved),
        timeout: const Duration(seconds: 180),
      );
      await tester.pump();
    },
    timeout: const Timeout(Duration(minutes: 20)),
  );
}

AppLocalizations _localizations(WidgetTester tester) =>
    AppLocalizations.of(tester.element(find.byType(RootPage)));

Future<void> _tapText(
  WidgetTester tester,
  String value, {
  bool last = false,
}) async {
  final candidates = find.text(value);
  expect(candidates, findsWidgets, reason: 'Expected visible text: $value');
  final target = last ? candidates.last : candidates.first;
  await tester.ensureVisible(target);
  await tester.tap(target);
  await tester.pump();
  await Future<void>.delayed(const Duration(milliseconds: 300));
  await tester.pump();
}

Future<void> _waitFor(
  WidgetTester tester,
  Finder finder, {
  Duration timeout = const Duration(seconds: 30),
}) async {
  await _waitForCondition(
    tester,
    () => finder.evaluate().isNotEmpty,
    description: finder.toString(),
    timeout: timeout,
  );
}

Future<void> _waitForCondition(
  WidgetTester tester,
  bool Function() condition, {
  required String description,
  Duration timeout = const Duration(seconds: 30),
}) async {
  final deadline = DateTime.now().add(timeout);
  while (DateTime.now().isBefore(deadline)) {
    if (condition()) return;
    await tester.pump(const Duration(milliseconds: 250));
    await Future<void>.delayed(const Duration(milliseconds: 250));
  }
  fail('Timed out waiting for $description');
}

Future<void> _showPlayerControls(WidgetTester tester) async {
  final player = find.byType(PLVideoPlayer);
  await _waitFor(tester, player);
  final rect = tester.getRect(player);
  await tester.tapAt(rect.center);
  await tester.pump();
  await Future<void>.delayed(const Duration(milliseconds: 300));
  await tester.pump();
}
