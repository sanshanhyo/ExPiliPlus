import 'dart:ffi';

import 'package:ex_piliplus/utils/android/android_helper.dart';
import 'package:ex_piliplus/utils/fontconfig.g.dart';
import 'package:ffi/ffi.dart';
import 'package:flutter/foundation.dart'
    show TargetPlatform, debugPrint, defaultTargetPlatform, visibleForTesting;
import 'package:jni/jni.dart';
import 'package:win32/win32.dart';

/// Lists installed font families on the same platforms supported upstream.
/// Enumeration is called only when the user opens the system-font picker.
abstract final class SystemFontCatalog {
  static Set<String>? _cachedFamilies;
  static Set<String>? _windowsFontSink;

  static bool supportsPlatform(TargetPlatform platform) => switch (platform) {
    .android || .windows || .linux => true,
    _ => false,
  };

  static Set<String> getSystemFontFamilies() {
    if (!supportsPlatform(defaultTargetPlatform)) return const {};
    final cached = _cachedFamilies;
    if (cached != null) return cached;

    try {
      final families = switch (defaultTargetPlatform) {
        .android => _androidFamilies(),
        .windows => _windowsFamilies(),
        .linux => _linuxFamilies(),
        _ => const <String>{},
      };
      return _cachedFamilies = normalizeFamilies(families);
    } catch (error) {
      debugPrint('System font enumeration failed: $error');
      return _cachedFamilies = const {};
    }
  }

  @visibleForTesting
  static Set<String> normalizeFamilies(Iterable<String> families) =>
      families
          .map((family) => family.trim())
          .where((family) => family.isNotEmpty && !family.startsWith('@'))
          .toSet();

  static Set<String> _androidFamilies() {
    final fontFamilies = AndroidHelper.fontFamilies();
    if (fontFamilies == null) return const {};
    try {
      return {
        for (var index = 0; index < fontFamilies.length; index++)
          if (fontFamilies[index] case final family?)
            family.toDartString(releaseOriginal: true),
      };
    } finally {
      fontFamilies.release();
    }
  }

  static Set<String> _windowsFamilies() {
    final fonts = <String>{};
    final deviceContext = GetDC(null);
    if (deviceContext == 0) return fonts;

    final logFont = calloc<LOGFONT>();
    logFont.ref
      ..lfCharSet = DEFAULT_CHARSET
      ..lfFaceName = '';
    _windowsFontSink = fonts;
    try {
      EnumFontFamiliesEx(
        deviceContext,
        logFont,
        Pointer.fromFunction(_enumFontCallback, 0),
        const LPARAM(0),
        0,
      );
    } finally {
      calloc.free(logFont);
      ReleaseDC(null, deviceContext);
      _windowsFontSink = null;
    }
    return fonts;
  }

  static int _enumFontCallback(
    Pointer<LOGFONT> logFont,
    Pointer<TEXTMETRIC> textMetric,
    int fontType,
    int lParam,
  ) {
    final family = logFont.ref.lfFaceName;
    if (!family.startsWith('@')) _windowsFontSink?.add(family);
    return 1;
  }

  static Set<String> _linuxFamilies() {
    final fontConfig = FontConfig(DynamicLibrary.open('libfontconfig.so.1'));
    final config = fontConfig.FcInitLoadConfigAndFonts();
    if (config == nullptr) return const {};

    try {
      final fontSet = fontConfig.FcConfigGetFonts(config, FcSetName.FcSetSystem);
      if (fontSet == nullptr) return const {};

      final fonts = <String>{};
      final familyKey = FC_FAMILY.toNativeUtf8().cast<Char>();
      try {
        for (var index = 0; index < fontSet.ref.nfont; index++) {
          final pattern = fontSet.ref.fonts[index];
          if (pattern == nullptr) continue;

          final outPointer = calloc<Pointer<UnsignedChar>>();
          try {
            if (fontConfig.FcPatternGetString(
                  pattern,
                  familyKey,
                  0,
                  outPointer,
                ) ==
                0) {
              final family = outPointer.value;
              if (family != nullptr) fonts.add(family.cast<Utf8>().toDartString());
            }
          } finally {
            calloc.free(outPointer);
          }
        }
      } finally {
        calloc.free(familyKey);
      }
      return fonts;
    } finally {
      fontConfig.FcConfigDestroy(config);
    }
  }
}
