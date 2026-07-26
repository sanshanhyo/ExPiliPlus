import 'package:ex_piliplus/l10n/generated/app_localizations.dart';
import 'package:flutter/material.dart';

const List<ThemeColorType> colorThemeTypes = [
  ThemeColorType(Color(0xFF5CB67B), ThemeColorName.defaultGreen),
  ThemeColorType(Color(0xFFFF7299), ThemeColorName.pink),
  ThemeColorType(Colors.red, ThemeColorName.red),
  ThemeColorType(Colors.orange, ThemeColorName.orange),
  ThemeColorType(Colors.amber, ThemeColorName.amber),
  ThemeColorType(Colors.yellow, ThemeColorName.yellow),
  ThemeColorType(Colors.lime, ThemeColorName.lime),
  ThemeColorType(Colors.lightGreen, ThemeColorName.lightGreen),
  ThemeColorType(Colors.green, ThemeColorName.green),
  ThemeColorType(Colors.teal, ThemeColorName.teal),
  ThemeColorType(Colors.cyan, ThemeColorName.cyan),
  ThemeColorType(Colors.lightBlue, ThemeColorName.lightBlue),
  ThemeColorType(Colors.blue, ThemeColorName.blue),
  ThemeColorType(Colors.indigo, ThemeColorName.indigo),
  ThemeColorType(Colors.purple, ThemeColorName.purple),
  ThemeColorType(Colors.deepPurple, ThemeColorName.deepPurple),
  ThemeColorType(Colors.blueGrey, ThemeColorName.blueGrey),
  ThemeColorType(Colors.brown, ThemeColorName.brown),
  ThemeColorType(Colors.grey, ThemeColorName.grey),
];

class ThemeColorType {
  const ThemeColorType(this.color, this.name);

  final Color color;
  final ThemeColorName name;

  String localizedLabel(AppLocalizations l10n) => name.localizedLabel(l10n);
}

enum ThemeColorName {
  defaultGreen,
  pink,
  red,
  orange,
  amber,
  yellow,
  lime,
  lightGreen,
  green,
  teal,
  cyan,
  lightBlue,
  blue,
  indigo,
  purple,
  deepPurple,
  blueGrey,
  brown,
  grey;

  String localizedLabel(AppLocalizations l10n) => switch (this) {
    .defaultGreen => l10n.themeColorDefaultGreen,
    .pink => l10n.themeColorPink,
    .red => l10n.themeColorRed,
    .orange => l10n.themeColorOrange,
    .amber => l10n.themeColorAmber,
    .yellow => l10n.themeColorYellow,
    .lime => l10n.themeColorLime,
    .lightGreen => l10n.themeColorLightGreen,
    .green => l10n.themeColorGreen,
    .teal => l10n.themeColorTeal,
    .cyan => l10n.themeColorCyan,
    .lightBlue => l10n.themeColorLightBlue,
    .blue => l10n.themeColorBlue,
    .indigo => l10n.themeColorIndigo,
    .purple => l10n.themeColorPurple,
    .deepPurple => l10n.themeColorDeepPurple,
    .blueGrey => l10n.themeColorBlueGrey,
    .brown => l10n.themeColorBrown,
    .grey => l10n.themeColorGrey,
  };
}
