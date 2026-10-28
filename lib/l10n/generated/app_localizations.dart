Warning: truncated output (original token count: 100281)
Total output lines: 13637

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('zh'),
    Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hant'),
  ];

  /// No description provided for @commonCancel.
  ///
  /// In zh, this message translates to:
  /// **'取消'**
  String get commonCancel;

  /// No description provided for @commonConfirm.
  ///
  /// In zh, this message translates to:
  /// **'确定'**
  String get commonConfirm;

  /// No description provided for @settingsTitle.
  ///
  /// In zh, this message translates to:
  /// **'设置'**
  String get settingsTitle;

  /// No description provided for @settingsSearch.
  ///
  /// In zh, this message translates to:
  /// **'搜索'**
  String get settingsSearch;

  /// No description provided for @settingsPrivacyTitle.
  ///
  /// In zh, this message translates to:
  /// **'隐私设置'**
  String get settingsPrivacyTitle;

  /// No description provided for @settingsPrivacySummary.
  ///
  /// In zh, this message translates to:
  /// **'黑名单'**
  String get settingsPrivacySummary;

  /// No description provided for @settingsRecommendationFeedTitle.
  ///
  /// In zh, this message translates to:
  /// **'推荐流设置'**
  String get settingsRecommendationFeedTitle;

  /// No description provided for @settingsRecommendationFeedSummary.
  ///
  /// In zh, this message translates to:
  /// **'推荐来源（Web/App）、刷新保留内容、过滤器'**
  String get settingsRecommendationFeedSummary;

  /// No description provided for @settingsAudioVideoTitle.
  ///
  /// In zh, this message translates to:
  /// **'音视频设置'**
  String get settingsAudioVideoTitle;

  /// No description provided for @settingsAudioVideoSummary.
  ///
  /// In zh, this message translates to:
  /// **'画质、音质、解码、缓冲、音频输出等'**
  String get settingsAudioVideoSummary;

  /// No description provided for @settingsPlayerTitle.
  ///
  /// In zh, this message translates to:
  /// **'播放器设置'**
  String get settingsPlayerTitle;

  /// No description provided for @settingsPlayerSummary.
  ///
  /// In zh, this message translates to:
  /// **'双击/长按、全屏、后台播放、弹幕、字幕、底部进度条等'**
  String get settingsPlayerSummary;

  /// No description provided for @settingsAppearanceTitle.
  ///
  /// In zh, this message translates to:
  /// **'外观设置'**
  String get settingsAppearanceTitle;

  /// No description provided for @settingsAppearanceSummary.
  ///
  /// In zh, this message translates to:
  /// **'横屏适配、侧边栏、首页、动态、主题、字体和图片等'**
  String get settingsAppearanceSummary;

  /// No description provided for @settingsGeneralTitle.
  ///
  /// In zh, this message translates to:
  /// **'其它设置'**
  String get settingsGeneralTitle;

  /// No description provided for @settingsGeneralSummary.
  ///
  /// In zh, this message translates to:
  /// **'震动、搜索、收藏、AI、评论、动态、代理和更新等'**
  String get settingsGeneralSummary;

  /// No description provided for @settingsExPiliPlusTitle.
  ///
  /// In zh, this message translates to:
  /// **'ExPiliPlus 设置'**
  String get settingsExPiliPlusTitle;

  /// No description provided for @settingsExPiliPlusSummary.
  ///
  /// In zh, this message translates to:
  /// **'语言、自定义主题色、字体、随机播放和自动点赞等'**
  String get settingsExPiliPlusSummary;

  /// No description provided for @settingsWebDavTitle.
  ///
  /// In zh, this message translates to:
  /// **'WebDAV 设置'**
  String get settingsWebDavTitle;

  /// No description provided for @settingsAboutTitle.
  ///
  /// In zh, this message translates to:
  /// **'关于'**
  String get settingsAboutTitle;

  /// No description provided for @settingsSwitchAccount.
  ///
  /// In zh, this message translates to:
  /// **'切换账号'**
  String get settingsSwitchAccount;

  /// No description provided for @settingsSignOut.
  ///
  /// In zh, this message translates to:
  /// **'退出登录'**
  String get settingsSignOut;

  /// No description provided for @settingsAppLanguage.
  ///
  /// In zh, this message translates to:
  /// **'应用语言'**
  String get settingsAppLanguage;

  /// No description provided for @settingsCurrentLanguage.
  ///
  /// In zh, this message translates to:
  /// **'当前：{language}'**
  String settingsCurrentLanguage(String language);

  /// No description provided for @languagePickerTitle.
  ///
  /// In zh, this message translates to:
  /// **'应用语言'**
  String get languagePickerTitle;

  /// No description provided for @languageSystemDefault.
  ///
  /// In zh, this message translates to:
  /// **'跟随系统'**
  String get languageSystemDefault;

  /// No description provided for @languageSimplifiedChinese.
  ///
  /// In zh, this message translates to:
  /// **'简体中文'**
  String get languageSimplifiedChinese;

  /// No description provided for @languageTraditionalChinese.
  ///
  /// In zh, this message translates to:
  /// **'繁體中文'**
  String get languageTraditionalChinese;

  /// No description provided for @languageEnglish.
  ///
  /// In zh, this message translates to:
  /// **'英语'**
  String get languageEnglish;

  /// No description provided for @settingsCustomThemeColor.
  ///
  /// In zh, this message translates to:
  /// **'自定义主题色'**
  String get settingsCustomThemeColor;

  /// No description provided for @settingsCustomThemeColorDisabled.
  ///
  /// In zh, this message translates to:
  /// **'未启用，使用动态取色或 PiliPlus 预设色'**
  String get settingsCustomThemeColorDisabled;

  /// No description provided for @settingsCustomThemeColorSavedOverridden.
  ///
  /// In zh, this message translates to:
  /// **'已保存 {color}，当前由动态取色覆盖'**
  String settingsCustomThemeColorSavedOverridden(String color);

  /// No description provided for @settingsCurrentValue.
  ///
  /// In zh, this message translates to:
  /// **'当前：{value}'**
  String settingsCurrentValue(String value);

  /// No description provided for @settingsAppFont.
  ///
  /// In zh, this message translates to:
  /// **'应用字体'**
  String get settingsAppFont;

  /// No description provided for @settingsSystemDefaultFont.
  ///
  /// In zh, this message translates to:
  /// **'系统默认'**
  String get settingsSystemDefaultFont;

  /// No description provided for @settingsAppFontWeight.
  ///
  /// In zh, this message translates to:
  /// **'应用字体字重'**
  String get settingsAppFontWeight;

  /// No description provided for @settingsTapToConfigure.
  ///
  /// In zh, this message translates to:
  /// **'点击设置'**
  String get settingsTapToConfigure;

  /// No description provided for @settingsUploaderProfileShuffle.
  ///
  /// In zh, this message translates to:
  /// **'UP 主页显示随机播放按钮'**
  String get settingsUploaderProfileShuffle;

  /// No description provided for @settingsAutoLikeOpenedVideos.
  ///
  /// In zh, this message translates to:
  /// **'自动点赞点开的视频'**
  String get settingsAutoLikeOpenedVideos;

  /// No description provided for @settingsAutoLikeOpenedVideosDescription.
  ///
  /// In zh, this message translates to:
  /// **'进入视频详情后自动点赞一次，已点赞的视频会跳过'**
  String get settingsAutoLikeOpenedVideosDescription;

  /// No description provided for @settingsEnableGifRecord.
  ///
  /// In zh, this message translates to:
  /// **'启用 GIF 截取按钮'**
  String get settingsEnableGifRecord;

  /// No description provided for @settingsPiliPlusThemeRestored.
  ///
  /// In zh, this message translates to:
  /// **'已恢复 PiliPlus 主题色'**
  String get settingsPiliPlusThemeRestored;

  /// No description provided for @settingsThemeColorSet.
  ///
  /// In zh, this message translates to:
  /// **'主题色已设为 {color}'**
  String settingsThemeColorSet(String color);

  /// No description provided for @settingsLoadingFont.
  ///
  /// In zh, this message translates to:
  /// **'正在加载字体'**
  String get settingsLoadingFont;

  /// No description provided for @commonSearch.
  ///
  /// In zh, this message translates to:
  /// **'搜索'**
  String get commonSearch;

  /// No description provided for @commonImport.
  ///
  /// In zh, this message translates to:
  /// **'导入'**
  String get commonImport;

  /// No description provided for @commonContinue.
  ///
  /// In zh, this message translates to:
  /// **'继续'**
  String get commonContinue;

  /// No description provided for @commonPrevious.
  ///
  /// In zh, this message translates to:
  /// **'上一步'**
  String get commonPrevious;

  /// No description provided for @commonNext.
  ///
  /// In zh, this message translates to:
  /// **'下一步'**
  String get commonNext;

  /// No description provided for @commonDefault.
  ///
  /// In zh, this message translates to:
  /// **'默认'**
  String get commonDefault;

  /// No description provided for @commonRefresh.
  ///
  /// In zh, this message translates to:
  /// **'刷新'**
  String get commonRefresh;

  /// No description provided for @commonSeeMore.
  ///
  /// In zh, this message translates to:
  /// **'查看更多'**
  String get commonSeeMore;

  /// No description provided for @commonListSeparator.
  ///
  /// In zh, this message translates to:
  /// **'、'**
  String get commonListSeparator;

  /// No description provided for @commonItemCount.
  ///
  /// In zh, this message translates to:
  /// **'{count, plural, =0{0 个} =1{1 个} other{{count} 个}}'**
  String commonItemCount(int count);

  /// No description provided for @navigationHome.
  ///
  /// In zh, this message translates to:
  /// **'首页'**
  String get navigationHome;

  /// No description provided for @navigationFeed.
  ///
  /// In zh, this message translates to:
  /// **'动态'**
  String get navigationFeed;

  /// No description provided for @navigationMe.
  ///
  /// In zh, this message translates to:
  /// **'我的'**
  String get navigationMe;

  /// No description provided for @navigationLive.
  ///
  /// In zh, this message translates to:
  /// **'直播'**
  String get navigationLive;

  /// No description provided for @navigationRecommended.
  ///
  /// In zh, this message translates to:
  /// **'推荐'**
  String get navigationRecommended;

  /// No description provided for @navigationTrending.
  ///
  /// In zh, this message translates to:
  /// **'热门'**
  String get navigationTrending;

  /// No description provided for @navigationCategories.
  ///
  /// In zh, this message translates to:
  /// **'分区'**
  String get navigationCategories;

  /// No description provided for @navigationAnime.
  ///
  /// In zh, this message translates to:
  /// **'番剧'**
  String get navigationAnime;

  /// No description provided for @navigationMoviesAndTv.
  ///
  /// In zh, this message translates to:
  /// **'影视'**
  String get navigationMoviesAndTv;

  /// No description provided for @navigationMessages.
  ///
  /// In zh, this message translates to:
  /// **'消息'**
  String get navigationMessages;

  /// No description provided for @desktopShowWindow.
  ///
  /// In zh, this message translates to:
  /// **'显示窗口'**
  String get desktopShowWindow;

  /// No description provided for @desktopExitApp.
  ///
  /// In zh, this message translates to:
  /// **'退出 {appName}'**
  String desktopExitApp(String appName);

  /// No description provided for @themeLight.
  ///
  /// In zh, this message translates to:
  /// **'浅色'**
  String get themeLight;

  /// No description provided for @themeDark.
  ///
  /// In zh, this message translates to:
  /// **'深色'**
  String get themeDark;

  /// No description provided for @themeSystem.
  ///
  /// In zh, this message translates to:
  /// **'跟随系统'**
  String get themeSystem;

  /// No description provided for @accountTapToSignIn.
  ///
  /// In zh, this message translates to:
  /// **'点击登录'**
  String get accountTapToSignIn;

  /// No description provided for @accountPleaseSignIn.
  ///
  /// In zh, this message translates to:
  /// **'请先登录'**
  String get accountPleaseSignIn;

  /// No description provided for @accessibilityPremium.
  ///
  /// In zh, this message translates to:
  /// **'大会员'**
  String get accessibilityPremium;

  /// No description provided for @accessibilityDefaultAvatar.
  ///
  /// In zh, this message translates to:
  /// **'默认头像'**
  String get accessibilityDefaultAvatar;

  /// No description provided for @mineDownloads.
  ///
  /// In zh, this message translates to:
  /// **'离线缓存'**
  String get mineDownloads;

  /// No description provided for @mineWatchHistory.
  ///
  /// In zh, this message translates to:
  /// **'观看记录'**
  String get mineWatchHistory;

  /// No description provided for @mineSubscriptions.
  ///
  /// In zh, this message translates to:
  /// **'我的订阅'**
  String get mineSubscriptions;

  /// No description provided for @mineWatchLater.
  ///
  /// In zh, this message translates to:
  /// **'稍后再看'**
  String get mineWatchLater;

  /// No description provided for @mineCommentHistory.
  ///
  /// In zh, this message translates to:
  /// **'评论记录'**
  String get mineCommentHistory;

  /// No description provided for @mineEnterIncognito.
  ///
  /// In zh, this message translates to:
  /// **'进入无痕模式'**
  String get mineEnterIncognito;

  /// No description provided for @mineExitIncognito.
  ///
  /// In zh, this message translates to:
  /// **'退出无痕模式'**
  String get mineExitIncognito;

  /// No description provided for @mineSwitchTheme.
  ///
  /// In zh, this message translates to:
  /// **'切换至{theme}主题'**
  String mineSwitchTheme(String theme);

  /// No description provided for @mineIncognitoEntered.
  ///
  /// In zh, this message translates to:
  /// **'已进入无痕模式'**
  String get mineIncognitoEntered;

  /// No description provided for @mineIncognitoDescription.
  ///
  /// In zh, this message translates to:
  /// **'搜索不携带身份信息\n不产生查询或播放记录\n点赞等其它操作不受影响\n播放进度信息跟随视频取流\n（前往隐私设置了解详情）'**
  String get mineIncognitoDescription;

  /// No description provided for @mineIncognitoPermanentSet.
  ///
  /// In zh, this message translates to:
  /// **'已设为永久无痕模式'**
  String get mineIncognitoPermanentSet;

  /// No description provided for @mineIncognitoSavePermanently.
  ///
  /// In zh, this message translates to:
  /// **'保存为永久'**
  String get mineIncognitoSavePermanently;

  /// No description provided for @mineIncognitoTemporarySet.
  ///
  /// In zh, this message translates to:
  /// **'已设为临时无痕模式'**
  String get mineIncognitoTemporarySet;

  /// No description provided for @mineIncognitoThisSession.
  ///
  /// In zh, this message translates to:
  /// **'仅本次（默认）'**
  String get mineIncognitoThisSession;

  /// No description provided for @mineIncognitoExited.
  ///
  /// In zh, this message translates to:
  /// **'已退出无痕模式'**
  String get mineIncognitoExited;

  /// No description provided for @mineCoins.
  ///
  /// In zh, this message translates to:
  /// **'硬币'**
  String get mineCoins;

  /// No description provided for @mineXp.
  ///
  /// In zh, this message translates to:
  /// **'经验'**
  String get mineXp;

  /// No description provided for @minePosts.
  ///
  /// In zh, this message translates to:
  /// **'动态'**
  String get minePosts;

  /// No description provided for @mineFollowing.
  ///
  /// In zh, this message translates to:
  /// **'关注'**
  String get mineFollowing;

  /// No description provided for @mineFollowers.
  ///
  /// In zh, this message translates to:
  /// **'粉丝'**
  String get mineFollowers;

  /// No description provided for @mineFavorites.
  ///
  /// In zh, this message translates to:
  /// **'我的收藏'**
  String get mineFavorites;

  /// No description provided for @favoritePublic.
  ///
  /// In zh, this message translates to:
  /// **'公开'**
  String get favoritePublic;

  /// No description provided for @favoritePrivate.
  ///
  /// In zh, this message translates to:
  /// **'私密'**
  String get favoritePrivate;

  /// No description provided for @favoriteFolderSummary.
  ///
  /// In zh, this message translates to:
  /// **'{count, plural, =0{共 0 条视频 · {visibility}} =1{共 1 条视频 · {visibility}} other{共 {count} 条视频 · {visibility}}}'**
  String favoriteFolderSummary(int count, String visibility);

  /// No description provided for @onboardingStepWelcome.
  ///
  /// In zh, this message translates to:
  /// **'欢迎'**
  String get onboardingStepWelcome;

  /// No description provided for @onboardingStepImport.
  ///
  /// In zh, this message translates to:
  /// **'导入'**
  String get onboardingStepImport;

  /// No description provided for @onboardingStepAppearance.
  ///
  /// In zh, this message translates to:
  /// **'外观'**
  String get onboardingStepAppearance;

  /// No description provided for @onboardingStepAccount.
  ///
  /// In zh, this message translates to:
  /// **'账户'**
  String get onboardingStepAccount;

  /// No description provided for @onboardingStepFinish.
  ///
  /// In zh, this message translates to:
  /// **'完成'**
  String get onboardingStepFinish;

  /// No description provided for @onboardingWelcomeTitle.
  ///
  /// In zh, this message translates to:
  /// **'欢迎使用 ExPiliPlus'**
  String get onboardingWelcomeTitle;

  /// No description provided for @onboardingWelcomeSubtitle.
  ///
  /// In zh, this message translates to:
  /// **'基于 PiliPlus 二次开发，探索更多个性化与实验性功能(｡･∀･)ﾉﾞ'**
  String get onboardingWelcomeSubtitle;

  /// No description provided for @onboardingWelcomeMigrateSettings.
  ///
  /// In zh, this message translates to:
  /// **'迁移既有设置'**
  String get onboardingWelcomeMigrateSettings;

  /// No description provided for @onboardingWelcomeAppearance.
  ///
  /// In zh, this message translates to:
  /// **'整理外观偏好'**
  String get onboardingWelcomeAppearance;

  /// No description provided for @onboardingWelcomeAccount.
  ///
  /// In zh, this message translates to:
  /// **'登录或导入本地账号备份'**
  String get onboardingWelcomeAccount;

  /// No description provided for @onboardingImportTitle.
  ///
  /// In zh, this message translates to:
  /// **'导入'**
  String get onboardingImportTitle;

  /// No description provided for @onboardingImportSubtitle.
  ///
  /// In zh, this message translates to:
  /// **'从 PiliPlus / ExPiliPlus 的本地文件或 WebDAV 备份迁移设置，也可以全新开始。'**
  String get onboardingImportSubtitle;

  /// No description provided for @onboardingImportLocal.
  ///
  /// In zh, this message translates to:
  /// **'从本地文件导入'**
  String get onboardingImportLocal;

  /// No description provided for @onboardingImportLocalDescription.
  ///
  /// In zh, this message translates to:
  /// **'选择导出的设置 JSON 文件'**
  String get onboardingImportLocalDescription;

  /// No description provided for @onboardingImportHelp.
  ///
  /// In zh, this message translates to:
  /// **'查看导出方法'**
  String get onboardingImportHelp;

  /// No description provided for @onboardingImportHelpTitle.
  ///
  /// In zh, this message translates to:
  /// **'如何从 PiliPlus 导出文件'**
  String get onboardingImportHelpTitle;

  /// No description provided for @onboardingImportHelpIntro.
  ///
  /// In zh, this message translates to:
  /// **'在 PiliPlus 中，按要迁移的内容打开对应入口：'**
  String get onboardingImportHelpIntro;

  /// No description provided for @onboardingImportHelpSettingsPath.
  ///
  /// In zh, this message translates to:
  /// **'我的 > 设置 > 关于 > 导入/导出设置'**
  String get onboardingImportHelpSettingsPath;

  /// No description provided for @onboardingImportHelpLoginPath.
  ///
  /// In zh, this message translates to:
  /// **'我的 > 设置 > 关于 > 导入/导出登录信息'**
  String get onboardingImportHelpLoginPath;

  /// No description provided for @onboardingImportHelpExportHint.
  ///
  /// In zh, this message translates to:
  /// **'进入对应页面后，选择“导出文件至本地”。导出完成后返回 ExPiliPlus，选择生成的 JSON 文件。'**
  String get onboardingImportHelpExportHint;

  /// No description provided for @onboardingImportWebDav.
  ///
  /// In zh, this message translates to:
  /// **'从 WebDAV 导入'**
  String get onboardingImportWebDav;

  /// No description provided for @onboardingImportWebDavDescription.
  ///
  /// In zh, this message translates to:
  /// **'使用 WebDAV 备份中的设置文件'**
  String get onboardingImportWebDavDescription;

  /// No description provided for @onboardingStartFresh.
  ///
  /// In zh, this message translates to:
  /// **'全新开始'**
  String get onboardingStartFresh;

  /// No description provided for @onboardingStartFreshDescription.
  ///
  /// In zh, this message translates to:
  /// **'保留默认设置继续'**
  String get onboardingStartFreshDescription;

  /// No description provided for @onboardingAppearanceTitle.
  ///
  /// In zh, this message translates to:
  /// **'外观'**
  String get onboardingAppearanceTitle;

  /// No description provided for @onboardingAppearanceDescription.
  ///
  /// In zh, this message translates to:
  /// **'先选一个舒服的阅读环境，之后也可以在设置里继续调整。'**
  String get onboardingAppearanceDescription;

  /// No description provided for @onboardingAppearanceImportedDescription.
  ///
  /// In zh, this message translates to:
  /// **'已应用导入的设置，可以在这里顺手微调。'**
  String get onboardingAppearanceImportedDescription;

  /// No description provided for @onboardingFontSize.
  ///
  /// In zh, this message translates to:
  /// **'字体大小'**
  String get onboardingFontSize;

  /// No description provided for @onboardingLargeScreenOptimization.
  ///
  /// In zh, this message translates to:
  /// **'大屏优化'**
  String get onboardingLargeScreenOptimization;

  /// No description provided for @onboardingLargeScreenOptimizationDescription.
  ///
  /// In zh, this message translates to:
  /// **'平板和横屏设备优先使用更适合大屏的导航布局'**
  String get onboardingLargeScreenOptimizationDescription;

  /// No description provided for @onboardingAccountTitle.
  ///
  /// In zh, this message translates to:
  /// **'账户'**
  String get onboardingAccountTitle;

  /// No description provided for @onboardingAccountDescription.
  ///
  /// In zh, this message translates to:
  /// **'登录后可以同步收藏、历史和关注；也可以从本地账号备份导入登录信息。'**
  String get onboardingAccountDescription;

  /// No description provided for @onboardingSignIn.
  ///
  /// In zh, this message translates to:
  /// **'登录'**
  String get onboardingSignIn;

  /// No description provided for @onboardingSignInDescription.
  ///
  /// In zh, this message translates to:
  /// **'使用现有登录方式进入账号'**
  String get onboardingSignInDescription;

  /// No description provided for @onboardingImportAccount.
  ///
  /// In zh, this message translates to:
  /// **'从本地备份导入账户'**
  String get onboardingImportAccount;

  /// No description provided for @onboardingImportAccountDescription.
  ///
  /// In zh, this message translates to:
  /// **'选择导出的登录信息 JSON 文件'**
  String get onboardingImportAccountDescription;

  /// No description provided for @onboardingSkipSignIn.
  ///
  /// In zh, this message translates to:
  /// **'暂不登录'**
  String get onboardingSkipSignIn;

  /// No description provided for @onboardingSkipSignInDescription.
  ///
  /// In zh, this message translates to:
  /// **'先进入应用，之后随时可以登录'**
  String get onboardingSkipSignInDescription;

  /// No description provided for @onboardingReadyTitle.
  ///
  /// In zh, this message translates to:
  /// **'准备好了'**
  String get onboardingReadyTitle;

  /// No description provided for @onboardingReadyDescription.
  ///
  /// In zh, this message translates to:
  /// **'欢迎来到 ExPiliPlus。'**
  String get onboardingReadyDescription;

  /// No description provided for @onboardingUsingDefaultSettings.
  ///
  /// In zh, this message translates to:
  /// **'使用默认设置'**
  String get onboardingUsingDefaultSettings;

  /// No description provided for @onboardingNotSignedIn.
  ///
  /// In zh, this message translates to:
  /// **'暂未登录'**
  String get onboardingNotSignedIn;

  /// No description provided for @onboardingGetStarted.
  ///
  /// In zh, this message translates to:
  /// **'开始'**
  String get onboardingGetStarted;

  /// No description provided for @onboardingStartUsing.
  ///
  /// In zh, this message translates to:
  /// **'开始使用'**
  String get onboardingStartUsing;

  /// No description provided for @onboardingSourceLocalFile.
  ///
  /// In zh, this message translates to:
  /// **'本地文件'**
  String get onboardingSourceLocalFile;

  /// No description provided for @onboardingSourceWebDavBackup.
  ///
  /// In zh, this message translates to:
  /// **'WebDAV 备份'**
  String get onboardingSourceWebDavBackup;

  /// No description provided for @onboardingWebDavReadFailed.
  ///
  /// In zh, this message translates to:
  /// **'读取 WebDAV 失败：{error}'**
  String onboardingWebDavReadFailed(String error);

  /// No description provided for @onboardingSettingsParseFailed.
  ///
  /// In zh, this message translates to:
  /// **'解析设置失败：{error}'**
  String onboardingSettingsParseFailed(String error);

  /// No description provided for @onboardingSettingsImported.
  ///
  /// In zh, this message translates to:
  /// **'{count, plural, =0{已导入 0 项设置（{categories}）} =1{已导入 1 项设置（{categories}）} other{已导入 {count} 项设置（{categories}）}}'**
  String onboardingSettingsImported(int count, String categories);

  /// No description provided for @onboardingSettingsImportSucceeded.
  ///
  /// In zh, this message translates to:
  /// **'设置导入成功'**
  String get onboardingSettingsImportSucceeded;

  /// No description provided for @onboardingAccountParseFailed.
  ///
  /// In zh, this message translates to:
  /// **'解析登录信息失败：{error}'**
  String onboardingAccountParseFailed(String error);

  /// No description provided for @onboardingSignedInMid.
  ///
  /// In zh, this message translates to:
  /// **'已登录 mid {mid}'**
  String onboardingSignedInMid(int mid);

  /// No description provided for @onboardingAccountsImported.
  ///
  /// In zh, this message translates to:
  /// **'{count, plural, =0{已导入 0 个账号} =1{已导入 1 个账号} other{已导入 {count} 个账号}}'**
  String onboardingAccountsImported(int count);

  /// No description provided for @onboardingAccountImportSucceeded.
  ///
  /// In zh, this message translates to:
  /// **'登录信息导入成功'**
  String get onboardingAccountImportSucceeded;

  /// No description provided for @onboardingErrorJsonTopLevelObject.
  ///
  /// In zh, this message translates to:
  /// **'JSON 顶层必须是对象'**
  String get onboardingErrorJsonTopLevelObject;

  /// No description provided for @onboardingConfirmSettingsImport.
  ///
  /// In zh, this message translates to:
  /// **'导入 {source} 设置？'**
  String onboardingConfirmSettingsImport(String source);

  /// No description provided for @onboardingSettingsFields.
  ///
  /// In zh, this message translates to:
  /// **'设置字段'**
  String get onboardingSettingsFields;

  /// No description provided for @onboardingPlaybackFields.
  ///
  /// In zh, this message translates to:
  /// **'播放字段'**
  String get onboardingPlaybackFields;

  /// No description provided for @onboardingCategory.
  ///
  /// In zh, this message translates to:
  /// **'分类'**
  String get onboardingCategory;

  /// No description provided for @onboardingExtraTopLevelFields.
  ///
  /// In zh, this message translates to:
  /// **'额外顶层字段'**
  String get onboardingExtraTopLevelFields;

  /// No description provided for @onboardingConfirmAccountImport.
  ///
  /// In zh, this message translates to:
  /// **'导入本地账号备份？'**
  String get onboardingConfirmAccountImport;

  /// No description provided for @onboardingAccountCount.
  ///
  /// In zh, this message translates to:
  /// **'账号数量'**
  String get onboardingAccountCount;

  /// No description provided for @onboardingContainsCookie.
  ///
  /// In zh, this message translates to:
  /// **'包含 Cookie'**
  String get onboardingContainsCookie;

  /// No description provided for @onboardingContainsAccessKey.
  ///
  /// In zh, this message translates to:
  /// **'包含 accessKey'**
  String get onboardingContainsAccessKey;

  /// No description provided for @onboardingContainsRefresh.
  ///
  /// In zh, this message translates to:
  /// **'包含 refresh'**
  String get onboardingContainsRefresh;

  /// No description provided for @onboardingWillOverwrite.
  ///
  /// In zh, this message translates to:
  /// **'将覆盖'**
  String get onboardingWillOverwrite;

  /// No description provided for @onboardingWebDavAddress.
  ///
  /// In zh, this message translates to:
  /// **'地址'**
  String get onboardingWebDavAddress;

  /// No description provided for @onboardingWebDavAddressRequired.
  ///
  /// In zh, this message translates to:
  /// **'请输入 WebDAV 地址'**
  String get onboardingWebDavAddressRequired;

  /// No description provided for @onboardingWebDavUser.
  ///
  /// In zh, this message translates to:
  /// **'用户'**
  String get onboardingWebDavUser;

  /// No description provided for @onboardingWebDavPassword.
  ///
  /// In zh, this message translates to:
  /// **'密码'**
  String get onboardingWebDavPassword;

  /// No description provided for @onboardingWebDavPath.
  ///
  /// In zh, this message translates to:
  /// **'路径'**
  String get onboardingWebDavPath;

  /// No description provided for @onboardingCategoryAppearance.
  ///
  /// In zh, this message translates to:
  /// **'外观'**
  String get onboardingCategoryAppearance;

  /// No description provided for @onboardingCategoryPlayback.
  ///
  /// In zh, this message translates to:
  /// **'播放'**
  String get onboardingCategoryPlayback;

  /// No description provided for @onboardingCategoryWebDav.
  ///
  /// In zh, this message translates to:
  /// **'WebDAV'**
  String get onboardingCategoryWebDav;

  /// No description provided for @onboardingCategoryLayout.
  ///
  /// In zh, this message translates to:
  /// **'布局'**
  String get onboardingCategoryLayout;

  /// No description provided for @onboardingCategoryGeneral.
  ///
  /// In zh, this message translates to:
  /// **'通用'**
  String get onboardingCategoryGeneral;

  /// No description provided for @onboardingErrorNoSettingsData.
  ///
  /// In zh, this message translates to:
  /// **'未找到 setting 或 video 数据'**
  String get onboardingErrorNoSettingsData;

  /// No description provided for @onboardingErrorValueMustBeObject.
  ///
  /// In zh, this message translates to:
  /// **'{name} 必须是对象'**
  String onboardingErrorValueMustBeObject(String name);

  /// No description provided for @onboardingMidListSummary.
  ///
  /// In zh, this message translates to:
  /// **'{count, plural, =0{{mids} 等 0 个} =1{{mids} 等 1 个} other{{mids} 等 {count} 个}}'**
  String onboardingMidListSummary(String mids, int count);

  /// No description provided for @onboardingErrorAccountMustBeObject.
  ///
  /// In zh, this message translates to:
  /// **'账号 {account} 必须是对象'**
  String onboardingErrorAccountMustBeObject(String account);

  /// No description provided for @onboardingErrorNoAccountData.
  ///
  /// In zh, this message translates to:
  /// **'未找到账号数据'**
  String get onboardingErrorNoAccountData;

  /// No description provided for @settingsOpenOnboarding.
  ///
  /// In zh, this message translates to:
  /// **'重新打开欢迎引导'**
  String get settingsOpenOnboarding;

  /// No description provided for @settingsOpenOnboardingDescription.
  ///
  /// In zh, this message translates to:
  /// **'再次查看语言、主题和数据迁移引导，不会清除现有设置'**
  String get settingsOpenOnboardingDescription;

  /// No description provided for @settingsEnablePermanentDynamicBlock.
  ///
  /// In zh, this message translates to:
  /// **'启用永久动态屏蔽'**
  String get settingsEnablePermanentDynamicBlock;

  /// No description provided for @settingsEnablePermanentDynamicBlockDescription.
  ///
  /// In zh, this message translates to:
  /// **'开启后，可将指定 UP 加入永久动态屏蔽名单'**
  String get settingsEnablePermanentDynamicBlockDescription;

  /// No description provided for @settingsDynamicBlockedUpList.
  ///
  /// In zh, this message translates to:
  /// **'动态屏蔽 UP 名单'**
  String get settingsDynamicBlockedUpList;

  /// No description provided for @settingsDynamicBlockedUpCount.
  ///
  /// In zh, this message translates to:
  /// **'{count} 位 UP'**
  String settingsDynamicBlockedUpCount(int count);

  /// No description provided for @settingsDefaultValue.
  ///
  /// In zh, this message translates to:
  /// **'默认值：{value}'**
  String settingsDefaultValue(String value);

  /// No description provided for @commonDisabled.
  ///
  /// In zh, this message translates to:
  /// **'禁用'**
  String get commonDisabled;

  /// No description provided for @commonUnavailable.
  ///
  /// In zh, this message translates to:
  /// **'不可用'**
  String get commonUnavailable;

  /// No description provided for @commonDeleted.
  ///
  /// In zh, this message translates to:
  /// **'已删除'**
  String get commonDeleted;

  /// No description provided for @commonDelete.
  ///
  /// In zh, this message translates to:
  /// **'删除'**
  String get commonDelete;

  /// No description provided for @commonDeleting.
  ///
  /// In zh, this message translates to:
  /// **'正在删除…'**
  String get commonDeleting;

  /// No description provided for @commonDeleteSucceeded.
  ///
  /// In zh, this message translates to:
  /// **'删除成功'**
  String get commonDeleteSucceeded;

  /// No description provided for @commonDeleteFailed.
  ///
  /// In zh, this message translates to:
  /// **'删除失败：{error}'**
  String commonDeleteFailed(String error);

  /// No description provided for @commonLoadFailed.
  ///
  /// In zh, this message translates to:
  /// **'加载失败：{error}'**
  String commonLoadFailed(String error);

  /// No description provided for @commonReport.
  ///
  /// In zh, this message translates to:
  /// **'举报'**
  String get commonReport;

  /// No description provided for @commonFormat.
  ///
  /// In zh, this message translates to:
  /// **'格式'**
  String get commonFormat;

  /// No description provided for @commonPin.
  ///
  /// In zh, this message translates to:
  /// **'置顶'**
  String get commonPin;

  /// No description provided for @commonUnpin.
  ///
  /// In zh, this message translates to:
  /// **'取消置顶'**
  String get commonUnpin;

  /// No description provided for @commonLike.
  ///
  /// In zh, this message translates to:
  /// **'点赞'**
  String get commonLike;

  /// No description provided for @commonLiked.
  ///
  /// In zh, this message translates to:
  /// **'已赞'**
  String get commonLiked;

  /// No description provided for @commonDislike.
  ///
  /// In zh, this message translates to:
  /// **'点踩'**
  String get commonDislike;

  /// No description provided for @commonDisliked.
  ///
  /// In zh, this message translates to:
  /// **'已踩'**
  String get commonDisliked;

  /// No description provided for @commonAddToFavorites.
  ///
  /// In zh, this message translates to:
  /// **'收藏'**
  String get commonAddToFavorites;

  /// No description provided for @commonRemoveFromFavorites.
  ///
  /// In zh, this message translates to:
  /// **'取消收藏'**
  String get commonRemoveFromFavorites;

  /// No description provided for @commonShare.
  ///
  /// In zh, this message translates to:
  /// **'分享'**
  String get commonShare;

  /// No description provided for @commonRepost.
  ///
  /// In zh, this message translates to:
  /// **'转发'**
  String get commonRepost;

  /// No description provided for @commonOther.
  ///
  /// In zh, this message translates to:
  /// **'其他'**
  String get commonOther;

  /// No description provided for @commonBack.
  ///
  /// In zh, this message translates to:
  /// **'返回'**
  String get commonBack;

  /// No description provided for @commonPause.
  ///
  /// In zh, this message translates to:
  /// **'暂停'**
  String get commonPause;

  /// No description provided for @commonClose.
  ///
  /// In zh, this message translates to:
  /// **'关闭'**
  String get commonClose;

  /// No description provided for @commonLoading.
  ///
  /// In zh, this message translates to:
  /// **'加载中…'**
  String get commonLoading;

  /// No description provided for @commonSavingMayTakeTime.
  ///
  /// In zh, this message translates to:
  /// **'正在保存，可能需要一些时间'**
  String get commonSavingMayTakeTime;

  /// No description provided for @commonTapToReload.
  ///
  /// In zh, this message translates to:
  /// **'点击重新加载'**
  String get commonTapToReload;

  /// No description provided for @commonCopyLink.
  ///
  /// In zh, this message translates to:
  /// **'复制链接'**
  String get commonCopyLink;

  /// No description provided for @commonOpenInAnotherApp.
  ///
  /// In zh, this message translates to:
  /// **'用其他应用打开'**
  String get commonOpenInAnotherApp;

  /// No description provided for @commonNoMore.
  ///
  /// In zh, this message translates to:
  /// **'没有更多了'**
  String get commonNoMore;

  /// No description provided for @commonSend.
  ///
  /// In zh, this message translates to:
  /// **'发送'**
  String get commonSend;

  /// No description provided for @commonSending.
  ///
  /// In zh, this message translates to:
  /// **'发送中…'**
  String get commonSending;

  /// No description provided for @commonSent.
  ///
  /// In zh, this message translates to:
  /// **'发送成功'**
  String get commonSent;

  /// No description provided for @commonImage.
  ///
  /// In zh, this message translates to:
  /// **'图片'**
  String get commonImage;

  /// No description provided for @commonEdit.
  ///
  /// In zh, this message translates to:
  /// **'编辑'**
  String get commonEdit;

  /// No description provided for @commonPreview.
  ///
  /// In zh, this message translates to:
  /// **'预览'**
  String get commonPreview;

  /// No description provided for @commonRemove.
  ///
  /// In zh, this message translates to:
  /// **'移除'**
  String get commonRemove;

  /// No description provided for @commonSubmit.
  ///
  /// In zh, this message translates to:
  /// **'提交'**
  String get commonSubmit;

  /// No description provided for @commonSubmitting.
  ///
  /// In zh, this message translates to:
  /// **'正在提交…'**
  String get commonSubmitting;

  /// No description provided for @commonSubmitSucceeded.
  ///
  /// In zh, this message translates to:
  /// **'提交成功'**
  String get commonSubmitSucceeded;

  /// No description provided for @commonSubmitFailed.
  ///
  /// In zh, this message translates to:
  /// **'提交失败：{error}'**
  String commonSubmitFailed(String error);

  /// No description provided for @commonSucceeded.
  ///
  /// In zh, this message translates to:
  /// **'成功'**
  String get commonSucceeded;

  /// No description provided for @commonUndo.
  ///
  /// In zh, this message translates to:
  /// **'撤销'**
  String get commonUndo;

  /// No description provided for @commonUnknown.
  ///
  /// In zh, this message translates to:
  /// **'未知'**
  String get commonUnknown;

  /// No description provided for @commonDataUnavailable.
  ///
  /// In zh, this message translates to:
  /// **'无法获取所需数据'**
  String get commonDataUnavailable;

  /// No description provided for @commonFeedback.
  ///
  /// In zh, this message translates to:
  /// **'反馈'**
  String get commonFeedback;

  /// No description provided for @commonNotice.
  ///
  /// In zh, this message translates to:
  /// **'提示'**
  String get commonNotice;

  /// No description provided for @commonJumpFailed.
  ///
  /// In zh, this message translates to:
  /// **'跳转失败'**
  String get commonJumpFailed;

  /// No description provided for @commonOriginal.
  ///
  /// In zh, this message translates to:
  /// **'原文'**
  String get commonOriginal;

  /// No description provided for @commonTranslate.
  ///
  /// In zh, this message translates to:
  /// **'翻译'**
  String get commonTranslate;

  /// No description provided for @commonReply.
  ///
  /// In zh, this message translates to:
  /// **'回复'**
  String get commonReply;

  /// No description provided for @commonVote.
  ///
  /// In zh, this message translates to:
  /// **'投票'**
  String get commonVote;

  /// No description provided for @commonNote.
  ///
  /// In zh, this message translates to:
  /// **'笔记'**
  String get commonNote;

  /// No description provided for @commonNotes.
  ///
  /// In zh, this message translates to:
  /// **'笔记'**
  String get commonNotes;

  /// No description provided for @commonClear.
  ///
  /// In zh, this message translates to:
  /// **'清空'**
  String get commonClear;

  /// No description provided for @commonVideos.
  ///
  /// In zh, this message translates to:
  /// **'视频'**
  String get commonVideos;

  /// No description provided for @commonArticles.
  ///
  /// In zh, this message translates to:
  /// **'专栏'**
  String get commonArticles;

  /// No description provided for @commonLiveRooms.
  ///
  /// In zh, this message translates to:
  /// **'直播间'**
  String get commonLiveRooms;

  /// No description provided for @commonUsers.
  ///
  /// In zh, this message translates to:
  /// **'用户'**
  String get commonUsers;

  /// No description provided for @commonAllTypes.
  ///
  /// In zh, this message translates to:
  /// **'全部类型'**
  String get commonAllTypes;

  /// No description provided for @commonViewDetails.
  ///
  /// In zh, this message translates to:
  /// **'查看详情'**
  String get commonViewDetails;

  /// No description provided for @commonDetails.
  ///
  /// In zh, this message translates to:
  /// **'详情'**
  String get commonDetails;

  /// No description provided for @commonView.
  ///
  /// In zh, this message translates to:
  /// **'查看'**
  String get commonView;

  /// No description provided for @commonViewAll.
  ///
  /// In zh, this message translates to:
  /// **'查看全部'**
  String get commonViewAll;

  /// No description provided for @commonGoTo.
  ///
  /// In zh, this message translates to:
  /// **'前往'**
  String get commonGoTo;

  /// No description provided for @commonColorPicker.
  ///
  /// In zh, this message translates to:
  /// **'选择颜色'**
  String get commonColorPicker;

  /// No description provided for @commonSmall.
  ///
  /// In zh, this message translates to:
  /// **'小'**
  String get commonSmall;

  /// No description provided for @commonStandard.
  ///
  /// In zh, this message translates to:
  /// **'标准'**
  String get commonStandard;

  /// No description provided for @commonWifi.
  ///
  /// In zh, this message translates to:
  /// **'Wi-Fi'**
  String get commonWifi;

  /// No description provided for @commonMobileData.
  ///
  /// In zh, this message translates to:
  /// **'移动数据'**
  String get commonMobileData;

  /// No description provided for @commonNewestPublished.
  ///
  /// In zh, this message translates to:
  /// **'最新发布'**
  String get commonNewestPublished;

  /// No description provided for @commonMostViewed.
  ///
  /// In zh, this message translates to:
  /// **'最多播放'**
  String get commonMostViewed;

  /// No description provided for @downloadHighestQuality.
  ///
  /// In zh, this message translates to:
  /// **'最高画质'**
  String get downloadHighestQuality;

  /// No description provided for @downloadCurrentNetwork.
  ///
  /// In zh, this message translates to:
  /// **'当前网络：{network}'**
  String downloadCurrentNetwork(String network);

  /// No description provided for @downloadCacheAll.
  ///
  /// In zh, this message translates to:
  /// **'缓存全部'**
  String get downloadCacheAll;

  /// No description provided for @downloadConfirmCacheAll.
  ///
  /// In zh, this message translates to:
  /// **'确定缓存全部？'**
  String get downloadConfirmCacheAll;

  /// No description provided for @downloadViewCached.
  ///
  /// In zh, this message translates to:
  /// **'查看缓存'**
  String get downloadViewCached;

  /// No description provided for @accountPremium.
  ///
  /// In zh, this message translates to:
  /// **'大会员'**
  String get accountPremium;

  /// No description provided for @accountPremiumRequired.
  ///
  /// In zh, this message translates to:
  /// **'需要大会员'**
  String get accountPremiumRequired;

  /// No description provided for @accountSignInAgainRequired.
  ///
  /// In zh, this message translates to:
  /// **'请退出账号后重新登录'**
  String get accountSignInAgainRequired;

  /// No description provided for @memberQuietlyFollowing.
  ///
  /// In zh, this message translates to:
  /// **'悄悄关注'**
  String get memberQuietlyFollowing;

  /// No description provided for @memberFollowing.
  ///
  /// In zh, this message translates to:
  /// **'已关注'**
  String get memberFollowing;

  /// No description provided for @memberMutualFollow.
  ///
  /// In zh, this message translates to:
  /// **'互相关注'**
  String get memberMutualFollow;

  /// No description provided for @memberBlocked.
  ///
  /// In zh, this message translates to:
  /// **'已拉黑'**
  String get memberBlocked;

  /// No description provided for @memberSpecialFollow.
  ///
  /// In zh, this message translates to:
  /// **'特别关注'**
  String get memberSpecialFollow;

  /// No description provided for @memberFollow.
  ///
  /// In zh, this message translates to:
  /// **'关注'**
  String get memberFollow;

  /// No description provided for @memberFollowersAndVideos.
  ///
  /// In zh, this message translates to:
  /// **'{followers} 粉丝 · {videos} 个视频'**
  String memberFollowersAndVideos(String followers, String videos);

  /// No description provided for @memberEditProfile.
  ///
  /// In zh, this message translates to:
  /// **'编辑资料'**
  String get memberEditProfile;

  /// No description provided for @memberViewProfile.
  ///
  /// In zh, this message translates to:
  /// **'查看主页'**
  String get memberViewProfile;

  /// No description provided for @playerSuperResolutionEfficiency.
  ///
  /// In zh, this message translates to:
  /// **'效率'**
  String get playerSuperResolutionEfficiency;

  /// No description provided for @playerSuperResolutionQuality.
  ///
  /// In zh, this message translates to:
  /// **'画质'**
  String get playerSuperResolutionQuality;

  /// No description provided for @playerSuperResolution.
  ///
  /// In zh, this message translates to:
  /// **'超分辨率'**
  String get playerSuperResolution;

  /// No description provided for @playerRepeatPauseAtEnd.
  ///
  /// In zh, this message translates to:
  /// **'播完暂停'**
  String get playerRepeatPauseAtEnd;

  /// No description provided for @playerRepeatListOrder.
  ///
  /// In zh, this message translates to:
  /// **'列表顺序播放'**
  String get playerRepeatListOrder;

  /// No description provided for @playerRepeatSingle.
  ///
  /// In zh, this message translates to:
  /// **'单集循环'**
  String get playerRepeatSingle;

  /// No description provided for @playerRepeatList.
  ///
  /// In zh, this message translates to:
  /// **'列表循环'**
  String get playerRepeatList;

  /// No description provided for @playerRepeatAutoplayRelated.
  ///
  /// In zh, this message translates to:
  /// **'自动播放相关视频'**
  String get playerRepeatAutoplayRelated;

  /// No description provided for @playerFitStretch.
  ///
  /// In zh, this message translates to:
  /// **'拉伸'**
  String get playerFitStretch;

  /// No description provided for @playerFitAuto.
  ///
  /// In zh, this message translates to:
  /// **'自动'**
  String get playerFitAuto;

  /// No description provided for @playerFitCrop.
  ///
  /// In zh, this message translates to:
  /// **'裁剪'**
  String get playerFitCrop;

  /// No description provided for @playerFitWidth.
  ///
  /// In zh, this message translates to:
  /// **'适应宽度'**
  String get playerFitWidth;

  /// No description provided for @playerFitHeight.
  ///
  /// In zh, this message translates to:
  /// **'适应高度'**
  String get playerFitHeight;

  /// No description provided for @playerFitOriginal.
  ///
  /// In zh, this message translates to:
  /// **'原始大小'**
  String get playerFitOriginal;

  /// No description provided for @playerFitScaleDown.
  ///
  /// In zh, this message translates to:
  /// **'缩小适应'**
  String get playerFitScaleDown;

  /// No description provided for @playerQuality8k.
  ///
  /// In zh, this message translates to:
  /// **'8K 超高清'**
  String get playerQuality8k;

  /// No description provided for @playerQualityDolbyVision.
  ///
  /// In zh, this message translates to:
  /// **'杜比视界'**
  String get playerQualityDolbyVision;

  /// No description provided for @playerQualityHdr.
  ///
  /// In zh, this message translates to:
  /// **'HDR 真彩'**
  String get playerQualityHdr;

  /// No description provided for @playerQuality4k.
  ///
  /// In zh, this message translates to:
  /// **'4K 超高清'**
  String get playerQuality4k;

  /// No description provided for @playerQuality1080p60.
  ///
  /// In zh, this message translates to:
  /// **'1080P 60 帧'**
  String get playerQuality1080p60;

  /// No description provided for @playerQuality1080pHighBitrate.
  ///
  /// In zh, this message translates to:
  /// **'1080P 高码率'**
  String get playerQuality1080pHighBitrate;

  /// No description provided for @playerQuality1080p.
  ///
  /// In zh, this message translates to:
  /// **'1080P 高清'**
  String get playerQuality1080p;

  /// No description provided for @playerQuality720p60.
  ///
  /// In zh, this message translates to:
  /// **'720P 60 帧'**
  String get playerQuality720p60;

  /// No description provided for @playerQuality720p.
  ///
  /// In zh, this message translates to:
  /// **'720P 准高清'**
  String get playerQuality720p;

  /// No description provided for @playerQuality480p.
  ///
  /// In zh, this message translates to:
  /// **'480P 标清'**
  String get playerQuality480p;

  /// No description provided for @playerQuality360p.
  ///
  /// In zh, this message translates to:
  /// **'360P 流畅'**
  String get playerQuality360p;

  /// No description provided for @playerQuality240p.
  ///
  /// In zh, this message translates to:
  /// **'240P 极速'**
  String get playerQuality240p;

  /// No description provided for @playerCdnBaseUrl.
  ///
  /// In zh, this message translates to:
  /// **'主线路'**
  String get playerCdnBaseUrl;

  /// No description provided for @playerCdnBackupUrl.
  ///
  /// In zh, this message translates to:
  /// **'备用线路'**
  String get playerCdnBackupUrl;

  /// No description provided for @playerCdnAlibaba.
  ///
  /// In zh, this message translates to:
  /// **'阿里云（{name}）'**
  String playerCdnAlibaba(String name);

  /// No description provided for @playerCdnTencent.
  ///
  /// In zh, this message translates to:
  /// **'腾讯云（{name}）'**
  String playerCdnTencent(String name);

  /// No description provided for @playerCdnTencentVod.
  ///
  /// In zh, this message translates to:
  /// **'腾讯 VOD（{name}）'**
  String playerCdnTencentVod(String name);

  /// No description provided for @playerCdnHuaweiFusion.
  ///
  /// In zh, this message translates to:
  /// **'华为融合（{name}）'**
  String playerCdnHuaweiFusion(String name);

  /// No description provided for @playerCdnHuawei.
  ///
  /// In zh, this message translates to:
  /// **'华为云（{name}）'**
  String playerCdnHuawei(String name);

  /// No description provided for @playerCdnAkamaiInternational.
  ///
  /// In zh, this message translates to:
  /// **'Akamai 国际（{name}）'**
  String playerCdnAkamaiInternational(String name);

  /// No description provided for @playerCdnAlibabaInternational.
  ///
  /// In zh, this message translates to:
  /// **'阿里云国际（{name}）'**
  String playerCdnAlibabaInternational(String name);

  /// No description provided for @playerCdnTencentInternational.
  ///
  /// In zh, this message translates to:
  /// **'腾讯云国际（{name}）'**
  String playerCdnTencentInternational(String name);

  /// No description provided for @playerCdnHuaweiInternational.
  ///
  /// In zh, this message translates to:
  /// **'华为云国际（{name}）'**
  String playerCdnHuaweiInternational(String name);

  /// No description provided for @playerCdnBilibiliInternational.
  ///
  /// In zh, this message translates to:
  /// **'哔哩哔哩国际（{name}）'**
  String playerCdnBilibiliInternational(String name);

  /// No description provided for @playerCdnMayNotWork.
  ///
  /// In zh, this message translates to:
  /// **'该线路可能不可用'**
  String get playerCdnMayNotWork;

  /// No description provided for @playerCdnSpeedTestFailed.
  ///
  /// In zh, this message translates to:
  /// **'测速失败'**
  String get playerCdnSpeedTestFailed;

  /// No description provided for @playerCdnSettings.
  ///
  /// In zh, this message translates to:
  /// **'CDN 设置'**
  String get playerCdnSettings;

  /// No description provided for @playerCurrentCdn.
  ///
  /// In zh, this message translates to:
  /// **'当前 CDN：{cdn}'**
  String playerCurrentCdn(String cdn);

  /// No description provided for @playerCdnSetReloading.
  ///
  /// In zh, this message translates to:
  /// **'已切换到 {cdn}，正在重新加载'**
  String playerCdnSetReloading(String cdn);

  /// No description provided for @playerMoreSettings.
  ///
  /// In zh, this message translates to:
  /// **'更多播放设置'**
  String get playerMoreSettings;

  /// No description provided for @playerPlay.
  ///
  /// In zh, this message translates to:
  /// **'播放'**
  String get playerPlay;

  /// No description provided for @playerSleepTimer.
  ///
  /// In zh, this message translates to:
  /// **'定时停止播放'**
  String get playerSleepTimer;

  /// No description provided for @playerQuickActions.
  ///
  /// In zh, this message translates to:
  /// **'快捷操作'**
  String get playerQuickActions;

  /// No description provided for @playerQuickActionsEdit.
  ///
  /// In zh, this message translates to:
  /// **'编辑'**
  String get playerQuickActionsEdit;

  /// No description provided for @playerQuickActionsDescription.
  ///
  /// In zh, this message translates to:
  /// **'选择并排序显示在顶部的操作。'**
  String get playerQuickActionsDescription;

  /// No description provided for @playerQuickActionsUnavailable.
  ///
  /// In zh, this message translates to:
  /// **'当前不可用'**
  String get playerQuickActionsUnavailable;

  /// No description provided for @playerQuic…70281 tokens truncated…oBlockedKeywords.
  ///
  /// In zh, this message translates to:
  /// **'还未添加屏蔽词'**
  String get messagesNoBlockedKeywords;

  /// No description provided for @messagesBlockedKeywordDescription.
  ///
  /// In zh, this message translates to:
  /// **'添加后，将不再接收包含屏蔽词的消息'**
  String get messagesBlockedKeywordDescription;

  /// No description provided for @messagesEnterKeyword.
  ///
  /// In zh, this message translates to:
  /// **'请输入'**
  String get messagesEnterKeyword;

  /// No description provided for @messagesMarkAllRead.
  ///
  /// In zh, this message translates to:
  /// **'一键已读'**
  String get messagesMarkAllRead;

  /// No description provided for @messagesMarkAllReadConfirm.
  ///
  /// In zh, this message translates to:
  /// **'是否清除全部新消息提醒？'**
  String get messagesMarkAllReadConfirm;

  /// No description provided for @messagesClearList.
  ///
  /// In zh, this message translates to:
  /// **'清空列表'**
  String get messagesClearList;

  /// No description provided for @messagesClearListConfirm.
  ///
  /// In zh, this message translates to:
  /// **'清空后所有消息将被删除，无法恢复'**
  String get messagesClearListConfirm;

  /// No description provided for @messagesMenuSettings.
  ///
  /// In zh, this message translates to:
  /// **'消息设置'**
  String get messagesMenuSettings;

  /// No description provided for @messagesUploaderAssistant.
  ///
  /// In zh, this message translates to:
  /// **'UP主助手'**
  String get messagesUploaderAssistant;

  /// No description provided for @messagesContacts.
  ///
  /// In zh, this message translates to:
  /// **'联系人'**
  String get messagesContacts;

  /// No description provided for @messagesFanGroupAssistant.
  ///
  /// In zh, this message translates to:
  /// **'粉丝团助手'**
  String get messagesFanGroupAssistant;

  /// No description provided for @feedSelectTopic.
  ///
  /// In zh, this message translates to:
  /// **'选择话题'**
  String get feedSelectTopic;

  /// No description provided for @feedOptionalTitleHint.
  ///
  /// In zh, this message translates to:
  /// **'标题，选填 20 字'**
  String get feedOptionalTitleHint;

  /// No description provided for @feedEditPostTitle.
  ///
  /// In zh, this message translates to:
  /// **'编辑动态'**
  String get feedEditPostTitle;

  /// No description provided for @feedCreatePostTitle.
  ///
  /// In zh, this message translates to:
  /// **'发布动态'**
  String get feedCreatePostTitle;

  /// No description provided for @feedScheduledPost.
  ///
  /// In zh, this message translates to:
  /// **'定时发布'**
  String get feedScheduledPost;

  /// No description provided for @feedScheduleAtLeastMinutes.
  ///
  /// In zh, this message translates to:
  /// **'请至少选择 {minutes} 分钟之后的时间'**
  String feedScheduleAtLeastMinutes(Object minutes);

  /// No description provided for @feedLiveReservation.
  ///
  /// In zh, this message translates to:
  /// **'直播预约'**
  String get feedLiveReservation;

  /// No description provided for @feedStartedPoll.
  ///
  /// In zh, this message translates to:
  /// **'我发起了一个投票'**
  String get feedStartedPoll;

  /// No description provided for @feedPosting.
  ///
  /// In zh, this message translates to:
  /// **'正在发布…'**
  String get feedPosting;

  /// No description provided for @feedPosted.
  ///
  /// In zh, this message translates to:
  /// **'发布成功'**
  String get feedPosted;

  /// No description provided for @feedLiveReservationTitle.
  ///
  /// In zh, this message translates to:
  /// **'直播预约：{title}'**
  String feedLiveReservationTitle(Object title);

  /// No description provided for @feedLiveStartsAt.
  ///
  /// In zh, this message translates to:
  /// **'{time} 直播'**
  String feedLiveStartsAt(Object time);

  /// No description provided for @feedAllowComments.
  ///
  /// In zh, this message translates to:
  /// **'允许评论'**
  String get feedAllowComments;

  /// No description provided for @feedCloseComments.
  ///
  /// In zh, this message translates to:
  /// **'关闭评论'**
  String get feedCloseComments;

  /// No description provided for @feedFeaturedComments.
  ///
  /// In zh, this message translates to:
  /// **'精选评论'**
  String get feedFeaturedComments;

  /// No description provided for @voteCreateTitle.
  ///
  /// In zh, this message translates to:
  /// **'发起投票'**
  String get voteCreateTitle;

  /// No description provided for @voteEditTitle.
  ///
  /// In zh, this message translates to:
  /// **'投票'**
  String get voteEditTitle;

  /// No description provided for @voteType.
  ///
  /// In zh, this message translates to:
  /// **'投票类型'**
  String get voteType;

  /// No description provided for @voteTitle.
  ///
  /// In zh, this message translates to:
  /// **'投票标题'**
  String get voteTitle;

  /// No description provided for @voteTitleHint.
  ///
  /// In zh, this message translates to:
  /// **'请填写标题'**
  String get voteTitleHint;

  /// No description provided for @voteDescription.
  ///
  /// In zh, this message translates to:
  /// **'投票说明'**
  String get voteDescription;

  /// No description provided for @voteOptionLabel.
  ///
  /// In zh, this message translates to:
  /// **'选项{number}'**
  String voteOptionLabel(Object number);

  /// No description provided for @voteOptionHint.
  ///
  /// In zh, this message translates to:
  /// **'选项内容，最多 20 字'**
  String get voteOptionHint;

  /// No description provided for @voteAddOption.
  ///
  /// In zh, this message translates to:
  /// **'添加选项'**
  String get voteAddOption;

  /// No description provided for @voteChoiceMode.
  ///
  /// In zh, this message translates to:
  /// **'单选或多选'**
  String get voteChoiceMode;

  /// No description provided for @voteSingleChoice.
  ///
  /// In zh, this message translates to:
  /// **'单选'**
  String get voteSingleChoice;

  /// No description provided for @voteMaxChoices.
  ///
  /// In zh, this message translates to:
  /// **'最多选 {count} 项'**
  String voteMaxChoices(Object count);

  /// No description provided for @voteEndTime.
  ///
  /// In zh, this message translates to:
  /// **'投票截止时间'**
  String get voteEndTime;

  /// No description provided for @voteAtLeastFiveMinutes.
  ///
  /// In zh, this message translates to:
  /// **'至少选择 5 分钟之后'**
  String get voteAtLeastFiveMinutes;

  /// No description provided for @voteCreate.
  ///
  /// In zh, this message translates to:
  /// **'发起投票'**
  String get voteCreate;

  /// No description provided for @voteTextType.
  ///
  /// In zh, this message translates to:
  /// **'文字投票'**
  String get voteTextType;

  /// No description provided for @voteImageType.
  ///
  /// In zh, this message translates to:
  /// **'图片投票'**
  String get voteImageType;

  /// No description provided for @reserveAddLive.
  ///
  /// In zh, this message translates to:
  /// **'添加直播预约'**
  String get reserveAddLive;

  /// No description provided for @reserveType.
  ///
  /// In zh, this message translates to:
  /// **'类型'**
  String get reserveType;

  /// No description provided for @reservePublicLive.
  ///
  /// In zh, this message translates to:
  /// **'公开直播'**
  String get reservePublicLive;

  /// No description provided for @reserveSupporterLive.
  ///
  /// In zh, this message translates to:
  /// **'大航海直播'**
  String get reserveSupporterLive;

  /// No description provided for @reserveTime.
  ///
  /// In zh, this message translates to:
  /// **'时间'**
  String get reserveTime;

  /// No description provided for @reserveTitle.
  ///
  /// In zh, this message translates to:
  /// **'标题'**
  String get reserveTitle;

  /// No description provided for @reserveTitleHint.
  ///
  /// In zh, this message translates to:
  /// **'请填写标题，最多 14 字'**
  String get reserveTitleHint;

  /// No description provided for @reserveAdd.
  ///
  /// In zh, this message translates to:
  /// **'添加预约'**
  String get reserveAdd;

  /// No description provided for @mentionInputHint.
  ///
  /// In zh, this message translates to:
  /// **'输入你想 @ 的人'**
  String get mentionInputHint;

  /// No description provided for @topicSearchHint.
  ///
  /// In zh, this message translates to:
  /// **'搜索话题'**
  String get topicSearchHint;

  /// No description provided for @commonBlock.
  ///
  /// In zh, this message translates to:
  /// **'屏蔽'**
  String get commonBlock;

  /// No description provided for @commonBlockSucceeded.
  ///
  /// In zh, this message translates to:
  /// **'屏蔽成功'**
  String get commonBlockSucceeded;

  /// No description provided for @commonShow.
  ///
  /// In zh, this message translates to:
  /// **'显示'**
  String get commonShow;

  /// No description provided for @commonHide.
  ///
  /// In zh, this message translates to:
  /// **'隐藏'**
  String get commonHide;

  /// No description provided for @playerEnterFullscreen.
  ///
  /// In zh, this message translates to:
  /// **'进入全屏'**
  String get playerEnterFullscreen;

  /// No description provided for @playerExitFullscreen.
  ///
  /// In zh, this message translates to:
  /// **'退出全屏'**
  String get playerExitFullscreen;

  /// No description provided for @playerTurnOffBackgroundPlayback.
  ///
  /// In zh, this message translates to:
  /// **'关闭后台播放'**
  String get playerTurnOffBackgroundPlayback;

  /// No description provided for @liveSendDanmaku.
  ///
  /// In zh, this message translates to:
  /// **'发弹幕'**
  String get liveSendDanmaku;

  /// No description provided for @liveSwitchRoute.
  ///
  /// In zh, this message translates to:
  /// **'切换路线'**
  String get liveSwitchRoute;

  /// No description provided for @liveShareRoom.
  ///
  /// In zh, this message translates to:
  /// **'分享直播间'**
  String get liveShareRoom;

  /// No description provided for @livePlayerVolume.
  ///
  /// In zh, this message translates to:
  /// **'播放器音量：{value}%'**
  String livePlayerVolume(Object value);

  /// No description provided for @liveBackToBottom.
  ///
  /// In zh, this message translates to:
  /// **'回到底部'**
  String get liveBackToBottom;

  /// No description provided for @liveCopyDanmakuInfo.
  ///
  /// In zh, this message translates to:
  /// **'复制弹幕信息'**
  String get liveCopyDanmakuInfo;

  /// No description provided for @liveGoToUserProfile.
  ///
  /// In zh, this message translates to:
  /// **'去 TA 的个人空间'**
  String get liveGoToUserProfile;

  /// No description provided for @liveBlockSender.
  ///
  /// In zh, this message translates to:
  /// **'屏蔽发送者'**
  String get liveBlockSender;

  /// No description provided for @liveBlocked.
  ///
  /// In zh, this message translates to:
  /// **'屏蔽成功'**
  String get liveBlocked;

  /// No description provided for @liveLikeSucceeded.
  ///
  /// In zh, this message translates to:
  /// **'点赞成功'**
  String get liveLikeSucceeded;

  /// No description provided for @liveDanmakuInputHint.
  ///
  /// In zh, this message translates to:
  /// **'输入弹幕内容'**
  String get liveDanmakuInputHint;

  /// No description provided for @audioNoOrder.
  ///
  /// In zh, this message translates to:
  /// **'无序'**
  String get audioNoOrder;

  /// No description provided for @audioPlaybackSpeed.
  ///
  /// In zh, this message translates to:
  /// **'播放倍速（{speed}×）'**
  String audioPlaybackSpeed(Object speed);

  /// No description provided for @audioPlaybackMode.
  ///
  /// In zh, this message translates to:
  /// **'播放模式'**
  String get audioPlaybackMode;

  /// No description provided for @videoTripleSucceeded.
  ///
  /// In zh, this message translates to:
  /// **'三连成功'**
  String get videoTripleSucceeded;

  /// No description provided for @danmakuBlockTitle.
  ///
  /// In zh, this message translates to:
  /// **'弹幕屏蔽'**
  String get danmakuBlockTitle;

  /// No description provided for @danmakuBlockKeyword.
  ///
  /// In zh, this message translates to:
  /// **'关键词'**
  String get danmakuBlockKeyword;

  /// No description provided for @danmakuBlockRegex.
  ///
  /// In zh, this message translates to:
  /// **'正则'**
  String get danmakuBlockRegex;

  /// No description provided for @danmakuBlockUser.
  ///
  /// In zh, this message translates to:
  /// **'用户'**
  String get danmakuBlockUser;

  /// No description provided for @danmakuBlockTabCount.
  ///
  /// In zh, this message translates to:
  /// **'{label}（{count}）'**
  String danmakuBlockTabCount(Object count, Object label);

  /// No description provided for @danmakuDeleteRuleConfirm.
  ///
  /// In zh, this message translates to:
  /// **'确定删除该规则？'**
  String get danmakuDeleteRuleConfirm;

  /// No description provided for @danmakuKeywordHint.
  ///
  /// In zh, this message translates to:
  /// **'输入过滤关键词；其他类别请切换标签页后添加。'**
  String get danmakuKeywordHint;

  /// No description provided for @danmakuRegexHint.
  ///
  /// In zh, this message translates to:
  /// **'输入 // 之间的正则表达式，无需包含首尾斜杠。'**
  String get danmakuRegexHint;

  /// No description provided for @danmakuUidHint.
  ///
  /// In zh, this message translates to:
  /// **'输入用户 UID'**
  String get danmakuUidHint;

  /// No description provided for @danmakuRuleDialogTitle.
  ///
  /// In zh, this message translates to:
  /// **'{action}{type}规则'**
  String danmakuRuleDialogTitle(Object action, Object type);

  /// No description provided for @danmakuInputEmpty.
  ///
  /// In zh, this message translates to:
  /// **'输入内容不能为空'**
  String get danmakuInputEmpty;

  /// No description provided for @danmakuInputUnchanged.
  ///
  /// In zh, this message translates to:
  /// **'输入内容与上次相同'**
  String get danmakuInputUnchanged;

  /// No description provided for @danmakuSyncingRules.
  ///
  /// In zh, this message translates to:
  /// **'正在同步弹幕屏蔽规则…'**
  String get danmakuSyncingRules;

  /// No description provided for @danmakuDeletingRule.
  ///
  /// In zh, this message translates to:
  /// **'正在删除弹幕屏蔽规则…'**
  String get danmakuDeletingRule;

  /// No description provided for @danmakuAddingRule.
  ///
  /// In zh, this message translates to:
  /// **'正在添加弹幕屏蔽规则…'**
  String get danmakuAddingRule;

  /// No description provided for @liveDanmakuGlobalBlock.
  ///
  /// In zh, this message translates to:
  /// **'全局屏蔽'**
  String get liveDanmakuGlobalBlock;

  /// No description provided for @liveDanmakuBlockEnabled.
  ///
  /// In zh, this message translates to:
  /// **'屏蔽已开启'**
  String get liveDanmakuBlockEnabled;

  /// No description provided for @liveDanmakuBlockDisabled.
  ///
  /// In zh, this message translates to:
  /// **'屏蔽未开启'**
  String get liveDanmakuBlockDisabled;

  /// No description provided for @liveDanmakuUserLevel.
  ///
  /// In zh, this message translates to:
  /// **'用户等级'**
  String get liveDanmakuUserLevel;

  /// No description provided for @liveDanmakuBelowLevel.
  ///
  /// In zh, this message translates to:
  /// **'{level} 以下'**
  String liveDanmakuBelowLevel(Object level);

  /// No description provided for @liveDanmakuUnofficialUser.
  ///
  /// In zh, this message translates to:
  /// **'非正式会员'**
  String get liveDanmakuUnofficialUser;

  /// No description provided for @liveDanmakuUnverifiedPhone.
  ///
  /// In zh, this message translates to:
  /// **'未绑定手机用户'**
  String get liveDanmakuUnverifiedPhone;

  /// No description provided for @liveDanmakuKeywordBlock.
  ///
  /// In zh, this message translates to:
  /// **'关键词屏蔽'**
  String get liveDanmakuKeywordBlock;

  /// No description provided for @commonInput.
  ///
  /// In zh, this message translates to:
  /// **'输入'**
  String get commonInput;

  /// No description provided for @favoriteFolderSortTitle.
  ///
  /// In zh, this message translates to:
  /// **'收藏夹排序'**
  String get favoriteFolderSortTitle;

  /// No description provided for @favoriteDefaultFolderSortUnsupported.
  ///
  /// In zh, this message translates to:
  /// **'默认收藏夹不支持排序'**
  String get favoriteDefaultFolderSortUnsupported;

  /// No description provided for @favoriteSortFolderTitle.
  ///
  /// In zh, this message translates to:
  /// **'排序：{folder}'**
  String favoriteSortFolderTitle(String folder);

  /// No description provided for @followSaveToDefaultGroup.
  ///
  /// In zh, this message translates to:
  /// **'保存至默认分组'**
  String get followSaveToDefaultGroup;

  /// No description provided for @commonVideo.
  ///
  /// In zh, this message translates to:
  /// **'视频'**
  String get commonVideo;

  /// No description provided for @commonLongImage.
  ///
  /// In zh, this message translates to:
  /// **'长图'**
  String get commonLongImage;

  /// No description provided for @imagePositionSemantics.
  ///
  /// In zh, this message translates to:
  /// **'图片，第 {position} 张，共 {total} 张'**
  String imagePositionSemantics(int position, int total);

  /// No description provided for @downloadVideoCachedNotification.
  ///
  /// In zh, this message translates to:
  /// **'视频已缓存完成'**
  String get downloadVideoCachedNotification;

  /// No description provided for @topicJoin.
  ///
  /// In zh, this message translates to:
  /// **'参与话题'**
  String get topicJoin;

  /// No description provided for @topicStarted.
  ///
  /// In zh, this message translates to:
  /// **'发起'**
  String get topicStarted;

  /// No description provided for @topicStats.
  ///
  /// In zh, this message translates to:
  /// **'{views} 浏览 · {discussions} 讨论'**
  String topicStats(String views, String discussions);

  /// No description provided for @replyPinned.
  ///
  /// In zh, this message translates to:
  /// **'评论置顶成功'**
  String get replyPinned;

  /// No description provided for @replyUnpinned.
  ///
  /// In zh, this message translates to:
  /// **'已取消评论置顶'**
  String get replyUnpinned;

  /// No description provided for @webRefresh.
  ///
  /// In zh, this message translates to:
  /// **'刷新'**
  String get webRefresh;

  /// No description provided for @webCopyLink.
  ///
  /// In zh, this message translates to:
  /// **'复制链接'**
  String get webCopyLink;

  /// No description provided for @webOpenInBrowser.
  ///
  /// In zh, this message translates to:
  /// **'在浏览器中打开'**
  String get webOpenInBrowser;

  /// No description provided for @webClearCache.
  ///
  /// In zh, this message translates to:
  /// **'清除缓存'**
  String get webClearCache;

  /// No description provided for @webResetCookie.
  ///
  /// In zh, this message translates to:
  /// **'重新设置 Cookie'**
  String get webResetCookie;

  /// No description provided for @webGoBack.
  ///
  /// In zh, this message translates to:
  /// **'返回'**
  String get webGoBack;

  /// No description provided for @webCacheCleared.
  ///
  /// In zh, this message translates to:
  /// **'已清理'**
  String get webCacheCleared;

  /// No description provided for @webCookieResetSucceeded.
  ///
  /// In zh, this message translates to:
  /// **'设置成功，请刷新或重新打开网页'**
  String get webCookieResetSucceeded;

  /// No description provided for @webDownloadFileConfirm.
  ///
  /// In zh, this message translates to:
  /// **'下载文件：{filename}？'**
  String webDownloadFileConfirm(String filename);

  /// No description provided for @webConfirmWithFileSize.
  ///
  /// In zh, this message translates to:
  /// **'确定（{size}）'**
  String webConfirmWithFileSize(String size);

  /// No description provided for @webExternalLinkConfirm.
  ///
  /// In zh, this message translates to:
  /// **'当前网页将要打开外部链接，是否打开？'**
  String get webExternalLinkConfirm;

  /// No description provided for @webOpen.
  ///
  /// In zh, this message translates to:
  /// **'打开'**
  String get webOpen;

  /// No description provided for @commonUnliked.
  ///
  /// In zh, this message translates to:
  /// **'已取消点赞'**
  String get commonUnliked;

  /// No description provided for @articleShareTitle.
  ///
  /// In zh, this message translates to:
  /// **'哔哩哔哩专栏'**
  String get articleShareTitle;

  /// No description provided for @articleCount.
  ///
  /// In zh, this message translates to:
  /// **'{count} 篇专栏'**
  String articleCount(String count);

  /// No description provided for @articleWordCount.
  ///
  /// In zh, this message translates to:
  /// **'{count} 个字'**
  String articleWordCount(String count);

  /// No description provided for @articleReadCount.
  ///
  /// In zh, this message translates to:
  /// **'{count} 次阅读'**
  String articleReadCount(String count);

  /// No description provided for @articleUpdatedAt.
  ///
  /// In zh, this message translates to:
  /// **'{date} 更新'**
  String articleUpdatedAt(String date);

  /// No description provided for @articleCollectionId.
  ///
  /// In zh, this message translates to:
  /// **'文集号：{id}'**
  String articleCollectionId(int id);

  /// No description provided for @followUserFollowers.
  ///
  /// In zh, this message translates to:
  /// **'{name} 的粉丝'**
  String followUserFollowers(String name);

  /// No description provided for @followRemoveFollowerConfirm.
  ///
  /// In zh, this message translates to:
  /// **'确定移除 {name}？'**
  String followRemoveFollowerConfirm(String name);

  /// No description provided for @followFollowerRemoved.
  ///
  /// In zh, this message translates to:
  /// **'移除成功'**
  String get followFollowerRemoved;

  /// No description provided for @matchDetails.
  ///
  /// In zh, this message translates to:
  /// **'比赛详情'**
  String get matchDetails;

  /// No description provided for @matchWatchLive.
  ///
  /// In zh, this message translates to:
  /// **'看直播'**
  String get matchWatchLive;

  /// No description provided for @matchEndedAt.
  ///
  /// In zh, this message translates to:
  /// **'{date} · 已结束'**
  String matchEndedAt(String date);

  /// No description provided for @castNoDevices.
  ///
  /// In zh, this message translates to:
  /// **'没有找到投屏设备'**
  String get castNoDevices;

  /// No description provided for @liveSearchHint.
  ///
  /// In zh, this message translates to:
  /// **'搜索房间或主播'**
  String get liveSearchHint;

  /// No description provided for @liveContributionRankOnline.
  ///
  /// In zh, this message translates to:
  /// **'在线榜'**
  String get liveContributionRankOnline;

  /// No description provided for @liveContributionRankDaily.
  ///
  /// In zh, this message translates to:
  /// **'日榜'**
  String get liveContributionRankDaily;

  /// No description provided for @liveContributionRankWeekly.
  ///
  /// In zh, this message translates to:
  /// **'周榜'**
  String get liveContributionRankWeekly;

  /// No description provided for @liveContributionRankMonthly.
  ///
  /// In zh, this message translates to:
  /// **'月榜'**
  String get liveContributionRankMonthly;

  /// No description provided for @liveSearchRooms.
  ///
  /// In zh, this message translates to:
  /// **'正在直播 {count}'**
  String liveSearchRooms(String count);

  /// No description provided for @liveSearchUploaders.
  ///
  /// In zh, this message translates to:
  /// **'主播 {count}'**
  String liveSearchUploaders(String count);

  /// No description provided for @liveAllTags.
  ///
  /// In zh, this message translates to:
  /// **'全部标签'**
  String get liveAllTags;

  /// No description provided for @liveFavoriteTags.
  ///
  /// In zh, this message translates to:
  /// **'我的常用标签'**
  String get liveFavoriteTags;

  /// No description provided for @liveTapTagHint.
  ///
  /// In zh, this message translates to:
  /// **'点击进入标签'**
  String get liveTapTagHint;

  /// No description provided for @favoriteWantToWatch.
  ///
  /// In zh, this message translates to:
  /// **'想看'**
  String get favoriteWantToWatch;

  /// No description provided for @favoriteWatching.
  ///
  /// In zh, this message translates to:
  /// **'在看'**
  String get favoriteWatching;

  /// No description provided for @favoriteWatched.
  ///
  /// In zh, this message translates to:
  /// **'看过'**
  String get favoriteWatched;

  /// No description provided for @favoriteUnpublishedNotes.
  ///
  /// In zh, this message translates to:
  /// **'未发布笔记'**
  String get favoriteUnpublishedNotes;

  /// No description provided for @favoritePublicNotes.
  ///
  /// In zh, this message translates to:
  /// **'公开笔记'**
  String get favoritePublicNotes;

  /// No description provided for @memberOrderMostPlayed.
  ///
  /// In zh, this message translates to:
  /// **'最多播放'**
  String get memberOrderMostPlayed;

  /// No description provided for @memberOrderMostFavorited.
  ///
  /// In zh, this message translates to:
  /// **'最多收藏'**
  String get memberOrderMostFavorited;

  /// No description provided for @memberReverseOrder.
  ///
  /// In zh, this message translates to:
  /// **'倒序'**
  String get memberReverseOrder;

  /// No description provided for @memberJumpToPage.
  ///
  /// In zh, this message translates to:
  /// **'跳至'**
  String get memberJumpToPage;

  /// No description provided for @memberPageNumber.
  ///
  /// In zh, this message translates to:
  /// **'页数'**
  String get memberPageNumber;

  /// No description provided for @memberLocateLastWatched.
  ///
  /// In zh, this message translates to:
  /// **'定位至上次观看'**
  String get memberLocateLastWatched;

  /// No description provided for @audioTrackCount.
  ///
  /// In zh, this message translates to:
  /// **'{count, plural, other{共 {count} 首}}'**
  String audioTrackCount(int count);

  /// No description provided for @memberMyRecentCoinedVideos.
  ///
  /// In zh, this message translates to:
  /// **'我的最近投币'**
  String get memberMyRecentCoinedVideos;

  /// No description provided for @memberUserRecentCoinedVideos.
  ///
  /// In zh, this message translates to:
  /// **'{name} 的最近投币'**
  String memberUserRecentCoinedVideos(String name);

  /// No description provided for @memberFanMedalWall.
  ///
  /// In zh, this message translates to:
  /// **'粉丝勋章墙'**
  String get memberFanMedalWall;

  /// No description provided for @memberFanMedalCount.
  ///
  /// In zh, this message translates to:
  /// **'{count, plural, other{共拥有 {count} 枚粉丝勋章}}'**
  String memberFanMedalCount(int count);

  /// No description provided for @memberMedalWearing.
  ///
  /// In zh, this message translates to:
  /// **'佩戴中'**
  String get memberMedalWearing;

  /// No description provided for @favoriteAddedAt.
  ///
  /// In zh, this message translates to:
  /// **'收藏于 {date}'**
  String favoriteAddedAt(String date);

  /// No description provided for @memberLastWatched.
  ///
  /// In zh, this message translates to:
  /// **'上次观看'**
  String get memberLastWatched;

  /// No description provided for @reviewLong.
  ///
  /// In zh, this message translates to:
  /// **'长评'**
  String get reviewLong;

  /// No description provided for @reviewShort.
  ///
  /// In zh, this message translates to:
  /// **'短评'**
  String get reviewShort;

  /// No description provided for @reviewWriteLong.
  ///
  /// In zh, this message translates to:
  /// **'写长评'**
  String get reviewWriteLong;

  /// No description provided for @reviewWriteShort.
  ///
  /// In zh, this message translates to:
  /// **'写短评'**
  String get reviewWriteShort;

  /// No description provided for @reviewLatest.
  ///
  /// In zh, this message translates to:
  /// **'最新'**
  String get reviewLatest;

  /// No description provided for @reviewRatingAwful.
  ///
  /// In zh, this message translates to:
  /// **'很差'**
  String get reviewRatingAwful;

  /// No description provided for @reviewRatingPoor.
  ///
  /// In zh, this message translates to:
  /// **'较差'**
  String get reviewRatingPoor;

  /// No description provided for @reviewRatingOkay.
  ///
  /// In zh, this message translates to:
  /// **'还行'**
  String get reviewRatingOkay;

  /// No description provided for @reviewRatingGreat.
  ///
  /// In zh, this message translates to:
  /// **'很好'**
  String get reviewRatingGreat;

  /// No description provided for @reviewRatingExcellent.
  ///
  /// In zh, this message translates to:
  /// **'佳作'**
  String get reviewRatingExcellent;

  /// No description provided for @reviewTapToRate.
  ///
  /// In zh, this message translates to:
  /// **'轻触评分'**
  String get reviewTapToRate;

  /// No description provided for @reviewEdited.
  ///
  /// In zh, this message translates to:
  /// **'编辑成功'**
  String get reviewEdited;

  /// No description provided for @reviewPublished.
  ///
  /// In zh, this message translates to:
  /// **'点评成功'**
  String get reviewPublished;

  /// No description provided for @reviewDeleteConfirm.
  ///
  /// In zh, this message translates to:
  /// **'删除短评，同时删除评分？'**
  String get reviewDeleteConfirm;

  /// No description provided for @reviewCount.
  ///
  /// In zh, this message translates to:
  /// **'{count} 条点评'**
  String reviewCount(String count);

  /// No description provided for @searchFilter.
  ///
  /// In zh, this message translates to:
  /// **'筛选'**
  String get searchFilter;

  /// No description provided for @searchFilteredBy.
  ///
  /// In zh, this message translates to:
  /// **'“{filter}”的筛选结果'**
  String searchFilteredBy(String filter);

  /// No description provided for @searchSortValue.
  ///
  /// In zh, this message translates to:
  /// **'排序：{value}'**
  String searchSortValue(String value);

  /// No description provided for @searchZoneValue.
  ///
  /// In zh, this message translates to:
  /// **'分区：{value}'**
  String searchZoneValue(String value);

  /// No description provided for @searchUserTypeValue.
  ///
  /// In zh, this message translates to:
  /// **'用户类型：{value}'**
  String searchUserTypeValue(String value);

  /// No description provided for @searchZone.
  ///
  /// In zh, this message translates to:
  /// **'分区'**
  String get searchZone;

  /// No description provided for @searchUserSort.
  ///
  /// In zh, this message translates to:
  /// **'用户粉丝数及等级排序顺序'**
  String get searchUserSort;

  /// No description provided for @searchUserType.
  ///
  /// In zh, this message translates to:
  /// **'用户分类'**
  String get searchUserType;

  /// No description provided for @searchPublishedTime.
  ///
  /// In zh, this message translates to:
  /// **'发布时间'**
  String get searchPublishedTime;

  /// No description provided for @searchDateTo.
  ///
  /// In zh, this message translates to:
  /// **'至'**
  String get searchDateTo;

  /// No description provided for @searchContentDuration.
  ///
  /// In zh, this message translates to:
  /// **'内容时长'**
  String get searchContentDuration;

  /// No description provided for @searchContentZone.
  ///
  /// In zh, this message translates to:
  /// **'内容分区'**
  String get searchContentZone;

  /// No description provided for @searchOrderRelevance.
  ///
  /// In zh, this message translates to:
  /// **'综合排序'**
  String get searchOrderRelevance;

  /// No description provided for @searchOrderNewest.
  ///
  /// In zh, this message translates to:
  /// **'最新发布'**
  String get searchOrderNewest;

  /// No description provided for @searchOrderMostClicked.
  ///
  /// In zh, this message translates to:
  /// **'最多点击'**
  String get searchOrderMostClicked;

  /// No description provided for @searchOrderMostLiked.
  ///
  /// In zh, this message translates to:
  /// **'最多喜欢'**
  String get searchOrderMostLiked;

  /// No description provided for @searchOrderMostCommented.
  ///
  /// In zh, this message translates to:
  /// **'最多评论'**
  String get searchOrderMostCommented;

  /// No description provided for @searchOrderDefault.
  ///
  /// In zh, this message translates to:
  /// **'默认排序'**
  String get searchOrderDefault;

  /// No description provided for @searchOrderMostPlayed.
  ///
  /// In zh, this message translates to:
  /// **'播放多'**
  String get searchOrderMostPlayed;

  /// No description provided for @searchOrderMostDanmaku.
  ///
  /// In zh, this message translates to:
  /// **'弹幕多'**
  String get searchOrderMostDanmaku;

  /// No description provided for @searchOrderMostFavorited.
  ///
  /// In zh, this message translates to:
  /// **'收藏多'**
  String get searchOrderMostFavorited;

  /// No description provided for @searchFollowersHighToLow.
  ///
  /// In zh, this message translates to:
  /// **'粉丝数由高到低'**
  String get searchFollowersHighToLow;

  /// No description provided for @searchFollowersLowToHigh.
  ///
  /// In zh, this message translates to:
  /// **'粉丝数由低到高'**
  String get searchFollowersLowToHigh;

  /// No description provided for @searchLevelHighToLow.
  ///
  /// In zh, this message translates to:
  /// **'等级由高到低'**
  String get searchLevelHighToLow;

  /// No description provided for @searchLevelLowToHigh.
  ///
  /// In zh, this message translates to:
  /// **'等级由低到高'**
  String get searchLevelLowToHigh;

  /// No description provided for @searchAllUsers.
  ///
  /// In zh, this message translates to:
  /// **'全部用户'**
  String get searchAllUsers;

  /// No description provided for @searchUploaders.
  ///
  /// In zh, this message translates to:
  /// **'UP 主'**
  String get searchUploaders;

  /// No description provided for @searchRegularUsers.
  ///
  /// In zh, this message translates to:
  /// **'普通用户'**
  String get searchRegularUsers;

  /// No description provided for @searchVerifiedUsers.
  ///
  /// In zh, this message translates to:
  /// **'认证用户'**
  String get searchVerifiedUsers;

  /// No description provided for @searchAnyTime.
  ///
  /// In zh, this message translates to:
  /// **'不限'**
  String get searchAnyTime;

  /// No description provided for @searchLastDay.
  ///
  /// In zh, this message translates to:
  /// **'最近一天'**
  String get searchLastDay;

  /// No description provided for @searchLastWeek.
  ///
  /// In zh, this message translates to:
  /// **'最近一周'**
  String get searchLastWeek;

  /// No description provided for @searchLastSixMonths.
  ///
  /// In zh, this message translates to:
  /// **'最近半年'**
  String get searchLastSixMonths;

  /// No description provided for @searchAllDurations.
  ///
  /// In zh, this message translates to:
  /// **'全部时长'**
  String get searchAllDurations;

  /// No description provided for @searchDurationUnderTen.
  ///
  /// In zh, this message translates to:
  /// **'0–10 分钟'**
  String get searchDurationUnderTen;

  /// No description provided for @searchDurationTenToThirty.
  ///
  /// In zh, this message translates to:
  /// **'10–30 分钟'**
  String get searchDurationTenToThirty;

  /// No description provided for @searchDurationThirtyToSixty.
  ///
  /// In zh, this message translates to:
  /// **'30–60 分钟'**
  String get searchDurationThirtyToSixty;

  /// No description provided for @searchDurationOverSixty.
  ///
  /// In zh, this message translates to:
  /// **'60 分钟以上'**
  String get searchDurationOverSixty;

  /// No description provided for @searchAllZones.
  ///
  /// In zh, this message translates to:
  /// **'全部分区'**
  String get searchAllZones;

  /// No description provided for @searchZoneAnimation.
  ///
  /// In zh, this message translates to:
  /// **'动画'**
  String get searchZoneAnimation;

  /// No description provided for @searchZoneAnime.
  ///
  /// In zh, this message translates to:
  /// **'番剧'**
  String get searchZoneAnime;

  /// No description provided for @searchZoneChineseAnimation.
  ///
  /// In zh, this message translates to:
  /// **'国创'**
  String get searchZoneChineseAnimation;

  /// No description provided for @searchZoneMusic.
  ///
  /// In zh, this message translates to:
  /// **'音乐'**
  String get searchZoneMusic;

  /// No description provided for @searchZoneDance.
  ///
  /// In zh, this message translates to:
  /// **'舞蹈'**
  String get searchZoneDance;

  /// No description provided for @searchZoneGames.
  ///
  /// In zh, this message translates to:
  /// **'游戏'**
  String get searchZoneGames;

  /// No description provided for @searchZoneKnowledge.
  ///
  /// In zh, this message translates to:
  /// **'知识'**
  String get searchZoneKnowledge;

  /// No description provided for @searchZoneTechnology.
  ///
  /// In zh, this message translates to:
  /// **'科技'**
  String get searchZoneTechnology;

  /// No description provided for @searchZoneSports.
  ///
  /// In zh, this message translates to:
  /// **'运动'**
  String get searchZoneSports;

  /// No description provided for @searchZoneCars.
  ///
  /// In zh, this message translates to:
  /// **'汽车'**
  String get searchZoneCars;

  /// No description provided for @searchZoneLife.
  ///
  /// In zh, this message translates to:
  /// **'生活'**
  String get searchZoneLife;

  /// No description provided for @searchZoneFood.
  ///
  /// In zh, this message translates to:
  /// **'美食'**
  String get searchZoneFood;

  /// No description provided for @searchZoneAnimals.
  ///
  /// In zh, this message translates to:
  /// **'动物'**
  String get searchZoneAnimals;

  /// No description provided for @searchZoneKichiku.
  ///
  /// In zh, this message translates to:
  /// **'鬼畜'**
  String get searchZoneKichiku;

  /// No description provided for @searchZoneFashion.
  ///
  /// In zh, this message translates to:
  /// **'时尚'**
  String get searchZoneFashion;

  /// No description provided for @searchZoneNews.
  ///
  /// In zh, this message translates to:
  /// **'资讯'**
  String get searchZoneNews;

  /// No description provided for @searchZoneEntertainment.
  ///
  /// In zh, this message translates to:
  /// **'娱乐'**
  String get searchZoneEntertainment;

  /// No description provided for @searchZoneFilmTv.
  ///
  /// In zh, this message translates to:
  /// **'影视'**
  String get searchZoneFilmTv;

  /// No description provided for @searchZoneDocumentary.
  ///
  /// In zh, this message translates to:
  /// **'纪录片'**
  String get searchZoneDocumentary;

  /// No description provided for @searchZoneMovies.
  ///
  /// In zh, this message translates to:
  /// **'电影'**
  String get searchZoneMovies;

  /// No description provided for @searchZoneTv.
  ///
  /// In zh, this message translates to:
  /// **'电视'**
  String get searchZoneTv;

  /// No description provided for @searchZoneInterests.
  ///
  /// In zh, this message translates to:
  /// **'兴趣'**
  String get searchZoneInterests;

  /// No description provided for @searchZoneLightNovels.
  ///
  /// In zh, this message translates to:
  /// **'轻小说'**
  String get searchZoneLightNovels;

  /// No description provided for @searchZoneNotes.
  ///
  /// In zh, this message translates to:
  /// **'笔记'**
  String get searchZoneNotes;

  /// No description provided for @commonAlbum.
  ///
  /// In zh, this message translates to:
  /// **'相簿'**
  String get commonAlbum;

  /// No description provided for @commonArticle.
  ///
  /// In zh, this message translates to:
  /// **'专栏'**
  String get commonArticle;

  /// No description provided for @messagesAutoReply.
  ///
  /// In zh, this message translates to:
  /// **'此条消息为自动回复'**
  String get messagesAutoReply;

  /// No description provided for @messagesLiveBy.
  ///
  /// In zh, this message translates to:
  /// **'{author} · 直播'**
  String messagesLiveBy(String author);

  /// No description provided for @liveNow.
  ///
  /// In zh, this message translates to:
  /// **'直播中'**
  String get liveNow;

  /// No description provided for @memberFollowerCount.
  ///
  /// In zh, this message translates to:
  /// **'{count} 粉丝'**
  String memberFollowerCount(String count);

  /// No description provided for @commonViewMore.
  ///
  /// In zh, this message translates to:
  /// **'查看更多内容'**
  String get commonViewMore;

  /// No description provided for @commonExit.
  ///
  /// In zh, this message translates to:
  /// **'退出'**
  String get commonExit;

  /// No description provided for @audioWatchMv.
  ///
  /// In zh, this message translates to:
  /// **'看 MV'**
  String get audioWatchMv;

  /// No description provided for @liveHighEnergyAudience.
  ///
  /// In zh, this message translates to:
  /// **'高能观众（{count}）'**
  String liveHighEnergyAudience(String count);

  /// No description provided for @liveJustStarted.
  ///
  /// In zh, this message translates to:
  /// **'刚刚开播'**
  String get liveJustStarted;

  /// No description provided for @liveStartedFor.
  ///
  /// In zh, this message translates to:
  /// **'开播 {duration}'**
  String liveStartedFor(String duration);

  /// No description provided for @livePlaybackUrlUnavailable.
  ///
  /// In zh, this message translates to:
  /// **'无法获取播放地址'**
  String get livePlaybackUrlUnavailable;

  /// No description provided for @liveVisitUser.
  ///
  /// In zh, this message translates to:
  /// **'访问：{name}'**
  String liveVisitUser(String name);

  /// No description provided for @liveCopySuperChatInfo.
  ///
  /// In zh, this message translates to:
  /// **'复制 SC 信息'**
  String get liveCopySuperChatInfo;

  /// No description provided for @commonExpand.
  ///
  /// In zh, this message translates to:
  /// **'展开'**
  String get commonExpand;

  /// No description provided for @commonCollapse.
  ///
  /// In zh, this message translates to:
  /// **'收起'**
  String get commonCollapse;

  /// No description provided for @feedTopics.
  ///
  /// In zh, this message translates to:
  /// **'话题'**
  String get feedTopics;

  /// No description provided for @commonTime.
  ///
  /// In zh, this message translates to:
  /// **'时间'**
  String get commonTime;

  /// No description provided for @commonReason.
  ///
  /// In zh, this message translates to:
  /// **'原因'**
  String get commonReason;

  /// No description provided for @logChange.
  ///
  /// In zh, this message translates to:
  /// **'变化'**
  String get logChange;

  /// No description provided for @logLocation.
  ///
  /// In zh, this message translates to:
  /// **'地理位置'**
  String get logLocation;

  /// No description provided for @logExperienceHistory.
  ///
  /// In zh, this message translates to:
  /// **'经验记录'**
  String get logExperienceHistory;

  /// No description provided for @logLoginHistory.
  ///
  /// In zh, this message translates to:
  /// **'登录记录'**
  String get logLoginHistory;

  /// No description provided for @saveWatch.
  ///
  /// In zh, this message translates to:
  /// **'观看'**
  String get saveWatch;

  /// No description provided for @saveContent.
  ///
  /// In zh, this message translates to:
  /// **'内容'**
  String get saveContent;

  /// No description provided for @saveCollection.
  ///
  /// In zh, this message translates to:
  /// **'合集'**
  String get saveCollection;

  /// No description provided for @saveScanQrToOpen.
  ///
  /// In zh, this message translates to:
  /// **'识别二维码，{action}{item}'**
  String saveScanQrToOpen(String action, String item);

  /// No description provided for @musicReleaseDate.
  ///
  /// In zh, this message translates to:
  /// **'发行日期：{date}'**
  String musicReleaseDate(String date);

  /// No description provided for @musicOriginalArtist.
  ///
  /// In zh, this message translates to:
  /// **'原唱：{artist}'**
  String musicOriginalArtist(String artist);

  /// No description provided for @musicAlbum.
  ///
  /// In zh, this message translates to:
  /// **'专辑：{album}'**
  String musicAlbum(String album);

  /// No description provided for @musicSource.
  ///
  /// In zh, this message translates to:
  /// **'出处：{source}'**
  String musicSource(String source);

  /// No description provided for @musicHotSongRanking.
  ///
  /// In zh, this message translates to:
  /// **'热歌榜排名'**
  String get musicHotSongRanking;

  /// No description provided for @musicPopularity.
  ///
  /// In zh, this message translates to:
  /// **'热度'**
  String get musicPopularity;

  /// No description provided for @musicTotalPlays.
  ///
  /// In zh, this message translates to:
  /// **'总播放量'**
  String get musicTotalPlays;

  /// No description provided for @musicVideosUsingTrack.
  ///
  /// In zh, this message translates to:
  /// **'使用稿件量'**
  String get musicVideosUsingTrack;

  /// No description provided for @musicRecentPopularityTrend.
  ///
  /// In zh, this message translates to:
  /// **'近 {days} 日热度趋势'**
  String musicRecentPopularityTrend(int days);

  /// No description provided for @articleAuthorReads.
  ///
  /// In zh, this message translates to:
  /// **'{author} · {count} 阅读'**
  String articleAuthorReads(String author, int count);

  /// No description provided for @articlePriceFrom.
  ///
  /// In zh, this message translates to:
  /// **'{price} 起'**
  String articlePriceFrom(String price);

  /// No description provided for @articleFeedOrArticle.
  ///
  /// In zh, this message translates to:
  /// **'动态 / 专栏'**
  String get articleFeedOrArticle;

  /// No description provided for @articleUnsupportedType.
  ///
  /// In zh, this message translates to:
  /// **'不支持的类型（{type}）'**
  String articleUnsupportedType(String type);

  /// No description provided for @articleInvalidType.
  ///
  /// In zh, this message translates to:
  /// **'错误的类型：{error}'**
  String articleInvalidType(String error);

  /// No description provided for @memberShopFrom.
  ///
  /// In zh, this message translates to:
  /// **'来自 {source}'**
  String memberShopFrom(String source);

  /// No description provided for @loginMainAccountSucceeded.
  ///
  /// In zh, this message translates to:
  /// **'主账号登录成功'**
  String get loginMainAccountSucceeded;

  /// No description provided for @loginCookieFailed.
  ///
  /// In zh, this message translates to:
  /// **'登录失败，请检查 Cookie 是否正确。{error}'**
  String loginCookieFailed(String error);

  /// No description provided for @memberAllCollectionsAndLists.
  ///
  /// In zh, this message translates to:
  /// **'全部合集 / 列表'**
  String get memberAllCollectionsAndLists;

  /// No description provided for @memberAllPosts.
  ///
  /// In zh, this message translates to:
  /// **'全部图文'**
  String get memberAllPosts;

  /// No description provided for @memberPosts.
  ///
  /// In zh, this message translates to:
  /// **'图文'**
  String get memberPosts;

  /// No description provided for @memberSupportRanking.
  ///
  /// In zh, this message translates to:
  /// **'{name} 的充电排行榜 {count}'**
  String memberSupportRanking(String name, String count);

  /// No description provided for @memberSupport.
  ///
  /// In zh, this message translates to:
  /// **'充电'**
  String get memberSupport;

  /// No description provided for @memberSupportDaysSuffix.
  ///
  /// In zh, this message translates to:
  /// **' 天'**
  String get memberSupportDaysSuffix;

  /// No description provided for @liveSearchUserStats.
  ///
  /// In zh, this message translates to:
  /// **'分区：{area} · 关注数：{followers}'**
  String liveSearchUserStats(String area, String followers);

  /// No description provided for @bubbleSiteTitle.
  ///
  /// In zh, this message translates to:
  /// **'{name} 小站'**
  String bubbleSiteTitle(String name);

  /// No description provided for @liveSwitchPreviewTo.
  ///
  /// In zh, this message translates to:
  /// **'切换至{target}'**
  String liveSwitchPreviewTo(String target);

  /// No description provided for @liveCover.
  ///
  /// In zh, this message translates to:
  /// **'封面'**
  String get liveCover;

  /// No description provided for @liveFirstFrame.
  ///
  /// In zh, this message translates to:
  /// **'首帧'**
  String get liveFirstFrame;

  /// No description provided for @liveShowMenu.
  ///
  /// In zh, this message translates to:
  /// **'显示菜单'**
  String get liveShowMenu;

  /// No description provided for @liveReportSelectedDanmaku.
  ///
  /// In zh, this message translates to:
  /// **'举报选中弹幕'**
  String get liveReportSelectedDanmaku;

  /// No description provided for @mediaTvSeries.
  ///
  /// In zh, this message translates to:
  /// **'电视剧'**
  String get mediaTvSeries;

  /// No description provided for @mediaComics.
  ///
  /// In zh, this message translates to:
  /// **'漫画'**
  String get mediaComics;

  /// No description provided for @mediaVarietyShows.
  ///
  /// In zh, this message translates to:
  /// **'综艺'**
  String get mediaVarietyShows;

  /// No description provided for @memberUserLevelSemantics.
  ///
  /// In zh, this message translates to:
  /// **'{level} 级'**
  String memberUserLevelSemantics(int level);

  /// No description provided for @avatarVipBadge.
  ///
  /// In zh, this message translates to:
  /// **'大会员'**
  String get avatarVipBadge;

  /// No description provided for @avatarVerifiedIndividual.
  ///
  /// In zh, this message translates to:
  /// **'认证个人'**
  String get avatarVerifiedIndividual;

  /// No description provided for @avatarVerifiedOrganization.
  ///
  /// In zh, this message translates to:
  /// **'认证机构'**
  String get avatarVerifiedOrganization;

  /// No description provided for @memberHardcoreUserLevelSemantics.
  ///
  /// In zh, this message translates to:
  /// **'硬核 {level} 级'**
  String memberHardcoreUserLevelSemantics(int level);

  /// No description provided for @playerProgressBar.
  ///
  /// In zh, this message translates to:
  /// **'进度条'**
  String get playerProgressBar;

  /// No description provided for @commonPlay.
  ///
  /// In zh, this message translates to:
  /// **'播放'**
  String get commonPlay;

  /// No description provided for @settingsSpeedTestTimeout.
  ///
  /// In zh, this message translates to:
  /// **'测速超时'**
  String get settingsSpeedTestTimeout;

  /// No description provided for @commonSave.
  ///
  /// In zh, this message translates to:
  /// **'保存'**
  String get commonSave;

  /// No description provided for @videoShareAsTicket.
  ///
  /// In zh, this message translates to:
  /// **'分享为分享票'**
  String get videoShareAsTicket;

  /// No description provided for @shareTicketTitle.
  ///
  /// In zh, this message translates to:
  /// **'分享票'**
  String get shareTicketTitle;

  /// No description provided for @shareTicketPostscript.
  ///
  /// In zh, this message translates to:
  /// **'分享附言'**
  String get shareTicketPostscript;

  /// No description provided for @shareTicketPostscriptHint.
  ///
  /// In zh, this message translates to:
  /// **'写下你的推荐语'**
  String get shareTicketPostscriptHint;

  /// No description provided for @shareTicketSave.
  ///
  /// In zh, this message translates to:
  /// **'保存图片'**
  String get shareTicketSave;

  /// No description provided for @shareTicketShare.
  ///
  /// In zh, this message translates to:
  /// **'系统分享'**
  String get shareTicketShare;

  /// No description provided for @shareTicketLoadFailed.
  ///
  /// In zh, this message translates to:
  /// **'分享票所需资源加载失败，请重试'**
  String get shareTicketLoadFailed;

  /// No description provided for @shareTicketRetry.
  ///
  /// In zh, this message translates to:
  /// **'重试'**
  String get shareTicketRetry;

  /// No description provided for @shareTicketPublishedAt.
  ///
  /// In zh, this message translates to:
  /// **'发布'**
  String get shareTicketPublishedAt;

  /// No description provided for @shareTicketPlays.
  ///
  /// In zh, this message translates to:
  /// **'播放'**
  String get shareTicketPlays;

  /// No description provided for @shareTicketDanmaku.
  ///
  /// In zh, this message translates to:
  /// **'弹幕'**
  String get shareTicketDanmaku;

  /// No description provided for @shareTicketLikes.
  ///
  /// In zh, this message translates to:
  /// **'点赞'**
  String get shareTicketLikes;

  /// No description provided for @shareTicketSharer.
  ///
  /// In zh, this message translates to:
  /// **'分享者'**
  String get shareTicketSharer;

  /// No description provided for @shareTicketFrom.
  ///
  /// In zh, this message translates to:
  /// **'分享来自 ExPiliPlus'**
  String get shareTicketFrom;

  /// No description provided for @videoNoteWindowPinned.
  ///
  /// In zh, this message translates to:
  /// **'已置顶笔记窗口'**
  String get videoNoteWindowPinned;

  /// No description provided for @videoNoteWindowOpened.
  ///
  /// In zh, this message translates to:
  /// **'已在新窗口打开'**
  String get videoNoteWindowOpened;

  /// No description provided for @settingsEnableDocProvider.
  ///
  /// In zh, this message translates to:
  /// **'允许三方 APP 访问私有存储'**
  String get settingsEnableDocProvider;

  /// No description provided for @settingsEnableDocProviderDescription.
  ///
  /// In zh, this message translates to:
  /// **'允许三方 APP 通过外部存储访问应用私有文件'**
  String get settingsEnableDocProviderDescription;

  /// No description provided for @settingsEnableEmoteTooltip.
  ///
  /// In zh, this message translates to:
  /// **'点击表情显示 Tooltip'**
  String get settingsEnableEmoteTooltip;

  /// No description provided for @settingsEnableEmoteTooltipDescription.
  ///
  /// In zh, this message translates to:
  /// **'长按或悬停表情时显示预览'**
  String get settingsEnableEmoteTooltipDescription;

  /// No description provided for @settingsAicuLookupEnabled.
  ///
  /// In zh, this message translates to:
  /// **'启用 AICU 评论查询'**
  String get settingsAicuLookupEnabled;

  /// No description provided for @settingsAicuLookupEnabledDescription.
  ///
  /// In zh, this message translates to:
  /// **'在评论菜单中显示 AICU 查询入口'**
  String get settingsAicuLookupEnabledDescription;

  /// No description provided for @settingsAicuProbe.
  ///
  /// In zh, this message translates to:
  /// **'AICU 服务状态'**
  String get settingsAicuProbe;

  /// No description provided for @aicuProbeNotChecked.
  ///
  /// In zh, this message translates to:
  /// **'尚未检测，点击检测'**
  String get aicuProbeNotChecked;

  /// No description provided for @aicuProbeChecking.
  ///
  /// In zh, this message translates to:
  /// **'正在检测 AICU 服务…'**
  String get aicuProbeChecking;

  /// No description provided for @aicuProbeReachable.
  ///
  /// In zh, this message translates to:
  /// **'服务响应正常'**
  String get aicuProbeReachable;

  /// No description provided for @aicuProbeLimited.
  ///
  /// In zh, this message translates to:
  /// **'服务可达，但本次探测受限'**
  String get aicuProbeLimited;

  /// No description provided for @aicuProbeUnavailable.
  ///
  /// In zh, this message translates to:
  /// **'当前网络无法连接服务'**
  String get aicuProbeUnavailable;

  /// No description provided for @aicuProbeTimedOut.
  ///
  /// In zh, this message translates to:
  /// **'服务探测超时'**
  String get aicuProbeTimedOut;

  /// No description provided for @aicuProbeUnexpectedResponse.
  ///
  /// In zh, this message translates to:
  /// **'服务返回了非预期响应'**
  String get aicuProbeUnexpectedResponse;

  /// No description provided for @aicuLookup.
  ///
  /// In zh, this message translates to:
  /// **'在 AICU 中查询'**
  String get aicuLookup;

  /// No description provided for @aicuLookupTitle.
  ///
  /// In zh, this message translates to:
  /// **'AICU 评论查询'**
  String get aicuLookupTitle;

  /// No description provided for @aicuThirdPartyNotice.
  ///
  /// In zh, this message translates to:
  /// **'第三方网站页面，可能显示广告并使用分析服务。查询不会附带 B 站登录凭据。'**
  String get aicuThirdPartyNotice;

  /// No description provided for @aicuLookupLoadFailed.
  ///
  /// In zh, this message translates to:
  /// **'AICU 页面加载失败，请检查网络或重试。'**
  String get aicuLookupLoadFailed;

  /// No description provided for @aicuWebViewUnsupported.
  ///
  /// In zh, this message translates to:
  /// **'此平台不支持应用内网页，请选择外部浏览器打开。'**
  String get aicuWebViewUnsupported;

  /// No description provided for @aicuOpenInBrowser.
  ///
  /// In zh, this message translates to:
  /// **'在浏览器中打开'**
  String get aicuOpenInBrowser;

  /// No description provided for @aicuExternalLinkBlocked.
  ///
  /// In zh, this message translates to:
  /// **'应用内仅允许打开安全的 AICU 页面。'**
  String get aicuExternalLinkBlocked;

  /// No description provided for @aicuOpenExternal.
  ///
  /// In zh, this message translates to:
  /// **'在外部打开链接'**
  String get aicuOpenExternal;

  /// No description provided for @aicuInvalidTarget.
  ///
  /// In zh, this message translates to:
  /// **'没有有效的评论用户 UID。'**
  String get aicuInvalidTarget;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'zh'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when language+script codes are specified.
  switch (locale.languageCode) {
    case 'zh':
      {
        switch (locale.scriptCode) {
          case 'Hant':
            return AppLocalizationsZhHant();
        }
        break;
      }
  }

  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
