import 'package:ex_piliplus/l10n/generated/app_localizations.dart';
import 'package:ex_piliplus/models/common/enum_with_label.dart';

enum SuperChatType implements EnumWithLabel {
  valid('有效时间内显示'),
  persist('常驻显示'),
  disable('不显示'),
  ;

  @override
  final String label;
  String get title => label;
  const SuperChatType(this.label);

  String localizedTitle(AppLocalizations l10n) => switch (this) {
    .valid => l10n.settingsSuperChatValidOnly,
    .persist => l10n.settingsSuperChatPersistent,
    .disable => l10n.settingsSuperChatDisabled,
  };
}
