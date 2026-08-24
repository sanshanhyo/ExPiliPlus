import 'package:ex_piliplus/l10n/generated/app_localizations.dart';
import 'package:ex_piliplus/plugin/pl_player/widgets/gif_record_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';

class _FakePlayer implements NativePlayer {
  @override
  dynamic noSuchMethod(Invocation invocation) => null;
}

class _FakeVideoController extends PlatformVideoController {
  _FakeVideoController(Player player)
    : super(player, const VideoControllerConfiguration());

  @override
  Future<void> setSize({int? width, int? height}) async {}
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late VideoController videoController;

  setUp(() {
    videoController = _FakeVideoController(_FakePlayer());
  });

  Widget host({required Size size}) {
    return MaterialApp(
      locale: const Locale('zh'),
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      home: MediaQuery(
        data: MediaQueryData(size: size),
        child: Scaffold(
          body: GifRecordDialog(
            videoController: videoController,
            duration: 20,
            initialPosition: 4,
            sourceUrls: const {
              GifResolution.p480: 'https://example.com/480.m4s',
              GifResolution.p720: 'https://example.com/720.m4s',
            },
            videoPreview: const ColoredBox(color: Colors.black),
          ),
        ),
      ),
    );
  }

  testWidgets('uses the wide three-column layout without removed copy', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(1024, 720));
    await tester.pumpWidget(host(size: const Size(1024, 720)));
    await tester.pump();

    expect(find.byKey(const ValueKey('gif-preview')), findsOneWidget);
    expect(find.byKey(const ValueKey('gif-options')), findsOneWidget);
    expect(find.byKey(const ValueKey('gif-actions')), findsOneWidget);
    expect(find.byKey(const ValueKey('gif-export-button')), findsOneWidget);
    expect(find.byKey(const ValueKey('gif-cancel-button')), findsOneWidget);
    expect(find.text('截取 GIF'), findsNothing);
    expect(find.textContaining('不包含音频'), findsNothing);
  });

  testWidgets('keeps the preview and options usable on a narrow surface', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(390, 844));
    await tester.pumpWidget(host(size: const Size(390, 844)));
    await tester.pump();

    expect(find.byKey(const ValueKey('gif-preview')), findsOneWidget);
    expect(find.byKey(const ValueKey('gif-options')), findsOneWidget);
    expect(find.byKey(const ValueKey('gif-export-button')), findsOneWidget);
    expect(find.byKey(const ValueKey('gif-cancel-button')), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
