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
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets(
    'loads AICU UID 2 inside the production Android WebView page',
    (tester) async {
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
          home: AicuLookupPage(
            initialUri: target,
            onWebViewCreatedForTesting: (controller) {
              if (!controllerReady.isCompleted) {
                controllerReady.complete(controller);
              }
            },
            onPageLoadedForTesting: (uri) {
              if (!pageLoaded.isCompleted) pageLoaded.complete(uri);
            },
          ),
        ),
      );

      expect(find.text('AICU 评论查询'), findsOneWidget);
      expect(find.byType(InAppWebView), findsOneWidget);

      late final Uri? loadedUri;
      try {
        await controllerReady.future.timeout(
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
        await _captureRealDeviceScreenshot(tester, binding);
        fail('AICU Android WebView load failed: $error');
      }

      await _captureRealDeviceScreenshot(tester, binding);
      final pageUri = loadedUri;
      expect(pageUri, isNotNull);
      final resolvedUri = pageUri!;
      expect(AicuUrlPolicy.isAllowedTopLevel(resolvedUri), isTrue);
      expect(resolvedUri.queryParameters['uid'], '2');

      // Keep diagnostics deliberately limited to non-personal page metadata.
      // No page body, cookies, or Bilibili account data are logged.
      // ignore: avoid_print
      print(
        'AICU Android WebView loaded official host=${resolvedUri.host}; '
        'path=${resolvedUri.path}; uid=2; screenshot=uid-2-android-webview',
      );
    },
    timeout: const Timeout(Duration(minutes: 6)),
  );
}

Future<void> _captureRealDeviceScreenshot(
  WidgetTester tester,
  IntegrationTestWidgetsFlutterBinding binding,
) async {
  await binding.convertFlutterSurfaceToImage();
  await tester.pump();
  final bytes = await binding.takeScreenshot('uid-2-android-webview');
  expect(bytes.length, greaterThan(8));
  expect(bytes.take(8).toList(), <int>[137, 80, 78, 71, 13, 10, 26, 10]);
}
