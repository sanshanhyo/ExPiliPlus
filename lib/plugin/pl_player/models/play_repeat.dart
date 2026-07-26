import 'package:ex_piliplus/l10n/generated/app_localizations.dart';
import 'package:ex_piliplus/models/common/enum_with_label.dart';

enum PlayRepeat implements EnumWithLabel {
  pause('播完暂停'),
  listOrder('顺序播放'),
  singleCycle('单个循环'),
  listCycle('列表循环'),
  autoPlayRelated('自动连播'),
  ;

  @override
  final String label;
  const PlayRepeat(this.label);

  String localizedLabel(AppLocalizations l10n) => switch (this) {
    .pause => l10n.playerRepeatPauseAtEnd,
    .listOrder => l10n.playerRepeatListOrder,
    .singleCycle => l10n.playerRepeatSingle,
    .listCycle => l10n.playerRepeatList,
    .autoPlayRelated => l10n.playerRepeatAutoplayRelated,
  };
}
