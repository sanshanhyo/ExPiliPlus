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
  String get settingsSystemDefaultFont => 'System default';

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

  @override
  String get commonSearch => 'Search';

  @override
  String get commonImport => 'Import';

  @override
  String get commonContinue => 'Continue';

  @override
  String get commonPrevious => 'Back';

  @override
  String get commonNext => 'Next';

  @override
  String get commonDefault => 'Default';

  @override
  String get commonRefresh => 'Refresh';

  @override
  String get commonSeeMore => 'See more';

  @override
  String get commonListSeparator => ', ';

  @override
  String commonItemCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count items',
      one: '1 item',
    );
    return '$_temp0';
  }

  @override
  String get navigationHome => 'Home';

  @override
  String get navigationFeed => 'Feed';

  @override
  String get navigationMe => 'Me';

  @override
  String get navigationLive => 'Live';

  @override
  String get navigationRecommended => 'Recommended';

  @override
  String get navigationTrending => 'Trending';

  @override
  String get navigationCategories => 'Categories';

  @override
  String get navigationAnime => 'Anime';

  @override
  String get navigationMoviesAndTv => 'Movies & TV';

  @override
  String get navigationMessages => 'Messages';

  @override
  String get desktopShowWindow => 'Show window';

  @override
  String desktopExitApp(String appName) {
    return 'Quit $appName';
  }

  @override
  String get themeLight => 'Light';

  @override
  String get themeDark => 'Dark';

  @override
  String get themeSystem => 'Use system setting';

  @override
  String get accountTapToSignIn => 'Tap to sign in';

  @override
  String get accountPleaseSignIn => 'Please sign in first';

  @override
  String get accessibilityPremium => 'Premium';

  @override
  String get accessibilityDefaultAvatar => 'Default avatar';

  @override
  String get mineDownloads => 'Downloads';

  @override
  String get mineWatchHistory => 'Watch history';

  @override
  String get mineSubscriptions => 'Subscriptions';

  @override
  String get mineWatchLater => 'Watch later';

  @override
  String get mineCommentHistory => 'Comment history';

  @override
  String get mineEnterIncognito => 'Turn on Incognito';

  @override
  String get mineExitIncognito => 'Turn off Incognito';

  @override
  String mineSwitchTheme(String theme) {
    return 'Switch to $theme theme';
  }

  @override
  String get mineIncognitoEntered => 'Incognito is on';

  @override
  String get mineIncognitoDescription =>
      'Searches won\'t include your identity\nSearch and watch history won\'t be saved\nLikes and other actions aren\'t affected\nWatch progress follows the video stream\n(See Privacy settings for details)';

  @override
  String get mineIncognitoPermanentSet => 'Incognito will stay on';

  @override
  String get mineIncognitoSavePermanently => 'Keep Incognito on';

  @override
  String get mineIncognitoTemporarySet => 'Incognito is on for this session';

  @override
  String get mineIncognitoThisSession => 'This session only (default)';

  @override
  String get mineIncognitoExited => 'Incognito is off';

  @override
  String get mineCoins => 'Coins';

  @override
  String get mineXp => 'XP';

  @override
  String get minePosts => 'Posts';

  @override
  String get mineFollowing => 'Following';

  @override
  String get mineFollowers => 'Followers';

  @override
  String get mineFavorites => 'Favorites';

  @override
  String get favoritePublic => 'Public';

  @override
  String get favoritePrivate => 'Private';

  @override
  String favoriteFolderSummary(int count, String visibility) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count videos · $visibility',
      one: '1 video · $visibility',
    );
    return '$_temp0';
  }

  @override
  String get onboardingStepWelcome => 'Welcome';

  @override
  String get onboardingStepImport => 'Import';

  @override
  String get onboardingStepAppearance => 'Appearance';

  @override
  String get onboardingStepAccount => 'Account';

  @override
  String get onboardingStepFinish => 'Finish';

  @override
  String get onboardingWelcomeTitle => 'Welcome to ExPiliPlus';

  @override
  String get onboardingWelcomeSubtitle =>
      'Built on PiliPlus, with more personalization and experimental features (｡･∀･)ﾉﾞ';

  @override
  String get onboardingWelcomeMigrateSettings => 'Move your existing settings';

  @override
  String get onboardingWelcomeAppearance =>
      'Set up your appearance preferences';

  @override
  String get onboardingWelcomeAccount =>
      'Sign in or import a local account backup';

  @override
  String get onboardingImportTitle => 'Import';

  @override
  String get onboardingImportSubtitle =>
      'Move settings from a local PiliPlus / ExPiliPlus file or WebDAV backup, or start fresh.';

  @override
  String get onboardingImportLocal => 'Import from a local file';

  @override
  String get onboardingImportLocalDescription =>
      'Choose an exported settings JSON file';

  @override
  String get onboardingImportWebDav => 'Import from WebDAV';

  @override
  String get onboardingImportWebDavDescription =>
      'Use the settings file in a WebDAV backup';

  @override
  String get onboardingStartFresh => 'Start fresh';

  @override
  String get onboardingStartFreshDescription =>
      'Continue with the default settings';

  @override
  String get onboardingAppearanceTitle => 'Appearance';

  @override
  String get onboardingAppearanceDescription =>
      'Choose a comfortable viewing experience. You can change it later in Settings.';

  @override
  String get onboardingAppearanceImportedDescription =>
      'Your imported settings are applied. You can fine-tune them here.';

  @override
  String get onboardingFontSize => 'Font size';

  @override
  String get onboardingLargeScreenOptimization => 'Optimize for large screens';

  @override
  String get onboardingLargeScreenOptimizationDescription =>
      'Use navigation designed for tablets and landscape screens';

  @override
  String get onboardingAccountTitle => 'Account';

  @override
  String get onboardingAccountDescription =>
      'Sign in to sync favorites, history, and subscriptions, or import sign-in information from a local account backup.';

  @override
  String get onboardingSignIn => 'Sign in';

  @override
  String get onboardingSignInDescription => 'Use an existing sign-in method';

  @override
  String get onboardingImportAccount => 'Import account from a local backup';

  @override
  String get onboardingImportAccountDescription =>
      'Choose an exported sign-in information JSON file';

  @override
  String get onboardingSkipSignIn => 'Not now';

  @override
  String get onboardingSkipSignInDescription =>
      'Open the app now and sign in at any time';

  @override
  String get onboardingReadyTitle => 'You\'re all set';

  @override
  String get onboardingReadyDescription => 'Welcome to ExPiliPlus.';

  @override
  String get onboardingUsingDefaultSettings => 'Using default settings';

  @override
  String get onboardingNotSignedIn => 'Not signed in';

  @override
  String get onboardingGetStarted => 'Get started';

  @override
  String get onboardingStartUsing => 'Start using ExPiliPlus';

  @override
  String get onboardingSourceLocalFile => 'local file';

  @override
  String get onboardingSourceWebDavBackup => 'WebDAV backup';

  @override
  String onboardingWebDavReadFailed(String error) {
    return 'Couldn\'t read WebDAV: $error';
  }

  @override
  String onboardingSettingsParseFailed(String error) {
    return 'Couldn\'t parse settings: $error';
  }

  @override
  String onboardingSettingsImported(int count, String categories) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Imported $count settings ($categories)',
      one: 'Imported 1 setting ($categories)',
    );
    return '$_temp0';
  }

  @override
  String get onboardingSettingsImportSucceeded => 'Settings imported';

  @override
  String onboardingAccountParseFailed(String error) {
    return 'Couldn\'t parse sign-in information: $error';
  }

  @override
  String onboardingSignedInMid(int mid) {
    return 'Signed in as mid $mid';
  }

  @override
  String onboardingAccountsImported(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Imported $count accounts',
      one: 'Imported 1 account',
    );
    return '$_temp0';
  }

  @override
  String get onboardingAccountImportSucceeded => 'Sign-in information imported';

  @override
  String get onboardingErrorJsonTopLevelObject =>
      'The top level of the JSON must be an object';

  @override
  String onboardingConfirmSettingsImport(String source) {
    return 'Import settings from $source?';
  }

  @override
  String get onboardingSettingsFields => 'Settings fields';

  @override
  String get onboardingPlaybackFields => 'Playback fields';

  @override
  String get onboardingCategory => 'Categories';

  @override
  String get onboardingExtraTopLevelFields => 'Extra top-level fields';

  @override
  String get onboardingConfirmAccountImport => 'Import local account backup?';

  @override
  String get onboardingAccountCount => 'Accounts';

  @override
  String get onboardingContainsCookie => 'With Cookie';

  @override
  String get onboardingContainsAccessKey => 'With accessKey';

  @override
  String get onboardingContainsRefresh => 'With refresh';

  @override
  String get onboardingWillOverwrite => 'Will overwrite';

  @override
  String get onboardingWebDavAddress => 'Address';

  @override
  String get onboardingWebDavAddressRequired => 'Enter a WebDAV address';

  @override
  String get onboardingWebDavUser => 'User';

  @override
  String get onboardingWebDavPassword => 'Password';

  @override
  String get onboardingWebDavPath => 'Path';

  @override
  String get onboardingCategoryAppearance => 'Appearance';

  @override
  String get onboardingCategoryPlayback => 'Playback';

  @override
  String get onboardingCategoryWebDav => 'WebDAV';

  @override
  String get onboardingCategoryLayout => 'Layout';

  @override
  String get onboardingCategoryGeneral => 'General';

  @override
  String get onboardingErrorNoSettingsData => 'No setting or video data found';

  @override
  String onboardingErrorValueMustBeObject(String name) {
    return '$name must be an object';
  }

  @override
  String onboardingMidListSummary(String mids, int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$mids and $count total',
      one: '$mids (1 total)',
    );
    return '$_temp0';
  }

  @override
  String onboardingErrorAccountMustBeObject(String account) {
    return 'Account $account must be an object';
  }

  @override
  String get onboardingErrorNoAccountData => 'No account data found';
}
