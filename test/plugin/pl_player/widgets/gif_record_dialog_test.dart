import 'package:ex_piliplus/l10n/generated/app_localizations.dart';
import 'package:ex_piliplus/plugin/pl_player/widgets/gif_record_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';

class _FakePlayer implements NativePlayer {
  @override
  Future<void> seek(Duration position, {bool synchronized = true}) async {}

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

  Widget host({
    required Size size,
    double duration = 20,
    double initialPosition = 4,
    double videoAspectRatio = 16 / 9,
    double? dialogMaxWidth,
  }) {
    return MaterialApp(
      locale: const Locale('zh'),
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      theme: dialogMaxWidth == null
          ? null
          : ThemeData(
              dialogTheme: DialogThemeData(
                constraints: BoxConstraints(
                  minWidth: 280,
                  maxWidth: dialogMaxWidth,
                ),
              ),
            ),
      home: MediaQuery(
        data: MediaQueryData(size: size),
        child: Scaffold(
          body: GifRecordDialog(
            videoController: videoController,
            duration: duration,
            initialPosition: initialPosition,
            sourceUrls: const {
              GifResolution.p480: 'https://example.com/480.m4s',
              GifResolution.p720: 'https://example.com/720.m4s',
            },
            videoAspectRatio: videoAspectRatio,
            videoPreview: const ColoredBox(color: Colors.black),
          ),
        ),
      ),
    );
  }

  testWidgets('uses the wide three-column layout without removed copy', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(800, 720));
    await tester.pumpWidget(
      host(size: const Size(800, 720), dialogMaxWidth: 420),
    );
    await tester.pump();

    expect(find.byKey(const ValueKey('gif-preview')), findsOneWidget);
    expect(find.byKey(const ValueKey('gif-wide-layout')), findsOneWidget);
    expect(find.byKey(const ValueKey('gif-options')), findsOneWidget);
    expect(find.byKey(const ValueKey('gif-actions')), findsOneWidget);
    expect(find.byKey(const ValueKey('gif-export-button')), findsOneWidget);
    expect(find.byKey(const ValueKey('gif-cancel-button')), findsOneWidget);
    expect(find.text('截取 GIF'), findsNothing);
    expect(find.textContaining('不包含音频'), findsNothing);

    final exportButton = tester.widget<IconButton>(
      find.byKey(const ValueKey('gif-export-button')),
    );
    final exportBackground = exportButton.style?.backgroundColor?.resolve({});
    expect(
      exportBackground,
      Theme.of(tester.element(find.byType(Dialog))).colorScheme.primary,
    );

    final cancelButton = tester.widget<IconButton>(
      find.byKey(const ValueKey('gif-cancel-button')),
    );
    expect(cancelButton.style?.backgroundColor?.resolve({}), isNull);
  });

  testWidgets('keeps portrait videos on the narrow layout', (tester) async {
    await tester.binding.setSurfaceSize(const Size(1024, 720));
    await tester.pumpWidget(
      host(size: const Size(1024, 720), videoAspectRatio: 9 / 16),
    );
    await tester.pump();

    expect(find.byKey(const ValueKey('gif-narrow-layout')), findsOneWidget);
    expect(find.byKey(const ValueKey('gif-wide-layout')), findsNothing);
  });

  testWidgets('accepts direct timestamp input', (tester) async {
    await tester.binding.setSurfaceSize(const Size(800, 720));
    await tester.pumpWidget(
      host(
        size: const Size(800, 720),
        duration: 200,
        initialPosition: 60,
      ),
    );
    await tester.pump();

    await tester.enterText(
      find.byKey(const ValueKey('gif-start-time')),
      '01:02.345',
    );
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pump();
    await tester.enterText(
      find.byKey(const ValueKey('gif-end-time')),
      '01:07.890',
    );
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pump();

    final slider = tester.widget<RangeSlider>(find.byType(RangeSlider));
    expect(slider.values.start, closeTo(62.345, 0.001));
    expect(slider.values.end, closeTo(67.890, 0.001));
  });

  testWidgets('limits long videos to a one-minute window around current time', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(800, 720));
    await tester.pumpWidget(
      host(
        size: const Size(800, 720),
        duration: 600,
        initialPosition: 300,
      ),
    );
    await tester.pump();

    final slider = tester.widget<RangeSlider>(find.byType(RangeSlider));
    expect(slider.min, 240);
    expect(slider.max, 360);
    expect(slider.values.start, 300);
    expect(slider.values.end, 305);
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
