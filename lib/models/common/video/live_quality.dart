import 'package:ex_piliplus/l10n/generated/app_localizations.dart';

enum LiveQuality {
  dolby(30000, '杜比'),
  origin4K(25000, '4K 原画'),
  super4K(20000, '4K'),
  super2K(15000, '2K'),
  origin(10000, '原画'),
  bluRay(400, '蓝光'),
  superHD(250, '超清'),
  smooth(150, '高清'),
  flunt(80, '流畅'),
  ;

  final int code;
  final String desc;
  const LiveQuality(this.code, this.desc);

  String localizedLabel(AppLocalizations l10n) => switch (this) {
    .dolby => l10n.settingsLiveQualityDolby,
    .origin4K => l10n.settingsLiveQuality4kOriginal,
    .super4K => l10n.settingsLiveQuality4k,
    .super2K => l10n.settingsLiveQuality2k,
    .origin => l10n.settingsLiveQualityOriginal,
    .bluRay => l10n.settingsLiveQualityBluRay,
    .superHD => l10n.settingsLiveQualitySuperHd,
    .smooth => l10n.settingsLiveQualityHd,
    .flunt => l10n.settingsLiveQualitySmooth,
  };

  static LiveQuality? fromCode(int? code) {
    for (final e in LiveQuality.values) {
      if (e.code == code) {
        return e;
      }
    }
    return null;
  }
}
