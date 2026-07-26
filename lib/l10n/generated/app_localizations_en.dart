// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get commonCancel => 'Cancel';

  @override
  String get commonConfirm => 'Confirm';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get settingsSearch => 'Search';

  @override
  String get settingsPrivacyTitle => 'Privacy';

  @override
  String get settingsPrivacySummary => 'Blocked users';

  @override
  String get settingsRecommendationFeedTitle => 'Recommendation feed';

  @override
  String get settingsRecommendationFeedSummary =>
      'Source, refresh behavior, and filters';

  @override
  String get settingsAudioVideoTitle => 'Audio & video';

  @override
  String get settingsAudioVideoSummary =>
      'Quality, codecs, buffering, and audio output';

  @override
  String get settingsPlayerTitle => 'Player';

  @override
  String get settingsPlayerSummary =>
      'Gestures, full screen, background playback, danmaku, and subtitles';

  @override
  String get settingsAppearanceTitle => 'Appearance';

  @override
  String get settingsAppearanceSummary =>
      'Layout, navigation, feed, theme, fonts, and images';

  @override
  String get settingsGeneralTitle => 'General';

  @override
  String get settingsGeneralSummary =>
      'Haptics, search, favorites, AI, comments, proxy, and updates';

  @override
  String get settingsExPiliPlusTitle => 'ExPiliPlus';

  @override
  String get settingsExPiliPlusSummary =>
      'Language, custom theme color, fonts, shuffle, and auto-like';

  @override
  String get settingsWebDavTitle => 'WebDAV';

  @override
  String get settingsAboutTitle => 'About';

  @override
  String get settingsSwitchAccount => 'Switch account';

  @override
  String get settingsSignOut => 'Sign out';

  @override
  String get settingsAppLanguage => 'App language';

  @override
  String settingsCurrentLanguage(String language) {
    return 'Current: $language';
  }

  @override
  String get languagePickerTitle => 'App language';

  @override
  String get languageSystemDefault => 'System default';

  @override
  String get languageSimplifiedChinese => 'Simplified Chinese';

  @override
  String get languageTraditionalChinese => 'Traditional Chinese';

  @override
  String get languageEnglish => 'English';

  @override
  String get settingsCustomThemeColor => 'Custom theme color';

  @override
  String get settingsCustomThemeColorDisabled =>
      'Off — using dynamic color or a PiliPlus preset';

  @override
  String settingsCustomThemeColorSavedOverridden(String color) {
    return 'Saved as $color; dynamic color is currently active';
  }

  @override
  String settingsCurrentValue(String value) {
    return 'Current: $value';
  }

  @override
  String get settingsAppFont => 'App font';

  @override
  String get settingsAppFontWeight => 'Font weight';

  @override
  String get settingsTapToConfigure => 'Tap to configure';

  @override
  String get settingsUploaderProfileShuffle =>
      'Show shuffle on uploader profiles';

  @override
  String get settingsAutoLikeOpenedVideos => 'Auto-like opened videos';

  @override
  String get settingsAutoLikeOpenedVideosDescription =>
      'Automatically likes a video once when you open its details; videos you already liked are skipped';

  @override
  String get settingsPiliPlusThemeRestored => 'PiliPlus theme color restored';

  @override
  String settingsThemeColorSet(String color) {
    return 'Theme color set to $color';
  }

  @override
  String get settingsLoadingFont => 'Loading font';
}
