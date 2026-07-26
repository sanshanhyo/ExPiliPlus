import 'package:ex_piliplus/l10n/generated/app_localizations.dart';

enum SuperChatType {
  valid('有效时间内显示'),
  persist('常驻显示'),
  disable('不显示'),
  ;

  final String title;
  const SuperChatType(this.title);

  String localizedTitle(AppLocalizations l10n) => switch (this) {
    .valid => l10n.settingsSuperChatValidOnly,
    .persist => l10n.settingsSuperChatPersistent,
    .disable => l10n.settingsSuperChatDisabled,
  };
}
