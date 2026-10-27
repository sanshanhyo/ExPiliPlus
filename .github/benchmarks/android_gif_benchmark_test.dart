import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:ex_piliplus/plugin/pl_player/widgets/gif_converter.dart';
import 'package:ex_piliplus/plugin/pl_player/widgets/gif_file_validator.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get_rx/get_rx.dart';
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
const _diagnosticRanges = <({String name, double start, double end})>[
  (name: 'keyframe-aligned-1-to-4', start: 1, end: 4),
  (name: 'keyframe-aligned-0-to-3', start: 0, end: 3),
  (name: 'non-keyframe-1.1-to-4.1', start: 1.1, end: 4.1),
];

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
      final diagnosticResults = <Map<String, Object>>[];
      final measuredTimes = <int>[];
      Uint8List? diagnosticGif;
      Uint8List? retainedGif;

      for (final scenario in _diagnosticRanges) {
        final outputFile = File(
          path.join(temporaryDirectory.path, 'android-gif-${scenario.name}.gif'),
        );
        final converter = createGifConverter(
          sourceUri,
          outputFile.path,
          scenario.start,
          scenario.end,
          width: _gifWidth,
          fps: _gifFps,
          progress: 0.0.obs,
        );
        final stopwatch = Stopwatch()..start();
        final succeeded = await converter.convert();
        stopwatch.stop();
        final bytes = outputFile.existsSync()
            ? await outputFile.readAsBytes()
            : Uint8List(0);
        final validation = GifFileValidation.fromBytes(bytes);
        final hasDimensions = bytes.length >= 10;
        final dimensions = hasDimensions ? ByteData.sublistView(bytes) : null;
        diagnosticResults.add(<String, Object>{
          'scenario': scenario.name,
          'start_seconds': scenario.start,
          'end_seconds': scenario.end,
          'duration_seconds': scenario.end - scenario.start,
          'speed_option': 1,
          'converter_succeeded': succeeded,
          'elapsed_ms': stopwatch.elapsedMilliseconds,
          'output_bytes': bytes.length,
          'valid_structure': validation.isValid,
          'decoded_structure_frames': validation.frameCount,
          'width': dimensions?.getUint16(6, Endian.little) ?? 0,
          'height': dimensions?.getUint16(8, Endian.little) ?? 0,
          'complete': validation.isComplete,
          'infinite_loop': validation.hasInfiniteLoop,
        });
        diagnosticGif ??= bytes.isEmpty ? null : bytes;
        await outputFile.delete().catchError((_) => outputFile);
      }

      final diagnosticsPassed = diagnosticResults.every((result) {
        final frames = result['decoded_structure_frames']! as int;
        return result['converter_succeeded']! as bool &&
            result['valid_structure']! as bool &&
            frames >= _expectedFrameCount - _frameCountTolerance &&
            frames <= _expectedFrameCount + _frameCountTolerance &&
            result['width'] == _gifWidth &&
            result['height'] == _expectedGifHeight;
      });

      var measurementsPassed = false;
      if (diagnosticsPassed) {
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
            progress: 0.0.obs,
          );

          final stopwatch = Stopwatch()..start();
          final succeeded = await converter.convert();
          stopwatch.stop();
          final bytes = outputFile.existsSync()
              ? await outputFile.readAsBytes()
              : Uint8List(0);
          final validation = GifFileValidation.fromBytes(bytes);
          final dimensions = bytes.length >= 10
              ? ByteData.sublistView(bytes)
              : null;
          final result = <String, Object>{
            'run': run,
            'phase': run < _warmupRuns ? 'warmup' : 'measured',
            'converter_succeeded': succeeded,
            'elapsed_ms': stopwatch.elapsedMilliseconds,
            'output_bytes': bytes.length,
            'valid_structure': validation.isValid,
            'decoded_structure_frames': validation.frameCount,
            'width': dimensions?.getUint16(6, Endian.little) ?? 0,
            'height': dimensions?.getUint16(8, Endian.little) ?? 0,
            'infinite_loop': validation.hasInfiniteLoop,
          };
          diagnosticResults.add(result);
          if (run >= _warmupRuns) measuredTimes.add(stopwatch.elapsedMilliseconds);
          if (validation.isValid &&
              validation.frameCount >=
                  _expectedFrameCount - _frameCountTolerance &&
              validation.frameCount <=
                  _expectedFrameCount + _frameCountTolerance &&
              dimensions?.getUint16(6, Endian.little) == _gifWidth &&
              dimensions?.getUint16(8, Endian.little) == _expectedGifHeight) {
            retainedGif = bytes;
          }
          await outputFile.delete().catchError((_) => outputFile);
        }
        final performanceResults = diagnosticResults
            .where((result) => result.containsKey('phase'))
            .toList();
        measurementsPassed =
            performanceResults.length == _warmupRuns + _measuredRuns &&
            performanceResults.every((result) {
              final frames = result['decoded_structure_frames']! as int;
              return result['converter_succeeded']! as bool &&
                  result['valid_structure']! as bool &&
                  frames >= _expectedFrameCount - _frameCountTolerance &&
                  frames <= _expectedFrameCount + _frameCountTolerance &&
                  result['width'] == _gifWidth &&
                  result['height'] == _expectedGifHeight &&
                  result['infinite_loop']! as bool;
            });
      }

      final sortedTimes = [...measuredTimes]..sort();
      final medianMs = sortedTimes.isEmpty
          ? 0
          : sortedTimes[sortedTimes.length ~/ 2];
      final outputBytes = retainedGif ?? diagnosticGif ?? Uint8List(0);
      final outputDimensions = outputBytes.length >= 10
          ? ByteData.sublistView(outputBytes)
          : null;
      final outputValidation = outputBytes.isEmpty
          ? null
          : GifFileValidation.fromBytes(outputBytes);
      final result = <String, Object>{
        'fixture_sha256': sourceSha256,
        'fixture': <String, Object>{
          'format': 'H.264 / MP4',
          'width': 854,
          'height': 480,
          'fps': '30/1',
          'frames': 240,
          'duration_seconds': 8,
          'start_pts_seconds': 0,
          'keyframe_seconds': <int>[0, 1, 2, 3, 4, 5, 6, 7],
          'metadata_source': 'ffprobe on the hash-pinned fixture',
        },
        'warmup_runs': diagnosticsPassed ? _warmupRuns : 0,
        'measured_runs': measuredTimes,
        'median_ms': medianMs,
        'diagnostics_passed': diagnosticsPassed,
        'measurements_passed': measurementsPassed,
        'diagnostic_and_measurement_runs': diagnosticResults,
        'options': <String, Object>{
          'start_seconds': 1,
          'duration_seconds': _gifDurationSeconds,
          'width': _gifWidth,
          'fps': _gifFps,
          'speed': 1,
        },
        'result': <String, Object>{
          'valid': outputValidation?.isValid ?? false,
          'bytes': outputBytes.length,
          'width': outputDimensions?.getUint16(6, Endian.little) ?? 0,
          'height': outputDimensions?.getUint16(8, Endian.little) ?? 0,
          'decoded_structure_frames': outputValidation?.frameCount ?? 0,
          'infinite_loop': outputValidation?.hasInfiniteLoop ?? false,
        },
        if (outputBytes.isNotEmpty) 'gif_base64': base64Encode(outputBytes),
      };
      // Report diagnostics before strict assertions so a frame-count failure
      // still leaves the complete range matrix and a GIF in the CI evidence.
      binding.reportData = <String, dynamic>{'androidGifBenchmark': result};

      expect(
        diagnosticsPassed,
        isTrue,
        reason: 'Every keyframe/non-keyframe 3s range must produce 28–32 '
            'frames. Results: $diagnosticResults',
      );
      expect(measuredTimes, hasLength(_measuredRuns));
      expect(
        measurementsPassed,
        isTrue,
        reason: 'Every warmup and measured run must satisfy the strict GIF '
            'contract. Results: $diagnosticResults',
      );

      return result;
    });

    expect(result, isNotNull);
    binding.reportData = <String, dynamic>{'androidGifBenchmark': result};
  });
}
