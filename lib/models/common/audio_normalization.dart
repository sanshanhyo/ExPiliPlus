import 'package:ex_piliplus/l10n/generated/app_localizations.dart';

enum AudioNormalization {
  disable('禁用'),
  // ref https://github.com/KRTirtho/spotube/commit/da10ab2e291d4ba4d3082b9a6ae535639fb8f1b7
  dynaudnorm('预设 dynaudnorm', 'dynaudnorm=g=5:f=250:r=0.9:p=0.5'),
  loudnorm('预设 loudnorm', 'loudnorm=I=-16:LRA=11:TP=-1.5'),
  custom('自定义参数'),
  ;

  final String title;
  final String param;
  const AudioNormalization(this.title, [this.param = '']);

  String localizedTitle(AppLocalizations l10n) => switch (this) {
    .disable => l10n.settingsAudioNormalizationDisabled,
    .dynaudnorm => l10n.settingsAudioNormalizationDynaudnorm,
    .loudnorm => l10n.settingsAudioNormalizationLoudnorm,
    .custom => l10n.settingsCustomParameters,
  };

  static String getTitleFromConfig(String config) => switch (config) {
    '0' => disable.title,
    '1' => dynaudnorm.title,
    '2' => loudnorm.title,
    _ => config,
  };

  static String localizedTitleFromConfig(
    String config,
    AppLocalizations l10n,
  ) => switch (config) {
    '0' => disable.localizedTitle(l10n),
    '1' => dynaudnorm.localizedTitle(l10n),
    '2' => loudnorm.localizedTitle(l10n),
    _ => config,
  };

  static String getParamFromConfig(String config) => switch (config) {
    '0' => disable.param,
    '1' => dynaudnorm.param,
    '2' => loudnorm.param,
    _ => config,
  };
}
