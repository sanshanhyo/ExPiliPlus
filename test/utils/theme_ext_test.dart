import 'package:ex_piliplus/utils/extension/theme_ext.dart';
import 'package:flex_seed_scheme/flex_seed_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'keeps the selected FlexSeedScheme variant in the Flutter ColorScheme',
    () {
      const seed = Color(0xFFE25B7B);
      final material = seed.asColorSchemeSeed(
        FlexSchemeVariant.material,
        Brightness.dark,
      );
      final monochrome = seed.asColorSchemeSeed(
        FlexSchemeVariant.monochrome,
        Brightness.dark,
      );

      expect(material.brightness, Brightness.dark);
      expect(material.primary, isNot(monochrome.primary));
    },
  );
}
