import 'package:ex_piliplus/services/system_font_catalog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('SystemFontCatalog', () {
    test('follows the upstream platform support set', () {
      expect(SystemFontCatalog.supportsPlatform(TargetPlatform.android), isTrue);
      expect(SystemFontCatalog.supportsPlatform(TargetPlatform.windows), isTrue);
      expect(SystemFontCatalog.supportsPlatform(TargetPlatform.linux), isTrue);
      expect(SystemFontCatalog.supportsPlatform(TargetPlatform.iOS), isFalse);
      expect(SystemFontCatalog.supportsPlatform(TargetPlatform.macOS), isFalse);
      expect(SystemFontCatalog.supportsPlatform(TargetPlatform.fuchsia), isFalse);
    });

    test('trims, removes empty and vertical aliases, and deduplicates names', () {
      expect(
        SystemFontCatalog.normalizeFamilies([
          '  Noto Sans  ',
          'Noto Sans',
          '',
          '   ',
          '@VerticalAlias',
          'Serif',
        ]),
        {'Noto Sans', 'Serif'},
      );
    });
  });
}
