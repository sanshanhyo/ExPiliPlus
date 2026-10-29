import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart';

/// Loads the same font assets declared by the app's Flutter font manifest and
/// the app's existing licensed CJK font for readable rendered test captures.
Future<void> loadRenderTestFonts() async {
  final manifest = jsonDecode(await rootBundle.loadString('FontManifest.json'))
      as List<dynamic>;
  final fontsByFamily = <String, List<dynamic>>{};
  for (final entry in manifest) {
    final family = entry['family'] as String;
    fontsByFamily.putIfAbsent(family, () => []).addAll(
      entry['fonts'] as List<dynamic>,
    );
  }
  for (final entry in fontsByFamily.entries) {
    final family = entry.key;
    final loader = FontLoader(family);
    for (final font in entry.value) {
      final package = font['package'] as String?;
      final asset = font['asset'] as String;
      final assetPath = package == null || asset.startsWith('packages/')
          ? asset
          : 'packages/$package/$asset';
      loader.addFont(rootBundle.load(assetPath));
    }
    await loader.load();
  }

  final cjkFont = await File(
    'build/test-fonts/SourceHanSerifCN-Regular.otf',
  ).readAsBytes();
  final cjkLoader = FontLoader('Source Han Serif CN')
    ..addFont(Future.value(ByteData.sublistView(cjkFont)));
  await cjkLoader.load();
}
