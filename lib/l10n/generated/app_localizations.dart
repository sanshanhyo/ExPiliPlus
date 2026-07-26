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

  /// No description provided for @replyReplyPrefix.
  ///
  /// In zh, this message translates to:
  /// **'回复 @{name}：{message}'**
  String replyReplyPrefix(String name, String message);

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
  /// **'{title}\nUploader：{uploader}\n{url}'**
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
  /// **'确定拉黑 {name}（{id}）？\n\n被拉黑的 Uploader 可在隐私设置的黑名单管理中解除。'**
  String videoConfirmBlockUploader(String name, String id);
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
