import 'dart:typed_data';

class GifFileValidation {
  const GifFileValidation({
    required this.header,
    required this.frameCount,
    required this.hasInfiniteLoop,
    required this.isComplete,
    this.trailerOffset,
    this.repairOffset,
  });

  final String header;
  final int frameCount;
  final bool hasInfiniteLoop;
  final bool isComplete;
  final int? trailerOffset;
  final int? repairOffset;

  bool get isValid =>
      (header == 'GIF87a' || header == 'GIF89a') &&
      frameCount >= 2 &&
      hasInfiniteLoop &&
      isComplete;

  /// Adds the standard infinite-loop application extension before the GIF
  /// trailer when a complete multi-frame GIF does not already contain one.
  ///
  /// Some Android libmpv/FFmpeg builds accept `ofopts=loop=0` but omit the
  /// Netscape extension from the resulting file. Keeping this repair at the
  /// byte level avoids a second encode and preserves the generated frames.
  static Uint8List ensureInfiniteLoop(Uint8List bytes) {
    final validation = fromBytes(bytes);
    final trailerIndex = validation.trailerOffset;
    if (validation.frameCount < 2 || validation.hasInfiniteLoop) {
      return bytes;
    }

    final extension = <int>[
      0x21,
      0xff,
      0x0b,
      ...'NETSCAPE2.0'.codeUnits,
      0x03,
      0x01,
      0x00,
      0x00,
      0x00,
    ];
    if (trailerIndex != null) {
      return Uint8List.fromList([
        ...bytes.sublist(0, trailerIndex),
        ...extension,
        ...bytes.sublist(trailerIndex),
      ]);
    }

    final repairIndex = validation.repairOffset;
    if (repairIndex != null) {
      return Uint8List.fromList([
        ...bytes.sublist(0, repairIndex),
        ...extension,
        0x3b,
      ]);
    }

    // libmpv can finish after writing all image data but before emitting the
    // GIF trailer. The frame parser has still consumed complete frames, so
    // the trailer and loop extension can be safely appended.
    if (!validation.isComplete) {
      return Uint8List.fromList([...bytes, ...extension, 0x3b]);
    }
    return bytes;
  }

  static GifFileValidation fromBytes(Uint8List bytes) {
    final reader = _GifReader(bytes);
    final header = reader.readAscii(6);
    if (header != 'GIF87a' && header != 'GIF89a') {
      return _invalid(header, 0);
    }
    if (!reader.skip(7)) return _invalid(header, 0);

    final packed = reader.bytes[10];
    if (packed & 0x80 != 0 && !reader.skip(3 * (1 << ((packed & 0x07) + 1)))) {
      return _invalid(header, 0);
    }

    var frameCount = 0;
    var hasInfiniteLoop = false;
    while (!reader.isAtEnd) {
      final marker = reader.readByte();
      if (marker == 0x3b) {
        return GifFileValidation(
          header: header,
          frameCount: frameCount,
          hasInfiniteLoop: hasInfiniteLoop,
          isComplete: true,
          trailerOffset: reader.position - 1,
        );
      }

      if (marker == 0x2c) {
        final imageStart = reader.position - 1;
        if (!reader.skip(9)) {
          return _invalid(
            header,
            frameCount,
            repairOffset: imageStart,
          );
        }
        final imagePacked = reader.bytes[reader.position - 1];
        if (imagePacked & 0x80 != 0 &&
            !reader.skip(3 * (1 << ((imagePacked & 0x07) + 1)))) {
          return _invalid(
            header,
            frameCount,
            repairOffset: imageStart,
          );
        }
        if (reader.readByte() < 0 || !reader.skipSubBlocks()) {
          return _invalid(
            header,
            frameCount,
            repairOffset: imageStart,
          );
        }
        frameCount++;
        continue;
      }

      if (marker == 0x21) {
        final label = reader.readByte();
        if (label < 0) return _invalid(header, frameCount);
        if (label == 0xff) {
          final applicationLength = reader.readByte();
          final application = reader.readAscii(applicationLength);
          final data = reader.readSubBlocks();
          if (data == null) return _invalid(header, frameCount);
          if (application.startsWith('NETSCAPE') ||
              application.startsWith('ANIMEXTS')) {
            hasInfiniteLoop =
                data.length >= 3 &&
                data[0] == 1 &&
                data[1] == 0 &&
                data[2] == 0;
          }
        } else if (label == 0xf9) {
          final blockLength = reader.readByte();
          if (blockLength < 0 ||
              !reader.skip(blockLength) ||
              reader.readByte() != 0) {
            return _invalid(header, frameCount);
          }
        } else if (reader.readSubBlocks() == null) {
          return _invalid(header, frameCount);
        }
        continue;
      }

      return _invalid(header, frameCount, repairOffset: reader.position - 1);
    }

    return _invalid(header, frameCount);
  }

  static GifFileValidation _invalid(
    String header,
    int frameCount, {
    int? repairOffset,
  }) {
    return GifFileValidation(
      header: header,
      frameCount: frameCount,
      hasInfiniteLoop: false,
      isComplete: false,
      repairOffset: repairOffset,
    );
  }
}

class _GifReader {
  _GifReader(this.bytes);

  final Uint8List bytes;
  int position = 0;

  bool get isAtEnd => position >= bytes.length;

  int readByte() => isAtEnd ? -1 : bytes[position++];

  String readAscii(int length) {
    if (length < 0 || position + length > bytes.length) return '';
    final value = String.fromCharCodes(
      bytes.sublist(position, position + length),
    );
    position += length;
    return value;
  }

  bool skip(int length) {
    if (length < 0 || position + length > bytes.length) return false;
    position += length;
    return true;
  }

  List<int>? readSubBlocks() {
    final result = <int>[];
    while (true) {
      final length = readByte();
      if (length < 0 || !skip(length)) return null;
      if (length == 0) return result;
      result.addAll(bytes.sublist(position - length, position));
    }
  }

  bool skipSubBlocks() => readSubBlocks() != null;
}
