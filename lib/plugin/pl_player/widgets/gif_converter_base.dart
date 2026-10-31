abstract interface class GifConverter {
  Future<bool> convert();

  void dispose();
}

/// Safe diagnostic codes only: never expose signed source URLs or native errors.
abstract interface class GifConversionDiagnostics {
  String? get failureCode;
}
