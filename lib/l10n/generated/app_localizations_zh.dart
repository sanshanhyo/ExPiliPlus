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
  String get settingsSystemDefaultFont => '系统默认';

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

  @override
  String get commonSearch => '搜索';

  @override
  String get commonImport => '导入';

  @override
  String get commonContinue => '继续';

  @override
  String get commonPrevious => '上一步';

  @override
  String get commonNext => '下一步';

  @override
  String get commonDefault => '默认';

  @override
  String get commonRefresh => '刷新';

  @override
  String get commonSeeMore => '查看更多';

  @override
  String get commonListSeparator => '、';

  @override
  String commonItemCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 个',
      one: '1 个',
      zero: '0 个',
    );
    return '$_temp0';
  }

  @override
  String get navigationHome => '首页';

  @override
  String get navigationFeed => '动态';

  @override
  String get navigationMe => '我的';

  @override
  String get navigationLive => '直播';

  @override
  String get navigationRecommended => '推荐';

  @override
  String get navigationTrending => '热门';

  @override
  String get navigationCategories => '分区';

  @override
  String get navigationAnime => '番剧';

  @override
  String get navigationMoviesAndTv => '影视';

  @override
  String get navigationMessages => '消息';

  @override
  String get desktopShowWindow => '显示窗口';

  @override
  String desktopExitApp(String appName) {
    return '退出 $appName';
  }

  @override
  String get themeLight => '浅色';

  @override
  String get themeDark => '深色';

  @override
  String get themeSystem => '跟随系统';

  @override
  String get accountTapToSignIn => '点击登录';

  @override
  String get accountPleaseSignIn => '请先登录';

  @override
  String get accessibilityPremium => '大会员';

  @override
  String get accessibilityDefaultAvatar => '默认头像';

  @override
  String get mineDownloads => '离线缓存';

  @override
  String get mineWatchHistory => '观看记录';

  @override
  String get mineSubscriptions => '我的订阅';

  @override
  String get mineWatchLater => '稍后再看';

  @override
  String get mineCommentHistory => '评论记录';

  @override
  String get mineEnterIncognito => '进入无痕模式';

  @override
  String get mineExitIncognito => '退出无痕模式';

  @override
  String mineSwitchTheme(String theme) {
    return '切换至$theme主题';
  }

  @override
  String get mineIncognitoEntered => '已进入无痕模式';

  @override
  String get mineIncognitoDescription =>
      '搜索不携带身份信息\n不产生查询或播放记录\n点赞等其它操作不受影响\n播放进度信息跟随视频取流\n（前往隐私设置了解详情）';

  @override
  String get mineIncognitoPermanentSet => '已设为永久无痕模式';

  @override
  String get mineIncognitoSavePermanently => '保存为永久';

  @override
  String get mineIncognitoTemporarySet => '已设为临时无痕模式';

  @override
  String get mineIncognitoThisSession => '仅本次（默认）';

  @override
  String get mineIncognitoExited => '已退出无痕模式';

  @override
  String get mineCoins => '硬币';

  @override
  String get mineXp => '经验';

  @override
  String get minePosts => '动态';

  @override
  String get mineFollowing => '关注';

  @override
  String get mineFollowers => '粉丝';

  @override
  String get mineFavorites => '我的收藏';

  @override
  String get favoritePublic => '公开';

  @override
  String get favoritePrivate => '私密';

  @override
  String favoriteFolderSummary(int count, String visibility) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '共 $count 条视频 · $visibility',
      one: '共 1 条视频 · $visibility',
      zero: '共 0 条视频 · $visibility',
    );
    return '$_temp0';
  }

  @override
  String get onboardingStepWelcome => '欢迎';

  @override
  String get onboardingStepImport => '导入';

  @override
  String get onboardingStepAppearance => '外观';

  @override
  String get onboardingStepAccount => '账户';

  @override
  String get onboardingStepFinish => '完成';

  @override
  String get onboardingWelcomeTitle => '欢迎使用 ExPiliPlus';

  @override
  String get onboardingWelcomeSubtitle =>
      '基于 PiliPlus 二次开发，探索更多个性化与实验性功能(｡･∀･)ﾉﾞ';

  @override
  String get onboardingWelcomeMigrateSettings => '迁移既有设置';

  @override
  String get onboardingWelcomeAppearance => '整理外观偏好';

  @override
  String get onboardingWelcomeAccount => '登录或导入本地账号备份';

  @override
  String get onboardingImportTitle => '导入';

  @override
  String get onboardingImportSubtitle =>
      '从 PiliPlus / ExPiliPlus 的本地文件或 WebDAV 备份迁移设置，也可以全新开始。';

  @override
  String get onboardingImportLocal => '从本地文件导入';

  @override
  String get onboardingImportLocalDescription => '选择导出的设置 JSON 文件';

  @override
  String get onboardingImportWebDav => '从 WebDAV 导入';

  @override
  String get onboardingImportWebDavDescription => '使用 WebDAV 备份中的设置文件';

  @override
  String get onboardingStartFresh => '全新开始';

  @override
  String get onboardingStartFreshDescription => '保留默认设置继续';

  @override
  String get onboardingAppearanceTitle => '外观';

  @override
  String get onboardingAppearanceDescription => '先选一个舒服的阅读环境，之后也可以在设置里继续调整。';

  @override
  String get onboardingAppearanceImportedDescription => '已应用导入的设置，可以在这里顺手微调。';

  @override
  String get onboardingFontSize => '字体大小';

  @override
  String get onboardingLargeScreenOptimization => '大屏优化';

  @override
  String get onboardingLargeScreenOptimizationDescription =>
      '平板和横屏设备优先使用更适合大屏的导航布局';

  @override
  String get onboardingAccountTitle => '账户';

  @override
  String get onboardingAccountDescription =>
      '登录后可以同步收藏、历史和关注；也可以从本地账号备份导入登录信息。';

  @override
  String get onboardingSignIn => '登录';

  @override
  String get onboardingSignInDescription => '使用现有登录方式进入账号';

  @override
  String get onboardingImportAccount => '从本地备份导入账户';

  @override
  String get onboardingImportAccountDescription => '选择导出的登录信息 JSON 文件';

  @override
  String get onboardingSkipSignIn => '暂不登录';

  @override
  String get onboardingSkipSignInDescription => '先进入应用，之后随时可以登录';

  @override
  String get onboardingReadyTitle => '准备好了';

  @override
  String get onboardingReadyDescription => '欢迎来到 ExPiliPlus。';

  @override
  String get onboardingUsingDefaultSettings => '使用默认设置';

  @override
  String get onboardingNotSignedIn => '暂未登录';

  @override
  String get onboardingGetStarted => '开始';

  @override
  String get onboardingStartUsing => '开始使用';

  @override
  String get onboardingSourceLocalFile => '本地文件';

  @override
  String get onboardingSourceWebDavBackup => 'WebDAV 备份';

  @override
  String onboardingWebDavReadFailed(String error) {
    return '读取 WebDAV 失败：$error';
  }

  @override
  String onboardingSettingsParseFailed(String error) {
    return '解析设置失败：$error';
  }

  @override
  String onboardingSettingsImported(int count, String categories) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '已导入 $count 项设置（$categories）',
      one: '已导入 1 项设置（$categories）',
      zero: '已导入 0 项设置（$categories）',
    );
    return '$_temp0';
  }

  @override
  String get onboardingSettingsImportSucceeded => '设置导入成功';

  @override
  String onboardingAccountParseFailed(String error) {
    return '解析登录信息失败：$error';
  }

  @override
  String onboardingSignedInMid(int mid) {
    return '已登录 mid $mid';
  }

  @override
  String onboardingAccountsImported(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '已导入 $count 个账号',
      one: '已导入 1 个账号',
      zero: '已导入 0 个账号',
    );
    return '$_temp0';
  }

  @override
  String get onboardingAccountImportSucceeded => '登录信息导入成功';

  @override
  String get onboardingErrorJsonTopLevelObject => 'JSON 顶层必须是对象';

  @override
  String onboardingConfirmSettingsImport(String source) {
    return '导入 $source 设置？';
  }

  @override
  String get onboardingSettingsFields => '设置字段';

  @override
  String get onboardingPlaybackFields => '播放字段';

  @override
  String get onboardingCategory => '分类';

  @override
  String get onboardingExtraTopLevelFields => '额外顶层字段';

  @override
  String get onboardingConfirmAccountImport => '导入本地账号备份？';

  @override
  String get onboardingAccountCount => '账号数量';

  @override
  String get onboardingContainsCookie => '包含 Cookie';

  @override
  String get onboardingContainsAccessKey => '包含 accessKey';

  @override
  String get onboardingContainsRefresh => '包含 refresh';

  @override
  String get onboardingWillOverwrite => '将覆盖';

  @override
  String get onboardingWebDavAddress => '地址';

  @override
  String get onboardingWebDavAddressRequired => '请输入 WebDAV 地址';

  @override
  String get onboardingWebDavUser => '用户';

  @override
  String get onboardingWebDavPassword => '密码';

  @override
  String get onboardingWebDavPath => '路径';

  @override
  String get onboardingCategoryAppearance => '外观';

  @override
  String get onboardingCategoryPlayback => '播放';

  @override
  String get onboardingCategoryWebDav => 'WebDAV';

  @override
  String get onboardingCategoryLayout => '布局';

  @override
  String get onboardingCategoryGeneral => '通用';

  @override
  String get onboardingErrorNoSettingsData => '未找到 setting 或 video 数据';

  @override
  String onboardingErrorValueMustBeObject(String name) {
    return '$name 必须是对象';
  }

  @override
  String onboardingMidListSummary(String mids, int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$mids 等 $count 个',
      one: '$mids 等 1 个',
      zero: '$mids 等 0 个',
    );
    return '$_temp0';
  }

  @override
  String onboardingErrorAccountMustBeObject(String account) {
    return '账号 $account 必须是对象';
  }

  @override
  String get onboardingErrorNoAccountData => '未找到账号数据';
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
  String get settingsSystemDefaultFont => '系統預設';

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

  @override
  String get commonSearch => '搜尋';

  @override
  String get commonImport => '匯入';

  @override
  String get commonContinue => '繼續';

  @override
  String get commonPrevious => '上一步';

  @override
  String get commonNext => '下一步';

  @override
  String get commonDefault => '預設';

  @override
  String get commonRefresh => '重新整理';

  @override
  String get commonSeeMore => '查看更多';

  @override
  String get commonListSeparator => '、';

  @override
  String commonItemCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 個',
      one: '1 個',
      zero: '0 個',
    );
    return '$_temp0';
  }

  @override
  String get navigationHome => '首頁';

  @override
  String get navigationFeed => '動態';

  @override
  String get navigationMe => '我的';

  @override
  String get navigationLive => '直播';

  @override
  String get navigationRecommended => '推薦';

  @override
  String get navigationTrending => '熱門';

  @override
  String get navigationCategories => '分區';

  @override
  String get navigationAnime => '番劇';

  @override
  String get navigationMoviesAndTv => '影視';

  @override
  String get navigationMessages => '訊息';

  @override
  String get desktopShowWindow => '顯示視窗';

  @override
  String desktopExitApp(String appName) {
    return '結束 $appName';
  }

  @override
  String get themeLight => '淺色';

  @override
  String get themeDark => '深色';

  @override
  String get themeSystem => '跟隨系統';

  @override
  String get accountTapToSignIn => '點擊登入';

  @override
  String get accountPleaseSignIn => '請先登入';

  @override
  String get accessibilityPremium => '大會員';

  @override
  String get accessibilityDefaultAvatar => '預設頭像';

  @override
  String get mineDownloads => '離線快取';

  @override
  String get mineWatchHistory => '觀看紀錄';

  @override
  String get mineSubscriptions => '我的訂閱';

  @override
  String get mineWatchLater => '稍後觀看';

  @override
  String get mineCommentHistory => '留言紀錄';

  @override
  String get mineEnterIncognito => '進入無痕模式';

  @override
  String get mineExitIncognito => '退出無痕模式';

  @override
  String mineSwitchTheme(String theme) {
    return '切換至$theme主題';
  }

  @override
  String get mineIncognitoEntered => '已進入無痕模式';

  @override
  String get mineIncognitoDescription =>
      '搜尋不會攜帶身分資訊\n不會產生查詢或播放紀錄\n按讚等其他操作不受影響\n播放進度資訊會跟隨影片串流\n（前往隱私設定瞭解詳情）';

  @override
  String get mineIncognitoPermanentSet => '已設為永久無痕模式';

  @override
  String get mineIncognitoSavePermanently => '永久儲存';

  @override
  String get mineIncognitoTemporarySet => '已設為暫時無痕模式';

  @override
  String get mineIncognitoThisSession => '僅本次（預設）';

  @override
  String get mineIncognitoExited => '已退出無痕模式';

  @override
  String get mineCoins => '硬幣';

  @override
  String get mineXp => '經驗';

  @override
  String get minePosts => '動態';

  @override
  String get mineFollowing => '關注';

  @override
  String get mineFollowers => '粉絲';

  @override
  String get mineFavorites => '我的收藏';

  @override
  String get favoritePublic => '公開';

  @override
  String get favoritePrivate => '私人';

  @override
  String favoriteFolderSummary(int count, String visibility) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '共 $count 部影片 · $visibility',
      one: '共 1 部影片 · $visibility',
      zero: '共 0 部影片 · $visibility',
    );
    return '$_temp0';
  }

  @override
  String get onboardingStepWelcome => '歡迎';

  @override
  String get onboardingStepImport => '匯入';

  @override
  String get onboardingStepAppearance => '外觀';

  @override
  String get onboardingStepAccount => '帳號';

  @override
  String get onboardingStepFinish => '完成';

  @override
  String get onboardingWelcomeTitle => '歡迎使用 ExPiliPlus';

  @override
  String get onboardingWelcomeSubtitle =>
      '基於 PiliPlus 二次開發，探索更多個人化與實驗性功能(｡･∀･)ﾉﾞ';

  @override
  String get onboardingWelcomeMigrateSettings => '移轉現有設定';

  @override
  String get onboardingWelcomeAppearance => '整理外觀偏好';

  @override
  String get onboardingWelcomeAccount => '登入或匯入本機帳號備份';

  @override
  String get onboardingImportTitle => '匯入';

  @override
  String get onboardingImportSubtitle =>
      '從 PiliPlus / ExPiliPlus 的本機檔案或 WebDAV 備份移轉設定，也可以全新開始。';

  @override
  String get onboardingImportLocal => '從本機檔案匯入';

  @override
  String get onboardingImportLocalDescription => '選擇匯出的設定 JSON 檔案';

  @override
  String get onboardingImportWebDav => '從 WebDAV 匯入';

  @override
  String get onboardingImportWebDavDescription => '使用 WebDAV 備份中的設定檔案';

  @override
  String get onboardingStartFresh => '全新開始';

  @override
  String get onboardingStartFreshDescription => '保留預設設定並繼續';

  @override
  String get onboardingAppearanceTitle => '外觀';

  @override
  String get onboardingAppearanceDescription => '先選擇舒適的閱讀環境，之後也可以在設定中繼續調整。';

  @override
  String get onboardingAppearanceImportedDescription => '已套用匯入的設定，可以在這裡順手微調。';

  @override
  String get onboardingFontSize => '字型大小';

  @override
  String get onboardingLargeScreenOptimization => '大螢幕最佳化';

  @override
  String get onboardingLargeScreenOptimizationDescription =>
      '平板和橫向裝置優先使用更適合大螢幕的導覽版面';

  @override
  String get onboardingAccountTitle => '帳號';

  @override
  String get onboardingAccountDescription =>
      '登入後可以同步收藏、紀錄和關注；也可以從本機帳號備份匯入登入資訊。';

  @override
  String get onboardingSignIn => '登入';

  @override
  String get onboardingSignInDescription => '使用現有登入方式進入帳號';

  @override
  String get onboardingImportAccount => '從本機備份匯入帳號';

  @override
  String get onboardingImportAccountDescription => '選擇匯出的登入資訊 JSON 檔案';

  @override
  String get onboardingSkipSignIn => '暫不登入';

  @override
  String get onboardingSkipSignInDescription => '先進入應用程式，之後隨時可以登入';

  @override
  String get onboardingReadyTitle => '準備好了';

  @override
  String get onboardingReadyDescription => '歡迎來到 ExPiliPlus。';

  @override
  String get onboardingUsingDefaultSettings => '使用預設設定';

  @override
  String get onboardingNotSignedIn => '尚未登入';

  @override
  String get onboardingGetStarted => '開始';

  @override
  String get onboardingStartUsing => '開始使用';

  @override
  String get onboardingSourceLocalFile => '本機檔案';

  @override
  String get onboardingSourceWebDavBackup => 'WebDAV 備份';

  @override
  String onboardingWebDavReadFailed(String error) {
    return '讀取 WebDAV 失敗：$error';
  }

  @override
  String onboardingSettingsParseFailed(String error) {
    return '解析設定失敗：$error';
  }

  @override
  String onboardingSettingsImported(int count, String categories) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '已匯入 $count 項設定（$categories）',
      one: '已匯入 1 項設定（$categories）',
      zero: '已匯入 0 項設定（$categories）',
    );
    return '$_temp0';
  }

  @override
  String get onboardingSettingsImportSucceeded => '設定匯入成功';

  @override
  String onboardingAccountParseFailed(String error) {
    return '解析登入資訊失敗：$error';
  }

  @override
  String onboardingSignedInMid(int mid) {
    return '已登入 mid $mid';
  }

  @override
  String onboardingAccountsImported(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '已匯入 $count 個帳號',
      one: '已匯入 1 個帳號',
      zero: '已匯入 0 個帳號',
    );
    return '$_temp0';
  }

  @override
  String get onboardingAccountImportSucceeded => '登入資訊匯入成功';

  @override
  String get onboardingErrorJsonTopLevelObject => 'JSON 最上層必須是物件';

  @override
  String onboardingConfirmSettingsImport(String source) {
    return '匯入 $source 設定？';
  }

  @override
  String get onboardingSettingsFields => '設定欄位';

  @override
  String get onboardingPlaybackFields => '播放欄位';

  @override
  String get onboardingCategory => '分類';

  @override
  String get onboardingExtraTopLevelFields => '額外的最上層欄位';

  @override
  String get onboardingConfirmAccountImport => '匯入本機帳號備份？';

  @override
  String get onboardingAccountCount => '帳號數量';

  @override
  String get onboardingContainsCookie => '包含 Cookie';

  @override
  String get onboardingContainsAccessKey => '包含 accessKey';

  @override
  String get onboardingContainsRefresh => '包含 refresh';

  @override
  String get onboardingWillOverwrite => '將覆蓋';

  @override
  String get onboardingWebDavAddress => '位址';

  @override
  String get onboardingWebDavAddressRequired => '請輸入 WebDAV 位址';

  @override
  String get onboardingWebDavUser => '使用者';

  @override
  String get onboardingWebDavPassword => '密碼';

  @override
  String get onboardingWebDavPath => '路徑';

  @override
  String get onboardingCategoryAppearance => '外觀';

  @override
  String get onboardingCategoryPlayback => '播放';

  @override
  String get onboardingCategoryWebDav => 'WebDAV';

  @override
  String get onboardingCategoryLayout => '版面配置';

  @override
  String get onboardingCategoryGeneral => '一般';

  @override
  String get onboardingErrorNoSettingsData => '找不到 setting 或 video 資料';

  @override
  String onboardingErrorValueMustBeObject(String name) {
    return '$name 必須是物件';
  }

  @override
  String onboardingMidListSummary(String mids, int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$mids 等共 $count 個',
      one: '$mids 等共 1 個',
      zero: '$mids 等共 0 個',
    );
    return '$_temp0';
  }

  @override
  String onboardingErrorAccountMustBeObject(String account) {
    return '帳號 $account 必須是物件';
  }

  @override
  String get onboardingErrorNoAccountData => '找不到帳號資料';
}
