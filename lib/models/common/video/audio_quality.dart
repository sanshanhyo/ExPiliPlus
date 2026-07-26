import 'package:ex_piliplus/l10n/generated/app_localizations.dart';

enum AudioQuality {
  u_100010(100010, '100010'),
  u_100009(100009, '100009'),
  u_100008(100008, '100008'),
  hiRes(30251, 'Hi-Res无损'),
  dolby_30250(30250, '杜比全景声'),
  dolby_30255(30255, '杜比全景声'),
  k192(30280, '192K'),
  k132(30232, '132K'),
  k64(30216, '64K'),
  ;

  final int code;
  final String desc;

  const AudioQuality(this.code, this.desc);

  String localizedLabel(AppLocalizations l10n) => switch (this) {
    .hiRes => 'Hi-Res Lossless',
    .dolby_30250 || .dolby_30255 => 'Dolby Atmos',
    _ => desc,
  };

  static final _codeMap = {for (final i in values) i.code: i};

  static AudioQuality fromCode(int code) => _codeMap[code]!;

  static AudioQuality? maybeFromCode(int? code) => _codeMap[code];
}
