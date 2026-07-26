import 'package:ex_piliplus/l10n/generated/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

enum ReplyOptionType {
  allow,
  close,
  choose,
  ;

  String localizedTitle(AppLocalizations l10n) => switch (this) {
    .allow => l10n.feedAllowComments,
    .close => l10n.feedCloseComments,
    .choose => l10n.feedFeaturedComments,
  };

  IconData get iconData => switch (this) {
    ReplyOptionType.allow => MdiIcons.commentTextOutline,
    ReplyOptionType.close => MdiIcons.commentOffOutline,
    ReplyOptionType.choose => MdiIcons.commentProcessingOutline,
  };
}
