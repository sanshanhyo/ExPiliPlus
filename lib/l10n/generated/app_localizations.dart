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
