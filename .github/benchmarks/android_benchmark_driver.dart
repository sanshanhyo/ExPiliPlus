import 'dart:convert';
import 'dart:io';

import 'package:integration_test/integration_test_driver.dart';

Future<void> main() async {
  final outputDirectory = Platform.environment['ANDROID_BENCHMARK_OUTPUT_DIR'];
  if (outputDirectory == null || outputDirectory.isEmpty) {
    throw StateError('ANDROID_BENCHMARK_OUTPUT_DIR is required');
  }

  await integrationDriver(
    responseDataCallback: (data) async {
      final rawBenchmark = data?['androidGifBenchmark'];
      if (rawBenchmark is! Map<String, dynamic>) {
        throw StateError('Integration test did not return GIF benchmark data');
      }

      final benchmark = Map<String, dynamic>.from(rawBenchmark);
      final gifBase64 = benchmark.remove('gif_base64');

      final directory = Directory(outputDirectory);
      await directory.create(recursive: true);
      await File('${directory.path}/gif-benchmark.json').writeAsString(
        const JsonEncoder.withIndent('  ').convert(benchmark),
      );
      if (gifBase64 is String && gifBase64.isNotEmpty) {
        await File('${directory.path}/synthetic-output.gif').writeAsBytes(
          base64Decode(gifBase64),
          flush: true,
        );
      }
    },
  );
}
