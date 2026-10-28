import 'package:cupertino_ui/cupertino_ui.dart' as cupertino_ui;
import 'package:ex_piliplus/l10n/generated/app_localizations.dart'
    show AppLocalizations;
import 'package:flutter/widgets.dart' show LocalizationsDelegate;
import 'package:flutter_localizations/flutter_localizations.dart'
    as flutter_localizations;
import 'package:material_ui/material_ui.dart' as material_ui;

const List<LocalizationsDelegate<dynamic>> appLocalizationsDelegates = [
  AppLocalizations.delegate,
  material_ui.GlobalMaterialLocalizations.delegate,
  cupertino_ui.GlobalCupertinoLocalizations.delegate,
  flutter_localizations.GlobalMaterialLocalizations.delegate,
  flutter_localizations.GlobalCupertinoLocalizations.delegate,
  flutter_localizations.GlobalWidgetsLocalizations.delegate,
];
