import 'package:ex_piliplus/l10n/generated/app_localizations.dart';
import 'package:flutter/material.dart' show IconData, Icons;

enum StatType {
  view(Icons.remove_red_eye_outlined),
  danmaku(Icons.subtitles_outlined),
  like(Icons.thumb_up_outlined),
  reply(Icons.comment_outlined),
  follow(Icons.favorite_border),
  play(Icons.play_circle_outlined),
  listen(Icons.headset_outlined),
  ;

  final IconData iconData;
  const StatType(this.iconData);

  String localizedLabel(AppLocalizations l10n) => switch (this) {
    .view => l10n.commonView,
    .danmaku => l10n.settingsDanmakuEnabled,
    .like => l10n.commonLike,
    .reply => l10n.commonReply,
    .follow => l10n.memberFollow,
    .play => l10n.commonPlay,
    .listen => l10n.videoListenToAudio,
  };
}
