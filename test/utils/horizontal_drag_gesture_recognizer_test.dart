import 'package:ex_piliplus/common/widgets/gesture/horizontal_drag_gesture_recognizer.dart';
import 'package:flutter/gestures.dart' show kTouchSlop;
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('keeps the concrete recognizer runtime type', () {
    touchSlopH = kTouchSlop;
    final recognizer = CustomHorizontalDragGestureRecognizer();
    addTearDown(recognizer.dispose);

    expect(recognizer.runtimeType, CustomHorizontalDragGestureRecognizer);
  });
}
