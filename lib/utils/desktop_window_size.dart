import 'dart:ui' show Size;

abstract final class DesktopWindowSize {
  static const Size defaultSize = Size(1180, 720);
  static const Size minimumSize = Size(600, 400);

  static Size restore(Size savedSize) {
    final isValid =
        savedSize.width.isFinite &&
        savedSize.height.isFinite &&
        savedSize.width >= minimumSize.width &&
        savedSize.height >= minimumSize.height;
    return isValid ? savedSize : defaultSize;
  }
}
