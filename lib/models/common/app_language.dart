import 'package:ex_piliplus/l10n/generated/app_localizations.dart';
import 'package:flutter/widgets.dart';

enum AppLanguage {
  system('system'),
  simplifiedChinese('zhHans'),
  traditionalChinese('zhHant'),
  english('en'),
  ;

  const AppLanguage(this.storageValue);

  final String storageValue;

  Locale? get locale => switch (this) {
    .system => null,
    .simplifiedChinese => const Locale('zh'),
    .traditionalChinese => const Locale.fromSubtags(
      languageCode: 'zh',
      scriptCode: 'Hant',
    ),
    .english => const Locale('en'),
  };

  String localizedName(AppLocalizations l10n) => switch (this) {
    .system => l10n.languageSystemDefault,
    .simplifiedChinese => l10n.languageSimplifiedChinese,
    .traditionalChinese => l10n.languageTraditionalChinese,
    .english => l10n.languageEnglish,
  };

  static AppLanguage fromStorage(Object? value) {
    return values.firstWhere(
      (language) => language.storageValue == value,
      orElse: () => simplifiedChinese,
    );
  }
}
