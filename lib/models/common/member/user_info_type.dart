import 'package:ex_piliplus/l10n/generated/app_localizations.dart';
import 'package:flutter/material.dart' show Alignment;

enum UserInfoType {
  fan(.centerLeft),
  follow(.center),
  like(.centerRight),
  ;

  final Alignment alignment;

  const UserInfoType(this.alignment);

  String localizedTitle(AppLocalizations l10n) => switch (this) {
    .fan => l10n.mineFollowers,
    .follow => l10n.mineFollowing,
    .like => l10n.memberLikesReceived,
  };
}
