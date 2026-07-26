import 'package:ex_piliplus/l10n/generated/app_localizations.dart';
import 'package:ex_piliplus/utils/bili_colors.dart';
import 'package:flutter/material.dart';

enum BadgeType {
  none(),
  vip(),
  person(BiliColors.yellow),
  institution(Colors.lightBlueAccent),
  ;

  final Color? color;
  const BadgeType([this.color]);

  String? localizedDescription(AppLocalizations l10n) => switch (this) {
    .none => null,
    .vip => l10n.avatarVipBadge,
    .person => l10n.avatarVerifiedIndividual,
    .institution => l10n.avatarVerifiedOrganization,
  };
}
