import 'dart:async';
import 'dart:io';
import 'dart:math' as math;
import 'dart:ui';

import 'package:ex_piliplus/common/widgets/progress_bar/audio_video_progress_bar.dart';
import 'package:ex_piliplus/l10n/generated/app_localizations.dart';
import 'package:ex_piliplus/main.dart' as app;
import 'package:ex_piliplus/models/common/app_language.dart';
import 'package:ex_piliplus/models/common/nav_bar_config.dart';
import 'package:ex_piliplus/pages/home/view.dart';
import 'package:ex_piliplus/pages/home/widgets/home_search_bar.dart';
import 'package:ex_piliplus/pages/main/controller.dart';
import 'package:ex_piliplus/pages/main/view.dart';
import 'package:ex_piliplus/pages/mine/view.dart';
import 'package:ex_piliplus/pages/onboarding/view.dart';
import 'package:ex_piliplus/pages/root/view.dart';
import 'package:ex_piliplus/pages/search/view.dart';
import 'package:ex_piliplus/pages/setting/common_setting.dart';
import 'package:ex_piliplus/pages/setting/view.dart';
import 'package:ex_piliplus/pages/video/view.dart';
import 'package:ex_piliplus/pages/video/widgets/header_control.dart';
import 'package:ex_piliplus/pages/video/widgets/shutdown_timer_indicators.dart';
import 'package:ex_piliplus/plugin/pl_player/controller.dart';
import 'package:ex_piliplus/plugin/pl_player/view/view.dart';
import 'package:ex_piliplus/plugin/pl_player/widgets/gif_record_dialog.dart';
import 'package:ex_piliplus/plugin/pl_player/widgets/play_pause_btn.dart';
import 'package:ex_piliplus/services/shutdown_timer_service.dart';
import 'package:ex_piliplus/utils/path_utils.dart' show tmpDirPath;
import 'package:ex_piliplus/utils/storage.dart';
import 'package:ex_piliplus/utils/storage_key.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:integration_test/integration_test.dart';
import 'package:material_ui/material_ui.dart' as mui;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets(
    'fresh install navigates settings and plays/exports a public video',
    (tester) async {
      await tester.runAsync(() async {
        // The production crash reporter replaces the global handlers. Keep the
        // integration binding's handlers after startup so asynchronous app
        // errors are reported as test failures instead of being diverted.
        final flutterErrorHandler = FlutterError.onError;
        final platformErrorHandler = PlatformDispatcher.instance.onError;
        try {
          await app.startApp(useScaledBinding: false);
        } finally {
          FlutterError.onError = flutterErrorHandler;
          PlatformDispatcher.instance.onError = platformErrorHandler;
        }
      });
      await tester.pump();

      await _waitFor(tester, find.byType(OnboardingPage));
      var l10n = _localizations(tester);
      await _tapText(tester, l10n.onboardingGetStarted);
      l10n = _localizations(tester);
      await _tapUnique(
        tester,
        find.ancestor(
          of: find.text(l10n.onboardingStartFresh),
          matching: find.byType(mui.FilledButton),
        ),
        description: 'onboarding start fresh action',
      );
      l10n = _localizations(tester);
      await _tapText(tester, l10n.commonNext);
      l10n = _localizations(tester);
      await _tapUnique(
        tester,
        find.ancestor(
          of: find.text(l10n.onboardingSkipSignIn),
          matching: find.byType(mui.FilledButton),
        ),
        description: 'onboarding skip sign in action',
      );
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
      await _tapUnique(
        tester,
        find.byTooltip(l10n.settingsTitle),
        description: 'open settings',
      );
      await _waitFor(tester, find.byType(SettingPage));

      l10n = _localizations(tester);
      await _tapText(tester, l10n.settingsExPiliPlusTitle);
      await _waitFor(tester, find.byType(CommonSetting));
      await _waitFor(tester, find.text(l10n.settingsAppLanguage));

      l10n = _localizations(tester);
      await _tapText(tester, l10n.settingsAppLanguage);
      final englishLabel = AppLanguage.english.localizedName(l10n);
      await _tapText(tester, englishLabel);
      await _waitForCondition(
        tester,
        () => _localizations(tester).localeName == 'en',
        description: 'active settings page switches to English',
      );
      l10n = _localizations(tester);
      expect(find.text(l10n.settingsAppLanguage), findsWidgets);
      expect(l10n.settingsTitle, 'Settings');

      final gifSetting = find.text(l10n.settingsEnableGifRecord);
      await _tapUnique(
        tester,
        gifSetting,
        description: 'disable the GIF shortcut setting',
      );
      await _waitForCondition(
        tester,
        () => GStorage.setting.get(SettingBoxKey.showFsGifBtn) == false,
        description: 'GIF setting turns off',
      );
      await _tapUnique(
        tester,
        gifSetting,
        description: 'restore the GIF shortcut setting',
      );
      await _waitForCondition(
        tester,
        () => GStorage.setting.get(SettingBoxKey.showFsGifBtn) == true,
        description: 'GIF setting turns back on',
      );

      await _tapScopedBackButton(
        tester,
        currentPage: find.byType(CommonSetting),
        previousPage: find.byType(SettingPage),
        description: 'return from ExPiliPlus settings to settings list',
      );
      await _tapScopedBackButton(
        tester,
        currentPage: find.byType(SettingPage),
        previousPage: find.byType(MainApp),
        description: 'return from settings to the main app',
      );
      l10n = _localizations(tester);
      expect(
        mainController.navigationBars[mainController.selectedIndex.value],
        NavigationBarType.mine,
        reason: 'returning from settings should preserve the selected tab',
      );
      await _tapText(tester, l10n.navigationHome);
      await _waitForCondition(
        tester,
        () => mainController.navigationBars[mainController.selectedIndex.value] ==
            NavigationBarType.home,
        description: 'switch from Me back to Home before searching',
      );
      l10n = _localizations(tester);
      expect(l10n.localeName, 'en', reason: 'app language remains English');
      expect(l10n.commonSearch, 'Search', reason: 'English search label');
      final homePage = find.byType(HomePage);
      await _waitFor(tester, homePage);
      expect(homePage, findsOneWidget, reason: 'one active Home page');
      final searchEntry = find.descendant(
        of: find.byType(HomePage),
        matching: find.byType(HomeSearchBar),
      );
      await _waitFor(tester, searchEntry);
      await _tapUnique(
        tester,
        searchEntry,
        description: 'tap the visible Home search bar',
      );
      await _waitFor(tester, find.byType(SearchPage));
      debugPrint('ANDROID_SMOKE_PHASE=local-search-navigation-passed');
      final searchField = find.descendant(
        of: find.byType(SearchPage),
        matching: find.byType(mui.TextField),
      );
      await _waitFor(tester, searchField);
      expect(searchField, findsOneWidget, reason: 'one search field on search page');
      await tester.enterText(
        searchField,
        'https://www.bilibili.com/video/BV1gA411M7RN',
      );
      await tester.testTextInput.receiveAction(TextInputAction.search);
      await tester.pump();
      debugPrint('ANDROID_SMOKE_PHASE=public-video-link-submitted');

      final videoDetail = find.byType(VideoDetailPageV);
      await _waitForCondition(
        tester,
        () => videoDetail.evaluate().isNotEmpty,
        description:
            'Bilibili video detail route opens for BV1gA411M7RN; public network is required',
        timeout: const Duration(seconds: 120),
      );
      expect(videoDetail, findsOneWidget, reason: 'one active video detail page');
      debugPrint('ANDROID_SMOKE_PHASE=public-video-detail-opened');
      l10n = _localizations(tester);
      final manualPlay = find.descendant(
        of: videoDetail,
        matching: find.byTooltip(l10n.playerPlay),
      );
      await _tapUnique(
        tester,
        manualPlay,
        description: 'start video playback from the detail page',
      );
      final playerController = PlPlayerController.instance!;
      await _waitForCondition(
        tester,
        () => playerController.videoPlayerController != null,
        description: 'native player controller initializes for public video',
      );
      final nativePlayer = playerController.videoPlayerController!;
      final playerErrors = <String>[];
      final bufferingEvents = <bool>[];
      final playerErrorSubscription = nativePlayer.stream.error.listen((event) {
        if (playerErrors.length < 20) {
          playerErrors.add(_redactDiagnosticUrls(event));
        }
      });
      final bufferingSubscription = nativePlayer.stream.buffering.listen(
        (event) {
          if (bufferingEvents.length < 20) {
            bufferingEvents.add(event);
          }
        },
      );
      final playerLogSubscription = nativePlayer.stream.log.listen((event) {
        if ((event.level == 'error' || event.level == 'fatal') &&
            playerErrors.length < 20) {
          playerErrors.add(
            _redactDiagnosticUrls(
              '${event.level}: ${event.prefix}: ${event.text}',
            ),
          );
        }
      });
      try {
        await _waitForCondition(
          tester,
          () => nativePlayer.state.playing &&
              nativePlayer.state.duration > const Duration(seconds: 10) &&
              nativePlayer.state.width > 0,
          description:
              'native Android player opens and decodes the public video',
          timeout: const Duration(seconds: 150),
        );
        final visiblePlayer = find.byType(PLVideoPlayer);
        final minimumPlayerHeight =
            tester.view.physicalSize.shortestSide /
            tester.view.devicePixelRatio /
            (16 / 9);
        await _waitForCondition(
          tester,
          () => visiblePlayer.evaluate().length == 1 &&
              tester.getRect(visiblePlayer).height >= minimumPlayerHeight * 0.9,
          description: 'video player expands to its portrait control area',
          timeout: const Duration(seconds: 15),
        );
        final state = nativePlayer.state;
        debugPrint(
          'ANDROID_PLAYER_READY_STATE '
          'playing=${state.playing} '
          'duration_ms=${state.duration.inMilliseconds} '
          'position_ms=${state.position.inMilliseconds} '
          'width=${state.width} height=${state.height} '
          'buffering_events=${bufferingEvents.join("|")} '
          'errors=${playerErrors.join(" | ")}',
        );
      } catch (_) {
        final state = nativePlayer.state;
        debugPrint(
          'ANDROID_PLAYER_DIAGNOSTICS '
          'playing=${state.playing} '
          'duration_ms=${state.duration.inMilliseconds} '
          'position_ms=${state.position.inMilliseconds} '
          'width=${state.width} height=${state.height} '
          'buffering_events=${bufferingEvents.join("|")} '
          'errors=${playerErrors.join(" | ")}',
        );
        rethrow;
      } finally {
        await playerErrorSubscription.cancel();
        await bufferingSubscription.cancel();
        await playerLogSubscription.cancel();
      }
      debugPrint('ANDROID_SMOKE_PHASE=native-player-decoded-video');

      final player = playerController;
      await player.setVolume(0, showIndicator: false);
      expect(player.volume.value, 0);
      await _showPlayerControls(tester);
      await _tapUnique(
        tester,
        _playerControls(find.byType(PlayOrPauseButton)),
        description: 'pause native playback',
      );
      await _waitForCondition(
        tester,
        () => !player.videoPlayerController!.state.playing,
        description: 'pause control pauses native playback',
      );
      await _tapUnique(
        tester,
        _playerControls(find.byType(PlayOrPauseButton)),
        description: 'resume native playback',
      );
      await _waitForCondition(
        tester,
        () => player.videoPlayerController!.state.playing,
        description: 'play control resumes native playback',
      );

      l10n = _localizations(tester);
      final speedButton = _playerControls(
        find.byTooltip(l10n.playerPlaybackSpeed),
      );
      await _tapUnique(
        tester,
        speedButton,
        description: 'open playback speed menu',
      );
      await _tapText(tester, '1.5X');
      await _waitForCondition(
        tester,
        () => player.playbackSpeed == 1.5,
        description: 'playback speed menu changes native playback speed',
      );

      await _showPlayerControls(tester);
      await _tapUnique(
        tester,
        _playerControls(find.byType(PlayOrPauseButton)),
        description: 'pause before seek verification',
      );
      await _waitForCondition(
        tester,
        () => !player.videoPlayerController!.state.playing,
        description: 'native playback pauses before seek verification',
      );
      final playerState = player.videoPlayerController!.state;
      final seekTarget = Duration(
        milliseconds: (playerState.duration.inMilliseconds * 0.65).round(),
      );
      final previousPosition = playerState.position;
      final seekTolerance = Duration(
        milliseconds: math.max(
          3000,
          (playerState.duration.inMilliseconds * 0.1).round(),
        ),
      );
      final progressBar = _playerControls(find.byType(ProgressBar));
      await _waitFor(tester, progressBar);
      expect(progressBar, findsOneWidget, reason: 'one active player progress bar');
      final progressRect = tester.getRect(progressBar);
      await tester.tapAt(
        Offset(
          progressRect.left + progressRect.width * 0.65,
          progressRect.center.dy,
        ),
      );
      await _waitForCondition(
        tester,
        () {
          final position = player.videoPlayerController!.state.position;
          return (position - seekTarget).inMilliseconds.abs() <=
                  seekTolerance.inMilliseconds &&
              (previousPosition - position).inMilliseconds.abs() >
                  seekTolerance.inMilliseconds;
        },
        description: 'progress bar seeks near the selected 65% position',
      );
      await _tapUnique(
        tester,
        _playerControls(find.byType(PlayOrPauseButton)),
        description: 'resume after seek verification',
      );
      await _waitForCondition(
        tester,
        () => player.videoPlayerController!.state.playing,
        description: 'native playback resumes after seek verification',
      );

      await _showPlayerControls(tester);
      l10n = _localizations(tester);
      await _tapUnique(
        tester,
        _headerControlButton(l10n.playerMoreSettings),
        description: 'open player settings for the timer list',
      );
      final sleepTimerTile = find.byType(ShutdownTimerListTile);
      await _tapUnique(
        tester,
        sleepTimerTile,
        description: 'open the sleep timer picker',
      );

      final fifteenMinutePreset = find.text(l10n.shutdownMinutes(15));
      await _tapUnique(
        tester,
        fifteenMinutePreset,
        description: 'set a fifteen minute sleep timer',
      );
      await _waitForCondition(
        tester,
        () => shutdownTimerService.isActive &&
            shutdownTimerService.countdown.value.isScheduled,
        description: 'sleep timer is scheduled from the video settings',
      );

      await _tapUnique(
        tester,
        _headerControlButton(l10n.playerMoreSettings),
        description: 'open player settings for the timer quick action',
      );
      final quickTimerAction = find.byType(ShutdownTimerQuickActionContent);
      await _waitFor(tester, quickTimerAction);
      final remainingLabel = l10n.statisticsRemaining(
        l10n.shutdownMinutes(
          shutdownTimerService.countdown.value.remainingMinutes,
        ),
      );
      final quickRemainingLabel = find.descendant(
        of: quickTimerAction,
        matching: find.text(remainingLabel),
      );
      await _waitFor(tester, quickRemainingLabel);
      await _captureCountdownScreenshot(tester, 'countdown_quick_bar');

      await tester.ensureVisible(sleepTimerTile);
      await tester.pump();
      final outsideRemainingLabel = find.descendant(
        of: sleepTimerTile,
        matching: find.text(remainingLabel),
      );
      await _waitFor(tester, outsideRemainingLabel);
      await _captureCountdownScreenshot(tester, 'countdown_outside_tile');

      await _tapUnique(
        tester,
        sleepTimerTile,
        description: 'reopen the sleep timer picker to cancel',
      );
      final disableTimer = find.text(l10n.commonDisabled);
      await _tapUnique(
        tester,
        disableTimer,
        description: 'cancel the sleep timer',
      );
      await _waitForCondition(
        tester,
        () => !shutdownTimerService.isActive &&
            !shutdownTimerService.countdown.value.isScheduled,
        description: 'sleep timer cancels after screenshot capture',
      );

      await _showPlayerControls(tester);
      l10n = _localizations(tester);
      final fullScreen = _playerControls(
        find.byTooltip(l10n.playerFullScreen),
      );
      await _tapUnique(
        tester,
        fullScreen,
        description: 'enter player full screen',
      );
      await _waitForCondition(
        tester,
        () => player.isFullScreen.value,
        description: 'player enters full screen',
      );
      await _showPlayerControls(tester);
      l10n = _localizations(tester);
      final gifButton = _playerControls(
        find.byTooltip(l10n.playerGifRecord),
      );
      await _tapUnique(
        tester,
        gifButton,
        description: 'open GIF recording options',
      );
      final gifDialog = find.byType(GifRecordDialog);
      await _waitFor(tester, gifDialog);
      expect(gifDialog, findsOneWidget, reason: 'one active GIF dialog');

      await _tapUnique(
        tester,
        find.byKey(const ValueKey('gif-cancel-button')),
        description: 'cancel GIF recording options',
      );
      await _waitForCondition(
        tester,
        () => find.byType(GifRecordDialog).evaluate().isEmpty,
        description: 'GIF recording dialog cancels without exporting',
      );
      await _showPlayerControls(tester);
      await _tapUnique(
        tester,
        gifButton,
        description: 'reopen GIF recording options',
      );
      await _waitFor(tester, gifDialog);
      expect(gifDialog, findsOneWidget, reason: 'one reopened GIF dialog');

      await _tapText(tester, '3s');
      await _tapUnique(tester, find.text('720p'), description: 'select 720p GIF');
      await _tapText(tester, '480p');
      await _tapUnique(
        tester,
        find.text('12 FPS'),
        description: 'select 12 FPS GIF',
      );
      await _tapText(tester, '10 FPS');

      l10n = _localizations(tester);
      final exportButton = find.byKey(const ValueKey('gif-export-button'));
      await _tapUnique(
        tester,
        exportButton,
        description: 'export GIF with selected options',
      );
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

String _redactDiagnosticUrls(String value) =>
    value.replaceAll(RegExp(r'https?://\S+'), '<redacted-url>');

AppLocalizations _localizations(WidgetTester tester) {
  // Settings and video details can be pushed above the RootPage route, so use
  // the current page's context. Prefer the most specific active page first.
  final candidates = <Finder>[
    find.byType(VideoDetailPageV),
    find.byType(CommonSetting),
    find.byType(SettingPage),
    find.byType(OnboardingPage),
    find.byType(MainApp),
    find.byType(RootPage),
  ];
  for (final finder in candidates) {
    final matches = finder.evaluate();
    if (matches.length == 1) {
      return AppLocalizations.of(tester.element(finder));
    }
    if (matches.length > 1) {
      throw TestFailure(
        'Ambiguous localization page ${finder.toString()} at '
        'GetX route ${Get.currentRoute}: ${matches.length} matches',
      );
    }
  }
  debugPrint('No localization context at GetX route ${Get.currentRoute}.');
  debugDumpApp();
  throw TestFailure(
    'No active app page provides a localization context. '
    'Page counts: ${candidates.map((finder) => finder.evaluate().length)}',
  );
}

Future<void> _tapText(WidgetTester tester, String value) async {
  final candidates = find.text(value);
  await _tapUnique(
    tester,
    candidates,
    description: 'tap text "$value"',
  );
}

Future<void> _tapUnique(
  WidgetTester tester,
  Finder finder, {
  required String description,
}) async {
  await _waitFor(tester, finder);
  expect(finder, findsOneWidget, reason: description);
  await tester.ensureVisible(finder);
  await tester.tap(finder);
  await tester.pump();
  await Future<void>.delayed(const Duration(milliseconds: 300));
  await tester.pump();
}

Future<void> _captureCountdownScreenshot(
  WidgetTester tester,
  String name,
) async {
  final binding = IntegrationTestWidgetsFlutterBinding.instance;
  await binding.convertFlutterSurfaceToImage();
  await tester.pump();
  final screenshot = await binding.takeScreenshot(name);
  expect(screenshot, isNotEmpty, reason: 'Expected screenshot bytes for $name');
  await tester.runAsync(() async {
    await File('$tmpDirPath/$name.png').writeAsBytes(screenshot, flush: true);
  });
  await const MethodChannel('plugins.flutter.io/integration_test')
      .invokeMethod<void>('revertFlutterImage');
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
  debugPrint(
    'Timed out waiting for $description at GetX route ${Get.currentRoute}.',
  );
  debugDumpApp();
  fail('Timed out waiting for $description');
}

Future<void> _tapScopedBackButton(
  WidgetTester tester, {
  required Finder currentPage,
  required Finder previousPage,
  required String description,
}) async {
  await _waitForCondition(
    tester,
    () => _isCurrentPage(tester, currentPage),
    description: 'active page before $description',
  );
  final pageContext = tester.element(currentPage);
  final backTooltip = MaterialLocalizations.of(pageContext).backButtonTooltip;
  final backButton = find.descendant(
    of: currentPage,
    matching: find.byTooltip(backTooltip),
  );
  await _waitFor(tester, backButton);
  await _tapUnique(
    tester,
    backButton,
    description: 'one scoped back button for $description',
  );
  await _waitForCondition(
    tester,
    () => _isCurrentPage(tester, previousPage),
    description: description,
  );
}

bool _isCurrentPage(WidgetTester tester, Finder page) {
  final elements = page.evaluate();
  if (elements.length != 1) return false;
  return ModalRoute.of(tester.element(page))?.isCurrent ?? false;
}

Future<void> _showPlayerControls(WidgetTester tester) async {
  final player = find.byType(PLVideoPlayer);
  await _waitFor(tester, player);
  expect(player, findsOneWidget, reason: 'one active PLVideoPlayer');
  final playPauseButton = _playerControls(find.byType(PlayOrPauseButton));
  if (playPauseButton.hitTestable().evaluate().isEmpty) {
    final rect = tester.getRect(player);
    await tester.tapAt(rect.center);
    await tester.pump();
    await Future<void>.delayed(const Duration(milliseconds: 300));
    await tester.pump();
  }
  await _waitForCondition(
    tester,
    () => playPauseButton.hitTestable().evaluate().length == 1,
    description: 'play/pause control is visible and hit-testable',
  );
  expect(playPauseButton, findsOneWidget, reason: 'one active play/pause control');
}

Finder _playerControls(Finder control) => find.descendant(
  of: find.byType(PLVideoPlayer),
  matching: control,
);

Finder _headerControlButton(String tooltip) => find.descendant(
  of: find.byType(HeaderControl),
  matching: find.byTooltip(tooltip),
);
