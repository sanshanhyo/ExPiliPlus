import 'dart:async';
import 'dart:io';

import 'package:ex_piliplus/plugin/pl_player/widgets/ios_gif_converter.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get_rx/get_rx.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const channel = MethodChannel('test/gif_export');
  final messenger =
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger;
  late Directory tempDir;

  setUp(() async {
    tempDir = await Directory.systemTemp.createTemp('ios_gif_converter_test');
  });

  tearDown(() async {
    messenger.setMockMethodCallHandler(channel, null);
    await tempDir.delete(recursive: true);
  });

  test('passes export options and accepts a valid GIF result', () async {
    final output = File('${tempDir.path}/result.gif');
    MethodCall? received;
    messenger.setMockMethodCallHandler(channel, (call) async {
      received = call;
      await output.writeAsBytes('GIF89a-content'.codeUnits);
      return output.path;
    });
    final progress = 0.0.obs;
    final converter = IosGifConverter(
      'https://example.com/video.m4s',
      output.path,
      1.5,
      4.5,
      width: 480,
      fps: 10,
      progress: progress,
      channel: channel,
    );

    expect(await converter.convert(), isTrue);
    expect(received?.method, 'generate');
    expect(received?.arguments, containsPair('start', 1.5));
    expect(received?.arguments, containsPair('duration', 3.0));
    expect(received?.arguments, containsPair('width', 480));
    expect(received?.arguments, containsPair('fps', 10));
    expect(progress.value, 1);
    expect(output.existsSync(), isTrue);
  });

  test('cancels the native export when disposed', () async {
    final generateResult = Completer<String>();
    var cancelled = false;
    messenger.setMockMethodCallHandler(channel, (call) async {
      if (call.method == 'generate') return generateResult.future;
      if (call.method == 'cancel') {
        cancelled = true;
        generateResult.completeError(
          PlatformException(code: 'cancelled'),
        );
      }
      return null;
    });
    final converter = IosGifConverter(
      'https://example.com/video.m4s',
      '${tempDir.path}/result.gif',
      0,
      3,
      width: 480,
      fps: 10,
      channel: channel,
    );

    final conversion = converter.convert();
    await Future<void>.delayed(Duration.zero);
    converter.dispose();

    expect(await conversion, isFalse);
    expect(cancelled, isTrue);
  });

  test('rejects a native result without a GIF header', () async {
    final output = File('${tempDir.path}/invalid.gif');
    messenger.setMockMethodCallHandler(channel, (call) async {
      await output.writeAsString('not a gif');
      return output.path;
    });
    final converter = IosGifConverter(
      'https://example.com/video.m4s',
      output.path,
      0,
      3,
      width: 480,
      fps: 10,
      channel: channel,
    );

    expect(await converter.convert(), isFalse);
    expect(output.existsSync(), isFalse);
  });
}
