import 'dart:async';
import 'dart:io';

import 'package:ex_piliplus/l10n/app_localization_delegates.dart';
import 'package:ex_piliplus/l10n/generated/app_localizations.dart';
import 'package:ex_piliplus/pages/aicu_lookup/view.dart';
import 'package:ex_piliplus/utils/aicu_url_policy.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:integration_test/integration_test.dart';
import 'package:material_ui/material_ui.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets(
    'loads AICU UID 2 in the Android WebView and closes the page safely',
    (tester) async {
      // The Android integration-test binding can start with a zero-sized
      // Flutter view in the headless emulator. Match the runner's 320x640
      // display so real hit-testing and the platform WebView have a viewport.
      tester.view.devicePixelRatio = 1;
      tester.view.physicalSize = const Size(320, 640);
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      final target = AicuUrlPolicy.replyForUid(2)!;
      final controllerReady = Completer<InAppWebViewController>();
      final pageLoaded = Completer<Uri?>();

      await tester.pumpWidget(
        GetMaterialApp(
          debugShowCheckedModeBanner: false,
          locale: const Locale('zh'),
          localizationsDelegates: appLocalizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          theme: ThemeData.dark(useMaterial3: true),
          home: Scaffold(
            body: Center(
              child: FilledButton(
                key: const ValueKey('open-aicu-uid-2'),
                onPressed: () => Get.to<void>(
                  () => AicuLookupPage(
                    initialUri: target,
                    onWebViewCreatedForTesting: (controller) {
                      // ignore: avoid_print
                      print('AICU Android WebView controller created');
                      if (!controllerReady.isCompleted) {
                        controllerReady.complete(controller);
                      }
                    },
                    onPageLoadedForTesting: (uri) {
                      // Log only the public host/path and the explicitly
                      // authorized test UID; never log page text or cookies.
                      // ignore: avoid_print
                      print(
                        'AICU real WebView load stop: '
                        'host=${uri?.host ?? "<null>"}; '
                        'path=${uri?.path ?? "<null>"}; '
                        'uid=${uri?.queryParameters["uid"] ?? "<none>"}',
                      );
                      if (!pageLoaded.isCompleted) {
                        pageLoaded.complete(uri);
                      }
                    },
                  ),
                ),
                child: const Text('打开真实 AICU UID 2'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.byKey(const ValueKey('open-aicu-uid-2')));
      late final Uri? loadedUri;
      late final InAppWebViewController controller;
      try {
        controller = await controllerReady.future.timeout(
          const Duration(seconds: 90),
          onTimeout: () => throw TimeoutException(
            'Android WebView controller was not created',
          ),
        );
        expect(find.byType(AicuLookupPage), findsOneWidget);
        expect(find.byType(InAppWebView), findsOneWidget);
        loadedUri = await pageLoaded.future.timeout(
          const Duration(seconds: 180),
          onTimeout: () => throw TimeoutException(
            'AICU did not finish loading in Android WebView within 180s',
          ),
        );
      } catch (error) {
        fail('AICU Android WebView load failed: $error');
      }

      final pageUri = loadedUri;
      expect(pageUri, isNotNull);
      final resolvedUri = pageUri!;
      expect(AicuUrlPolicy.isAllowedTopLevel(resolvedUri), isTrue);
      expect(resolvedUri.queryParameters['uid'], '2');
      expect(find.text('AICU 评论查询'), findsOneWidget);

      Future<bool> captureWithRunner(String purpose) async {
        final captureAck = File(
          '${Directory.systemTemp.path}/aicu-webview-capture-ack-'
          '${DateTime.now().microsecondsSinceEpoch}',
        );
        // ignore: avoid_print
        print(
          'AICU_REAL_WEBVIEW_CAPTURE_REQUESTED '
          'purpose=$purpose path=${captureAck.path}',
        );
        final captured = await tester.runAsync(() async {
          final deadline = DateTime.now().add(const Duration(seconds: 20));
          while (DateTime.now().isBefore(deadline)) {
            if (await captureAck.exists()) return true;
            await Future<void>.delayed(const Duration(milliseconds: 100));
          }
          return false;
        });
        return captured == true;
      }

      // A load-stop callback alone can also happen on a Cloudflare challenge
      // page. Wait for the site's own title before asking the runner to save
      // the screenshot. Do not log the title because it may contain account
      // display data.
      final hasAicuPageTitle = await tester.runAsync(() async {
        final deadline = DateTime.now().add(const Duration(seconds: 45));
        while (DateTime.now().isBefore(deadline)) {
          final title = await controller.getTitle().timeout(
            const Duration(seconds: 5),
            onTimeout: () => null,
          );
          final normalizedTitle = title?.toLowerCase() ?? '';
          if (normalizedTitle.contains('aicu') ||
              (title?.contains('查评论') ?? false)) {
            return true;
          }
          await Future<void>.delayed(const Duration(seconds: 1));
        }
        return false;
      });
      if (!hasAicuPageTitle) {
        // Preserve a diagnostic image of the still-open WebView to distinguish
        // a real result page from an intermediary/challenge page. This image
        // is not treated as a successful AICU screenshot and no challenge is
        // clicked or bypassed.
        final diagnosticCaptured = await captureWithRunner('diagnostic');
        // ignore: avoid_print
        print(
          'AICU_REAL_WEBVIEW_DIAGNOSTIC_CAPTURED '
          'captured=$diagnosticCaptured',
        );
        fail(
          'The real WebView did not expose the AICU result-page title; '
          'a load-stop URL alone is not sufficient. '
          'Diagnostic screenshot captured: $diagnosticCaptured.',
        );
      }
      // ignore: avoid_print
      print('AICU_REAL_WEBVIEW_PAGE_TITLE_VERIFIED');

      // The host runner captures the native emulator display. Keep this route
      // mounted until it acknowledges that capture, so the screenshot cannot
      // race with the subsequent scroll/back actions and show the test home.
      // ignore: avoid_print
      print(
        'AICU_REAL_WEBVIEW_SCREENSHOT_READY '
        'host=${resolvedUri.host} path=${resolvedUri.path} uid=2',
      );
      final screenshotCaptured = await captureWithRunner('verified');
      expect(
        screenshotCaptured,
        isTrue,
        reason: 'The Android runner did not acknowledge the in-WebView capture.',
      );
      // ignore: avoid_print
      print('AICU_REAL_WEBVIEW_SCREENSHOT_CAPTURED');

      // Scroll through the native Android WebView API instead of executing
      // JavaScript in the third-party page; a renderer crash must fail promptly
      // rather than hold flutter drive until the entire test timeout.
      Object? scrollFailure;
      try {
        final contentHeight = await tester.runAsync(
          () => controller.getContentHeight().timeout(
            const Duration(seconds: 10),
            onTimeout: () => throw TimeoutException(
              'Timed out reading AICU WebView content height',
            ),
          ),
        );
        if (contentHeight == null) {
          throw TimeoutException(
            'AICU WebView did not return its content height',
          );
        }
        final scrollCompleted = await tester.runAsync(() async {
          await controller.scrollBy(x: 0, y: 480).timeout(
            const Duration(seconds: 10),
            onTimeout: () => throw TimeoutException(
              'Timed out scrolling the AICU Android WebView',
            ),
          );
          return true;
        });
        if (scrollCompleted != true) {
          throw TimeoutException('AICU WebView scroll did not complete');
        }
        final scrollY = await tester.runAsync(
          () => controller.getScrollY().timeout(
            const Duration(seconds: 10),
            onTimeout: () => throw TimeoutException(
              'Timed out reading AICU WebView scroll position',
            ),
          ),
        );
        if (scrollY == null) {
          throw TimeoutException(
            'AICU WebView did not return its scroll position',
          );
        }
        // This reports only page geometry, not page text or queried data.
        // ignore: avoid_print
        print(
          'AICU real WebView scroll metrics: '
          'contentHeight=$contentHeight; scrollY=$scrollY',
        );
        expect(scrollY, isNotNull);
        expect(scrollY, greaterThan(0));
        // ignore: avoid_print
        print('AICU_REAL_WEBVIEW_SCROLL_VERIFIED scrollY=$scrollY');
      } catch (error) {
        scrollFailure = error;
        // The production page should replace a dead Android renderer with its
        // retry panel. Log the state before leaving so the captured screenshot
        // is not mistaken for proof that later browser interactions worked.
        // ignore: avoid_print
        print(
          'AICU_REAL_WEBVIEW_SCROLL_FAILED '
          'webViewVisible=${find.byType(InAppWebView).evaluate().length == 1}; '
          'error=$error',
        );
      }

      final backTooltip = MaterialLocalizations.of(
        tester.element(find.byType(AicuLookupPage)),
      ).backButtonTooltip;
      expect(find.byTooltip(backTooltip), findsOneWidget);
      await tester.tap(find.byTooltip(backTooltip));
      await tester.pump(const Duration(milliseconds: 500));
      expect(find.byKey(const ValueKey('open-aicu-uid-2')), findsOneWidget);
      // ignore: avoid_print
      print('AICU_REAL_WEBVIEW_ROUTE_CLOSED');
      if (scrollFailure != null) {
        fail('AICU WebView scroll failed before route close: $scrollFailure');
      }
    },
    timeout: const Timeout(Duration(minutes: 6)),
  );
}
