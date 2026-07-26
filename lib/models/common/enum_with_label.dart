import 'package:ex_piliplus/l10n/generated/app_localizations.dart';

mixin EnumWithLabel on Enum {
  String get label;
}

extension EnumWithLocalizedLabel on EnumWithLabel {
  String localizedLabel(AppLocalizations l10n) => label;
}
