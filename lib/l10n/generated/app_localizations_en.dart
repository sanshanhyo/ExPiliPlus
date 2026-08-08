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
  String get mineWatchHistory => 'History';

  @override
  String get mineSubscriptions => 'Subscription';

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
  String get onboardingImportHelp => 'How to export';

  @override
  String get onboardingImportHelpTitle => 'Export a file from PiliPlus';

  @override
  String get onboardingImportHelpIntro =>
      'In PiliPlus, open the entry for the data you want to move:';

  @override
  String get onboardingImportHelpSettingsPath =>
      'Me > Settings > About > Import / export settings';

  @override
  String get onboardingImportHelpLoginPath =>
      'Me > Settings > About > Import / export sign-in data';

  @override
  String get onboardingImportHelpExportHint =>
      'Choose “Export to a local file”, then return to ExPiliPlus and select the exported JSON file.';

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

  @override
  String get settingsOpenOnboarding => 'Open welcome guide again';

  @override
  String get settingsOpenOnboardingDescription =>
      'Review language, theme, and data migration without clearing your current settings';

  @override
  String get settingsEnablePermanentDynamicBlock =>
      'Enable permanent dynamic filtering';

  @override
  String get settingsEnablePermanentDynamicBlockDescription =>
      'Allow uploaders to be added to a permanent dynamic filter list';

  @override
  String get settingsDynamicBlockedUpList => 'Filtered uploader list';

  @override
  String settingsDynamicBlockedUpCount(int count) {
    return '$count uploaders';
  }

  @override
  String settingsDefaultValue(String value) {
    return 'Default: $value';
  }

  @override
  String get commonDisabled => 'Disabled';

  @override
  String get commonUnavailable => 'Unavailable';

  @override
  String get commonDeleted => 'Deleted';

  @override
  String get commonDelete => 'Delete';

  @override
  String get commonDeleting => 'Deleting…';

  @override
  String get commonDeleteSucceeded => 'Deleted';

  @override
  String commonDeleteFailed(String error) {
    return 'Couldn\'t delete: $error';
  }

  @override
  String commonLoadFailed(String error) {
    return 'Couldn\'t load: $error';
  }

  @override
  String get commonReport => 'Report';

  @override
  String get commonFormat => 'Format';

  @override
  String get commonPin => 'Pin';

  @override
  String get commonUnpin => 'Unpin';

  @override
  String get commonLike => 'Like';

  @override
  String get commonLiked => 'Liked';

  @override
  String get commonDislike => 'Dislike';

  @override
  String get commonDisliked => 'Disliked';

  @override
  String get commonAddToFavorites => 'Add to favorites';

  @override
  String get commonRemoveFromFavorites => 'Remove from favorites';

  @override
  String get commonShare => 'Share';

  @override
  String get commonRepost => 'Repost';

  @override
  String get commonOther => 'Other';

  @override
  String get commonBack => 'Back';

  @override
  String get commonPause => 'Pause';

  @override
  String get commonClose => 'Close';

  @override
  String get commonLoading => 'Loading…';

  @override
  String get commonSavingMayTakeTime => 'Saving. This may take a while';

  @override
  String get commonTapToReload => 'Tap to reload';

  @override
  String get commonCopyLink => 'Copy link';

  @override
  String get commonOpenInAnotherApp => 'Open in another app';

  @override
  String get commonNoMore => 'No more results';

  @override
  String get commonSend => 'Send';

  @override
  String get commonSending => 'Sending…';

  @override
  String get commonSent => 'Sent';

  @override
  String get commonImage => 'Image';

  @override
  String get commonEdit => 'Edit';

  @override
  String get commonPreview => 'Preview';

  @override
  String get commonRemove => 'Remove';

  @override
  String get commonSubmit => 'Submit';

  @override
  String get commonSubmitting => 'Submitting…';

  @override
  String get commonSubmitSucceeded => 'Submitted';

  @override
  String commonSubmitFailed(String error) {
    return 'Couldn\'t submit: $error';
  }

  @override
  String get commonSucceeded => 'Done';

  @override
  String get commonUndo => 'Undo';

  @override
  String get commonUnknown => 'Unknown';

  @override
  String get commonDataUnavailable => 'Required data isn\'t available';

  @override
  String get commonFeedback => 'Feedback';

  @override
  String get commonNotice => 'Notice';

  @override
  String get commonJumpFailed => 'Couldn\'t jump';

  @override
  String get commonOriginal => 'Original';

  @override
  String get commonTranslate => 'Translate';

  @override
  String get commonReply => 'Reply';

  @override
  String get commonVote => 'Vote';

  @override
  String get commonNote => 'Note';

  @override
  String get commonNotes => 'Notes';

  @override
  String get commonClear => 'Clear';

  @override
  String get commonVideos => 'Videos';

  @override
  String get commonArticles => 'Articles';

  @override
  String get commonLiveRooms => 'Live rooms';

  @override
  String get commonUsers => 'Users';

  @override
  String get commonAllTypes => 'All types';

  @override
  String get commonViewDetails => 'View details';

  @override
  String get commonDetails => 'Details';

  @override
  String get commonView => 'View';

  @override
  String get commonViewAll => 'View all';

  @override
  String get commonGoTo => 'Go to';

  @override
  String get commonColorPicker => 'Choose a color';

  @override
  String get commonSmall => 'Small';

  @override
  String get commonStandard => 'Standard';

  @override
  String get commonWifi => 'Wi-Fi';

  @override
  String get commonMobileData => 'Mobile data';

  @override
  String get commonNewestPublished => 'Newest';

  @override
  String get commonMostViewed => 'Most viewed';

  @override
  String get downloadHighestQuality => 'Highest quality';

  @override
  String downloadCurrentNetwork(String network) {
    return 'Current network: $network';
  }

  @override
  String get downloadCacheAll => 'Download all';

  @override
  String get downloadConfirmCacheAll => 'Download all episodes?';

  @override
  String get downloadViewCached => 'View downloads';

  @override
  String get accountPremium => 'Premium';

  @override
  String get accountPremiumRequired => 'Premium is required';

  @override
  String get accountSignInAgainRequired => 'Sign out, then sign in again';

  @override
  String get memberQuietlyFollowing => 'Following privately';

  @override
  String get memberFollowing => 'Following';

  @override
  String get memberMutualFollow => 'Mutual follow';

  @override
  String get memberBlocked => 'Blocked';

  @override
  String get memberSpecialFollow => 'Priority follow';

  @override
  String get memberFollow => 'Follow';

  @override
  String memberFollowersAndVideos(String followers, String videos) {
    return '$followers followers · $videos videos';
  }

  @override
  String get memberEditProfile => 'Edit profile';

  @override
  String get memberViewProfile => 'View profile';

  @override
  String get playerSuperResolutionEfficiency => 'Performance';

  @override
  String get playerSuperResolutionQuality => 'Quality';

  @override
  String get playerSuperResolution => 'Super resolution';

  @override
  String get playerRepeatPauseAtEnd => 'Pause at end';

  @override
  String get playerRepeatListOrder => 'Play list in order';

  @override
  String get playerRepeatSingle => 'Repeat one';

  @override
  String get playerRepeatList => 'Repeat list';

  @override
  String get playerRepeatAutoplayRelated => 'Autoplay related videos';

  @override
  String get playerFitStretch => 'Stretch';

  @override
  String get playerFitAuto => 'Auto';

  @override
  String get playerFitCrop => 'Crop';

  @override
  String get playerFitWidth => 'Fit width';

  @override
  String get playerFitHeight => 'Fit height';

  @override
  String get playerFitOriginal => 'Original size';

  @override
  String get playerFitScaleDown => 'Scale down';

  @override
  String get playerQuality8k => '8K Ultra HD';

  @override
  String get playerQualityDolbyVision => 'Dolby Vision';

  @override
  String get playerQualityHdr => 'HDR';

  @override
  String get playerQuality4k => '4K Ultra HD';

  @override
  String get playerQuality1080p60 => '1080p60';

  @override
  String get playerQuality1080pHighBitrate => '1080p High Bitrate';

  @override
  String get playerQuality1080p => '1080p';

  @override
  String get playerQuality720p60 => '720p60';

  @override
  String get playerQuality720p => '720p';

  @override
  String get playerQuality480p => '480p';

  @override
  String get playerQuality360p => '360p';

  @override
  String get playerQuality240p => '240p';

  @override
  String get playerCdnBaseUrl => 'Primary URL';

  @override
  String get playerCdnBackupUrl => 'Backup URL';

  @override
  String playerCdnAlibaba(String name) {
    return 'Alibaba Cloud ($name)';
  }

  @override
  String playerCdnTencent(String name) {
    return 'Tencent Cloud ($name)';
  }

  @override
  String playerCdnTencentVod(String name) {
    return 'Tencent VOD ($name)';
  }

  @override
  String playerCdnHuaweiFusion(String name) {
    return 'Huawei Fusion ($name)';
  }

  @override
  String playerCdnHuawei(String name) {
    return 'Huawei Cloud ($name)';
  }

  @override
  String playerCdnAkamaiInternational(String name) {
    return 'Akamai International ($name)';
  }

  @override
  String playerCdnAlibabaInternational(String name) {
    return 'Alibaba Cloud International ($name)';
  }

  @override
  String playerCdnTencentInternational(String name) {
    return 'Tencent Cloud International ($name)';
  }

  @override
  String playerCdnHuaweiInternational(String name) {
    return 'Huawei Cloud International ($name)';
  }

  @override
  String playerCdnBilibiliInternational(String name) {
    return 'Bilibili International ($name)';
  }

  @override
  String get playerCdnMayNotWork => 'This route may not work';

  @override
  String get playerCdnSpeedTestFailed => 'Speed test failed';

  @override
  String get playerCdnSettings => 'CDN settings';

  @override
  String playerCurrentCdn(String cdn) {
    return 'Current CDN: $cdn';
  }

  @override
  String playerCdnSetReloading(String cdn) {
    return 'Switched to $cdn. Reloading…';
  }

  @override
  String get playerMoreSettings => 'More playback settings';

  @override
  String get playerPlay => 'Play';

  @override
  String get playerSleepTimer => 'Sleep timer';

  @override
  String get playerPlaybackUrl => 'Playback URL';

  @override
  String get playerReloadVideo => 'Reload video';

  @override
  String get playerVolume => 'Volume';

  @override
  String get playerFlipHorizontal => 'Flip horizontally';

  @override
  String get playerFlipVertical => 'Flip vertically';

  @override
  String get playerAudioOnly => 'Audio only';

  @override
  String get playerBackgroundPlayback => 'Background playback';

  @override
  String get playerSelectVideoQuality => 'Video quality';

  @override
  String playerCurrentVideoQuality(String quality) {
    return 'Current quality: $quality';
  }

  @override
  String get playerSelectAudioQuality => 'Audio quality';

  @override
  String playerCurrentAudioQuality(String quality) {
    return 'Current audio quality: $quality';
  }

  @override
  String get playerCodec => 'Codec';

  @override
  String playerCurrentCodec(String codec) {
    return 'Current codec: $codec';
  }

  @override
  String get playerPlaybackOrder => 'Playback order';

  @override
  String get playerDanmakuList => 'Danmaku list';

  @override
  String get playerDanmakuSettings => 'Danmaku settings';

  @override
  String get playerSubtitleSettings => 'Subtitle settings';

  @override
  String get playerLoadSubtitles => 'Load subtitles';

  @override
  String get playerSaveSubtitles => 'Save subtitles';

  @override
  String get playerPlaybackInfo => 'Playback info';

  @override
  String get playerInfoResolution => 'Resolution';

  @override
  String get playerInfoVideoParameters => 'Video parameters';

  @override
  String get playerInfoAudioParameters => 'Audio parameters';

  @override
  String get playerInfoMedia => 'Media';

  @override
  String get playerInfoAudioTrack => 'Audio track';

  @override
  String get playerInfoVideoTrack => 'Video track';

  @override
  String get playerInfoPlaybackRate => 'Playback rate';

  @override
  String get playerInfoHardwareDecoder => 'Hardware decoder';

  @override
  String get playerVideoQualityNotSupported =>
      'Quality selection isn\'t available for this video';

  @override
  String get playerPremiumQualityHint =>
      'Sign in or get Premium to use this quality';

  @override
  String playerVideoQualityChanged(String quality) {
    return 'Quality changed to $quality';
  }

  @override
  String playerAudioQualityChanged(String quality) {
    return 'Audio quality changed to $quality';
  }

  @override
  String get playerCodecNotSupported =>
      'Codec switching isn\'t available for this video';

  @override
  String get playerSelectCodec => 'Choose a codec';

  @override
  String playerCodecChanged(String codec) {
    return 'Codec changed to $codec';
  }

  @override
  String playerFontSize(String value) {
    return 'Font size: $value';
  }

  @override
  String playerFullscreenFontSize(String value) {
    return 'Fullscreen font size: $value';
  }

  @override
  String playerFontWeightMayVary(String value) {
    return 'Font weight: $value (varies by font)';
  }

  @override
  String playerStrokeWidth(String value) {
    return 'Stroke width: $value';
  }

  @override
  String playerHorizontalMargin(String value) {
    return 'Horizontal margin: $value';
  }

  @override
  String playerBottomMargin(String value) {
    return 'Bottom margin: $value';
  }

  @override
  String playerBackgroundOpacity(String value) {
    return 'Background opacity: $value';
  }

  @override
  String playerOpacity(String value) {
    return 'Opacity: $value';
  }

  @override
  String playerWatchingNow(String count) {
    return '$count watching';
  }

  @override
  String get playerCast => 'Cast';

  @override
  String get playerCastingNotSupported => 'Casting isn\'t supported';

  @override
  String get playerSubmitSegment => 'Submit segment';

  @override
  String get playerSegmentInfo => 'Segment info';

  @override
  String get playerTurnOffDanmaku => 'Turn off Danmaku';

  @override
  String get playerTurnOnDanmaku => 'Turn on Danmaku';

  @override
  String get playerPictureInPicture => 'Picture-in-picture';

  @override
  String get playerDanmakuScrolling => 'Scrolling';

  @override
  String get playerDanmakuTop => 'Top';

  @override
  String get playerDanmakuBottom => 'Bottom';

  @override
  String get playerDanmakuColored => 'Colored';

  @override
  String get playerDanmakuAdvanced => 'Advanced';

  @override
  String playerDanmakuCloudFilterLevel(int level) {
    return 'Cloud filter level: $level';
  }

  @override
  String playerDanmakuFilterManagement(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Filter management ($count)',
      zero: 'Filter management',
    );
    return '$_temp0';
  }

  @override
  String get playerDanmakuFilterByType => 'Filter by type';

  @override
  String get playerDanmakuMassiveMode => 'Massive mode';

  @override
  String get playerDanmakuConvertStaticToScrolling =>
      'Convert static Danmaku to scrolling';

  @override
  String get playerDanmakuFixedSpeed => 'Fixed speed';

  @override
  String playerDanmakuDisplayArea(String value) {
    return 'Display area: $value';
  }

  @override
  String playerScrollingDanmakuDuration(String value) {
    return 'Scrolling Danmaku duration: ${value}s';
  }

  @override
  String playerStaticDanmakuDuration(String value) {
    return 'Static Danmaku duration: ${value}s';
  }

  @override
  String playerDanmakuLineHeight(String value) {
    return 'Danmaku line height: $value';
  }

  @override
  String get playerPreviousEpisode => 'Previous episode';

  @override
  String get playerNextEpisode => 'Next episode';

  @override
  String get playerAlreadyFirstEpisode => 'This is the first episode';

  @override
  String get playerAlreadyLastEpisode => 'This is the last episode';

  @override
  String get playerHighlightHeatmap => 'Most replayed';

  @override
  String get playerChapterInfo => 'Chapters';

  @override
  String get playerEpisodes => 'Episodes';

  @override
  String get playerAspectRatio => 'Aspect ratio';

  @override
  String get playerTranslation => 'Translation';

  @override
  String get playerTurnOffTranslation => 'Turn off translation';

  @override
  String get playerSubtitles => 'Subtitles';

  @override
  String get playerTurnOffSubtitles => 'Turn off subtitles';

  @override
  String get playerPlaybackSpeed => 'Playback speed';

  @override
  String playerSpeedSemantic(String speed) {
    return '$speed× speed';
  }

  @override
  String get playerVideoQuality => 'Video quality';

  @override
  String get playerExitFullScreen => 'Exit full screen';

  @override
  String get playerFullScreen => 'Full screen';

  @override
  String get playerReleaseToCancelSeeking => 'Release to cancel seeking';

  @override
  String playerSpeedActive(String speed) {
    return 'Playing at $speed×';
  }

  @override
  String get playerResetView => 'Reset view';

  @override
  String get playerUnlock => 'Unlock';

  @override
  String get playerLock => 'Lock';

  @override
  String get playerScreenshot => 'Screenshot';

  @override
  String get playerMuted => 'Muted';

  @override
  String get playerUnmuted => 'Unmuted';

  @override
  String get playerGifRecord => 'Record GIF';

  @override
  String get playerGifRecordLength => 'Clip length';

  @override
  String get playerGifResolution => 'Resolution';

  @override
  String get playerGifFrameRate => 'Frame rate';

  @override
  String get playerGifNoAudioLoop => 'No audio · Infinite loop · GIF';

  @override
  String get playerGifExport => 'Export GIF';

  @override
  String get playerGifSourceUnavailable => 'GIF source is unavailable';

  @override
  String get playerAnimatedScreenshot => 'Animated screenshot';

  @override
  String get playerWebpPreset => 'WebP preset';

  @override
  String get playerWebpCpuWarning =>
      'Animated screenshots can use significant processing power';

  @override
  String get playerTranscodeFailedOrCanceled =>
      'Transcoding failed or was canceled';

  @override
  String get playerWebpPresetNone => 'None';

  @override
  String get playerWebpPresetPicture => 'Picture';

  @override
  String get playerWebpPresetPhoto => 'Photo';

  @override
  String get playerWebpPresetDrawing => 'Drawing';

  @override
  String get playerWebpPresetIcon => 'Icon';

  @override
  String get playerWebpPresetText => 'Text';

  @override
  String get playerWebpPresetNoneDescription => 'Don\'t use a preset';

  @override
  String get playerWebpPresetDefaultDescription =>
      'Balance quality and file size';

  @override
  String get playerWebpPresetPictureDescription => 'For general images';

  @override
  String get playerWebpPresetPhotoDescription =>
      'For photos and complex scenes';

  @override
  String get playerWebpPresetDrawingDescription =>
      'For drawings and illustrations';

  @override
  String get playerWebpPresetIconDescription => 'For icons and small graphics';

  @override
  String get playerWebpPresetTextDescription => 'For images containing text';

  @override
  String get playerDanmakuFontSize => 'Danmaku size';

  @override
  String get playerDanmakuStyle => 'Danmaku style';

  @override
  String get playerDanmakuColor => 'Danmaku color';

  @override
  String get playerDanmakuInputHint => 'Enter Danmaku';

  @override
  String get playerNowPlaying => 'Now playing';

  @override
  String playerNowPlayingTitle(String title) {
    return 'Now playing: $title';
  }

  @override
  String get playerPlayInOrder => 'Play in order';

  @override
  String get playerPlayInReverse => 'Play in reverse';

  @override
  String playerSkipSegment(String segment) {
    return 'Skip: $segment';
  }

  @override
  String get playerUploaderDisabledDanmaku => 'The Uploader turned off Danmaku';

  @override
  String playerRewindSeconds(int seconds) {
    return 'Rewind ${seconds}s';
  }

  @override
  String playerForwardSeconds(int seconds) {
    return 'Forward ${seconds}s';
  }

  @override
  String get playerVideoOpenFailedRetrying =>
      'Couldn\'t open the video URL. Retrying…';

  @override
  String playerDecoderLoadFailed(String error) {
    return 'Couldn\'t load the decoder: $error. Software decoding may be used';
  }

  @override
  String get playerTakingScreenshot => 'Taking screenshot…';

  @override
  String get playerTapPreviewToSaveScreenshot =>
      'Tap the preview to save the screenshot';

  @override
  String get playerScreenshotFailed => 'Couldn\'t take screenshot';

  @override
  String get replyPostComment => 'Post a comment';

  @override
  String get replyNoCommentsYet => 'No comments yet';

  @override
  String get replyInputHint => 'Add a comment…';

  @override
  String get replyImagesNotSupported =>
      'Images aren\'t supported in this comment section';

  @override
  String get replyAlsoPostToFeed => 'Also post to Feed';

  @override
  String get replyInsertContent => 'Insert content';

  @override
  String get replyVideoProgress => 'Video timestamp';

  @override
  String replyMaxImages(int limit) {
    String _temp0 = intl.Intl.pluralLogic(
      limit,
      locale: localeName,
      other: 'You can add up to $limit images',
    );
    return '$_temp0';
  }

  @override
  String get replyVideoScreenshot => 'Video screenshot';

  @override
  String get replyVoteRedSide => 'Red side';

  @override
  String get replyVoteBlueSide => 'Blue side';

  @override
  String replyVoteParticipants(String count) {
    return '$count participants';
  }

  @override
  String get replyTranslationEmpty => 'No translation was returned';

  @override
  String replyTranslationFailed(String error) {
    return 'Translation failed: $error';
  }

  @override
  String get replyViewConversation => 'View conversation';

  @override
  String get replyJumpToReply => 'Jump to reply';

  @override
  String get replyUploaderAndOthers => 'Uploader and others';

  @override
  String replyCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count replies',
      one: '1 reply',
      zero: 'No replies',
    );
    return '$_temp0';
  }

  @override
  String replyVoteTitle(String title) {
    return 'Vote: $title';
  }

  @override
  String replyJumpTo(String time) {
    return 'Jump to $time';
  }

  @override
  String replyJumpFailed(String error) {
    return 'Couldn\'t jump: $error';
  }

  @override
  String get replyDeleteComment => 'Delete comment';

  @override
  String get replyConfirmDeleteComment => 'Delete this comment?';

  @override
  String get replyCopyAll => 'Copy all';

  @override
  String get replyCopySelection => 'Select and copy';

  @override
  String get replySaveComment => 'Save comment';

  @override
  String get replyCheckComment => 'Check comment';

  @override
  String get replyDetails => 'Comment details';

  @override
  String get replyConversation => 'Conversation';

  @override
  String replyRelatedCount(String count) {
    return '$count related replies';
  }

  @override
  String get replyMayHaveBeenDeleted => 'This comment may have been deleted';

  @override
  String get replyDislikeSucceeded => 'Disliked';

  @override
  String get replyRemoveDislikeSucceeded => 'Dislike removed';

  @override
  String get replyLikeSucceeded => 'Liked';

  @override
  String get replyUnlikeSucceeded => 'Like removed';

  @override
  String get reportChooseReason => 'Choose a reason for reporting:';

  @override
  String get reportDetailsHint =>
      'Add the issue type, where it appears, and other details to help reviewers';

  @override
  String get reportReasonRequired => 'A reason is required';

  @override
  String get reportBlockUser => 'Block this user';

  @override
  String get reportSucceeded => 'Report submitted';

  @override
  String get reportGroupIllegal => 'Illegal content';

  @override
  String get reportGroupMisinformation => 'Misinformation';

  @override
  String get reportGroupPersonalRights => 'Personal rights';

  @override
  String get reportGroupCommunity => 'Harmful to the community';

  @override
  String get reportIllegal => 'Illegal or prohibited';

  @override
  String get reportPornography => 'Pornography';

  @override
  String get reportVulgar => 'Vulgar content';

  @override
  String get reportGamblingOrScam => 'Gambling or scam';

  @override
  String get reportIllegalExternalLink => 'Link to illegal content';

  @override
  String get reportPoliticalRumor => 'Political misinformation';

  @override
  String get reportMisinformation => 'False or misleading information';

  @override
  String get reportSocialEventRumor => 'Misinformation about public events';

  @override
  String get reportPersonalAttack => 'Harassment or personal attack';

  @override
  String get reportPrivacyViolation => 'Privacy violation';

  @override
  String get reportSpam => 'Spam or advertising';

  @override
  String get reportProvocation => 'Provoking conflict';

  @override
  String get reportSpoiler => 'Spoiler';

  @override
  String get reportFlooding => 'Flooding';

  @override
  String get reportIrrelevant => 'Unrelated to the video';

  @override
  String get reportIllegalLottery => 'Illegal giveaway';

  @override
  String get reportHarmfulToMinors => 'Harmful to minors';

  @override
  String get reportIllegalOrHarmful => 'Illegal or harmful';

  @override
  String get reportPornographicOrVulgar => 'Pornographic or vulgar';

  @override
  String get reportAbuseOrProvocation => 'Abuse or provocation';

  @override
  String get reportPoliticallySensitive => 'Politically sensitive';

  @override
  String get reportAdHarassment => 'Advertising or harassment';

  @override
  String get reportScam => 'Scam';

  @override
  String get sponsorBlockActionSkip => 'Skip';

  @override
  String get sponsorBlockActionMute => 'Mute';

  @override
  String get sponsorBlockActionFullVideo => 'Full video';

  @override
  String get sponsorBlockActionHighlight => 'Highlight';

  @override
  String get sponsorBlockAlwaysSkip => 'Always skip';

  @override
  String get sponsorBlockSkipOnce => 'Skip once';

  @override
  String get sponsorBlockManualSkip => 'Manual skip';

  @override
  String get sponsorBlockShowOnly => 'Show only';

  @override
  String get sponsorBlockCategorySponsor => 'Sponsor';

  @override
  String get sponsorBlockCategorySponsorShort => 'Sponsor';

  @override
  String get sponsorBlockCategorySelfPromotion => 'Unpaid/self promotion';

  @override
  String get sponsorBlockCategorySelfPromotionShort => 'Self promotion';

  @override
  String get sponsorBlockCategoryExclusiveAccess => 'Exclusive access';

  @override
  String get sponsorBlockCategoryExclusiveAccessShort => 'Exclusive access';

  @override
  String get sponsorBlockCategoryInteraction => 'Interaction reminder';

  @override
  String get sponsorBlockCategoryInteractionShort => 'Interaction';

  @override
  String get sponsorBlockCategoryHighlight => 'Highlight';

  @override
  String get sponsorBlockCategoryHighlightShort => 'Highlight';

  @override
  String get sponsorBlockCategoryIntro => 'Intermission/intro';

  @override
  String get sponsorBlockCategoryIntroShort => 'Intro';

  @override
  String get sponsorBlockCategoryOutro => 'Endcards/credits';

  @override
  String get sponsorBlockCategoryOutroShort => 'Outro';

  @override
  String get sponsorBlockCategoryPreview => 'Preview/recap';

  @override
  String get sponsorBlockCategoryPreviewShort => 'Preview';

  @override
  String get sponsorBlockCategoryPadding => 'Filler/blank content';

  @override
  String get sponsorBlockCategoryPaddingShort => 'Padding';

  @override
  String get sponsorBlockCategoryFiller => 'Tangents/jokes';

  @override
  String get sponsorBlockCategoryFillerShort => 'Filler';

  @override
  String get sponsorBlockCategoryMusicOfftopic => 'Music: non-music section';

  @override
  String get sponsorBlockCategoryMusicOfftopicShort => 'Non-music';

  @override
  String sponsorBlockSkipped(String segment) {
    return 'Skipped $segment';
  }

  @override
  String sponsorBlockJumpedTo(String segment) {
    return 'Jumped to $segment';
  }

  @override
  String sponsorBlockSkipFailed(String segment) {
    return 'Couldn\'t skip $segment';
  }

  @override
  String get sponsorBlockUpvote => 'Upvote';

  @override
  String get sponsorBlockDownvote => 'Downvote';

  @override
  String get sponsorBlockChangeCategory => 'Change category';

  @override
  String get sponsorBlockVoteSucceeded => 'Vote submitted';

  @override
  String sponsorBlockVoteFailed(String error) {
    return 'Couldn\'t vote: $error';
  }

  @override
  String get sponsorBlockCategoryChangeSucceeded => 'Category changed';

  @override
  String sponsorBlockCategoryChangeFailed(String error) {
    return 'Couldn\'t change category: $error';
  }

  @override
  String sponsorBlockSegmentRange(String start, String end) {
    return '$start to $end';
  }

  @override
  String get sponsorBlockJumpToSegment => 'Jump to this segment';

  @override
  String get sponsorBlockSkipSegment => 'Skip this segment';

  @override
  String get videoPlayNow => 'Play now';

  @override
  String get videoReplay => 'Replay';

  @override
  String get videoResumePlayback => 'Resume';

  @override
  String get videoBackToHome => 'Back to Home';

  @override
  String get videoRelatedVideos => 'Related videos';

  @override
  String get videoViewNotes => 'View notes';

  @override
  String get videoDownload => 'Download';

  @override
  String get videoSaveCover => 'Save thumbnail';

  @override
  String get videoListenToAudio => 'Listen to audio';

  @override
  String get videoOfflineVideo => 'Offline video';

  @override
  String get videoDescription => 'Description';

  @override
  String get videoComments => 'Comments';

  @override
  String get videoPlaylist => 'Playlist';

  @override
  String videoCommentsCount(String count) {
    return 'Comments $count';
  }

  @override
  String get videoSendDanmaku => 'Send Danmaku';

  @override
  String get videoSeriesReverseNotSupported =>
      'Reverse playback isn\'t available for this series';

  @override
  String get videoLikeSucceeded => 'Liked';

  @override
  String get videoUnlikeSucceeded => 'Like removed';

  @override
  String get videoAddToWatchLater => 'Add to Watch later';

  @override
  String get videoCoin => 'Coin';

  @override
  String get videoSupporterOnly => 'Supporters only';

  @override
  String get videoInteractive => 'Interactive video';

  @override
  String get videoSponsorBlockSourceSync => 'Sync SponsorBlock video source';

  @override
  String videoSponsorBlockAlreadyLinked(String videoId) {
    return 'Linked to YouTube video $videoId';
  }

  @override
  String videoSponsorBlockConfirmLink(String videoId) {
    return 'Link this video to YouTube video $videoId?';
  }

  @override
  String get videoSponsorBlockLinkSucceeded => 'Video source linked';

  @override
  String videoSponsorBlockLinkFailed(String error) {
    return 'Couldn\'t link video source: $error';
  }

  @override
  String get videoAiSummaryNotSupported =>
      'AI summary isn\'t available for this video';

  @override
  String get videoAiSummary => 'AI summary';

  @override
  String videoBgmPrefix(String content) {
    return 'BGM: $content';
  }

  @override
  String get videoGreatCoined => 'Great Coined';

  @override
  String get videoCoinFailed => 'Couldn\'t Coin';

  @override
  String get videoGreatCoinedSucceeded => 'Great Coined';

  @override
  String get videoDislikeSucceeded => 'Disliked';

  @override
  String get videoRemoveDislikeSucceeded => 'Dislike removed';

  @override
  String get videoShareAtCurrentTime => 'Start at current time';

  @override
  String get videoShareVideo => 'Share video';

  @override
  String videoShareText(String title, String uploader, String url) {
    return '$title\nUploader: $uploader\n$url';
  }

  @override
  String get videoShareToFeed => 'Share to Feed';

  @override
  String get videoShareToMessages => 'Share to messages';

  @override
  String get videoNoRelatedVideosStopAutoplay =>
      'No more related videos. Autoplay stopped';

  @override
  String get videoLoadingAiSummary => 'Loading AI summary…';

  @override
  String get videoAiProcessing =>
      'The AI summary is still being generated. Try again later';

  @override
  String get videoFollowAnime => 'Follow Anime';

  @override
  String get videoFollowSeries => 'Follow series';

  @override
  String videoRating(String score) {
    return 'Rating $score';
  }

  @override
  String videoAlreadyFollowing(String type) {
    return 'Following: $type';
  }

  @override
  String videoDescriptionWithContent(String description) {
    return 'Description: $description';
  }

  @override
  String get videoRemovedFromFavorites => 'Removed from favorites';

  @override
  String get videoAddedToFavorites => 'Added to favorites';

  @override
  String videoMarkAs(String status) {
    return 'Mark as $status';
  }

  @override
  String get videoStatusWatched => 'Watched';

  @override
  String get videoStatusWatching => 'Watching';

  @override
  String get videoStatusWantToWatch => 'Want to watch';

  @override
  String videoCancelFollowingType(String type) {
    return 'Unfollow $type';
  }

  @override
  String videoSegmentStart(String value) {
    return 'Start: $value';
  }

  @override
  String videoSegmentEnd(String value) {
    return 'End: $value';
  }

  @override
  String get videoSegmentSetCurrent => 'Set to current time';

  @override
  String get videoSegmentVideoStart => 'Start of video';

  @override
  String get videoSegmentVideoEnd => 'End of video';

  @override
  String get videoSegmentAdd => 'Add segment';

  @override
  String get videoSegmentConfirmBeforeSubmit => 'Review before submitting';

  @override
  String get videoSegmentConfirmSubmit => 'Submit';

  @override
  String get videoSegmentCategory => 'Category';

  @override
  String get videoSegmentAction => 'Action';

  @override
  String get videoSegmentProgressBar => 'Segment progress bar';

  @override
  String videoResumeAtPart(int part) {
    return 'Last watched Part $part. Tap to jump';
  }

  @override
  String videoJumpedToPart(int part) {
    return 'Jumped to Part $part';
  }

  @override
  String get videoExclusiveTrial =>
      'This exclusive video only provides a preview';

  @override
  String get videoResourceUnavailable => 'Video isn\'t available';

  @override
  String get videoCoinLimitReached => 'Coin limit reached';

  @override
  String get videoNotEnoughCoins => 'Not enough Coins';

  @override
  String videoCoinBalance(String balance) {
    return 'Coin balance: $balance';
  }

  @override
  String get videoAlreadyCoinedOne => '1 Coin given';

  @override
  String videoCoinBalanceAndCoined(String balance) {
    return 'Coin balance: $balance · 1 Coin given';
  }

  @override
  String get videoCoinAndLike => 'Like too';

  @override
  String get videoEpisodes => 'Episodes';

  @override
  String videoEpisodeCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count episodes',
      one: '1 episode',
    );
    return '$_temp0';
  }

  @override
  String videoCollection(String title) {
    return 'Collection: $title';
  }

  @override
  String get videoCollectionLabel => 'Collection';

  @override
  String videoEpisodePosition(int current, int total) {
    return 'Episode $current of $total';
  }

  @override
  String videoOngoingUpdatedTo(String episode) {
    return 'Ongoing · Updated to $episode';
  }

  @override
  String videoEpisodeNumber(int number) {
    return 'Episode $number';
  }

  @override
  String get videoReviews => 'Reviews';

  @override
  String get videoSummary => 'Summary';

  @override
  String get videoCastAndCrew => 'Cast & crew';

  @override
  String videoCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count videos',
      one: '1 video',
    );
    return '$_temp0';
  }

  @override
  String get videoTypePlaybackNotSupported =>
      'This video type isn\'t supported';

  @override
  String get videoConfirmRemove => 'Remove this video?';

  @override
  String videoNotesCount(int count) {
    return 'Notes ($count)';
  }

  @override
  String get videoStartTakingNotes => 'Start taking notes';

  @override
  String videoVisitUploader(String name) {
    return 'Visit $name';
  }

  @override
  String get videoNotInterested => 'Not interested';

  @override
  String get videoDoNotWantToSee => 'I don\'t want to see this';

  @override
  String get videoWebFineSelectionUnsupported =>
      'Detailed choices aren\'t available on Web';

  @override
  String videoBlockUploader(String name) {
    return 'Block $name';
  }

  @override
  String videoConfirmBlockUploader(String name, String id) {
    return 'Block $name ($id)?\n\nYou can unblock this Uploader from Privacy settings > Blocked users.';
  }

  @override
  String get timeJustNow => 'Just now';

  @override
  String timeMinutesAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count minutes ago',
      one: '1 minute ago',
    );
    return '$_temp0';
  }

  @override
  String timeHoursAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count hours ago',
      one: '1 hour ago',
    );
    return '$_temp0';
  }

  @override
  String timeYesterdayAt(String time) {
    return 'Yesterday at $time';
  }

  @override
  String timeDaysAgo(int count) {
    return '$count days ago';
  }

  @override
  String durationYears(int count) {
    return '$count yr ';
  }

  @override
  String durationMonths(int count) {
    return '$count mo ';
  }

  @override
  String durationDays(int count) {
    return '$count d ';
  }

  @override
  String durationHours(int count) {
    return '$count hr ';
  }

  @override
  String durationMinutes(int count) {
    return '$count min';
  }

  @override
  String timeTodayAt(String time) {
    return 'Today at $time';
  }

  @override
  String get weekdayMondayShort => 'Mon';

  @override
  String get weekdayTuesdayShort => 'Tue';

  @override
  String get weekdayWednesdayShort => 'Wed';

  @override
  String get weekdayThursdayShort => 'Thu';

  @override
  String get weekdayFridayShort => 'Fri';

  @override
  String get weekdaySaturdayShort => 'Sat';

  @override
  String get weekdaySundayShort => 'Sun';

  @override
  String get homePgcSchedule => 'Anime schedule';

  @override
  String get homeToday => 'Today';

  @override
  String homeWeekday(String weekday) {
    return '$weekday';
  }

  @override
  String get homeRecommendations => 'Recommended';

  @override
  String get homeMediaIndex => 'Browse';

  @override
  String get homeAllMedia => 'All';

  @override
  String get homeMovies => 'Movies';

  @override
  String get homeTvShows => 'TV shows';

  @override
  String get homeDocumentaries => 'Documentaries';

  @override
  String get homeVarietyShows => 'Variety shows';

  @override
  String homeRecentAnime(String count) {
    return 'Recently watched$count';
  }

  @override
  String homeRecentSeries(String count) {
    return 'Recently watched$count';
  }

  @override
  String get homeNoAnime => 'No anime followed yet';

  @override
  String get homeNoSeries => 'No series followed yet';

  @override
  String get feedAll => 'All';

  @override
  String get feedUploads => 'Uploads';

  @override
  String get feedAnime => 'Anime';

  @override
  String get feedArticles => 'Articles';

  @override
  String get feedUploader => 'Uploader';

  @override
  String get feedCreatePost => 'Create post';

  @override
  String get feedAllUpdates => 'All updates';

  @override
  String get feedMe => 'Me';

  @override
  String get feedLiveEnded => 'Live ended';

  @override
  String feedVoteWithTitle(String title) {
    return 'Poll: $title';
  }

  @override
  String feedPlayCount(String count) {
    return '$count views';
  }

  @override
  String feedDanmakuCount(String count) {
    return '$count danmaku';
  }

  @override
  String get feedExpired => 'No longer available';

  @override
  String feedUnsupportedType(String id, String type) {
    return 'Unsupported post type:\n$id\n$type';
  }

  @override
  String get followMyFollowing => 'Following';

  @override
  String followUserFollowing(String name) {
    return '$name\'s following';
  }

  @override
  String get followNewGroup => 'New group';

  @override
  String get followSortGroups => 'Sort groups';

  @override
  String get followBlockedUsers => 'Blocked users';

  @override
  String get followShared => 'Followed by both';

  @override
  String get followAll => 'All following';

  @override
  String get followMostRecent => 'Recently followed';

  @override
  String get followMostVisited => 'Most visited';

  @override
  String get followEditGroupName => 'Edit group name';

  @override
  String get followRenameGroup => 'Rename';

  @override
  String get followDeleteGroup => 'Delete group';

  @override
  String get followDeleteGroupDescription =>
      'People in this group will remain in your following list.';

  @override
  String get followUpdateSucceeded => 'Group updated';

  @override
  String get followDeleteSucceeded => 'Group deleted';

  @override
  String get feedSupporterOnly => 'Supporters only';

  @override
  String get feedPollOptions => 'Poll options';

  @override
  String get feedPollEnded => 'Poll ended';

  @override
  String get feedPollCompleted => 'Voted';

  @override
  String get feedPoll => 'Vote';

  @override
  String get feedFollowedPeopleVotes => 'Votes from people you follow';

  @override
  String get feedVotedFor => 'voted for';

  @override
  String feedPollEndsAt(String time) {
    return 'Ends $time';
  }

  @override
  String feedParticipantCount(String count) {
    return '$count participants';
  }

  @override
  String get feedShowPercentage => 'Show percentage';

  @override
  String get feedAnonymous => 'Anonymous';

  @override
  String get feedMoreActions => 'More';

  @override
  String get feedWatchLater => 'Watch later';

  @override
  String get feedSavePost => 'Save post';

  @override
  String get feedSharePost => 'Share post';

  @override
  String get feedShareToMessages => 'Share in messages';

  @override
  String feedTemporarilyBlock(String name) {
    return 'Temporarily hide posts from $name';
  }

  @override
  String feedTemporarilyBlocked(String name, String id) {
    return 'Posts from $name ($id) are hidden until restart';
  }

  @override
  String feedPermanentlyBlockAuthorPosts(String name) {
    return 'Permanently hide posts from $name';
  }

  @override
  String feedAuthorPostsPermanentlyBlocked(String name, String id) {
    return 'Posts from $name ($id) are permanently hidden';
  }

  @override
  String feedUnblockAuthorPosts(String name) {
    return 'Show posts from $name';
  }

  @override
  String feedAuthorPostsUnblocked(String name) {
    return 'Posts from $name are now visible';
  }

  @override
  String dynamicBlockedUpListTitle(int count) {
    return 'Filtered uploaders ($count)';
  }

  @override
  String get dynamicBlockedUpListEmpty =>
      'No uploaders are permanently filtered';

  @override
  String dynamicBlockedUpUnknownName(String id) {
    return 'Uploader $id';
  }

  @override
  String dynamicBlockedUpUid(String id) {
    return 'UID: $id';
  }

  @override
  String dynamicBlockedUpRemoveConfirm(String name) {
    return 'Remove $name from the dynamic filter list?';
  }

  @override
  String get dynamicBlockedUpRemoved => 'Removed from the dynamic filter list';

  @override
  String get feedCheckPost => 'Check post';

  @override
  String get feedPinPost => 'Pin post';

  @override
  String get feedUnpinPost => 'Unpin post';

  @override
  String get feedEnableFeaturedComments => 'Turn on featured comments';

  @override
  String get feedDisableFeaturedComments => 'Turn off featured comments';

  @override
  String get feedDisableComments => 'Turn off comments';

  @override
  String get feedRestoreComments => 'Restore comments';

  @override
  String get feedInteractionSettings => 'Interaction settings';

  @override
  String get feedVisibleToEveryone => 'Visible to everyone';

  @override
  String get feedVisibleOnlyToMe => 'Only visible to me';

  @override
  String get feedVisibility => 'Visibility';

  @override
  String get feedEditPost => 'Edit post';

  @override
  String get feedConfirmDeletePost => 'Delete this post?';

  @override
  String get feedExpand => 'Show more';

  @override
  String get feedPriceFrom => 'and up';

  @override
  String get feedJoin => 'Join';

  @override
  String get feedComment => 'Comment';

  @override
  String get feedWebLink => 'Web link';

  @override
  String get followGroupSortTitle => 'Sort following groups';

  @override
  String get followSortCompleted => 'Order saved';

  @override
  String followAlsoFollowed(int count, String name) {
    return '$count people you follow also follow $name';
  }

  @override
  String get followUnknownPerson => 'them';

  @override
  String get followActionFollow => 'Follow';

  @override
  String get followActionFollowing => 'Following';

  @override
  String followSharedWithUser(String name) {
    return 'Followed by you and $name';
  }

  @override
  String get settingsSignInRequired => 'Sign in to view';

  @override
  String get settingsBlockedUsersManagement => 'Blocked users';

  @override
  String get settingsBlockedUsersDescription => 'People you\'ve blocked';

  @override
  String get settingsAccountModeDetails => 'Account mode details';

  @override
  String get settingsLearnAccountModes => 'About account modes';

  @override
  String get settingsAccountModesApiDescription =>
      'See which APIs each account mode uses';

  @override
  String get settingsAccountModeMain => 'Main account';

  @override
  String get settingsAccountModeWatchHistory => 'Watch history';

  @override
  String get settingsAccountModeRecommendation => 'Recommendations';

  @override
  String get settingsAccountModeVideoStream => 'Video streaming';

  @override
  String get settingsUseAppRecommendations => 'Use app recommendations on Home';

  @override
  String get settingsUseAppRecommendationsDescription =>
      'Try the app recommendation source if Web recommendations don\'t fit you';

  @override
  String get settingsKeepPreviousRecommendations =>
      'Keep previous recommendations';

  @override
  String get settingsKeepPreviousRecommendationsDescription =>
      'Keep the previous items when refreshing';

  @override
  String get settingsShowLastPosition => 'Show last position';

  @override
  String get settingsShowLastPositionDescription =>
      'Mark where the previous recommendation refresh started';

  @override
  String get settingsLikeRatio => 'Like ratio';

  @override
  String get settingsTitleKeywordFilter => 'Filter title keywords';

  @override
  String get settingsCategoryKeywordFilter =>
      'Filter category keywords in app recommendations, Trending, and rankings';

  @override
  String get settingsVideoDuration => 'Video duration';

  @override
  String get settingsPlayCount => 'View count';

  @override
  String get settingsExemptFollowedUploaders =>
      'Don\'t filter followed Uploaders';

  @override
  String get settingsExemptFollowedUploadersDescription =>
      'Uploads from people you follow won\'t be filtered from recommendations';

  @override
  String get settingsApplyFilterToRelatedVideos =>
      'Apply filters to related videos';

  @override
  String get settingsApplyFilterToRelatedVideosDescription =>
      'Other pages such as Trending and Search aren\'t filtered; followed Uploaders can\'t be exempted in related videos';

  @override
  String get settingsTapToAdd => 'Tap to add';

  @override
  String get settingsKeywordSeparatorHelp =>
      'Separate terms with |, for example: cats|dogs';

  @override
  String get settingsSaved => 'Saved';

  @override
  String settingsFilterTitle(String title) {
    return 'Filter by $title';
  }

  @override
  String settingsFilterBelow(String title, int value, String suffix) {
    return 'Hide videos with $title below $value$suffix';
  }

  @override
  String settingsCurrentNamedValue(String title, int value, String suffix) {
    return 'Current $title: $value$suffix';
  }

  @override
  String settingsChooseFilterValue(String title, String filterHint) {
    return 'Choose $title$filterHint';
  }

  @override
  String get settingsZeroDisablesFilter => ' (0 turns off this filter)';

  @override
  String get settingsCustomValue => 'Custom';

  @override
  String settingsCustomNamedValue(String title) {
    return 'Custom $title';
  }

  @override
  String get settingsChooseAccountsToSignOut =>
      'Choose account UIDs to sign out';

  @override
  String settingsConfirmSignOutAccounts(String accounts) {
    return 'Sign out of these accounts?\n\n$accounts';
  }

  @override
  String get settingsSignOutCancel => 'Cancel';

  @override
  String get settingsSignOutOnly => 'Sign out locally';

  @override
  String get settingsDanmakuEnabled => 'Danmaku';

  @override
  String get settingsDanmakuEnabledDescription => 'Show danmaku over videos';

  @override
  String get settingsTapDanmaku => 'Tap danmaku';

  @override
  String get settingsTapDanmakuDescription =>
      'Pause a danmaku by tapping it to like, copy, or report';

  @override
  String get settingsPlaybackSpeed => 'Playback speed';

  @override
  String get settingsPlaybackSpeedDescription =>
      'Choose available video playback speeds';

  @override
  String get settingsTiltAngleThreshold => 'Tilt angle threshold';

  @override
  String get settingsAutoplay => 'Autoplay';

  @override
  String get settingsAutoplayDescription =>
      'Start playback when opening video details';

  @override
  String get settingsFullscreenLockButton => 'Show lock button in full screen';

  @override
  String get settingsFullscreenScreenshotButton =>
      'Show screenshot button in full screen';

  @override
  String get settingsFullscreenBattery => 'Show battery level in full screen';

  @override
  String get settingsDoubleTapSeek => 'Double-tap to seek';

  @override
  String get settingsDoubleTapSeekDescription =>
      'Double-tap left to rewind and right to fast-forward; when off, double-tap pauses or plays';

  @override
  String get settingsSlideBrightnessVolume =>
      'Swipe sides for brightness and volume';

  @override
  String get settingsSystemBrightness => 'Adjust system brightness';

  @override
  String get settingsSlideFullscreen =>
      'Swipe center to enter or exit full screen';

  @override
  String get settingsPlayerVolume => 'Player volume';

  @override
  String get settingsMaximumVolume => 'Maximum volume';

  @override
  String get settingsDoubleTapSeekDuration => 'Double-tap seek duration';

  @override
  String get settingsRelativeSlideSeek => 'Use relative swipe seek duration';

  @override
  String get settingsSlideSeekDuration => 'Swipe seek duration';

  @override
  String get settingsSlideSeekDurationDescription =>
      'How far to seek when swiping across the full player width';

  @override
  String get settingsAutomaticSubtitles => 'Automatic subtitles';

  @override
  String settingsCurrentPreference(String value) {
    return 'Current preference: $value';
  }

  @override
  String get settingsPauseWhenMinimized =>
      'Pause when minimized and resume when restored';

  @override
  String get settingsKeyboardControls => 'Keyboard controls';

  @override
  String get settingsSuperChatDisplay => 'Super Chat display';

  @override
  String get settingsFullscreenSuperChatSize => 'Full-screen Super Chat size';

  @override
  String get settingsFullscreenSuperChatSizeDescription =>
      'Adjust the size of Super Chats in full screen';

  @override
  String get settingsExpandPortraitVideo => 'Expand portrait videos';

  @override
  String get settingsExpandPortraitVideoDescription =>
      'Expand portrait videos from 16:9 to 1:1 on phones and to 9:16 in landscape layouts';

  @override
  String get settingsAutoEnterFullscreen => 'Enter full screen automatically';

  @override
  String get settingsAutoEnterFullscreenDescription =>
      'Enter full screen when playback starts';

  @override
  String get settingsAutoExitFullscreen => 'Exit full screen automatically';

  @override
  String get settingsAutoExitFullscreenDescription =>
      'Exit full screen when playback ends';

  @override
  String get settingsExtendPlayerControls =>
      'Keep player controls visible longer';

  @override
  String get settingsExtendPlayerControlsDescription =>
      'Keep controls visible for 30 seconds to make screen-reader navigation easier';

  @override
  String get settingsBackgroundPlayback => 'Background playback';

  @override
  String get settingsBackgroundPlaybackDescription =>
      'Keep playing while the app is in the background';

  @override
  String get settingsBackgroundPictureInPicture =>
      'Background picture-in-picture';

  @override
  String get settingsBackgroundPictureInPictureDescription =>
      'Enter picture-in-picture when the app goes to the background';

  @override
  String get settingsEnableBackgroundAudioSuggestion =>
      'Turn on the background audio service for better controls';

  @override
  String get settingsHideDanmakuInPictureInPicture =>
      'Hide danmaku in picture-in-picture';

  @override
  String get settingsHideDanmakuInPictureInPictureDescription =>
      'Hide danmaku in the floating player';

  @override
  String get settingsReverseFullscreenGesture => 'Reverse full-screen gesture';

  @override
  String get settingsReverseFullscreenGestureDescription =>
      'By default, swipe up to enter full screen and down to exit; turn on to reverse it';

  @override
  String get settingsFullscreenActionButtons =>
      'Show action buttons in full screen';

  @override
  String get settingsOnlineViewerCount => 'Concurrent viewers';

  @override
  String get settingsOnlineViewerCountDescription =>
      'Show how many people are watching now';

  @override
  String get settingsDefaultFullscreenOrientation =>
      'Default full-screen orientation';

  @override
  String settingsCurrentFullscreenOrientation(String value) {
    return 'Current orientation: $value';
  }

  @override
  String get settingsBottomProgressBar => 'Bottom progress bar';

  @override
  String settingsCurrentBottomProgressBar(String value) {
    return 'Current display: $value';
  }

  @override
  String get settingsBackgroundAudioService => 'Background audio service';

  @override
  String get settingsBackgroundAudioServiceDescription =>
      'Keeps play and pause controls available in picture-in-picture';

  @override
  String get settingsPlaybackOrder => 'Playback order';

  @override
  String get settingsTemporaryPlayerSettings =>
      'Apply player settings only to the current video';

  @override
  String get settingsTemporaryPlayerSettingsDescription =>
      'Except danmaku, subtitles, and options not available in Settings';

  @override
  String get settingsSubtitlePreference => 'Subtitle preference';

  @override
  String get settingsSubtitlePreferenceOff =>
      'Don\'t show subtitles by default';

  @override
  String get settingsSubtitlePreferencePreferHuman =>
      'Prefer non-auto-generated subtitles';

  @override
  String get settingsSubtitlePreferenceSkipAi =>
      'Skip auto-generated subtitles and use the first available track';

  @override
  String get settingsSubtitlePreferenceAuto =>
      'Prefer human subtitles when muted; otherwise skip auto-generated tracks';

  @override
  String get settingsSuperChatValidOnly => 'Show while active';

  @override
  String get settingsSuperChatPersistent => 'Always show';

  @override
  String get settingsSuperChatDisabled => 'Don\'t show';

  @override
  String get settingsFullscreenOrientationAuto =>
      'Match video orientation (default)';

  @override
  String get settingsFullscreenOrientationUnchanged =>
      'Keep current orientation';

  @override
  String get settingsFullscreenOrientationPortrait => 'Always portrait';

  @override
  String get settingsFullscreenOrientationLandscape => 'Always landscape';

  @override
  String settingsFullscreenOrientationRatio(double ratio) {
    return 'Use portrait below a $ratio screen ratio or for portrait video; otherwise landscape';
  }

  @override
  String get settingsFullscreenOrientationGravity =>
      'Rotate with gravity even when system rotation is locked (Android only)';

  @override
  String get settingsProgressAlwaysShow => 'Always show';

  @override
  String get settingsProgressAlwaysHide => 'Always hide';

  @override
  String get settingsProgressFullscreenOnly => 'Show only in full screen';

  @override
  String get settingsProgressHideFullscreen => 'Hide in full screen';

  @override
  String get settingsHardwareDecoding => 'Hardware decoding';

  @override
  String get settingsHardwareDecodingDescription =>
      'Use less power for video playback; turn off if playback freezes';

  @override
  String get settingsGuest1080p => '1080p without signing in';

  @override
  String get settingsGuest1080pDescription =>
      'Try to play 1080p video while signed out';

  @override
  String get settingsBilibiliDataPlan => 'Bilibili carrier data support';

  @override
  String get settingsBilibiliDataPlanDescription =>
      'Automatically use a Bilibili-specific carrier data plan when available; verify it in your carrier usage records';

  @override
  String get settingsCdn => 'CDN';

  @override
  String settingsCurrentCdn(String value) {
    return 'Current: $value. Some CDNs may stop working; switch if playback fails';
  }

  @override
  String get settingsLiveCdn => 'Live CDN';

  @override
  String settingsCurrentSource(String value) {
    return 'Current: $value';
  }

  @override
  String get settingsCdnSpeedTest => 'CDN speed test';

  @override
  String get settingsCdnSpeedTestDescription =>
      'Tests by simulating video loading, which uses data; results are for reference only';

  @override
  String get settingsSeparateAudioCdn => 'Use a separate CDN for audio';

  @override
  String get settingsSeparateAudioCdnDescription =>
      'Use the backup URL directly to fix missing audio on some videos';

  @override
  String get settingsDefaultVideoQuality => 'Default video quality';

  @override
  String get settingsCellularVideoQuality => 'Video quality on mobile data';

  @override
  String get settingsDefaultAudioQuality => 'Default audio quality';

  @override
  String get settingsCellularAudioQuality => 'Audio quality on mobile data';

  @override
  String get settingsDefaultLiveQuality => 'Default live quality';

  @override
  String get settingsCellularLiveQuality => 'Live quality on mobile data';

  @override
  String settingsCurrentVideoQuality(String value) {
    return 'Current quality: $value';
  }

  @override
  String settingsCurrentAudioQuality(String value) {
    return 'Current audio quality: $value';
  }

  @override
  String get settingsPreferredCodecs => 'Preferred codecs';

  @override
  String settingsPreferredCodecsDescription(String value) {
    return 'Preferred codecs: $value. Adjust this to match your device support and needs';
  }

  @override
  String get settingsAudioOutput => 'Audio output';

  @override
  String get settingsBufferSize => 'Buffer size';

  @override
  String settingsBufferSizeDescription(double value) {
    return 'Current: $value MB. Used for both forward and backward buffers; live streams use all of it as forward buffer (mpv: --demuxer-max-bytes, --demuxer-max-back-bytes)';
  }

  @override
  String get settingsBufferDuration => 'Buffer duration';

  @override
  String settingsBufferDurationDescription(double value) {
    return 'Current: $value seconds. Actual buffering uses the lower of the size and duration limits; this doesn\'t affect live streams (mpv: --cache-secs)';
  }

  @override
  String get settingsAutoSync => 'Auto sync';

  @override
  String settingsAutoSyncDescription(String value) {
    return 'Current: $value (mpv: --autosync)';
  }

  @override
  String get settingsVideoSync => 'Video sync';

  @override
  String settingsVideoSyncDescription(String value) {
    return 'Current: $value (mpv: --video-sync)';
  }

  @override
  String get settingsHardwareDecodingMode => 'Hardware decoding mode';

  @override
  String settingsHardwareDecodingModeDescription(String value) {
    return 'Current: $value (mpv: --hwdec)';
  }

  @override
  String get settingsEnterCdnHost => 'Enter CDN host';

  @override
  String get settingsLiveQualityDolby => 'Dolby';

  @override
  String get settingsLiveQuality4kOriginal => '4K Original';

  @override
  String get settingsLiveQuality4k => '4K';

  @override
  String get settingsLiveQuality2k => '2K';

  @override
  String get settingsLiveQualityOriginal => 'Original';

  @override
  String get settingsLiveQualityBluRay => 'Blu-ray';

  @override
  String get settingsLiveQualitySuperHd => 'Super HD';

  @override
  String get settingsLiveQualityHd => 'HD';

  @override
  String get settingsLiveQualitySmooth => 'Smooth';

  @override
  String get settingsHwdecSoftware => 'Use software decoding';

  @override
  String get settingsHwdecAny => 'Use any available decoder';

  @override
  String get settingsHwdecBest => 'Use the best decoder';

  @override
  String get settingsHwdecBestCopy => 'Use the best copy-back decoder';

  @override
  String get settingsHwdecNonDirect => 'copy-back';

  @override
  String settingsHwdecExclusive(String vendor) {
    return '$vendor only';
  }

  @override
  String get settingsHwdecExperimental => 'experimental';

  @override
  String get settingsHwdecDeprecated => 'deprecated';

  @override
  String get settingsHwdecAllPlatforms => 'all platforms';

  @override
  String get settingsHwdecPartialRockchip => 'selected Rockchip chips only';

  @override
  String get settingsWindowTitleBar => 'Show window title bar';

  @override
  String get settingsTrayIcon => 'Show tray icon';

  @override
  String get settingsLandscapeLayout => 'Landscape layout';

  @override
  String get settingsLandscapeLayoutDescription =>
      'Use landscape layout and behavior on tablets and foldables; keeping the current orientation is recommended for full screen';

  @override
  String get settingsUseSidebar => 'Use sidebar';

  @override
  String get settingsUseSidebarDescription =>
      'Replaces the top and bottom bars and disables related options';

  @override
  String get settingsUiScale => 'Interface scale';

  @override
  String settingsCurrentUiScale(String value) {
    return 'Current scale: $value';
  }

  @override
  String get settingsPageTransition => 'Page transition';

  @override
  String get settingsOptimizeTabletNavigation => 'Optimize tablet navigation';

  @override
  String get settingsMaterialYouBottomBar => 'Material 3 bottom bar';

  @override
  String get settingsMaterialYouBottomBarDescription =>
      'Use the Material You bottom bar; turn off for a narrower bar';

  @override
  String get settingsFloatingBottomBar => 'Floating bottom bar';

  @override
  String get settingsListWidthLimit => 'List width limit (dp)';

  @override
  String settingsListWidthDescription(int home, int other, String screen) {
    return 'Current: Home $home dp, other pages $other dp, screen $screen dp. Smaller widths create more columns.';
  }

  @override
  String get settingsRemovePlayerSafeArea => 'Remove safe area on video pages';

  @override
  String get settingsDarkVideoPage => 'Use dark theme on video pages';

  @override
  String get settingsFeedWaterfall => 'Waterfall layout for Feed';

  @override
  String get settingsFeedWaterfallDescription =>
      'Turn off to use a single column';

  @override
  String get settingsFeedUploaderPosition => 'Uploader list position in Feed';

  @override
  String get settingsShowAllFollowedUploaders =>
      'Show all followed Uploaders in Feed';

  @override
  String get settingsExpandLiveUploaders => 'Expand live Uploaders in Feed';

  @override
  String get settingsFeedUnreadBadge => 'Feed unread badge';

  @override
  String get settingsMessageUnreadBadge => 'Message unread badge';

  @override
  String settingsCurrentBadgeStyle(String value) {
    return 'Current badge style: $value';
  }

  @override
  String get settingsMessageUnreadTypes => 'Unread message types';

  @override
  String settingsCurrentMessageTypes(String value) {
    return 'Current message types: $value';
  }

  @override
  String get settingsBarCollapseBehavior =>
      'Top and bottom bar collapse behavior';

  @override
  String get settingsCollapseHomeTopBar => 'Collapse Home top bar';

  @override
  String get settingsCollapseHomeTopBarDescription =>
      'Collapse the top bar while scrolling Home';

  @override
  String get settingsCollapseHomeBottomBar => 'Collapse Home bottom bar';

  @override
  String get settingsCollapseHomeBottomBarDescription =>
      'Collapse the bottom bar while scrolling Home';

  @override
  String get settingsImageQuality => 'Image quality';

  @override
  String get settingsImagePreviewQuality => 'Full-size image quality';

  @override
  String get settingsImageQualityDescription =>
      'Choose image clarity up to 100%';

  @override
  String get settingsDarkImageOverlay => 'Dark-mode image overlay';

  @override
  String get settingsDarkImageOverlayDescription =>
      'Display color = original image × selected color; full-size images aren\'t affected';

  @override
  String get settingsToastOpacity => 'Toast opacity';

  @override
  String get settingsToastOpacityDescription => 'Customize toast opacity';

  @override
  String get settingsThemeMode => 'Theme mode';

  @override
  String settingsCurrentMode(String value) {
    return 'Current mode: $value';
  }

  @override
  String get settingsPureBlackTheme => 'Pure black theme';

  @override
  String get settingsAppTheme => 'App theme';

  @override
  String settingsCurrentTheme(String value) {
    return 'Current theme: $value';
  }

  @override
  String get settingsDynamicColor => 'Dynamic color';

  @override
  String get settingsExPiliPlusCustomColor => 'ExPiliPlus custom color';

  @override
  String get settingsSpecifiedColor => 'Selected color';

  @override
  String get settingsDefaultStartPage => 'Default start page';

  @override
  String settingsCurrentStartPage(String value) {
    return 'Current start page: $value';
  }

  @override
  String get settingsSpringParameters => 'Scroll spring parameters';

  @override
  String get settingsFontSize => 'Font size';

  @override
  String get settingsHomeTabs => 'Home tabs';

  @override
  String get settingsHomeTabsDescription => 'Remove or reorder Home tabs';

  @override
  String get settingsNavigationBarEditor => 'Edit Navbar';

  @override
  String get settingsNavigationBarEditorDescription =>
      'Remove or reorder Navbar items';

  @override
  String get settingsExitDirectlyOnBack => 'Exit directly with Back';

  @override
  String get settingsExitDirectlyOnBackDescription =>
      'When on, Back exits from any Home tab; when off, it first returns to the first Navbar tab';

  @override
  String get settingsScreenRefreshRate => 'Screen refresh rate';

  @override
  String get settingsSucceeded => 'Settings updated';

  @override
  String get settingsRestartRequired => 'Restart to apply';

  @override
  String get settingsSucceededRestartRequired =>
      'Settings updated; restart to apply';

  @override
  String get settingsReset => 'Reset';

  @override
  String get settingsResetSucceededRestartRequired => 'Reset; restart to apply';

  @override
  String get settingsScaleRatio => 'Scale';

  @override
  String get settingsSpringParametersTitle => 'Spring parameters';

  @override
  String get settingsSpringDurationMode => 'Duration mode';

  @override
  String get settingsSpringPhysicalMode => 'Physical parameters';

  @override
  String get settingsListMaxColumnWidth =>
      'Maximum column width (default 240 dp)';

  @override
  String get settingsHomeRecommendationFeed => 'Home recommendation feed';

  @override
  String settingsConfirmDarkColor(String color) {
    return 'Use $color?';
  }

  @override
  String get settingsDarkColorWarning =>
      'This color is very dark and may make images harder to view';

  @override
  String get settingsUseServerSideDecoration =>
      'Use SSD (Server-Side Decoration)';

  @override
  String get settingsUpPositionTop => 'Top';

  @override
  String get settingsUpPositionLeftFixed => 'Fixed left';

  @override
  String get settingsUpPositionRightFixed => 'Fixed right';

  @override
  String get settingsUpPositionLeftDrawer => 'Left drawer';

  @override
  String get settingsUpPositionRightDrawer => 'Right drawer';

  @override
  String get settingsBadgeHidden => 'Hidden';

  @override
  String get settingsBadgeDot => 'Dot';

  @override
  String get settingsBadgeNumber => 'Number';

  @override
  String get settingsUnreadPrivateMessages => 'Direct messages';

  @override
  String get settingsUnreadReplies => 'Replies';

  @override
  String get settingsUnreadMentions => 'Mentions';

  @override
  String get settingsUnreadLikes => 'Likes';

  @override
  String get settingsUnreadSystem => 'System notifications';

  @override
  String get settingsBarCollapseInstant => 'Instant';

  @override
  String get settingsBarCollapseSynchronized => 'Synchronized';

  @override
  String get settingsMinimizeOnExit => 'Minimize on exit';

  @override
  String get settingsCachePath => 'Cache location';

  @override
  String get settingsSponsorBlock => 'SponsorBlock';

  @override
  String get settingsAnimeIntroOutroSkip => 'Anime intro and outro skipping';

  @override
  String get settingsCheckUnreadFeed => 'Check for unread Feed updates';

  @override
  String get settingsCheckUnreadFeedDescription =>
      'Tap to set the check interval in minutes';

  @override
  String get settingsVideoChapters => 'Show video chapters';

  @override
  String get settingsRelatedVideos => 'Show related videos';

  @override
  String get settingsVideoComments => 'Show video comments';

  @override
  String get settingsAnimeComments => 'Show anime comments';

  @override
  String get settingsExpandVideoDescription =>
      'Expand video description by default';

  @override
  String get settingsExpandVideoDescriptionLandscape =>
      'Expand video description in landscape';

  @override
  String get settingsLandscapeEpisodeTabs =>
      'Show episodes and collections as landscape tabs';

  @override
  String get settingsLandscapeUploaderSidebar =>
      'Open Uploader profiles in the landscape sidebar';

  @override
  String get settingsLandscapeImagePreview =>
      'Open image previews in the landscape sidebar';

  @override
  String get settingsCommentFoldLines => 'Comment fold line count';

  @override
  String get settingsZeroLinesDoNotFold => '0 lines means don\'t fold';

  @override
  String settingsLineCount(String count) {
    return '$count lines';
  }

  @override
  String get settingsDanmakuLineHeight => 'Danmaku line height';

  @override
  String settingsDefaultNumber(String value) {
    return 'Default: $value';
  }

  @override
  String get settingsVideoWarnings => 'Show video warnings and dispute notices';

  @override
  String get settingsFeedWarnings => 'Show Feed warnings and dispute notices';

  @override
  String get settingsReverseEpisodesFromFirst =>
      'Start reversed episodes and collections from the first item';

  @override
  String get settingsReverseEpisodesFromFirstDescription =>
      'Switch to the first item in reverse order; otherwise keep the current item';

  @override
  String get settingsDisableSslVerification =>
      'Disable SSL certificate verification';

  @override
  String get settingsDisableSslVerificationDescription =>
      'Use with caution; disabling verification makes man-in-the-middle attacks easier';

  @override
  String get settingsContinuePartPrompt =>
      'Show continue-playing prompt for multipart videos';

  @override
  String get settingsCommentKeywordFilter => 'Filter comment keywords';

  @override
  String get settingsFeedKeywordFilter => 'Filter Feed keywords';

  @override
  String get settingsExternalBrowser => 'Open links in external browser';

  @override
  String get settingsHorizontalSwipeThreshold => 'Horizontal swipe threshold';

  @override
  String settingsCurrentAndSystemDefault(String current, String defaultValue) {
    return 'Current: $current; system default: $defaultValue';
  }

  @override
  String get settingsRefreshDragDistance => 'Pull-to-refresh distance';

  @override
  String settingsCurrentMultiplier(String value) {
    return 'Current: $value×';
  }

  @override
  String get settingsRefreshIndicatorHeight => 'Refresh indicator height';

  @override
  String get settingsVipDanmaku => 'Show member color danmaku';

  @override
  String get settingsMergeDanmaku => 'Merge duplicate danmaku';

  @override
  String get settingsMergeDanmakuDescription =>
      'Merge identical danmaku received within a short period';

  @override
  String get settingsTrendingRecommendations => 'Show Trending recommendations';

  @override
  String get settingsTrendingRecommendationsDescription =>
      'Show entries such as The Bests on Trending';

  @override
  String get settingsAudioNormalization => 'Volume normalization';

  @override
  String get settingsFallbackNormalization =>
      'Use when the server has no loudnorm config';

  @override
  String settingsFallbackValue(String value) {
    return 'When unavailable: $value';
  }

  @override
  String get settingsAudioNormalizationDisabled => 'Disabled';

  @override
  String get settingsAudioNormalizationDynaudnorm => 'dynaudnorm preset';

  @override
  String get settingsAudioNormalizationLoudnorm => 'loudnorm preset';

  @override
  String get settingsCustomParameters => 'Custom parameters';

  @override
  String get settingsAudioNormalizationParameterHelp =>
      'Equivalent to --lavfi-complex=\"[aid1] parameters [ao]\"';

  @override
  String get settingsSuperResolution => 'Super resolution';

  @override
  String settingsSuperResolutionDescription(String value) {
    return 'Current: $value\nThe default applies to anime and is off for other videos\nHardware decoding is required; if it still doesn\'t work, try the auto-copy decoder';
  }

  @override
  String get settingsPreinitializePlayer => 'Pre-initialize player';

  @override
  String get settingsPreinitializePlayerDescription =>
      'Reduce loading time for manual playback';

  @override
  String get settingsHomePageAnimation => 'Home page switching animation';

  @override
  String get settingsSearchSuggestions => 'Search suggestions';

  @override
  String get settingsSearchHistory => 'Save search history';

  @override
  String get settingsShowDecorations =>
      'Show avatar, comment, and Feed decorations';

  @override
  String get settingsFanMedals => 'Show fan medals';

  @override
  String get settingsLivePhotoPreview => 'Preview Live Photos';

  @override
  String get settingsLivePhotoPreviewDescription =>
      'Play Live Photos as video; turn off to preview a still image';

  @override
  String get settingsSeekPreviewThumbnails => 'Show thumbnails while seeking';

  @override
  String get settingsDanmakuHeatmap => 'Show danmaku heatmap';

  @override
  String get settingsDanmakuHeatmapDescription =>
      'Shows how danmaku volume changes over time';

  @override
  String get settingsSaveComments => 'Save comments';

  @override
  String get settingsCommentAntifraud => 'Verify posted comments';

  @override
  String get settingsCommentAntifraudDescription =>
      'Check whether a comment remains visible after posting';

  @override
  String get settingsUseBilibiliCommentCheck =>
      'Use Bilibili Comment Anti-Fraud to verify comments';

  @override
  String get settingsFeedPostAntifraud =>
      'Verify posted and reposted Feed items';

  @override
  String get settingsFeedPostAntifraudDescription =>
      'Check whether a Feed item remains visible after posting or reposting';

  @override
  String get settingsBlockShoppingPosts => 'Block shopping Feed posts';

  @override
  String get settingsBlockShoppingComments => 'Block shopping comments';

  @override
  String get settingsSwipeToCloseSecondaryPages =>
      'Swipe to close secondary pages';

  @override
  String get settingsPinchToShrinkVideo => 'Pinch to shrink video';

  @override
  String get settingsSecondaryPageActionBar =>
      'Show bottom action bar on Feed and article details';

  @override
  String get settingsDragSubtitles => 'Drag subtitles to adjust bottom margin';

  @override
  String get settingsAnimeSchedule => 'Show anime schedule';

  @override
  String get settingsSilentImageDownload => 'Download images silently';

  @override
  String get settingsSilentImageDownloadDescription =>
      'Don\'t show a loading dialog while downloading';

  @override
  String get settingsImageContextMenu =>
      'Long-press or right-click for image menu';

  @override
  String get settingsHapticFeedback => 'Haptic feedback';

  @override
  String get settingsHapticFeedbackDescription =>
      'Make sure haptic feedback is enabled in system settings';

  @override
  String get settingsTrendingSearches => 'Trending searches';

  @override
  String get settingsTrendingSearchesDescription => 'Show Trending searches';

  @override
  String get settingsSearchDiscovery => 'Search discovery';

  @override
  String get settingsSearchDiscoveryDescription => 'Show Search discovery';

  @override
  String get settingsDefaultSearchTerm => 'Default search term';

  @override
  String get settingsDefaultSearchTermDescription =>
      'Show a default term in the search box';

  @override
  String get settingsQuickFavorite => 'Quick save';

  @override
  String get settingsQuickFavoriteDescription =>
      'Tap to choose a default favorite\nTap Save to use the default; long-press to choose a folder';

  @override
  String get settingsCommentSearchKeywords => 'Comment search keywords';

  @override
  String get settingsCommentSearchKeywordsDescription =>
      'Show suggested keywords in comments';

  @override
  String get settingsAiSummary => 'AI summary';

  @override
  String get settingsAiSummaryDescription =>
      'Enable AI summaries on video details';

  @override
  String get settingsDisableReceivedLikes =>
      'Disable Received likes in Messages';

  @override
  String get settingsDisableReceivedLikesDescription =>
      'Prevent opening it to reduce social-media dependence';

  @override
  String get settingsShowCommentsByDefault => 'Show comments by default';

  @override
  String get settingsShowCommentsByDefaultDescription =>
      'Open the Comments tab by default on video details (tab layout only)';

  @override
  String get settingsHttp2 => 'Enable HTTP/2';

  @override
  String get settingsRetryCount => 'Connection retry count';

  @override
  String get settingsZeroDisables => '0 disables this option';

  @override
  String get settingsRetryDelay => 'Connection retry delay';

  @override
  String get settingsRetryDelayDescription =>
      'Actual delay = interval × retry number';

  @override
  String get settingsCommentDisplay => 'Comment display';

  @override
  String settingsCurrentlyPrioritize(String value) {
    return 'Currently prioritize “$value”';
  }

  @override
  String get settingsFeedDisplay => 'Feed display';

  @override
  String get settingsFeedInteractions => 'Show Feed interactions';

  @override
  String get settingsFeedInteractionsDescription =>
      'Show interactions such as likes from people you follow and popular comments below Feed cards';

  @override
  String get settingsMemberDefaultTab => 'Default profile tab';

  @override
  String get settingsUploaderShopTab => 'Show Shop tab on Uploader profiles';

  @override
  String get settingsProxy => 'Proxy';

  @override
  String get settingsProxyDescription => 'Set proxy host:port';

  @override
  String get settingsProxyHostHint => 'Enter Host, separated with dots';

  @override
  String get settingsProxyPortHint => 'Enter Port';

  @override
  String get settingsMaximumCacheSize => 'Maximum cache size';

  @override
  String settingsCurrentMaximumCacheSize(String value) {
    return 'Current maximum cache size: $value';
  }

  @override
  String get settingsCheckForUpdates => 'Check for updates';

  @override
  String get settingsCheckForUpdatesDescription =>
      'Check for updates whenever the app starts';

  @override
  String get settingsSetNewPath => 'Choose new location';

  @override
  String get settingsCheckInterval => 'Check interval';

  @override
  String get settingsChooseDefaultFavorite => 'Choose default favorite';

  @override
  String get replySortNewest => 'Newest comments';

  @override
  String get replySortHottest => 'Top comments';

  @override
  String get replySortFeatured => 'Featured comments';

  @override
  String get replySortNewestShort => 'Newest';

  @override
  String get replySortHottestShort => 'Top';

  @override
  String get replySortFeaturedShort => 'Featured';

  @override
  String get memberTabDefault => 'Default';

  @override
  String get memberTabHome => 'Home';

  @override
  String get memberTabFeed => 'Feed';

  @override
  String get memberTabUploads => 'Uploads';

  @override
  String get memberTabFavorites => 'Favorites';

  @override
  String get memberTabAnime => 'Anime';

  @override
  String get memberTabCourses => 'Courses';

  @override
  String get memberTabShop => 'Shop';

  @override
  String get logsTitle => 'Logs';

  @override
  String get logsCopied => 'Copied';

  @override
  String get logsCleared => 'Logs cleared';

  @override
  String get logsTriggerError => 'Trigger error';

  @override
  String get logsEnabledRestartRequired => 'Logging enabled; restart to apply';

  @override
  String get logsDisabledRestartRequired =>
      'Logging disabled; restart to apply';

  @override
  String get logsEnable => 'Enable logging';

  @override
  String get logsDisable => 'Disable logging';

  @override
  String get logsCopy => 'Copy logs';

  @override
  String get logsErrorFeedback => 'Report an error';

  @override
  String get logsClear => 'Clear logs';

  @override
  String get logsRelatedInformation => 'Related information';

  @override
  String get logsCollapse => 'Collapse';

  @override
  String get logsExpand => 'Expand';

  @override
  String get logsDeviceInformation => 'Device information';

  @override
  String get logsAppInformation => 'App information';

  @override
  String get logsBuildInformation => 'Build information';

  @override
  String logsCopiedTimestamp(String time) {
    return 'Copied $time to the clipboard';
  }

  @override
  String get logsErrorDetails => 'Error details';

  @override
  String get logsStackTrace => 'Stack trace';

  @override
  String get settingsPlaybackSpeedSetDefault => 'Set as default speed';

  @override
  String get settingsPlaybackSpeedSetLongPress =>
      'Set as default long-press speed';

  @override
  String get settingsPlaybackSpeedDelete => 'Delete';

  @override
  String get settingsPlaybackSpeedAdd => 'Add speed';

  @override
  String get settingsPlaybackSpeedCustom => 'Custom speed';

  @override
  String get settingsPlaybackSpeedExists => 'This speed already exists';

  @override
  String get settingsPlaybackSpeedDefaultCannotDelete =>
      'Default speeds can\'t be deleted';

  @override
  String get settingsPlaybackSpeedHint =>
      'Use the buttons below to set default and long-press speeds';

  @override
  String get settingsPlaybackSpeedDefault => 'Default speed';

  @override
  String get settingsPlaybackSpeedDynamicLongPress =>
      'Dynamic long-press speed';

  @override
  String get settingsPlaybackSpeedDynamicLongPressDescription =>
      'Use twice the default speed while pressing and holding';

  @override
  String get settingsPlaybackSpeedDefaultLongPress =>
      'Default long-press speed';

  @override
  String get settingsPlaybackSpeedList => 'Speed list';

  @override
  String get settingsAdd => 'Add';

  @override
  String get settingsSavedNextLaunch =>
      'Saved; applies next time the app starts';

  @override
  String get settingsResetNextLaunch =>
      'Reset; applies next time the app starts';

  @override
  String settingsEditTitle(String title) {
    return 'Edit $title';
  }

  @override
  String get settingsSave => 'Save';

  @override
  String get settingsLongPressToReorder => 'Press and hold to reorder';

  @override
  String settingsCurrentFontSize(String value) {
    return 'Current font size: $value';
  }

  @override
  String get settingsSmall => 'Small';

  @override
  String get settingsLarge => 'Large';

  @override
  String get settingsScreenRefreshRateTitle => 'Screen refresh rate';

  @override
  String get settingsRestartIfDisplayModeFails =>
      'Not applied? Try restarting the app';

  @override
  String get settingsAutomatic => 'Automatic';

  @override
  String get settingsSystemModeMarker => 'system';

  @override
  String get settingsChooseAppTheme => 'Choose app theme';

  @override
  String get settingsPaletteStyle => 'Palette style';

  @override
  String get settingsDynamicColorUnsupported =>
      'Dynamic color may not be supported on this device';

  @override
  String settingsUseFont(String font) {
    return 'Use $font';
  }

  @override
  String get settingsViewLicense => 'View license';

  @override
  String get settingsAgreeAndDownload => 'Agree and download';

  @override
  String settingsFontDownloaded(String font) {
    return '$font downloaded';
  }

  @override
  String settingsFontDownloading(int progress) {
    return 'Downloading $progress%';
  }

  @override
  String get settingsFontConnecting => 'Connecting to download source';

  @override
  String settingsDownloadedWithSize(String size) {
    return 'Downloaded · $size';
  }

  @override
  String get settingsDownloaded => 'Downloaded';

  @override
  String get settingsDownloadFont => 'Download font';

  @override
  String get settingsFontErrorIncompleteFile =>
      'The font file is incomplete. Download it again';

  @override
  String get settingsFontErrorLoadFailed =>
      'Couldn\'t load the font. Download it again';

  @override
  String settingsFontErrorHttp(String status) {
    return 'Couldn\'t download the font (HTTP $status)';
  }

  @override
  String get settingsFontErrorLicenseExtraction =>
      'Couldn\'t extract the font license. Try again';

  @override
  String get settingsFontErrorDownloadFailed =>
      'Couldn\'t download the font. Try again later';

  @override
  String get settingsFontErrorSizeMismatch =>
      'The font file size didn\'t match. Try again';

  @override
  String get settingsFontErrorChecksumMismatch =>
      'The font checksum didn\'t match. Try again';

  @override
  String get settingsFontErrorTimeout =>
      'The font download timed out. Check your network and try again';

  @override
  String get settingsFontErrorNetwork =>
      'Couldn\'t download the font. Check your network';

  @override
  String get settingsFontErrorSaveFailed =>
      'Couldn\'t save the font. Check your available storage';

  @override
  String get settingsAppFontTitle => 'App font';

  @override
  String get settingsFontLxgwWenKai => 'LXGW WenKai';

  @override
  String get settingsFontLxgwZhenKai => 'LXGW ZhenKai';

  @override
  String get settingsFontLxgwNeoXiHei => 'LXGW Neo XiHei';

  @override
  String get settingsFontLxgwZhuqueFangsong => 'LXGW Zhuque Fangsong';

  @override
  String get settingsFontSourceHanSans => 'Source Han Sans';

  @override
  String get settingsFontSourceHanSerif => 'Source Han Serif';

  @override
  String get settingsFontFusionPixel => 'Fusion Pixel';

  @override
  String settingsFontLicenseNotice(String font) {
    return 'This app will use $font. By downloading and using it, you agree to its official license.';
  }

  @override
  String get settingsFullscreenSuperChatSizeTitle =>
      'Full-screen Super Chat size';

  @override
  String get themeColorDefaultGreen => 'Default green';

  @override
  String get themeColorPink => 'Pink';

  @override
  String get themeColorRed => 'Red';

  @override
  String get themeColorOrange => 'Orange';

  @override
  String get themeColorAmber => 'Amber';

  @override
  String get themeColorYellow => 'Yellow';

  @override
  String get themeColorLime => 'Lime';

  @override
  String get themeColorLightGreen => 'Light green';

  @override
  String get themeColorGreen => 'Green';

  @override
  String get themeColorTeal => 'Teal';

  @override
  String get themeColorCyan => 'Cyan';

  @override
  String get themeColorLightBlue => 'Light blue';

  @override
  String get themeColorBlue => 'Blue';

  @override
  String get themeColorIndigo => 'Indigo';

  @override
  String get themeColorPurple => 'Purple';

  @override
  String get themeColorDeepPurple => 'Deep purple';

  @override
  String get themeColorBlueGrey => 'Blue grey';

  @override
  String get themeColorBrown => 'Brown';

  @override
  String get themeColorGrey => 'Grey';

  @override
  String get commonCopy => 'Copy';

  @override
  String get homeFollowingAnime => 'Following';

  @override
  String get homeRankings => 'Rankings';

  @override
  String get homeWeeklyMustWatch => 'The Bests';

  @override
  String get homeEssentialVideos => 'Bilibili essentials';

  @override
  String get homeLastSeenRefresh => 'You were here last time\nTap to refresh';

  @override
  String get homeSwitchToCover => 'Switch to cover';

  @override
  String get homeSwitchToFirstFrame => 'Switch to first frame';

  @override
  String get homeGameEvents => 'Gaming events';

  @override
  String get homeAllLiveCategories => 'All categories';

  @override
  String get homeMyLiveFollowing => 'Following';

  @override
  String homeLiveFollowingCount(String count) {
    return '$count live now';
  }

  @override
  String get aboutAppDescription =>
      'A third-party Bilibili client built with Flutter';

  @override
  String get aboutAppSemantics => 'Discover a different world together';

  @override
  String get aboutAccessibilityAdapted => 'Accessibility supported';

  @override
  String get aboutCurrentVersion => 'Current version';

  @override
  String get aboutUpstreamVersion => 'Upstream version';

  @override
  String get aboutBuildType => 'Build type';

  @override
  String get aboutStableBuild => 'Stable';

  @override
  String get aboutDevelopmentBuild => 'Development';

  @override
  String get aboutSelfCompiledBuild => 'Self-compiled';

  @override
  String get aboutOpenSupportedLinks => 'Open supported links';

  @override
  String get aboutIssueFeedback => 'Report an issue';

  @override
  String get aboutErrorLogs => 'Error logs';

  @override
  String get aboutClearLogsHint => 'Press and hold to clear logs';

  @override
  String get aboutClearCacheConfirm =>
      'This will clear image and network caches. Continue?';

  @override
  String get aboutClearing => 'Clearing…';

  @override
  String get aboutClearSucceeded => 'Cleared';

  @override
  String get aboutClearCache => 'Clear cache';

  @override
  String aboutImageNetworkCache(Object size) {
    return 'Images and network cache: $size';
  }

  @override
  String get aboutImportExportLogin => 'Import / export sign-in data';

  @override
  String get aboutLoginData => 'Sign-in data';

  @override
  String get aboutImportExportSettings => 'Import / export settings';

  @override
  String get aboutSettingsData => 'Settings';

  @override
  String get aboutResetAllSettings => 'Reset all settings';

  @override
  String get aboutResetAllSettingsQuestion => 'Reset all settings?';

  @override
  String get aboutResetSucceeded => 'Reset';

  @override
  String get aboutResetExportableSettings => 'Reset exportable settings';

  @override
  String get aboutResetAllData => 'Reset all data (including sign-in data)';

  @override
  String importExportTitle(Object title) {
    return 'Import / export $title';
  }

  @override
  String importConfirmPreview(Object title) {
    return 'Import the following $title?';
  }

  @override
  String importInputTitle(Object title) {
    return 'Enter $title';
  }

  @override
  String importJsonParseFailed(Object error) {
    return 'Couldn\'t parse JSON: $error';
  }

  @override
  String get importSucceeded => 'Imported';

  @override
  String importFailed(Object error) {
    return 'Couldn\'t import: $error';
  }

  @override
  String get importClipboardEmpty => 'The clipboard is empty';

  @override
  String get exportToClipboard => 'Export to clipboard';

  @override
  String get exportToLocalFile => 'Export to a local file';

  @override
  String get importEnterManually => 'Enter manually';

  @override
  String get importFromClipboard => 'Import from clipboard';

  @override
  String get importFromLocalFile => 'Import from a local file';

  @override
  String get memberHomeVideos => 'Videos';

  @override
  String get memberHomeFavorites => 'Favorites';

  @override
  String get memberHomeRecentCoinedVideos => 'Recently supported with coins';

  @override
  String get memberHomeRecentLikedVideos => 'Recently liked videos';

  @override
  String get memberHomePosts => 'Posts';

  @override
  String get memberHomeAudio => 'Audio';

  @override
  String get memberHomeComics => 'Comics';

  @override
  String get memberHomeAnime => 'Anime';

  @override
  String blacklistTitle(Object count) {
    return 'Blocked users$count';
  }

  @override
  String blacklistCountSuffix(Object count) {
    return ': $count';
  }

  @override
  String blacklistAddedAt(Object date) {
    return 'Added: $date';
  }

  @override
  String blacklistRemoveConfirm(Object name) {
    return 'Remove $name from blocked users?';
  }

  @override
  String get blacklistRemoved => 'Removed';

  @override
  String get webDavSettingsTitle => 'WebDAV settings';

  @override
  String get webDavBackupSettings => 'Back up settings';

  @override
  String get webDavRestoreSettings => 'Restore settings';

  @override
  String get webDavConfigurationSucceeded => 'Configuration saved';

  @override
  String webDavConfigurationFailed(Object error) {
    return 'Couldn\'t save configuration: $error';
  }

  @override
  String webDavBackupConfigurationFailed(Object error) {
    return 'Couldn\'t back up. Check the configuration: $error';
  }

  @override
  String get webDavBackupSucceeded => 'Backup complete';

  @override
  String webDavBackupFailed(Object error) {
    return 'Couldn\'t back up: $error';
  }

  @override
  String get webDavRestoreSucceeded => 'Settings restored';

  @override
  String webDavRestoreFailed(Object error) {
    return 'Couldn\'t restore settings: $error';
  }

  @override
  String webDavCheckConfiguration(Object error) {
    return 'Check the configuration: $error';
  }

  @override
  String get webDavBackupNotFound => 'No settings backup was found';

  @override
  String get sponsorBlockTitle => 'SponsorBlock';

  @override
  String get sponsorBlockMinimumDuration => 'Minimum segment duration';

  @override
  String get sponsorBlockMinimumDurationDescription =>
      'Ignore segments shorter than this duration';

  @override
  String get sponsorBlockAbout => 'About SponsorBlock';

  @override
  String get sponsorBlockUserId => 'User ID';

  @override
  String get sponsorBlockUserIdValidation =>
      'The User ID must be an alphanumeric string of at least 30 characters';

  @override
  String get sponsorBlockRandom => 'Random';

  @override
  String get sponsorBlockShowSkipToast => 'Show a toast after skipping';

  @override
  String get sponsorBlockTrackSkips => 'Track skip statistics';

  @override
  String get sponsorBlockTrackSkipsDescription =>
      'This reports skipped segments so contributors can see how many people they helped. Votes are also used to keep spam out of the database. A message is sent to the server whenever a segment is skipped. Enabling this improves the accuracy of the statistics.';

  @override
  String get sponsorBlockYourInformation => 'Your information';

  @override
  String sponsorBlockUserInformation(
    Object minutes,
    Object segments,
    Object views,
  ) {
    return 'You submitted $segments segments\nYour segments have helped viewers $views times\n($minutes minutes saved)';
  }

  @override
  String get sponsorBlockServerError => 'Server error';

  @override
  String get sponsorBlockServerAddress => 'Server address';

  @override
  String get sponsorBlockServerStatus => 'Server status';

  @override
  String get sponsorBlockServerNormal => 'Available';

  @override
  String get sponsorBlockServerUnavailable => 'Unavailable';

  @override
  String sponsorBlockColorPickerTitle(Object category) {
    return 'Color for $category';
  }

  @override
  String get sponsorBlockDescriptionSponsor =>
      'Paid promotion, sponsorship, direct advertising, or product placement. This does not include unpaid mentions.';

  @override
  String get sponsorBlockDescriptionSelfPromotion =>
      'Unpaid or self promotion, including merchandise, donations, or collaborator information.';

  @override
  String get sponsorBlockDescriptionExclusiveAccess =>
      'Marks a whole video that showcases a product, service, or location provided free or at a discount.';

  @override
  String get sponsorBlockDescriptionInteraction =>
      'A brief reminder to like, follow, or interact. Longer segments with meaningful content belong under self promotion.';

  @override
  String get sponsorBlockDescriptionHighlight =>
      'The moment most viewers are looking for, such as the timestamp shown on the thumbnail.';

  @override
  String get sponsorBlockDescriptionIntro =>
      'An intermission or intro with no actual content, such as a pause, still frame, or repeated animation.';

  @override
  String get sponsorBlockDescriptionOutro =>
      'Endcards or credits with no additional content.';

  @override
  String get sponsorBlockDescriptionPreview =>
      'A recap or preview whose content appears again later in this video or the same series.';

  @override
  String get sponsorBlockDescriptionPadding =>
      'Blank or unrelated padding around reposted content, with no meaningful connection to the main video.';

  @override
  String get sponsorBlockDescriptionFiller =>
      'Tangents or jokes that are not required to understand the main content. This is an aggressive category.';

  @override
  String get sponsorBlockDescriptionMusicOfftopic =>
      'For music videos only: non-music sections that do not fit another category.';

  @override
  String get videoCooperation => 'Collaboration';

  @override
  String get commonSort => 'Sort';

  @override
  String get commonMultiSelect => 'Select multiple';

  @override
  String get commonUpdate => 'Update';

  @override
  String get commonUpdateSucceeded => 'Updated';

  @override
  String get commonUpdateFailed => 'Couldn\'t update';

  @override
  String get commonMove => 'Move';

  @override
  String get commonPlayAll => 'Play all';

  @override
  String get favoriteTitle => 'My favorites';

  @override
  String get favoriteNewFolder => 'New favorites folder';

  @override
  String get favoriteFolderSort => 'Sort favorites folders';

  @override
  String get favoriteLoadAllBeforeSorting =>
      'Load all favorites folders before sorting';

  @override
  String get favoriteTabVideos => 'Videos';

  @override
  String get favoriteTabAnime => 'Anime';

  @override
  String get favoriteTabSeries => 'TV series';

  @override
  String get favoriteTabArticles => 'Articles';

  @override
  String get favoriteTabNotes => 'Notes';

  @override
  String get favoriteTabTopics => 'Topics';

  @override
  String get favoriteTabCourses => 'Courses';

  @override
  String get laterAll => 'All';

  @override
  String get laterUnfinished => 'Unfinished';

  @override
  String get laterRecentlyAdded => 'Recently added';

  @override
  String get laterEarliestAdded => 'Earliest added';

  @override
  String get laterClearInvalid => 'Clear unavailable';

  @override
  String get laterClearWatched => 'Clear watched';

  @override
  String get laterClearAll => 'Clear all';

  @override
  String get historyAll => 'All';

  @override
  String get historyTitle => 'Watch history';

  @override
  String get historyPause => 'Pause watch history';

  @override
  String get historyResume => 'Resume watch history';

  @override
  String get historyClear => 'Clear watch history';

  @override
  String get historyDeleteWatched => 'Delete watched items';

  @override
  String get historyDisabled => ' Watch history is paused';

  @override
  String get historyTapToEnable => 'Turn on';

  @override
  String get statisticsTitle => 'Viewing statistics';

  @override
  String get statisticsLoading => 'Loading the latest 1,200 history records…';

  @override
  String statisticsLoadingCount(int count) {
    return 'Loaded $count / 1,200 records…';
  }

  @override
  String get statisticsRange7Days => '7 days';

  @override
  String get statisticsRange30Days => '30 days';

  @override
  String get statisticsRange90Days => '90 days';

  @override
  String get statisticsPartialData =>
      'Some watch history couldn\'t be loaded. This summary may be incomplete.';

  @override
  String get statisticsEmpty => 'No watch history is available to analyze';

  @override
  String get statisticsOverview => 'Recent viewing overview';

  @override
  String statisticsDateRange(String start, String end) {
    return '$start – $end';
  }

  @override
  String statisticsRecordCoverage(int count, String start, String end) {
    return 'Latest $count records · $start – $end';
  }

  @override
  String get statisticsRecordLimitReached =>
      'Reached bilibili\'s 1,200-record query limit';

  @override
  String get statisticsDistinctContent => 'Different items viewed';

  @override
  String get statisticsCompleted => 'Completed';

  @override
  String get statisticsUnfinished => 'Unfinished';

  @override
  String get statisticsContinueWatchingMetric => 'Ready to continue';

  @override
  String get statisticsActiveDays => 'Active days';

  @override
  String get statisticsFavorited => 'Favorited';

  @override
  String get statisticsCurrentStreak => 'Current active streak';

  @override
  String get statisticsLongestStreak => 'Longest active streak';

  @override
  String get statisticsWeekdayDistribution => 'Weekday distribution';

  @override
  String get statisticsWeekdayDistributionDescription =>
      'Records grouped by the day of the week';

  @override
  String get statisticsActivityTapHint => 'View records for this date';

  @override
  String get statisticsNoActivityRecords =>
      'No records are available for this date';

  @override
  String get statisticsExportJson => 'Export JSON';

  @override
  String get statisticsExportCsv => 'Export CSV';

  @override
  String get statisticsExportScreenshot => 'Save screenshot';

  @override
  String get statisticsActivity => 'Activity';

  @override
  String get statisticsActivityDescription =>
      'The full date span covered by the available records';

  @override
  String statisticsActivityTooltip(String date, int count) {
    return '$date: $count items';
  }

  @override
  String statisticsActivityRecords(String date, int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count records',
      one: '$count record',
    );
    return '$date · $_temp0';
  }

  @override
  String get statisticsRecordTime => 'Active hours';

  @override
  String get statisticsRecordTimeDescription =>
      'Based on when each history entry was last updated';

  @override
  String statisticsHourTooltip(int hour, int count) {
    return '$hour:00 · $count items';
  }

  @override
  String get statisticsContentTypes => 'Content types';

  @override
  String get statisticsContentTypesDescription =>
      'The content mix in the available records';

  @override
  String get statisticsTopUploaders => 'Top uploaders';

  @override
  String get statisticsTopUploadersDescription =>
      'Ranked by the number of different items viewed';

  @override
  String statisticsUploaderSummary(int contentCount, int completedCount) {
    return '$contentCount viewed · $completedCount completed';
  }

  @override
  String get statisticsContinueWatching => 'Continue watching';

  @override
  String statisticsRemainingTotal(int count, String duration) {
    return '$count items · about $duration remaining';
  }

  @override
  String statisticsRemaining(String duration) {
    return '$duration remaining';
  }

  @override
  String get statisticsDataSourceNotice =>
      'Based on up to the latest 1,200 cross-platform history records currently available from bilibili. Paused, cleared, or unrecorded history isn\'t included; record times and remaining durations don\'t represent actual watch time.';

  @override
  String get statisticsTypeVideo => 'Videos';

  @override
  String get statisticsTypePgc => 'Anime & TV';

  @override
  String get statisticsTypeLive => 'Live';

  @override
  String get statisticsTypeArticle => 'Articles';

  @override
  String get statisticsTypeCourse => 'Courses';

  @override
  String get statisticsTypeOther => 'Other';

  @override
  String get statisticsUncategorized => 'Uncategorized';

  @override
  String get downloadOfflineTitle => 'Downloads';

  @override
  String downloadDownloadingCount(Object count) {
    return 'Downloading ($count)';
  }

  @override
  String get downloadDownloadedVideos => 'Downloaded videos';

  @override
  String downloadVideoCount(Object count) {
    return '$count videos';
  }

  @override
  String get downloadCourse => 'Course';

  @override
  String get downloadAnime => 'Anime';

  @override
  String get downloadMovie => 'Movie';

  @override
  String get downloadDocumentary => 'Documentary';

  @override
  String get downloadChineseAnimation => 'Chinese animation';

  @override
  String get downloadTvSeries => 'TV series';

  @override
  String get downloadVarietyShow => 'Variety show';

  @override
  String get downloadConfirmDelete => 'Delete this download?';

  @override
  String get downloadUpdateDanmaku => 'Update danmaku';

  @override
  String get messagesTitle => 'Messages';

  @override
  String get messagesNewFollowers => 'New followers';

  @override
  String get messagesRepliesToMe => 'Replies';

  @override
  String get messagesMentions => 'Mentions';

  @override
  String get messagesReceivedLikes => 'Likes';

  @override
  String get messagesSystemNotifications => 'System notifications';

  @override
  String get messagesMarkedAsRead => 'Marked as read';

  @override
  String get messagesMarkAsRead => 'Mark as read';

  @override
  String get messagesEnableDoNotDisturb => 'Turn on mute';

  @override
  String get messagesDisableDoNotDisturb => 'Turn off mute';

  @override
  String get messagesDeleteConversationConfirm => 'Delete this conversation?';

  @override
  String get contactsTitle => 'Contacts';

  @override
  String get loginDevicesTitle => 'Sign-in devices';

  @override
  String get loginDevicesCurrentDevice => '(this device)';

  @override
  String get memberMyFeed => 'My posts';

  @override
  String get memberSpaceSettings => 'Profile settings';

  @override
  String get messagesLikeDetails => 'Like details';

  @override
  String get messagesMentionsMe => 'Mentions';

  @override
  String get messagesDeleteNotificationConfirm => 'Delete this notification?';

  @override
  String messagesMentionedIn(Object business) {
    return ' mentioned you in $business';
  }

  @override
  String get messagesAndOthers => ' and others';

  @override
  String messagesCommentsOnMyItem(Object business, Object count) {
    return ' left $count comments on your $business';
  }

  @override
  String get messagesLatest => 'Latest';

  @override
  String get messagesTotal => 'All time';

  @override
  String get messagesDeleteLikeNoticeConfirm =>
      'If you delete this notification, it will appear again when the item receives a new like. Continue?';

  @override
  String get messagesStopNotifications => 'Stop notifications';

  @override
  String get messagesStopNotificationsConfirm =>
      'You won\'t receive more like notifications for this item, but it will remain in the list. Continue?';

  @override
  String get messagesReceiveNotifications => 'Receive notifications';

  @override
  String messagesAndPeople(Object count) {
    return ' and $count others';
  }

  @override
  String messagesLikedMyItem(Object business) {
    return ' liked your $business';
  }

  @override
  String get messagesViewFeed => 'View post';

  @override
  String get messagesWebLink => 'Web link';

  @override
  String get accountSwitchAnonymousHint => 'Use anonymous mode when mid is 0';

  @override
  String get accountSwitchDetailed => 'Detailed';

  @override
  String get accountSwitchQuick => 'Quick';

  @override
  String get accountSignInFirst => 'Sign in first';

  @override
  String replyIpLocation(Object region) {
    return 'IP location: $region';
  }

  @override
  String get videoPersonalOpinionDisclaimer =>
      'Personal opinion; for reference only';

  @override
  String videoAllEpisodes(Object count) {
    return 'All $count episodes';
  }

  @override
  String get feedPostedVideo => 'posted a video';

  @override
  String get feedCoCreated => 'co-created with others';

  @override
  String get feedLikesAndReposts => 'Likes & reposts';

  @override
  String get feedSaySomething => 'Say something…';

  @override
  String get feedShareToFeed => 'Share to Feed';

  @override
  String get feedRepostFeed => 'Repost';

  @override
  String get feedPublishNow => 'Post now';

  @override
  String get feedRepostNow => 'Repost now';

  @override
  String get feedPublish => 'Post';

  @override
  String get feedRepostSucceeded => 'Reposted';

  @override
  String get commonCopied => 'Copied';

  @override
  String get commonExport => 'Export';

  @override
  String get commonNoData => 'No data';

  @override
  String get commonTapToRetry => 'Tap to retry';

  @override
  String get watchLaterAdded => 'Added to Watch later';

  @override
  String get watchLaterRemoved => 'Removed from Watch later';

  @override
  String get myCommentsTitle => 'My comments';

  @override
  String get subscriptionFolder => 'Favorites folder';

  @override
  String get subscriptionCollection => 'Collection';

  @override
  String subscriptionOtherType(Object type) {
    return 'Other ($type)';
  }

  @override
  String subscriptionUnavailable(Object type) {
    return 'This $type is unavailable';
  }

  @override
  String subscriptionUploader(Object name) {
    return 'Uploader: $name';
  }

  @override
  String subscriptionVideoCount(Object count) {
    return '$count videos';
  }

  @override
  String subscriptionTotalVideos(Object count) {
    return '$count videos';
  }

  @override
  String subscriptionPlayCount(Object count) {
    return '$count views';
  }

  @override
  String get subscriptionCancelConfirm => 'Cancel this subscription?';

  @override
  String get subscriptionCanceled => 'Subscription canceled';

  @override
  String get commonSaving => 'Saving…';

  @override
  String get commonSaved => 'Saved';

  @override
  String get commonSaveFailed => 'Couldn\'t save';

  @override
  String commonSaveFailedWithError(Object error) {
    return 'Couldn\'t save: $error';
  }

  @override
  String get commonSaveCanceled => 'Save canceled';

  @override
  String get commonDownloadCanceled => 'Download canceled';

  @override
  String get commonDownloading => 'Downloading…';

  @override
  String get commonDownloadingOriginal => 'Downloading original image…';

  @override
  String get commonFileNotFound => 'File not found';

  @override
  String get permissionStorageRequired => 'Storage permission is required';

  @override
  String get permissionOpenSettings => 'Open settings';

  @override
  String get laterDeleteSelectedConfirm =>
      'Remove the selected Watch later items?';

  @override
  String get laterRemoveVideoConfirm => 'Remove this video from Watch later?';

  @override
  String get laterRemoveConfirmed => 'Remove';

  @override
  String get laterClearInvalidConfirm => 'Clear unavailable videos?';

  @override
  String get laterClearWatchedConfirm => 'Clear watched videos?';

  @override
  String get laterClearAllConfirm => 'Clear the Watch later list?';

  @override
  String get laterCleared => 'Watch later cleared';

  @override
  String get videoPremiumRequired => 'Premium is required';

  @override
  String videoSwitchingTo(Object title) {
    return 'Switching to: $title';
  }

  @override
  String get shareTo => 'Share with';

  @override
  String get shareChooseRecipients => 'Choose at least one recipient';

  @override
  String get shareSucceeded => 'Shared';

  @override
  String get shareFailed => 'Couldn\'t share';

  @override
  String get sharePartiallyFailed => 'Some items couldn\'t be shared';

  @override
  String get followCreateGroup => 'New group';

  @override
  String get followGroupCreated => 'Group created';

  @override
  String get followSucceeded => 'Following';

  @override
  String get followAddPriority => 'Add to priority following';

  @override
  String get followRemovePriority => 'Remove from priority following';

  @override
  String get followPriorityAdded => 'Added to priority following';

  @override
  String get followPriorityRemoved => 'Removed from priority following';

  @override
  String get followSetGroup => 'Set group';

  @override
  String get followUnfollow => 'Unfollow';

  @override
  String get followUnfollowSucceeded => 'Unfollowed';

  @override
  String get commonCopyTo => 'Copy to';

  @override
  String get commonMoveTo => 'Move to';

  @override
  String get commonMoved => 'Moved';

  @override
  String get feedAppeal => 'Appeal';

  @override
  String get feedCheckResult => 'Post check result';

  @override
  String get feedCheckPassed => 'Your post is publicly visible.';

  @override
  String get feedCheckShadowBanned => 'Your post may only be visible to you.';

  @override
  String feedPostContent(Object content) {
    return 'Post: $content';
  }

  @override
  String get commonMissingParameters => 'Required parameters are missing';

  @override
  String get videoCoinSucceeded => 'Coined';

  @override
  String get historyNoWatchedItems => 'No watched items';

  @override
  String get historyDeleteSelectedConfirm =>
      'Delete the selected history items?';

  @override
  String get historyClearConfirm => 'Clear all watch history?';

  @override
  String get historyCleared => 'Watch history cleared';

  @override
  String get historyConfirmClear => 'Clear history';

  @override
  String get historyPauseConfirm => 'Pause watch history?';

  @override
  String get historyResumeConfirm => 'Resume watch history?';

  @override
  String get historyPaused => 'Watch history paused';

  @override
  String get historyResumed => 'Watch history resumed';

  @override
  String get historyConfirmPause => 'Pause';

  @override
  String get historyConfirmResume => 'Resume';

  @override
  String get commonActionsMenu => 'Actions';

  @override
  String get commonFavorited => 'Favorited';

  @override
  String get liveNotStarted => 'The live stream hasn\'t started';

  @override
  String get historyDeleteRecord => 'Delete from history';

  @override
  String get loginTitle => 'Sign in';

  @override
  String get loginWithQr => 'Scan with the official bilibili app';

  @override
  String loginQrExpiresIn(Object seconds) {
    return 'Expires in ${seconds}s';
  }

  @override
  String get loginRefreshQr => 'Refresh QR code';

  @override
  String get loginGeneratingScreenshot => 'Creating image…';

  @override
  String get loginSaveToGallery => 'Save to Photos';

  @override
  String get loginOpenInAnotherApp => 'Open in another app';

  @override
  String get loginQrCopiedHint =>
      'Copied. Send it in a bilibili message from a signed-in app, then open the sent link.';

  @override
  String loginTrustedSourceNotice(Object appName) {
    return 'Only install $appName from its open-source repository or another trusted source.';
  }

  @override
  String get loginWithCookie => 'Sign in with Cookie';

  @override
  String get loginCookieLimit =>
      'Features that require app APIs won\'t be available';

  @override
  String get loginWithPassword => 'Sign in with password';

  @override
  String get loginAccount => 'Account';

  @override
  String get loginEmailOrPhone => 'Email or phone';

  @override
  String get loginPassword => 'Password';

  @override
  String get loginShowPassword => 'Show password';

  @override
  String get loginForgotPasswordQuestion => 'Forgot password?';

  @override
  String get loginForgotPasswordHint =>
      'Try QR code or SMS sign-in, or choose a recovery page.';

  @override
  String get loginRecoverPasswordMobile => 'Recover password (mobile)';

  @override
  String get loginRecoverPasswordDesktop => 'Recover password (desktop)';

  @override
  String loginPasswordSecurityNotice(Object appName) {
    return 'Following bilibili\'s official sign-in protocol, your password is salted and encrypted locally before transmission. The salt and public key are provided by bilibili and RSA/ECB/PKCS1Padding is used. Your credentials are only used for sign-in and aren\'t stored; only the resulting sign-in token is stored locally.\nOnly install $appName from its open-source repository or another trusted source.';
  }

  @override
  String get loginWithSms => 'Sign in with SMS code';

  @override
  String loginCountryCodeTooltip(Object code, Object name) {
    return 'Choose a country calling code. Current: $name (+$code)';
  }

  @override
  String get loginCountryOrRegion => 'Country/region';

  @override
  String get loginPhoneNumber => 'Phone number';

  @override
  String get loginVerificationCode => 'Verification code';

  @override
  String loginWaitSeconds(Object seconds) {
    return 'Wait ${seconds}s';
  }

  @override
  String get loginGetVerificationCode => 'Get code';

  @override
  String loginSmsPrivacyNotice(Object appName) {
    return 'Your phone number is only sent to bilibili\'s official SMS and sign-in APIs and isn\'t stored. Only the resulting sign-in token is stored locally.\nOnly install $appName from its open-source repository or another trusted source.';
  }

  @override
  String get loginPasswordTab => 'Password';

  @override
  String get loginSmsTab => 'SMS';

  @override
  String get loginQrTab => 'QR code';

  @override
  String get loginQrExpired => 'QR code expired. Refresh it.';

  @override
  String get loginQrSucceeded => 'QR code scanned';

  @override
  String get loginVerificationSucceeded => 'Verified';

  @override
  String get loginCookieRequired => 'Enter a Cookie';

  @override
  String get loginSucceeded => 'Signed in';

  @override
  String loginFailedWithError(Object error) {
    return 'Sign-in failed: $error';
  }

  @override
  String get loginSessionExpired =>
      'Your bilibili sign-in has expired. Sign in again.';

  @override
  String get loginUserInfoFailed =>
      'Couldn\'t get bilibili account information. Try again from account management.';

  @override
  String get loginCredentialsRequired => 'Enter your account and password';

  @override
  String loginNoDataReturned(Object message) {
    return 'Sign-in returned no data: $message';
  }

  @override
  String loginTryAnotherMethod(Object details) {
    return 'Try another sign-in method.\n$details';
  }

  @override
  String get loginPhoneVerificationUnavailable =>
      'This account can\'t use phone verification. Try another sign-in method.';

  @override
  String get loginPhoneVerificationRequired => 'Phone verification is required';

  @override
  String get loginPhoneUnavailable => 'Couldn\'t get the phone number';

  @override
  String get loginEnterVerificationCode => 'Enter the SMS code';

  @override
  String get loginSendVerificationCode => 'Send code';

  @override
  String get loginVerificationCodeSent => 'Verification code sent';

  @override
  String get loginVerifyingAndSigningIn => 'Verified. Signing in…';

  @override
  String loginMissingIdentity(Object details) {
    return 'Sign-in returned no identity information, possibly due to account security controls. Try another method.\n$details';
  }

  @override
  String get loginSavingIdentity => 'Saving sign-in information…';

  @override
  String get loginPhoneRequired => 'Enter a phone number';

  @override
  String get loginRequestCodeFirst => 'Get a verification code first';

  @override
  String get loginVerificationCodeRequired => 'Enter the verification code';

  @override
  String get loginVerificationCodeExpired =>
      'Verification code expired. Get a new one.';

  @override
  String get loginSucceededSetAccountMode =>
      'Signed in. Choose an account mode.';

  @override
  String get commonServerError => 'Server error';

  @override
  String get networkBadCertificate => 'Invalid certificate';

  @override
  String get networkServerError => 'Server error. Try again later';

  @override
  String get networkRequestCancelled => 'Request cancelled';

  @override
  String get networkConnectionError =>
      'Connection error. Check your network settings';

  @override
  String get networkConnectionTimeout =>
      'Connection timed out. Check your network settings';

  @override
  String get networkResponseTimeout => 'Response timed out. Try again later';

  @override
  String get networkSendTimeout =>
      'Request timed out. Check your network settings';

  @override
  String get networkTransformTimeout => 'Response processing timed out';

  @override
  String networkUnknownError(String error) {
    return 'Network error: $error';
  }

  @override
  String get searchSecurityCheckTriggered => 'A security check is required';

  @override
  String get loginVerificationTitle => 'Verification';

  @override
  String get loginCompleteVerificationWindow =>
      'Complete verification in the new window';

  @override
  String get memberBlockConfirm => 'Block this Uploader?';

  @override
  String get memberUnblockConfirm => 'Remove this Uploader from blocked users?';

  @override
  String get memberNoPlayableVideos => 'This Uploader has no playable videos';

  @override
  String get memberVideoPlayInfoUnavailable =>
      'Couldn\'t get playback information';

  @override
  String memberRandomVideoFailed(Object error) {
    return 'Couldn\'t choose a random video: $error';
  }

  @override
  String get memberFollowerRemoved => 'Follower removed';

  @override
  String get memberPremiumRewardClaimed => 'Reward claimed';

  @override
  String get memberAddToBlocked => 'Block';

  @override
  String get memberRemoveFromBlocked => 'Unblock';

  @override
  String get memberRemoveFollower => 'Remove follower';

  @override
  String get memberShareUploader => 'Share Uploader';

  @override
  String get memberShareMyProfile => 'Share my profile';

  @override
  String get memberAddToHomeScreen => 'Add to Home Screen';

  @override
  String get memberRandomPlay => 'Shuffle';

  @override
  String get memberReservation => 'Reservation';

  @override
  String get memberReserved => 'Reserved';

  @override
  String get memberReservationPost => 'Reservation post';

  @override
  String memberReservationCount(Object count) {
    return '$count reservations';
  }

  @override
  String get memberWebUploads => 'Web uploads';

  @override
  String get memberPremiumXp => 'Premium XP';

  @override
  String get memberSignInHistory => 'Sign-in history';

  @override
  String get memberCoinHistory => 'Coin history';

  @override
  String get memberXpHistory => 'XP history';

  @override
  String memberFollowingSince(Object date) {
    return 'Following since: $date';
  }

  @override
  String get memberAccountBanned => 'This account is suspended';

  @override
  String memberSupporterCount(Object count) {
    return '$count supporters';
  }

  @override
  String memberGuardCount(Object count) {
    return '$count members joined the guard';
  }

  @override
  String get memberMyRecommendations => 'My recommendations';

  @override
  String memberRecommendationsBy(String name) {
    return '$name\'s recommendations';
  }

  @override
  String memberCollectionCount(int count) {
    return 'Collection: $count';
  }

  @override
  String memberListCount(int count) {
    return 'List: $count';
  }

  @override
  String memberGuardTitle(String name) {
    return '$name\'s guard';
  }

  @override
  String memberGuardTitleWithCount(String name, Object count) {
    return '$name\'s guard ($count)';
  }

  @override
  String get memberAlsoFollowed => 'Also followed';

  @override
  String memberAlsoFollowedWithOthers(Object count) {
    return 'and $count others also followed';
  }

  @override
  String get memberLikesReceived => 'Likes';

  @override
  String get memberFollowingTime => 'Follow time';

  @override
  String commonSelectedCount(Object count) {
    return 'Selected: $count';
  }

  @override
  String get commonSelectAll => 'Select all';

  @override
  String get commonCancelSelection => 'Cancel selection';

  @override
  String get imageSaveImage => 'Save image';

  @override
  String get imageSaveAll => 'Save all';

  @override
  String get imageSaveAllImages => 'Save all images';

  @override
  String get imageSaveVideo => 'Save video';

  @override
  String get imageSaveLivePhoto => 'Save Live Photo';

  @override
  String get imageOpenInBrowser => 'Open in browser';

  @override
  String get commonDone => 'Done';

  @override
  String get commonCreate => 'Create';

  @override
  String get favoriteSortMethod => 'Sort by';

  @override
  String favoriteContentCount(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count items',
      one: '1 item',
    );
    return '$_temp0';
  }

  @override
  String favoriteContentSummary(num count, Object visibility) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count items · $visibility',
      one: '1 item · $visibility',
    );
    return '$_temp0';
  }

  @override
  String get favoriteEditInfo => 'Edit details';

  @override
  String get favoriteShareToPost => 'Share to post';

  @override
  String get favoriteClearUnavailable => 'Clear unavailable items';

  @override
  String get favoriteDeleteFolderConfirm => 'Delete this favorites folder?';

  @override
  String get favoriteRemoveSelectedConfirm => 'Remove the selected favorites?';

  @override
  String get favoriteRemoved => 'Removed from favorites';

  @override
  String get favoriteFolderAdded => 'Favorites folder added';

  @override
  String get favoriteFolderRemoved => 'Favorites folder removed';

  @override
  String get favoriteClearSucceeded => 'Unavailable items cleared';

  @override
  String get favoriteTooManyToSort =>
      'Folders with more than 1,000 items can\'t be sorted';

  @override
  String get favoriteRemoveConfirm => 'Remove this item from favorites?';

  @override
  String get favoriteConfirmRemove => 'Remove';

  @override
  String get favoriteAudio => 'Audio';

  @override
  String get favoriteAddToFolder => 'Add to favorites';

  @override
  String get favoriteNameRequired => 'Enter a name';

  @override
  String get favoriteFolderCreated => 'Favorites folder created';

  @override
  String get favoriteFolderUpdated => 'Favorites folder updated';

  @override
  String get favoriteCrop => 'Crop';

  @override
  String get favoriteReplaceCover => 'Replace cover';

  @override
  String get favoriteRemoveCover => 'Remove cover';

  @override
  String get favoriteCover => 'Cover';

  @override
  String get favoriteName => 'Name';

  @override
  String get favoriteIntro => 'Description';

  @override
  String get favoriteIntroHint => 'Add a description';

  @override
  String get favoritePublicSetting => 'Public';

  @override
  String get favoriteCollectionBadge => 'Collection';

  @override
  String get favoriteFolderBadge => 'Favorites folder';

  @override
  String favoriteUploaderCollectionSummary(Object count, Object name) {
    return '$count items · $name';
  }

  @override
  String favoriteCreatedCollectionSummary(
    Object count,
    Object name,
    Object views,
  ) {
    return 'Creator: $name\n$count videos · $views views';
  }

  @override
  String get favoriteOrderRecentlyAdded => 'Recently added';

  @override
  String get favoriteOrderMostPlayed => 'Most played';

  @override
  String get favoriteOrderRecentlyPublished => 'Recently published';

  @override
  String get profileTitle => 'Account profile';

  @override
  String get profileAvatar => 'Avatar';

  @override
  String get profileNickname => 'Name';

  @override
  String get profileGender => 'Gender';

  @override
  String get profileBirthday => 'Birthday';

  @override
  String get profileBio => 'Bio';

  @override
  String get profileAvatarDecoration => 'Avatar decoration';

  @override
  String get profileVerification => 'bilibili verification';

  @override
  String get profileInsufficientCoins => 'Not enough coins';

  @override
  String get profileGenderMale => 'Male';

  @override
  String get profileGenderPrivate => 'Prefer not to say';

  @override
  String get profileGenderFemale => 'Female';

  @override
  String profileEditField(Object field) {
    return 'Edit $field';
  }

  @override
  String profileSameAsCurrent(Object field) {
    return 'This is the same as your current $field';
  }

  @override
  String get profileReloginRequired => 'Sign out and sign in again';

  @override
  String get profileUpdateSucceeded => 'Profile updated';

  @override
  String get profileGifNotSupported => 'GIF avatars aren\'t supported';

  @override
  String get shutdownPauseVideo => 'Pause video';

  @override
  String get shutdownExitApp => 'Exit app';

  @override
  String get shutdownTitle => 'Sleep timer';

  @override
  String get shutdownCanceled => 'Sleep timer canceled';

  @override
  String shutdownScheduledAfter(Object duration) {
    return 'Sleep timer set for $duration';
  }

  @override
  String get shutdownTimeReachedPaused => 'Timer ended. Playback paused';

  @override
  String shutdownHoursMinutes(Object hours, Object minutes) {
    return '$hours hr $minutes min';
  }

  @override
  String shutdownHours(Object hours) {
    return '$hours hr';
  }

  @override
  String shutdownMinutes(Object minutes) {
    return '$minutes min';
  }

  @override
  String get shutdownCustom => 'Custom';

  @override
  String get shutdownWaitUntilVideoEnds => 'Wait until the video ends';

  @override
  String get shutdownActionAtEnd => 'When timer ends:';

  @override
  String get replyViewComments => 'View comments';

  @override
  String get replyAppeal => 'Appeal';

  @override
  String get replyCheckResult => 'Comment check result';

  @override
  String replyMainListError(Object error) {
    return 'Couldn\'t load the main comment list: $error';
  }

  @override
  String replyCheckNormal(Object message) {
    return 'Your comment is visible while signed out, so it appears normal.\n\nYour comment: $message';
  }

  @override
  String replyCheckNotFound(Object message) {
    return 'Your comment couldn\'t be found.\n\nYour comment: $message';
  }

  @override
  String replyCheckShadowBanned(Object message) {
    return 'Your comment may be visible only to you.\n\nYour comment: $message';
  }

  @override
  String replyCheckInvisible(Object error, Object message) {
    return 'Comment isn\'t visible ($error): $message';
  }

  @override
  String replyCheckSuspicious(Object message, Object url) {
    return 'Your comment status looks unusual. It isn\'t visible while browsing the comment section signed out, but it can be retrieved directly at:\n$url\nThe comment section may be restricted, or this may be your own video.\n\nYour comment: $message';
  }

  @override
  String replyCheckInvisibleSimple(Object message) {
    return 'Comment isn\'t visible: $message';
  }

  @override
  String get replyContentText => 'Text';

  @override
  String get replyContentEmoji => 'Emoji';

  @override
  String get replyFilterChangeConfirm => 'Apply this comment filter change?';

  @override
  String get replyAddToFilter => 'Add to filter';

  @override
  String memberReportTitle(Object name) {
    return 'Report $name';
  }

  @override
  String get memberReportContentRequired =>
      'Report content (required; choose one or more)';

  @override
  String get memberReportReasonOptional => 'Reason (optional; choose one)';

  @override
  String get memberReportAvatar => 'Inappropriate avatar';

  @override
  String get memberReportNickname => 'Inappropriate name';

  @override
  String get memberReportBio => 'Inappropriate bio';

  @override
  String get memberReportChooseContent => 'Choose at least one item to report';

  @override
  String get reportFailed => 'Couldn\'t submit report';

  @override
  String get feedPinned => 'Post pinned';

  @override
  String get feedUnpinned => 'Post unpinned';

  @override
  String get updateCheckFailed =>
      'Couldn\'t check for updates. GitHub returned no data; check your connection';

  @override
  String get updateSelfCompiled =>
      'Self-compiled builds don\'t receive updates';

  @override
  String get updateAlreadyLatest => 'You\'re using the latest version';

  @override
  String get updateNewVersion => '🎉 New version available';

  @override
  String get updateViewFullChanges => 'View the full commit history';

  @override
  String get updateStopReminding => 'Don\'t remind me again';

  @override
  String get commonUnsupportedType =>
      'This content type isn\'t supported yet. Contact the developer';

  @override
  String get commonGettingResource => 'Getting resource…';

  @override
  String get commonResourceLoadFailed => 'Couldn\'t load resource';

  @override
  String routeUnknown(Object uri) {
    return 'Unknown link: $uri. Take a screenshot and report it to the developer';
  }

  @override
  String videoLoadFailed(Object error) {
    return 'Couldn\'t load video: $error';
  }

  @override
  String get liveTitle => 'Live';

  @override
  String get rankingTitle => 'Rankings';

  @override
  String get commonPlaylist => 'Playlist';

  @override
  String get videoParts => 'Parts';

  @override
  String get videoChargingOnly => 'Supporters only';

  @override
  String get videoTrailerBadge => 'Trailer';

  @override
  String get videoLimitedFreeBadge => 'Limited free';

  @override
  String get subscriptionSubscribe => 'Subscribe';

  @override
  String get subscriptionUnsubscribe => 'Unsubscribe';

  @override
  String get subscriptionSubscribed => 'Subscribed';

  @override
  String get commonJumpToTop => 'Jump to top';

  @override
  String get commonJumpToBottom => 'Jump to bottom';

  @override
  String get commonJumpToCurrent => 'Jump to current';

  @override
  String get commonAscendingOrder => 'Ascending';

  @override
  String get commonDescendingOrder => 'Descending';

  @override
  String get searchUserByUid => 'Find user by UID';

  @override
  String get searchTrending => 'Trending searches';

  @override
  String get searchDiscover => 'Discover';

  @override
  String get searchFullRanking => 'Full ranking';

  @override
  String get searchHistory => 'Search history';

  @override
  String get searchRecordHistory => 'Save searches';

  @override
  String get searchIncognito => 'Incognito search';

  @override
  String get searchImportExportHistory => 'Import or export search history';

  @override
  String get searchClearHistoryConfirm => 'Clear search history?';

  @override
  String searchTabCount(Object count, Object label) {
    return '$label $count';
  }

  @override
  String memberSearchHint(Object name) {
    return 'Search $name\'s posts and videos';
  }

  @override
  String get favoriteDeleteSelectedNotesConfirm => 'Delete the selected notes?';

  @override
  String get favoriteRemoveCourseConfirm =>
      'Remove this course from favorites?';

  @override
  String get downloadDeleteSelectedConfirm => 'Delete the selected videos?';

  @override
  String get downloadQueueTitle => 'Download queue';

  @override
  String get downloadViewDetails => 'View details';

  @override
  String get downloadOpenLocalFolder => 'Open local folder';

  @override
  String downloadVisitUploader(Object name) {
    return 'Visit $name';
  }

  @override
  String get downloadUserProfile => 'user profile';

  @override
  String get downloadWatched => 'Watched';

  @override
  String get downloadStatusDownloading => 'Downloading';

  @override
  String get downloadStatusAudioDownloading => 'Downloading audio';

  @override
  String get downloadStatusGettingDanmaku => 'Getting danmaku';

  @override
  String get downloadStatusGettingPlayUrl => 'Getting playback URL';

  @override
  String get downloadStatusCompleted => 'Downloaded';

  @override
  String get downloadStatusFailed => 'Download failed';

  @override
  String get downloadStatusAudioFailed => 'Audio download failed';

  @override
  String get downloadStatusDanmakuFailed => 'Couldn\'t get danmaku';

  @override
  String get downloadStatusPlayUrlFailed => 'Couldn\'t get playback URL';

  @override
  String get downloadStatusPaused => 'Paused';

  @override
  String get downloadStatusWaiting => 'Waiting';

  @override
  String get commonSettings => 'Settings';

  @override
  String get commonEmoji => 'Emoji';

  @override
  String get messagesRecall => 'Recall';

  @override
  String get messagesRecalled => 'Message recalled';

  @override
  String get messagesSent => 'Message sent';

  @override
  String get messagesInputHint => 'Send a message…';

  @override
  String get messagesUploadingImage => 'Uploading image…';

  @override
  String get messagesChatSettings => 'Chat settings';

  @override
  String get messagesAddToBlocked => 'Block user';

  @override
  String get messagesReceivePush => 'Receive content updates';

  @override
  String get messagesPushDescription =>
      'Turn this off to stop receiving this account\'s image, article, and upload updates. Notification messages aren\'t affected.';

  @override
  String get messagesPinChat => 'Pin chat';

  @override
  String get messagesMute => 'Mute notifications';

  @override
  String get messagesDisablePushConfirm => 'Turn off content updates?';

  @override
  String get messagesBlockConfirm => 'Block this user?';

  @override
  String get messagesBlockDescription =>
      'Blocking removes your follow relationship and collection subscriptions with this user, and prevents them from interacting with you or viewing your profile.';

  @override
  String get messagesBvNotFound => 'No BV number found';

  @override
  String get commonAdd => 'Add';

  @override
  String get messagesBlockedKeywords => 'Blocked message keywords';

  @override
  String get messagesTapKeywordToDelete => 'Tap a keyword to delete it';

  @override
  String get messagesDeleteKeywordConfirm => 'Delete this blocked keyword?';

  @override
  String get messagesKeywordNoLongerApplies =>
      'This keyword will no longer be blocked';

  @override
  String get messagesAddBlockedKeyword => 'Add blocked keyword';

  @override
  String get messagesNoBlockedKeywords => 'No blocked keywords';

  @override
  String get messagesBlockedKeywordDescription =>
      'Messages containing a blocked keyword won\'t be received';

  @override
  String get messagesEnterKeyword => 'Enter a keyword';

  @override
  String get messagesMarkAllRead => 'Mark all as read';

  @override
  String get messagesMarkAllReadConfirm =>
      'Clear all unread message indicators?';

  @override
  String get messagesClearList => 'Clear list';

  @override
  String get messagesClearListConfirm =>
      'All messages will be deleted and can\'t be recovered';

  @override
  String get messagesMenuSettings => 'Message settings';

  @override
  String get messagesUploaderAssistant => 'Uploader assistant';

  @override
  String get messagesContacts => 'Contacts';

  @override
  String get messagesFanGroupAssistant => 'Fan group assistant';

  @override
  String get feedSelectTopic => 'Choose topic';

  @override
  String get feedOptionalTitleHint => 'Title (optional, up to 20 characters)';

  @override
  String get feedEditPostTitle => 'Edit post';

  @override
  String get feedCreatePostTitle => 'Create post';

  @override
  String get feedScheduledPost => 'Schedule';

  @override
  String feedScheduleAtLeastMinutes(Object minutes) {
    return 'Choose a time at least $minutes minutes from now';
  }

  @override
  String get feedLiveReservation => 'Live reservation';

  @override
  String get feedStartedPoll => 'I started a poll';

  @override
  String get feedPosting => 'Posting…';

  @override
  String get feedPosted => 'Posted';

  @override
  String feedLiveReservationTitle(Object title) {
    return 'Live reservation: $title';
  }

  @override
  String feedLiveStartsAt(Object time) {
    return 'Live at $time';
  }

  @override
  String get feedAllowComments => 'Allow comments';

  @override
  String get feedCloseComments => 'Turn off comments';

  @override
  String get feedFeaturedComments => 'Featured comments';

  @override
  String get voteCreateTitle => 'Create poll';

  @override
  String get voteEditTitle => 'Poll';

  @override
  String get voteType => 'Poll type';

  @override
  String get voteTitle => 'Poll title';

  @override
  String get voteTitleHint => 'Enter a title';

  @override
  String get voteDescription => 'Description';

  @override
  String voteOptionLabel(Object number) {
    return 'Option $number';
  }

  @override
  String get voteOptionHint => 'Option text, up to 20 characters';

  @override
  String get voteAddOption => 'Add option';

  @override
  String get voteChoiceMode => 'Single or multiple choice';

  @override
  String get voteSingleChoice => 'Single choice';

  @override
  String voteMaxChoices(Object count) {
    return 'Choose up to $count';
  }

  @override
  String get voteEndTime => 'Poll end time';

  @override
  String get voteAtLeastFiveMinutes =>
      'Choose a time at least 5 minutes from now';

  @override
  String get voteCreate => 'Create poll';

  @override
  String get voteTextType => 'Text poll';

  @override
  String get voteImageType => 'Image poll';

  @override
  String get reserveAddLive => 'Add live reservation';

  @override
  String get reserveType => 'Type';

  @override
  String get reservePublicLive => 'Public live';

  @override
  String get reserveSupporterLive => 'Supporters-only live';

  @override
  String get reserveTime => 'Time';

  @override
  String get reserveTitle => 'Title';

  @override
  String get reserveTitleHint => 'Enter a title, up to 14 characters';

  @override
  String get reserveAdd => 'Add reservation';

  @override
  String get mentionInputHint => 'Enter someone to mention';

  @override
  String get topicSearchHint => 'Search topics';

  @override
  String get commonBlock => 'Block';

  @override
  String get commonShow => 'Show';

  @override
  String get commonHide => 'Hide';

  @override
  String get playerEnterFullscreen => 'Enter full screen';

  @override
  String get playerExitFullscreen => 'Exit full screen';

  @override
  String get playerTurnOffBackgroundPlayback => 'Turn off background playback';

  @override
  String get liveSendDanmaku => 'Send Danmaku';

  @override
  String get liveSwitchRoute => 'Switch route';

  @override
  String get liveShareRoom => 'Share live room';

  @override
  String livePlayerVolume(Object value) {
    return 'Player volume: $value%';
  }

  @override
  String get liveBackToBottom => 'Back to bottom';

  @override
  String get liveCopyDanmakuInfo => 'Copy Danmaku details';

  @override
  String get liveGoToUserProfile => 'View user profile';

  @override
  String get liveBlockSender => 'Block sender';

  @override
  String get liveBlocked => 'Sender blocked';

  @override
  String get liveLikeSucceeded => 'Liked';

  @override
  String get liveDanmakuInputHint => 'Enter Danmaku';

  @override
  String get audioNoOrder => 'No order';

  @override
  String audioPlaybackSpeed(Object speed) {
    return 'Playback speed ($speed×)';
  }

  @override
  String get audioPlaybackMode => 'Playback mode';

  @override
  String get videoTripleSucceeded => 'Liked, Coined, and added to favorites';

  @override
  String get danmakuBlockTitle => 'Danmaku blocking';

  @override
  String get danmakuBlockKeyword => 'Keyword';

  @override
  String get danmakuBlockRegex => 'Regular expression';

  @override
  String get danmakuBlockUser => 'User';

  @override
  String danmakuBlockTabCount(Object count, Object label) {
    return '$label ($count)';
  }

  @override
  String get danmakuDeleteRuleConfirm => 'Delete this rule?';

  @override
  String get danmakuKeywordHint =>
      'Enter a keyword. Switch tabs to add another rule type.';

  @override
  String get danmakuRegexHint =>
      'Enter the regular expression between // without the slashes.';

  @override
  String get danmakuUidHint => 'Enter a user UID';

  @override
  String danmakuRuleDialogTitle(Object action, Object type) {
    return '$action $type rule';
  }

  @override
  String get danmakuInputEmpty => 'Input can\'t be empty';

  @override
  String get danmakuInputUnchanged => 'Input is unchanged';

  @override
  String get danmakuSyncingRules => 'Syncing Danmaku block rules…';

  @override
  String get danmakuDeletingRule => 'Deleting Danmaku block rule…';

  @override
  String get danmakuAddingRule => 'Adding Danmaku block rule…';

  @override
  String get liveDanmakuGlobalBlock => 'Global blocking';

  @override
  String get liveDanmakuBlockEnabled => 'Blocking is on';

  @override
  String get liveDanmakuBlockDisabled => 'Blocking is off';

  @override
  String get liveDanmakuUserLevel => 'User level';

  @override
  String liveDanmakuBelowLevel(Object level) {
    return 'Below $level';
  }

  @override
  String get liveDanmakuUnofficialUser => 'Non-full members';

  @override
  String get liveDanmakuUnverifiedPhone => 'Users without verified phone';

  @override
  String get liveDanmakuKeywordBlock => 'Keyword blocking';

  @override
  String get commonInput => 'Keyboard';

  @override
  String get favoriteFolderSortTitle => 'Sort favorites';

  @override
  String get favoriteDefaultFolderSortUnsupported =>
      'The default favorites folder can\'t be reordered';

  @override
  String favoriteSortFolderTitle(String folder) {
    return 'Sort: $folder';
  }

  @override
  String get followSaveToDefaultGroup => 'Save to default group';

  @override
  String get commonVideo => 'Video';

  @override
  String get commonLongImage => 'Long image';

  @override
  String imagePositionSemantics(int position, int total) {
    return 'Image $position of $total';
  }

  @override
  String get downloadVideoCachedNotification => 'Video downloaded';

  @override
  String get topicJoin => 'Join topic';

  @override
  String get topicStarted => 'Started this topic';

  @override
  String topicStats(String views, String discussions) {
    return '$views views · $discussions discussions';
  }

  @override
  String get replyPinned => 'Comment pinned';

  @override
  String get replyUnpinned => 'Comment unpinned';

  @override
  String get webRefresh => 'Refresh';

  @override
  String get webCopyLink => 'Copy link';

  @override
  String get webOpenInBrowser => 'Open in browser';

  @override
  String get webClearCache => 'Clear cache';

  @override
  String get webResetCookie => 'Reset cookies';

  @override
  String get webGoBack => 'Back';

  @override
  String get webCacheCleared => 'Cache cleared';

  @override
  String get webCookieResetSucceeded =>
      'Cookies reset. Refresh or reopen the page.';

  @override
  String webDownloadFileConfirm(String filename) {
    return 'Download $filename?';
  }

  @override
  String webConfirmWithFileSize(String size) {
    return 'Confirm ($size)';
  }

  @override
  String get webExternalLinkConfirm =>
      'This page wants to open an external link.';

  @override
  String get webOpen => 'Open';

  @override
  String get commonUnliked => 'Like removed';

  @override
  String get articleShareTitle => 'Bilibili article';

  @override
  String articleCount(String count) {
    return '$count articles';
  }

  @override
  String articleWordCount(String count) {
    return '$count words';
  }

  @override
  String articleReadCount(String count) {
    return '$count reads';
  }

  @override
  String articleUpdatedAt(String date) {
    return 'Updated $date';
  }

  @override
  String articleCollectionId(int id) {
    return 'Collection ID: $id';
  }

  @override
  String followUserFollowers(String name) {
    return '$name\'s followers';
  }

  @override
  String followRemoveFollowerConfirm(String name) {
    return 'Remove $name from your followers?';
  }

  @override
  String get followFollowerRemoved => 'Follower removed';

  @override
  String get matchDetails => 'Match details';

  @override
  String get matchWatchLive => 'Watch live';

  @override
  String matchEndedAt(String date) {
    return '$date · Ended';
  }

  @override
  String get castNoDevices => 'No casting devices found';

  @override
  String get liveSearchHint => 'Search rooms or Uploaders';

  @override
  String get liveContributionRankOnline => 'Online rank';

  @override
  String get liveContributionRankDaily => 'Daily rank';

  @override
  String get liveContributionRankWeekly => 'Weekly rank';

  @override
  String get liveContributionRankMonthly => 'Monthly rank';

  @override
  String liveSearchRooms(String count) {
    return 'Live $count';
  }

  @override
  String liveSearchUploaders(String count) {
    return 'Uploaders $count';
  }

  @override
  String get liveAllTags => 'All tags';

  @override
  String get liveFavoriteTags => 'My favorite tags';

  @override
  String get liveTapTagHint => 'Tap a tag to open it';

  @override
  String get favoriteWantToWatch => 'Want to watch';

  @override
  String get favoriteWatching => 'Watching';

  @override
  String get favoriteWatched => 'Watched';

  @override
  String get favoriteUnpublishedNotes => 'Unpublished notes';

  @override
  String get favoritePublicNotes => 'Public notes';

  @override
  String get memberOrderMostPlayed => 'Most played';

  @override
  String get memberOrderMostFavorited => 'Most favorited';

  @override
  String get memberReverseOrder => 'Reverse';

  @override
  String get memberJumpToPage => 'Go to page';

  @override
  String get memberPageNumber => 'Page';

  @override
  String get memberLocateLastWatched => 'Go to last watched';

  @override
  String audioTrackCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count tracks',
      one: '1 track',
    );
    return '$_temp0';
  }

  @override
  String get memberMyRecentCoinedVideos => 'My recently supported videos';

  @override
  String memberUserRecentCoinedVideos(String name) {
    return '$name\'s recently supported videos';
  }

  @override
  String get memberFanMedalWall => 'Fan medal wall';

  @override
  String memberFanMedalCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count fan medals',
      one: '1 fan medal',
    );
    return '$_temp0';
  }

  @override
  String get memberMedalWearing => 'Wearing';

  @override
  String favoriteAddedAt(String date) {
    return 'Saved $date';
  }

  @override
  String get memberLastWatched => 'Last watched';

  @override
  String get reviewLong => 'Long reviews';

  @override
  String get reviewShort => 'Short reviews';

  @override
  String get reviewWriteLong => 'Write a long review';

  @override
  String get reviewWriteShort => 'Write a short review';

  @override
  String get reviewLatest => 'Latest';

  @override
  String get reviewRatingAwful => 'Awful';

  @override
  String get reviewRatingPoor => 'Poor';

  @override
  String get reviewRatingOkay => 'Okay';

  @override
  String get reviewRatingGreat => 'Great';

  @override
  String get reviewRatingExcellent => 'Excellent';

  @override
  String get reviewTapToRate => 'Tap to rate';

  @override
  String get reviewEdited => 'Review updated';

  @override
  String get reviewPublished => 'Review published';

  @override
  String get reviewDeleteConfirm => 'Delete this short review and its rating?';

  @override
  String reviewCount(String count) {
    return '$count reviews';
  }

  @override
  String get searchFilter => 'Filter';

  @override
  String searchFilteredBy(String filter) {
    return 'Filtered by “$filter”';
  }

  @override
  String searchSortValue(String value) {
    return 'Sort: $value';
  }

  @override
  String searchZoneValue(String value) {
    return 'Category: $value';
  }

  @override
  String searchUserTypeValue(String value) {
    return 'User type: $value';
  }

  @override
  String get searchZone => 'Category';

  @override
  String get searchUserSort => 'Followers and level order';

  @override
  String get searchUserType => 'User type';

  @override
  String get searchPublishedTime => 'Published';

  @override
  String get searchDateTo => 'to';

  @override
  String get searchContentDuration => 'Duration';

  @override
  String get searchContentZone => 'Category';

  @override
  String get searchOrderRelevance => 'Relevance';

  @override
  String get searchOrderNewest => 'Newest';

  @override
  String get searchOrderMostClicked => 'Most viewed';

  @override
  String get searchOrderMostLiked => 'Most liked';

  @override
  String get searchOrderMostCommented => 'Most commented';

  @override
  String get searchOrderDefault => 'Default';

  @override
  String get searchOrderMostPlayed => 'Most played';

  @override
  String get searchOrderMostDanmaku => 'Most Danmaku';

  @override
  String get searchOrderMostFavorited => 'Most favorited';

  @override
  String get searchFollowersHighToLow => 'Most followers';

  @override
  String get searchFollowersLowToHigh => 'Fewest followers';

  @override
  String get searchLevelHighToLow => 'Highest level';

  @override
  String get searchLevelLowToHigh => 'Lowest level';

  @override
  String get searchAllUsers => 'All users';

  @override
  String get searchUploaders => 'Uploaders';

  @override
  String get searchRegularUsers => 'Regular users';

  @override
  String get searchVerifiedUsers => 'Verified users';

  @override
  String get searchAnyTime => 'Any time';

  @override
  String get searchLastDay => 'Past day';

  @override
  String get searchLastWeek => 'Past week';

  @override
  String get searchLastSixMonths => 'Past six months';

  @override
  String get searchAllDurations => 'Any duration';

  @override
  String get searchDurationUnderTen => 'Under 10 minutes';

  @override
  String get searchDurationTenToThirty => '10–30 minutes';

  @override
  String get searchDurationThirtyToSixty => '30–60 minutes';

  @override
  String get searchDurationOverSixty => 'Over 60 minutes';

  @override
  String get searchAllZones => 'All categories';

  @override
  String get searchZoneAnimation => 'Animation';

  @override
  String get searchZoneAnime => 'Anime';

  @override
  String get searchZoneChineseAnimation => 'Chinese animation';

  @override
  String get searchZoneMusic => 'Music';

  @override
  String get searchZoneDance => 'Dance';

  @override
  String get searchZoneGames => 'Gaming';

  @override
  String get searchZoneKnowledge => 'Knowledge';

  @override
  String get searchZoneTechnology => 'Technology';

  @override
  String get searchZoneSports => 'Sports';

  @override
  String get searchZoneCars => 'Cars';

  @override
  String get searchZoneLife => 'Lifestyle';

  @override
  String get searchZoneFood => 'Food';

  @override
  String get searchZoneAnimals => 'Animals';

  @override
  String get searchZoneKichiku => 'Kichiku';

  @override
  String get searchZoneFashion => 'Fashion';

  @override
  String get searchZoneNews => 'News';

  @override
  String get searchZoneEntertainment => 'Entertainment';

  @override
  String get searchZoneFilmTv => 'Film & TV';

  @override
  String get searchZoneDocumentary => 'Documentary';

  @override
  String get searchZoneMovies => 'Movies';

  @override
  String get searchZoneTv => 'TV';

  @override
  String get searchZoneInterests => 'Interests';

  @override
  String get searchZoneLightNovels => 'Light novels';

  @override
  String get searchZoneNotes => 'Notes';

  @override
  String get commonAlbum => 'Album';

  @override
  String get commonArticle => 'Article';

  @override
  String get messagesAutoReply => 'This is an automated reply';

  @override
  String messagesLiveBy(String author) {
    return '$author · Live';
  }

  @override
  String get liveNow => 'LIVE';

  @override
  String memberFollowerCount(String count) {
    return '$count followers';
  }

  @override
  String get commonViewMore => 'View more';

  @override
  String get commonExit => 'Exit';

  @override
  String get audioWatchMv => 'Watch MV';

  @override
  String liveHighEnergyAudience(String count) {
    return 'Top viewers ($count)';
  }

  @override
  String get liveJustStarted => 'Just started';

  @override
  String liveStartedFor(String duration) {
    return 'Live for $duration';
  }

  @override
  String get livePlaybackUrlUnavailable => 'Couldn\'t get the playback URL';

  @override
  String liveVisitUser(String name) {
    return 'View $name';
  }

  @override
  String get liveCopySuperChatInfo => 'Copy Super Chat info';

  @override
  String get commonExpand => 'Expand';

  @override
  String get commonCollapse => 'Collapse';

  @override
  String get feedTopics => 'Topics';

  @override
  String get commonTime => 'Time';

  @override
  String get commonReason => 'Reason';

  @override
  String get logChange => 'Change';

  @override
  String get logLocation => 'Location';

  @override
  String get logExperienceHistory => 'Experience history';

  @override
  String get logLoginHistory => 'Sign-in history';

  @override
  String get saveWatch => 'watch';

  @override
  String get saveContent => 'content';

  @override
  String get saveCollection => 'collection';

  @override
  String saveScanQrToOpen(String action, String item) {
    return 'Scan the QR code to $action this $item';
  }

  @override
  String musicReleaseDate(String date) {
    return 'Released: $date';
  }

  @override
  String musicOriginalArtist(String artist) {
    return 'Original artist: $artist';
  }

  @override
  String musicAlbum(String album) {
    return 'Album: $album';
  }

  @override
  String musicSource(String source) {
    return 'Source: $source';
  }

  @override
  String get musicHotSongRanking => 'Hot song ranking';

  @override
  String get musicPopularity => 'Popularity';

  @override
  String get musicTotalPlays => 'Total plays';

  @override
  String get musicVideosUsingTrack => 'Videos using this track';

  @override
  String musicRecentPopularityTrend(int days) {
    return 'Popularity over the past $days days';
  }

  @override
  String articleAuthorReads(String author, int count) {
    return '$author · $count reads';
  }

  @override
  String articlePriceFrom(String price) {
    return 'From $price';
  }

  @override
  String get articleFeedOrArticle => 'Post / article';

  @override
  String articleUnsupportedType(String type) {
    return 'Unsupported type ($type)';
  }

  @override
  String articleInvalidType(String error) {
    return 'Invalid type: $error';
  }

  @override
  String memberShopFrom(String source) {
    return 'From $source';
  }

  @override
  String get loginMainAccountSucceeded => 'Main account signed in';

  @override
  String loginCookieFailed(String error) {
    return 'Sign-in failed. Check your cookies. $error';
  }

  @override
  String get memberAllCollectionsAndLists => 'All collections / lists';

  @override
  String get memberAllPosts => 'All posts';

  @override
  String get memberPosts => 'Posts';

  @override
  String memberSupportRanking(String name, String count) {
    return '$name\'s supporter ranking $count';
  }

  @override
  String get memberSupport => 'Support';

  @override
  String get memberSupportDaysSuffix => ' days';

  @override
  String liveSearchUserStats(String area, String followers) {
    return 'Category: $area · $followers followers';
  }

  @override
  String bubbleSiteTitle(String name) {
    return '$name community';
  }

  @override
  String liveSwitchPreviewTo(String target) {
    return 'Switch to $target';
  }

  @override
  String get liveCover => 'cover';

  @override
  String get liveFirstFrame => 'first frame';

  @override
  String get liveShowMenu => 'Show menu';

  @override
  String get liveReportSelectedDanmaku => 'Report selected Danmaku';

  @override
  String get mediaTvSeries => 'TV series';

  @override
  String get mediaComics => 'Comics';

  @override
  String get mediaVarietyShows => 'Variety shows';

  @override
  String memberUserLevelSemantics(int level) {
    return 'Level $level';
  }

  @override
  String get avatarVipBadge => 'Premium member';

  @override
  String get avatarVerifiedIndividual => 'Verified individual';

  @override
  String get avatarVerifiedOrganization => 'Verified organization';

  @override
  String memberHardcoreUserLevelSemantics(int level) {
    return 'Hardcore Level $level';
  }

  @override
  String get playerProgressBar => 'Progress bar';

  @override
  String get commonPlay => 'Play';

  @override
  String get settingsSpeedTestTimeout => 'Speed test timed out';

  @override
  String get commonSave => 'Save';

  @override
  String get videoShareAsTicket => 'Share as ticket';

  @override
  String get shareTicketTitle => 'Share ticket';

  @override
  String get shareTicketPostscript => 'Postscript';

  @override
  String get shareTicketPostscriptHint => 'Write a recommendation';

  @override
  String get shareTicketSave => 'Save image';

  @override
  String get shareTicketShare => 'System share';

  @override
  String get shareTicketLoadFailed =>
      'Required share ticket resources failed to load. Please retry';

  @override
  String get shareTicketRetry => 'Retry';

  @override
  String get shareTicketPublishedAt => 'Published';

  @override
  String get shareTicketPlays => 'Plays';

  @override
  String get shareTicketDanmaku => 'Danmaku';

  @override
  String get shareTicketLikes => 'Likes';

  @override
  String get shareTicketSharer => 'Shared by';

  @override
  String get shareTicketFrom => 'Shared from ExPiliPlus';
}
