import 'dart:convert';

import 'package:ex_piliplus/plugin/pl_player/widgets/mpv_runtime_capabilities.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('recognizes an encoder by its codec field', () {
    final encoderList = jsonEncode([
      {'codec': 'gif', 'driver': 'gif', 'description': ''},
      {'codec': 'webp', 'driver': 'libwebp_anim', 'description': ''},
    ]);

    expect(mpvEncoderListContainsCodec(encoderList, 'gif'), isTrue);
  });

  test('does not treat a matching driver as the requested codec', () {
    final encoderList = jsonEncode([
      {'codec': 'webp', 'driver': 'gif', 'description': ''},
    ]);

    expect(mpvEncoderListContainsCodec(encoderList, 'gif'), isFalse);
  });

  test('returns false for unavailable or malformed properties', () {
    expect(mpvEncoderListContainsCodec('<unavailable>', 'gif'), isFalse);
    expect(mpvEncoderListContainsCodec('{"codec":"gif"}', 'gif'), isFalse);
  });
}
