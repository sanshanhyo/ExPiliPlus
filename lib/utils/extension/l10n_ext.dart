import 'package:ex_piliplus/l10n/generated/app_localizations.dart';
import 'package:flutter/widgets.dart';

extension L10nExt on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);
}
