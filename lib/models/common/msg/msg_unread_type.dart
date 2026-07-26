import 'package:ex_piliplus/l10n/generated/app_localizations.dart';

enum MsgUnReadType {
  pm('私信'),
  reply('回复我的'),
  at('@我'),
  like('收到的赞'),
  sysMsg('系统通知'),
  ;

  final String title;
  const MsgUnReadType(this.title);

  String localizedTitle(AppLocalizations l10n) => switch (this) {
    .pm => l10n.settingsUnreadPrivateMessages,
    .reply => l10n.settingsUnreadReplies,
    .at => l10n.settingsUnreadMentions,
    .like => l10n.settingsUnreadLikes,
    .sysMsg => l10n.settingsUnreadSystem,
  };
}
