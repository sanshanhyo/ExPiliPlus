import 'dart:async';

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
                        // The runner takes an Android emulator screenshot while
                        // this production page is still on screen.
                        // ignore: avoid_print
                        print(
                          'AICU_REAL_WEBVIEW_SCREENSHOT_READY '
                          'host=${uri?.host ?? "<null>"} '
                          'path=${uri?.path ?? "<null>"} uid=2',
                        );
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
      await tester.pump(const Duration(milliseconds: 500));
      expect(find.text('AICU 评论查询'), findsOneWidget);
      expect(find.byType(InAppWebView), findsOneWidget);

      late final Uri? loadedUri;
      late final InAppWebViewController controller;
      try {
        controller = await controllerReady.future.timeout(
          const Duration(seconds: 90),
          onTimeout: () => throw TimeoutException(
            'Android WebView controller was not created',
          ),
        );
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

      // Let the host-side screenshot command capture the loaded application
      // before exercising scrolling or navigating away.
      await tester.runAsync(
        () => Future<void>.delayed(const Duration(seconds: 3)),
      );

      final scrollMetrics = await controller.evaluateJavascript(
        source: '''(() => {
          const page = document.scrollingElement || document.documentElement;
          const maxScroll = Math.max(0, page.scrollHeight - page.clientHeight);
          window.scrollTo(0, maxScroll);
          return JSON.stringify({
            scrollHeight: page.scrollHeight,
            clientHeight: page.clientHeight,
            scrollTop: page.scrollTop
          });
        })()''',
      );
      expect(scrollMetrics, isNotNull);
      // This reports only page geometry, not AICU page text or queried data.
      // ignore: avoid_print
      print('AICU real WebView scroll metrics: $scrollMetrics');

      final backTooltip = MaterialLocalizations.of(
        tester.element(find.text('AICU 评论查询')),
      ).backButtonTooltip;
      expect(find.byTooltip(backTooltip), findsOneWidget);
      await tester.tap(find.byTooltip(backTooltip));
      await tester.pump(const Duration(milliseconds: 500));
      expect(find.byKey(const ValueKey('open-aicu-uid-2')), findsOneWidget);
      // ignore: avoid_print
      print('AICU real WebView route returned to the app host screen');
    },
    timeout: const Timeout(Duration(minutes: 6)),
  );
}
