import 'package:ex_piliplus/l10n/generated/app_localizations.dart';
import 'package:ex_piliplus/models/common/app_language.dart';
import 'package:ex_piliplus/services/app_locale_controller.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppLanguage', () {
    test('uses stable persisted values and a simplified Chinese fallback', () {
      for (final language in AppLanguage.values) {
        expect(AppLanguage.fromStorage(language.storageValue), language);
      }
      expect(AppLanguage.fromStorage(null), AppLanguage.simplifiedChinese);
      expect(
        AppLanguage.fromStorage('unsupported'),
        AppLanguage.simplifiedChinese,
      );
    });

    test('exposes explicit locales and a null system locale', () {
      expect(AppLanguage.system.locale, isNull);
      expect(AppLanguage.simplifiedChinese.locale, const Locale('zh'));
      expect(AppLanguage.english.locale, const Locale('en'));
      expect(AppLanguage.traditionalChinese.locale?.languageCode, 'zh');
      expect(AppLanguage.traditionalChinese.locale?.scriptCode, 'Hant');
    });
  });

  group('AppLocaleController', () {
    test('resolves supported locales and falls back to simplified Chinese', () {
      const supported = [
        Locale('en'),
        Locale('zh'),
        Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hant'),
      ];

      expect(
        AppLocaleController.resolve(const Locale('en', 'US'), supported),
        const Locale('en'),
      );
      expect(
        AppLocaleController.resolve(const Locale('zh', 'TW'), supported),
        const Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hant'),
      );
      expect(
        AppLocaleController.resolve(const Locale('ja'), supported),
        const Locale('zh'),
      );
    });
  });

  group('generated localizations', () {
    test('loads all initial languages', () async {
      final simplified = await AppLocalizations.delegate.load(
        const Locale('zh'),
      );
      final traditional = await AppLocalizations.delegate.load(
        const Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hant'),
      );
      final english = await AppLocalizations.delegate.load(const Locale('en'));

      expect(simplified.settingsTitle, '设置');
      expect(traditional.settingsTitle, '設定');
      expect(english.settingsTitle, 'Settings');
      expect(english.settingsCurrentLanguage('English'), 'Current: English');
    });
  });
}
