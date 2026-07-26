import 'package:ex_piliplus/l10n/generated/app_localizations.dart';

enum WebviewMenuItem {
  refresh,
  copy,
  openInBrowser,
  clearCache,
  resetCookie,
  goBack,
  ;

  String localizedTitle(AppLocalizations l10n) => switch (this) {
    .refresh => l10n.webRefresh,
    .copy => l10n.webCopyLink,
    .openInBrowser => l10n.webOpenInBrowser,
    .clearCache => l10n.webClearCache,
    .resetCookie => l10n.webResetCookie,
    .goBack => l10n.webGoBack,
  };
}
