import 'package:ex_piliplus/l10n/generated/app_localizations.dart';
import 'package:ex_piliplus/pages/setting/models/extra_settings.dart';
import 'package:ex_piliplus/pages/setting/models/ex_features_settings.dart';
import 'package:ex_piliplus/pages/setting/models/model.dart';
import 'package:ex_piliplus/pages/setting/models/play_settings.dart';
import 'package:ex_piliplus/pages/setting/models/privacy_settings.dart';
import 'package:ex_piliplus/pages/setting/models/recommend_settings.dart';
import 'package:ex_piliplus/pages/setting/models/style_settings.dart';
import 'package:ex_piliplus/pages/setting/models/video_settings.dart';
import 'package:flutter/widgets.dart';

enum SettingType {
  privacySetting,
  recommendSetting,
  videoSetting,
  playSetting,
  styleSetting,
  extraSetting,
  exPiliPlusSetting,
  webdavSetting,
  about,
  ;

  String localizedTitle(AppLocalizations l10n) => switch (this) {
    .privacySetting => l10n.settingsPrivacyTitle,
    .recommendSetting => l10n.settingsRecommendationFeedTitle,
    .videoSetting => l10n.settingsAudioVideoTitle,
    .playSetting => l10n.settingsPlayerTitle,
    .styleSetting => l10n.settingsAppearanceTitle,
    .extraSetting => l10n.settingsGeneralTitle,
    .exPiliPlusSetting => l10n.settingsExPiliPlusTitle,
    .webdavSetting => l10n.settingsWebDavTitle,
    .about => l10n.settingsAboutTitle,
  };

  String? localizedSubtitle(AppLocalizations l10n) => switch (this) {
    .privacySetting => l10n.settingsPrivacySummary,
    .recommendSetting => l10n.settingsRecommendationFeedSummary,
    .videoSetting => l10n.settingsAudioVideoSummary,
    .playSetting => l10n.settingsPlayerSummary,
    .styleSetting => l10n.settingsAppearanceSummary,
    .extraSetting => l10n.settingsGeneralSummary,
    .exPiliPlusSetting => l10n.settingsExPiliPlusSummary,
    .webdavSetting || .about => null,
  };

  List<SettingsModel> settings(BuildContext context) => switch (this) {
    .privacySetting => privacySettings(context),
    .recommendSetting => recommendSettings(context),
    .videoSetting => videoSettings(context),
    .playSetting => playSettings(context),
    .styleSetting => styleSettings(context),
    .extraSetting => extraSettings(context),
    .exPiliPlusSetting => exFeatureSettings(context),
    _ => throw UnimplementedError(),
  };
}
