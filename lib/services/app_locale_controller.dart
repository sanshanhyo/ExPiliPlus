import 'package:ex_piliplus/models/common/app_language.dart';
import 'package:ex_piliplus/utils/storage.dart';
import 'package:ex_piliplus/utils/storage_key.dart';
import 'package:ex_piliplus/utils/storage_pref.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

abstract final class AppLocaleController {
  static const Locale fallbackLocale = Locale('zh');

  static final ValueNotifier<Locale?> locale = ValueNotifier(
    Pref.appLanguage.locale,
  );

  static Future<void> setLanguage(AppLanguage language) async {
    await GStorage.setting.put(
      SettingBoxKey.appLanguage,
      language.storageValue,
    );
    Get.locale = language.locale;
    locale.value = language.locale;
  }

  static void syncFromStorage() {
    final storedLocale = Pref.appLanguage.locale;
    Get.locale = storedLocale;
    locale.value = storedLocale;
  }

  static Locale resolve(
    Locale? requestedLocale,
    Iterable<Locale> supportedLocales,
  ) {
    final supported = supportedLocales.toList(growable: false);
    if (supported.isEmpty) return fallbackLocale;

    if (requestedLocale != null) {
      for (final locale in supported) {
        if (_sameLocale(locale, requestedLocale)) return locale;
      }

      if (requestedLocale.languageCode == 'zh' &&
          (requestedLocale.scriptCode == 'Hant' ||
              const {'HK', 'MO', 'TW'}.contains(requestedLocale.countryCode))) {
        for (final locale in supported) {
          if (locale.languageCode == 'zh' && locale.scriptCode == 'Hant') {
            return locale;
          }
        }
      }

      for (final locale in supported) {
        if (locale.languageCode == requestedLocale.languageCode) return locale;
      }
    }

    return supported.firstWhere(
      (locale) => _sameLocale(locale, fallbackLocale),
      orElse: () => supported.first,
    );
  }

  static bool _sameLocale(Locale first, Locale second) {
    return first.languageCode == second.languageCode &&
        first.scriptCode == second.scriptCode &&
        first.countryCode == second.countryCode;
  }
}
