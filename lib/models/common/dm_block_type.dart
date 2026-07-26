import 'package:ex_piliplus/l10n/generated/app_localizations.dart';

enum DmBlockType {
  keyword,
  regex,
  uid,
  ;

  String localizedLabel(AppLocalizations l10n) => switch (this) {
    .keyword => l10n.danmakuBlockKeyword,
    .regex => l10n.danmakuBlockRegex,
    .uid => l10n.danmakuBlockUser,
  };
}
