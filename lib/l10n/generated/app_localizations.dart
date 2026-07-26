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
