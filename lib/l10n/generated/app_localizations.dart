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

  /// No description provided for @playerPlaybackUrl.
  ///
  /// In zh, this message translates to:
  /// **'播放地址'**
  String get playerPlaybackUrl;

  /// No description provided for @playerReloadVideo.
  ///
  /// In zh, this message translates to:
  /// **'重新加载视频'**
  String get playerReloadVideo;

  /// No description provided for @playerVolume.
  ///
  /// In zh, this message translates to:
  /// **'音量'**
  String get playerVolume;

  /// No description provided for @playerFlipHorizontal.
  ///
  /// In zh, this message translates to:
  /// **'水平翻转'**
  String get playerFlipHorizontal;

  /// No description provided for @playerFlipVertical.
  ///
  /// In zh, this message translates to:
  /// **'垂直翻转'**
  String get playerFlipVertical;

  /// No description provided for @playerAudioOnly.
  ///
  /// In zh, this message translates to:
  /// **'仅播放音频'**
  String get playerAudioOnly;

  /// No description provided for @playerBackgroundPlayback.
  ///
  /// In zh, this message translates to:
  /// **'后台播放'**
  String get playerBackgroundPlayback;

  /// No description provided for @playerSelectVideoQuality.
  ///
  /// In zh, this message translates to:
  /// **'选择视频画质'**
  String get playerSelectVideoQuality;

  /// No description provided for @playerCurrentVideoQuality.
  ///
  /// In zh, this message translates to:
  /// **'当前画质：{quality}'**
  String playerCurrentVideoQuality(String quality);

  /// No description provided for @playerSelectAudioQuality.
  ///
  /// In zh, this message translates to:
  /// **'选择音质'**
  String get playerSelectAudioQuality;

  /// No description provided for @playerCurrentAudioQuality.
  ///
  /// In zh, this message translates to:
  /// **'当前音质：{quality}'**
  String playerCurrentAudioQuality(String quality);

  /// No description provided for @playerCodec.
  ///
  /// In zh, this message translates to:
  /// **'编码格式'**
  String get playerCodec;

  /// No description provided for @playerCurrentCodec.
  ///
  /// In zh, this message translates to:
  /// **'当前编码：{codec}'**
  String playerCurrentCodec(String codec);

  /// No description provided for @playerPlaybackOrder.
  ///
  /// In zh, this message translates to:
  /// **'播放顺序'**
  String get playerPlaybackOrder;

  /// No description provided for @playerDanmakuList.
  ///
  /// In zh, this message translates to:
  /// **'弹幕列表'**
  String get playerDanmakuList;

  /// No description provided for @playerDanmakuSettings.
  ///
  /// In zh, this message translates to:
  /// **'弹幕设置'**
  String get playerDanmakuSettings;

  /// No description provided for @playerSubtitleSettings.
  ///
  /// In zh, this message translates to:
  /// **'字幕设置'**
  String get playerSubtitleSettings;

  /// No description provided for @playerLoadSubtitles.
  ///
  /// In zh, this message translates to:
  /// **'加载字幕'**
  String get playerLoadSubtitles;

  /// No description provided for @playerSaveSubtitles.
  ///
  /// In zh, this message translates to:
  /// **'保存字幕'**
  String get playerSaveSubtitles;

  /// No description provided for @playerPlaybackInfo.
  ///
  /// In zh, this message translates to:
  /// **'播放信息'**
  String get playerPlaybackInfo;

  /// No description provided for @playerInfoResolution.
  ///
  /// In zh, this message translates to:
  /// **'分辨率'**
  String get playerInfoResolution;

  /// No description provided for @playerInfoVideoParameters.
  ///
  /// In zh, this message translates to:
  /// **'视频参数'**
  String get playerInfoVideoParameters;

  /// No description provided for @playerInfoAudioParameters.
  ///
  /// In zh, this message translates to:
  /// **'音频参数'**
  String get playerInfoAudioParameters;

  /// No description provided for @playerInfoMedia.
  ///
  /// In zh, this message translates to:
  /// **'媒体'**
  String get playerInfoMedia;

  /// No description provided for @playerInfoAudioTrack.
  ///
  /// In zh, this message translates to:
  /// **'音轨'**
  String get playerInfoAudioTrack;

  /// No description provided for @playerInfoVideoTrack.
  ///
  /// In zh, this message translates to:
  /// **'视频轨'**
  String get playerInfoVideoTrack;

  /// No description provided for @playerInfoPlaybackRate.
  ///
  /// In zh, this message translates to:
  /// **'播放速度'**
  String get playerInfoPlaybackRate;

  /// No description provided for @playerInfoHardwareDecoder.
  ///
  /// In zh, this message translates to:
  /// **'硬件解码'**
  String get playerInfoHardwareDecoder;

  /// No description provided for @playerVideoQualityNotSupported.
  ///
  /// In zh, this message translates to:
  /// **'当前视频不支持选择画质'**
  String get playerVideoQualityNotSupported;

  /// No description provided for @playerPremiumQualityHint.
  ///
  /// In zh, this message translates to:
  /// **'此画质需要大会员或登录后使用'**
  String get playerPremiumQualityHint;

  /// No description provided for @playerVideoQualityChanged.
  ///
  /// In zh, this message translates to:
  /// **'画质已切换为 {quality}'**
  String playerVideoQualityChanged(String quality);

  /// No description provided for @playerAudioQualityChanged.
  ///
  /// In zh, this message translates to:
  /// **'音质已切换为 {quality}'**
  String playerAudioQualityChanged(String quality);

  /// No description provided for @playerCodecNotSupported.
  ///
  /// In zh, this message translates to:
  /// **'当前视频不支持切换编码'**
  String get playerCodecNotSupported;

  /// No description provided for @playerSelectCodec.
  ///
  /// In zh, this message translates to:
  /// **'选择编码格式'**
  String get playerSelectCodec;

  /// No description provided for @playerCodecChanged.
  ///
  /// In zh, this message translates to:
  /// **'编码已切换为 {codec}'**
  String playerCodecChanged(String codec);

  /// No description provided for @playerFontSize.
  ///
  /// In zh, this message translates to:
  /// **'字号：{value}'**
  String playerFontSize(String value);

  /// No description provided for @playerFullscreenFontSize.
  ///
  /// In zh, this message translates to:
  /// **'全屏字号：{value}'**
  String playerFullscreenFontSize(String value);

  /// No description provided for @playerFontWeightMayVary.
  ///
  /// In zh, this message translates to:
  /// **'字重：{value}（效果因字体而异）'**
  String playerFontWeightMayVary(String value);

  /// No description provided for @playerStrokeWidth.
  ///
  /// In zh, this message translates to:
  /// **'描边宽度：{value}'**
  String playerStrokeWidth(String value);

  /// No description provided for @playerHorizontalMargin.
  ///
  /// In zh, this message translates to:
  /// **'水平边距：{value}'**
  String playerHorizontalMargin(String value);

  /// No description provided for @playerBottomMargin.
  ///
  /// In zh, this message translates to:
  /// **'底部边距：{value}'**
  String playerBottomMargin(String value);

  /// No description provided for @playerBackgroundOpacity.
  ///
  /// In zh, this message translates to:
  /// **'背景不透明度：{value}'**
  String playerBackgroundOpacity(String value);

  /// No description provided for @playerOpacity.
  ///
  /// In zh, this message translates to:
  /// **'不透明度：{value}'**
  String playerOpacity(String value);

  /// No description provided for @playerWatchingNow.
  ///
  /// In zh, this message translates to:
  /// **'{count} 人正在看'**
  String playerWatchingNow(String count);

  /// No description provided for @playerCast.
  ///
  /// In zh, this message translates to:
  /// **'投屏'**
  String get playerCast;

  /// No description provided for @playerCastingNotSupported.
  ///
  /// In zh, this message translates to:
  /// **'不支持投屏'**
  String get playerCastingNotSupported;

  /// No description provided for @playerSubmitSegment.
  ///
  /// In zh, this message translates to:
  /// **'提交片段'**
  String get playerSubmitSegment;

  /// No description provided for @playerSegmentInfo.
  ///
  /// In zh, this message translates to:
  /// **'分段信息'**
  String get playerSegmentInfo;

  /// No description provided for @playerTurnOffDanmaku.
  ///
  /// In zh, this message translates to:
  /// **'关闭弹幕'**
  String get playerTurnOffDanmaku;

  /// No description provided for @playerTurnOnDanmaku.
  ///
  /// In zh, this message translates to:
  /// **'打开弹幕'**
  String get playerTurnOnDanmaku;

  /// No description provided for @playerPictureInPicture.
  ///
  /// In zh, this message translates to:
  /// **'画中画'**
  String get playerPictureInPicture;

  /// No description provided for @playerDanmakuScrolling.
  ///
  /// In zh, this message translates to:
  /// **'滚动'**
  String get playerDanmakuScrolling;

  /// No description provided for @playerDanmakuTop.
  ///
  /// In zh, this message translates to:
  /// **'顶部'**
  String get playerDanmakuTop;

  /// No description provided for @playerDanmakuBottom.
  ///
  /// In zh, this message translates to:
  /// **'底部'**
  String get playerDanmakuBottom;

  /// No description provided for @playerDanmakuColored.
  ///
  /// In zh, this message translates to:
  /// **'彩色'**
  String get playerDanmakuColored;

  /// No description provided for @playerDanmakuAdvanced.
  ///
  /// In zh, this message translates to:
  /// **'高级'**
  String get playerDanmakuAdvanced;

  /// No description provided for @playerDanmakuCloudFilterLevel.
  ///
  /// In zh, this message translates to:
  /// **'云屏蔽等级：{level}'**
  String playerDanmakuCloudFilterLevel(int level);

  /// No description provided for @playerDanmakuFilterManagement.
  ///
  /// In zh, this message translates to:
  /// **'{count, plural, =0{屏蔽管理} other{屏蔽管理（{count}）}}'**
  String playerDanmakuFilterManagement(int count);

  /// No description provided for @playerDanmakuFilterByType.
  ///
  /// In zh, this message translates to:
  /// **'按类型屏蔽'**
  String get playerDanmakuFilterByType;

  /// No description provided for @playerDanmakuMassiveMode.
  ///
  /// In zh, this message translates to:
  /// **'海量模式'**
  String get playerDanmakuMassiveMode;

  /// No description provided for @playerDanmakuConvertStaticToScrolling.
  ///
  /// In zh, this message translates to:
  /// **'固定弹幕转滚动弹幕'**
  String get playerDanmakuConvertStaticToScrolling;

  /// No description provided for @playerDanmakuFixedSpeed.
  ///
  /// In zh, this message translates to:
  /// **'固定速度'**
  String get playerDanmakuFixedSpeed;

  /// No description provided for @playerDanmakuDisplayArea.
  ///
  /// In zh, this message translates to:
  /// **'显示区域：{value}'**
  String playerDanmakuDisplayArea(String value);

  /// No description provided for @playerScrollingDanmakuDuration.
  ///
  /// In zh, this message translates to:
  /// **'滚动弹幕时长：{value} 秒'**
  String playerScrollingDanmakuDuration(String value);

  /// No description provided for @playerStaticDanmakuDuration.
  ///
  /// In zh, this message translates to:
  /// **'固定弹幕时长：{value} 秒'**
  String playerStaticDanmakuDuration(String value);

  /// No description provided for @playerDanmakuLineHeight.
  ///
  /// In zh, this message translates to:
  /// **'弹幕行高：{value}'**
  String playerDanmakuLineHeight(String value);

  /// No description provided for @playerPreviousEpisode.
  ///
  /// In zh, this message translates to:
  /// **'上一集'**
  String get playerPreviousEpisode;

  /// No description provided for @playerNextEpisode.
  ///
  /// In zh, this message translates to:
  /// **'下一集'**
  String get playerNextEpisode;

  /// No description provided for @playerAlreadyFirstEpisode.
  ///
  /// In zh, this message translates to:
  /// **'已经是第一集了'**
  String get playerAlreadyFirstEpisode;

  /// No description provided for @playerAlreadyLastEpisode.
  ///
  /// In zh, this message translates to:
  /// **'已经是最后一集了'**
  String get playerAlreadyLastEpisode;

  /// No description provided for @playerHighlightHeatmap.
  ///
  /// In zh, this message translates to:
  /// **'高能进度条'**
  String get playerHighlightHeatmap;

  /// No description provided for @playerChapterInfo.
  ///
  /// In zh, this message translates to:
  /// **'章节信息'**
  String get playerChapterInfo;

  /// No description provided for @playerEpisodes.
  ///
  /// In zh, this message translates to:
  /// **'选集'**
  String get playerEpisodes;

  /// No description provided for @playerAspectRatio.
  ///
  /// In zh, this message translates to:
  /// **'画面比例'**
  String get playerAspectRatio;

  /// No description provided for @playerTranslation.
  ///
  /// In zh, this message translates to:
  /// **'翻译'**
  String get playerTranslation;

  /// No description provided for @playerTurnOffTranslation.
  ///
  /// In zh, this message translates to:
  /// **'关闭翻译'**
  String get playerTurnOffTranslation;

  /// No description provided for @playerSubtitles.
  ///
  /// In zh, this message translates to:
  /// **'字幕'**
  String get playerSubtitles;

  /// No description provided for @playerTurnOffSubtitles.
  ///
  /// In zh, this message translates to:
  /// **'关闭字幕'**
  String get playerTurnOffSubtitles;

  /// No description provided for @playerPlaybackSpeed.
  ///
  /// In zh, this message translates to:
  /// **'播放速度'**
  String get playerPlaybackSpeed;

  /// No description provided for @playerSpeedSemantic.
  ///
  /// In zh, this message translates to:
  /// **'{speed} 倍速'**
  String playerSpeedSemantic(String speed);

  /// No description provided for @playerVideoQuality.
  ///
  /// In zh, this message translates to:
  /// **'视频画质'**
  String get playerVideoQuality;

  /// No description provided for @playerExitFullScreen.
  ///
  /// In zh, this message translates to:
  /// **'退出全屏'**
  String get playerExitFullScreen;

  /// No description provided for @playerFullScreen.
  ///
  /// In zh, this message translates to:
  /// **'全屏'**
  String get playerFullScreen;

  /// No description provided for @playerReleaseToCancelSeeking.
  ///
  /// In zh, this message translates to:
  /// **'松开以取消定位'**
  String get playerReleaseToCancelSeeking;

  /// No description provided for @playerSpeedActive.
  ///
  /// In zh, this message translates to:
  /// **'{speed} 倍速播放'**
  String playerSpeedActive(String speed);

  /// No description provided for @playerResetView.
  ///
  /// In zh, this message translates to:
  /// **'重置画面'**
  String get playerResetView;

  /// No description provided for @playerUnlock.
  ///
  /// In zh, this message translates to:
  /// **'解锁'**
  String get playerUnlock;

  /// No description provided for @playerLock.
  ///
  /// In zh, this message translates to:
  /// **'锁定'**
  String get playerLock;

  /// No description provided for @playerScreenshot.
  ///
  /// In zh, this message translates to:
  /// **'截图'**
  String get playerScreenshot;

  /// No description provided for @playerMuted.
  ///
  /// In zh, this message translates to:
  /// **'已静音'**
  String get playerMuted;

  /// No description provided for @playerUnmuted.
  ///
  /// In zh, this message translates to:
  /// **'已取消静音'**
  String get playerUnmuted;

  /// No description provided for @playerAnimatedScreenshot.
  ///
  /// In zh, this message translates to:
  /// **'动态截图'**
  String get playerAnimatedScreenshot;

  /// No description provided for @playerWebpPreset.
  ///
  /// In zh, this message translates to:
  /// **'WebP 预设'**
  String get playerWebpPreset;

  /// No description provided for @playerWebpCpuWarning.
  ///
  /// In zh, this message translates to:
  /// **'生成动态截图会占用较多处理器资源'**
  String get playerWebpCpuWarning;

  /// No description provided for @playerTranscodeFailedOrCanceled.
  ///
  /// In zh, this message translates to:
  /// **'转码失败或已取消'**
  String get playerTranscodeFailedOrCanceled;

  /// No description provided for @playerWebpPresetNone.
  ///
  /// In zh, this message translates to:
  /// **'无'**
  String get playerWebpPresetNone;

  /// No description provided for @playerWebpPresetPicture.
  ///
  /// In zh, this message translates to:
  /// **'图片'**
  String get playerWebpPresetPicture;

  /// No description provided for @playerWebpPresetPhoto.
  ///
  /// In zh, this message translates to:
  /// **'照片'**
  String get playerWebpPresetPhoto;

  /// No description provided for @playerWebpPresetDrawing.
  ///
  /// In zh, this message translates to:
  /// **'绘画'**
  String get playerWebpPresetDrawing;

  /// No description provided for @playerWebpPresetIcon.
  ///
  /// In zh, this message translates to:
  /// **'图标'**
  String get playerWebpPresetIcon;

  /// No description provided for @playerWebpPresetText.
  ///
  /// In zh, this message translates to:
  /// **'文字'**
  String get playerWebpPresetText;

  /// No description provided for @playerWebpPresetNoneDescription.
  ///
  /// In zh, this message translates to:
  /// **'不使用预设'**
  String get playerWebpPresetNoneDescription;

  /// No description provided for @playerWebpPresetDefaultDescription.
  ///
  /// In zh, this message translates to:
  /// **'平衡画质与文件大小'**
  String get playerWebpPresetDefaultDescription;

  /// No description provided for @playerWebpPresetPictureDescription.
  ///
  /// In zh, this message translates to:
  /// **'适合一般图片'**
  String get playerWebpPresetPictureDescription;

  /// No description provided for @playerWebpPresetPhotoDescription.
  ///
  /// In zh, this message translates to:
  /// **'适合照片和复杂画面'**
  String get playerWebpPresetPhotoDescription;

  /// No description provided for @playerWebpPresetDrawingDescription.
  ///
  /// In zh, this message translates to:
  /// **'适合绘画和插画'**
  String get playerWebpPresetDrawingDescription;

  /// No description provided for @playerWebpPresetIconDescription.
  ///
  /// In zh, this message translates to:
  /// **'适合图标和小尺寸图形'**
  String get playerWebpPresetIconDescription;

  /// No description provided for @playerWebpPresetTextDescription.
  ///
  /// In zh, this message translates to:
  /// **'适合包含文字的画面'**
  String get playerWebpPresetTextDescription;

  /// No description provided for @playerDanmakuFontSize.
  ///
  /// In zh, this message translates to:
  /// **'弹幕字号'**
  String get playerDanmakuFontSize;

  /// No description provided for @playerDanmakuStyle.
  ///
  /// In zh, this message translates to:
  /// **'弹幕样式'**
  String get playerDanmakuStyle;

  /// No description provided for @playerDanmakuColor.
  ///
  /// In zh, this message translates to:
  /// **'弹幕颜色'**
  String get playerDanmakuColor;

  /// No description provided for @playerDanmakuInputHint.
  ///
  /// In zh, this message translates to:
  /// **'输入弹幕内容'**
  String get playerDanmakuInputHint;

  /// No description provided for @playerNowPlaying.
  ///
  /// In zh, this message translates to:
  /// **'正在播放'**
  String get playerNowPlaying;

  /// No description provided for @playerNowPlayingTitle.
  ///
  /// In zh, this message translates to:
  /// **'正在播放：{title}'**
  String playerNowPlayingTitle(String title);

  /// No description provided for @playerPlayInOrder.
  ///
  /// In zh, this message translates to:
  /// **'顺序播放'**
  String get playerPlayInOrder;

  /// No description provided for @playerPlayInReverse.
  ///
  /// In zh, this message translates to:
  /// **'倒序播放'**
  String get playerPlayInReverse;

  /// No description provided for @playerSkipSegment.
  ///
  /// In zh, this message translates to:
  /// **'跳过：{segment}'**
  String playerSkipSegment(String segment);

  /// No description provided for @playerUploaderDisabledDanmaku.
  ///
  /// In zh, this message translates to:
  /// **'UP 主已关闭弹幕'**
  String get playerUploaderDisabledDanmaku;

  /// No description provided for @playerRewindSeconds.
  ///
  /// In zh, this message translates to:
  /// **'快退 {seconds} 秒'**
  String playerRewindSeconds(int seconds);

  /// No description provided for @playerForwardSeconds.
  ///
  /// In zh, this message translates to:
  /// **'快进 {seconds} 秒'**
  String playerForwardSeconds(int seconds);

  /// No description provided for @playerVideoOpenFailedRetrying.
  ///
  /// In zh, this message translates to:
  /// **'视频链接打开失败，正在重试'**
  String get playerVideoOpenFailedRetrying;

  /// No description provided for @playerDecoderLoadFailed.
  ///
  /// In zh, this message translates to:
  /// **'无法加载解码器：{error}，可能会切换至软解'**
  String playerDecoderLoadFailed(String error);

  /// No description provided for @playerTakingScreenshot.
  ///
  /// In zh, this message translates to:
  /// **'正在截图'**
  String get playerTakingScreenshot;

  /// No description provided for @playerTapPreviewToSaveScreenshot.
  ///
  /// In zh, this message translates to:
  /// **'点击预览图保存截图'**
  String get playerTapPreviewToSaveScreenshot;

  /// No description provided for @playerScreenshotFailed.
  ///
  /// In zh, this message translates to:
  /// **'截图失败'**
  String get playerScreenshotFailed;

  /// No description provided for @replyPostComment.
  ///
  /// In zh, this message translates to:
  /// **'发表评论'**
  String get replyPostComment;

  /// No description provided for @replyNoCommentsYet.
  ///
  /// In zh, this message translates to:
  /// **'还没有评论'**
  String get replyNoCommentsYet;

  /// No description provided for @replyInputHint.
  ///
  /// In zh, this message translates to:
  /// **'友善发言的人运气不会太差'**
  String get replyInputHint;

  /// No description provided for @replyImagesNotSupported.
  ///
  /// In zh, this message translates to:
  /// **'当前评论区不支持图片'**
  String get replyImagesNotSupported;

  /// No description provided for @replyAlsoPostToFeed.
  ///
  /// In zh, this message translates to:
  /// **'同时转发到动态'**
  String get replyAlsoPostToFeed;

  /// No description provided for @replyInsertContent.
  ///
  /// In zh, this message translates to:
  /// **'插入内容'**
  String get replyInsertContent;

  /// No description provided for @replyVideoProgress.
  ///
  /// In zh, this message translates to:
  /// **'视频进度'**
  String get replyVideoProgress;

  /// No description provided for @replyMaxImages.
  ///
  /// In zh, this message translates to:
  /// **'{limit, plural, other{最多可添加 {limit} 张图片}}'**
  String replyMaxImages(int limit);

  /// No description provided for @replyVideoScreenshot.
  ///
  /// In zh, this message translates to:
  /// **'视频截图'**
  String get replyVideoScreenshot;

  /// No description provided for @replyVoteRedSide.
  ///
  /// In zh, this message translates to:
  /// **'红方'**
  String get replyVoteRedSide;

  /// No description provided for @replyVoteBlueSide.
  ///
  /// In zh, this message translates to:
  /// **'蓝方'**
  String get replyVoteBlueSide;

  /// No description provided for @replyVoteParticipants.
  ///
  /// In zh, this message translates to:
  /// **'{count} 人参与'**
  String replyVoteParticipants(String count);

  /// No description provided for @replyTranslationEmpty.
  ///
  /// In zh, this message translates to:
  /// **'翻译结果为空'**
  String get replyTranslationEmpty;

  /// No description provided for @replyTranslationFailed.
  ///
  /// In zh, this message translates to:
  /// **'翻译失败：{error}'**
  String replyTranslationFailed(String error);

  /// No description provided for @replyViewConversation.
  ///
  /// In zh, this message translates to:
  /// **'查看对话'**
  String get replyViewConversation;

  /// No description provided for @replyJumpToReply.
  ///
  /// In zh, this message translates to:
  /// **'跳转回复'**
  String get replyJumpToReply;

  /// No description provided for @replyUploaderAndOthers.
  ///
  /// In zh, this message translates to:
  /// **'UP 主等人'**
  String get replyUploaderAndOthers;

  /// No description provided for @replyCount.
  ///
  /// In zh, this message translates to:
  /// **'{count, plural, =0{暂无回复} other{共 {count} 条回复}}'**
  String replyCount(int count);

  /// No description provided for @replyVoteTitle.
  ///
  /// In zh, this message translates to:
  /// **'投票：{title}'**
  String replyVoteTitle(String title);

  /// No description provided for @replyJumpTo.
  ///
  /// In zh, this message translates to:
  /// **'跳转至：{time}'**
  String replyJumpTo(String time);

  /// No description provided for @replyJumpFailed.
  ///
  /// In zh, this message translates to:
  /// **'跳转失败：{error}'**
  String replyJumpFailed(String error);

  /// No description provided for @replyDeleteComment.
  ///
  /// In zh, this message translates to:
  /// **'删除评论'**
  String get replyDeleteComment;

  /// No description provided for @replyConfirmDeleteComment.
  ///
  /// In zh, this message translates to:
  /// **'确定删除这条评论吗？'**
  String get replyConfirmDeleteComment;

  /// No description provided for @replyCopyAll.
  ///
  /// In zh, this message translates to:
  /// **'复制全部'**
  String get replyCopyAll;

  /// No description provided for @replyCopySelection.
  ///
  /// In zh, this message translates to:
  /// **'自由复制'**
  String get replyCopySelection;

  /// No description provided for @replySaveComment.
  ///
  /// In zh, this message translates to:
  /// **'保存评论'**
  String get replySaveComment;

  /// No description provided for @replyCheckComment.
  ///
  /// In zh, this message translates to:
  /// **'检查评论'**
  String get replyCheckComment;

  /// No description provided for @replyDetails.
  ///
  /// In zh, this message translates to:
  /// **'评论详情'**
  String get replyDetails;

  /// No description provided for @replyConversation.
  ///
  /// In zh, this message translates to:
  /// **'对话列表'**
  String get replyConversation;

  /// No description provided for @replyRelatedCount.
  ///
  /// In zh, this message translates to:
  /// **'相关回复共 {count} 条'**
  String replyRelatedCount(String count);

  /// No description provided for @replyMayHaveBeenDeleted.
  ///
  /// In zh, this message translates to:
  /// **'评论可能已被删除'**
  String get replyMayHaveBeenDeleted;

  /// No description provided for @replyDislikeSucceeded.
  ///
  /// In zh, this message translates to:
  /// **'点踩成功'**
  String get replyDislikeSucceeded;

  /// No description provided for @replyRemoveDislikeSucceeded.
  ///
  /// In zh, this message translates to:
  /// **'已取消踩'**
  String get replyRemoveDislikeSucceeded;

  /// No description provided for @replyLikeSucceeded.
  ///
  /// In zh, this message translates to:
  /// **'点赞成功'**
  String get replyLikeSucceeded;

  /// No description provided for @replyUnlikeSucceeded.
  ///
  /// In zh, this message translates to:
  /// **'已取消赞'**
  String get replyUnlikeSucceeded;

  /// No description provided for @reportChooseReason.
  ///
  /// In zh, this message translates to:
  /// **'请选择举报理由：'**
  String get reportChooseReason;

  /// No description provided for @reportDetailsHint.
  ///
  /// In zh, this message translates to:
  /// **'为帮助审核人员更快处理，请补充问题类型、出现位置等详细信息'**
  String get reportDetailsHint;

  /// No description provided for @reportReasonRequired.
  ///
  /// In zh, this message translates to:
  /// **'理由不能为空'**
  String get reportReasonRequired;

  /// No description provided for @reportBlockUser.
  ///
  /// In zh, this message translates to:
  /// **'拉黑该用户'**
  String get reportBlockUser;

  /// No description provided for @reportSucceeded.
  ///
  /// In zh, this message translates to:
  /// **'举报成功'**
  String get reportSucceeded;

  /// No description provided for @reportGroupIllegal.
  ///
  /// In zh, this message translates to:
  /// **'违反法律法规'**
  String get reportGroupIllegal;

  /// No description provided for @reportGroupMisinformation.
  ///
  /// In zh, this message translates to:
  /// **'谣言类不实信息'**
  String get reportGroupMisinformation;

  /// No description provided for @reportGroupPersonalRights.
  ///
  /// In zh, this message translates to:
  /// **'侵犯个人权益'**
  String get reportGroupPersonalRights;

  /// No description provided for @reportGroupCommunity.
  ///
  /// In zh, this message translates to:
  /// **'有害社区环境'**
  String get reportGroupCommunity;

  /// No description provided for @reportIllegal.
  ///
  /// In zh, this message translates to:
  /// **'违法违规'**
  String get reportIllegal;

  /// No description provided for @reportPornography.
  ///
  /// In zh, this message translates to:
  /// **'色情'**
  String get reportPornography;

  /// No description provided for @reportVulgar.
  ///
  /// In zh, this message translates to:
  /// **'低俗'**
  String get reportVulgar;

  /// No description provided for @reportGamblingOrScam.
  ///
  /// In zh, this message translates to:
  /// **'赌博诈骗'**
  String get reportGamblingOrScam;

  /// No description provided for @reportIllegalExternalLink.
  ///
  /// In zh, this message translates to:
  /// **'违法信息外链'**
  String get reportIllegalExternalLink;

  /// No description provided for @reportPoliticalRumor.
  ///
  /// In zh, this message translates to:
  /// **'涉政谣言'**
  String get reportPoliticalRumor;

  /// No description provided for @reportMisinformation.
  ///
  /// In zh, this message translates to:
  /// **'虚假不实信息'**
  String get reportMisinformation;

  /// No description provided for @reportSocialEventRumor.
  ///
  /// In zh, this message translates to:
  /// **'涉社会事件谣言'**
  String get reportSocialEventRumor;

  /// No description provided for @reportPersonalAttack.
  ///
  /// In zh, this message translates to:
  /// **'人身攻击'**
  String get reportPersonalAttack;

  /// No description provided for @reportPrivacyViolation.
  ///
  /// In zh, this message translates to:
  /// **'侵犯隐私'**
  String get reportPrivacyViolation;

  /// No description provided for @reportSpam.
  ///
  /// In zh, this message translates to:
  /// **'垃圾广告'**
  String get reportSpam;

  /// No description provided for @reportProvocation.
  ///
  /// In zh, this message translates to:
  /// **'引战'**
  String get reportProvocation;

  /// No description provided for @reportSpoiler.
  ///
  /// In zh, this message translates to:
  /// **'剧透'**
  String get reportSpoiler;

  /// No description provided for @reportFlooding.
  ///
  /// In zh, this message translates to:
  /// **'恶意刷屏'**
  String get reportFlooding;

  /// No description provided for @reportIrrelevant.
  ///
  /// In zh, this message translates to:
  /// **'与视频无关'**
  String get reportIrrelevant;

  /// No description provided for @reportIllegalLottery.
  ///
  /// In zh, this message translates to:
  /// **'违规抽奖'**
  String get reportIllegalLottery;

  /// No description provided for @reportHarmfulToMinors.
  ///
  /// In zh, this message translates to:
  /// **'青少年不良信息'**
  String get reportHarmfulToMinors;

  /// No description provided for @reportIllegalOrHarmful.
  ///
  /// In zh, this message translates to:
  /// **'违法有害信息'**
  String get reportIllegalOrHarmful;

  /// No description provided for @reportPornographicOrVulgar.
  ///
  /// In zh, this message translates to:
  /// **'色情低俗'**
  String get reportPornographicOrVulgar;

  /// No description provided for @reportAbuseOrProvocation.
  ///
  /// In zh, this message translates to:
  /// **'辱骂引战'**
  String get reportAbuseOrProvocation;

  /// No description provided for @reportPoliticallySensitive.
  ///
  /// In zh, this message translates to:
  /// **'政治敏感'**
  String get reportPoliticallySensitive;

  /// No description provided for @reportAdHarassment.
  ///
  /// In zh, this message translates to:
  /// **'广告骚扰'**
  String get reportAdHarassment;

  /// No description provided for @reportScam.
  ///
  /// In zh, this message translates to:
  /// **'诈骗'**
  String get reportScam;

  /// No description provided for @sponsorBlockActionSkip.
  ///
  /// In zh, this message translates to:
  /// **'跳过'**
  String get sponsorBlockActionSkip;

  /// No description provided for @sponsorBlockActionMute.
  ///
  /// In zh, this message translates to:
  /// **'静音'**
  String get sponsorBlockActionMute;

  /// No description provided for @sponsorBlockActionFullVideo.
  ///
  /// In zh, this message translates to:
  /// **'整个视频'**
  String get sponsorBlockActionFullVideo;

  /// No description provided for @sponsorBlockActionHighlight.
  ///
  /// In zh, this message translates to:
  /// **'精彩时刻'**
  String get sponsorBlockActionHighlight;

  /// No description provided for @sponsorBlockAlwaysSkip.
  ///
  /// In zh, this message translates to:
  /// **'总是跳过'**
  String get sponsorBlockAlwaysSkip;

  /// No description provided for @sponsorBlockSkipOnce.
  ///
  /// In zh, this message translates to:
  /// **'跳过一次'**
  String get sponsorBlockSkipOnce;

  /// No description provided for @sponsorBlockManualSkip.
  ///
  /// In zh, this message translates to:
  /// **'手动跳过'**
  String get sponsorBlockManualSkip;

  /// No description provided for @sponsorBlockShowOnly.
  ///
  /// In zh, this message translates to:
  /// **'仅显示'**
  String get sponsorBlockShowOnly;

  /// No description provided for @sponsorBlockCategorySponsor.
  ///
  /// In zh, this message translates to:
  /// **'赞助／恰饭'**
  String get sponsorBlockCategorySponsor;

  /// No description provided for @sponsorBlockCategorySponsorShort.
  ///
  /// In zh, this message translates to:
  /// **'赞助'**
  String get sponsorBlockCategorySponsorShort;

  /// No description provided for @sponsorBlockCategorySelfPromotion.
  ///
  /// In zh, this message translates to:
  /// **'无偿／自我推广'**
  String get sponsorBlockCategorySelfPromotion;

  /// No description provided for @sponsorBlockCategorySelfPromotionShort.
  ///
  /// In zh, this message translates to:
  /// **'推广'**
  String get sponsorBlockCategorySelfPromotionShort;

  /// No description provided for @sponsorBlockCategoryExclusiveAccess.
  ///
  /// In zh, this message translates to:
  /// **'独家访问／抢先体验'**
  String get sponsorBlockCategoryExclusiveAccess;

  /// No description provided for @sponsorBlockCategoryExclusiveAccessShort.
  ///
  /// In zh, this message translates to:
  /// **'品牌合作'**
  String get sponsorBlockCategoryExclusiveAccessShort;

  /// No description provided for @sponsorBlockCategoryInteraction.
  ///
  /// In zh, this message translates to:
  /// **'三连／互动提醒'**
  String get sponsorBlockCategoryInteraction;

  /// No description provided for @sponsorBlockCategoryInteractionShort.
  ///
  /// In zh, this message translates to:
  /// **'三连提醒'**
  String get sponsorBlockCategoryInteractionShort;

  /// No description provided for @sponsorBlockCategoryHighlight.
  ///
  /// In zh, this message translates to:
  /// **'精彩时刻／重点'**
  String get sponsorBlockCategoryHighlight;

  /// No description provided for @sponsorBlockCategoryHighlightShort.
  ///
  /// In zh, this message translates to:
  /// **'精彩时刻'**
  String get sponsorBlockCategoryHighlightShort;

  /// No description provided for @sponsorBlockCategoryIntro.
  ///
  /// In zh, this message translates to:
  /// **'过场／开场动画'**
  String get sponsorBlockCategoryIntro;

  /// No description provided for @sponsorBlockCategoryIntroShort.
  ///
  /// In zh, this message translates to:
  /// **'开场动画'**
  String get sponsorBlockCategoryIntroShort;

  /// No description provided for @sponsorBlockCategoryOutro.
  ///
  /// In zh, this message translates to:
  /// **'鸣谢／结束画面'**
  String get sponsorBlockCategoryOutro;

  /// No description provided for @sponsorBlockCategoryOutroShort.
  ///
  /// In zh, this message translates to:
  /// **'片尾'**
  String get sponsorBlockCategoryOutroShort;

  /// No description provided for @sponsorBlockCategoryPreview.
  ///
  /// In zh, this message translates to:
  /// **'回顾／概要'**
  String get sponsorBlockCategoryPreview;

  /// No description provided for @sponsorBlockCategoryPreviewShort.
  ///
  /// In zh, this message translates to:
  /// **'预览'**
  String get sponsorBlockCategoryPreviewShort;

  /// No description provided for @sponsorBlockCategoryPadding.
  ///
  /// In zh, this message translates to:
  /// **'填充内容／前黑／后黑'**
  String get sponsorBlockCategoryPadding;

  /// No description provided for @sponsorBlockCategoryPaddingShort.
  ///
  /// In zh, this message translates to:
  /// **'填充内容'**
  String get sponsorBlockCategoryPaddingShort;

  /// No description provided for @sponsorBlockCategoryFiller.
  ///
  /// In zh, this message translates to:
  /// **'离题闲聊／玩笑'**
  String get sponsorBlockCategoryFiller;

  /// No description provided for @sponsorBlockCategoryFillerShort.
  ///
  /// In zh, this message translates to:
  /// **'离题'**
  String get sponsorBlockCategoryFillerShort;

  /// No description provided for @sponsorBlockCategoryMusicOfftopic.
  ///
  /// In zh, this message translates to:
  /// **'音乐：非音乐部分'**
  String get sponsorBlockCategoryMusicOfftopic;

  /// No description provided for @sponsorBlockCategoryMusicOfftopicShort.
  ///
  /// In zh, this message translates to:
  /// **'非音乐'**
  String get sponsorBlockCategoryMusicOfftopicShort;

  /// No description provided for @sponsorBlockSkipped.
  ///
  /// In zh, this message translates to:
  /// **'已跳过{segment}片段'**
  String sponsorBlockSkipped(String segment);

  /// No description provided for @sponsorBlockJumpedTo.
  ///
  /// In zh, this message translates to:
  /// **'已跳至{segment}'**
  String sponsorBlockJumpedTo(String segment);

  /// No description provided for @sponsorBlockSkipFailed.
  ///
  /// In zh, this message translates to:
  /// **'{segment}片段跳过失败'**
  String sponsorBlockSkipFailed(String segment);

  /// No description provided for @sponsorBlockUpvote.
  ///
  /// In zh, this message translates to:
  /// **'赞成票'**
  String get sponsorBlockUpvote;

  /// No description provided for @sponsorBlockDownvote.
  ///
  /// In zh, this message translates to:
  /// **'反对票'**
  String get sponsorBlockDownvote;

  /// No description provided for @sponsorBlockChangeCategory.
  ///
  /// In zh, this message translates to:
  /// **'更改类别'**
  String get sponsorBlockChangeCategory;

  /// No description provided for @sponsorBlockVoteSucceeded.
  ///
  /// In zh, this message translates to:
  /// **'投票成功'**
  String get sponsorBlockVoteSucceeded;

  /// No description provided for @sponsorBlockVoteFailed.
  ///
  /// In zh, this message translates to:
  /// **'投票失败：{error}'**
  String sponsorBlockVoteFailed(String error);

  /// No description provided for @sponsorBlockCategoryChangeSucceeded.
  ///
  /// In zh, this message translates to:
  /// **'类别更改成功'**
  String get sponsorBlockCategoryChangeSucceeded;

  /// No description provided for @sponsorBlockCategoryChangeFailed.
  ///
  /// In zh, this message translates to:
  /// **'类别更改失败：{error}'**
  String sponsorBlockCategoryChangeFailed(String error);

  /// No description provided for @sponsorBlockSegmentRange.
  ///
  /// In zh, this message translates to:
  /// **'{start} 至 {end}'**
  String sponsorBlockSegmentRange(String start, String end);

  /// No description provided for @sponsorBlockJumpToSegment.
  ///
  /// In zh, this message translates to:
  /// **'跳至此片段'**
  String get sponsorBlockJumpToSegment;

  /// No description provided for @sponsorBlockSkipSegment.
  ///
  /// In zh, this message translates to:
  /// **'跳过此片段'**
  String get sponsorBlockSkipSegment;

  /// No description provided for @videoPlayNow.
  ///
  /// In zh, this message translates to:
  /// **'立即播放'**
  String get videoPlayNow;

  /// No description provided for @videoReplay.
  ///
  /// In zh, this message translates to:
  /// **'重新播放'**
  String get videoReplay;

  /// No description provided for @videoResumePlayback.
  ///
  /// In zh, this message translates to:
  /// **'继续播放'**
  String get videoResumePlayback;

  /// No description provided for @videoBackToHome.
  ///
  /// In zh, this message translates to:
  /// **'返回首页'**
  String get videoBackToHome;

  /// No description provided for @videoRelatedVideos.
  ///
  /// In zh, this message translates to:
  /// **'相关视频'**
  String get videoRelatedVideos;

  /// No description provided for @videoViewNotes.
  ///
  /// In zh, this message translates to:
  /// **'查看笔记'**
  String get videoViewNotes;

  /// No description provided for @videoDownload.
  ///
  /// In zh, this message translates to:
  /// **'下载'**
  String get videoDownload;

  /// No description provided for @videoSaveCover.
  ///
  /// In zh, this message translates to:
  /// **'保存封面'**
  String get videoSaveCover;

  /// No description provided for @videoListenToAudio.
  ///
  /// In zh, this message translates to:
  /// **'听视频'**
  String get videoListenToAudio;

  /// No description provided for @videoOfflineVideo.
  ///
  /// In zh, this message translates to:
  /// **'离线视频'**
  String get videoOfflineVideo;

  /// No description provided for @videoDescription.
  ///
  /// In zh, this message translates to:
  /// **'简介'**
  String get videoDescription;

  /// No description provided for @videoComments.
  ///
  /// In zh, this message translates to:
  /// **'评论'**
  String get videoComments;

  /// No description provided for @videoPlaylist.
  ///
  /// In zh, this message translates to:
  /// **'播放列表'**
  String get videoPlaylist;

  /// No description provided for @videoCommentsCount.
  ///
  /// In zh, this message translates to:
  /// **'评论 {count}'**
  String videoCommentsCount(String count);

  /// No description provided for @videoSendDanmaku.
  ///
  /// In zh, this message translates to:
  /// **'发送弹幕'**
  String get videoSendDanmaku;

  /// No description provided for @videoSeriesReverseNotSupported.
  ///
  /// In zh, this message translates to:
  /// **'当前系列不支持倒序播放'**
  String get videoSeriesReverseNotSupported;

  /// No description provided for @videoLikeSucceeded.
  ///
  /// In zh, this message translates to:
  /// **'点赞成功'**
  String get videoLikeSucceeded;

  /// No description provided for @videoUnlikeSucceeded.
  ///
  /// In zh, this message translates to:
  /// **'已取消点赞'**
  String get videoUnlikeSucceeded;

  /// No description provided for @videoAddToWatchLater.
  ///
  /// In zh, this message translates to:
  /// **'添加到稍后再看'**
  String get videoAddToWatchLater;

  /// No description provided for @videoCoin.
  ///
  /// In zh, this message translates to:
  /// **'投币'**
  String get videoCoin;

  /// No description provided for @videoSupporterOnly.
  ///
  /// In zh, this message translates to:
  /// **'充电专属'**
  String get videoSupporterOnly;

  /// No description provided for @videoInteractive.
  ///
  /// In zh, this message translates to:
  /// **'互动视频'**
  String get videoInteractive;

  /// No description provided for @videoSponsorBlockSourceSync.
  ///
  /// In zh, this message translates to:
  /// **'同步 SponsorBlock 视频来源'**
  String get videoSponsorBlockSourceSync;

  /// No description provided for @videoSponsorBlockAlreadyLinked.
  ///
  /// In zh, this message translates to:
  /// **'已关联 YouTube 视频 {videoId}'**
  String videoSponsorBlockAlreadyLinked(String videoId);

  /// No description provided for @videoSponsorBlockConfirmLink.
  ///
  /// In zh, this message translates to:
  /// **'确认将本视频关联到 YouTube 视频 {videoId}？'**
  String videoSponsorBlockConfirmLink(String videoId);

  /// No description provided for @videoSponsorBlockLinkSucceeded.
  ///
  /// In zh, this message translates to:
  /// **'来源关联成功'**
  String get videoSponsorBlockLinkSucceeded;

  /// No description provided for @videoSponsorBlockLinkFailed.
  ///
  /// In zh, this message translates to:
  /// **'来源关联失败：{error}'**
  String videoSponsorBlockLinkFailed(String error);

  /// No description provided for @videoAiSummaryNotSupported.
  ///
  /// In zh, this message translates to:
  /// **'当前视频暂不支持 AI 总结'**
  String get videoAiSummaryNotSupported;

  /// No description provided for @videoAiSummary.
  ///
  /// In zh, this message translates to:
  /// **'AI 总结'**
  String get videoAiSummary;

  /// No description provided for @videoBgmPrefix.
  ///
  /// In zh, this message translates to:
  /// **'BGM：{content}'**
  String videoBgmPrefix(String content);

  /// No description provided for @videoGreatCoined.
  ///
  /// In zh, this message translates to:
  /// **'已完成 Great Coined'**
  String get videoGreatCoined;

  /// No description provided for @videoCoinFailed.
  ///
  /// In zh, this message translates to:
  /// **'投币失败'**
  String get videoCoinFailed;

  /// No description provided for @videoGreatCoinedSucceeded.
  ///
  /// In zh, this message translates to:
  /// **'Great Coined 成功'**
  String get videoGreatCoinedSucceeded;

  /// No description provided for @videoDislikeSucceeded.
  ///
  /// In zh, this message translates to:
  /// **'点踩成功'**
  String get videoDislikeSucceeded;

  /// No description provided for @videoRemoveDislikeSucceeded.
  ///
  /// In zh, this message translates to:
  /// **'已取消踩'**
  String get videoRemoveDislikeSucceeded;

  /// No description provided for @videoShareAtCurrentTime.
  ///
  /// In zh, this message translates to:
  /// **'从当前时间开始分享'**
  String get videoShareAtCurrentTime;

  /// No description provided for @videoShareVideo.
  ///
  /// In zh, this message translates to:
  /// **'分享视频'**
  String get videoShareVideo;

  /// No description provided for @videoShareText.
  ///
  /// In zh, this message translates to:
  /// **'{title}\nUP 主：{uploader}\n{url}'**
  String videoShareText(String title, String uploader, String url);

  /// No description provided for @videoShareToFeed.
  ///
  /// In zh, this message translates to:
  /// **'分享到动态'**
  String get videoShareToFeed;

  /// No description provided for @videoShareToMessages.
  ///
  /// In zh, this message translates to:
  /// **'分享到消息'**
  String get videoShareToMessages;

  /// No description provided for @videoNoRelatedVideosStopAutoplay.
  ///
  /// In zh, this message translates to:
  /// **'没有更多相关视频，已停止自动播放'**
  String get videoNoRelatedVideosStopAutoplay;

  /// No description provided for @videoLoadingAiSummary.
  ///
  /// In zh, this message translates to:
  /// **'正在加载 AI 总结…'**
  String get videoLoadingAiSummary;

  /// No description provided for @videoAiProcessing.
  ///
  /// In zh, this message translates to:
  /// **'AI 总结正在生成，请稍后再试'**
  String get videoAiProcessing;

  /// No description provided for @videoFollowAnime.
  ///
  /// In zh, this message translates to:
  /// **'追番'**
  String get videoFollowAnime;

  /// No description provided for @videoFollowSeries.
  ///
  /// In zh, this message translates to:
  /// **'追剧'**
  String get videoFollowSeries;

  /// No description provided for @videoRating.
  ///
  /// In zh, this message translates to:
  /// **'评分 {score}'**
  String videoRating(String score);

  /// No description provided for @videoAlreadyFollowing.
  ///
  /// In zh, this message translates to:
  /// **'已{type}'**
  String videoAlreadyFollowing(String type);

  /// No description provided for @videoDescriptionWithContent.
  ///
  /// In zh, this message translates to:
  /// **'简介：{description}'**
  String videoDescriptionWithContent(String description);

  /// No description provided for @videoRemovedFromFavorites.
  ///
  /// In zh, this message translates to:
  /// **'已取消收藏'**
  String get videoRemovedFromFavorites;

  /// No description provided for @videoAddedToFavorites.
  ///
  /// In zh, this message translates to:
  /// **'已收藏'**
  String get videoAddedToFavorites;

  /// No description provided for @videoMarkAs.
  ///
  /// In zh, this message translates to:
  /// **'标记为{status}'**
  String videoMarkAs(String status);

  /// No description provided for @videoStatusWatched.
  ///
  /// In zh, this message translates to:
  /// **'看过'**
  String get videoStatusWatched;

  /// No description provided for @videoStatusWatching.
  ///
  /// In zh, this message translates to:
  /// **'在看'**
  String get videoStatusWatching;

  /// No description provided for @videoStatusWantToWatch.
  ///
  /// In zh, this message translates to:
  /// **'想看'**
  String get videoStatusWantToWatch;

  /// No description provided for @videoCancelFollowingType.
  ///
  /// In zh, this message translates to:
  /// **'取消{type}'**
  String videoCancelFollowingType(String type);

  /// No description provided for @videoSegmentStart.
  ///
  /// In zh, this message translates to:
  /// **'开始：{value}'**
  String videoSegmentStart(String value);

  /// No description provided for @videoSegmentEnd.
  ///
  /// In zh, this message translates to:
  /// **'结束：{value}'**
  String videoSegmentEnd(String value);

  /// No description provided for @videoSegmentSetCurrent.
  ///
  /// In zh, this message translates to:
  /// **'设为当前'**
  String get videoSegmentSetCurrent;

  /// No description provided for @videoSegmentVideoStart.
  ///
  /// In zh, this message translates to:
  /// **'视频开头'**
  String get videoSegmentVideoStart;

  /// No description provided for @videoSegmentVideoEnd.
  ///
  /// In zh, this message translates to:
  /// **'视频结尾'**
  String get videoSegmentVideoEnd;

  /// No description provided for @videoSegmentAdd.
  ///
  /// In zh, this message translates to:
  /// **'添加片段'**
  String get videoSegmentAdd;

  /// No description provided for @videoSegmentConfirmBeforeSubmit.
  ///
  /// In zh, this message translates to:
  /// **'确认无误后再提交'**
  String get videoSegmentConfirmBeforeSubmit;

  /// No description provided for @videoSegmentConfirmSubmit.
  ///
  /// In zh, this message translates to:
  /// **'确定提交'**
  String get videoSegmentConfirmSubmit;

  /// No description provided for @videoSegmentCategory.
  ///
  /// In zh, this message translates to:
  /// **'分类'**
  String get videoSegmentCategory;

  /// No description provided for @videoSegmentAction.
  ///
  /// In zh, this message translates to:
  /// **'行为类别'**
  String get videoSegmentAction;

  /// No description provided for @videoSegmentProgressBar.
  ///
  /// In zh, this message translates to:
  /// **'分段进度条'**
  String get videoSegmentProgressBar;

  /// No description provided for @videoResumeAtPart.
  ///
  /// In zh, this message translates to:
  /// **'上次看到第 {part}P，点击跳转'**
  String videoResumeAtPart(int part);

  /// No description provided for @videoJumpedToPart.
  ///
  /// In zh, this message translates to:
  /// **'已跳至第 {part}P'**
  String videoJumpedToPart(int part);

  /// No description provided for @videoExclusiveTrial.
  ///
  /// In zh, this message translates to:
  /// **'该视频为专属视频，仅提供试看'**
  String get videoExclusiveTrial;

  /// No description provided for @videoResourceUnavailable.
  ///
  /// In zh, this message translates to:
  /// **'视频资源不存在'**
  String get videoResourceUnavailable;

  /// No description provided for @videoCoinLimitReached.
  ///
  /// In zh, this message translates to:
  /// **'已达到投币上限'**
  String get videoCoinLimitReached;

  /// No description provided for @videoNotEnoughCoins.
  ///
  /// In zh, this message translates to:
  /// **'硬币不足'**
  String get videoNotEnoughCoins;

  /// No description provided for @videoCoinBalance.
  ///
  /// In zh, this message translates to:
  /// **'硬币余额：{balance}'**
  String videoCoinBalance(String balance);

  /// No description provided for @videoAlreadyCoinedOne.
  ///
  /// In zh, this message translates to:
  /// **'已投 1 枚硬币'**
  String get videoAlreadyCoinedOne;

  /// No description provided for @videoCoinBalanceAndCoined.
  ///
  /// In zh, this message translates to:
  /// **'硬币余额：{balance}，已投 1 枚硬币'**
  String videoCoinBalanceAndCoined(String balance);

  /// No description provided for @videoCoinAndLike.
  ///
  /// In zh, this message translates to:
  /// **'同时点赞'**
  String get videoCoinAndLike;

  /// No description provided for @videoEpisodes.
  ///
  /// In zh, this message translates to:
  /// **'视频选集'**
  String get videoEpisodes;

  /// No description provided for @videoEpisodeCount.
  ///
  /// In zh, this message translates to:
  /// **'{count, plural, other{共 {count} 集}}'**
  String videoEpisodeCount(int count);

  /// No description provided for @videoCollection.
  ///
  /// In zh, this message translates to:
  /// **'合集：{title}'**
  String videoCollection(String title);

  /// No description provided for @videoCollectionLabel.
  ///
  /// In zh, this message translates to:
  /// **'合集'**
  String get videoCollectionLabel;

  /// No description provided for @videoEpisodePosition.
  ///
  /// In zh, this message translates to:
  /// **'第 {current} 集，共 {total} 集'**
  String videoEpisodePosition(int current, int total);

  /// No description provided for @videoOngoingUpdatedTo.
  ///
  /// In zh, this message translates to:
  /// **'连载中，更新至{episode}'**
  String videoOngoingUpdatedTo(String episode);

  /// No description provided for @videoEpisodeNumber.
  ///
  /// In zh, this message translates to:
  /// **'第 {number} 话'**
  String videoEpisodeNumber(int number);

  /// No description provided for @videoReviews.
  ///
  /// In zh, this message translates to:
  /// **'点评'**
  String get videoReviews;

  /// No description provided for @videoSummary.
  ///
  /// In zh, this message translates to:
  /// **'简介'**
  String get videoSummary;

  /// No description provided for @videoCastAndCrew.
  ///
  /// In zh, this message translates to:
  /// **'演职人员'**
  String get videoCastAndCrew;

  /// No description provided for @videoCount.
  ///
  /// In zh, this message translates to:
  /// **'{count, plural, other{共 {count} 个视频}}'**
  String videoCount(int count);

  /// No description provided for @videoTypePlaybackNotSupported.
  ///
  /// In zh, this message translates to:
  /// **'不支持播放该类型视频'**
  String get videoTypePlaybackNotSupported;

  /// No description provided for @videoConfirmRemove.
  ///
  /// In zh, this message translates to:
  /// **'确定移除该视频？'**
  String get videoConfirmRemove;

  /// No description provided for @videoNotesCount.
  ///
  /// In zh, this message translates to:
  /// **'笔记（{count}）'**
  String videoNotesCount(int count);

  /// No description provided for @videoStartTakingNotes.
  ///
  /// In zh, this message translates to:
  /// **'开始记笔记'**
  String get videoStartTakingNotes;

  /// No description provided for @videoVisitUploader.
  ///
  /// In zh, this message translates to:
  /// **'访问：{name}'**
  String videoVisitUploader(String name);

  /// No description provided for @videoNotInterested.
  ///
  /// In zh, this message translates to:
  /// **'不感兴趣'**
  String get videoNotInterested;

  /// No description provided for @videoDoNotWantToSee.
  ///
  /// In zh, this message translates to:
  /// **'我不想看'**
  String get videoDoNotWantToSee;

  /// No description provided for @videoWebFineSelectionUnsupported.
  ///
  /// In zh, this message translates to:
  /// **'Web 端暂不支持精细选择'**
  String get videoWebFineSelectionUnsupported;

  /// No description provided for @videoBlockUploader.
  ///
  /// In zh, this message translates to:
  /// **'拉黑：{name}'**
  String videoBlockUploader(String name);

  /// No description provided for @videoConfirmBlockUploader.
  ///
  /// In zh, this message translates to:
  /// **'确定拉黑 {name}（{id}）？\n\n被拉黑的 UP 主可在隐私设置的黑名单管理中解除。'**
  String videoConfirmBlockUploader(String name, String id);

  /// No description provided for @timeJustNow.
  ///
  /// In zh, this message translates to:
  /// **'刚刚'**
  String get timeJustNow;

  /// No description provided for @timeMinutesAgo.
  ///
  /// In zh, this message translates to:
  /// **'{count} 分钟前'**
  String timeMinutesAgo(int count);

  /// No description provided for @timeHoursAgo.
  ///
  /// In zh, this message translates to:
  /// **'{count} 小时前'**
  String timeHoursAgo(int count);

  /// No description provided for @timeYesterdayAt.
  ///
  /// In zh, this message translates to:
  /// **'昨天 {time}'**
  String timeYesterdayAt(String time);

  /// No description provided for @timeDaysAgo.
  ///
  /// In zh, this message translates to:
  /// **'{count} 天前'**
  String timeDaysAgo(int count);

  /// No description provided for @durationYears.
  ///
  /// In zh, this message translates to:
  /// **'{count}年'**
  String durationYears(int count);

  /// No description provided for @durationMonths.
  ///
  /// In zh, this message translates to:
  /// **'{count}个月'**
  String durationMonths(int count);

  /// No description provided for @durationDays.
  ///
  /// In zh, this message translates to:
  /// **'{count}天'**
  String durationDays(int count);

  /// No description provided for @durationHours.
  ///
  /// In zh, this message translates to:
  /// **'{count}小时'**
  String durationHours(int count);

  /// No description provided for @durationMinutes.
  ///
  /// In zh, this message translates to:
  /// **'{count}分钟'**
  String durationMinutes(int count);

  /// No description provided for @timeTodayAt.
  ///
  /// In zh, this message translates to:
  /// **'今天 {time}'**
  String timeTodayAt(String time);

  /// No description provided for @weekdayMondayShort.
  ///
  /// In zh, this message translates to:
  /// **'一'**
  String get weekdayMondayShort;

  /// No description provided for @weekdayTuesdayShort.
  ///
  /// In zh, this message translates to:
  /// **'二'**
  String get weekdayTuesdayShort;

  /// No description provided for @weekdayWednesdayShort.
  ///
  /// In zh, this message translates to:
  /// **'三'**
  String get weekdayWednesdayShort;

  /// No description provided for @weekdayThursdayShort.
  ///
  /// In zh, this message translates to:
  /// **'四'**
  String get weekdayThursdayShort;

  /// No description provided for @weekdayFridayShort.
  ///
  /// In zh, this message translates to:
  /// **'五'**
  String get weekdayFridayShort;

  /// No description provided for @weekdaySaturdayShort.
  ///
  /// In zh, this message translates to:
  /// **'六'**
  String get weekdaySaturdayShort;

  /// No description provided for @weekdaySundayShort.
  ///
  /// In zh, this message translates to:
  /// **'日'**
  String get weekdaySundayShort;

  /// No description provided for @homePgcSchedule.
  ///
  /// In zh, this message translates to:
  /// **'追番时间表'**
  String get homePgcSchedule;

  /// No description provided for @homeToday.
  ///
  /// In zh, this message translates to:
  /// **'今天'**
  String get homeToday;

  /// No description provided for @homeWeekday.
  ///
  /// In zh, this message translates to:
  /// **'周{weekday}'**
  String homeWeekday(String weekday);

  /// No description provided for @homeRecommendations.
  ///
  /// In zh, this message translates to:
  /// **'推荐'**
  String get homeRecommendations;

  /// No description provided for @homeMediaIndex.
  ///
  /// In zh, this message translates to:
  /// **'索引'**
  String get homeMediaIndex;

  /// No description provided for @homeAllMedia.
  ///
  /// In zh, this message translates to:
  /// **'全部'**
  String get homeAllMedia;

  /// No description provided for @homeMovies.
  ///
  /// In zh, this message translates to:
  /// **'电影'**
  String get homeMovies;

  /// No description provided for @homeTvShows.
  ///
  /// In zh, this message translates to:
  /// **'电视剧'**
  String get homeTvShows;

  /// No description provided for @homeDocumentaries.
  ///
  /// In zh, this message translates to:
  /// **'纪录片'**
  String get homeDocumentaries;

  /// No description provided for @homeVarietyShows.
  ///
  /// In zh, this message translates to:
  /// **'综艺'**
  String get homeVarietyShows;

  /// No description provided for @homeRecentAnime.
  ///
  /// In zh, this message translates to:
  /// **'最近追番{count}'**
  String homeRecentAnime(String count);

  /// No description provided for @homeRecentSeries.
  ///
  /// In zh, this message translates to:
  /// **'最近追剧{count}'**
  String homeRecentSeries(String count);

  /// No description provided for @homeNoAnime.
  ///
  /// In zh, this message translates to:
  /// **'还没有追番'**
  String get homeNoAnime;

  /// No description provided for @homeNoSeries.
  ///
  /// In zh, this message translates to:
  /// **'还没有追剧'**
  String get homeNoSeries;

  /// No description provided for @feedAll.
  ///
  /// In zh, this message translates to:
  /// **'全部'**
  String get feedAll;

  /// No description provided for @feedUploads.
  ///
  /// In zh, this message translates to:
  /// **'投稿'**
  String get feedUploads;

  /// No description provided for @feedAnime.
  ///
  /// In zh, this message translates to:
  /// **'番剧'**
  String get feedAnime;

  /// No description provided for @feedArticles.
  ///
  /// In zh, this message translates to:
  /// **'专栏'**
  String get feedArticles;

  /// No description provided for @feedUploader.
  ///
  /// In zh, this message translates to:
  /// **'UP'**
  String get feedUploader;

  /// No description provided for @feedCreatePost.
  ///
  /// In zh, this message translates to:
  /// **'发布动态'**
  String get feedCreatePost;

  /// No description provided for @feedAllUpdates.
  ///
  /// In zh, this message translates to:
  /// **'全部动态'**
  String get feedAllUpdates;

  /// No description provided for @feedMe.
  ///
  /// In zh, this message translates to:
  /// **'我'**
  String get feedMe;

  /// No description provided for @feedLiveEnded.
  ///
  /// In zh, this message translates to:
  /// **'直播结束'**
  String get feedLiveEnded;

  /// No description provided for @feedVoteWithTitle.
  ///
  /// In zh, this message translates to:
  /// **'投票：{title}'**
  String feedVoteWithTitle(String title);

  /// No description provided for @feedPlayCount.
  ///
  /// In zh, this message translates to:
  /// **'{count}播放'**
  String feedPlayCount(String count);

  /// No description provided for @feedDanmakuCount.
  ///
  /// In zh, this message translates to:
  /// **'{count}弹幕'**
  String feedDanmakuCount(String count);

  /// No description provided for @feedExpired.
  ///
  /// In zh, this message translates to:
  /// **'已失效'**
  String get feedExpired;

  /// No description provided for @feedUnsupportedType.
  ///
  /// In zh, this message translates to:
  /// **'暂未支持的类型：\n{id}\n{type}'**
  String feedUnsupportedType(String id, String type);

  /// No description provided for @followMyFollowing.
  ///
  /// In zh, this message translates to:
  /// **'我的关注'**
  String get followMyFollowing;

  /// No description provided for @followUserFollowing.
  ///
  /// In zh, this message translates to:
  /// **'{name}的关注'**
  String followUserFollowing(String name);

  /// No description provided for @followNewGroup.
  ///
  /// In zh, this message translates to:
  /// **'新建分组'**
  String get followNewGroup;

  /// No description provided for @followSortGroups.
  ///
  /// In zh, this message translates to:
  /// **'分组排序'**
  String get followSortGroups;

  /// No description provided for @followBlockedUsers.
  ///
  /// In zh, this message translates to:
  /// **'黑名单管理'**
  String get followBlockedUsers;

  /// No description provided for @followShared.
  ///
  /// In zh, this message translates to:
  /// **'我们的共同关注'**
  String get followShared;

  /// No description provided for @followAll.
  ///
  /// In zh, this message translates to:
  /// **'全部关注'**
  String get followAll;

  /// No description provided for @followMostRecent.
  ///
  /// In zh, this message translates to:
  /// **'最近关注'**
  String get followMostRecent;

  /// No description provided for @followMostVisited.
  ///
  /// In zh, this message translates to:
  /// **'最常访问'**
  String get followMostVisited;

  /// No description provided for @followEditGroupName.
  ///
  /// In zh, this message translates to:
  /// **'编辑分组名称'**
  String get followEditGroupName;

  /// No description provided for @followRenameGroup.
  ///
  /// In zh, this message translates to:
  /// **'修改名称'**
  String get followRenameGroup;

  /// No description provided for @followDeleteGroup.
  ///
  /// In zh, this message translates to:
  /// **'删除分组'**
  String get followDeleteGroup;

  /// No description provided for @followDeleteGroupDescription.
  ///
  /// In zh, this message translates to:
  /// **'删除后，该分组下的用户依旧保留。'**
  String get followDeleteGroupDescription;

  /// No description provided for @followUpdateSucceeded.
  ///
  /// In zh, this message translates to:
  /// **'修改成功'**
  String get followUpdateSucceeded;

  /// No description provided for @followDeleteSucceeded.
  ///
  /// In zh, this message translates to:
  /// **'删除成功'**
  String get followDeleteSucceeded;

  /// No description provided for @feedSupporterOnly.
  ///
  /// In zh, this message translates to:
  /// **'充电专属'**
  String get feedSupporterOnly;

  /// No description provided for @feedPollOptions.
  ///
  /// In zh, this message translates to:
  /// **'投票选项'**
  String get feedPollOptions;

  /// No description provided for @feedPollEnded.
  ///
  /// In zh, this message translates to:
  /// **'已结束'**
  String get feedPollEnded;

  /// No description provided for @feedPollCompleted.
  ///
  /// In zh, this message translates to:
  /// **'已完成'**
  String get feedPollCompleted;

  /// No description provided for @feedPoll.
  ///
  /// In zh, this message translates to:
  /// **'投票'**
  String get feedPoll;

  /// No description provided for @feedFollowedPeopleVotes.
  ///
  /// In zh, this message translates to:
  /// **'关注的人的投票'**
  String get feedFollowedPeopleVotes;

  /// No description provided for @feedVotedFor.
  ///
  /// In zh, this message translates to:
  /// **'投给了'**
  String get feedVotedFor;

  /// No description provided for @feedPollEndsAt.
  ///
  /// In zh, this message translates to:
  /// **'至 {time}'**
  String feedPollEndsAt(String time);

  /// No description provided for @feedParticipantCount.
  ///
  /// In zh, this message translates to:
  /// **'{count}人参与'**
  String feedParticipantCount(String count);

  /// No description provided for @feedShowPercentage.
  ///
  /// In zh, this message translates to:
  /// **'显示比例'**
  String get feedShowPercentage;

  /// No description provided for @feedAnonymous.
  ///
  /// In zh, this message translates to:
  /// **'匿名'**
  String get feedAnonymous;

  /// No description provided for @feedMoreActions.
  ///
  /// In zh, this message translates to:
  /// **'更多'**
  String get feedMoreActions;

  /// No description provided for @feedWatchLater.
  ///
  /// In zh, this message translates to:
  /// **'稍后再看'**
  String get feedWatchLater;

  /// No description provided for @feedSavePost.
  ///
  /// In zh, this message translates to:
  /// **'保存动态'**
  String get feedSavePost;

  /// No description provided for @feedSharePost.
  ///
  /// In zh, this message translates to:
  /// **'分享动态'**
  String get feedSharePost;

  /// No description provided for @feedShareToMessages.
  ///
  /// In zh, this message translates to:
  /// **'分享至消息'**
  String get feedShareToMessages;

  /// No description provided for @feedTemporarilyBlock.
  ///
  /// In zh, this message translates to:
  /// **'临时屏蔽 {name} 的动态'**
  String feedTemporarilyBlock(String name);

  /// No description provided for @feedTemporarilyBlocked.
  ///
  /// In zh, this message translates to:
  /// **'已临时屏蔽 {name}（{id}）的动态，重启后恢复'**
  String feedTemporarilyBlocked(String name, String id);

  /// No description provided for @feedPermanentlyBlockAuthorPosts.
  ///
  /// In zh, this message translates to:
  /// **'永久屏蔽 {name} 的动态'**
  String feedPermanentlyBlockAuthorPosts(String name);

  /// No description provided for @feedAuthorPostsPermanentlyBlocked.
  ///
  /// In zh, this message translates to:
  /// **'已永久屏蔽 {name}（{id}）的动态'**
  String feedAuthorPostsPermanentlyBlocked(String name, String id);

  /// No description provided for @feedUnblockAuthorPosts.
  ///
  /// In zh, this message translates to:
  /// **'取消屏蔽 {name} 的动态'**
  String feedUnblockAuthorPosts(String name);

  /// No description provided for @feedAuthorPostsUnblocked.
  ///
  /// In zh, this message translates to:
  /// **'已取消屏蔽 {name} 的动态'**
  String feedAuthorPostsUnblocked(String name);

  /// No description provided for @dynamicBlockedUpListTitle.
  ///
  /// In zh, this message translates to:
  /// **'动态屏蔽 UP 名单（{count}）'**
  String dynamicBlockedUpListTitle(int count);

  /// No description provided for @dynamicBlockedUpListEmpty.
  ///
  /// In zh, this message translates to:
  /// **'名单中暂无 UP'**
  String get dynamicBlockedUpListEmpty;

  /// No description provided for @dynamicBlockedUpUnknownName.
  ///
  /// In zh, this message translates to:
  /// **'UP {id}'**
  String dynamicBlockedUpUnknownName(String id);

  /// No description provided for @dynamicBlockedUpUid.
  ///
  /// In zh, this message translates to:
  /// **'UID：{id}'**
  String dynamicBlockedUpUid(String id);

  /// No description provided for @dynamicBlockedUpRemoveConfirm.
  ///
  /// In zh, this message translates to:
  /// **'确定将 {name} 移出动态屏蔽名单？'**
  String dynamicBlockedUpRemoveConfirm(String name);

  /// No description provided for @dynamicBlockedUpRemoved.
  ///
  /// In zh, this message translates to:
  /// **'已移出动态屏蔽名单'**
  String get dynamicBlockedUpRemoved;

  /// No description provided for @feedCheckPost.
  ///
  /// In zh, this message translates to:
  /// **'检查动态'**
  String get feedCheckPost;

  /// No description provided for @feedPinPost.
  ///
  /// In zh, this message translates to:
  /// **'置顶'**
  String get feedPinPost;

  /// No description provided for @feedUnpinPost.
  ///
  /// In zh, this message translates to:
  /// **'取消置顶'**
  String get feedUnpinPost;

  /// No description provided for @feedEnableFeaturedComments.
  ///
  /// In zh, this message translates to:
  /// **'开启评论精选'**
  String get feedEnableFeaturedComments;

  /// No description provided for @feedDisableFeaturedComments.
  ///
  /// In zh, this message translates to:
  /// **'停止评论精选'**
  String get feedDisableFeaturedComments;

  /// No description provided for @feedDisableComments.
  ///
  /// In zh, this message translates to:
  /// **'关闭评论'**
  String get feedDisableComments;

  /// No description provided for @feedRestoreComments.
  ///
  /// In zh, this message translates to:
  /// **'恢复评论'**
  String get feedRestoreComments;

  /// No description provided for @feedInteractionSettings.
  ///
  /// In zh, this message translates to:
  /// **'互动设置'**
  String get feedInteractionSettings;

  /// No description provided for @feedVisibleToEveryone.
  ///
  /// In zh, this message translates to:
  /// **'所有用户可见'**
  String get feedVisibleToEveryone;

  /// No description provided for @feedVisibleOnlyToMe.
  ///
  /// In zh, this message translates to:
  /// **'仅自己可见'**
  String get feedVisibleOnlyToMe;

  /// No description provided for @feedVisibility.
  ///
  /// In zh, this message translates to:
  /// **'可见范围'**
  String get feedVisibility;

  /// No description provided for @feedEditPost.
  ///
  /// In zh, this message translates to:
  /// **'编辑动态'**
  String get feedEditPost;

  /// No description provided for @feedConfirmDeletePost.
  ///
  /// In zh, this message translates to:
  /// **'确定删除该动态？'**
  String get feedConfirmDeletePost;

  /// No description provided for @feedExpand.
  ///
  /// In zh, this message translates to:
  /// **'展开'**
  String get feedExpand;

  /// No description provided for @feedPriceFrom.
  ///
  /// In zh, this message translates to:
  /// **'起'**
  String get feedPriceFrom;

  /// No description provided for @feedJoin.
  ///
  /// In zh, this message translates to:
  /// **'参与'**
  String get feedJoin;

  /// No description provided for @feedComment.
  ///
  /// In zh, this message translates to:
  /// **'评论'**
  String get feedComment;

  /// No description provided for @feedWebLink.
  ///
  /// In zh, this message translates to:
  /// **'网页链接'**
  String get feedWebLink;

  /// No description provided for @followGroupSortTitle.
  ///
  /// In zh, this message translates to:
  /// **'关注分组排序'**
  String get followGroupSortTitle;

  /// No description provided for @followSortCompleted.
  ///
  /// In zh, this message translates to:
  /// **'排序完成'**
  String get followSortCompleted;

  /// No description provided for @followAlsoFollowed.
  ///
  /// In zh, this message translates to:
  /// **'我关注的 {count} 人也关注了 {name}'**
  String followAlsoFollowed(int count, String name);

  /// No description provided for @followUnknownPerson.
  ///
  /// In zh, this message translates to:
  /// **'TA'**
  String get followUnknownPerson;

  /// No description provided for @followActionFollow.
  ///
  /// In zh, this message translates to:
  /// **'关注'**
  String get followActionFollow;

  /// No description provided for @followActionFollowing.
  ///
  /// In zh, this message translates to:
  /// **'已关注'**
  String get followActionFollowing;

  /// No description provided for @followSharedWithUser.
  ///
  /// In zh, this message translates to:
  /// **'我与 {name} 的共同关注'**
  String followSharedWithUser(String name);

  /// No description provided for @settingsSignInRequired.
  ///
  /// In zh, this message translates to:
  /// **'登录后查看'**
  String get settingsSignInRequired;

  /// No description provided for @settingsBlockedUsersManagement.
  ///
  /// In zh, this message translates to:
  /// **'黑名单管理'**
  String get settingsBlockedUsersManagement;

  /// No description provided for @settingsBlockedUsersDescription.
  ///
  /// In zh, this message translates to:
  /// **'已拉黑用户'**
  String get settingsBlockedUsersDescription;

  /// No description provided for @settingsAccountModeDetails.
  ///
  /// In zh, this message translates to:
  /// **'账号模式详情'**
  String get settingsAccountModeDetails;

  /// No description provided for @settingsLearnAccountModes.
  ///
  /// In zh, this message translates to:
  /// **'了解账号模式'**
  String get settingsLearnAccountModes;

  /// No description provided for @settingsAccountModesApiDescription.
  ///
  /// In zh, this message translates to:
  /// **'查看各个账号模式所使用的 API 列表'**
  String get settingsAccountModesApiDescription;

  /// No description provided for @settingsAccountModeMain.
  ///
  /// In zh, this message translates to:
  /// **'主账号'**
  String get settingsAccountModeMain;

  /// No description provided for @settingsAccountModeWatchHistory.
  ///
  /// In zh, this message translates to:
  /// **'记录观看'**
  String get settingsAccountModeWatchHistory;

  /// No description provided for @settingsAccountModeRecommendation.
  ///
  /// In zh, this message translates to:
  /// **'推荐'**
  String get settingsAccountModeRecommendation;

  /// No description provided for @settingsAccountModeVideoStream.
  ///
  /// In zh, this message translates to:
  /// **'视频取流'**
  String get settingsAccountModeVideoStream;

  /// No description provided for @settingsUseAppRecommendations.
  ///
  /// In zh, this message translates to:
  /// **'首页使用 App 端推荐'**
  String get settingsUseAppRecommendations;

  /// No description provided for @settingsUseAppRecommendationsDescription.
  ///
  /// In zh, this message translates to:
  /// **'若 Web 端推荐不太符合预期，可尝试切换至 App 端推荐'**
  String get settingsUseAppRecommendationsDescription;

  /// No description provided for @settingsKeepPreviousRecommendations.
  ///
  /// In zh, this message translates to:
  /// **'保留首页推荐刷新'**
  String get settingsKeepPreviousRecommendations;

  /// No description provided for @settingsKeepPreviousRecommendationsDescription.
  ///
  /// In zh, this message translates to:
  /// **'下拉刷新时保留上次内容'**
  String get settingsKeepPreviousRecommendationsDescription;

  /// No description provided for @settingsShowLastPosition.
  ///
  /// In zh, this message translates to:
  /// **'显示上次看到位置提示'**
  String get settingsShowLastPosition;

  /// No description provided for @settingsShowLastPositionDescription.
  ///
  /// In zh, this message translates to:
  /// **'保留上次推荐时，在上次刷新位置显示提示'**
  String get settingsShowLastPositionDescription;

  /// No description provided for @settingsLikeRatio.
  ///
  /// In zh, this message translates to:
  /// **'点赞率'**
  String get settingsLikeRatio;

  /// No description provided for @settingsTitleKeywordFilter.
  ///
  /// In zh, this message translates to:
  /// **'标题关键词过滤'**
  String get settingsTitleKeywordFilter;

  /// No description provided for @settingsCategoryKeywordFilter.
  ///
  /// In zh, this message translates to:
  /// **'App 推荐／热门／排行榜：视频分区关键词过滤'**
  String get settingsCategoryKeywordFilter;

  /// No description provided for @settingsVideoDuration.
  ///
  /// In zh, this message translates to:
  /// **'视频时长'**
  String get settingsVideoDuration;

  /// No description provided for @settingsPlayCount.
  ///
  /// In zh, this message translates to:
  /// **'播放量'**
  String get settingsPlayCount;

  /// No description provided for @settingsExemptFollowedUploaders.
  ///
  /// In zh, this message translates to:
  /// **'已关注 UP 豁免推荐过滤'**
  String get settingsExemptFollowedUploaders;

  /// No description provided for @settingsExemptFollowedUploadersDescription.
  ///
  /// In zh, this message translates to:
  /// **'推荐中已关注用户发布的内容不会被过滤'**
  String get settingsExemptFollowedUploadersDescription;

  /// No description provided for @settingsApplyFilterToRelatedVideos.
  ///
  /// In zh, this message translates to:
  /// **'过滤器也应用于详情页相关视频'**
  String get settingsApplyFilterToRelatedVideos;

  /// No description provided for @settingsApplyFilterToRelatedVideosDescription.
  ///
  /// In zh, this message translates to:
  /// **'热门视频、搜索等其它页面不受过滤器影响；相关视频中的已关注 UP 无法豁免'**
  String get settingsApplyFilterToRelatedVideosDescription;

  /// No description provided for @settingsTapToAdd.
  ///
  /// In zh, this message translates to:
  /// **'点击添加'**
  String get settingsTapToAdd;

  /// No description provided for @settingsKeywordSeparatorHelp.
  ///
  /// In zh, this message translates to:
  /// **'使用 | 隔开，例如：尝试|测试'**
  String get settingsKeywordSeparatorHelp;

  /// No description provided for @settingsSaved.
  ///
  /// In zh, this message translates to:
  /// **'已保存'**
  String get settingsSaved;

  /// No description provided for @settingsFilterTitle.
  ///
  /// In zh, this message translates to:
  /// **'{title}过滤'**
  String settingsFilterTitle(String title);

  /// No description provided for @settingsFilterBelow.
  ///
  /// In zh, this message translates to:
  /// **'过滤掉{title}小于「{value}{suffix}」的视频'**
  String settingsFilterBelow(String title, int value, String suffix);

  /// No description provided for @settingsCurrentNamedValue.
  ///
  /// In zh, this message translates to:
  /// **'当前{title}：「{value}{suffix}」'**
  String settingsCurrentNamedValue(String title, int value, String suffix);

  /// No description provided for @settingsChooseFilterValue.
  ///
  /// In zh, this message translates to:
  /// **'选择{title}{filterHint}'**
  String settingsChooseFilterValue(String title, String filterHint);

  /// No description provided for @settingsZeroDisablesFilter.
  ///
  /// In zh, this message translates to:
  /// **'（0 即不过滤）'**
  String get settingsZeroDisablesFilter;

  /// No description provided for @settingsCustomValue.
  ///
  /// In zh, this message translates to:
  /// **'自定义'**
  String get settingsCustomValue;

  /// No description provided for @settingsCustomNamedValue.
  ///
  /// In zh, this message translates to:
  /// **'自定义{title}'**
  String settingsCustomNamedValue(String title);

  /// No description provided for @settingsChooseAccountsToSignOut.
  ///
  /// In zh, this message translates to:
  /// **'选择要登出的账号 UID'**
  String get settingsChooseAccountsToSignOut;

  /// No description provided for @settingsConfirmSignOutAccounts.
  ///
  /// In zh, this message translates to:
  /// **'确认要退出以下账号登录吗？\n\n{accounts}'**
  String settingsConfirmSignOutAccounts(String accounts);

  /// No description provided for @settingsSignOutCancel.
  ///
  /// In zh, this message translates to:
  /// **'点错了'**
  String get settingsSignOutCancel;

  /// No description provided for @settingsSignOutOnly.
  ///
  /// In zh, this message translates to:
  /// **'仅登出'**
  String get settingsSignOutOnly;

  /// No description provided for @settingsDanmakuEnabled.
  ///
  /// In zh, this message translates to:
  /// **'弹幕开关'**
  String get settingsDanmakuEnabled;

  /// No description provided for @settingsDanmakuEnabledDescription.
  ///
  /// In zh, this message translates to:
  /// **'是否展示弹幕'**
  String get settingsDanmakuEnabledDescription;

  /// No description provided for @settingsTapDanmaku.
  ///
  /// In zh, this message translates to:
  /// **'启用点击弹幕'**
  String get settingsTapDanmaku;

  /// No description provided for @settingsTapDanmakuDescription.
  ///
  /// In zh, this message translates to:
  /// **'点击弹幕悬停，支持点赞、复制、举报操作'**
  String get settingsTapDanmakuDescription;

  /// No description provided for @settingsPlaybackSpeed.
  ///
  /// In zh, this message translates to:
  /// **'倍速设置'**
  String get settingsPlaybackSpeed;

  /// No description provided for @settingsPlaybackSpeedDescription.
  ///
  /// In zh, this message translates to:
  /// **'设置视频播放速度'**
  String get settingsPlaybackSpeedDescription;

  /// No description provided for @settingsTiltAngleThreshold.
  ///
  /// In zh, this message translates to:
  /// **'倾斜角度阈值'**
  String get settingsTiltAngleThreshold;

  /// No description provided for @settingsAutoplay.
  ///
  /// In zh, this message translates to:
  /// **'自动播放'**
  String get settingsAutoplay;

  /// No description provided for @settingsAutoplayDescription.
  ///
  /// In zh, this message translates to:
  /// **'进入详情页自动播放'**
  String get settingsAutoplayDescription;

  /// No description provided for @settingsFullscreenLockButton.
  ///
  /// In zh, this message translates to:
  /// **'全屏显示锁定按钮'**
  String get settingsFullscreenLockButton;

  /// No description provided for @settingsFullscreenScreenshotButton.
  ///
  /// In zh, this message translates to:
  /// **'全屏显示截图按钮'**
  String get settingsFullscreenScreenshotButton;

  /// No description provided for @settingsFullscreenBattery.
  ///
  /// In zh, this message translates to:
  /// **'全屏显示电池电量'**
  String get settingsFullscreenBattery;

  /// No description provided for @settingsDoubleTapSeek.
  ///
  /// In zh, this message translates to:
  /// **'双击快退／快进'**
  String get settingsDoubleTapSeek;

  /// No description provided for @settingsDoubleTapSeekDescription.
  ///
  /// In zh, this message translates to:
  /// **'左侧双击快退，右侧双击快进；关闭后双击均为暂停／播放'**
  String get settingsDoubleTapSeekDescription;

  /// No description provided for @settingsSlideBrightnessVolume.
  ///
  /// In zh, this message translates to:
  /// **'左右侧滑动调节亮度／音量'**
  String get settingsSlideBrightnessVolume;

  /// No description provided for @settingsSystemBrightness.
  ///
  /// In zh, this message translates to:
  /// **'调节系统亮度'**
  String get settingsSystemBrightness;

  /// No description provided for @settingsSlideFullscreen.
  ///
  /// In zh, this message translates to:
  /// **'中间滑动进入／退出全屏'**
  String get settingsSlideFullscreen;

  /// No description provided for @settingsPlayerVolume.
  ///
  /// In zh, this message translates to:
  /// **'播放器音量'**
  String get settingsPlayerVolume;

  /// No description provided for @settingsMaximumVolume.
  ///
  /// In zh, this message translates to:
  /// **'最高音量'**
  String get settingsMaximumVolume;

  /// No description provided for @settingsDoubleTapSeekDuration.
  ///
  /// In zh, this message translates to:
  /// **'双击快进／快退时长'**
  String get settingsDoubleTapSeekDuration;

  /// No description provided for @settingsRelativeSlideSeek.
  ///
  /// In zh, this message translates to:
  /// **'滑动快进／快退使用相对时长'**
  String get settingsRelativeSlideSeek;

  /// No description provided for @settingsSlideSeekDuration.
  ///
  /// In zh, this message translates to:
  /// **'滑动快进／快退时长'**
  String get settingsSlideSeekDuration;

  /// No description provided for @settingsSlideSeekDurationDescription.
  ///
  /// In zh, this message translates to:
  /// **'从播放器一端滑到另一端的快进／快退时长'**
  String get settingsSlideSeekDurationDescription;

  /// No description provided for @settingsAutomaticSubtitles.
  ///
  /// In zh, this message translates to:
  /// **'自动启用字幕'**
  String get settingsAutomaticSubtitles;

  /// No description provided for @settingsCurrentPreference.
  ///
  /// In zh, this message translates to:
  /// **'当前选择偏好：{value}'**
  String settingsCurrentPreference(String value);

  /// No description provided for @settingsPauseWhenMinimized.
  ///
  /// In zh, this message translates to:
  /// **'最小化时暂停／还原时播放'**
  String get settingsPauseWhenMinimized;

  /// No description provided for @settingsKeyboardControls.
  ///
  /// In zh, this message translates to:
  /// **'启用键盘控制'**
  String get settingsKeyboardControls;

  /// No description provided for @settingsSuperChatDisplay.
  ///
  /// In zh, this message translates to:
  /// **'SuperChat（醒目留言）显示类型'**
  String get settingsSuperChatDisplay;

  /// No description provided for @settingsFullscreenSuperChatSize.
  ///
  /// In zh, this message translates to:
  /// **'全屏 SC 大小'**
  String get settingsFullscreenSuperChatSize;

  /// No description provided for @settingsFullscreenSuperChatSizeDescription.
  ///
  /// In zh, this message translates to:
  /// **'SuperChat（醒目留言）大小设置'**
  String get settingsFullscreenSuperChatSizeDescription;

  /// No description provided for @settingsExpandPortraitVideo.
  ///
  /// In zh, this message translates to:
  /// **'竖屏扩大展示'**
  String get settingsExpandPortraitVideo;

  /// No description provided for @settingsExpandPortraitVideoDescription.
  ///
  /// In zh, this message translates to:
  /// **'小屏竖屏视频宽高比由 16:9 扩大至 1:1（不支持收起）；横屏适配时扩大至 9:16'**
  String get settingsExpandPortraitVideoDescription;

  /// No description provided for @settingsAutoEnterFullscreen.
  ///
  /// In zh, this message translates to:
  /// **'自动全屏'**
  String get settingsAutoEnterFullscreen;

  /// No description provided for @settingsAutoEnterFullscreenDescription.
  ///
  /// In zh, this message translates to:
  /// **'视频开始播放时进入全屏'**
  String get settingsAutoEnterFullscreenDescription;

  /// No description provided for @settingsAutoExitFullscreen.
  ///
  /// In zh, this message translates to:
  /// **'自动退出全屏'**
  String get settingsAutoExitFullscreen;

  /// No description provided for @settingsAutoExitFullscreenDescription.
  ///
  /// In zh, this message translates to:
  /// **'视频结束播放时退出全屏'**
  String get settingsAutoExitFullscreenDescription;

  /// No description provided for @settingsExtendPlayerControls.
  ///
  /// In zh, this message translates to:
  /// **'延长播放控件显示时间'**
  String get settingsExtendPlayerControls;

  /// No description provided for @settingsExtendPlayerControlsDescription.
  ///
  /// In zh, this message translates to:
  /// **'开启后延长至 30 秒，便于屏幕阅读器滑动切换控件焦点'**
  String get settingsExtendPlayerControlsDescription;

  /// No description provided for @settingsBackgroundPlayback.
  ///
  /// In zh, this message translates to:
  /// **'后台播放'**
  String get settingsBackgroundPlayback;

  /// No description provided for @settingsBackgroundPlaybackDescription.
  ///
  /// In zh, this message translates to:
  /// **'进入后台时继续播放'**
  String get settingsBackgroundPlaybackDescription;

  /// No description provided for @settingsBackgroundPictureInPicture.
  ///
  /// In zh, this message translates to:
  /// **'后台画中画'**
  String get settingsBackgroundPictureInPicture;

  /// No description provided for @settingsBackgroundPictureInPictureDescription.
  ///
  /// In zh, this message translates to:
  /// **'进入后台时以小窗形式（PiP）播放'**
  String get settingsBackgroundPictureInPictureDescription;

  /// No description provided for @settingsEnableBackgroundAudioSuggestion.
  ///
  /// In zh, this message translates to:
  /// **'建议开启后台音频服务'**
  String get settingsEnableBackgroundAudioSuggestion;

  /// No description provided for @settingsHideDanmakuInPictureInPicture.
  ///
  /// In zh, this message translates to:
  /// **'画中画不加载弹幕'**
  String get settingsHideDanmakuInPictureInPicture;

  /// No description provided for @settingsHideDanmakuInPictureInPictureDescription.
  ///
  /// In zh, this message translates to:
  /// **'小窗播放时屏蔽弹幕以获得更好的体验'**
  String get settingsHideDanmakuInPictureInPictureDescription;

  /// No description provided for @settingsReverseFullscreenGesture.
  ///
  /// In zh, this message translates to:
  /// **'全屏手势反向'**
  String get settingsReverseFullscreenGesture;

  /// No description provided for @settingsReverseFullscreenGestureDescription.
  ///
  /// In zh, this message translates to:
  /// **'默认向上滑动进入全屏、向下退出；开启后方向相反'**
  String get settingsReverseFullscreenGestureDescription;

  /// No description provided for @settingsFullscreenActionButtons.
  ///
  /// In zh, this message translates to:
  /// **'全屏展示点赞、投币、收藏等操作按钮'**
  String get settingsFullscreenActionButtons;

  /// No description provided for @settingsOnlineViewerCount.
  ///
  /// In zh, this message translates to:
  /// **'观看人数'**
  String get settingsOnlineViewerCount;

  /// No description provided for @settingsOnlineViewerCountDescription.
  ///
  /// In zh, this message translates to:
  /// **'展示同时在看人数'**
  String get settingsOnlineViewerCountDescription;

  /// No description provided for @settingsDefaultFullscreenOrientation.
  ///
  /// In zh, this message translates to:
  /// **'默认全屏方向'**
  String get settingsDefaultFullscreenOrientation;

  /// No description provided for @settingsCurrentFullscreenOrientation.
  ///
  /// In zh, this message translates to:
  /// **'当前全屏方向：{value}'**
  String settingsCurrentFullscreenOrientation(String value);

  /// No description provided for @settingsBottomProgressBar.
  ///
  /// In zh, this message translates to:
  /// **'底部进度条展示'**
  String get settingsBottomProgressBar;

  /// No description provided for @settingsCurrentBottomProgressBar.
  ///
  /// In zh, this message translates to:
  /// **'当前展示方式：{value}'**
  String settingsCurrentBottomProgressBar(String value);

  /// No description provided for @settingsBackgroundAudioService.
  ///
  /// In zh, this message translates to:
  /// **'后台音频服务'**
  String get settingsBackgroundAudioService;

  /// No description provided for @settingsBackgroundAudioServiceDescription.
  ///
  /// In zh, this message translates to:
  /// **'避免画中画没有播放暂停功能'**
  String get settingsBackgroundAudioServiceDescription;

  /// No description provided for @settingsPlaybackOrder.
  ///
  /// In zh, this message translates to:
  /// **'播放顺序'**
  String get settingsPlaybackOrder;

  /// No description provided for @settingsTemporaryPlayerSettings.
  ///
  /// In zh, this message translates to:
  /// **'播放器设置仅对当前生效'**
  String get settingsTemporaryPlayerSettings;

  /// No description provided for @settingsTemporaryPlayerSettingsDescription.
  ///
  /// In zh, this message translates to:
  /// **'弹幕、字幕及部分设置中没有的设置除外'**
  String get settingsTemporaryPlayerSettingsDescription;

  /// No description provided for @settingsSubtitlePreference.
  ///
  /// In zh, this message translates to:
  /// **'字幕选择偏好'**
  String get settingsSubtitlePreference;

  /// No description provided for @settingsSubtitlePreferenceOff.
  ///
  /// In zh, this message translates to:
  /// **'默认不显示字幕'**
  String get settingsSubtitlePreferenceOff;

  /// No description provided for @settingsSubtitlePreferencePreferHuman.
  ///
  /// In zh, this message translates to:
  /// **'优先选择非自动生成（AI）字幕'**
  String get settingsSubtitlePreferencePreferHuman;

  /// No description provided for @settingsSubtitlePreferenceSkipAi.
  ///
  /// In zh, this message translates to:
  /// **'跳过自动生成（AI）字幕，选择第一个可用字幕'**
  String get settingsSubtitlePreferenceSkipAi;

  /// No description provided for @settingsSubtitlePreferenceAuto.
  ///
  /// In zh, this message translates to:
  /// **'静音时优先非自动字幕，非静音时跳过自动字幕'**
  String get settingsSubtitlePreferenceAuto;

  /// No description provided for @settingsSuperChatValidOnly.
  ///
  /// In zh, this message translates to:
  /// **'有效时间内显示'**
  String get settingsSuperChatValidOnly;

  /// No description provided for @settingsSuperChatPersistent.
  ///
  /// In zh, this message translates to:
  /// **'常驻显示'**
  String get settingsSuperChatPersistent;

  /// No description provided for @settingsSuperChatDisabled.
  ///
  /// In zh, this message translates to:
  /// **'不显示'**
  String get settingsSuperChatDisabled;

  /// No description provided for @settingsFullscreenOrientationAuto.
  ///
  /// In zh, this message translates to:
  /// **'按视频方向（默认）'**
  String get settingsFullscreenOrientationAuto;

  /// No description provided for @settingsFullscreenOrientationUnchanged.
  ///
  /// In zh, this message translates to:
  /// **'不改变当前方向'**
  String get settingsFullscreenOrientationUnchanged;

  /// No description provided for @settingsFullscreenOrientationPortrait.
  ///
  /// In zh, this message translates to:
  /// **'强制竖屏'**
  String get settingsFullscreenOrientationPortrait;

  /// No description provided for @settingsFullscreenOrientationLandscape.
  ///
  /// In zh, this message translates to:
  /// **'强制横屏'**
  String get settingsFullscreenOrientationLandscape;

  /// No description provided for @settingsFullscreenOrientationRatio.
  ///
  /// In zh, this message translates to:
  /// **'屏幕长宽比小于 {ratio} 或为竖屏视频时竖屏，否则横屏'**
  String settingsFullscreenOrientationRatio(double ratio);

  /// No description provided for @settingsFullscreenOrientationGravity.
  ///
  /// In zh, this message translates to:
  /// **'忽略系统方向锁定，强制按重力转屏（仅 Android）'**
  String get settingsFullscreenOrientationGravity;

  /// No description provided for @settingsProgressAlwaysShow.
  ///
  /// In zh, this message translates to:
  /// **'始终展示'**
  String get settingsProgressAlwaysShow;

  /// No description provided for @settingsProgressAlwaysHide.
  ///
  /// In zh, this message translates to:
  /// **'始终隐藏'**
  String get settingsProgressAlwaysHide;

  /// No description provided for @settingsProgressFullscreenOnly.
  ///
  /// In zh, this message translates to:
  /// **'仅全屏时展示'**
  String get settingsProgressFullscreenOnly;

  /// No description provided for @settingsProgressHideFullscreen.
  ///
  /// In zh, this message translates to:
  /// **'仅全屏时隐藏'**
  String get settingsProgressHideFullscreen;

  /// No description provided for @settingsHardwareDecoding.
  ///
  /// In zh, this message translates to:
  /// **'开启硬解'**
  String get settingsHardwareDecoding;

  /// No description provided for @settingsHardwareDecodingDescription.
  ///
  /// In zh, this message translates to:
  /// **'以较低功耗播放视频，若异常卡死请关闭'**
  String get settingsHardwareDecodingDescription;

  /// No description provided for @settingsGuest1080p.
  ///
  /// In zh, this message translates to:
  /// **'免登录 1080P'**
  String get settingsGuest1080p;

  /// No description provided for @settingsGuest1080pDescription.
  ///
  /// In zh, this message translates to:
  /// **'未登录时也尝试播放 1080P 视频'**
  String get settingsGuest1080pDescription;

  /// No description provided for @settingsBilibiliDataPlan.
  ///
  /// In zh, this message translates to:
  /// **'B 站定向流量支持'**
  String get settingsBilibiliDataPlan;

  /// No description provided for @settingsBilibiliDataPlanDescription.
  ///
  /// In zh, this message translates to:
  /// **'若套餐含 B 站定向流量则会自动使用，可查阅运营商的流量记录确认'**
  String get settingsBilibiliDataPlanDescription;

  /// No description provided for @settingsCdn.
  ///
  /// In zh, this message translates to:
  /// **'CDN 设置'**
  String get settingsCdn;

  /// No description provided for @settingsCurrentCdn.
  ///
  /// In zh, this message translates to:
  /// **'当前使用：{value}。部分 CDN 可能失效，如无法播放请尝试切换'**
  String settingsCurrentCdn(String value);

  /// No description provided for @settingsLiveCdn.
  ///
  /// In zh, this message translates to:
  /// **'直播 CDN 设置'**
  String get settingsLiveCdn;

  /// No description provided for @settingsCurrentSource.
  ///
  /// In zh, this message translates to:
  /// **'当前使用：{value}'**
  String settingsCurrentSource(String value);

  /// No description provided for @settingsCdnSpeedTest.
  ///
  /// In zh, this message translates to:
  /// **'CDN 测速'**
  String get settingsCdnSpeedTest;

  /// No description provided for @settingsCdnSpeedTestDescription.
  ///
  /// In zh, this message translates to:
  /// **'测速通过模拟加载视频实现，请注意流量消耗，结果仅供参考'**
  String get settingsCdnSpeedTestDescription;

  /// No description provided for @settingsSeparateAudioCdn.
  ///
  /// In zh, this message translates to:
  /// **'音频不跟随 CDN 设置'**
  String get settingsSeparateAudioCdn;

  /// No description provided for @settingsSeparateAudioCdnDescription.
  ///
  /// In zh, this message translates to:
  /// **'直接采用备用 URL，可解决部分视频无声'**
  String get settingsSeparateAudioCdnDescription;

  /// No description provided for @settingsDefaultVideoQuality.
  ///
  /// In zh, this message translates to:
  /// **'默认画质'**
  String get settingsDefaultVideoQuality;

  /// No description provided for @settingsCellularVideoQuality.
  ///
  /// In zh, this message translates to:
  /// **'蜂窝网络画质'**
  String get settingsCellularVideoQuality;

  /// No description provided for @settingsDefaultAudioQuality.
  ///
  /// In zh, this message translates to:
  /// **'默认音质'**
  String get settingsDefaultAudioQuality;

  /// No description provided for @settingsCellularAudioQuality.
  ///
  /// In zh, this message translates to:
  /// **'蜂窝网络音质'**
  String get settingsCellularAudioQuality;

  /// No description provided for @settingsDefaultLiveQuality.
  ///
  /// In zh, this message translates to:
  /// **'直播默认画质'**
  String get settingsDefaultLiveQuality;

  /// No description provided for @settingsCellularLiveQuality.
  ///
  /// In zh, this message translates to:
  /// **'蜂窝网络直播默认画质'**
  String get settingsCellularLiveQuality;

  /// No description provided for @settingsCurrentVideoQuality.
  ///
  /// In zh, this message translates to:
  /// **'当前画质：{value}'**
  String settingsCurrentVideoQuality(String value);

  /// No description provided for @settingsCurrentAudioQuality.
  ///
  /// In zh, this message translates to:
  /// **'当前音质：{value}'**
  String settingsCurrentAudioQuality(String value);

  /// No description provided for @settingsPreferredCodecs.
  ///
  /// In zh, this message translates to:
  /// **'首选解码格式'**
  String get settingsPreferredCodecs;

  /// No description provided for @settingsPreferredCodecsDescription.
  ///
  /// In zh, this message translates to:
  /// **'首选解码格式：{value}。请根据设备支持情况与需求调整'**
  String settingsPreferredCodecsDescription(String value);

  /// No description provided for @settingsAudioOutput.
  ///
  /// In zh, this message translates to:
  /// **'音频输出设备'**
  String get settingsAudioOutput;

  /// No description provided for @settingsBufferSize.
  ///
  /// In zh, this message translates to:
  /// **'缓冲大小'**
  String get settingsBufferSize;

  /// No description provided for @settingsBufferSizeDescription.
  ///
  /// In zh, this message translates to:
  /// **'当前：{value} MB。此值同时作为前向和后向缓冲区大小；直播流会全部用于前向缓冲（mpv：--demuxer-max-bytes、--demuxer-max-back-bytes）'**
  String settingsBufferSizeDescription(double value);

  /// No description provided for @settingsBufferDuration.
  ///
  /// In zh, this message translates to:
  /// **'缓冲时长'**
  String get settingsBufferDuration;

  /// No description provided for @settingsBufferDurationDescription.
  ///
  /// In zh, this message translates to:
  /// **'当前：{value} 秒。实际缓冲取大小与时长限制中的较小值；直播流不使用此项（mpv：--cache-secs）'**
  String settingsBufferDurationDescription(double value);

  /// No description provided for @settingsAutoSync.
  ///
  /// In zh, this message translates to:
  /// **'自动同步'**
  String get settingsAutoSync;

  /// No description provided for @settingsAutoSyncDescription.
  ///
  /// In zh, this message translates to:
  /// **'当前：{value}（mpv：--autosync）'**
  String settingsAutoSyncDescription(String value);

  /// No description provided for @settingsVideoSync.
  ///
  /// In zh, this message translates to:
  /// **'视频同步'**
  String get settingsVideoSync;

  /// No description provided for @settingsVideoSyncDescription.
  ///
  /// In zh, this message translates to:
  /// **'当前：{value}（mpv：--video-sync）'**
  String settingsVideoSyncDescription(String value);

  /// No description provided for @settingsHardwareDecodingMode.
  ///
  /// In zh, this message translates to:
  /// **'硬解模式'**
  String get settingsHardwareDecodingMode;

  /// No description provided for @settingsHardwareDecodingModeDescription.
  ///
  /// In zh, this message translates to:
  /// **'当前：{value}（mpv：--hwdec）'**
  String settingsHardwareDecodingModeDescription(String value);

  /// No description provided for @settingsEnterCdnHost.
  ///
  /// In zh, this message translates to:
  /// **'输入 CDN Host'**
  String get settingsEnterCdnHost;

  /// No description provided for @settingsLiveQualityDolby.
  ///
  /// In zh, this message translates to:
  /// **'杜比'**
  String get settingsLiveQualityDolby;

  /// No description provided for @settingsLiveQuality4kOriginal.
  ///
  /// In zh, this message translates to:
  /// **'4K 原画'**
  String get settingsLiveQuality4kOriginal;

  /// No description provided for @settingsLiveQuality4k.
  ///
  /// In zh, this message translates to:
  /// **'4K'**
  String get settingsLiveQuality4k;

  /// No description provided for @settingsLiveQuality2k.
  ///
  /// In zh, this message translates to:
  /// **'2K'**
  String get settingsLiveQuality2k;

  /// No description provided for @settingsLiveQualityOriginal.
  ///
  /// In zh, this message translates to:
  /// **'原画'**
  String get settingsLiveQualityOriginal;

  /// No description provided for @settingsLiveQualityBluRay.
  ///
  /// In zh, this message translates to:
  /// **'蓝光'**
  String get settingsLiveQualityBluRay;

  /// No description provided for @settingsLiveQualitySuperHd.
  ///
  /// In zh, this message translates to:
  /// **'超清'**
  String get settingsLiveQualitySuperHd;

  /// No description provided for @settingsLiveQualityHd.
  ///
  /// In zh, this message translates to:
  /// **'高清'**
  String get settingsLiveQualityHd;

  /// No description provided for @settingsLiveQualitySmooth.
  ///
  /// In zh, this message translates to:
  /// **'流畅'**
  String get settingsLiveQualitySmooth;

  /// No description provided for @settingsHwdecSoftware.
  ///
  /// In zh, this message translates to:
  /// **'启用软解'**
  String get settingsHwdecSoftware;

  /// No description provided for @settingsHwdecAny.
  ///
  /// In zh, this message translates to:
  /// **'启用任意可用解码器'**
  String get settingsHwdecAny;

  /// No description provided for @settingsHwdecBest.
  ///
  /// In zh, this message translates to:
  /// **'启用最佳解码器'**
  String get settingsHwdecBest;

  /// No description provided for @settingsHwdecBestCopy.
  ///
  /// In zh, this message translates to:
  /// **'启用带拷贝功能的最佳解码器'**
  String get settingsHwdecBestCopy;

  /// No description provided for @settingsHwdecNonDirect.
  ///
  /// In zh, this message translates to:
  /// **'非直通'**
  String get settingsHwdecNonDirect;

  /// No description provided for @settingsHwdecExclusive.
  ///
  /// In zh, this message translates to:
  /// **'{vendor} 独占'**
  String settingsHwdecExclusive(String vendor);

  /// No description provided for @settingsHwdecExperimental.
  ///
  /// In zh, this message translates to:
  /// **'实验性'**
  String get settingsHwdecExperimental;

  /// No description provided for @settingsHwdecDeprecated.
  ///
  /// In zh, this message translates to:
  /// **'已过时'**
  String get settingsHwdecDeprecated;

  /// No description provided for @settingsHwdecAllPlatforms.
  ///
  /// In zh, this message translates to:
  /// **'全平台'**
  String get settingsHwdecAllPlatforms;

  /// No description provided for @settingsHwdecPartialRockchip.
  ///
  /// In zh, this message translates to:
  /// **'仅部分 Rockchip 芯片'**
  String get settingsHwdecPartialRockchip;

  /// No description provided for @settingsWindowTitleBar.
  ///
  /// In zh, this message translates to:
  /// **'显示窗口标题栏'**
  String get settingsWindowTitleBar;

  /// No description provided for @settingsTrayIcon.
  ///
  /// In zh, this message translates to:
  /// **'显示托盘图标'**
  String get settingsTrayIcon;

  /// No description provided for @settingsLandscapeLayout.
  ///
  /// In zh, this message translates to:
  /// **'横屏适配'**
  String get settingsLandscapeLayout;

  /// No description provided for @settingsLandscapeLayoutDescription.
  ///
  /// In zh, this message translates to:
  /// **'启用横屏布局与逻辑，平板、折叠屏等可开启；建议全屏方向设为“不改变当前方向”'**
  String get settingsLandscapeLayoutDescription;

  /// No description provided for @settingsUseSidebar.
  ///
  /// In zh, this message translates to:
  /// **'改用侧边栏'**
  String get settingsUseSidebar;

  /// No description provided for @settingsUseSidebarDescription.
  ///
  /// In zh, this message translates to:
  /// **'开启后底栏与顶栏会被替换，相关设置将失效'**
  String get settingsUseSidebarDescription;

  /// No description provided for @settingsUiScale.
  ///
  /// In zh, this message translates to:
  /// **'界面缩放'**
  String get settingsUiScale;

  /// No description provided for @settingsCurrentUiScale.
  ///
  /// In zh, this message translates to:
  /// **'当前缩放比例：{value}'**
  String settingsCurrentUiScale(String value);

  /// No description provided for @settingsPageTransition.
  ///
  /// In zh, this message translates to:
  /// **'页面过渡动画'**
  String get settingsPageTransition;

  /// No description provided for @settingsOptimizeTabletNavigation.
  ///
  /// In zh, this message translates to:
  /// **'优化平板导航栏'**
  String get settingsOptimizeTabletNavigation;

  /// No description provided for @settingsMaterialYouBottomBar.
  ///
  /// In zh, this message translates to:
  /// **'MD3 样式底栏'**
  String get settingsMaterialYouBottomBar;

  /// No description provided for @settingsMaterialYouBottomBarDescription.
  ///
  /// In zh, this message translates to:
  /// **'Material You 设计规范底栏，关闭后可变窄'**
  String get settingsMaterialYouBottomBarDescription;

  /// No description provided for @settingsFloatingBottomBar.
  ///
  /// In zh, this message translates to:
  /// **'悬浮底栏'**
  String get settingsFloatingBottomBar;

  /// No description provided for @settingsListWidthLimit.
  ///
  /// In zh, this message translates to:
  /// **'列表宽度（dp）限制'**
  String get settingsListWidthLimit;

  /// No description provided for @settingsListWidthDescription.
  ///
  /// In zh, this message translates to:
  /// **'当前：主页 {home} dp，其他 {other} dp，屏幕宽度 {screen} dp。宽度越小，列数越多。'**
  String settingsListWidthDescription(int home, int other, String screen);

  /// No description provided for @settingsRemovePlayerSafeArea.
  ///
  /// In zh, this message translates to:
  /// **'播放页移除安全边距'**
  String get settingsRemovePlayerSafeArea;

  /// No description provided for @settingsDarkVideoPage.
  ///
  /// In zh, this message translates to:
  /// **'视频播放页使用深色主题'**
  String get settingsDarkVideoPage;

  /// No description provided for @settingsFeedWaterfall.
  ///
  /// In zh, this message translates to:
  /// **'动态页启用瀑布流'**
  String get settingsFeedWaterfall;

  /// No description provided for @settingsFeedWaterfallDescription.
  ///
  /// In zh, this message translates to:
  /// **'关闭后显示为单列'**
  String get settingsFeedWaterfallDescription;

  /// No description provided for @settingsFeedUploaderPosition.
  ///
  /// In zh, this message translates to:
  /// **'动态页 UP 主列表显示位置'**
  String get settingsFeedUploaderPosition;

  /// No description provided for @settingsShowAllFollowedUploaders.
  ///
  /// In zh, this message translates to:
  /// **'动态页显示所有已关注 UP 主'**
  String get settingsShowAllFollowedUploaders;

  /// No description provided for @settingsExpandLiveUploaders.
  ///
  /// In zh, this message translates to:
  /// **'动态页展开正在直播的 UP 主列表'**
  String get settingsExpandLiveUploaders;

  /// No description provided for @settingsFeedUnreadBadge.
  ///
  /// In zh, this message translates to:
  /// **'动态未读标记'**
  String get settingsFeedUnreadBadge;

  /// No description provided for @settingsMessageUnreadBadge.
  ///
  /// In zh, this message translates to:
  /// **'消息未读标记'**
  String get settingsMessageUnreadBadge;

  /// No description provided for @settingsCurrentBadgeStyle.
  ///
  /// In zh, this message translates to:
  /// **'当前标记样式：{value}'**
  String settingsCurrentBadgeStyle(String value);

  /// No description provided for @settingsMessageUnreadTypes.
  ///
  /// In zh, this message translates to:
  /// **'消息未读类型'**
  String get settingsMessageUnreadTypes;

  /// No description provided for @settingsCurrentMessageTypes.
  ///
  /// In zh, this message translates to:
  /// **'当前消息类型：{value}'**
  String settingsCurrentMessageTypes(String value);

  /// No description provided for @settingsBarCollapseBehavior.
  ///
  /// In zh, this message translates to:
  /// **'顶／底栏收起类型'**
  String get settingsBarCollapseBehavior;

  /// No description provided for @settingsCollapseHomeTopBar.
  ///
  /// In zh, this message translates to:
  /// **'首页顶栏收起'**
  String get settingsCollapseHomeTopBar;

  /// No description provided for @settingsCollapseHomeTopBarDescription.
  ///
  /// In zh, this message translates to:
  /// **'首页列表滑动时收起顶栏'**
  String get settingsCollapseHomeTopBarDescription;

  /// No description provided for @settingsCollapseHomeBottomBar.
  ///
  /// In zh, this message translates to:
  /// **'首页底栏收起'**
  String get settingsCollapseHomeBottomBar;

  /// No description provided for @settingsCollapseHomeBottomBarDescription.
  ///
  /// In zh, this message translates to:
  /// **'首页列表滑动时收起底栏'**
  String get settingsCollapseHomeBottomBarDescription;

  /// No description provided for @settingsImageQuality.
  ///
  /// In zh, this message translates to:
  /// **'图片质量'**
  String get settingsImageQuality;

  /// No description provided for @settingsImagePreviewQuality.
  ///
  /// In zh, this message translates to:
  /// **'查看大图质量'**
  String get settingsImagePreviewQuality;

  /// No description provided for @settingsImageQualityDescription.
  ///
  /// In zh, this message translates to:
  /// **'选择合适的图片清晰度，上限 100%'**
  String get settingsImageQualityDescription;

  /// No description provided for @settingsDarkImageOverlay.
  ///
  /// In zh, this message translates to:
  /// **'深色下图片颜色叠加'**
  String get settingsDarkImageOverlay;

  /// No description provided for @settingsDarkImageOverlayDescription.
  ///
  /// In zh, this message translates to:
  /// **'显示颜色＝图片原色 × 所选颜色；大图查看不受影响'**
  String get settingsDarkImageOverlayDescription;

  /// No description provided for @settingsToastOpacity.
  ///
  /// In zh, this message translates to:
  /// **'气泡提示不透明度'**
  String get settingsToastOpacity;

  /// No description provided for @settingsToastOpacityDescription.
  ///
  /// In zh, this message translates to:
  /// **'自定义气泡提示（Toast）不透明度'**
  String get settingsToastOpacityDescription;

  /// No description provided for @settingsThemeMode.
  ///
  /// In zh, this message translates to:
  /// **'主题模式'**
  String get settingsThemeMode;

  /// No description provided for @settingsCurrentMode.
  ///
  /// In zh, this message translates to:
  /// **'当前模式：{value}'**
  String settingsCurrentMode(String value);

  /// No description provided for @settingsPureBlackTheme.
  ///
  /// In zh, this message translates to:
  /// **'纯黑主题'**
  String get settingsPureBlackTheme;

  /// No description provided for @settingsAppTheme.
  ///
  /// In zh, this message translates to:
  /// **'应用主题'**
  String get settingsAppTheme;

  /// No description provided for @settingsCurrentTheme.
  ///
  /// In zh, this message translates to:
  /// **'当前主题：{value}'**
  String settingsCurrentTheme(String value);

  /// No description provided for @settingsDynamicColor.
  ///
  /// In zh, this message translates to:
  /// **'动态取色'**
  String get settingsDynamicColor;

  /// No description provided for @settingsExPiliPlusCustomColor.
  ///
  /// In zh, this message translates to:
  /// **'ExPiliPlus 自定义颜色'**
  String get settingsExPiliPlusCustomColor;

  /// No description provided for @settingsSpecifiedColor.
  ///
  /// In zh, this message translates to:
  /// **'指定颜色'**
  String get settingsSpecifiedColor;

  /// No description provided for @settingsDefaultStartPage.
  ///
  /// In zh, this message translates to:
  /// **'默认启动页'**
  String get settingsDefaultStartPage;

  /// No description provided for @settingsCurrentStartPage.
  ///
  /// In zh, this message translates to:
  /// **'当前启动页：{value}'**
  String settingsCurrentStartPage(String value);

  /// No description provided for @settingsSpringParameters.
  ///
  /// In zh, this message translates to:
  /// **'滑动动画弹簧参数'**
  String get settingsSpringParameters;

  /// No description provided for @settingsFontSize.
  ///
  /// In zh, this message translates to:
  /// **'字体大小'**
  String get settingsFontSize;

  /// No description provided for @settingsHomeTabs.
  ///
  /// In zh, this message translates to:
  /// **'首页标签页'**
  String get settingsHomeTabs;

  /// No description provided for @settingsHomeTabsDescription.
  ///
  /// In zh, this message translates to:
  /// **'删除或调换首页标签页'**
  String get settingsHomeTabsDescription;

  /// No description provided for @settingsNavigationBarEditor.
  ///
  /// In zh, this message translates to:
  /// **'Navbar 编辑'**
  String get settingsNavigationBarEditor;

  /// No description provided for @settingsNavigationBarEditorDescription.
  ///
  /// In zh, this message translates to:
  /// **'删除或调换 Navbar'**
  String get settingsNavigationBarEditorDescription;

  /// No description provided for @settingsExitDirectlyOnBack.
  ///
  /// In zh, this message translates to:
  /// **'返回时直接退出'**
  String get settingsExitDirectlyOnBack;

  /// No description provided for @settingsExitDirectlyOnBackDescription.
  ///
  /// In zh, this message translates to:
  /// **'开启后，在主页任意标签页按返回键都会直接退出；关闭后先回到 Navbar 的第一个标签页'**
  String get settingsExitDirectlyOnBackDescription;

  /// No description provided for @settingsScreenRefreshRate.
  ///
  /// In zh, this message translates to:
  /// **'屏幕帧率'**
  String get settingsScreenRefreshRate;

  /// No description provided for @settingsSucceeded.
  ///
  /// In zh, this message translates to:
  /// **'设置成功'**
  String get settingsSucceeded;

  /// No description provided for @settingsRestartRequired.
  ///
  /// In zh, this message translates to:
  /// **'重启生效'**
  String get settingsRestartRequired;

  /// No description provided for @settingsSucceededRestartRequired.
  ///
  /// In zh, this message translates to:
  /// **'设置成功，重启生效'**
  String get settingsSucceededRestartRequired;

  /// No description provided for @settingsReset.
  ///
  /// In zh, this message translates to:
  /// **'重置'**
  String get settingsReset;

  /// No description provided for @settingsResetSucceededRestartRequired.
  ///
  /// In zh, this message translates to:
  /// **'重置成功，重启生效'**
  String get settingsResetSucceededRestartRequired;

  /// No description provided for @settingsScaleRatio.
  ///
  /// In zh, this message translates to:
  /// **'缩放比例'**
  String get settingsScaleRatio;

  /// No description provided for @settingsSpringParametersTitle.
  ///
  /// In zh, this message translates to:
  /// **'弹簧参数'**
  String get settingsSpringParametersTitle;

  /// No description provided for @settingsSpringDurationMode.
  ///
  /// In zh, this message translates to:
  /// **'滑动时间'**
  String get settingsSpringDurationMode;

  /// No description provided for @settingsSpringPhysicalMode.
  ///
  /// In zh, this message translates to:
  /// **'物理参数'**
  String get settingsSpringPhysicalMode;

  /// No description provided for @settingsListMaxColumnWidth.
  ///
  /// In zh, this message translates to:
  /// **'列表最大列宽度（默认 240 dp）'**
  String get settingsListMaxColumnWidth;

  /// No description provided for @settingsHomeRecommendationFeed.
  ///
  /// In zh, this message translates to:
  /// **'主页推荐流'**
  String get settingsHomeRecommendationFeed;

  /// No description provided for @settingsConfirmDarkColor.
  ///
  /// In zh, this message translates to:
  /// **'确认使用 {color}？'**
  String settingsConfirmDarkColor(String color);

  /// No description provided for @settingsDarkColorWarning.
  ///
  /// In zh, this message translates to:
  /// **'所选颜色过于昏暗，可能会影响图片观看'**
  String get settingsDarkColorWarning;

  /// No description provided for @settingsUseServerSideDecoration.
  ///
  /// In zh, this message translates to:
  /// **'使用 SSD（Server-Side Decoration）'**
  String get settingsUseServerSideDecoration;

  /// No description provided for @settingsUpPositionTop.
  ///
  /// In zh, this message translates to:
  /// **'顶部'**
  String get settingsUpPositionTop;

  /// No description provided for @settingsUpPositionLeftFixed.
  ///
  /// In zh, this message translates to:
  /// **'左侧常驻'**
  String get settingsUpPositionLeftFixed;

  /// No description provided for @settingsUpPositionRightFixed.
  ///
  /// In zh, this message translates to:
  /// **'右侧常驻'**
  String get settingsUpPositionRightFixed;

  /// No description provided for @settingsUpPositionLeftDrawer.
  ///
  /// In zh, this message translates to:
  /// **'左侧抽屉'**
  String get settingsUpPositionLeftDrawer;

  /// No description provided for @settingsUpPositionRightDrawer.
  ///
  /// In zh, this message translates to:
  /// **'右侧抽屉'**
  String get settingsUpPositionRightDrawer;

  /// No description provided for @settingsBadgeHidden.
  ///
  /// In zh, this message translates to:
  /// **'隐藏'**
  String get settingsBadgeHidden;

  /// No description provided for @settingsBadgeDot.
  ///
  /// In zh, this message translates to:
  /// **'红点'**
  String get settingsBadgeDot;

  /// No description provided for @settingsBadgeNumber.
  ///
  /// In zh, this message translates to:
  /// **'数字'**
  String get settingsBadgeNumber;

  /// No description provided for @settingsUnreadPrivateMessages.
  ///
  /// In zh, this message translates to:
  /// **'私信'**
  String get settingsUnreadPrivateMessages;

  /// No description provided for @settingsUnreadReplies.
  ///
  /// In zh, this message translates to:
  /// **'回复我的'**
  String get settingsUnreadReplies;

  /// No description provided for @settingsUnreadMentions.
  ///
  /// In zh, this message translates to:
  /// **'@我'**
  String get settingsUnreadMentions;

  /// No description provided for @settingsUnreadLikes.
  ///
  /// In zh, this message translates to:
  /// **'收到的赞'**
  String get settingsUnreadLikes;

  /// No description provided for @settingsUnreadSystem.
  ///
  /// In zh, this message translates to:
  /// **'系统通知'**
  String get settingsUnreadSystem;

  /// No description provided for @settingsBarCollapseInstant.
  ///
  /// In zh, this message translates to:
  /// **'即时'**
  String get settingsBarCollapseInstant;

  /// No description provided for @settingsBarCollapseSynchronized.
  ///
  /// In zh, this message translates to:
  /// **'同步'**
  String get settingsBarCollapseSynchronized;

  /// No description provided for @settingsMinimizeOnExit.
  ///
  /// In zh, this message translates to:
  /// **'退出时最小化'**
  String get settingsMinimizeOnExit;

  /// No description provided for @settingsCachePath.
  ///
  /// In zh, this message translates to:
  /// **'缓存路径'**
  String get settingsCachePath;

  /// No description provided for @settingsSponsorBlock.
  ///
  /// In zh, this message translates to:
  /// **'空降助手'**
  String get settingsSponsorBlock;

  /// No description provided for @settingsAnimeIntroOutroSkip.
  ///
  /// In zh, this message translates to:
  /// **'番剧片头／片尾跳过类型'**
  String get settingsAnimeIntroOutroSkip;

  /// No description provided for @settingsCheckUnreadFeed.
  ///
  /// In zh, this message translates to:
  /// **'检查未读动态'**
  String get settingsCheckUnreadFeed;

  /// No description provided for @settingsCheckUnreadFeedDescription.
  ///
  /// In zh, this message translates to:
  /// **'点击设置检查周期（分钟）'**
  String get settingsCheckUnreadFeedDescription;

  /// No description provided for @settingsVideoChapters.
  ///
  /// In zh, this message translates to:
  /// **'显示视频分段信息'**
  String get settingsVideoChapters;

  /// No description provided for @settingsRelatedVideos.
  ///
  /// In zh, this message translates to:
  /// **'视频页显示相关视频'**
  String get settingsRelatedVideos;

  /// No description provided for @settingsVideoComments.
  ///
  /// In zh, this message translates to:
  /// **'显示视频评论'**
  String get settingsVideoComments;

  /// No description provided for @settingsAnimeComments.
  ///
  /// In zh, this message translates to:
  /// **'显示番剧评论'**
  String get settingsAnimeComments;

  /// No description provided for @settingsExpandVideoDescription.
  ///
  /// In zh, this message translates to:
  /// **'默认展开视频简介'**
  String get settingsExpandVideoDescription;

  /// No description provided for @settingsExpandVideoDescriptionLandscape.
  ///
  /// In zh, this message translates to:
  /// **'横屏自动展开视频简介'**
  String get settingsExpandVideoDescriptionLandscape;

  /// No description provided for @settingsLandscapeEpisodeTabs.
  ///
  /// In zh, this message translates to:
  /// **'横屏分 P／合集列表显示在 Tab 栏'**
  String get settingsLandscapeEpisodeTabs;

  /// No description provided for @settingsLandscapeUploaderSidebar.
  ///
  /// In zh, this message translates to:
  /// **'横屏播放页在侧栏打开 UP 主主页'**
  String get settingsLandscapeUploaderSidebar;

  /// No description provided for @settingsLandscapeImagePreview.
  ///
  /// In zh, this message translates to:
  /// **'横屏在侧栏打开图片预览'**
  String get settingsLandscapeImagePreview;

  /// No description provided for @settingsCommentFoldLines.
  ///
  /// In zh, this message translates to:
  /// **'评论折叠行数'**
  String get settingsCommentFoldLines;

  /// No description provided for @settingsZeroLinesDoNotFold.
  ///
  /// In zh, this message translates to:
  /// **'0 行时不折叠'**
  String get settingsZeroLinesDoNotFold;

  /// No description provided for @settingsLineCount.
  ///
  /// In zh, this message translates to:
  /// **'{count} 行'**
  String settingsLineCount(String count);

  /// No description provided for @settingsDanmakuLineHeight.
  ///
  /// In zh, this message translates to:
  /// **'弹幕行高'**
  String get settingsDanmakuLineHeight;

  /// No description provided for @settingsDefaultNumber.
  ///
  /// In zh, this message translates to:
  /// **'默认 {value}'**
  String settingsDefaultNumber(String value);

  /// No description provided for @settingsVideoWarnings.
  ///
  /// In zh, this message translates to:
  /// **'显示视频警告／争议信息'**
  String get settingsVideoWarnings;

  /// No description provided for @settingsFeedWarnings.
  ///
  /// In zh, this message translates to:
  /// **'显示动态警告／争议信息'**
  String get settingsFeedWarnings;

  /// No description provided for @settingsReverseEpisodesFromFirst.
  ///
  /// In zh, this message translates to:
  /// **'分 P／合集：倒序播放从首集开始'**
  String get settingsReverseEpisodesFromFirst;

  /// No description provided for @settingsReverseEpisodesFromFirstDescription.
  ///
  /// In zh, this message translates to:
  /// **'开启后自动切换到倒序首集，否则保持当前集'**
  String get settingsReverseEpisodesFromFirstDescription;

  /// No description provided for @settingsDisableSslVerification.
  ///
  /// In zh, this message translates to:
  /// **'禁用 SSL 证书验证'**
  String get settingsDisableSslVerification;

  /// No description provided for @settingsDisableSslVerificationDescription.
  ///
  /// In zh, this message translates to:
  /// **'请谨慎开启，禁用后容易受到中间人攻击'**
  String get settingsDisableSslVerificationDescription;

  /// No description provided for @settingsContinuePartPrompt.
  ///
  /// In zh, this message translates to:
  /// **'显示继续播放分 P 提示'**
  String get settingsContinuePartPrompt;

  /// No description provided for @settingsCommentKeywordFilter.
  ///
  /// In zh, this message translates to:
  /// **'评论关键词过滤'**
  String get settingsCommentKeywordFilter;

  /// No description provided for @settingsFeedKeywordFilter.
  ///
  /// In zh, this message translates to:
  /// **'动态关键词过滤'**
  String get settingsFeedKeywordFilter;

  /// No description provided for @settingsExternalBrowser.
  ///
  /// In zh, this message translates to:
  /// **'使用外部浏览器打开链接'**
  String get settingsExternalBrowser;

  /// No description provided for @settingsHorizontalSwipeThreshold.
  ///
  /// In zh, this message translates to:
  /// **'横向滑动阈值'**
  String get settingsHorizontalSwipeThreshold;

  /// No description provided for @settingsCurrentAndSystemDefault.
  ///
  /// In zh, this message translates to:
  /// **'当前：{current}；系统默认值：{defaultValue}'**
  String settingsCurrentAndSystemDefault(String current, String defaultValue);

  /// No description provided for @settingsRefreshDragDistance.
  ///
  /// In zh, this message translates to:
  /// **'刷新滑动距离'**
  String get settingsRefreshDragDistance;

  /// No description provided for @settingsCurrentMultiplier.
  ///
  /// In zh, this message translates to:
  /// **'当前：{value}×'**
  String settingsCurrentMultiplier(String value);

  /// No description provided for @settingsRefreshIndicatorHeight.
  ///
  /// In zh, this message translates to:
  /// **'刷新指示器高度'**
  String get settingsRefreshIndicatorHeight;

  /// No description provided for @settingsVipDanmaku.
  ///
  /// In zh, this message translates to:
  /// **'显示会员彩色弹幕'**
  String get settingsVipDanmaku;

  /// No description provided for @settingsMergeDanmaku.
  ///
  /// In zh, this message translates to:
  /// **'合并弹幕'**
  String get settingsMergeDanmaku;

  /// No description provided for @settingsMergeDanmakuDescription.
  ///
  /// In zh, this message translates to:
  /// **'合并一段时间内获取到的相同弹幕'**
  String get settingsMergeDanmakuDescription;

  /// No description provided for @settingsTrendingRecommendations.
  ///
  /// In zh, this message translates to:
  /// **'显示热门推荐'**
  String get settingsTrendingRecommendations;

  /// No description provided for @settingsTrendingRecommendationsDescription.
  ///
  /// In zh, this message translates to:
  /// **'热门页面显示每周必看等推荐内容入口'**
  String get settingsTrendingRecommendationsDescription;

  /// No description provided for @settingsAudioNormalization.
  ///
  /// In zh, this message translates to:
  /// **'音量均衡'**
  String get settingsAudioNormalization;

  /// No description provided for @settingsFallbackNormalization.
  ///
  /// In zh, this message translates to:
  /// **'服务器无 loudnorm 配置时使用'**
  String get settingsFallbackNormalization;

  /// No description provided for @settingsFallbackValue.
  ///
  /// In zh, this message translates to:
  /// **'无参数时：{value}'**
  String settingsFallbackValue(String value);

  /// No description provided for @settingsAudioNormalizationDisabled.
  ///
  /// In zh, this message translates to:
  /// **'禁用'**
  String get settingsAudioNormalizationDisabled;

  /// No description provided for @settingsAudioNormalizationDynaudnorm.
  ///
  /// In zh, this message translates to:
  /// **'预设 dynaudnorm'**
  String get settingsAudioNormalizationDynaudnorm;

  /// No description provided for @settingsAudioNormalizationLoudnorm.
  ///
  /// In zh, this message translates to:
  /// **'预设 loudnorm'**
  String get settingsAudioNormalizationLoudnorm;

  /// No description provided for @settingsCustomParameters.
  ///
  /// In zh, this message translates to:
  /// **'自定义参数'**
  String get settingsCustomParameters;

  /// No description provided for @settingsAudioNormalizationParameterHelp.
  ///
  /// In zh, this message translates to:
  /// **'等同于 --lavfi-complex=\"[aid1] 参数 [ao]\"'**
  String get settingsAudioNormalizationParameterHelp;

  /// No description provided for @settingsSuperResolution.
  ///
  /// In zh, this message translates to:
  /// **'超分辨率'**
  String get settingsSuperResolution;

  /// No description provided for @settingsSuperResolutionDescription.
  ///
  /// In zh, this message translates to:
  /// **'当前：{value}\n默认设置对番剧生效，其它视频默认关闭\n超分辨率需要启用硬件解码；若仍未生效，请尝试将硬件解码器切换为 auto-copy'**
  String settingsSuperResolutionDescription(String value);

  /// No description provided for @settingsPreinitializePlayer.
  ///
  /// In zh, this message translates to:
  /// **'提前初始化播放器'**
  String get settingsPreinitializePlayer;

  /// No description provided for @settingsPreinitializePlayerDescription.
  ///
  /// In zh, this message translates to:
  /// **'相对减少手动播放的加载时间'**
  String get settingsPreinitializePlayerDescription;

  /// No description provided for @settingsHomePageAnimation.
  ///
  /// In zh, this message translates to:
  /// **'首页切换页面动画'**
  String get settingsHomePageAnimation;

  /// No description provided for @settingsSearchSuggestions.
  ///
  /// In zh, this message translates to:
  /// **'搜索建议'**
  String get settingsSearchSuggestions;

  /// No description provided for @settingsSearchHistory.
  ///
  /// In zh, this message translates to:
  /// **'记录搜索历史'**
  String get settingsSearchHistory;

  /// No description provided for @settingsShowDecorations.
  ///
  /// In zh, this message translates to:
  /// **'展示头像、评论和动态装饰'**
  String get settingsShowDecorations;

  /// No description provided for @settingsFanMedals.
  ///
  /// In zh, this message translates to:
  /// **'显示粉丝勋章'**
  String get settingsFanMedals;

  /// No description provided for @settingsLivePhotoPreview.
  ///
  /// In zh, this message translates to:
  /// **'预览 Live Photo'**
  String get settingsLivePhotoPreview;

  /// No description provided for @settingsLivePhotoPreviewDescription.
  ///
  /// In zh, this message translates to:
  /// **'开启后以视频形式预览 Live Photo，否则预览静态图片'**
  String get settingsLivePhotoPreviewDescription;

  /// No description provided for @settingsSeekPreviewThumbnails.
  ///
  /// In zh, this message translates to:
  /// **'滑动跳转预览视频缩略图'**
  String get settingsSeekPreviewThumbnails;

  /// No description provided for @settingsDanmakuHeatmap.
  ///
  /// In zh, this message translates to:
  /// **'显示高能进度条'**
  String get settingsDanmakuHeatmap;

  /// No description provided for @settingsDanmakuHeatmapDescription.
  ///
  /// In zh, this message translates to:
  /// **'高能进度条反映单位时间内弹幕发送量的变化趋势'**
  String get settingsDanmakuHeatmapDescription;

  /// No description provided for @settingsSaveComments.
  ///
  /// In zh, this message translates to:
  /// **'记录评论'**
  String get settingsSaveComments;

  /// No description provided for @settingsCommentAntifraud.
  ///
  /// In zh, this message translates to:
  /// **'发评反诈'**
  String get settingsCommentAntifraud;

  /// No description provided for @settingsCommentAntifraudDescription.
  ///
  /// In zh, this message translates to:
  /// **'发送评论后检查评论是否可见'**
  String get settingsCommentAntifraudDescription;

  /// No description provided for @settingsUseBilibiliCommentCheck.
  ///
  /// In zh, this message translates to:
  /// **'使用“哔哩发评反诈”检查评论'**
  String get settingsUseBilibiliCommentCheck;

  /// No description provided for @settingsFeedPostAntifraud.
  ///
  /// In zh, this message translates to:
  /// **'发布／转发动态反诈'**
  String get settingsFeedPostAntifraud;

  /// No description provided for @settingsFeedPostAntifraudDescription.
  ///
  /// In zh, this message translates to:
  /// **'发布／转发后检查动态内容是否可见'**
  String get settingsFeedPostAntifraudDescription;

  /// No description provided for @settingsBlockShoppingPosts.
  ///
  /// In zh, this message translates to:
  /// **'屏蔽带货动态'**
  String get settingsBlockShoppingPosts;

  /// No description provided for @settingsBlockShoppingComments.
  ///
  /// In zh, this message translates to:
  /// **'屏蔽带货评论'**
  String get settingsBlockShoppingComments;

  /// No description provided for @settingsSwipeToCloseSecondaryPages.
  ///
  /// In zh, this message translates to:
  /// **'侧滑关闭二级页面'**
  String get settingsSwipeToCloseSecondaryPages;

  /// No description provided for @settingsPinchToShrinkVideo.
  ///
  /// In zh, this message translates to:
  /// **'启用双指缩小视频'**
  String get settingsPinchToShrinkVideo;

  /// No description provided for @settingsSecondaryPageActionBar.
  ///
  /// In zh, this message translates to:
  /// **'动态／专栏详情页展示底部操作栏'**
  String get settingsSecondaryPageActionBar;

  /// No description provided for @settingsDragSubtitles.
  ///
  /// In zh, this message translates to:
  /// **'启用拖拽字幕调整底部边距'**
  String get settingsDragSubtitles;

  /// No description provided for @settingsAnimeSchedule.
  ///
  /// In zh, this message translates to:
  /// **'展示追番时间表'**
  String get settingsAnimeSchedule;

  /// No description provided for @settingsSilentImageDownload.
  ///
  /// In zh, this message translates to:
  /// **'静默下载图片'**
  String get settingsSilentImageDownload;

  /// No description provided for @settingsSilentImageDownloadDescription.
  ///
  /// In zh, this message translates to:
  /// **'不显示下载 Loading 弹窗'**
  String get settingsSilentImageDownloadDescription;

  /// No description provided for @settingsImageContextMenu.
  ///
  /// In zh, this message translates to:
  /// **'长按／右键显示图片菜单'**
  String get settingsImageContextMenu;

  /// No description provided for @settingsHapticFeedback.
  ///
  /// In zh, this message translates to:
  /// **'振动反馈'**
  String get settingsHapticFeedback;

  /// No description provided for @settingsHapticFeedbackDescription.
  ///
  /// In zh, this message translates to:
  /// **'请确认手机系统设置中已开启振动反馈'**
  String get settingsHapticFeedbackDescription;

  /// No description provided for @settingsTrendingSearches.
  ///
  /// In zh, this message translates to:
  /// **'大家都在搜'**
  String get settingsTrendingSearches;

  /// No description provided for @settingsTrendingSearchesDescription.
  ///
  /// In zh, this message translates to:
  /// **'展示“大家都在搜”'**
  String get settingsTrendingSearchesDescription;

  /// No description provided for @settingsSearchDiscovery.
  ///
  /// In zh, this message translates to:
  /// **'搜索发现'**
  String get settingsSearchDiscovery;

  /// No description provided for @settingsSearchDiscoveryDescription.
  ///
  /// In zh, this message translates to:
  /// **'展示“搜索发现”'**
  String get settingsSearchDiscoveryDescription;

  /// No description provided for @settingsDefaultSearchTerm.
  ///
  /// In zh, this message translates to:
  /// **'搜索默认词'**
  String get settingsDefaultSearchTerm;

  /// No description provided for @settingsDefaultSearchTermDescription.
  ///
  /// In zh, this message translates to:
  /// **'在搜索框中展示默认词'**
  String get settingsDefaultSearchTermDescription;

  /// No description provided for @settingsQuickFavorite.
  ///
  /// In zh, this message translates to:
  /// **'快速收藏'**
  String get settingsQuickFavorite;

  /// No description provided for @settingsQuickFavoriteDescription.
  ///
  /// In zh, this message translates to:
  /// **'点击设置默认收藏夹\n点按收藏至默认收藏夹，长按选择文件夹'**
  String get settingsQuickFavoriteDescription;

  /// No description provided for @settingsCommentSearchKeywords.
  ///
  /// In zh, this message translates to:
  /// **'评论区搜索关键词'**
  String get settingsCommentSearchKeywords;

  /// No description provided for @settingsCommentSearchKeywordsDescription.
  ///
  /// In zh, this message translates to:
  /// **'展示评论区搜索关键词'**
  String get settingsCommentSearchKeywordsDescription;

  /// No description provided for @settingsAiSummary.
  ///
  /// In zh, this message translates to:
  /// **'启用 AI 总结'**
  String get settingsAiSummary;

  /// No description provided for @settingsAiSummaryDescription.
  ///
  /// In zh, this message translates to:
  /// **'在视频详情页开启 AI 总结'**
  String get settingsAiSummaryDescription;

  /// No description provided for @settingsDisableReceivedLikes.
  ///
  /// In zh, this message translates to:
  /// **'消息页禁用“收到的赞”'**
  String get settingsDisableReceivedLikes;

  /// No description provided for @settingsDisableReceivedLikesDescription.
  ///
  /// In zh, this message translates to:
  /// **'禁止打开入口，降低网络社交依赖'**
  String get settingsDisableReceivedLikesDescription;

  /// No description provided for @settingsShowCommentsByDefault.
  ///
  /// In zh, this message translates to:
  /// **'默认展示评论区'**
  String get settingsShowCommentsByDefault;

  /// No description provided for @settingsShowCommentsByDefaultDescription.
  ///
  /// In zh, this message translates to:
  /// **'视频详情页默认切换至评论区（仅 Tab 型布局）'**
  String get settingsShowCommentsByDefaultDescription;

  /// No description provided for @settingsHttp2.
  ///
  /// In zh, this message translates to:
  /// **'启用 HTTP/2'**
  String get settingsHttp2;

  /// No description provided for @settingsRetryCount.
  ///
  /// In zh, this message translates to:
  /// **'连接重试次数'**
  String get settingsRetryCount;

  /// No description provided for @settingsZeroDisables.
  ///
  /// In zh, this message translates to:
  /// **'设为 0 时禁用'**
  String get settingsZeroDisables;

  /// No description provided for @settingsRetryDelay.
  ///
  /// In zh, this message translates to:
  /// **'连接重试间隔'**
  String get settingsRetryDelay;

  /// No description provided for @settingsRetryDelayDescription.
  ///
  /// In zh, this message translates to:
  /// **'实际间隔＝间隔 × 第 n 次重试'**
  String get settingsRetryDelayDescription;

  /// No description provided for @settingsCommentDisplay.
  ///
  /// In zh, this message translates to:
  /// **'评论展示'**
  String get settingsCommentDisplay;

  /// No description provided for @settingsCurrentlyPrioritize.
  ///
  /// In zh, this message translates to:
  /// **'当前优先展示“{value}”'**
  String settingsCurrentlyPrioritize(String value);

  /// No description provided for @settingsFeedDisplay.
  ///
  /// In zh, this message translates to:
  /// **'动态展示'**
  String get settingsFeedDisplay;

  /// No description provided for @settingsFeedInteractions.
  ///
  /// In zh, this message translates to:
  /// **'显示动态互动内容'**
  String get settingsFeedInteractions;

  /// No description provided for @settingsFeedInteractionsDescription.
  ///
  /// In zh, this message translates to:
  /// **'在动态卡片底部显示互动内容，例如关注的人点赞、热评等'**
  String get settingsFeedInteractionsDescription;

  /// No description provided for @settingsMemberDefaultTab.
  ///
  /// In zh, this message translates to:
  /// **'用户页默认展示 Tab'**
  String get settingsMemberDefaultTab;

  /// No description provided for @settingsUploaderShopTab.
  ///
  /// In zh, this message translates to:
  /// **'显示 UP 主主页小店 Tab'**
  String get settingsUploaderShopTab;

  /// No description provided for @settingsProxy.
  ///
  /// In zh, this message translates to:
  /// **'设置代理'**
  String get settingsProxy;

  /// No description provided for @settingsProxyDescription.
  ///
  /// In zh, this message translates to:
  /// **'设置代理 host:port'**
  String get settingsProxyDescription;

  /// No description provided for @settingsProxyHostHint.
  ///
  /// In zh, this message translates to:
  /// **'请输入 Host，使用 . 分隔'**
  String get settingsProxyHostHint;

  /// No description provided for @settingsProxyPortHint.
  ///
  /// In zh, this message translates to:
  /// **'请输入 Port'**
  String get settingsProxyPortHint;

  /// No description provided for @settingsMaximumCacheSize.
  ///
  /// In zh, this message translates to:
  /// **'最大缓存大小'**
  String get settingsMaximumCacheSize;

  /// No description provided for @settingsCurrentMaximumCacheSize.
  ///
  /// In zh, this message translates to:
  /// **'当前最大缓存大小：{value}'**
  String settingsCurrentMaximumCacheSize(String value);

  /// No description provided for @settingsCheckForUpdates.
  ///
  /// In zh, this message translates to:
  /// **'检查更新'**
  String get settingsCheckForUpdates;

  /// No description provided for @settingsCheckForUpdatesDescription.
  ///
  /// In zh, this message translates to:
  /// **'每次启动时检查是否需要更新'**
  String get settingsCheckForUpdatesDescription;

  /// No description provided for @settingsSetNewPath.
  ///
  /// In zh, this message translates to:
  /// **'设置新路径'**
  String get settingsSetNewPath;

  /// No description provided for @settingsCheckInterval.
  ///
  /// In zh, this message translates to:
  /// **'检查周期'**
  String get settingsCheckInterval;

  /// No description provided for @settingsChooseDefaultFavorite.
  ///
  /// In zh, this message translates to:
  /// **'选择默认收藏夹'**
  String get settingsChooseDefaultFavorite;

  /// No description provided for @replySortNewest.
  ///
  /// In zh, this message translates to:
  /// **'最新评论'**
  String get replySortNewest;

  /// No description provided for @replySortHottest.
  ///
  /// In zh, this message translates to:
  /// **'最热评论'**
  String get replySortHottest;

  /// No description provided for @replySortFeatured.
  ///
  /// In zh, this message translates to:
  /// **'精选评论'**
  String get replySortFeatured;

  /// No description provided for @replySortNewestShort.
  ///
  /// In zh, this message translates to:
  /// **'最新'**
  String get replySortNewestShort;

  /// No description provided for @replySortHottestShort.
  ///
  /// In zh, this message translates to:
  /// **'最热'**
  String get replySortHottestShort;

  /// No description provided for @replySortFeaturedShort.
  ///
  /// In zh, this message translates to:
  /// **'精选'**
  String get replySortFeaturedShort;

  /// No description provided for @memberTabDefault.
  ///
  /// In zh, this message translates to:
  /// **'默认'**
  String get memberTabDefault;

  /// No description provided for @memberTabHome.
  ///
  /// In zh, this message translates to:
  /// **'主页'**
  String get memberTabHome;

  /// No description provided for @memberTabFeed.
  ///
  /// In zh, this message translates to:
  /// **'动态'**
  String get memberTabFeed;

  /// No description provided for @memberTabUploads.
  ///
  /// In zh, this message translates to:
  /// **'投稿'**
  String get memberTabUploads;

  /// No description provided for @memberTabFavorites.
  ///
  /// In zh, this message translates to:
  /// **'收藏'**
  String get memberTabFavorites;

  /// No description provided for @memberTabAnime.
  ///
  /// In zh, this message translates to:
  /// **'番剧'**
  String get memberTabAnime;

  /// No description provided for @memberTabCourses.
  ///
  /// In zh, this message translates to:
  /// **'课堂'**
  String get memberTabCourses;

  /// No description provided for @memberTabShop.
  ///
  /// In zh, this message translates to:
  /// **'小店'**
  String get memberTabShop;

  /// No description provided for @logsTitle.
  ///
  /// In zh, this message translates to:
  /// **'日志'**
  String get logsTitle;

  /// No description provided for @logsCopied.
  ///
  /// In zh, this message translates to:
  /// **'复制成功'**
  String get logsCopied;

  /// No description provided for @logsCleared.
  ///
  /// In zh, this message translates to:
  /// **'已清空'**
  String get logsCleared;

  /// No description provided for @logsTriggerError.
  ///
  /// In zh, this message translates to:
  /// **'引发错误'**
  String get logsTriggerError;

  /// No description provided for @logsEnabledRestartRequired.
  ///
  /// In zh, this message translates to:
  /// **'已开启，重启生效'**
  String get logsEnabledRestartRequired;

  /// No description provided for @logsDisabledRestartRequired.
  ///
  /// In zh, this message translates to:
  /// **'已关闭，重启生效'**
  String get logsDisabledRestartRequired;

  /// No description provided for @logsEnable.
  ///
  /// In zh, this message translates to:
  /// **'开启日志'**
  String get logsEnable;

  /// No description provided for @logsDisable.
  ///
  /// In zh, this message translates to:
  /// **'关闭日志'**
  String get logsDisable;

  /// No description provided for @logsCopy.
  ///
  /// In zh, this message translates to:
  /// **'复制日志'**
  String get logsCopy;

  /// No description provided for @logsErrorFeedback.
  ///
  /// In zh, this message translates to:
  /// **'错误反馈'**
  String get logsErrorFeedback;

  /// No description provided for @logsClear.
  ///
  /// In zh, this message translates to:
  /// **'清空日志'**
  String get logsClear;

  /// No description provided for @logsRelatedInformation.
  ///
  /// In zh, this message translates to:
  /// **'相关信息'**
  String get logsRelatedInformation;

  /// No description provided for @logsCollapse.
  ///
  /// In zh, this message translates to:
  /// **'收起'**
  String get logsCollapse;

  /// No description provided for @logsExpand.
  ///
  /// In zh, this message translates to:
  /// **'展开'**
  String get logsExpand;

  /// No description provided for @logsDeviceInformation.
  ///
  /// In zh, this message translates to:
  /// **'设备信息'**
  String get logsDeviceInformation;

  /// No description provided for @logsAppInformation.
  ///
  /// In zh, this message translates to:
  /// **'应用信息'**
  String get logsAppInformation;

  /// No description provided for @logsBuildInformation.
  ///
  /// In zh, this message translates to:
  /// **'编译信息'**
  String get logsBuildInformation;

  /// No description provided for @logsCopiedTimestamp.
  ///
  /// In zh, this message translates to:
  /// **'已将 {time} 复制至剪贴板'**
  String logsCopiedTimestamp(String time);

  /// No description provided for @logsErrorDetails.
  ///
  /// In zh, this message translates to:
  /// **'错误详情'**
  String get logsErrorDetails;

  /// No description provided for @logsStackTrace.
  ///
  /// In zh, this message translates to:
  /// **'堆栈跟踪'**
  String get logsStackTrace;

  /// No description provided for @settingsPlaybackSpeedSetDefault.
  ///
  /// In zh, this message translates to:
  /// **'设置为默认倍速'**
  String get settingsPlaybackSpeedSetDefault;

  /// No description provided for @settingsPlaybackSpeedSetLongPress.
  ///
  /// In zh, this message translates to:
  /// **'设置为默认长按倍速'**
  String get settingsPlaybackSpeedSetLongPress;

  /// No description provided for @settingsPlaybackSpeedDelete.
  ///
  /// In zh, this message translates to:
  /// **'删除该项'**
  String get settingsPlaybackSpeedDelete;

  /// No description provided for @settingsPlaybackSpeedAdd.
  ///
  /// In zh, this message translates to:
  /// **'添加倍速'**
  String get settingsPlaybackSpeedAdd;

  /// No description provided for @settingsPlaybackSpeedCustom.
  ///
  /// In zh, this message translates to:
  /// **'自定义倍速'**
  String get settingsPlaybackSpeedCustom;

  /// No description provided for @settingsPlaybackSpeedExists.
  ///
  /// In zh, this message translates to:
  /// **'该倍速已存在'**
  String get settingsPlaybackSpeedExists;

  /// No description provided for @settingsPlaybackSpeedDefaultCannotDelete.
  ///
  /// In zh, this message translates to:
  /// **'不支持删除默认倍速'**
  String get settingsPlaybackSpeedDefaultCannotDelete;

  /// No description provided for @settingsPlaybackSpeedHint.
  ///
  /// In zh, this message translates to:
  /// **'点击下方按钮设置默认倍速和长按倍速'**
  String get settingsPlaybackSpeedHint;

  /// No description provided for @settingsPlaybackSpeedDefault.
  ///
  /// In zh, this message translates to:
  /// **'默认倍速'**
  String get settingsPlaybackSpeedDefault;

  /// No description provided for @settingsPlaybackSpeedDynamicLongPress.
  ///
  /// In zh, this message translates to:
  /// **'动态长按倍速'**
  String get settingsPlaybackSpeedDynamicLongPress;

  /// No description provided for @settingsPlaybackSpeedDynamicLongPressDescription.
  ///
  /// In zh, this message translates to:
  /// **'根据默认倍速，长按时自动使用双倍速度'**
  String get settingsPlaybackSpeedDynamicLongPressDescription;

  /// No description provided for @settingsPlaybackSpeedDefaultLongPress.
  ///
  /// In zh, this message translates to:
  /// **'默认长按倍速'**
  String get settingsPlaybackSpeedDefaultLongPress;

  /// No description provided for @settingsPlaybackSpeedList.
  ///
  /// In zh, this message translates to:
  /// **'倍速列表'**
  String get settingsPlaybackSpeedList;

  /// No description provided for @settingsAdd.
  ///
  /// In zh, this message translates to:
  /// **'添加'**
  String get settingsAdd;

  /// No description provided for @settingsSavedNextLaunch.
  ///
  /// In zh, this message translates to:
  /// **'保存成功，下次启动时生效'**
  String get settingsSavedNextLaunch;

  /// No description provided for @settingsResetNextLaunch.
  ///
  /// In zh, this message translates to:
  /// **'重置成功，下次启动时生效'**
  String get settingsResetNextLaunch;

  /// No description provided for @settingsEditTitle.
  ///
  /// In zh, this message translates to:
  /// **'{title}编辑'**
  String settingsEditTitle(String title);

  /// No description provided for @settingsSave.
  ///
  /// In zh, this message translates to:
  /// **'保存'**
  String get settingsSave;

  /// No description provided for @settingsLongPressToReorder.
  ///
  /// In zh, this message translates to:
  /// **'长按拖动排序'**
  String get settingsLongPressToReorder;

  /// No description provided for @settingsCurrentFontSize.
  ///
  /// In zh, this message translates to:
  /// **'当前字体大小：{value}'**
  String settingsCurrentFontSize(String value);

  /// No description provided for @settingsSmall.
  ///
  /// In zh, this message translates to:
  /// **'小'**
  String get settingsSmall;

  /// No description provided for @settingsLarge.
  ///
  /// In zh, this message translates to:
  /// **'大'**
  String get settingsLarge;

  /// No description provided for @settingsScreenRefreshRateTitle.
  ///
  /// In zh, this message translates to:
  /// **'屏幕帧率设置'**
  String get settingsScreenRefreshRateTitle;

  /// No description provided for @settingsRestartIfDisplayModeFails.
  ///
  /// In zh, this message translates to:
  /// **'没有生效？请尝试重启 App'**
  String get settingsRestartIfDisplayModeFails;

  /// No description provided for @settingsAutomatic.
  ///
  /// In zh, this message translates to:
  /// **'自动'**
  String get settingsAutomatic;

  /// No description provided for @settingsSystemModeMarker.
  ///
  /// In zh, this message translates to:
  /// **'系统'**
  String get settingsSystemModeMarker;

  /// No description provided for @settingsChooseAppTheme.
  ///
  /// In zh, this message translates to:
  /// **'选择应用主题'**
  String get settingsChooseAppTheme;

  /// No description provided for @settingsPaletteStyle.
  ///
  /// In zh, this message translates to:
  /// **'调色板风格'**
  String get settingsPaletteStyle;

  /// No description provided for @settingsDynamicColorUnsupported.
  ///
  /// In zh, this message translates to:
  /// **'设备可能不支持动态取色'**
  String get settingsDynamicColorUnsupported;

  /// No description provided for @settingsUseFont.
  ///
  /// In zh, this message translates to:
  /// **'使用 {font}'**
  String settingsUseFont(String font);

  /// No description provided for @settingsViewLicense.
  ///
  /// In zh, this message translates to:
  /// **'查看许可协议'**
  String get settingsViewLicense;

  /// No description provided for @settingsAgreeAndDownload.
  ///
  /// In zh, this message translates to:
  /// **'同意并下载'**
  String get settingsAgreeAndDownload;

  /// No description provided for @settingsFontDownloaded.
  ///
  /// In zh, this message translates to:
  /// **'{font} 下载完成'**
  String settingsFontDownloaded(String font);

  /// No description provided for @settingsFontDownloading.
  ///
  /// In zh, this message translates to:
  /// **'正在下载 {progress}%'**
  String settingsFontDownloading(int progress);

  /// No description provided for @settingsFontConnecting.
  ///
  /// In zh, this message translates to:
  /// **'正在连接下载源'**
  String get settingsFontConnecting;

  /// No description provided for @settingsDownloadedWithSize.
  ///
  /// In zh, this message translates to:
  /// **'已下载 · {size}'**
  String settingsDownloadedWithSize(String size);

  /// No description provided for @settingsDownloaded.
  ///
  /// In zh, this message translates to:
  /// **'已下载'**
  String get settingsDownloaded;

  /// No description provided for @settingsDownloadFont.
  ///
  /// In zh, this message translates to:
  /// **'下载字体'**
  String get settingsDownloadFont;

  /// No description provided for @settingsFontErrorIncompleteFile.
  ///
  /// In zh, this message translates to:
  /// **'字体文件不完整，请重新下载'**
  String get settingsFontErrorIncompleteFile;

  /// No description provided for @settingsFontErrorLoadFailed.
  ///
  /// In zh, this message translates to:
  /// **'字体加载失败，请重新下载'**
  String get settingsFontErrorLoadFailed;

  /// No description provided for @settingsFontErrorHttp.
  ///
  /// In zh, this message translates to:
  /// **'字体下载失败（HTTP {status}）'**
  String settingsFontErrorHttp(String status);

  /// No description provided for @settingsFontErrorLicenseExtraction.
  ///
  /// In zh, this message translates to:
  /// **'字体许可文件提取失败，请重试'**
  String get settingsFontErrorLicenseExtraction;

  /// No description provided for @settingsFontErrorDownloadFailed.
  ///
  /// In zh, this message translates to:
  /// **'字体下载失败，请稍后重试'**
  String get settingsFontErrorDownloadFailed;

  /// No description provided for @settingsFontErrorSizeMismatch.
  ///
  /// In zh, this message translates to:
  /// **'字体文件大小校验失败，请重试'**
  String get settingsFontErrorSizeMismatch;

  /// No description provided for @settingsFontErrorChecksumMismatch.
  ///
  /// In zh, this message translates to:
  /// **'字体校验失败，请重试'**
  String get settingsFontErrorChecksumMismatch;

  /// No description provided for @settingsFontErrorTimeout.
  ///
  /// In zh, this message translates to:
  /// **'字体下载连接超时，请检查网络后重试'**
  String get settingsFontErrorTimeout;

  /// No description provided for @settingsFontErrorNetwork.
  ///
  /// In zh, this message translates to:
  /// **'无法下载字体，请检查网络'**
  String get settingsFontErrorNetwork;

  /// No description provided for @settingsFontErrorSaveFailed.
  ///
  /// In zh, this message translates to:
  /// **'字体文件保存失败，请检查存储空间'**
  String get settingsFontErrorSaveFailed;

  /// No description provided for @settingsAppFontTitle.
  ///
  /// In zh, this message translates to:
  /// **'App 字体'**
  String get settingsAppFontTitle;

  /// No description provided for @settingsFontLxgwWenKai.
  ///
  /// In zh, this message translates to:
  /// **'霞鹜文楷'**
  String get settingsFontLxgwWenKai;

  /// No description provided for @settingsFontLxgwZhenKai.
  ///
  /// In zh, this message translates to:
  /// **'霞鹜臻楷'**
  String get settingsFontLxgwZhenKai;

  /// No description provided for @settingsFontLxgwNeoXiHei.
  ///
  /// In zh, this message translates to:
  /// **'霞鹜新晰黑'**
  String get settingsFontLxgwNeoXiHei;

  /// No description provided for @settingsFontLxgwZhuqueFangsong.
  ///
  /// In zh, this message translates to:
  /// **'霞鹜朱雀仿宋'**
  String get settingsFontLxgwZhuqueFangsong;

  /// No description provided for @settingsFontSourceHanSans.
  ///
  /// In zh, this message translates to:
  /// **'思源黑体'**
  String get settingsFontSourceHanSans;

  /// No description provided for @settingsFontSourceHanSerif.
  ///
  /// In zh, this message translates to:
  /// **'思源宋体'**
  String get settingsFontSourceHanSerif;

  /// No description provided for @settingsFontFusionPixel.
  ///
  /// In zh, this message translates to:
  /// **'缝合像素字体'**
  String get settingsFontFusionPixel;

  /// No description provided for @settingsFontLicenseNotice.
  ///
  /// In zh, this message translates to:
  /// **'本软件将使用 {font}。下载和使用即表示你同意其官方许可协议。'**
  String settingsFontLicenseNotice(String font);

  /// No description provided for @settingsFullscreenSuperChatSizeTitle.
  ///
  /// In zh, this message translates to:
  /// **'全屏 SC 大小设置'**
  String get settingsFullscreenSuperChatSizeTitle;

  /// No description provided for @themeColorDefaultGreen.
  ///
  /// In zh, this message translates to:
  /// **'默认绿'**
  String get themeColorDefaultGreen;

  /// No description provided for @themeColorPink.
  ///
  /// In zh, this message translates to:
  /// **'粉红色'**
  String get themeColorPink;

  /// No description provided for @themeColorRed.
  ///
  /// In zh, this message translates to:
  /// **'红色'**
  String get themeColorRed;

  /// No description provided for @themeColorOrange.
  ///
  /// In zh, this message translates to:
  /// **'橙色'**
  String get themeColorOrange;

  /// No description provided for @themeColorAmber.
  ///
  /// In zh, this message translates to:
  /// **'琥珀色'**
  String get themeColorAmber;

  /// No description provided for @themeColorYellow.
  ///
  /// In zh, this message translates to:
  /// **'黄色'**
  String get themeColorYellow;

  /// No description provided for @themeColorLime.
  ///
  /// In zh, this message translates to:
  /// **'酸橙色'**
  String get themeColorLime;

  /// No description provided for @themeColorLightGreen.
  ///
  /// In zh, this message translates to:
  /// **'浅绿色'**
  String get themeColorLightGreen;

  /// No description provided for @themeColorGreen.
  ///
  /// In zh, this message translates to:
  /// **'绿色'**
  String get themeColorGreen;

  /// No description provided for @themeColorTeal.
  ///
  /// In zh, this message translates to:
  /// **'青色'**
  String get themeColorTeal;

  /// No description provided for @themeColorCyan.
  ///
  /// In zh, this message translates to:
  /// **'蓝绿色'**
  String get themeColorCyan;

  /// No description provided for @themeColorLightBlue.
  ///
  /// In zh, this message translates to:
  /// **'浅蓝色'**
  String get themeColorLightBlue;

  /// No description provided for @themeColorBlue.
  ///
  /// In zh, this message translates to:
  /// **'蓝色'**
  String get themeColorBlue;

  /// No description provided for @themeColorIndigo.
  ///
  /// In zh, this message translates to:
  /// **'靛蓝色'**
  String get themeColorIndigo;

  /// No description provided for @themeColorPurple.
  ///
  /// In zh, this message translates to:
  /// **'紫色'**
  String get themeColorPurple;

  /// No description provided for @themeColorDeepPurple.
  ///
  /// In zh, this message translates to:
  /// **'深紫色'**
  String get themeColorDeepPurple;

  /// No description provided for @themeColorBlueGrey.
  ///
  /// In zh, this message translates to:
  /// **'蓝灰色'**
  String get themeColorBlueGrey;

  /// No description provided for @themeColorBrown.
  ///
  /// In zh, this message translates to:
  /// **'棕色'**
  String get themeColorBrown;

  /// No description provided for @themeColorGrey.
  ///
  /// In zh, this message translates to:
  /// **'灰色'**
  String get themeColorGrey;

  /// No description provided for @commonCopy.
  ///
  /// In zh, this message translates to:
  /// **'复制'**
  String get commonCopy;

  /// No description provided for @homeFollowingAnime.
  ///
  /// In zh, this message translates to:
  /// **'已追番'**
  String get homeFollowingAnime;

  /// No description provided for @homeRankings.
  ///
  /// In zh, this message translates to:
  /// **'排行榜'**
  String get homeRankings;

  /// No description provided for @homeWeeklyMustWatch.
  ///
  /// In zh, this message translates to:
  /// **'每周必看'**
  String get homeWeeklyMustWatch;

  /// No description provided for @homeEssentialVideos.
  ///
  /// In zh, this message translates to:
  /// **'入站必刷'**
  String get homeEssentialVideos;

  /// No description provided for @homeLastSeenRefresh.
  ///
  /// In zh, this message translates to:
  /// **'上次看到这里\n点击刷新'**
  String get homeLastSeenRefresh;

  /// No description provided for @homeSwitchToCover.
  ///
  /// In zh, this message translates to:
  /// **'切换封面'**
  String get homeSwitchToCover;

  /// No description provided for @homeSwitchToFirstFrame.
  ///
  /// In zh, this message translates to:
  /// **'切换首帧'**
  String get homeSwitchToFirstFrame;

  /// No description provided for @homeGameEvents.
  ///
  /// In zh, this message translates to:
  /// **'游戏赛事'**
  String get homeGameEvents;

  /// No description provided for @homeAllLiveCategories.
  ///
  /// In zh, this message translates to:
  /// **'全部标签'**
  String get homeAllLiveCategories;

  /// No description provided for @homeMyLiveFollowing.
  ///
  /// In zh, this message translates to:
  /// **'我的关注'**
  String get homeMyLiveFollowing;

  /// No description provided for @homeLiveFollowingCount.
  ///
  /// In zh, this message translates to:
  /// **'{count} 人正在直播'**
  String homeLiveFollowingCount(String count);

  /// No description provided for @aboutAppDescription.
  ///
  /// In zh, this message translates to:
  /// **'使用 Flutter 开发的 B 站第三方客户端'**
  String get aboutAppDescription;

  /// No description provided for @aboutAppSemantics.
  ///
  /// In zh, this message translates to:
  /// **'与你一起，发现不一样的世界'**
  String get aboutAppSemantics;

  /// No description provided for @aboutAccessibilityAdapted.
  ///
  /// In zh, this message translates to:
  /// **'无障碍适配'**
  String get aboutAccessibilityAdapted;

  /// No description provided for @aboutCurrentVersion.
  ///
  /// In zh, this message translates to:
  /// **'当前版本'**
  String get aboutCurrentVersion;

  /// No description provided for @aboutOpenSupportedLinks.
  ///
  /// In zh, this message translates to:
  /// **'打开受支持的链接'**
  String get aboutOpenSupportedLinks;

  /// No description provided for @aboutIssueFeedback.
  ///
  /// In zh, this message translates to:
  /// **'问题反馈'**
  String get aboutIssueFeedback;

  /// No description provided for @aboutErrorLogs.
  ///
  /// In zh, this message translates to:
  /// **'错误日志'**
  String get aboutErrorLogs;

  /// No description provided for @aboutClearLogsHint.
  ///
  /// In zh, this message translates to:
  /// **'长按清除日志'**
  String get aboutClearLogsHint;

  /// No description provided for @aboutClearCacheConfirm.
  ///
  /// In zh, this message translates to:
  /// **'该操作将清除图片及网络请求缓存数据，确认清除？'**
  String get aboutClearCacheConfirm;

  /// No description provided for @aboutClearing.
  ///
  /// In zh, this message translates to:
  /// **'正在清除…'**
  String get aboutClearing;

  /// No description provided for @aboutClearSucceeded.
  ///
  /// In zh, this message translates to:
  /// **'清除成功'**
  String get aboutClearSucceeded;

  /// No description provided for @aboutClearCache.
  ///
  /// In zh, this message translates to:
  /// **'清除缓存'**
  String get aboutClearCache;

  /// No description provided for @aboutImageNetworkCache.
  ///
  /// In zh, this message translates to:
  /// **'图片及网络缓存 {size}'**
  String aboutImageNetworkCache(Object size);

  /// No description provided for @aboutImportExportLogin.
  ///
  /// In zh, this message translates to:
  /// **'导入/导出登录信息'**
  String get aboutImportExportLogin;

  /// No description provided for @aboutLoginData.
  ///
  /// In zh, this message translates to:
  /// **'登录信息'**
  String get aboutLoginData;

  /// No description provided for @aboutImportExportSettings.
  ///
  /// In zh, this message translates to:
  /// **'导入/导出设置'**
  String get aboutImportExportSettings;

  /// No description provided for @aboutSettingsData.
  ///
  /// In zh, this message translates to:
  /// **'设置'**
  String get aboutSettingsData;

  /// No description provided for @aboutResetAllSettings.
  ///
  /// In zh, this message translates to:
  /// **'重置所有设置'**
  String get aboutResetAllSettings;

  /// No description provided for @aboutResetAllSettingsQuestion.
  ///
  /// In zh, this message translates to:
  /// **'是否重置所有设置？'**
  String get aboutResetAllSettingsQuestion;

  /// No description provided for @aboutResetSucceeded.
  ///
  /// In zh, this message translates to:
  /// **'重置成功'**
  String get aboutResetSucceeded;

  /// No description provided for @aboutResetExportableSettings.
  ///
  /// In zh, this message translates to:
  /// **'重置可导出的设置'**
  String get aboutResetExportableSettings;

  /// No description provided for @aboutResetAllData.
  ///
  /// In zh, this message translates to:
  /// **'重置所有数据（含登录信息）'**
  String get aboutResetAllData;

  /// No description provided for @importExportTitle.
  ///
  /// In zh, this message translates to:
  /// **'导入/导出{title}'**
  String importExportTitle(Object title);

  /// No description provided for @importConfirmPreview.
  ///
  /// In zh, this message translates to:
  /// **'是否导入如下{title}？'**
  String importConfirmPreview(Object title);

  /// No description provided for @importInputTitle.
  ///
  /// In zh, this message translates to:
  /// **'输入{title}'**
  String importInputTitle(Object title);

  /// No description provided for @importJsonParseFailed.
  ///
  /// In zh, this message translates to:
  /// **'解析 JSON 失败：{error}'**
  String importJsonParseFailed(Object error);

  /// No description provided for @importSucceeded.
  ///
  /// In zh, this message translates to:
  /// **'导入成功'**
  String get importSucceeded;

  /// No description provided for @importFailed.
  ///
  /// In zh, this message translates to:
  /// **'导入失败：{error}'**
  String importFailed(Object error);

  /// No description provided for @importClipboardEmpty.
  ///
  /// In zh, this message translates to:
  /// **'剪贴板无数据'**
  String get importClipboardEmpty;

  /// No description provided for @exportToClipboard.
  ///
  /// In zh, this message translates to:
  /// **'导出至剪贴板'**
  String get exportToClipboard;

  /// No description provided for @exportToLocalFile.
  ///
  /// In zh, this message translates to:
  /// **'导出文件至本地'**
  String get exportToLocalFile;

  /// No description provided for @importEnterManually.
  ///
  /// In zh, this message translates to:
  /// **'输入'**
  String get importEnterManually;

  /// No description provided for @importFromClipboard.
  ///
  /// In zh, this message translates to:
  /// **'从剪贴板导入'**
  String get importFromClipboard;

  /// No description provided for @importFromLocalFile.
  ///
  /// In zh, this message translates to:
  /// **'从本地文件导入'**
  String get importFromLocalFile;

  /// No description provided for @memberHomeVideos.
  ///
  /// In zh, this message translates to:
  /// **'视频'**
  String get memberHomeVideos;

  /// No description provided for @memberHomeFavorites.
  ///
  /// In zh, this message translates to:
  /// **'收藏'**
  String get memberHomeFavorites;

  /// No description provided for @memberHomeRecentCoinedVideos.
  ///
  /// In zh, this message translates to:
  /// **'最近投币的视频'**
  String get memberHomeRecentCoinedVideos;

  /// No description provided for @memberHomeRecentLikedVideos.
  ///
  /// In zh, this message translates to:
  /// **'最近点赞的视频'**
  String get memberHomeRecentLikedVideos;

  /// No description provided for @memberHomePosts.
  ///
  /// In zh, this message translates to:
  /// **'图文'**
  String get memberHomePosts;

  /// No description provided for @memberHomeAudio.
  ///
  /// In zh, this message translates to:
  /// **'音频'**
  String get memberHomeAudio;

  /// No description provided for @memberHomeComics.
  ///
  /// In zh, this message translates to:
  /// **'漫画'**
  String get memberHomeComics;

  /// No description provided for @memberHomeAnime.
  ///
  /// In zh, this message translates to:
  /// **'追番'**
  String get memberHomeAnime;

  /// No description provided for @blacklistTitle.
  ///
  /// In zh, this message translates to:
  /// **'黑名单管理{count}'**
  String blacklistTitle(Object count);

  /// No description provided for @blacklistCountSuffix.
  ///
  /// In zh, this message translates to:
  /// **': {count}'**
  String blacklistCountSuffix(Object count);

  /// No description provided for @blacklistAddedAt.
  ///
  /// In zh, this message translates to:
  /// **'添加时间：{date}'**
  String blacklistAddedAt(Object date);

  /// No description provided for @blacklistRemoveConfirm.
  ///
  /// In zh, this message translates to:
  /// **'确定将 {name} 移出黑名单？'**
  String blacklistRemoveConfirm(Object name);

  /// No description provided for @blacklistRemoved.
  ///
  /// In zh, this message translates to:
  /// **'移除成功'**
  String get blacklistRemoved;

  /// No description provided for @webDavSettingsTitle.
  ///
  /// In zh, this message translates to:
  /// **'WebDAV 设置'**
  String get webDavSettingsTitle;

  /// No description provided for @webDavBackupSettings.
  ///
  /// In zh, this message translates to:
  /// **'备份设置'**
  String get webDavBackupSettings;

  /// No description provided for @webDavRestoreSettings.
  ///
  /// In zh, this message translates to:
  /// **'恢复设置'**
  String get webDavRestoreSettings;

  /// No description provided for @webDavConfigurationSucceeded.
  ///
  /// In zh, this message translates to:
  /// **'配置成功'**
  String get webDavConfigurationSucceeded;

  /// No description provided for @webDavConfigurationFailed.
  ///
  /// In zh, this message translates to:
  /// **'配置失败：{error}'**
  String webDavConfigurationFailed(Object error);

  /// No description provided for @webDavBackupConfigurationFailed.
  ///
  /// In zh, this message translates to:
  /// **'备份失败，请检查配置：{error}'**
  String webDavBackupConfigurationFailed(Object error);

  /// No description provided for @webDavBackupSucceeded.
  ///
  /// In zh, this message translates to:
  /// **'备份成功'**
  String get webDavBackupSucceeded;

  /// No description provided for @webDavBackupFailed.
  ///
  /// In zh, this message translates to:
  /// **'备份失败：{error}'**
  String webDavBackupFailed(Object error);

  /// No description provided for @webDavRestoreSucceeded.
  ///
  /// In zh, this message translates to:
  /// **'恢复成功'**
  String get webDavRestoreSucceeded;

  /// No description provided for @webDavRestoreFailed.
  ///
  /// In zh, this message translates to:
  /// **'恢复失败：{error}'**
  String webDavRestoreFailed(Object error);

  /// No description provided for @webDavCheckConfiguration.
  ///
  /// In zh, this message translates to:
  /// **'请检查配置：{error}'**
  String webDavCheckConfiguration(Object error);

  /// No description provided for @webDavBackupNotFound.
  ///
  /// In zh, this message translates to:
  /// **'未找到备份文件'**
  String get webDavBackupNotFound;

  /// No description provided for @sponsorBlockTitle.
  ///
  /// In zh, this message translates to:
  /// **'空降助手'**
  String get sponsorBlockTitle;

  /// No description provided for @sponsorBlockMinimumDuration.
  ///
  /// In zh, this message translates to:
  /// **'最短片段时长'**
  String get sponsorBlockMinimumDuration;

  /// No description provided for @sponsorBlockMinimumDurationDescription.
  ///
  /// In zh, this message translates to:
  /// **'忽略短于此时长的片段'**
  String get sponsorBlockMinimumDurationDescription;

  /// No description provided for @sponsorBlockAbout.
  ///
  /// In zh, this message translates to:
  /// **'关于空降助手'**
  String get sponsorBlockAbout;

  /// No description provided for @sponsorBlockUserId.
  ///
  /// In zh, this message translates to:
  /// **'用户 ID'**
  String get sponsorBlockUserId;

  /// No description provided for @sponsorBlockUserIdValidation.
  ///
  /// In zh, this message translates to:
  /// **'用户 ID 要求至少为 30 个字符长度的纯字母数字字符串'**
  String get sponsorBlockUserIdValidation;

  /// No description provided for @sponsorBlockRandom.
  ///
  /// In zh, this message translates to:
  /// **'随机'**
  String get sponsorBlockRandom;

  /// No description provided for @sponsorBlockShowSkipToast.
  ///
  /// In zh, this message translates to:
  /// **'显示跳过提示'**
  String get sponsorBlockShowSkipToast;

  /// No description provided for @sponsorBlockTrackSkips.
  ///
  /// In zh, this message translates to:
  /// **'跳过次数统计跟踪'**
  String get sponsorBlockTrackSkips;

  /// No description provided for @sponsorBlockTrackSkipsDescription.
  ///
  /// In zh, this message translates to:
  /// **'此功能会报告您跳过的片段，让提交者知道帮助了多少人；点赞结果也会用于避免垃圾信息污染数据库。每次跳过片段时都会向服务器发送消息，开启后可让统计更准确。'**
  String get sponsorBlockTrackSkipsDescription;

  /// No description provided for @sponsorBlockYourInformation.
  ///
  /// In zh, this message translates to:
  /// **'您的信息'**
  String get sponsorBlockYourInformation;

  /// No description provided for @sponsorBlockUserInformation.
  ///
  /// In zh, this message translates to:
  /// **'您提交了 {segments} 个片段\n您的片段已帮助观众 {views} 次\n（节省 {minutes} 分钟）'**
  String sponsorBlockUserInformation(
    Object minutes,
    Object segments,
    Object views,
  );

  /// No description provided for @sponsorBlockServerError.
  ///
  /// In zh, this message translates to:
  /// **'服务器错误'**
  String get sponsorBlockServerError;

  /// No description provided for @sponsorBlockServerAddress.
  ///
  /// In zh, this message translates to:
  /// **'服务器地址'**
  String get sponsorBlockServerAddress;

  /// No description provided for @sponsorBlockServerStatus.
  ///
  /// In zh, this message translates to:
  /// **'服务器状态'**
  String get sponsorBlockServerStatus;

  /// No description provided for @sponsorBlockServerNormal.
  ///
  /// In zh, this message translates to:
  /// **'正常'**
  String get sponsorBlockServerNormal;

  /// No description provided for @sponsorBlockServerUnavailable.
  ///
  /// In zh, this message translates to:
  /// **'错误'**
  String get sponsorBlockServerUnavailable;

  /// No description provided for @sponsorBlockColorPickerTitle.
  ///
  /// In zh, this message translates to:
  /// **'{category}的颜色'**
  String sponsorBlockColorPickerTitle(Object category);

  /// No description provided for @sponsorBlockDescriptionSponsor.
  ///
  /// In zh, this message translates to:
  /// **'付费推广、赞助和直接广告，不包含无偿提及。'**
  String get sponsorBlockDescriptionSponsor;

  /// No description provided for @sponsorBlockDescriptionSelfPromotion.
  ///
  /// In zh, this message translates to:
  /// **'无偿或自我推广，包括商品、捐赠或合作者信息。'**
  String get sponsorBlockDescriptionSelfPromotion;

  /// No description provided for @sponsorBlockDescriptionExclusiveAccess.
  ///
  /// In zh, this message translates to:
  /// **'标记整个展示免费或优惠获得的产品、服务或场地的视频。'**
  String get sponsorBlockDescriptionExclusiveAccess;

  /// No description provided for @sponsorBlockDescriptionInteraction.
  ///
  /// In zh, this message translates to:
  /// **'简短提醒观众点赞、关注或互动；较长且有实质内容的片段应归为自我推广。'**
  String get sponsorBlockDescriptionInteraction;

  /// No description provided for @sponsorBlockDescriptionHighlight.
  ///
  /// In zh, this message translates to:
  /// **'大多数观众正在寻找的精彩时刻，例如封面所示的时间点。'**
  String get sponsorBlockDescriptionHighlight;

  /// No description provided for @sponsorBlockDescriptionIntro.
  ///
  /// In zh, this message translates to:
  /// **'没有实际内容的过场或片头，例如暂停、静止画面或重复动画。'**
  String get sponsorBlockDescriptionIntro;

  /// No description provided for @sponsorBlockDescriptionOutro.
  ///
  /// In zh, this message translates to:
  /// **'没有额外内容的片尾或鸣谢画面。'**
  String get sponsorBlockDescriptionOutro;

  /// No description provided for @sponsorBlockDescriptionPreview.
  ///
  /// In zh, this message translates to:
  /// **'本片或同系列稍后会再次出现内容的回顾或预览。'**
  String get sponsorBlockDescriptionPreview;

  /// No description provided for @sponsorBlockDescriptionPadding.
  ///
  /// In zh, this message translates to:
  /// **'搬运内容前后无实质意义、与主体无关的空白或填充画面。'**
  String get sponsorBlockDescriptionPadding;

  /// No description provided for @sponsorBlockDescriptionFiller.
  ///
  /// In zh, this message translates to:
  /// **'理解主要内容不需要的离题闲聊或玩笑；这是一个较激进的分类。'**
  String get sponsorBlockDescriptionFiller;

  /// No description provided for @sponsorBlockDescriptionMusicOfftopic.
  ///
  /// In zh, this message translates to:
  /// **'仅限音乐视频：不属于其他分类的非音乐片段。'**
  String get sponsorBlockDescriptionMusicOfftopic;

  /// No description provided for @videoCooperation.
  ///
  /// In zh, this message translates to:
  /// **'合作'**
  String get videoCooperation;

  /// No description provided for @commonSort.
  ///
  /// In zh, this message translates to:
  /// **'排序'**
  String get commonSort;

  /// No description provided for @commonMultiSelect.
  ///
  /// In zh, this message translates to:
  /// **'多选'**
  String get commonMultiSelect;

  /// No description provided for @commonUpdate.
  ///
  /// In zh, this message translates to:
  /// **'更新'**
  String get commonUpdate;

  /// No description provided for @commonUpdateSucceeded.
  ///
  /// In zh, this message translates to:
  /// **'更新成功'**
  String get commonUpdateSucceeded;

  /// No description provided for @commonUpdateFailed.
  ///
  /// In zh, this message translates to:
  /// **'更新失败'**
  String get commonUpdateFailed;

  /// No description provided for @commonMove.
  ///
  /// In zh, this message translates to:
  /// **'移动'**
  String get commonMove;

  /// No description provided for @commonPlayAll.
  ///
  /// In zh, this message translates to:
  /// **'播放全部'**
  String get commonPlayAll;

  /// No description provided for @favoriteTitle.
  ///
  /// In zh, this message translates to:
  /// **'我的收藏'**
  String get favoriteTitle;

  /// No description provided for @favoriteNewFolder.
  ///
  /// In zh, this message translates to:
  /// **'新建收藏夹'**
  String get favoriteNewFolder;

  /// No description provided for @favoriteFolderSort.
  ///
  /// In zh, this message translates to:
  /// **'收藏夹排序'**
  String get favoriteFolderSort;

  /// No description provided for @favoriteLoadAllBeforeSorting.
  ///
  /// In zh, this message translates to:
  /// **'加载全部收藏夹再排序'**
  String get favoriteLoadAllBeforeSorting;

  /// No description provided for @favoriteTabVideos.
  ///
  /// In zh, this message translates to:
  /// **'视频'**
  String get favoriteTabVideos;

  /// No description provided for @favoriteTabAnime.
  ///
  /// In zh, this message translates to:
  /// **'追番'**
  String get favoriteTabAnime;

  /// No description provided for @favoriteTabSeries.
  ///
  /// In zh, this message translates to:
  /// **'追剧'**
  String get favoriteTabSeries;

  /// No description provided for @favoriteTabArticles.
  ///
  /// In zh, this message translates to:
  /// **'专栏'**
  String get favoriteTabArticles;

  /// No description provided for @favoriteTabNotes.
  ///
  /// In zh, this message translates to:
  /// **'笔记'**
  String get favoriteTabNotes;

  /// No description provided for @favoriteTabTopics.
  ///
  /// In zh, this message translates to:
  /// **'话题'**
  String get favoriteTabTopics;

  /// No description provided for @favoriteTabCourses.
  ///
  /// In zh, this message translates to:
  /// **'课堂'**
  String get favoriteTabCourses;

  /// No description provided for @laterAll.
  ///
  /// In zh, this message translates to:
  /// **'全部'**
  String get laterAll;

  /// No description provided for @laterUnfinished.
  ///
  /// In zh, this message translates to:
  /// **'未看完'**
  String get laterUnfinished;

  /// No description provided for @laterRecentlyAdded.
  ///
  /// In zh, this message translates to:
  /// **'最近添加'**
  String get laterRecentlyAdded;

  /// No description provided for @laterEarliestAdded.
  ///
  /// In zh, this message translates to:
  /// **'最早添加'**
  String get laterEarliestAdded;

  /// No description provided for @laterClearInvalid.
  ///
  /// In zh, this message translates to:
  /// **'清空失效'**
  String get laterClearInvalid;

  /// No description provided for @laterClearWatched.
  ///
  /// In zh, this message translates to:
  /// **'清空看完'**
  String get laterClearWatched;

  /// No description provided for @laterClearAll.
  ///
  /// In zh, this message translates to:
  /// **'清空全部'**
  String get laterClearAll;

  /// No description provided for @historyAll.
  ///
  /// In zh, this message translates to:
  /// **'全部'**
  String get historyAll;

  /// No description provided for @historyTitle.
  ///
  /// In zh, this message translates to:
  /// **'观看记录'**
  String get historyTitle;

  /// No description provided for @historyPause.
  ///
  /// In zh, this message translates to:
  /// **'暂停观看记录'**
  String get historyPause;

  /// No description provided for @historyResume.
  ///
  /// In zh, this message translates to:
  /// **'恢复观看记录'**
  String get historyResume;

  /// No description provided for @historyClear.
  ///
  /// In zh, this message translates to:
  /// **'清空观看记录'**
  String get historyClear;

  /// No description provided for @historyDeleteWatched.
  ///
  /// In zh, this message translates to:
  /// **'删除已看记录'**
  String get historyDeleteWatched;

  /// No description provided for @historyDisabled.
  ///
  /// In zh, this message translates to:
  /// **' 历史记录功能已关闭'**
  String get historyDisabled;

  /// No description provided for @historyTapToEnable.
  ///
  /// In zh, this message translates to:
  /// **'点击开启'**
  String get historyTapToEnable;

  /// No description provided for @statisticsTitle.
  ///
  /// In zh, this message translates to:
  /// **'数据统计（Beta）'**
  String get statisticsTitle;

  /// No description provided for @statisticsLoading.
  ///
  /// In zh, this message translates to:
  /// **'正在整理观看记录…'**
  String get statisticsLoading;

  /// No description provided for @statisticsLoadingCount.
  ///
  /// In zh, this message translates to:
  /// **'已加载 {count} 条记录…'**
  String statisticsLoadingCount(int count);

  /// No description provided for @statisticsRange7Days.
  ///
  /// In zh, this message translates to:
  /// **'近 7 天'**
  String get statisticsRange7Days;

  /// No description provided for @statisticsRange30Days.
  ///
  /// In zh, this message translates to:
  /// **'近 30 天'**
  String get statisticsRange30Days;

  /// No description provided for @statisticsRange90Days.
  ///
  /// In zh, this message translates to:
  /// **'近 90 天'**
  String get statisticsRange90Days;

  /// No description provided for @statisticsPartialData.
  ///
  /// In zh, this message translates to:
  /// **'部分观看记录加载失败，当前统计可能不完整。'**
  String get statisticsPartialData;

  /// No description provided for @statisticsEmpty.
  ///
  /// In zh, this message translates to:
  /// **'所选时间范围内没有观看记录'**
  String get statisticsEmpty;

  /// No description provided for @statisticsOverview.
  ///
  /// In zh, this message translates to:
  /// **'概览'**
  String get statisticsOverview;

  /// No description provided for @statisticsDateRange.
  ///
  /// In zh, this message translates to:
  /// **'{start} – {end}'**
  String statisticsDateRange(String start, String end);

  /// No description provided for @statisticsDistinctContent.
  ///
  /// In zh, this message translates to:
  /// **'浏览过的不同内容'**
  String get statisticsDistinctContent;

  /// No description provided for @statisticsCompleted.
  ///
  /// In zh, this message translates to:
  /// **'已看完'**
  String get statisticsCompleted;

  /// No description provided for @statisticsUnfinished.
  ///
  /// In zh, this message translates to:
  /// **'未看完'**
  String get statisticsUnfinished;

  /// No description provided for @statisticsActiveDays.
  ///
  /// In zh, this message translates to:
  /// **'活跃天数'**
  String get statisticsActiveDays;

  /// No description provided for @statisticsFavorited.
  ///
  /// In zh, this message translates to:
  /// **'已收藏'**
  String get statisticsFavorited;

  /// No description provided for @statisticsActivity.
  ///
  /// In zh, this message translates to:
  /// **'活跃日期'**
  String get statisticsActivity;

  /// No description provided for @statisticsActivityDescription.
  ///
  /// In zh, this message translates to:
  /// **'每个方格代表一天，颜色越深表示记录越多'**
  String get statisticsActivityDescription;

  /// No description provided for @statisticsActivityTooltip.
  ///
  /// In zh, this message translates to:
  /// **'{date}：{count} 个内容'**
  String statisticsActivityTooltip(String date, int count);

  /// No description provided for @statisticsRecordTime.
  ///
  /// In zh, this message translates to:
  /// **'记录时段'**
  String get statisticsRecordTime;

  /// No description provided for @statisticsRecordTimeDescription.
  ///
  /// In zh, this message translates to:
  /// **'按观看记录最后更新的时间统计'**
  String get statisticsRecordTimeDescription;

  /// No description provided for @statisticsContentTypes.
  ///
  /// In zh, this message translates to:
  /// **'内容类型'**
  String get statisticsContentTypes;

  /// No description provided for @statisticsContentTypesDescription.
  ///
  /// In zh, this message translates to:
  /// **'按不同内容的观看记录数量统计'**
  String get statisticsContentTypesDescription;

  /// No description provided for @statisticsTopUploaders.
  ///
  /// In zh, this message translates to:
  /// **'常看 UP 主'**
  String get statisticsTopUploaders;

  /// No description provided for @statisticsTopUploadersDescription.
  ///
  /// In zh, this message translates to:
  /// **'按浏览过的不同内容数量排序'**
  String get statisticsTopUploadersDescription;

  /// No description provided for @statisticsUploaderSummary.
  ///
  /// In zh, this message translates to:
  /// **'{contentCount} 个内容 · {completedCount} 个看完'**
  String statisticsUploaderSummary(int contentCount, int completedCount);

  /// No description provided for @statisticsContinueWatching.
  ///
  /// In zh, this message translates to:
  /// **'继续观看'**
  String get statisticsContinueWatching;

  /// No description provided for @statisticsRemainingTotal.
  ///
  /// In zh, this message translates to:
  /// **'这些内容共剩余 {duration}'**
  String statisticsRemainingTotal(String duration);

  /// No description provided for @statisticsRemaining.
  ///
  /// In zh, this message translates to:
  /// **'还剩 {duration}'**
  String statisticsRemaining(String duration);

  /// No description provided for @statisticsDataSourceNotice.
  ///
  /// In zh, this message translates to:
  /// **'数据根据 bilibili 跨平台观看记录整理。暂停、清空或未记录的历史不会纳入，也不代表实际观看时长。'**
  String get statisticsDataSourceNotice;

  /// No description provided for @statisticsTypeVideo.
  ///
  /// In zh, this message translates to:
  /// **'视频'**
  String get statisticsTypeVideo;

  /// No description provided for @statisticsTypePgc.
  ///
  /// In zh, this message translates to:
  /// **'番剧与影视'**
  String get statisticsTypePgc;

  /// No description provided for @statisticsTypeLive.
  ///
  /// In zh, this message translates to:
  /// **'直播'**
  String get statisticsTypeLive;

  /// No description provided for @statisticsTypeArticle.
  ///
  /// In zh, this message translates to:
  /// **'文章'**
  String get statisticsTypeArticle;

  /// No description provided for @statisticsTypeCourse.
  ///
  /// In zh, this message translates to:
  /// **'课程'**
  String get statisticsTypeCourse;

  /// No description provided for @statisticsTypeOther.
  ///
  /// In zh, this message translates to:
  /// **'其他'**
  String get statisticsTypeOther;

  /// No description provided for @downloadOfflineTitle.
  ///
  /// In zh, this message translates to:
  /// **'离线缓存'**
  String get downloadOfflineTitle;

  /// No description provided for @downloadDownloadingCount.
  ///
  /// In zh, this message translates to:
  /// **'正在缓存（{count}）'**
  String downloadDownloadingCount(Object count);

  /// No description provided for @downloadDownloadedVideos.
  ///
  /// In zh, this message translates to:
  /// **'已缓存视频'**
  String get downloadDownloadedVideos;

  /// No description provided for @downloadVideoCount.
  ///
  /// In zh, this message translates to:
  /// **'{count} 个视频'**
  String downloadVideoCount(Object count);

  /// No description provided for @downloadCourse.
  ///
  /// In zh, this message translates to:
  /// **'课程'**
  String get downloadCourse;

  /// No description provided for @downloadAnime.
  ///
  /// In zh, this message translates to:
  /// **'番剧'**
  String get downloadAnime;

  /// No description provided for @downloadMovie.
  ///
  /// In zh, this message translates to:
  /// **'电影'**
  String get downloadMovie;

  /// No description provided for @downloadDocumentary.
  ///
  /// In zh, this message translates to:
  /// **'纪录片'**
  String get downloadDocumentary;

  /// No description provided for @downloadChineseAnimation.
  ///
  /// In zh, this message translates to:
  /// **'国创'**
  String get downloadChineseAnimation;

  /// No description provided for @downloadTvSeries.
  ///
  /// In zh, this message translates to:
  /// **'电视剧'**
  String get downloadTvSeries;

  /// No description provided for @downloadVarietyShow.
  ///
  /// In zh, this message translates to:
  /// **'综艺'**
  String get downloadVarietyShow;

  /// No description provided for @downloadConfirmDelete.
  ///
  /// In zh, this message translates to:
  /// **'确定删除？'**
  String get downloadConfirmDelete;

  /// No description provided for @downloadUpdateDanmaku.
  ///
  /// In zh, this message translates to:
  /// **'更新弹幕'**
  String get downloadUpdateDanmaku;

  /// No description provided for @messagesTitle.
  ///
  /// In zh, this message translates to:
  /// **'消息'**
  String get messagesTitle;

  /// No description provided for @messagesNewFollowers.
  ///
  /// In zh, this message translates to:
  /// **'新增粉丝'**
  String get messagesNewFollowers;

  /// No description provided for @messagesRepliesToMe.
  ///
  /// In zh, this message translates to:
  /// **'回复我的'**
  String get messagesRepliesToMe;

  /// No description provided for @messagesMentions.
  ///
  /// In zh, this message translates to:
  /// **'@我'**
  String get messagesMentions;

  /// No description provided for @messagesReceivedLikes.
  ///
  /// In zh, this message translates to:
  /// **'收到的赞'**
  String get messagesReceivedLikes;

  /// No description provided for @messagesSystemNotifications.
  ///
  /// In zh, this message translates to:
  /// **'系统通知'**
  String get messagesSystemNotifications;

  /// No description provided for @messagesMarkedAsRead.
  ///
  /// In zh, this message translates to:
  /// **'已标为已读'**
  String get messagesMarkedAsRead;

  /// No description provided for @messagesMarkAsRead.
  ///
  /// In zh, this message translates to:
  /// **'标为已读'**
  String get messagesMarkAsRead;

  /// No description provided for @messagesEnableDoNotDisturb.
  ///
  /// In zh, this message translates to:
  /// **'开启免打扰'**
  String get messagesEnableDoNotDisturb;

  /// No description provided for @messagesDisableDoNotDisturb.
  ///
  /// In zh, this message translates to:
  /// **'关闭免打扰'**
  String get messagesDisableDoNotDisturb;

  /// No description provided for @messagesDeleteConversationConfirm.
  ///
  /// In zh, this message translates to:
  /// **'确定删除该对话？'**
  String get messagesDeleteConversationConfirm;

  /// No description provided for @contactsTitle.
  ///
  /// In zh, this message translates to:
  /// **'通讯录'**
  String get contactsTitle;

  /// No description provided for @loginDevicesTitle.
  ///
  /// In zh, this message translates to:
  /// **'登录设备'**
  String get loginDevicesTitle;

  /// No description provided for @loginDevicesCurrentDevice.
  ///
  /// In zh, this message translates to:
  /// **'（本机）'**
  String get loginDevicesCurrentDevice;

  /// No description provided for @memberMyFeed.
  ///
  /// In zh, this message translates to:
  /// **'我的动态'**
  String get memberMyFeed;

  /// No description provided for @memberSpaceSettings.
  ///
  /// In zh, this message translates to:
  /// **'空间设置'**
  String get memberSpaceSettings;

  /// No description provided for @messagesLikeDetails.
  ///
  /// In zh, this message translates to:
  /// **'点赞详情'**
  String get messagesLikeDetails;

  /// No description provided for @messagesMentionsMe.
  ///
  /// In zh, this message translates to:
  /// **'@我的'**
  String get messagesMentionsMe;

  /// No description provided for @messagesDeleteNotificationConfirm.
  ///
  /// In zh, this message translates to:
  /// **'确定删除该通知？'**
  String get messagesDeleteNotificationConfirm;

  /// No description provided for @messagesMentionedIn.
  ///
  /// In zh, this message translates to:
  /// **' 在{business}中@了我'**
  String messagesMentionedIn(Object business);

  /// No description provided for @messagesAndOthers.
  ///
  /// In zh, this message translates to:
  /// **' 等人'**
  String get messagesAndOthers;

  /// No description provided for @messagesCommentsOnMyItem.
  ///
  /// In zh, this message translates to:
  /// **' 对我的{business}发布了{count}条评论'**
  String messagesCommentsOnMyItem(Object business, Object count);

  /// No description provided for @messagesLatest.
  ///
  /// In zh, this message translates to:
  /// **'最新'**
  String get messagesLatest;

  /// No description provided for @messagesTotal.
  ///
  /// In zh, this message translates to:
  /// **'累计'**
  String get messagesTotal;

  /// No description provided for @messagesDeleteLikeNoticeConfirm.
  ///
  /// In zh, this message translates to:
  /// **'该条通知删除后，当有新点赞时会重新出现在列表，是否继续？'**
  String get messagesDeleteLikeNoticeConfirm;

  /// No description provided for @messagesStopNotifications.
  ///
  /// In zh, this message translates to:
  /// **'不再通知'**
  String get messagesStopNotifications;

  /// No description provided for @messagesStopNotificationsConfirm.
  ///
  /// In zh, this message translates to:
  /// **'这条内容的点赞将不再通知，但仍可在列表内查看，是否继续？'**
  String get messagesStopNotificationsConfirm;

  /// No description provided for @messagesReceiveNotifications.
  ///
  /// In zh, this message translates to:
  /// **'接收通知'**
  String get messagesReceiveNotifications;

  /// No description provided for @messagesAndPeople.
  ///
  /// In zh, this message translates to:
  /// **' 等{count}人'**
  String messagesAndPeople(Object count);

  /// No description provided for @messagesLikedMyItem.
  ///
  /// In zh, this message translates to:
  /// **' 赞了我的{business}'**
  String messagesLikedMyItem(Object business);

  /// No description provided for @messagesViewFeed.
  ///
  /// In zh, this message translates to:
  /// **'查看动态'**
  String get messagesViewFeed;

  /// No description provided for @messagesWebLink.
  ///
  /// In zh, this message translates to:
  /// **'网页链接'**
  String get messagesWebLink;

  /// No description provided for @accountSwitchAnonymousHint.
  ///
  /// In zh, this message translates to:
  /// **'mid 为 0 时使用匿名模式'**
  String get accountSwitchAnonymousHint;

  /// No description provided for @accountSwitchDetailed.
  ///
  /// In zh, this message translates to:
  /// **'详细'**
  String get accountSwitchDetailed;

  /// No description provided for @accountSwitchQuick.
  ///
  /// In zh, this message translates to:
  /// **'快速'**
  String get accountSwitchQuick;

  /// No description provided for @accountSignInFirst.
  ///
  /// In zh, this message translates to:
  /// **'请先登录'**
  String get accountSignInFirst;

  /// No description provided for @replyIpLocation.
  ///
  /// In zh, this message translates to:
  /// **'IP 属地：{region}'**
  String replyIpLocation(Object region);

  /// No description provided for @videoPersonalOpinionDisclaimer.
  ///
  /// In zh, this message translates to:
  /// **'个人观点，仅供参考'**
  String get videoPersonalOpinionDisclaimer;

  /// No description provided for @videoAllEpisodes.
  ///
  /// In zh, this message translates to:
  /// **'全 {count} 话'**
  String videoAllEpisodes(Object count);

  /// No description provided for @feedPostedVideo.
  ///
  /// In zh, this message translates to:
  /// **'投稿了视频'**
  String get feedPostedVideo;

  /// No description provided for @feedCoCreated.
  ///
  /// In zh, this message translates to:
  /// **'与他人共同创作'**
  String get feedCoCreated;

  /// No description provided for @feedLikesAndReposts.
  ///
  /// In zh, this message translates to:
  /// **'赞与转发'**
  String get feedLikesAndReposts;

  /// No description provided for @feedSaySomething.
  ///
  /// In zh, this message translates to:
  /// **'说点什么吧…'**
  String get feedSaySomething;

  /// No description provided for @feedShareToFeed.
  ///
  /// In zh, this message translates to:
  /// **'分享至动态'**
  String get feedShareToFeed;

  /// No description provided for @feedRepostFeed.
  ///
  /// In zh, this message translates to:
  /// **'转发动态'**
  String get feedRepostFeed;

  /// No description provided for @feedPublishNow.
  ///
  /// In zh, this message translates to:
  /// **'立即发布'**
  String get feedPublishNow;

  /// No description provided for @feedRepostNow.
  ///
  /// In zh, this message translates to:
  /// **'立即转发'**
  String get feedRepostNow;

  /// No description provided for @feedPublish.
  ///
  /// In zh, this message translates to:
  /// **'发布'**
  String get feedPublish;

  /// No description provided for @feedRepostSucceeded.
  ///
  /// In zh, this message translates to:
  /// **'转发成功'**
  String get feedRepostSucceeded;

  /// No description provided for @commonCopied.
  ///
  /// In zh, this message translates to:
  /// **'已复制'**
  String get commonCopied;

  /// No description provided for @commonExport.
  ///
  /// In zh, this message translates to:
  /// **'导出'**
  String get commonExport;

  /// No description provided for @commonNoData.
  ///
  /// In zh, this message translates to:
  /// **'没有数据'**
  String get commonNoData;

  /// No description provided for @commonTapToRetry.
  ///
  /// In zh, this message translates to:
  /// **'点击重试'**
  String get commonTapToRetry;

  /// No description provided for @watchLaterAdded.
  ///
  /// In zh, this message translates to:
  /// **'已添加至稍后再看'**
  String get watchLaterAdded;

  /// No description provided for @watchLaterRemoved.
  ///
  /// In zh, this message translates to:
  /// **'已从稍后再看移除'**
  String get watchLaterRemoved;

  /// No description provided for @myCommentsTitle.
  ///
  /// In zh, this message translates to:
  /// **'我的评论'**
  String get myCommentsTitle;

  /// No description provided for @subscriptionFolder.
  ///
  /// In zh, this message translates to:
  /// **'收藏夹'**
  String get subscriptionFolder;

  /// No description provided for @subscriptionCollection.
  ///
  /// In zh, this message translates to:
  /// **'合集'**
  String get subscriptionCollection;

  /// No description provided for @subscriptionOtherType.
  ///
  /// In zh, this message translates to:
  /// **'其它（{type}）'**
  String subscriptionOtherType(Object type);

  /// No description provided for @subscriptionUnavailable.
  ///
  /// In zh, this message translates to:
  /// **'该{type}已失效'**
  String subscriptionUnavailable(Object type);

  /// No description provided for @subscriptionUploader.
  ///
  /// In zh, this message translates to:
  /// **'UP 主：{name}'**
  String subscriptionUploader(Object name);

  /// No description provided for @subscriptionVideoCount.
  ///
  /// In zh, this message translates to:
  /// **'{count} 个视频'**
  String subscriptionVideoCount(Object count);

  /// No description provided for @subscriptionTotalVideos.
  ///
  /// In zh, this message translates to:
  /// **'共 {count} 个视频'**
  String subscriptionTotalVideos(Object count);

  /// No description provided for @subscriptionPlayCount.
  ///
  /// In zh, this message translates to:
  /// **'{count} 次播放'**
  String subscriptionPlayCount(Object count);

  /// No description provided for @subscriptionCancelConfirm.
  ///
  /// In zh, this message translates to:
  /// **'确定取消订阅吗？'**
  String get subscriptionCancelConfirm;

  /// No description provided for @subscriptionCanceled.
  ///
  /// In zh, this message translates to:
  /// **'取消订阅成功'**
  String get subscriptionCanceled;

  /// No description provided for @commonSaving.
  ///
  /// In zh, this message translates to:
  /// **'正在保存…'**
  String get commonSaving;

  /// No description provided for @commonSaved.
  ///
  /// In zh, this message translates to:
  /// **'已保存'**
  String get commonSaved;

  /// No description provided for @commonSaveFailed.
  ///
  /// In zh, this message translates to:
  /// **'保存失败'**
  String get commonSaveFailed;

  /// No description provided for @commonSaveFailedWithError.
  ///
  /// In zh, this message translates to:
  /// **'保存失败：{error}'**
  String commonSaveFailedWithError(Object error);

  /// No description provided for @commonSaveCanceled.
  ///
  /// In zh, this message translates to:
  /// **'取消保存'**
  String get commonSaveCanceled;

  /// No description provided for @commonDownloadCanceled.
  ///
  /// In zh, this message translates to:
  /// **'已取消下载'**
  String get commonDownloadCanceled;

  /// No description provided for @commonDownloading.
  ///
  /// In zh, this message translates to:
  /// **'正在下载…'**
  String get commonDownloading;

  /// No description provided for @commonDownloadingOriginal.
  ///
  /// In zh, this message translates to:
  /// **'正在下载原图…'**
  String get commonDownloadingOriginal;

  /// No description provided for @commonFileNotFound.
  ///
  /// In zh, this message translates to:
  /// **'文件不存在'**
  String get commonFileNotFound;

  /// No description provided for @permissionStorageRequired.
  ///
  /// In zh, this message translates to:
  /// **'存储权限未授权'**
  String get permissionStorageRequired;

  /// No description provided for @permissionOpenSettings.
  ///
  /// In zh, this message translates to:
  /// **'去授权'**
  String get permissionOpenSettings;

  /// No description provided for @laterDeleteSelectedConfirm.
  ///
  /// In zh, this message translates to:
  /// **'确认删除所选稍后再看吗？'**
  String get laterDeleteSelectedConfirm;

  /// No description provided for @laterRemoveVideoConfirm.
  ///
  /// In zh, this message translates to:
  /// **'即将移除该视频，确定是否移除？'**
  String get laterRemoveVideoConfirm;

  /// No description provided for @laterRemoveConfirmed.
  ///
  /// In zh, this message translates to:
  /// **'确认移除'**
  String get laterRemoveConfirmed;

  /// No description provided for @laterClearInvalidConfirm.
  ///
  /// In zh, this message translates to:
  /// **'确定清空已失效视频吗？'**
  String get laterClearInvalidConfirm;

  /// No description provided for @laterClearWatchedConfirm.
  ///
  /// In zh, this message translates to:
  /// **'确定清空已看完视频吗？'**
  String get laterClearWatchedConfirm;

  /// No description provided for @laterClearAllConfirm.
  ///
  /// In zh, this message translates to:
  /// **'确定清空稍后再看列表吗？'**
  String get laterClearAllConfirm;

  /// No description provided for @laterCleared.
  ///
  /// In zh, this message translates to:
  /// **'已清空稍后再看'**
  String get laterCleared;

  /// No description provided for @videoPremiumRequired.
  ///
  /// In zh, this message translates to:
  /// **'需要大会员'**
  String get videoPremiumRequired;

  /// No description provided for @videoSwitchingTo.
  ///
  /// In zh, this message translates to:
  /// **'切换到：{title}'**
  String videoSwitchingTo(Object title);

  /// No description provided for @shareTo.
  ///
  /// In zh, this message translates to:
  /// **'分享给'**
  String get shareTo;

  /// No description provided for @shareChooseRecipients.
  ///
  /// In zh, this message translates to:
  /// **'请选择分享的用户'**
  String get shareChooseRecipients;

  /// No description provided for @shareSucceeded.
  ///
  /// In zh, this message translates to:
  /// **'分享成功'**
  String get shareSucceeded;

  /// No description provided for @shareFailed.
  ///
  /// In zh, this message translates to:
  /// **'分享失败'**
  String get shareFailed;

  /// No description provided for @sharePartiallyFailed.
  ///
  /// In zh, this message translates to:
  /// **'部分分享失败'**
  String get sharePartiallyFailed;

  /// No description provided for @followCreateGroup.
  ///
  /// In zh, this message translates to:
  /// **'新建分组'**
  String get followCreateGroup;

  /// No description provided for @followGroupCreated.
  ///
  /// In zh, this message translates to:
  /// **'创建成功'**
  String get followGroupCreated;

  /// No description provided for @followSucceeded.
  ///
  /// In zh, this message translates to:
  /// **'关注成功'**
  String get followSucceeded;

  /// No description provided for @followAddPriority.
  ///
  /// In zh, this message translates to:
  /// **'加入特别关注'**
  String get followAddPriority;

  /// No description provided for @followRemovePriority.
  ///
  /// In zh, this message translates to:
  /// **'移除特别关注'**
  String get followRemovePriority;

  /// No description provided for @followPriorityAdded.
  ///
  /// In zh, this message translates to:
  /// **'加入特别关注成功'**
  String get followPriorityAdded;

  /// No description provided for @followPriorityRemoved.
  ///
  /// In zh, this message translates to:
  /// **'移除特别关注成功'**
  String get followPriorityRemoved;

  /// No description provided for @followSetGroup.
  ///
  /// In zh, this message translates to:
  /// **'设置分组'**
  String get followSetGroup;

  /// No description provided for @followUnfollow.
  ///
  /// In zh, this message translates to:
  /// **'取消关注'**
  String get followUnfollow;

  /// No description provided for @followUnfollowSucceeded.
  ///
  /// In zh, this message translates to:
  /// **'取消关注成功'**
  String get followUnfollowSucceeded;

  /// No description provided for @commonCopyTo.
  ///
  /// In zh, this message translates to:
  /// **'复制到'**
  String get commonCopyTo;

  /// No description provided for @commonMoveTo.
  ///
  /// In zh, this message translates to:
  /// **'移动到'**
  String get commonMoveTo;

  /// No description provided for @commonMoved.
  ///
  /// In zh, this message translates to:
  /// **'移动成功'**
  String get commonMoved;

  /// No description provided for @feedAppeal.
  ///
  /// In zh, this message translates to:
  /// **'申诉'**
  String get feedAppeal;

  /// No description provided for @feedCheckResult.
  ///
  /// In zh, this message translates to:
  /// **'动态检查结果'**
  String get feedCheckResult;

  /// No description provided for @feedCheckPassed.
  ///
  /// In zh, this message translates to:
  /// **'无账号状态下找到了你的动态，动态正常！'**
  String get feedCheckPassed;

  /// No description provided for @feedCheckShadowBanned.
  ///
  /// In zh, this message translates to:
  /// **'你的动态可能仅自己可见！'**
  String get feedCheckShadowBanned;

  /// No description provided for @feedPostContent.
  ///
  /// In zh, this message translates to:
  /// **'动态内容：{content}'**
  String feedPostContent(Object content);

  /// No description provided for @commonMissingParameters.
  ///
  /// In zh, this message translates to:
  /// **'参数为空'**
  String get commonMissingParameters;

  /// No description provided for @videoCoinSucceeded.
  ///
  /// In zh, this message translates to:
  /// **'投币成功'**
  String get videoCoinSucceeded;

  /// No description provided for @historyNoWatchedItems.
  ///
  /// In zh, this message translates to:
  /// **'无已看记录'**
  String get historyNoWatchedItems;

  /// No description provided for @historyDeleteSelectedConfirm.
  ///
  /// In zh, this message translates to:
  /// **'确认删除所选历史记录吗？'**
  String get historyDeleteSelectedConfirm;

  /// No description provided for @historyClearConfirm.
  ///
  /// In zh, this message translates to:
  /// **'确定清空观看历史吗？'**
  String get historyClearConfirm;

  /// No description provided for @historyCleared.
  ///
  /// In zh, this message translates to:
  /// **'已清空观看历史'**
  String get historyCleared;

  /// No description provided for @historyConfirmClear.
  ///
  /// In zh, this message translates to:
  /// **'确认清空'**
  String get historyConfirmClear;

  /// No description provided for @historyPauseConfirm.
  ///
  /// In zh, this message translates to:
  /// **'确定暂停观看历史吗？'**
  String get historyPauseConfirm;

  /// No description provided for @historyResumeConfirm.
  ///
  /// In zh, this message translates to:
  /// **'确定恢复观看历史吗？'**
  String get historyResumeConfirm;

  /// No description provided for @historyPaused.
  ///
  /// In zh, this message translates to:
  /// **'已暂停观看历史'**
  String get historyPaused;

  /// No description provided for @historyResumed.
  ///
  /// In zh, this message translates to:
  /// **'已恢复观看历史'**
  String get historyResumed;

  /// No description provided for @historyConfirmPause.
  ///
  /// In zh, this message translates to:
  /// **'确认暂停'**
  String get historyConfirmPause;

  /// No description provided for @historyConfirmResume.
  ///
  /// In zh, this message translates to:
  /// **'确认恢复'**
  String get historyConfirmResume;

  /// No description provided for @commonActionsMenu.
  ///
  /// In zh, this message translates to:
  /// **'功能菜单'**
  String get commonActionsMenu;

  /// No description provided for @commonFavorited.
  ///
  /// In zh, this message translates to:
  /// **'已收藏'**
  String get commonFavorited;

  /// No description provided for @liveNotStarted.
  ///
  /// In zh, this message translates to:
  /// **'直播未开播'**
  String get liveNotStarted;

  /// No description provided for @historyDeleteRecord.
  ///
  /// In zh, this message translates to:
  /// **'删除记录'**
  String get historyDeleteRecord;

  /// No description provided for @loginTitle.
  ///
  /// In zh, this message translates to:
  /// **'登录'**
  String get loginTitle;

  /// No description provided for @loginWithQr.
  ///
  /// In zh, this message translates to:
  /// **'使用 bilibili 官方 App 扫码登录'**
  String get loginWithQr;

  /// No description provided for @loginQrExpiresIn.
  ///
  /// In zh, this message translates to:
  /// **'剩余有效时间：{seconds} 秒'**
  String loginQrExpiresIn(Object seconds);

  /// No description provided for @loginRefreshQr.
  ///
  /// In zh, this message translates to:
  /// **'刷新二维码'**
  String get loginRefreshQr;

  /// No description provided for @loginGeneratingScreenshot.
  ///
  /// In zh, this message translates to:
  /// **'正在生成截图'**
  String get loginGeneratingScreenshot;

  /// No description provided for @loginSaveToGallery.
  ///
  /// In zh, this message translates to:
  /// **'保存至相册'**
  String get loginSaveToGallery;

  /// No description provided for @loginOpenInAnotherApp.
  ///
  /// In zh, this message translates to:
  /// **'其他应用打开'**
  String get loginOpenInAnotherApp;

  /// No description provided for @loginQrCopiedHint.
  ///
  /// In zh, this message translates to:
  /// **'已复制到剪贴板，可粘贴至已登录的 App 私信处发送，然后点击已发送的链接打开。'**
  String get loginQrCopiedHint;

  /// No description provided for @loginTrustedSourceNotice.
  ///
  /// In zh, this message translates to:
  /// **'请务必在 {appName} 开源仓库等可信渠道下载安装。'**
  String loginTrustedSourceNotice(Object appName);

  /// No description provided for @loginWithCookie.
  ///
  /// In zh, this message translates to:
  /// **'使用 Cookie 登录'**
  String get loginWithCookie;

  /// No description provided for @loginCookieLimit.
  ///
  /// In zh, this message translates to:
  /// **'使用 App 端 API 实现的功能将不可用'**
  String get loginCookieLimit;

  /// No description provided for @loginWithPassword.
  ///
  /// In zh, this message translates to:
  /// **'使用账号密码登录'**
  String get loginWithPassword;

  /// No description provided for @loginAccount.
  ///
  /// In zh, this message translates to:
  /// **'账号'**
  String get loginAccount;

  /// No description provided for @loginEmailOrPhone.
  ///
  /// In zh, this message translates to:
  /// **'邮箱/手机号'**
  String get loginEmailOrPhone;

  /// No description provided for @loginPassword.
  ///
  /// In zh, this message translates to:
  /// **'密码'**
  String get loginPassword;

  /// No description provided for @loginShowPassword.
  ///
  /// In zh, this message translates to:
  /// **'显示密码'**
  String get loginShowPassword;

  /// No description provided for @loginForgotPasswordQuestion.
  ///
  /// In zh, this message translates to:
  /// **'忘记密码？'**
  String get loginForgotPasswordQuestion;

  /// No description provided for @loginForgotPasswordHint.
  ///
  /// In zh, this message translates to:
  /// **'试试扫码、手机号登录，或选择找回密码页面。'**
  String get loginForgotPasswordHint;

  /// No description provided for @loginRecoverPasswordMobile.
  ///
  /// In zh, this message translates to:
  /// **'找回密码（手机版）'**
  String get loginRecoverPasswordMobile;

  /// No description provided for @loginRecoverPasswordDesktop.
  ///
  /// In zh, this message translates to:
  /// **'找回密码（电脑版）'**
  String get loginRecoverPasswordDesktop;

  /// No description provided for @loginPasswordSecurityNotice.
  ///
  /// In zh, this message translates to:
  /// **'根据 bilibili 官方登录接口规范，密码将在本地加盐、加密后传输。盐与公钥均由官方提供；以 RSA/ECB/PKCS1Padding 方式加密。账号密码仅用于该登录接口，不予保存；本地仅存储登录凭证。\n请务必在 {appName} 开源仓库等可信渠道下载安装。'**
  String loginPasswordSecurityNotice(Object appName);

  /// No description provided for @loginWithSms.
  ///
  /// In zh, this message translates to:
  /// **'使用手机短信验证码登录'**
  String get loginWithSms;

  /// No description provided for @loginCountryCodeTooltip.
  ///
  /// In zh, this message translates to:
  /// **'选择国际冠码，当前为 {name}（+{code}）'**
  String loginCountryCodeTooltip(Object code, Object name);

  /// No description provided for @loginCountryOrRegion.
  ///
  /// In zh, this message translates to:
  /// **'国家/地区'**
  String get loginCountryOrRegion;

  /// No description provided for @loginPhoneNumber.
  ///
  /// In zh, this message translates to:
  /// **'手机号'**
  String get loginPhoneNumber;

  /// No description provided for @loginVerificationCode.
  ///
  /// In zh, this message translates to:
  /// **'验证码'**
  String get loginVerificationCode;

  /// No description provided for @loginWaitSeconds.
  ///
  /// In zh, this message translates to:
  /// **'等待 {seconds} 秒'**
  String loginWaitSeconds(Object seconds);

  /// No description provided for @loginGetVerificationCode.
  ///
  /// In zh, this message translates to:
  /// **'获取验证码'**
  String get loginGetVerificationCode;

  /// No description provided for @loginSmsPrivacyNotice.
  ///
  /// In zh, this message translates to:
  /// **'手机号仅用于 bilibili 官方发送验证码与登录接口，不予保存；本地仅存储登录凭证。\n请务必在 {appName} 开源仓库等可信渠道下载安装。'**
  String loginSmsPrivacyNotice(Object appName);

  /// No description provided for @loginPasswordTab.
  ///
  /// In zh, this message translates to:
  /// **'密码'**
  String get loginPasswordTab;

  /// No description provided for @loginSmsTab.
  ///
  /// In zh, this message translates to:
  /// **'短信'**
  String get loginSmsTab;

  /// No description provided for @loginQrTab.
  ///
  /// In zh, this message translates to:
  /// **'扫码'**
  String get loginQrTab;

  /// No description provided for @loginQrExpired.
  ///
  /// In zh, this message translates to:
  /// **'二维码已过期，请刷新'**
  String get loginQrExpired;

  /// No description provided for @loginQrSucceeded.
  ///
  /// In zh, this message translates to:
  /// **'扫码成功'**
  String get loginQrSucceeded;

  /// No description provided for @loginVerificationSucceeded.
  ///
  /// In zh, this message translates to:
  /// **'验证成功'**
  String get loginVerificationSucceeded;

  /// No description provided for @loginCookieRequired.
  ///
  /// In zh, this message translates to:
  /// **'Cookie 不能为空'**
  String get loginCookieRequired;

  /// No description provided for @loginSucceeded.
  ///
  /// In zh, this message translates to:
  /// **'登录成功'**
  String get loginSucceeded;

  /// No description provided for @loginFailedWithError.
  ///
  /// In zh, this message translates to:
  /// **'登录失败：{error}'**
  String loginFailedWithError(Object error);

  /// No description provided for @loginSessionExpired.
  ///
  /// In zh, this message translates to:
  /// **'bilibili 登录已失效，请重新登录'**
  String get loginSessionExpired;

  /// No description provided for @loginUserInfoFailed.
  ///
  /// In zh, this message translates to:
  /// **'获取 bilibili 用户信息失败，可前往账号管理重试'**
  String get loginUserInfoFailed;

  /// No description provided for @loginCredentialsRequired.
  ///
  /// In zh, this message translates to:
  /// **'用户名或密码不能为空'**
  String get loginCredentialsRequired;

  /// No description provided for @loginNoDataReturned.
  ///
  /// In zh, this message translates to:
  /// **'登录异常，接口未返回数据：{message}'**
  String loginNoDataReturned(Object message);

  /// No description provided for @loginTryAnotherMethod.
  ///
  /// In zh, this message translates to:
  /// **'请尝试其他登录方式。\n{details}'**
  String loginTryAnotherMethod(Object details);

  /// No description provided for @loginPhoneVerificationUnavailable.
  ///
  /// In zh, this message translates to:
  /// **'当前账号不支持手机号验证，请尝试其他登录方式'**
  String get loginPhoneVerificationUnavailable;

  /// No description provided for @loginPhoneVerificationRequired.
  ///
  /// In zh, this message translates to:
  /// **'本次登录需要验证您的手机号'**
  String get loginPhoneVerificationRequired;

  /// No description provided for @loginPhoneUnavailable.
  ///
  /// In zh, this message translates to:
  /// **'未能获取手机号'**
  String get loginPhoneUnavailable;

  /// No description provided for @loginEnterVerificationCode.
  ///
  /// In zh, this message translates to:
  /// **'请输入短信验证码'**
  String get loginEnterVerificationCode;

  /// No description provided for @loginSendVerificationCode.
  ///
  /// In zh, this message translates to:
  /// **'发送验证码'**
  String get loginSendVerificationCode;

  /// No description provided for @loginVerificationCodeSent.
  ///
  /// In zh, this message translates to:
  /// **'短信验证码已发送，请查收'**
  String get loginVerificationCodeSent;

  /// No description provided for @loginVerifyingAndSigningIn.
  ///
  /// In zh, this message translates to:
  /// **'验证成功，正在登录'**
  String get loginVerifyingAndSigningIn;

  /// No description provided for @loginMissingIdentity.
  ///
  /// In zh, this message translates to:
  /// **'登录异常，接口未返回身份信息，可能是因为账号风控，请尝试其他登录方式。\n{details}'**
  String loginMissingIdentity(Object details);

  /// No description provided for @loginSavingIdentity.
  ///
  /// In zh, this message translates to:
  /// **'正在保存身份信息'**
  String get loginSavingIdentity;

  /// No description provided for @loginPhoneRequired.
  ///
  /// In zh, this message translates to:
  /// **'手机号不能为空'**
  String get loginPhoneRequired;

  /// No description provided for @loginRequestCodeFirst.
  ///
  /// In zh, this message translates to:
  /// **'请先点击获取验证码'**
  String get loginRequestCodeFirst;

  /// No description provided for @loginVerificationCodeRequired.
  ///
  /// In zh, this message translates to:
  /// **'验证码不能为空'**
  String get loginVerificationCodeRequired;

  /// No description provided for @loginVerificationCodeExpired.
  ///
  /// In zh, this message translates to:
  /// **'验证码已过期，请重新获取'**
  String get loginVerificationCodeExpired;

  /// No description provided for @loginSucceededSetAccountMode.
  ///
  /// In zh, this message translates to:
  /// **'登录成功，请先设置账号模式'**
  String get loginSucceededSetAccountMode;

  /// No description provided for @commonServerError.
  ///
  /// In zh, this message translates to:
  /// **'服务器错误'**
  String get commonServerError;

  /// No description provided for @networkBadCertificate.
  ///
  /// In zh, this message translates to:
  /// **'证书无效'**
  String get networkBadCertificate;

  /// No description provided for @networkServerError.
  ///
  /// In zh, this message translates to:
  /// **'服务器异常，请稍后重试'**
  String get networkServerError;

  /// No description provided for @networkRequestCancelled.
  ///
  /// In zh, this message translates to:
  /// **'请求已取消'**
  String get networkRequestCancelled;

  /// No description provided for @networkConnectionError.
  ///
  /// In zh, this message translates to:
  /// **'连接错误，请检查网络设置'**
  String get networkConnectionError;

  /// No description provided for @networkConnectionTimeout.
  ///
  /// In zh, this message translates to:
  /// **'网络连接超时，请检查网络设置'**
  String get networkConnectionTimeout;

  /// No description provided for @networkResponseTimeout.
  ///
  /// In zh, this message translates to:
  /// **'响应超时，请稍后重试'**
  String get networkResponseTimeout;

  /// No description provided for @networkSendTimeout.
  ///
  /// In zh, this message translates to:
  /// **'发送请求超时，请检查网络设置'**
  String get networkSendTimeout;

  /// No description provided for @networkTransformTimeout.
  ///
  /// In zh, this message translates to:
  /// **'转换响应数据超时'**
  String get networkTransformTimeout;

  /// No description provided for @networkUnknownError.
  ///
  /// In zh, this message translates to:
  /// **'网络异常：{error}'**
  String networkUnknownError(String error);

  /// No description provided for @searchSecurityCheckTriggered.
  ///
  /// In zh, this message translates to:
  /// **'触发风控校验'**
  String get searchSecurityCheckTriggered;

  /// No description provided for @loginVerificationTitle.
  ///
  /// In zh, this message translates to:
  /// **'验证码'**
  String get loginVerificationTitle;

  /// No description provided for @loginCompleteVerificationWindow.
  ///
  /// In zh, this message translates to:
  /// **'请在弹出的新窗口中完成验证'**
  String get loginCompleteVerificationWindow;

  /// No description provided for @memberBlockConfirm.
  ///
  /// In zh, this message translates to:
  /// **'确定拉黑 UP 主吗？'**
  String get memberBlockConfirm;

  /// No description provided for @memberUnblockConfirm.
  ///
  /// In zh, this message translates to:
  /// **'从黑名单移除该 UP 主吗？'**
  String get memberUnblockConfirm;

  /// No description provided for @memberNoPlayableVideos.
  ///
  /// In zh, this message translates to:
  /// **'该 UP 主暂无可播放视频'**
  String get memberNoPlayableVideos;

  /// No description provided for @memberVideoPlayInfoUnavailable.
  ///
  /// In zh, this message translates to:
  /// **'无法获取视频播放信息'**
  String get memberVideoPlayInfoUnavailable;

  /// No description provided for @memberRandomVideoFailed.
  ///
  /// In zh, this message translates to:
  /// **'随机视频获取失败：{error}'**
  String memberRandomVideoFailed(Object error);

  /// No description provided for @memberFollowerRemoved.
  ///
  /// In zh, this message translates to:
  /// **'移除粉丝成功'**
  String get memberFollowerRemoved;

  /// No description provided for @memberPremiumRewardClaimed.
  ///
  /// In zh, this message translates to:
  /// **'领取成功'**
  String get memberPremiumRewardClaimed;

  /// No description provided for @memberAddToBlocked.
  ///
  /// In zh, this message translates to:
  /// **'加入黑名单'**
  String get memberAddToBlocked;

  /// No description provided for @memberRemoveFromBlocked.
  ///
  /// In zh, this message translates to:
  /// **'移除黑名单'**
  String get memberRemoveFromBlocked;

  /// No description provided for @memberRemoveFollower.
  ///
  /// In zh, this message translates to:
  /// **'移除粉丝'**
  String get memberRemoveFollower;

  /// No description provided for @memberShareUploader.
  ///
  /// In zh, this message translates to:
  /// **'分享 UP 主'**
  String get memberShareUploader;

  /// No description provided for @memberShareMyProfile.
  ///
  /// In zh, this message translates to:
  /// **'分享我的主页'**
  String get memberShareMyProfile;

  /// No description provided for @memberAddToHomeScreen.
  ///
  /// In zh, this message translates to:
  /// **'添加至桌面'**
  String get memberAddToHomeScreen;

  /// No description provided for @memberRandomPlay.
  ///
  /// In zh, this message translates to:
  /// **'随机播放'**
  String get memberRandomPlay;

  /// No description provided for @memberReservation.
  ///
  /// In zh, this message translates to:
  /// **'预约'**
  String get memberReservation;

  /// No description provided for @memberReserved.
  ///
  /// In zh, this message translates to:
  /// **'已预约'**
  String get memberReserved;

  /// No description provided for @memberReservationPost.
  ///
  /// In zh, this message translates to:
  /// **'预约动态'**
  String get memberReservationPost;

  /// No description provided for @memberReservationCount.
  ///
  /// In zh, this message translates to:
  /// **'{count} 人预约'**
  String memberReservationCount(Object count);

  /// No description provided for @memberWebUploads.
  ///
  /// In zh, this message translates to:
  /// **'网页投稿'**
  String get memberWebUploads;

  /// No description provided for @memberPremiumXp.
  ///
  /// In zh, this message translates to:
  /// **'大会员经验'**
  String get memberPremiumXp;

  /// No description provided for @memberSignInHistory.
  ///
  /// In zh, this message translates to:
  /// **'登录记录'**
  String get memberSignInHistory;

  /// No description provided for @memberCoinHistory.
  ///
  /// In zh, this message translates to:
  /// **'硬币记录'**
  String get memberCoinHistory;

  /// No description provided for @memberXpHistory.
  ///
  /// In zh, this message translates to:
  /// **'经验记录'**
  String get memberXpHistory;

  /// No description provided for @memberFollowingSince.
  ///
  /// In zh, this message translates to:
  /// **'关注时间：{date}'**
  String memberFollowingSince(Object date);

  /// No description provided for @memberAccountBanned.
  ///
  /// In zh, this message translates to:
  /// **'该账号封禁中'**
  String get memberAccountBanned;

  /// No description provided for @memberSupporterCount.
  ///
  /// In zh, this message translates to:
  /// **'{count} 人为 TA 充电'**
  String memberSupporterCount(Object count);

  /// No description provided for @memberGuardCount.
  ///
  /// In zh, this message translates to:
  /// **'{count} 人加入大航海'**
  String memberGuardCount(Object count);

  /// No description provided for @memberMyRecommendations.
  ///
  /// In zh, this message translates to:
  /// **'我的推荐'**
  String get memberMyRecommendations;

  /// No description provided for @memberRecommendationsBy.
  ///
  /// In zh, this message translates to:
  /// **'{name}的推荐'**
  String memberRecommendationsBy(String name);

  /// No description provided for @memberCollectionCount.
  ///
  /// In zh, this message translates to:
  /// **'合集：{count}'**
  String memberCollectionCount(int count);

  /// No description provided for @memberListCount.
  ///
  /// In zh, this message translates to:
  /// **'列表：{count}'**
  String memberListCount(int count);

  /// No description provided for @memberGuardTitle.
  ///
  /// In zh, this message translates to:
  /// **'{name}的舰队'**
  String memberGuardTitle(String name);

  /// No description provided for @memberGuardTitleWithCount.
  ///
  /// In zh, this message translates to:
  /// **'{name}的舰队（{count}）'**
  String memberGuardTitleWithCount(String name, Object count);

  /// No description provided for @memberAlsoFollowed.
  ///
  /// In zh, this message translates to:
  /// **'也关注了 TA'**
  String get memberAlsoFollowed;

  /// No description provided for @memberAlsoFollowedWithOthers.
  ///
  /// In zh, this message translates to:
  /// **'等 {count} 人也关注了 TA'**
  String memberAlsoFollowedWithOthers(Object count);

  /// No description provided for @memberLikesReceived.
  ///
  /// In zh, this message translates to:
  /// **'获赞'**
  String get memberLikesReceived;

  /// No description provided for @memberFollowingTime.
  ///
  /// In zh, this message translates to:
  /// **'关注时间'**
  String get memberFollowingTime;

  /// No description provided for @commonSelectedCount.
  ///
  /// In zh, this message translates to:
  /// **'已选：{count}'**
  String commonSelectedCount(Object count);

  /// No description provided for @commonSelectAll.
  ///
  /// In zh, this message translates to:
  /// **'全选'**
  String get commonSelectAll;

  /// No description provided for @commonCancelSelection.
  ///
  /// In zh, this message translates to:
  /// **'取消选择'**
  String get commonCancelSelection;

  /// No description provided for @imageSaveImage.
  ///
  /// In zh, this message translates to:
  /// **'保存图片'**
  String get imageSaveImage;

  /// No description provided for @imageSaveAll.
  ///
  /// In zh, this message translates to:
  /// **'保存全部'**
  String get imageSaveAll;

  /// No description provided for @imageSaveAllImages.
  ///
  /// In zh, this message translates to:
  /// **'保存全部图片'**
  String get imageSaveAllImages;

  /// No description provided for @imageSaveVideo.
  ///
  /// In zh, this message translates to:
  /// **'保存视频'**
  String get imageSaveVideo;

  /// No description provided for @imageSaveLivePhoto.
  ///
  /// In zh, this message translates to:
  /// **'保存实况照片'**
  String get imageSaveLivePhoto;

  /// No description provided for @imageOpenInBrowser.
  ///
  /// In zh, this message translates to:
  /// **'在浏览器中打开'**
  String get imageOpenInBrowser;

  /// No description provided for @commonDone.
  ///
  /// In zh, this message translates to:
  /// **'完成'**
  String get commonDone;

  /// No description provided for @commonCreate.
  ///
  /// In zh, this message translates to:
  /// **'创建'**
  String get commonCreate;

  /// No description provided for @favoriteSortMethod.
  ///
  /// In zh, this message translates to:
  /// **'排序方式'**
  String get favoriteSortMethod;

  /// No description provided for @favoriteContentCount.
  ///
  /// In zh, this message translates to:
  /// **'{count}个内容'**
  String favoriteContentCount(num count);

  /// No description provided for @favoriteContentSummary.
  ///
  /// In zh, this message translates to:
  /// **'{count}个内容 · {visibility}'**
  String favoriteContentSummary(num count, Object visibility);

  /// No description provided for @favoriteEditInfo.
  ///
  /// In zh, this message translates to:
  /// **'编辑信息'**
  String get favoriteEditInfo;

  /// No description provided for @favoriteShareToPost.
  ///
  /// In zh, this message translates to:
  /// **'分享至动态'**
  String get favoriteShareToPost;

  /// No description provided for @favoriteClearUnavailable.
  ///
  /// In zh, this message translates to:
  /// **'清除失效内容'**
  String get favoriteClearUnavailable;

  /// No description provided for @favoriteDeleteFolderConfirm.
  ///
  /// In zh, this message translates to:
  /// **'确定删除该收藏夹？'**
  String get favoriteDeleteFolderConfirm;

  /// No description provided for @favoriteRemoveSelectedConfirm.
  ///
  /// In zh, this message translates to:
  /// **'确认删除所选收藏吗？'**
  String get favoriteRemoveSelectedConfirm;

  /// No description provided for @favoriteRemoved.
  ///
  /// In zh, this message translates to:
  /// **'已取消收藏'**
  String get favoriteRemoved;

  /// No description provided for @favoriteFolderAdded.
  ///
  /// In zh, this message translates to:
  /// **'收藏夹收藏成功'**
  String get favoriteFolderAdded;

  /// No description provided for @favoriteFolderRemoved.
  ///
  /// In zh, this message translates to:
  /// **'已取消收藏夹收藏'**
  String get favoriteFolderRemoved;

  /// No description provided for @favoriteClearSucceeded.
  ///
  /// In zh, this message translates to:
  /// **'清除成功'**
  String get favoriteClearSucceeded;

  /// No description provided for @favoriteTooManyToSort.
  ///
  /// In zh, this message translates to:
  /// **'内容超过 1000 条，不支持排序'**
  String get favoriteTooManyToSort;

  /// No description provided for @favoriteRemoveConfirm.
  ///
  /// In zh, this message translates to:
  /// **'要取消收藏吗？'**
  String get favoriteRemoveConfirm;

  /// No description provided for @favoriteConfirmRemove.
  ///
  /// In zh, this message translates to:
  /// **'确定取消'**
  String get favoriteConfirmRemove;

  /// No description provided for @favoriteAudio.
  ///
  /// In zh, this message translates to:
  /// **'音频'**
  String get favoriteAudio;

  /// No description provided for @favoriteAddToFolder.
  ///
  /// In zh, this message translates to:
  /// **'添加到收藏夹'**
  String get favoriteAddToFolder;

  /// No description provided for @favoriteNameRequired.
  ///
  /// In zh, this message translates to:
  /// **'名称不能为空'**
  String get favoriteNameRequired;

  /// No description provided for @favoriteFolderCreated.
  ///
  /// In zh, this message translates to:
  /// **'创建成功'**
  String get favoriteFolderCreated;

  /// No description provided for @favoriteFolderUpdated.
  ///
  /// In zh, this message translates to:
  /// **'编辑成功'**
  String get favoriteFolderUpdated;

  /// No description provided for @favoriteCrop.
  ///
  /// In zh, this message translates to:
  /// **'裁剪'**
  String get favoriteCrop;

  /// No description provided for @favoriteReplaceCover.
  ///
  /// In zh, this message translates to:
  /// **'替换封面'**
  String get favoriteReplaceCover;

  /// No description provided for @favoriteRemoveCover.
  ///
  /// In zh, this message translates to:
  /// **'移除封面'**
  String get favoriteRemoveCover;

  /// No description provided for @favoriteCover.
  ///
  /// In zh, this message translates to:
  /// **'封面'**
  String get favoriteCover;

  /// No description provided for @favoriteName.
  ///
  /// In zh, this message translates to:
  /// **'名称'**
  String get favoriteName;

  /// No description provided for @favoriteIntro.
  ///
  /// In zh, this message translates to:
  /// **'简介'**
  String get favoriteIntro;

  /// No description provided for @favoriteIntroHint.
  ///
  /// In zh, this message translates to:
  /// **'可填写简介'**
  String get favoriteIntroHint;

  /// No description provided for @favoritePublicSetting.
  ///
  /// In zh, this message translates to:
  /// **'公开'**
  String get favoritePublicSetting;

  /// No description provided for @favoriteCollectionBadge.
  ///
  /// In zh, this message translates to:
  /// **'合集'**
  String get favoriteCollectionBadge;

  /// No description provided for @favoriteFolderBadge.
  ///
  /// In zh, this message translates to:
  /// **'收藏夹'**
  String get favoriteFolderBadge;

  /// No description provided for @favoriteUploaderCollectionSummary.
  ///
  /// In zh, this message translates to:
  /// **'{count}个内容 · {name}'**
  String favoriteUploaderCollectionSummary(Object count, Object name);

  /// No description provided for @favoriteCreatedCollectionSummary.
  ///
  /// In zh, this message translates to:
  /// **'创建者：{name}\n{count}个视频 · {views}播放'**
  String favoriteCreatedCollectionSummary(
    Object count,
    Object name,
    Object views,
  );

  /// No description provided for @favoriteOrderRecentlyAdded.
  ///
  /// In zh, this message translates to:
  /// **'最近收藏'**
  String get favoriteOrderRecentlyAdded;

  /// No description provided for @favoriteOrderMostPlayed.
  ///
  /// In zh, this message translates to:
  /// **'最多播放'**
  String get favoriteOrderMostPlayed;

  /// No description provided for @favoriteOrderRecentlyPublished.
  ///
  /// In zh, this message translates to:
  /// **'最近投稿'**
  String get favoriteOrderRecentlyPublished;

  /// No description provided for @profileTitle.
  ///
  /// In zh, this message translates to:
  /// **'账号资料'**
  String get profileTitle;

  /// No description provided for @profileAvatar.
  ///
  /// In zh, this message translates to:
  /// **'头像'**
  String get profileAvatar;

  /// No description provided for @profileNickname.
  ///
  /// In zh, this message translates to:
  /// **'昵称'**
  String get profileNickname;

  /// No description provided for @profileGender.
  ///
  /// In zh, this message translates to:
  /// **'性别'**
  String get profileGender;

  /// No description provided for @profileBirthday.
  ///
  /// In zh, this message translates to:
  /// **'出生年月'**
  String get profileBirthday;

  /// No description provided for @profileBio.
  ///
  /// In zh, this message translates to:
  /// **'个性签名'**
  String get profileBio;

  /// No description provided for @profileAvatarDecoration.
  ///
  /// In zh, this message translates to:
  /// **'头像挂件'**
  String get profileAvatarDecoration;

  /// No description provided for @profileVerification.
  ///
  /// In zh, this message translates to:
  /// **'哔哩哔哩认证'**
  String get profileVerification;

  /// No description provided for @profileInsufficientCoins.
  ///
  /// In zh, this message translates to:
  /// **'硬币不足'**
  String get profileInsufficientCoins;

  /// No description provided for @profileGenderMale.
  ///
  /// In zh, this message translates to:
  /// **'男'**
  String get profileGenderMale;

  /// No description provided for @profileGenderPrivate.
  ///
  /// In zh, this message translates to:
  /// **'保密'**
  String get profileGenderPrivate;

  /// No description provided for @profileGenderFemale.
  ///
  /// In zh, this message translates to:
  /// **'女'**
  String get profileGenderFemale;

  /// No description provided for @profileEditField.
  ///
  /// In zh, this message translates to:
  /// **'修改{field}'**
  String profileEditField(Object field);

  /// No description provided for @profileSameAsCurrent.
  ///
  /// In zh, this message translates to:
  /// **'与原{field}相同'**
  String profileSameAsCurrent(Object field);

  /// No description provided for @profileReloginRequired.
  ///
  /// In zh, this message translates to:
  /// **'请退出账号后重新登录'**
  String get profileReloginRequired;

  /// No description provided for @profileUpdateSucceeded.
  ///
  /// In zh, this message translates to:
  /// **'修改成功'**
  String get profileUpdateSucceeded;

  /// No description provided for @profileGifNotSupported.
  ///
  /// In zh, this message translates to:
  /// **'不能选择 GIF'**
  String get profileGifNotSupported;

  /// No description provided for @shutdownPauseVideo.
  ///
  /// In zh, this message translates to:
  /// **'暂停视频'**
  String get shutdownPauseVideo;

  /// No description provided for @shutdownExitApp.
  ///
  /// In zh, this message translates to:
  /// **'退出应用'**
  String get shutdownExitApp;

  /// No description provided for @shutdownTitle.
  ///
  /// In zh, this message translates to:
  /// **'定时关闭'**
  String get shutdownTitle;

  /// No description provided for @shutdownCanceled.
  ///
  /// In zh, this message translates to:
  /// **'已取消定时关闭'**
  String get shutdownCanceled;

  /// No description provided for @shutdownScheduledAfter.
  ///
  /// In zh, this message translates to:
  /// **'已设置在 {duration} 后定时关闭'**
  String shutdownScheduledAfter(Object duration);

  /// No description provided for @shutdownTimeReachedPaused.
  ///
  /// In zh, this message translates to:
  /// **'定时时间已到，已暂停'**
  String get shutdownTimeReachedPaused;

  /// No description provided for @shutdownHoursMinutes.
  ///
  /// In zh, this message translates to:
  /// **'{hours}小时{minutes}分钟'**
  String shutdownHoursMinutes(Object hours, Object minutes);

  /// No description provided for @shutdownHours.
  ///
  /// In zh, this message translates to:
  /// **'{hours}小时'**
  String shutdownHours(Object hours);

  /// No description provided for @shutdownMinutes.
  ///
  /// In zh, this message translates to:
  /// **'{minutes}分钟'**
  String shutdownMinutes(Object minutes);

  /// No description provided for @shutdownCustom.
  ///
  /// In zh, this message translates to:
  /// **'自定义'**
  String get shutdownCustom;

  /// No description provided for @shutdownWaitUntilVideoEnds.
  ///
  /// In zh, this message translates to:
  /// **'额外等待视频播放完毕'**
  String get shutdownWaitUntilVideoEnds;

  /// No description provided for @shutdownActionAtEnd.
  ///
  /// In zh, this message translates to:
  /// **'倒计时结束：'**
  String get shutdownActionAtEnd;

  /// No description provided for @replyViewComments.
  ///
  /// In zh, this message translates to:
  /// **'查看评论'**
  String get replyViewComments;

  /// No description provided for @replyAppeal.
  ///
  /// In zh, this message translates to:
  /// **'申诉'**
  String get replyAppeal;

  /// No description provided for @replyCheckResult.
  ///
  /// In zh, this message translates to:
  /// **'评论检查结果'**
  String get replyCheckResult;

  /// No description provided for @replyMainListError.
  ///
  /// In zh, this message translates to:
  /// **'获取评论主列表时发生错误：{error}'**
  String replyMainListError(Object error);

  /// No description provided for @replyCheckNormal.
  ///
  /// In zh, this message translates to:
  /// **'无账号状态下找到了你的评论，评论正常！\n\n你的评论：{message}'**
  String replyCheckNormal(Object message);

  /// No description provided for @replyCheckNotFound.
  ///
  /// In zh, this message translates to:
  /// **'无法找到你的评论。\n\n你的评论：{message}'**
  String replyCheckNotFound(Object message);

  /// No description provided for @replyCheckShadowBanned.
  ///
  /// In zh, this message translates to:
  /// **'你的评论可能仅自己可见！\n\n你的评论：{message}'**
  String replyCheckShadowBanned(Object message);

  /// No description provided for @replyCheckInvisible.
  ///
  /// In zh, this message translates to:
  /// **'评论不可见（{error}）：{message}'**
  String replyCheckInvisible(Object error, Object message);

  /// No description provided for @replyCheckSuspicious.
  ///
  /// In zh, this message translates to:
  /// **'你的评论状态有些可疑。无账号浏览评论区时无法看到，但可以通过以下地址直接获取：\n{url}\n评论区可能受到限制，或者这是你的视频。\n\n你的评论：{message}'**
  String replyCheckSuspicious(Object message, Object url);

  /// No description provided for @replyCheckInvisibleSimple.
  ///
  /// In zh, this message translates to:
  /// **'评论不可见：{message}'**
  String replyCheckInvisibleSimple(Object message);

  /// No description provided for @replyContentText.
  ///
  /// In zh, this message translates to:
  /// **'文本'**
  String get replyContentText;

  /// No description provided for @replyContentEmoji.
  ///
  /// In zh, this message translates to:
  /// **'表情'**
  String get replyContentEmoji;

  /// No description provided for @replyFilterChangeConfirm.
  ///
  /// In zh, this message translates to:
  /// **'确认应用评论过滤变更？'**
  String get replyFilterChangeConfirm;

  /// No description provided for @replyAddToFilter.
  ///
  /// In zh, this message translates to:
  /// **'加入过滤'**
  String get replyAddToFilter;

  /// No description provided for @memberReportTitle.
  ///
  /// In zh, this message translates to:
  /// **'举报：{name}'**
  String memberReportTitle(Object name);

  /// No description provided for @memberReportContentRequired.
  ///
  /// In zh, this message translates to:
  /// **'举报内容（必选，可多选）'**
  String get memberReportContentRequired;

  /// No description provided for @memberReportReasonOptional.
  ///
  /// In zh, this message translates to:
  /// **'举报理由（单选，非必选）'**
  String get memberReportReasonOptional;

  /// No description provided for @memberReportAvatar.
  ///
  /// In zh, this message translates to:
  /// **'头像违规'**
  String get memberReportAvatar;

  /// No description provided for @memberReportNickname.
  ///
  /// In zh, this message translates to:
  /// **'昵称违规'**
  String get memberReportNickname;

  /// No description provided for @memberReportBio.
  ///
  /// In zh, this message translates to:
  /// **'签名违规'**
  String get memberReportBio;

  /// No description provided for @memberReportChooseContent.
  ///
  /// In zh, this message translates to:
  /// **'至少选择一项作为举报内容'**
  String get memberReportChooseContent;

  /// No description provided for @reportFailed.
  ///
  /// In zh, this message translates to:
  /// **'举报失败'**
  String get reportFailed;

  /// No description provided for @feedPinned.
  ///
  /// In zh, this message translates to:
  /// **'置顶成功'**
  String get feedPinned;

  /// No description provided for @feedUnpinned.
  ///
  /// In zh, this message translates to:
  /// **'取消置顶成功'**
  String get feedUnpinned;

  /// No description provided for @updateCheckFailed.
  ///
  /// In zh, this message translates to:
  /// **'检查更新失败，GitHub 接口未返回数据，请检查网络'**
  String get updateCheckFailed;

  /// No description provided for @updateAlreadyLatest.
  ///
  /// In zh, this message translates to:
  /// **'已是最新版本'**
  String get updateAlreadyLatest;

  /// No description provided for @updateNewVersion.
  ///
  /// In zh, this message translates to:
  /// **'🎉 发现新版本'**
  String get updateNewVersion;

  /// No description provided for @updateViewFullChanges.
  ///
  /// In zh, this message translates to:
  /// **'查看完整提交记录'**
  String get updateViewFullChanges;

  /// No description provided for @updateStopReminding.
  ///
  /// In zh, this message translates to:
  /// **'不再提醒'**
  String get updateStopReminding;

  /// No description provided for @commonUnsupportedType.
  ///
  /// In zh, this message translates to:
  /// **'暂未支持此类型，请联系开发者'**
  String get commonUnsupportedType;

  /// No description provided for @commonGettingResource.
  ///
  /// In zh, this message translates to:
  /// **'资源获取中…'**
  String get commonGettingResource;

  /// No description provided for @commonResourceLoadFailed.
  ///
  /// In zh, this message translates to:
  /// **'资源加载失败'**
  String get commonResourceLoadFailed;

  /// No description provided for @routeUnknown.
  ///
  /// In zh, this message translates to:
  /// **'未知路径：{uri}，请截图反馈给开发者'**
  String routeUnknown(Object uri);

  /// No description provided for @videoLoadFailed.
  ///
  /// In zh, this message translates to:
  /// **'视频获取失败：{error}'**
  String videoLoadFailed(Object error);

  /// No description provided for @liveTitle.
  ///
  /// In zh, this message translates to:
  /// **'直播'**
  String get liveTitle;

  /// No description provided for @rankingTitle.
  ///
  /// In zh, this message translates to:
  /// **'排行榜'**
  String get rankingTitle;

  /// No description provided for @commonPlaylist.
  ///
  /// In zh, this message translates to:
  /// **'播放列表'**
  String get commonPlaylist;

  /// No description provided for @videoParts.
  ///
  /// In zh, this message translates to:
  /// **'分 P'**
  String get videoParts;

  /// No description provided for @videoChargingOnly.
  ///
  /// In zh, this message translates to:
  /// **'充电专属'**
  String get videoChargingOnly;

  /// No description provided for @videoTrailerBadge.
  ///
  /// In zh, this message translates to:
  /// **'预告'**
  String get videoTrailerBadge;

  /// No description provided for @videoLimitedFreeBadge.
  ///
  /// In zh, this message translates to:
  /// **'限免'**
  String get videoLimitedFreeBadge;

  /// No description provided for @subscriptionSubscribe.
  ///
  /// In zh, this message translates to:
  /// **'订阅'**
  String get subscriptionSubscribe;

  /// No description provided for @subscriptionUnsubscribe.
  ///
  /// In zh, this message translates to:
  /// **'取消订阅'**
  String get subscriptionUnsubscribe;

  /// No description provided for @subscriptionSubscribed.
  ///
  /// In zh, this message translates to:
  /// **'订阅成功'**
  String get subscriptionSubscribed;

  /// No description provided for @commonJumpToTop.
  ///
  /// In zh, this message translates to:
  /// **'跳至顶部'**
  String get commonJumpToTop;

  /// No description provided for @commonJumpToBottom.
  ///
  /// In zh, this message translates to:
  /// **'跳至底部'**
  String get commonJumpToBottom;

  /// No description provided for @commonJumpToCurrent.
  ///
  /// In zh, this message translates to:
  /// **'跳至当前'**
  String get commonJumpToCurrent;

  /// No description provided for @commonAscendingOrder.
  ///
  /// In zh, this message translates to:
  /// **'顺序'**
  String get commonAscendingOrder;

  /// No description provided for @commonDescendingOrder.
  ///
  /// In zh, this message translates to:
  /// **'倒序'**
  String get commonDescendingOrder;

  /// No description provided for @searchUserByUid.
  ///
  /// In zh, this message translates to:
  /// **'通过 UID 搜索用户'**
  String get searchUserByUid;

  /// No description provided for @searchTrending.
  ///
  /// In zh, this message translates to:
  /// **'大家都在搜'**
  String get searchTrending;

  /// No description provided for @searchDiscover.
  ///
  /// In zh, this message translates to:
  /// **'搜索发现'**
  String get searchDiscover;

  /// No description provided for @searchFullRanking.
  ///
  /// In zh, this message translates to:
  /// **'完整榜单'**
  String get searchFullRanking;

  /// No description provided for @searchHistory.
  ///
  /// In zh, this message translates to:
  /// **'搜索历史'**
  String get searchHistory;

  /// No description provided for @searchRecordHistory.
  ///
  /// In zh, this message translates to:
  /// **'记录搜索'**
  String get searchRecordHistory;

  /// No description provided for @searchIncognito.
  ///
  /// In zh, this message translates to:
  /// **'无痕搜索'**
  String get searchIncognito;

  /// No description provided for @searchImportExportHistory.
  ///
  /// In zh, this message translates to:
  /// **'导入或导出搜索历史'**
  String get searchImportExportHistory;

  /// No description provided for @searchClearHistoryConfirm.
  ///
  /// In zh, this message translates to:
  /// **'确定清空搜索历史？'**
  String get searchClearHistoryConfirm;

  /// No description provided for @searchTabCount.
  ///
  /// In zh, this message translates to:
  /// **'{label} {count}'**
  String searchTabCount(Object count, Object label);

  /// No description provided for @memberSearchHint.
  ///
  /// In zh, this message translates to:
  /// **'搜索「{name}」的动态、视频'**
  String memberSearchHint(Object name);

  /// No description provided for @favoriteDeleteSelectedNotesConfirm.
  ///
  /// In zh, this message translates to:
  /// **'确定删除已选中的笔记吗？'**
  String get favoriteDeleteSelectedNotesConfirm;

  /// No description provided for @favoriteRemoveCourseConfirm.
  ///
  /// In zh, this message translates to:
  /// **'确定取消收藏该课堂？'**
  String get favoriteRemoveCourseConfirm;

  /// No description provided for @downloadDeleteSelectedConfirm.
  ///
  /// In zh, this message translates to:
  /// **'确定删除选中视频？'**
  String get downloadDeleteSelectedConfirm;

  /// No description provided for @downloadQueueTitle.
  ///
  /// In zh, this message translates to:
  /// **'正在缓存'**
  String get downloadQueueTitle;

  /// No description provided for @downloadViewDetails.
  ///
  /// In zh, this message translates to:
  /// **'查看详情页'**
  String get downloadViewDetails;

  /// No description provided for @downloadOpenLocalFolder.
  ///
  /// In zh, this message translates to:
  /// **'打开本地文件夹'**
  String get downloadOpenLocalFolder;

  /// No description provided for @downloadVisitUploader.
  ///
  /// In zh, this message translates to:
  /// **'访问{name}'**
  String downloadVisitUploader(Object name);

  /// No description provided for @downloadUserProfile.
  ///
  /// In zh, this message translates to:
  /// **'用户主页'**
  String get downloadUserProfile;

  /// No description provided for @downloadWatched.
  ///
  /// In zh, this message translates to:
  /// **'已看完'**
  String get downloadWatched;

  /// No description provided for @downloadStatusDownloading.
  ///
  /// In zh, this message translates to:
  /// **'正在下载'**
  String get downloadStatusDownloading;

  /// No description provided for @downloadStatusAudioDownloading.
  ///
  /// In zh, this message translates to:
  /// **'正在下载音频'**
  String get downloadStatusAudioDownloading;

  /// No description provided for @downloadStatusGettingDanmaku.
  ///
  /// In zh, this message translates to:
  /// **'获取弹幕'**
  String get downloadStatusGettingDanmaku;

  /// No description provided for @downloadStatusGettingPlayUrl.
  ///
  /// In zh, this message translates to:
  /// **'获取播放地址'**
  String get downloadStatusGettingPlayUrl;

  /// No description provided for @downloadStatusCompleted.
  ///
  /// In zh, this message translates to:
  /// **'下载完成'**
  String get downloadStatusCompleted;

  /// No description provided for @downloadStatusFailed.
  ///
  /// In zh, this message translates to:
  /// **'下载失败'**
  String get downloadStatusFailed;

  /// No description provided for @downloadStatusAudioFailed.
  ///
  /// In zh, this message translates to:
  /// **'音频下载失败'**
  String get downloadStatusAudioFailed;

  /// No description provided for @downloadStatusDanmakuFailed.
  ///
  /// In zh, this message translates to:
  /// **'获取弹幕失败'**
  String get downloadStatusDanmakuFailed;

  /// No description provided for @downloadStatusPlayUrlFailed.
  ///
  /// In zh, this message translates to:
  /// **'获取播放地址失败'**
  String get downloadStatusPlayUrlFailed;

  /// No description provided for @downloadStatusPaused.
  ///
  /// In zh, this message translates to:
  /// **'暂停中'**
  String get downloadStatusPaused;

  /// No description provided for @downloadStatusWaiting.
  ///
  /// In zh, this message translates to:
  /// **'等待中'**
  String get downloadStatusWaiting;

  /// No description provided for @commonSettings.
  ///
  /// In zh, this message translates to:
  /// **'设置'**
  String get commonSettings;

  /// No description provided for @commonEmoji.
  ///
  /// In zh, this message translates to:
  /// **'表情'**
  String get commonEmoji;

  /// No description provided for @messagesRecall.
  ///
  /// In zh, this message translates to:
  /// **'撤回'**
  String get messagesRecall;

  /// No description provided for @messagesRecalled.
  ///
  /// In zh, this message translates to:
  /// **'撤回成功'**
  String get messagesRecalled;

  /// No description provided for @messagesSent.
  ///
  /// In zh, this message translates to:
  /// **'发送成功'**
  String get messagesSent;

  /// No description provided for @messagesInputHint.
  ///
  /// In zh, this message translates to:
  /// **'发个消息聊聊吧…'**
  String get messagesInputHint;

  /// No description provided for @messagesUploadingImage.
  ///
  /// In zh, this message translates to:
  /// **'正在上传图片…'**
  String get messagesUploadingImage;

  /// No description provided for @messagesChatSettings.
  ///
  /// In zh, this message translates to:
  /// **'聊天设置'**
  String get messagesChatSettings;

  /// No description provided for @messagesAddToBlocked.
  ///
  /// In zh, this message translates to:
  /// **'加入黑名单'**
  String get messagesAddToBlocked;

  /// No description provided for @messagesReceivePush.
  ///
  /// In zh, this message translates to:
  /// **'接收消息推送'**
  String get messagesReceivePush;

  /// No description provided for @messagesPushDescription.
  ///
  /// In zh, this message translates to:
  /// **'关闭后将不再收到该账号的图文消息与稿件推送，但通知类消息不受影响。'**
  String get messagesPushDescription;

  /// No description provided for @messagesPinChat.
  ///
  /// In zh, this message translates to:
  /// **'置顶聊天'**
  String get messagesPinChat;

  /// No description provided for @messagesMute.
  ///
  /// In zh, this message translates to:
  /// **'消息免打扰'**
  String get messagesMute;

  /// No description provided for @messagesDisablePushConfirm.
  ///
  /// In zh, this message translates to:
  /// **'确认关闭内容推送吗？'**
  String get messagesDisablePushConfirm;

  /// No description provided for @messagesBlockConfirm.
  ///
  /// In zh, this message translates to:
  /// **'确认拉黑该用户？'**
  String get messagesBlockConfirm;

  /// No description provided for @messagesBlockDescription.
  ///
  /// In zh, this message translates to:
  /// **'加入黑名单后，将自动解除关注关系和对该用户的合集订阅关系，并禁止该用户与你互动或查看你的空间。'**
  String get messagesBlockDescription;

  /// No description provided for @messagesBvNotFound.
  ///
  /// In zh, this message translates to:
  /// **'未匹配到 BV 号'**
  String get messagesBvNotFound;

  /// No description provided for @commonAdd.
  ///
  /// In zh, this message translates to:
  /// **'添加'**
  String get commonAdd;

  /// No description provided for @messagesBlockedKeywords.
  ///
  /// In zh, this message translates to:
  /// **'消息屏蔽词'**
  String get messagesBlockedKeywords;

  /// No description provided for @messagesTapKeywordToDelete.
  ///
  /// In zh, this message translates to:
  /// **'点击屏蔽词即可删除'**
  String get messagesTapKeywordToDelete;

  /// No description provided for @messagesDeleteKeywordConfirm.
  ///
  /// In zh, this message translates to:
  /// **'删除屏蔽词？'**
  String get messagesDeleteKeywordConfirm;

  /// No description provided for @messagesKeywordNoLongerApplies.
  ///
  /// In zh, this message translates to:
  /// **'该屏蔽词将不再生效'**
  String get messagesKeywordNoLongerApplies;

  /// No description provided for @messagesAddBlockedKeyword.
  ///
  /// In zh, this message translates to:
  /// **'添加消息屏蔽词'**
  String get messagesAddBlockedKeyword;

  /// No description provided for @messagesNoBlockedKeywords.
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
