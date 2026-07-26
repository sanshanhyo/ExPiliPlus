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

  @override
  String get settingsOpenOnboarding => 'Open welcome guide again';

  @override
  String get settingsOpenOnboardingDescription =>
      'Review language, theme, and data migration without clearing your current settings';

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
  String replyReplyPrefix(String name, String message) {
    return 'Reply to @$name: $message';
  }

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
}
