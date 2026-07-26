import 'package:ex_piliplus/common/widgets/custom_icon.dart';
import 'package:ex_piliplus/l10n/generated/app_localizations.dart';
import 'package:ex_piliplus/models/common/enum_with_label.dart';
import 'package:ex_piliplus/pages/dynamics/view.dart';
import 'package:ex_piliplus/pages/home/view.dart';
import 'package:ex_piliplus/pages/mine/view.dart';
import 'package:flutter/material.dart';

enum NavigationBarType implements EnumWithLabel {
  home(
    '首页',
    Icon(Icons.home_outlined),
    Icon(Icons.home),
    HomePage(),
  ),
  dynamics(
    '动态',
    Icon(CustomIcons.motion_photos_on_outlined),
    Icon(CustomIcons.motion_photos_on),
    DynamicsPage(),
  ),
  mine(
    '我的',
    Icon(Icons.person_outline),
    Icon(Icons.person),
    MinePage(),
  ),
  ;

  @override
  final String label;
  final Icon icon;
  final Icon selectIcon;
  final Widget page;

  const NavigationBarType(this.label, this.icon, this.selectIcon, this.page);

  String localizedLabel(AppLocalizations l10n) => switch (this) {
    .home => l10n.navigationHome,
    .dynamics => l10n.navigationFeed,
    .mine => l10n.navigationMe,
  };
}
