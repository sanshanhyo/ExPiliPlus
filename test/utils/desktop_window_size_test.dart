import 'dart:ui' show Size;

import 'package:ex_piliplus/utils/desktop_window_size.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DesktopWindowSize', () {
    test('keeps a valid saved size', () {
      const savedSize = Size(960, 640);

      expect(DesktopWindowSize.restore(savedSize), savedSize);
    });

    test('keeps the minimum supported size', () {
      expect(
        DesktopWindowSize.restore(DesktopWindowSize.minimumSize),
        DesktopWindowSize.minimumSize,
      );
    });

    test('restores the default when width is too small', () {
      expect(
        DesktopWindowSize.restore(const Size(599, 640)),
        DesktopWindowSize.defaultSize,
      );
    });

    test('restores the default when height is too small', () {
      expect(
        DesktopWindowSize.restore(const Size(960, 399)),
        DesktopWindowSize.defaultSize,
      );
    });

    test('restores the default for non-finite dimensions', () {
      expect(
        DesktopWindowSize.restore(const Size(double.nan, 640)),
        DesktopWindowSize.defaultSize,
      );
      expect(
        DesktopWindowSize.restore(const Size(960, double.infinity)),
        DesktopWindowSize.defaultSize,
      );
    });
  });
}
