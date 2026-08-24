import 'dart:typed_data';

import 'package:ex_piliplus/plugin/pl_player/widgets/gif_file_validator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('accepts a complete looping GIF with at least two frames', () {
    final result = GifFileValidation.fromBytes(_twoFrameGif());

    expect(result.header, 'GIF89a');
    expect(result.frameCount, 2);
    expect(result.hasInfiniteLoop, isTrue);
    expect(result.isComplete, isTrue);
    expect(result.isValid, isTrue);
    expect(result.trailerOffset, sourceTrailerOffset(_twoFrameGif()));
  });

  test('rejects an incomplete GIF', () {
    final bytes = Uint8List.fromList(_twoFrameGif().take(25).toList());

    final result = GifFileValidation.fromBytes(bytes);

    expect(result.isComplete, isFalse);
    expect(result.isValid, isFalse);
  });

  test('adds an infinite loop extension before the trailer', () {
    final source = _twoFrameGif();
    final loopStart = source.indexOf(0x21);
    final trailer = source.lastIndexOf(0x3b);
    final withoutLoop = Uint8List.fromList([
      ...source.sublist(0, loopStart),
      ...source.sublist(loopStart + 19, trailer + 1),
    ]);

    final repaired = GifFileValidation.ensureInfiniteLoop(withoutLoop);
    final result = GifFileValidation.fromBytes(repaired);

    expect(result.isValid, isTrue);
    expect(repaired.last, 0x3b);
  });

  test('adds loop extension and trailer when the trailer is missing', () {
    final source = _twoFrameGif();
    final withoutTrailer = Uint8List.fromList(
      source.take(source.length - 1).toList(),
    );

    final repaired = GifFileValidation.ensureInfiniteLoop(withoutTrailer);
    final result = GifFileValidation.fromBytes(repaired);

    expect(result.isValid, isTrue);
    expect(repaired.last, 0x3b);
  });

  test('drops a truncated final frame before repairing the trailer', () {
    final source = _twoFrameGif();
    final truncated = Uint8List.fromList([
      ...source.take(source.length - 1),
      0x2c,
      0,
      0,
    ]);

    final repaired = GifFileValidation.ensureInfiniteLoop(truncated);
    final result = GifFileValidation.fromBytes(repaired);

    expect(result.isValid, isTrue);
    expect(result.frameCount, 2);
  });
}

int sourceTrailerOffset(Uint8List bytes) => bytes.length - 1;

Uint8List _twoFrameGif() {
  return Uint8List.fromList([
    ...'GIF89a'.codeUnits,
    1,
    0,
    1,
    0,
    0x80,
    0,
    0,
    0,
    0,
    0,
    255,
    255,
    255,
    0x21,
    0xff,
    0x0b,
    ...'NETSCAPE2.0'.codeUnits,
    3,
    1,
    0,
    0,
    0,
    0x21,
    0xf9,
    4,
    0,
    10,
    0,
    0,
    0,
    0x2c,
    0,
    0,
    0,
    0,
    1,
    0,
    1,
    0,
    0,
    2,
    2,
    0x44,
    1,
    0,
    0x21,
    0xf9,
    4,
    0,
    10,
    0,
    0,
    0,
    0x2c,
    0,
    0,
    0,
    0,
    1,
    0,
    1,
    0,
    0,
    2,
    2,
    0x44,
    1,
    0,
    0x3b,
  ]);
}
