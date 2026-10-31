import 'dart:async';
import 'dart:io';

import 'package:ex_piliplus/plugin/pl_player/widgets/darwin_gif_converter.dart';
import 'package:ex_piliplus/plugin/pl_player/widgets/gif_source_cache.dart';
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
    final converter = DarwinGifConverter(
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
    final converter = DarwinGifConverter(
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
    final converter = DarwinGifConverter(
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
    expect(converter.failureCode, 'invalid_gif_output');
  });

  test('does not start a second export while one is running', () async {
    final generateResult = Completer<String>();
    messenger.setMockMethodCallHandler(channel, (call) async {
      if (call.method == 'generate') return generateResult.future;
      if (call.method == 'cancel') {
        generateResult.completeError(PlatformException(code: 'cancelled'));
      }
      return null;
    });
    final converter = DarwinGifConverter(
      'https://example.com/video.m4s',
      '${tempDir.path}/result.gif',
      0,
      3,
      width: 480,
      fps: 10,
      channel: channel,
    );

    final first = converter.convert();
    await Future<void>.delayed(Duration.zero);

    expect(await converter.convert(), isFalse);
    converter.dispose();
    expect(await first, isFalse);
  });

  for (final code in [
    'asset_unreadable',
    'frame_generation_failed',
    'output_creation_failed',
    'output_finalize_failed',
    'invalid_arguments',
    'busy',
  ]) {
    test('preserves safe native failure stage $code and cleans output', () async {
      final output = File('${tempDir.path}/failed.gif');
      messenger.setMockMethodCallHandler(channel, (call) async {
        await output.writeAsString('partial');
        throw PlatformException(
          code: code,
          message: 'https://example.com/private-video?token=secret',
          details: {'url': 'private'},
        );
      });
      final converter = DarwinGifConverter(
        'https://example.com/video.m4s',
        output.path,
        0,
        3,
        width: 480,
        fps: 10,
        channel: channel,
      );
      expect(await converter.convert(), isFalse);
      expect(converter.failureCode, code);
      expect(output.existsSync(), isFalse);
    });
  }

  test('does not surface arbitrary platform error codes', () async {
    messenger.setMockMethodCallHandler(channel, (call) async {
      throw PlatformException(code: 'https://example.com/?token=secret');
    });
    final converter = DarwinGifConverter(
      'https://example.com/video.m4s',
      '${tempDir.path}/failed.gif',
      0,
      3,
      width: 480,
      fps: 10,
      channel: channel,
    );
    expect(await converter.convert(), isFalse);
    expect(converter.failureCode, 'native_export_failed');
  });

  test('identifies an unavailable native plugin', () async {
    final converter = DarwinGifConverter(
      'https://example.com/video.m4s',
      '${tempDir.path}/failed.gif',
      0,
      3,
      width: 480,
      fps: 10,
      channel: channel,
    );
    expect(await converter.convert(), isFalse);
    expect(converter.failureCode, 'native_export_unavailable');
  });

  test('cancel channel errors do not escape as conversion failures', () async {
    final generateResult = Completer<String>();
    messenger.setMockMethodCallHandler(channel, (call) async {
      if (call.method == 'generate') return generateResult.future;
      throw PlatformException(code: 'cancel_failed');
    });
    final converter = DarwinGifConverter(
      'https://example.com/video.m4s',
      '${tempDir.path}/failed.gif',
      0,
      3,
      width: 480,
      fps: 10,
      channel: channel,
    );
    final conversion = converter.convert();
    await Future<void>.delayed(Duration.zero);
    converter.dispose();
    await Future<void>.delayed(Duration.zero);
    generateResult.completeError(PlatformException(code: 'cancelled'));
    expect(await conversion, isFalse);
    expect(converter.failureCode, isNull);
  });

  for (final source in [
    'http://example.com/video.m4s?token=unchanged',
    '//example.com/video.m4s?token=unchanged',
    'https://example.com/video.m4s?token=unchanged',
    'file:///tmp/video.mp4',
  ]) {
    test('normalizes ATS source URL: $source', () async {
      final output = File('${tempDir.path}/result.gif');
      String? receivedUrl;
      messenger.setMockMethodCallHandler(channel, (call) async {
        receivedUrl = (call.arguments as Map)['url'] as String;
        await output.writeAsBytes('GIF89a-content'.codeUnits);
        return output.path;
      });
      final converter = DarwinGifConverter(
        source,
        output.path,
        0,
        3,
        width: 480,
        fps: 10,
        channel: channel,
      );
      expect(await converter.convert(), isTrue);
      expect(
        receivedUrl,
        source.startsWith('file:')
            ? source
            : 'https://example.com/video.m4s?token=unchanged',
      );
    });
  }

  test('successful remote conversion never downloads a source', () async {
    final output = File('${tempDir.path}/result.gif');
    var factories = 0;
    messenger.setMockMethodCallHandler(channel, (call) async {
      await output.writeAsBytes('GIF89a-content'.codeUnits);
      return output.path;
    });
    final converter = DarwinGifConverter(
      'https://example.com/video.m4s', output.path, 0, 3,
      width: 480, fps: 10, channel: channel, localSourceFallback: true,
      sourceCacheFactory: () {
        factories++;
        throw StateError('must not download');
      },
    );
    expect(await converter.convert(), isTrue);
    expect(factories, 0);
  });

  for (final retryFails in [false, true]) {
    test('retries unreadable remote asset once locally; failure=$retryFails', () async {
      final output = File('${tempDir.path}/result.gif');
      final source = await File('${tempDir.path}/source.mp4').writeAsString('fixture');
      final cache = _FakeSourceCache(source);
      var calls = 0;
      messenger.setMockMethodCallHandler(channel, (call) async {
        calls++;
        if (calls == 1) throw PlatformException(code: 'asset_unreadable');
        expect((call.arguments as Map)['url'], source.uri.toString());
        expect(source.existsSync(), isTrue);
        if (retryFails) {
          throw PlatformException(code: 'asset_unreadable', details: {
            'stage': 'tracks', 'domain': 'AVFoundationErrorDomain', 'code': -11800,
            'underlyingDomain': 'NSOSStatusErrorDomain', 'underlyingCode': -12889,
          });
        }
        await output.writeAsBytes('GIF89a-content'.codeUnits);
        return output.path;
      });
      final converter = DarwinGifConverter(
        'https://example.com/video.m4s', output.path, 0, 3,
        width: 480, fps: 10, channel: channel, localSourceFallback: true,
        sourceCacheFactory: () => cache,
      );
      expect(await converter.convert(), !retryFails);
      expect(calls, 2);
      expect(cache.downloads, 1);
      expect(cache.disposed, isTrue);
      expect(source.existsSync(), isFalse);
      expect(converter.preparingSource, isFalse);
      if (retryFails) {
        expect(converter.failureCode,
          'asset_unreadable/tracks/AVFoundationErrorDomain:-11800/NSOSStatusErrorDomain:-12889');
      }
    });
  }

  for (final code in ['busy', 'cancelled', 'frame_generation_failed']) {
    test('does not download on $code', () async {
      messenger.setMockMethodCallHandler(channel, (call) async {
        throw PlatformException(code: code);
      });
      final converter = DarwinGifConverter(
        'https://example.com/video.m4s', '${tempDir.path}/failed.gif', 0, 3,
        width: 480, fps: 10, channel: channel, localSourceFallback: true,
        sourceCacheFactory: () => throw StateError('must not download'),
      );
      expect(await converter.convert(), isFalse);
      expect(converter.failureCode, code == 'cancelled' ? null : code);
    });
  }

  test('download failure remains safe and cleans its cache', () async {
    final cache = _FakeSourceCache(File('${tempDir.path}/source.mp4'),
      failure: const GifSourceException('source_too_large'));
    messenger.setMockMethodCallHandler(channel, (call) async {
      throw PlatformException(code: 'asset_unreadable');
    });
    final converter = DarwinGifConverter(
      'https://example.com/video.m4s', '${tempDir.path}/failed.gif', 0, 3,
      width: 480, fps: 10, channel: channel, localSourceFallback: true,
      sourceCacheFactory: () => cache,
    );
    expect(await converter.convert(), isFalse);
    expect(converter.failureCode, 'source_too_large');
    expect(cache.disposed, isTrue);
  });

  test('cancelling during source download never retries native generation', () async {
    final cache = _FakeSourceCache(File('${tempDir.path}/source.mp4'),
      pending: Completer<File>());
    var generations = 0;
    messenger.setMockMethodCallHandler(channel, (call) async {
      if (call.method == 'cancel') return null;
      generations++;
      throw PlatformException(code: 'asset_unreadable');
    });
    final converter = DarwinGifConverter(
      'https://example.com/video.m4s', '${tempDir.path}/failed.gif', 0, 3,
      width: 480, fps: 10, channel: channel, localSourceFallback: true,
      sourceCacheFactory: () => cache,
    );
    final conversion = converter.convert();
    await Future<void>.delayed(Duration.zero);
    expect(converter.preparingSource, isTrue);
    converter.dispose();
    expect(await conversion, isFalse);
    expect(generations, 1);
    expect(cache.disposed, isTrue);
    expect(converter.failureCode, isNull);
  });

  test('asset details never expose unknown stages, domains or URL values', () async {
    messenger.setMockMethodCallHandler(channel, (call) async {
      throw PlatformException(code: 'asset_unreadable', details: {
        'stage': 'tracks', 'domain': 'https://private?token=secret', 'code': -1,
        'underlyingDomain': 'NSURLErrorDomain', 'underlyingCode': 'private',
      });
    });
    final converter = DarwinGifConverter(
      'https://example.com/video.m4s', '${tempDir.path}/failed.gif', 0, 3,
      width: 480, fps: 10, channel: channel, localSourceFallback: false,
    );
    expect(await converter.convert(), isFalse);
    expect(converter.failureCode, 'asset_unreadable/tracks');
  });

}


class _FakeSourceCache extends GifSourceCache {
  _FakeSourceCache(this.file, {this.failure, this.pending});

  final File file;
  final GifSourceException? failure;
  final Completer<File>? pending;
  int downloads = 0;
  bool disposed = false;

  @override
  Future<File> download(Uri source, {
    required String userAgent,
    required String referer,
    void Function(int received, int? total)? onProgress,
  }) async {
    downloads++;
    expect(source.scheme, 'https');
    expect(userAgent, isNotEmpty);
    expect(referer, 'https://www.bilibili.com');
    if (failure != null) throw failure!;
    if (pending != null) return pending!.future;
    onProgress?.call(10, 10);
    return file;
  }

  @override
  void cancel() {
    if (pending != null && !pending!.isCompleted) {
      pending!.completeError(const GifSourceException('source_cancelled'));
    }
  }

  @override
  Future<void> dispose() async {
    disposed = true;
    if (await file.exists()) await file.delete();
  }
}
