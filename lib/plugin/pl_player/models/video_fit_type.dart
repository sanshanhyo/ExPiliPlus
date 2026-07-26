import 'package:ex_piliplus/common/style.dart';
import 'package:ex_piliplus/l10n/generated/app_localizations.dart';
import 'package:flutter/material.dart' show BoxFit;

enum VideoFitType {
  fill('拉伸', boxFit: BoxFit.fill),
  contain('自动', boxFit: BoxFit.contain),
  cover('裁剪', boxFit: BoxFit.cover),
  fitWidth('等宽', boxFit: BoxFit.fitWidth),
  fitHeight('等高', boxFit: BoxFit.fitHeight),
  none('原始', boxFit: BoxFit.none),
  scaleDown('限制', boxFit: BoxFit.scaleDown),
  ratio_4x3('4:3', aspectRatio: 4 / 3),
  ratio_16x9('16:9', aspectRatio: Style.aspectRatio16x9),
  ;

  final String desc;
  final BoxFit boxFit;
  final double? aspectRatio;
  const VideoFitType(
    this.desc, {
    this.boxFit = BoxFit.contain,
    this.aspectRatio,
  });

  String localizedLabel(AppLocalizations l10n) => switch (this) {
    .fill => l10n.playerFitStretch,
    .contain => l10n.playerFitAuto,
    .cover => l10n.playerFitCrop,
    .fitWidth => l10n.playerFitWidth,
    .fitHeight => l10n.playerFitHeight,
    .none => l10n.playerFitOriginal,
    .scaleDown => l10n.playerFitScaleDown,
    .ratio_4x3 => '4:3',
    .ratio_16x9 => '16:9',
  };
}
