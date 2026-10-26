import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:ex_piliplus/plugin/pl_player/widgets/gif_converter.dart';
import 'package:ex_piliplus/plugin/pl_player/widgets/gif_file_validator.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:media_kit/media_kit.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

import 'android_benchmark_video_data.dart';

const _warmupRuns = 1;
const _measuredRuns = 5;
const _gifDurationSeconds = 3.0;
const _gifWidth = 480;
const _gifFps = 10;
const _expectedGifHeight = 270;
const _expectedFrameCount = _gifDurationSeconds * _gifFps;
const _frameCountTolerance = 2;

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('profiles real Android native GIF conversion', (tester) async {
    final result = await tester.runAsync(() async {
      MediaKit.ensureInitialized();
      final temporaryDirectory = await getTemporaryDirectory();
      final sourceFile = File(
        path.join(temporaryDirectory.path, 'android-gif-benchmark-source.mp4'),
      );
      await sourceFile.writeAsBytes(androidBenchmarkVideoBytes, flush: true);
      final sourceUri = sourceFile.uri.toString();
      final sourceSha256 = sha256.convert(androidBenchmarkVideoBytes).toString();
      final measuredTimes = <int>[];
      Uint8List? retainedGif;
      late GifFileValidation retainedValidation;

      for (var run = 0; run < _warmupRuns + _measuredRuns; run++) {
        final outputFile = File(
          path.join(temporaryDirectory.path, 'android-gif-benchmark-$run.gif'),
        );
        final converter = createGifConverter(
          sourceUri,
          outputFile.path,
          1,
          1 + _gifDurationSeconds,
          width: _gifWidth,
          fps: _gifFps,
        );

        final stopwatch = Stopwatch()..start();
        final succeeded = await converter.convert();
        stopwatch.stop();
        expect(succeeded, isTrue, reason: 'native GIF conversion $run failed');

        final bytes = await outputFile.readAsBytes();
        final validation = GifFileValidation.fromBytes(bytes);
        expect(validation.isValid, isTrue);
        expect(
          validation.frameCount,
          inInclusiveRange(
            _expectedFrameCount - _frameCountTolerance,
            _expectedFrameCount + _frameCountTolerance,
          ),
          reason: '3 seconds at $_gifFps fps should produce about '
              '$_expectedFrameCount frames, not preserve the source 30 fps.',
        );
        final dimensions = ByteData.sublistView(bytes);
        expect(
          dimensions.getUint16(6, Endian.little),
          _gifWidth,
          reason: 'The production converter parameter is output width.',
        );
        expect(
          dimensions.getUint16(8, Endian.little),
          _expectedGifHeight,
          reason: 'The fixed 16:9 test clip should keep its aspect ratio.',
        );

        if (run >= _warmupRuns) {
          measuredTimes.add(stopwatch.elapsedMilliseconds);
          retainedGif = bytes;
          retainedValidation = validation;
        } else {
          await outputFile.delete();
        }
      }

      final sortedTimes = [...measuredTimes]..sort();
      final medianMs = sortedTimes[sortedTimes.length ~/ 2];
      final outputBytes = retainedGif!;
      final outputDimensions = ByteData.sublistView(outputBytes);
      return <String, Object>{
        'fixture_sha256': sourceSha256,
        'warmup_runs': _warmupRuns,
        'measured_runs': measuredTimes,
        'median_ms': medianMs,
        'options': <String, Object>{
          'source_seconds': 8,
          'start_seconds': 1,
          'duration_seconds': _gifDurationSeconds,
          'width': _gifWidth,
          'fps': _gifFps,
        },
        'result': <String, Object>{
          'valid': retainedValidation.isValid,
          'bytes': outputBytes.length,
          'width': outputDimensions.getUint16(6, Endian.little),
          'height': outputDimensions.getUint16(8, Endian.little),
          'decoded_structure_frames': retainedValidation.frameCount,
          'infinite_loop': retainedValidation.hasInfiniteLoop,
        },
        'gif_base64': base64Encode(outputBytes),
      };
    });

    expect(result, isNotNull);
    binding.reportData = <String, dynamic>{'androidGifBenchmark': result};
  });
}
