// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get commonCancel => '取消';

  @override
  String get commonConfirm => '确定';

  @override
  String get settingsTitle => '设置';

  @override
  String get settingsSearch => '搜索';

  @override
  String get settingsPrivacyTitle => '隐私设置';

  @override
  String get settingsPrivacySummary => '黑名单';

  @override
  String get settingsRecommendationFeedTitle => '推荐流设置';

  @override
  String get settingsRecommendationFeedSummary => '推荐来源（Web/App）、刷新保留内容、过滤器';

  @override
  String get settingsAudioVideoTitle => '音视频设置';

  @override
  String get settingsAudioVideoSummary => '画质、音质、解码、缓冲、音频输出等';

  @override
  String get settingsPlayerTitle => '播放器设置';

  @override
  String get settingsPlayerSummary => '双击/长按、全屏、后台播放、弹幕、字幕、底部进度条等';

  @override
  String get settingsAppearanceTitle => '外观设置';

  @override
  String get settingsAppearanceSummary => '横屏适配、侧边栏、首页、动态、主题、字体和图片等';

  @override
  String get settingsGeneralTitle => '其它设置';

  @override
  String get settingsGeneralSummary => '震动、搜索、收藏、AI、评论、动态、代理和更新等';

  @override
  String get settingsExPiliPlusTitle => 'ExPiliPlus 设置';

  @override
  String get settingsExPiliPlusSummary => '语言、自定义主题色、字体、随机播放和自动点赞等';

  @override
  String get settingsWebDavTitle => 'WebDAV 设置';

  @override
  String get settingsAboutTitle => '关于';

  @override
  String get settingsSwitchAccount => '切换账号';

  @override
  String get settingsSignOut => '退出登录';

  @override
  String get settingsAppLanguage => '应用语言';

  @override
  String settingsCurrentLanguage(String language) {
    return '当前：$language';
  }

  @override
  String get languagePickerTitle => '应用语言';

  @override
  String get languageSystemDefault => '跟随系统';

  @override
  String get languageSimplifiedChinese => '简体中文';

  @override
  String get languageTraditionalChinese => '繁體中文';

  @override
  String get languageEnglish => '英语';

  @override
  String get settingsCustomThemeColor => '自定义主题色';

  @override
  String get settingsCustomThemeColorDisabled => '未启用，使用动态取色或 PiliPlus 预设色';

  @override
  String settingsCustomThemeColorSavedOverridden(String color) {
    return '已保存 $color，当前由动态取色覆盖';
  }

  @override
  String settingsCurrentValue(String value) {
    return '当前：$value';
  }

  @override
  String get settingsAppFont => '应用字体';

  @override
  String get settingsAppFontWeight => '应用字体字重';

  @override
  String get settingsTapToConfigure => '点击设置';

  @override
  String get settingsUploaderProfileShuffle => 'UP 主页显示随机播放按钮';

  @override
  String get settingsAutoLikeOpenedVideos => '自动点赞点开的视频';

  @override
  String get settingsAutoLikeOpenedVideosDescription =>
      '进入视频详情后自动点赞一次，已点赞的视频会跳过';

  @override
  String get settingsPiliPlusThemeRestored => '已恢复 PiliPlus 主题色';

  @override
  String settingsThemeColorSet(String color) {
    return '主题色已设为 $color';
  }

  @override
  String get settingsLoadingFont => '正在加载字体';
}

/// The translations for Chinese, using the Han script (`zh_Hant`).
class AppLocalizationsZhHant extends AppLocalizationsZh {
  AppLocalizationsZhHant() : super('zh_Hant');

  @override
  String get commonCancel => '取消';

  @override
  String get commonConfirm => '確認';

  @override
  String get settingsTitle => '設定';

  @override
  String get settingsSearch => '搜尋';

  @override
  String get settingsPrivacyTitle => '隱私設定';

  @override
  String get settingsPrivacySummary => '封鎖的使用者';

  @override
  String get settingsRecommendationFeedTitle => '推薦動態設定';

  @override
  String get settingsRecommendationFeedSummary => '推薦來源（Web/App）、重新整理保留內容、篩選器';

  @override
  String get settingsAudioVideoTitle => '音訊與影片設定';

  @override
  String get settingsAudioVideoSummary => '畫質、音質、解碼、緩衝、音訊輸出等';

  @override
  String get settingsPlayerTitle => '播放器設定';

  @override
  String get settingsPlayerSummary => '雙擊/長按、全螢幕、背景播放、彈幕、字幕、底部進度列等';

  @override
  String get settingsAppearanceTitle => '外觀設定';

  @override
  String get settingsAppearanceSummary => '橫向配置、側邊欄、首頁、動態、主題、字型和圖片等';

  @override
  String get settingsGeneralTitle => '其他設定';

  @override
  String get settingsGeneralSummary => '震動、搜尋、收藏、AI、留言、動態、Proxy 和更新等';

  @override
  String get settingsExPiliPlusTitle => 'ExPiliPlus 設定';

  @override
  String get settingsExPiliPlusSummary => '語言、自訂主題色、字型、隨機播放和自動按讚等';

  @override
  String get settingsWebDavTitle => 'WebDAV 設定';

  @override
  String get settingsAboutTitle => '關於';

  @override
  String get settingsSwitchAccount => '切換帳號';

  @override
  String get settingsSignOut => '登出';

  @override
  String get settingsAppLanguage => '應用程式語言';

  @override
  String settingsCurrentLanguage(String language) {
    return '目前：$language';
  }

  @override
  String get languagePickerTitle => '應用程式語言';

  @override
  String get languageSystemDefault => '跟隨系統';

  @override
  String get languageSimplifiedChinese => '簡體中文';

  @override
  String get languageTraditionalChinese => '繁體中文';

  @override
  String get languageEnglish => '英文';

  @override
  String get settingsCustomThemeColor => '自訂主題色';

  @override
  String get settingsCustomThemeColorDisabled => '未啟用，使用動態色彩或 PiliPlus 預設色';

  @override
  String settingsCustomThemeColorSavedOverridden(String color) {
    return '已儲存 $color，目前由動態色彩覆蓋';
  }

  @override
  String settingsCurrentValue(String value) {
    return '目前：$value';
  }

  @override
  String get settingsAppFont => '應用程式字型';

  @override
  String get settingsAppFontWeight => '應用程式字重';

  @override
  String get settingsTapToConfigure => '點擊設定';

  @override
  String get settingsUploaderProfileShuffle => 'UP 主頁顯示隨機播放按鈕';

  @override
  String get settingsAutoLikeOpenedVideos => '自動按讚已開啟的影片';

  @override
  String get settingsAutoLikeOpenedVideosDescription =>
      '進入影片詳細資料後自動按讚一次，已按讚的影片會略過';

  @override
  String get settingsPiliPlusThemeRestored => '已還原 PiliPlus 主題色';

  @override
  String settingsThemeColorSet(String color) {
    return '主題色已設為 $color';
  }

  @override
  String get settingsLoadingFont => '正在載入字型';
}
