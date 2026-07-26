import 'package:ex_piliplus/l10n/generated/app_localizations.dart';
import 'package:ex_piliplus/pages/later/child_view.dart';
import 'package:flutter/material.dart';

enum LaterViewType {
  all(0, '全部'),
  // toView(1, '未看'),
  unfinished(2, '未看完'),
  // viewed(3, '已看完'),
  ;

  Widget get page => LaterViewChildPage(laterViewType: this);

  final int type;
  final String title;
  const LaterViewType(this.type, this.title);

  String localizedTitle(AppLocalizations l10n) => switch (this) {
    .all => l10n.laterAll,
    .unfinished => l10n.laterUnfinished,
  };
}
