import 'dart:convert';

/// Checks the `encoder-list` JSON returned by libmpv for a codec entry.
bool mpvEncoderListContainsCodec(String encoderList, String codec) {
  try {
    final decoded = jsonDecode(encoderList);
    return decoded is List &&
        decoded.any(
          (entry) => entry is Map && entry['codec'] == codec,
        );
  } on FormatException {
    return false;
  }
}
