import 'dart:io';
import 'dart:typed_data';

import 'package:integration_test/integration_test_driver_extended.dart';

Future<void> main() async {
  await integrationDriver(
    writeResponseOnFailure: true,
    responseDataCallback: (data) async {
      final screenshots = data?['screenshots'] as List<dynamic>? ?? const [];
      for (final entry in screenshots) {
        final screenshot = entry as Map<String, dynamic>;
        final rawBytes = screenshot['bytes'] as List<dynamic>;
        final safeName = (screenshot['screenshotName'] as String)
            .replaceAll(RegExp(r'[^A-Za-z0-9_.-]'), '_');
        final file = File(
          'build/test-artifacts/aicu-real-webview/$safeName.png',
        );
        await file.parent.create(recursive: true);
        await file.writeAsBytes(Uint8List.fromList(rawBytes.cast<int>()));
        // ignore: avoid_print
        print('Saved real Android WebView screenshot: ${file.path}');
      }
    },
  );
}
