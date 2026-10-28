Warning: truncated output (original token count: 89230)
Total output lines: 15058

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
  String get settingsEnableGifRecord => '启用 GIF 截取按钮';

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
  String get onboardingImportHelp => '查看导出方法';

  @override
  String get onboardingImportHelpTitle => '如何从 PiliPlus 导出文件';

  @override
  String get onboardingImportHelpIntro => '在 PiliPlus 中，按要迁移的内容打开对应入口：';

  @override
  String get onboardingImportHelpSettingsPath => '我的 > 设置 > 关于 > 导入/导出设置';

  @override
  String get onboardingImportHelpLoginPath => '我的 > 设置 > 关于 > 导入/导出登录信息';

  @override
  String get onboardingImportHelpExportHint =>
      '进入对应页面后，选择“导出文件至本地”。导出完成后返回 ExPiliPlus，选择生成的 JSON 文件。';

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

  @override
  String get settingsOpenOnboarding => '重新打开欢迎引导';

  @override
  String get settingsOpenOnboardingDescription => '再次查看语言、主题和数据迁移引导，不会清除现有设置';

  @override
  String get settingsEnablePermanentDynamicBlock => '启用永久动态屏蔽';

  @override
  String get settingsEnablePermanentDynamicBlockDescription =>
      '开启后，可将指定 UP 加入永久动态屏蔽名单';

  @override
  String get settingsDynamicBlockedUpList => '动态屏蔽 UP 名单';

  @override
  String settingsDynamicBlockedUpCount(int count) {
    return '$count 位 UP';
  }

  @override
  String settingsDefaultValue(String value) {
    return '默认值：$value';
  }

  @override
  String get commonDisabled => '禁用';

  @override
  String get commonUnavailable => '不可用';

  @override
  String get commonDeleted => '已删除';

  @override
  String get commonDelete => '删除';

  @override
  String get commonDeleting => '正在删除…';

  @override
  String get commonDeleteSucceeded => '删除成功';

  @override
  String commonDeleteFailed(String error) {
    return '删除失败：$error';
  }

  @override
  String commonLoadFailed(String error) {
    return '加载失败：$error';
  }

  @override
  String get commonReport => '举报';

  @override
  String get commonFormat => '格式';

  @override
  String get commonPin => '置顶';

  @override
  String get commonUnpin => '取消置顶';

  @override
  String get commonLike => '点赞';

  @override
  String get commonLiked => '已赞';

  @override
  String get commonDislike => '点踩';

  @override
  String get commonDisliked => '已踩';

  @override
  String get commonAddToFavorites => '收藏';

  @override
  String get commonRemoveFromFavorites => '取消收藏';

  @override
  String get commonShare => '分享';

  @override
  String get commonRepost => '转发';

  @override
  String get commonOther => '其他';

  @override
  String get commonBack => '返回';

  @override
  String get commonPause => '暂停';

  @override
  String get commonClose => '关闭';

  @override
  String get commonLoading => '加载中…';

  @override
  String get commonSavingMayTakeTime => '正在保存，可能需要一些时间';

  @override
  String get commonTapToReload => '点击重新加载';

  @override
  String get commonCopyLink => '复制链接';

  @override
  String get commonOpenInAnotherApp => '用其他应用打开';

  @override
  String get commonNoMore => '没有更多了';

  @override
  String get commonSend => '发送';

  @override
  String get commonSending => '发送中…';

  @override
  String get commonSent => '发送成功';

  @override
  String get commonImage => '图片';

  @override
  String get commonEdit => '编辑';

  @override
  String get commonPreview => '预览';

  @override
  String get commonRemove => '移除';

  @override
  String get commonSubmit => '提交';

  @override
  String get commonSubmitting => '正在提交…';

  @override
  String get commonSubmitSucceeded => '提交成功';

  @override
  String commonSubmitFailed(String error) {
    return '提交失败：$error';
  }

  @override
  String get commonSucceeded => '成功';

  @override
  String get commonUndo => '撤销';

  @override
  String get commonUnknown => '未知';

  @override
  String get commonDataUnavailable => '无法获取所需数据';

  @override
  String get commonFeedback => '反馈';

  @override
  String get commonNotice => '提示';

  @override
  String get commonJumpFailed => '跳转失败';

  @override
  String get commonOriginal => '原文';

  @override
  String get commonTranslate => '翻译';

  @override
  String get commonReply => '回复';

  @override
  String get commonVote => '投票';

  @override
  String get commonNote => '笔记';

  @override
  String get commonNotes => '笔记';

  @override
  String get commonClear => '清空';

  @override
  String get commonVideos => '视频';

  @override
  String get commonArticles => '专栏';

  @override
  String get commonLiveRooms => '直播间';

  @override
  String get commonUsers => '用户';

  @override
  String get commonAllTypes => '全部类型';

  @override
  String get commonViewDetails => '查看详情';

  @override
  String get commonDetails => '详情';

  @override
  String get commonView => '查看';

  @override
  String get commonViewAll => '查看全部';

  @override
  String get commonGoTo => '前往';

  @override
  String get commonColorPicker => '选择颜色';

  @override
  String get commonSmall => '小';

  @override
  String get commonStandard => '标准';

  @override
  String get commonWifi => 'Wi-Fi';

  @override
  String get commonMobileData => '移动数据';

  @override
  String get commonNewestPublished => '最新发布';

  @override
  String get commonMostViewed => '最多播放';

  @override
  String get downloadHighestQuality => '最高画质';

  @override
  String downloadCurrentNetwork(String network) {
    return '当前网络：$network';
  }

  @override
  String get downloadCacheAll => '缓存全部';

  @override
  String get downloadConfirmCacheAll => '确定缓存全部？';

  @override
  String get downloadViewCached => '查看缓存';

  @override
  String get accountPremium => '大会员';

  @override
  String get accountPremiumRequired => '需要大会员';

  @override
  String get accountSignInAgainRequired => '请退出账号后重新登录';

  @override
  String get memberQuietlyFollowing => '悄悄关注';

  @override
  String get memberFollowing => '已关注';

  @override
  String get memberMutualFollow => '互相关注';

  @override
  String get memberBlocked => '已拉黑';

  @override
  String get memberSpecialFollow => '特别关注';

  @override
  String get memberFollow => '关注';

  @override
  String memberFollowersAndVideos(String followers, String videos) {
    return '$followers 粉丝 · $videos 个视频';
  }

  @override
  String get memberEditProfile => '编辑资料';

  @override
  String get memberViewProfile => '查看主页';

  @override
  String get playerSuperResolutionEfficiency => '效率';

  @override
  String get playerSuperResolutionQuality => '画质';

  @override
  String get playerSuperResolution => '超分辨率';

  @override
  String get playerRepeatPauseAtEnd => '播完暂停';

  @override
  String get playerRepeatListOrder => '列表顺序播放';

  @override
  String get playerRepeatSingle => '单集循环';

  @override
  String get playerRepeatList => '列表循环';

  @override
  String get playerRepeatAutoplayRelated => '自动播放相关视频';

  @override
  String get playerFitStretch => '拉伸';

  @override
  String get playerFitAuto => '自动';

  @override
  String get playerFitCrop => '裁剪';

  @override
  String get playerFitWidth => '适应宽度';

  @override
  String get playerFitHeight => '适应高度';

  @override
  String get playerFitOriginal => '原始大小';

  @override
  String get playerFitScaleDown => '缩小适应';

  @override
  String get playerQuality8k => '8K 超高清';

  @override
  String get playerQualityDolbyVision => '杜比视界';

  @override
  String get playerQualityHdr => 'HDR 真彩';

  @override
  String get playerQuality4k => '4K 超高清';

  @override
  String get playerQuality1080p60 => '1080P 60 帧';

  @override
  String get playerQuality1080pHighBitrate => '1080P 高码率';

  @override
  String get playerQuality1080p => '1080P 高清';

  @override
  String get playerQuality720p60 => '720P 60 帧';

  @override
  String get playerQuality720p => '720P 准高清';

  @override
  String get playerQuality480p => '480P 标清';

  @override
  String get playerQuality360p => '360P 流畅';

  @override
  String get playerQuality240p => '240P 极速';

  @override
  String get playerCdnBaseUrl => '主线路';

  @override
  String get playerCdnBackupUrl => '备用线路';

  @override
  String playerCdnAlibaba(String name) {
    return '阿里云（$name）';
  }

  @override
  String playerCdnTencent(String name) {
    return '腾讯云（$name）';
  }

  @override
  String playerCdnTencentVod(String name) {
    return '腾讯 VOD（$name）';
  }

  @override
  String playerCdnHuaweiFusion(String name) {
    return '华为融合（$name）';
  }

  @override
  String playerCdnHuawei(String name) {
    return '华为云（$name）';
  }

  @override
  String playerCdnAkamaiInternational(String name) {
    return 'Akamai 国际（$name）';
  }

  @override
  String playerCdnAlibabaInternational(String name) {
    return '阿里云国际（$name）';
  }

  @override
  String playerCdnTencentInternational(String name) {
    return '腾讯云国际（$name）';
  }

  @override
  String playerCdnHuaweiInternational(String name) {
    return '华为云国际（$name）';
  }

  @override
  String playerCdnBilibiliInternational(String name) {
    return '哔哩哔哩国际（$name）';
  }

  @override
  String get playerCdnMayNotWork => '该线路可能不可用';

  @override
  String get playerCdnSpeedTestFailed => '测速失败';

  @override
  String get playerCdnSettings => 'CDN 设置';

  @override
  String playerCurrentCdn(String cdn) {
    return '当前 CDN：$cdn';
  }

  @override
  String playerCdnSetReloading(String cdn) {
    return '已切换到 $cdn，正在重新加载';
  }

  @override
  String get playerMoreSettings => '更多播放设置';

  @override
  String get playerPlay => '播放';

  @override
  String get playerSleepTimer => '定时停止播放';

  @override
  String get playerQuickActions => '快捷操作';

  @override
  String get playerQuickActionsEdit => '编辑';

  @override
  String get playerQuickActionsDescription => '选择并排序显示在顶部的操作。';

  @override
  String get playerQuickActionsUnavailable => '当前不可用';

  @override
  String get playerQuickActionsRestoreDefault => '恢复默认';

  @override
  String get playerPlaybackUrl => '播放地址';

  @override
  String get playerReloadVideo => '重新加载视频';

  @override
  String get playerVolume => '音量';

  @override
  String get playerFlipHorizontal => '水平翻转';

  @override
  String get playerFlipVertical => '垂直翻转';

  @override
  String get playerAudioOnly => '仅播放音频';

  @override
  String get playerBackgroundPlayback => '后台播放';

  @override
  String get playerSelectVideoQuality => '选择视频画质';

  @override
  String playerCurrentVideoQuality(String quality) {
    return '当前画质：$quality';
  }

  @override
  String get playerSelectAudioQuality => '选择音质';

  @override
  String playerCurrentAudioQuality(String quality) {
    return '当前音质：$quality';
  }

  @override
  String get playerCodec => '编码格式';

  @override
  String playerCurrentCodec(String codec) {
    return '当前编码：$codec';
  }

  @override
  String get playerPlaybackOrder => '播放顺序';

  @override
  String get playerDanmakuList => '弹幕列表';

  @override
  String get playerDanmakuSettings => '弹幕设置';

  @override
  String get playerSubtitleSettings => '字幕设置';

  @override
  String get playerLoadSubtitles => '加载字幕';

  @override
  String get playerSaveSubtitles => '保存字幕';

  @override
  String get playerPlaybackInfo => '播放信息';

  @override
  String get playerInfoResolution => '分辨率';

  @override
  String get playerInfoVideoParameters => '视频参数';

  @override
  String get playerInfoAudioParameters => '音频参数';

  @override
  String get playerInfoMedia => '媒体';

  @override
  String get playerInfoAudioTrack => '音轨';

  @override
  String get playerInfoVideoTrack => '视频轨';

  @override
  String get playerInfoPlaybackRate => '播放速度';

  @override
  String get playerInfoHardwareDecoder => '硬件解码';

  @override
  String get playerVideoQualityNotSupported => '当前视频不支持选择画质';

  @override
  String get playerPremiumQualityHint => '此画质需要大会员或登录后使用';

  @override
  String playerVideoQualityChanged(String quality) {
    return '画质已切换为 $quality';
  }

  @override
  String playerAudioQualityChanged(String quality) {
    return '音质已切换为 $quality';
  }

  @override
  String get playerCodecNotSupported => '当前视频不支持切换编码';

  @override
  String get playerSelectCodec => '选择编码格式';

  @override
  String playerCodecChanged(String codec) {
    return '编码已切换为 $codec';
  }

  @override
  String playerFontSize(String value) {
    return '字号：$value';
  }

  @override
  String playerFullscreenFontSize(String value) {
    return '全屏字号：$value';
  }

  @override
  String playerFontWeightMayVary(String value) {
    return '字重：$value（效果因字体而异）';
  }

  @override
  String playerStrokeWidth(String value) {
    return '描边宽度：$value';
  }

  @override
  String playerHorizontalMargin(String value) {
    return '水平边距：$value';
  }

  @override
  String playerBottomMargin(String value) {
    return '底部边距：$value';
  }

  @override
  String playerBackgroundOpacity(String value) {
    return '背景不透明度：$value';
  }

  @override
  String playerOpacity(String value) {
    return '不透明度：$value';
  }

  @override
  String playerWatchingNow(String count) {
    return '$count 人正在看';
  }

  @override
  String get playerCast => '投屏';

  @override
  String get playerCastingNotSupported => '不支持投屏';

  @override
  String get playerSubmitSegment => '提交片段';

  @override
  String get playerSegmentInfo => '分段信息';

  @override
  String get playerTurnOffDanmaku => '关闭弹幕';

  @override
  String get playerTurnOnDanmaku => '打开弹幕';

  @override
  String get playerPictureInPicture => '画中画';

  @override
  String get playerDanmakuScrolling => '滚动';

  @override
  String get playerDanmakuTop => '顶部';

  @override
  String get playerDanmakuBottom => '底部';

  @override
  String get playerDanmakuColored => '彩色';

  @override
  String get playerDanmakuAdvanced => '高级';

  @override
  String playerDanmakuCloudFilterLevel(int level) {
    return '云屏蔽等级：$level';
  }

  @override
  String playerDanmakuFilterManagement(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '屏蔽管理（$count）',
      zero: '屏蔽管理',
    );
    return '$_temp0';
  }

  @override
  String get playerDanmakuFilterByType => '按类型屏蔽';

  @override
  String get playerDanmakuMassiveMode => '海量模式';

  @override
  String get playerDanmakuConvertStaticToScrolling => '固定弹幕转滚动弹幕';

  @override
  String get playerDanmakuFixedSpeed => '固定速度';

  @override
  String playerDanmakuDisplayArea(String value) {
    return '显示区域：$value';
  }

  @override
  String playerScrollingDanmakuDuration(String value) {
    return '滚动弹幕时长：$value 秒';
  }

  @override
  String playerStaticDanmakuDuration(String value) {
    return '固定弹幕时长：$value 秒';
  }

  @override
  String playerDanmakuLineHeight(String value) {
    return '弹幕行高：$value';
  }

  @override
  String get playerPreviousEpisode => '上一集';

  @override
  String get playerNextEpisode => '下一集';

  @override
  String get playerAlreadyFirstEpisode => '已经是第一集了';

  @override
  String get playerAlreadyLastEpisode => '已经是最后一集了';

  @override
  String get playerHighlightHeatmap => '高能进度条';

  @override
  String get playerChapterInfo => '章节信息';

  @override
  String get playerEpisodes => '选集';

  @override
  String get playerAspectRatio => '画面比例';

  @override
  String get playerTranslation => '翻译';

  @override
  String get playerTurnOffTranslation => '关闭翻译';

  @override
  String get playerSubtitles => '字幕';

  @override
  String get playerTurnOffSubtitles => '关闭字幕';

  @override
  String get playerPlaybackSpeed => '播放速度';

  @override
  String playerSpeedSemantic(String speed) {
    return '$speed 倍速';
  }

  @override
  String get playerVideoQuality => '视频画质';

  @override
  String get playerExitFullScreen => '退出全屏';

  @override
  String get playerFullScreen => '全屏';

  @override
  String get playerReleaseToCancelSeeking => '松开以取消定位';

  @override
  String playerSpeedActive(String speed) {
    return '$speed 倍速播放';
  }

  @override
  String get playerResetView => '重置画面';

  @override
  String get playerUnlock => '解锁';

  @override
  String get playerLock => '锁定';

  @override
  String get playerScreenshot => '截图';

  @override
  String get playerMuted => '已静音';

  @override
  String get playerUnmuted => '已取消静音';

  @override
  String get playerGifRecord => '截取 GIF';

  @override
  String get playerGifRecordLength => '片段长度';

  @override
  String get playerGifResolution => '输出分辨率';

  @override
  String get playerGifFrameRate => '帧率';

  @override
  String get playerGifExport => '导出 GIF';

  @override
  String get playerGifSourceUnavailable => '暂无可用的 GIF 视频源';

  @override
  String get playerAnimatedScreenshot => '动态截图';

  @override
  String get playerWebpPreset => 'WebP 预设';

  @override
  String get playerWebpCpuWarning => '生成动态截图会占用较多处理器资源';

  @override
  String get playerTranscodeFailedOrCanceled => '转码失败或已取消';

  @override
  String get playerWebpPresetNone => '无';

  @override
  String get playerWebpPresetPicture => '图片';

  @override
  String get playerWebpPresetPhoto => '照片';

  @override
  String get playerWebpPresetDrawing => '绘画';

  @override
  String get playerWebpPresetIcon => '图标';

  @override
  String get playerWebpPresetText => '文字';

  @override
  String get playerWebpPresetNoneDescription => '不使用预设';

  @override
  String get playerWebpPresetDefaultDescription => '平衡画质与文件大小';

  @override
  String get playerWebpPresetPictureDescription => '适合一般图片';

  @override
  String get playerWebpPresetPhotoDescription => '适合照片和复杂画面';

  @override
  String get playerWebpPresetDrawingDescription => '适合绘画和插画';

  @override
  String get playerWebpPresetIconDescription => '适合图标和小尺寸图形';

  @override
  String get playerWebpPresetTextDescription => '适合包含文字的画面';

  @override
  String get playerDanmakuFontSize => '弹幕字号';

  @override
  String get playerDanmakuStyle => '弹幕样式';

  @override
  String get playerDanmakuColor => '弹幕颜色';

  @override
  String get playerDanmakuInputHint => '输入弹幕内容';

  @override
  String get playerNowPlaying => '正在播放';

  @override
  String playerNowPlayingTitle(String title) {
    return '正在播放：$title';
  }

  @override
  String get playerPlayInOrder => '顺序播放';

  @override
  String get playerPlayInReverse => '倒序播放';

  @override
  String playerSkipSegment(String segment) {
    return '跳过：$segment';
  }

  @override
  String get playerUploaderDisabledDanmaku => 'UP 主已关闭弹幕';

  @override
  String playerRewindSeconds(int seconds) {
    return '快退 $seconds 秒';
  }

  @override
  String playerForwardSeconds(int seconds) {
    return '快进 $seconds 秒';
  }

  @override
  String get playerVideoOpenFailedRetrying => '视频链接打开失败，正在重试';

  @override
  String playerDecoderLoadFailed(String error) {
    return '无法加载解码器：$error，可能会切换至软解';
  }

  @override
  String get playerTakingScreenshot => '正在截图';

  @override
  String get playerTapPreviewToSaveScreenshot => '点击预览图保存截图';

  @override
  String get playerScreenshotFailed => '截图失败';

  @override
  String get replyPostComment => '发表评论';

  @override
  String get replyNoCommentsYet => '还没有评论';

  @override
  String get replyInputHint => '友善发言的人运气不会太差';

  @override
  String get replyImagesNotSupported => '当前评论区不支持图片';

  @override
  String get replyAlsoPostToFeed => '同时转发到动态';

  @override
  String get replyInsertContent => '插入内容';

  @override
  String get replyVideoProgress => '视频进度';

  @override
  String replyMaxImages(int limit) {
    String _temp0 = intl.Intl.pluralLogic(
      limit,
      locale: localeName,
      other: '最多可添加 $limit 张图片',
    );
    return '$_temp0';
  }

  @override
  String get replyVideoScreenshot => '视频截图';

  @override
  String get replyVoteRedSide => '红方';

  @override
  String get replyVoteBlueSide => '蓝方';

  @override
  String replyVoteParticipants(String count) {
    return '$count 人参与';
  }

  @override
  String get replyTranslationEmpty => '翻译结果为空';

  @override
  String replyTranslationFailed(String error) {
    return '翻译失败：$error';
  }

  @override
  String get replyViewConversation => '查看对话';

  @override
  String get replyJumpToReply => '跳转回复';

  @override
  String get replyUploaderAndOthers => 'UP 主等人';

  @override
  String replyCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '共 $count 条回复',
      zero: '暂无回复',
    );
    return '$_temp0';
  }

  @override
  String replyVoteTitle(String title) {
    return '投票：$title';
  }

  @override
  String replyJumpTo(String time) {
    return '跳转至：$time';
  }

  @override
  String replyJumpFailed(String error) {
    return '跳转失败：$error';
  }

  @override
  String get replyDeleteComment => '删除评论';

  @override
  String get replyConfirmDeleteComment => '确定删除这条评论吗？';

  @override
  String get replyCopyAll => '复制全部';

  @override
  String get replyCopySelection => '自由复制';

  @override
  String get replySaveComment => '保存评论';

  @override
  String get replyCheckComment => '检查评论';

  @override
  String get replyDetails => '评论详情';

  @override
  String get replyConversation => '对话列表';

  @override
  String replyRelatedCount(String count) {
    return '相关回复共 $count 条';
  }

  @override
  String get replyMayHaveBeenDeleted => '评论可能已被删除';

  @override
  String get replyDislikeSucceeded => '点踩成功';

  @override
  String get replyRemoveDislikeSucceeded => '已取消踩';

  @override
  String get replyLikeSucceeded => '点赞成功';

  @override
  String get replyUnlikeSucceeded => '已取消赞';

  @override
  String get reportChooseReason => '请选择举报理由：';

  @override
  String get reportDetailsHint => '为帮助审核人员更快处理，请补充问题类型、出现位置等详细信息';

  @override
  String get reportReasonRequired => '理由不能为空';

  @override
  String get reportBlockUser => '拉黑该用户';

  @override
  String get reportSucceeded => '举报成功';

  @override
  String get reportGroupIllegal => '违反法律法规';

  @override
  String get reportGroupMisinformation => '谣言类不实信息';

  @override
  String get reportGroupPersonalRights => '侵犯个人权益';

  @override
  String get reportGroupCommunity => '有害社区环境';

  @override
  String get reportIllegal => '违法违规';

  @override
  String get reportPornography => '色情';

  @override
  String get reportVulgar => '低俗';

  @override
  String get reportGamblingOrScam => '赌博诈骗';

  @override
  String get reportIllegalExternalLink => '违法信息外链';

  @override
  String get reportPoliticalRumor => '涉政谣言';

  @override
  String get reportMisinformation => '虚假不实信息';

  @override
  String get reportSocialEventRumor => '涉社会事件谣言';

  @override
  String get reportPersonalAttack => '人身攻击';

  @override
  String get reportPrivacyViolation => '侵犯隐私';

  @override
  String get reportSpam => '垃圾广告';

  @override
  String get reportProvocation => '引战';

  @override
  String get reportSpoiler => '剧透';

  @override
  String get reportFlooding => '恶意刷屏';

  @override
  String get reportIrrelevant => '与视频无关';

  @override
  String get reportIllegalLottery => '违规抽奖';

  @override
  String get reportHarmfulToMinors => '青少年不良信息';

  @override
  String get reportIllegalOrHarmful => '违法有害信息';

  @override
  String get reportPornographicOrVulgar => '色情低俗';

  @override
  String get reportAbuseOrProvocation => '辱骂引战';

  @override
  String get reportPoliticallySensitive => '政治敏感';

  @override
  String get reportAdHarassment => '广告骚扰';

  @override
  String get reportScam => '诈骗';

  @override
  String get sponsorBlockActionSkip => '跳过';

  @override
  String get sponsorBlockActionMute => '静音';

  @override
  String get sponsorBlockActionFullVideo => '整个视频';

  @override
  String get sponsorBlockActionHighlight => '精彩时刻';

  @override
  String get sponsorBlockAlwaysSkip => '总是跳过';

  @override
  String get sponsorBlockSkipOnce => '跳过一次';

  @override
  String get sponsorBlockManualSkip => '手动跳过';

  @override
  String get sponsorBlockShowOnly => '仅显示';

  @override
  String get sponsorBlockCategorySponsor => '赞助／恰饭';

  @override
  String get sponsorBlockCategorySponsorShort => '赞助';

  @override
  String get sponsorBlockCategorySelfPromotion => '无偿／自我推广';

  @override
  String get sponsorBlockCategorySelfPromotionShort => '推广';

  @override
  String get sponsorBlockCategoryExclusiveAccess => '独家访问／抢先体验';

  @override
  String get sponsorBlockCategoryExclusiveAccessShort => '品牌合作';

  @override
  String get sponsorBlockCategoryInteraction => '三连／互动提醒';

  @override
  String get sponsorBlockCategoryInteractionShort => '三连提醒';

  @override
  String get sponsorBlockCategoryHighlight => '精彩时刻／重点';

  @override
  String get sponsorBlockCategoryHighlightShort => '精彩时刻';

  @override
  String get sponsorBlockCategoryIntro => '过场／开场动画';

  @override
  String get sponsorBlockCategoryIntroShort => '开场动画';

  @override
  String get sponsorBlockCategoryOutro => '鸣谢／结束画面';

  @override
  String get sponsorBlockCategoryOutroShort => '片尾';

  @override
  String get sponsorBlockCategoryPreview => '回顾／概要';

  @override
  String get sponsorBlockCategoryPreviewShort => '预览';

  @override
  String get sponsorBlockCategoryPadding => '填充内容／前黑／后黑';

  @override
  String get sponsorBlockCategoryPaddingShort => '填充内容';

  @override
  String get sponsorBlockCategoryFiller => '离题闲聊／玩笑';

  @override
  String get sponsorBlockCategoryFillerShort => '离题';

  @override
  String get sponsorBlockCategoryMusicOfftopic => '音乐：非音乐部分';

  @override
  String get sponsorBlockCategoryMusicOfftopicShort => '非音乐';

  @override
  String sponsorBlockSkipped(String segment) {
    return '已跳过$segment片段';
  }

  @override
  String sponsorBlockJumpedTo(String segment) {
    return '已跳至$segment';
  }

  @override
  String sponsorBlockSkipFailed(String segment) {
    return '$segment片段跳过失败';
  }

  @override
  String get sponsorBlockUpvote => '赞成票';

  @override
  String get sponsorBlockDownvote => '反对票';

  @override
  String get sponsorBlockChangeCategory => '更改类别';

  @override
  String get sponsorBlockVoteSucceeded => '投票成功';

  @override
  String sponsorBlockVoteFailed(String error) {
    return '投票失败：$error';
  }

  @override
  String get sponsorBlockCategoryChangeSucceeded => '类别更改成功';

  @override
  String sponsorBlockCategoryChangeFailed(String error) {
    return '类别更改失败：$error';
  }

  @override
  String sponsorBlockSegmentRange(String start, String end) {
    return '$start 至 $end';
  }

  @override
  String get sponsorBlockJumpToSegment => '跳至此片段';

  @override
  String get sponsorBlockSkipSegment => '跳过此片段';

  @override
  String get videoPlayNow => '立即播放';

  @override
  String get videoReplay => '重新播放';

  @override
  String get videoResumePlayback => '继续播放';

  @override
  String get videoBackToHome => '返回首页';

  @override
  String get videoRelatedVideos => '相关视频';

  @override
  String get videoViewNotes => '查看笔记';

  @override
  String get videoDownload => '下载';

  @override
  String get videoSaveCover => '保存封面';

  @override
  String get videoListenToAudio => '听视频';

  @override
  String get videoOfflineVideo => '离线视频';

  @override
  String get videoDescription => '简介';

  @override
  String get videoComments => '评论';

  @override
  String get videoPlaylist => '播放列表';

  @override
  String videoCommentsCount(String count) {
    return '评论 $count';
  }

  @override
  String get videoSendDanmaku => '发送弹幕';

  @override
  String get videoSeriesReverseNotSupported => '当前系列不支持倒序播放';

  @override
  String get videoLikeSucceeded => '点赞成功';

  @override
  String get videoUnlikeSucceeded => '已取消点赞';

  @override
  String get videoAddToWatchLater => '添加到稍后再看';

  @override
  String get videoCoin => '投币';

  @override
  String get videoSupporterOnly => '充电专属';

  @override
  String get videoInteractive => '互动视频';

  @override
  String get videoSponsorBlockSourceSync => '同步 SponsorBlock 视频来源';

  @override
  String videoSponsorBlockAlreadyLinked(String videoId) {
    return '已关联 YouTube 视频 $videoId';
  }

  @override
  String videoSponsorBlockConfirmLink(String videoId) {
    return '确认将本视频关联到 YouTube 视频 $videoId？';
  }

  @override
  String get videoSponsorBlockLinkSucceeded => '来源关联成功';

  @override
  String videoSponsorBlockLinkFailed(String error) {
    return '来源关联失败：$error';
  }

  @override
  String get videoAiSummaryNotSupported => '当前视频暂不支持 AI 总结';

  @override
  String get videoAiSummary => 'AI 总结';

  @override
  String videoBgmPrefix(String content) {
    return 'BGM：$content';
  }

  @override
  String get videoGreatCoined => '已完成 Great Coined';

  @override
  String get videoCoinFailed => '投币失败';

  @override
  String get videoGreatCoinedSucceeded => 'Great Coined 成功';

  @override
  String get videoDislikeSucceeded => '点踩成功';

  @override
  String get videoRemoveDislikeSucceeded => '已取消踩';

  @override
  String get videoShareAtCurrentTime => '从当前时间开始分享';

  @override
  String get videoShareVideo => '分享视频';

  @override
  String videoShareText(String title, String uploader, String url) {
    return '$title\nUP 主：$uploader\n$url';
  }

  @override
  String get videoShareToFeed => '分享到动态';

  @override
  String get videoShareToMessages => '分享到消息';

  @override
  String get videoNoRelatedVideosStopAutoplay => '没有更多相关视频，已停止自动播放';

  @override
  String get videoLoadingAiSummary => '正在加载 AI 总结…';

  @override
  String get videoAiProcessing => 'AI 总结正在生成，请稍后再试';

  @override
  String get videoFollowAnime => '追番';

  @override
  String get videoFollowSeries => '追剧';

  @override
  String videoRating(String score) {
    return '评分 $score';
  }

  @override
  String videoAlreadyFollowing(String type) {
    return '已$type';
  }

  @override
  String videoDescriptionWithContent(String description) {
    return '简介：$description';
  }

  @override
  String get videoRemovedFromFavorites => '已取消收藏';

  @override
  String get videoAddedToFavorites => '已收藏';

  @override
  String videoMarkAs(String status) {
    return '标记为$status';
  }

  @override
  String get videoStatusWatched => '看过';

  @override
  String get videoStatusWatching => '在看';

  @override
  String get videoStatusWantToWatch => '想看';

  @override
  String videoCancelFollowingType(String type) {
    return '取消$type';
  }

  @override
  String videoSegmentStart(String value) {
    return '开始：$value';
  }

  @override
  String videoSegmentEnd(String value) {
    return '结束：$value';
  }

  @override
  String get videoSegmentSetCurrent => '设为当前';

  @override
  String get videoSegmentVideoStart => '视频开头';

  @override
  String get videoSegmentVideoEnd => '视频结尾';

  @override
  String get videoSegmentAdd => '添加片段';

  @override
  String get videoSegmentConfirmBeforeSubmit => '确认无误后再提交';

  @override
  String get videoSegmentConfirmSubmit => '确定提交';

  @override
  String get videoSegmentCategory => '分类';

  @override
  String get videoSegmentAction => '行为类别';

  @override
  String get videoSegmentProgressBar => '分段进度条';

  @override
  String videoResumeAtPart(int part) {
    return '上次看到第 ${part}P，点击跳转';
  }

  @override
  String videoJumpedToPart(int part) {
    return '已跳至第 ${part}P';
  }

  @override
  String get videoExclusiveTrial => '该视频为专属视频，仅提供试看';

  @override
  String get videoResourceUnavailable => '视频资源不存在';

  @override
  String get videoCoinLimitReached => '已达到投币上限';

  @override
  String get videoNotEnoughCoins => '硬币不足';

  @override
  String videoCoinBalance(String balance) {
    return '硬币余额：$balance';
  }

  @override
  String get videoAlreadyCoinedOne => '已投 1 枚硬币';

  @override
  String videoCoinBalanceAndCoined(String balance) {
    return '硬币余额：$balance，已投 1 枚硬币';
  }

  @override
  String get videoCoinAndLike => '同时点赞';

  @override
  String get videoEpisodes => '视频选集';

  @override
  String get videoNoEpisodes => '暂无可用剧集';

  @override
  String videoEpisodeCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '共 $count 集',
    );
    return '$_temp0';
  }

  @override
  String videoCollection(String title) {
    return '合集：$title';
  }

  @override
  String get videoCollectionLabel => '合集';

  @override
  String videoEpisodePosition(int current, int total) {
    return '第 $current 集，共 $total 集';
  }

  @override
  String videoOngoingUpdatedTo(String episode) {
    return '连载中，更新至$episode';
  }

  @override
  String videoEpisodeNumber(int number) {
    return '第 $number 话';
  }

  @override
  String get videoReviews => '点评';

  @override
  String get videoSummary => '简介';

  @override
  String get videoCastAndCrew => '演职人员';

  @override
  String videoCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '共 $count 个视频',
    );
    return '$_temp0';
  }

  @override
  String get videoTypePlaybackNotSupported => '不支持播放该类型视频';

  @override
  String get videoConfirmRemove => '确定移除该视频？';

  @override
  String videoNotesCount(int count) {
    return '笔记（$count）';
  }

  @override
  String get videoStartTakingNotes => '开始记笔记';

  @override
  String videoVisitUploader(String name) {
    return '访问：$name';
  }

  @override
  String get videoNotInterested => '不感兴趣';

  @override
  String get videoDoNotWantToSee => '我不想看';

  @override
  String get videoWebFineSelectionUnsupported => 'Web 端暂不支持精细选择';

  @override
  String videoBlockUploader(String name) {
    return '拉黑：$name';
  }

  @override
  String videoConfirmBlockUploader(String name, String id) {
    return '确定拉黑 $name（$id）？\n\n被拉黑的 UP 主可在隐私设置的黑名单管理中解除。';
  }

  @override
  String get timeJustNow => '刚刚';

  @override
  String timeMinutesAgo(int count) {
    return '$count 分钟前';
  }

  @override
  String timeHoursAgo(int count) {
    return '$count 小时前';
  }

  @override
  String timeYesterdayAt(String time) {
    return '昨天 $time';
  }

  @override
  String timeDaysAgo(int count) {
    return '$count 天前';
  }

  @override
  String durationYears(int count) {
    return '$count年';
  }

  @override
  String durationMonths(int count) {
    return '$count个月';
  }

  @override
  String durationDays(int count) {
    return '$count天';
  }

  @override
  String durationHours(int count) {
    return '$count小时';
  }

  @override
  String durationMinutes(int count) {
    return '$count分钟';
  }

  @override
  String timeTodayAt(String time) {
    return '今天 $time';
  }

  @override
  String get weekdayMondayShort => '一';

  @override
  String get weekdayTuesdayShort => '二';

  @override
  String get weekdayWednesdayShort => '三';

  @override
  String get weekdayThursdayShort => '四';

  @override
  String get weekdayFridayShort => '五';

  @override
  String get weekdaySaturdayShort => '六';

  @override
  String get weekdaySundayShort => '日';

  @override
  String get homePgcSchedule => '追番时间表';

  @override
  String get homeToday => '今天';

  @override
  String homeWeekday(String weekday) {
    return '周$weekday';
  }

  @override
  String get homeRecommendations => '推荐';

  @override
  String get homeMediaIndex => '索引';

  @override
  String get homeAllMedia => '全部';

  @override
  String get homeMovies => '电影';

  @override
  String get homeTvShows => '电视剧';

  @override
  String get homeDocumentaries => '纪录片';

  @override
  String get homeVarietyShows => '综艺';

  @override
  String homeRecentAnime(String count) {
    return '最近追番$count';
  }

  @override
  String homeRecentSeries(String count) {
    return '最近追剧$count';
  }

  @override
  String get homeNoAnime => '还没有追番';

  @override
  String get homeNoSeries => '还没有追剧';

  @override
  String get feedAll => '全部';

  @override
  String get feedUploads => '投稿';

  @override
  String get feedAnime => '番剧';

  @override
  String get feedArticles => '专栏';

  @override
  String get feedUploader => 'UP';

  @override
  String get feedCreatePost => '发布动态';

  @override
  String get feedAllUpdates => '全部动态';

  @override
  String get feedMe => '我';

  @override
  String get feedLiveEnded => '直播结束';

  @override
  String feedVoteWithTitle(String title) {
    return '投票：$title';
  }

  @override
  String feedPlayCount(String count) {
    return '$count播放';
  }

  @override
  String feedDanmakuCount(String count) {
    return '$count弹幕';
  }

  @override
  String get feedExpired => '已失效';

  @override
  String feedUnsupportedType(String id, String type) {
    return '暂未支持的类型：\n$id\n$type';
  }

  @override
  String get followMyFollowing => '我的关注';

  @override
  String followUserFollowing(String name) {
    return '$name的关注';
  }

  @override
  String get followNewGroup => '新建分组';

  @override
  String get followSortGroups => '分组排序';

  @override
  String get followBlockedUsers => '黑名单管理';

  @override
  String get followShared => '我们的共同关注';

  @override
  String get followAll => '全部关注';

  @override
  String get followMostRecent => '最近关注';

  @override
  String get followMostVisited => '最常访问';

  @override
  String get followEditGroupName => '编辑分组名称';

  @override
  String get followRenameGroup => '修改名称';

  @override
  String get followDeleteGroup => '删除分组';

  @override
  String get followDeleteGroupDescription => '删除后，该分组下的用户依旧保留。';

  @override
  String get followUpdateSucceeded => '修改成功';

  @override
  String get followDeleteSucceeded => '删除成功';

  @override
  String get feedSupporterOnly => '充电专属';

  @override
  String get feedPollOptions => '投票选项';

  @override
  String get feedPollEnded => '已结束';

  @override
  String get feedPollCompleted => '已完成';

  @override
  String get feedPoll => '投票';

  @override
  String get feedFollowedPeopleVotes => '关注的人的投票';

  @override
  String get feedVotedFor => '投给了';

  @override
  String feedPollEndsAt(String time) {
    return '至 $time';
  }

  @override
  String feedParticipantCount(String count) {
    return '$count人参与';
  }

  @override
  String get feedShowPercentage => '显示比例';

  @override
  String get feedAnonymous => '匿名';

  @override
  String get feedMoreActions => '更多';

  @override
  String get feedWatchLater => '稍后再看';

  @override
  String get feedSavePost => '保存动态';

  @override
  String get feedSharePost => '分享动态';

  @override
  String get feedShareToMessages => '分享至消息';

  @override
  String feedTemporarilyBlock(String name) {
    return '临时屏蔽 $name 的动态';
  }

  @override
  String feedTemporarilyBlocked(String name, String id) {
    return '已临时屏蔽 $name（$id）的动态，重启后恢复';
  }

  @override
  String feedPermanentlyBlockAuthorPosts(String name) {
    return '永久屏蔽 $name 的动态';
  }

  @override
  String feedAuthorPostsPermanentlyBlocked(String name, String id) {
    return '已永久屏蔽 $name（$id）的动态';
  }

  @override
  String feedUnblockAuthorPosts(String name) {
    return '取消屏蔽 $name 的动态';
  }

  @override
  String feedAuthorPostsUnblocked(String name) {
    return '已取消屏蔽 $name 的动态';
  }

  @override
  String dynamicBlockedUpListTitle(int count) {
    return '动态屏蔽 UP 名单（$count）';
  }

  @override
  String get dynamicBlockedUpListEmpty => '名单中暂无 UP';

  @override
  String dynamicBlockedUpUnknownName(String id) {
    return 'UP $id';
  }

  @override
  String dynamicBlockedUpUid(String id) {
    return 'UID：$id';
  }

  @override
  String dynamicBlockedUpRemoveConfirm(String name) {
    return '确定将 $name 移出动态屏蔽名单？';
  }

  @override
  String get dynamicBlockedUpRemoved => '已移出动态屏蔽名单';

  @override
  String get feedCheckPost => '检查动态';

  @override
  String get feedPinPost => '置顶';

  @override
  String get feedUnpinPost => '取消置顶';

  @override
  String get feedEnableFeaturedComments => '开启评论精选';

  @override
  String get feedDisableFeaturedComments => '停止评论精选';

  @override
  String get feedDisableComments => '关闭评论';

  @override
  String get feedRestoreComments => '恢复评论';

  @override
  String get feedInteractionSettings => '互动设置';

  @override
  String get feedVisibleToEveryone => '所有用户可见';

  @override
  String get feedVisibleOnlyToMe => '仅自己可见';

  @override
  String get feedVisibility => '可见范围';

  @override
  String get feedEditPost => '编辑动态';

  @override
  String get feedConfirmDeletePost => '确定删除该动态？';

  @override
  String get feedExpand => '展开';

  @override
  String get feedPriceFrom => '起';

  @override
  String get feedJoin => '参与';

  @override
  String get feedComment => '评论';

  @override
  String get feedWebLink => '网页链接';

  @override
  String get followGroupSortTitle => '关注分组排序';

  @override
  String get followSortCompleted => '排序完成';

  @override
  String followAlsoFollowed(int count, String name) {
    return '我关注的 $count 人也关注了 $name';
  }

  @override
  String get followUnknownPerson => 'TA';

  @override
  String get followActionFollow => '关注';

  @override
  String get followActionFo…59230 tokens truncated…override
  String statisticsRemaining(String duration) {
    return '還剩 $duration';
  }

  @override
  String get statisticsDataSourceNotice =>
      '資料基於 bilibili 目前最多可查詢的最近 1200 筆跨平台觀看記錄。暫停、清除或未記錄的歷史不會納入，記錄時間與剩餘時長也不代表實際觀看時長。';

  @override
  String get statisticsTypeVideo => '影片';

  @override
  String get statisticsTypePgc => '番劇與影視';

  @override
  String get statisticsTypeLive => '直播';

  @override
  String get statisticsTypeArticle => '文章';

  @override
  String get statisticsTypeCourse => '課程';

  @override
  String get statisticsTypeOther => '其他';

  @override
  String get statisticsUncategorized => '未分類';

  @override
  String get downloadOfflineTitle => '離線快取';

  @override
  String downloadDownloadingCount(Object count) {
    return '正在快取（$count）';
  }

  @override
  String get downloadDownloadedVideos => '已快取影片';

  @override
  String downloadVideoCount(Object count) {
    return '$count 個影片';
  }

  @override
  String get downloadCourse => '課程';

  @override
  String get downloadAnime => '番劇';

  @override
  String get downloadMovie => '電影';

  @override
  String get downloadDocumentary => '紀錄片';

  @override
  String get downloadChineseAnimation => '國創';

  @override
  String get downloadTvSeries => '電視劇';

  @override
  String get downloadVarietyShow => '綜藝';

  @override
  String get downloadConfirmDelete => '確定刪除？';

  @override
  String get downloadUpdateDanmaku => '更新彈幕';

  @override
  String get messagesTitle => '訊息';

  @override
  String get messagesNewFollowers => '新增粉絲';

  @override
  String get messagesRepliesToMe => '回覆我的';

  @override
  String get messagesMentions => '@我';

  @override
  String get messagesReceivedLikes => '收到的讚';

  @override
  String get messagesSystemNotifications => '系統通知';

  @override
  String get messagesMarkedAsRead => '已標為已讀';

  @override
  String get messagesMarkAsRead => '標為已讀';

  @override
  String get messagesEnableDoNotDisturb => '開啟勿擾';

  @override
  String get messagesDisableDoNotDisturb => '關閉勿擾';

  @override
  String get messagesDeleteConversationConfirm => '確定刪除該對話？';

  @override
  String get contactsTitle => '通訊錄';

  @override
  String get loginDevicesTitle => '登入裝置';

  @override
  String get loginDevicesCurrentDevice => '（本機）';

  @override
  String get memberMyFeed => '我的動態';

  @override
  String get memberSpaceSettings => '空間設定';

  @override
  String get messagesLikeDetails => '按讚詳情';

  @override
  String get messagesMentionsMe => '@我的';

  @override
  String get messagesDeleteNotificationConfirm => '確定刪除該通知？';

  @override
  String messagesMentionedIn(Object business) {
    return ' 在$business中提及了我';
  }

  @override
  String get messagesAndOthers => ' 等人';

  @override
  String messagesCommentsOnMyItem(Object business, Object count) {
    return ' 對我的$business發佈了$count則留言';
  }

  @override
  String get messagesLatest => '最新';

  @override
  String get messagesTotal => '累計';

  @override
  String get messagesDeleteLikeNoticeConfirm => '刪除該通知後，內容有新按讚時會再次出現在列表，是否繼續？';

  @override
  String get messagesStopNotifications => '不再通知';

  @override
  String get messagesStopNotificationsConfirm => '將不再通知這則內容的按讚，但仍可在列表中查看，是否繼續？';

  @override
  String get messagesReceiveNotifications => '接收通知';

  @override
  String messagesAndPeople(Object count) {
    return ' 等$count人';
  }

  @override
  String messagesLikedMyItem(Object business) {
    return ' 按讚了我的$business';
  }

  @override
  String get messagesViewFeed => '查看動態';

  @override
  String get messagesWebLink => '網頁連結';

  @override
  String get accountSwitchAnonymousHint => 'mid 為 0 時使用匿名模式';

  @override
  String get accountSwitchDetailed => '詳細';

  @override
  String get accountSwitchQuick => '快速';

  @override
  String get accountSignInFirst => '請先登入';

  @override
  String replyIpLocation(Object region) {
    return 'IP 所在地：$region';
  }

  @override
  String get videoPersonalOpinionDisclaimer => '個人觀點，僅供參考';

  @override
  String videoAllEpisodes(Object count) {
    return '全 $count 話';
  }

  @override
  String get feedPostedVideo => '投稿了影片';

  @override
  String get feedCoCreated => '與他人共同創作';

  @override
  String get feedLikesAndReposts => '讚與轉發';

  @override
  String get feedSaySomething => '說點什麼吧…';

  @override
  String get feedShareToFeed => '分享至動態';

  @override
  String get feedRepostFeed => '轉發動態';

  @override
  String get feedRepostAndComment => '同時評論';

  @override
  String get feedPublishNow => '立即發佈';

  @override
  String get feedRepostNow => '立即轉發';

  @override
  String get feedPublish => '發佈';

  @override
  String get feedRepostSucceeded => '轉發成功';

  @override
  String get commonCopied => '已複製';

  @override
  String get commonExport => '匯出';

  @override
  String get commonNoData => '沒有資料';

  @override
  String get commonTapToRetry => '點擊重試';

  @override
  String get watchLaterAdded => '已加入稍後觀看';

  @override
  String get watchLaterRemoved => '已從稍後觀看移除';

  @override
  String get myCommentsTitle => '我的評論';

  @override
  String get subscriptionFolder => '收藏夾';

  @override
  String get subscriptionCollection => '合集';

  @override
  String subscriptionOtherType(Object type) {
    return '其他（$type）';
  }

  @override
  String subscriptionUnavailable(Object type) {
    return '此$type已失效';
  }

  @override
  String subscriptionUploader(Object name) {
    return 'UP 主：$name';
  }

  @override
  String subscriptionVideoCount(Object count) {
    return '$count 個影片';
  }

  @override
  String subscriptionTotalVideos(Object count) {
    return '共 $count 個影片';
  }

  @override
  String subscriptionPlayCount(Object count) {
    return '$count 次播放';
  }

  @override
  String get subscriptionCancelConfirm => '確定取消訂閱嗎？';

  @override
  String get subscriptionCanceled => '取消訂閱成功';

  @override
  String get commonSaving => '正在儲存…';

  @override
  String get commonSaved => '已儲存';

  @override
  String get commonSaveFailed => '儲存失敗';

  @override
  String commonSaveFailedWithError(Object error) {
    return '儲存失敗：$error';
  }

  @override
  String get commonSaveCanceled => '取消儲存';

  @override
  String get commonDownloadCanceled => '已取消下載';

  @override
  String get commonDownloading => '正在下載…';

  @override
  String get commonDownloadingOriginal => '正在下載原圖…';

  @override
  String get commonFileNotFound => '檔案不存在';

  @override
  String get permissionStorageRequired => '未授權儲存權限';

  @override
  String get permissionOpenSettings => '前往授權';

  @override
  String get laterDeleteSelectedConfirm => '確定刪除所選稍後觀看項目嗎？';

  @override
  String get laterRemoveVideoConfirm => '即將移除這部影片，確定要移除嗎？';

  @override
  String get laterRemoveConfirmed => '確認移除';

  @override
  String get laterClearInvalidConfirm => '確定清空已失效影片嗎？';

  @override
  String get laterClearWatchedConfirm => '確定清空已看完影片嗎？';

  @override
  String get laterClearAllConfirm => '確定清空稍後觀看清單嗎？';

  @override
  String get laterCleared => '已清空稍後觀看';

  @override
  String get videoPremiumRequired => '需要大會員';

  @override
  String videoSwitchingTo(Object title) {
    return '切換到：$title';
  }

  @override
  String get shareTo => '分享給';

  @override
  String get shareChooseRecipients => '請選擇分享對象';

  @override
  String get shareSucceeded => '分享成功';

  @override
  String get shareFailed => '分享失敗';

  @override
  String get sharePartiallyFailed => '部分分享失敗';

  @override
  String get followCreateGroup => '新增分組';

  @override
  String get followGroupCreated => '建立成功';

  @override
  String get followSucceeded => '關注成功';

  @override
  String get followAddPriority => '加入特別關注';

  @override
  String get followRemovePriority => '移除特別關注';

  @override
  String get followPriorityAdded => '已加入特別關注';

  @override
  String get followPriorityRemoved => '已移除特別關注';

  @override
  String get followSetGroup => '設定分組';

  @override
  String get followUnfollow => '取消關注';

  @override
  String get followUnfollowSucceeded => '已取消關注';

  @override
  String get commonCopyTo => '複製到';

  @override
  String get commonMoveTo => '移動到';

  @override
  String get commonMoved => '移動成功';

  @override
  String get feedAppeal => '申訴';

  @override
  String get feedCheckResult => '動態檢查結果';

  @override
  String get feedCheckPassed => '未登入狀態下找到了你的動態，動態正常！';

  @override
  String get feedCheckShadowBanned => '你的動態可能僅自己可見！';

  @override
  String feedPostContent(Object content) {
    return '動態內容：$content';
  }

  @override
  String get commonMissingParameters => '缺少必要參數';

  @override
  String get videoCoinSucceeded => '投幣成功';

  @override
  String get historyNoWatchedItems => '沒有已看記錄';

  @override
  String get historyDeleteSelectedConfirm => '確定刪除所選歷史記錄嗎？';

  @override
  String get historyClearConfirm => '確定清空觀看歷史嗎？';

  @override
  String get historyCleared => '已清空觀看歷史';

  @override
  String get historyConfirmClear => '確認清空';

  @override
  String get historyPauseConfirm => '確定暫停觀看歷史嗎？';

  @override
  String get historyResumeConfirm => '確定恢復觀看歷史嗎？';

  @override
  String get historyPaused => '已暫停觀看歷史';

  @override
  String get historyResumed => '已恢復觀看歷史';

  @override
  String get historyConfirmPause => '確認暫停';

  @override
  String get historyConfirmResume => '確認恢復';

  @override
  String get commonActionsMenu => '功能選單';

  @override
  String get commonFavorited => '已收藏';

  @override
  String get liveNotStarted => '直播尚未開播';

  @override
  String get historyDeleteRecord => '刪除記錄';

  @override
  String get loginTitle => '登入';

  @override
  String get loginWithQr => '使用 bilibili 官方 App 掃碼登入';

  @override
  String loginQrExpiresIn(Object seconds) {
    return '剩餘有效時間：$seconds 秒';
  }

  @override
  String get loginRefreshQr => '重新整理 QR Code';

  @override
  String get loginGeneratingScreenshot => '正在產生圖片';

  @override
  String get loginSaveToGallery => '儲存至相簿';

  @override
  String get loginOpenInAnotherApp => '使用其他應用程式開啟';

  @override
  String get loginQrCopiedHint => '已複製到剪貼簿，可貼到已登入的 App 私訊中傳送，再開啟已傳送的連結。';

  @override
  String loginTrustedSourceNotice(Object appName) {
    return '請務必從 $appName 開源儲存庫等可信管道下載安裝。';
  }

  @override
  String get loginWithCookie => '使用 Cookie 登入';

  @override
  String get loginCookieLimit => '使用 App 端 API 的功能將無法使用';

  @override
  String get loginWithPassword => '使用帳號密碼登入';

  @override
  String get loginAccount => '帳號';

  @override
  String get loginEmailOrPhone => '電子郵件／手機號碼';

  @override
  String get loginPassword => '密碼';

  @override
  String get loginShowPassword => '顯示密碼';

  @override
  String get loginForgotPasswordQuestion => '忘記密碼？';

  @override
  String get loginForgotPasswordHint => '試試掃碼、手機號碼登入，或選擇密碼找回頁面。';

  @override
  String get loginRecoverPasswordMobile => '找回密碼（手機版）';

  @override
  String get loginRecoverPasswordDesktop => '找回密碼（電腦版）';

  @override
  String loginPasswordSecurityNotice(Object appName) {
    return '依照 bilibili 官方登入介面規範，密碼會在本機加鹽、加密後傳輸。鹽與公開金鑰均由官方提供，並使用 RSA/ECB/PKCS1Padding 加密。帳號密碼只用於登入且不會儲存；本機只儲存登入憑證。\n請務必從 $appName 開源儲存庫等可信管道下載安裝。';
  }

  @override
  String get loginWithSms => '使用手機簡訊驗證碼登入';

  @override
  String loginCountryCodeTooltip(Object code, Object name) {
    return '選擇國際冠碼，目前為 $name（+$code）';
  }

  @override
  String get loginCountryOrRegion => '國家/地區';

  @override
  String get loginPhoneNumber => '手機號碼';

  @override
  String get loginVerificationCode => '驗證碼';

  @override
  String loginWaitSeconds(Object seconds) {
    return '等待 $seconds 秒';
  }

  @override
  String get loginGetVerificationCode => '取得驗證碼';

  @override
  String loginSmsPrivacyNotice(Object appName) {
    return '手機號碼只用於 bilibili 官方傳送驗證碼與登入介面且不會儲存；本機只儲存登入憑證。\n請務必從 $appName 開源儲存庫等可信管道下載安裝。';
  }

  @override
  String get loginPasswordTab => '密碼';

  @override
  String get loginSmsTab => '簡訊';

  @override
  String get loginQrTab => '掃碼';

  @override
  String get loginQrExpired => 'QR Code 已過期，請重新整理';

  @override
  String get loginQrSucceeded => '掃碼成功';

  @override
  String get loginVerificationSucceeded => '驗證成功';

  @override
  String get loginCookieRequired => 'Cookie 不可為空';

  @override
  String get loginSucceeded => '登入成功';

  @override
  String loginFailedWithError(Object error) {
    return '登入失敗：$error';
  }

  @override
  String get loginSessionExpired => 'bilibili 登入已失效，請重新登入';

  @override
  String get loginUserInfoFailed => '無法取得 bilibili 使用者資訊，可前往帳號管理重試';

  @override
  String get loginCredentialsRequired => '使用者名稱或密碼不可為空';

  @override
  String loginNoDataReturned(Object message) {
    return '登入異常，介面未回傳資料：$message';
  }

  @override
  String loginTryAnotherMethod(Object details) {
    return '請嘗試其他登入方式。\n$details';
  }

  @override
  String get loginPhoneVerificationUnavailable => '目前帳號不支援手機號碼驗證，請嘗試其他登入方式';

  @override
  String get loginPhoneVerificationRequired => '本次登入需要驗證您的手機號碼';

  @override
  String get loginPhoneUnavailable => '無法取得手機號碼';

  @override
  String get loginEnterVerificationCode => '請輸入簡訊驗證碼';

  @override
  String get loginSendVerificationCode => '傳送驗證碼';

  @override
  String get loginVerificationCodeSent => '簡訊驗證碼已傳送';

  @override
  String get loginVerifyingAndSigningIn => '驗證成功，正在登入';

  @override
  String loginMissingIdentity(Object details) {
    return '登入異常，介面未回傳身分資訊，可能是帳號安全限制所致，請嘗試其他登入方式。\n$details';
  }

  @override
  String get loginSavingIdentity => '正在儲存登入資訊';

  @override
  String get loginPhoneRequired => '手機號碼不可為空';

  @override
  String get loginRequestCodeFirst => '請先取得驗證碼';

  @override
  String get loginVerificationCodeRequired => '驗證碼不可為空';

  @override
  String get loginVerificationCodeExpired => '驗證碼已過期，請重新取得';

  @override
  String get loginSucceededSetAccountMode => '登入成功，請先設定帳號模式';

  @override
  String get commonServerError => '伺服器錯誤';

  @override
  String get networkBadCertificate => '憑證無效';

  @override
  String get networkServerError => '伺服器異常，請稍後再試';

  @override
  String get networkRequestCancelled => '請求已取消';

  @override
  String get networkConnectionError => '連線錯誤，請檢查網路設定';

  @override
  String get networkConnectionTimeout => '網路連線逾時，請檢查網路設定';

  @override
  String get networkResponseTimeout => '回應逾時，請稍後再試';

  @override
  String get networkSendTimeout => '傳送請求逾時，請檢查網路設定';

  @override
  String get networkTransformTimeout => '處理回應資料逾時';

  @override
  String networkUnknownError(String error) {
    return '網路異常：$error';
  }

  @override
  String get searchSecurityCheckTriggered => '需要進行安全驗證';

  @override
  String get loginVerificationTitle => '驗證';

  @override
  String get loginVerificationLoadFailed => '驗證碼載入失敗';

  @override
  String get loginCompleteVerificationWindow => '請在彈出的新視窗中完成驗證';

  @override
  String get memberBlockConfirm => '確定封鎖這位 UP 主嗎？';

  @override
  String get memberUnblockConfirm => '將這位 UP 主從封鎖名單移除嗎？';

  @override
  String get memberNoPlayableVideos => '這位 UP 主沒有可播放的影片';

  @override
  String get memberVideoPlayInfoUnavailable => '無法取得影片播放資訊';

  @override
  String memberRandomVideoFailed(Object error) {
    return '隨機影片取得失敗：$error';
  }

  @override
  String get memberFollowerRemoved => '已移除粉絲';

  @override
  String get memberPremiumRewardClaimed => '領取成功';

  @override
  String get memberAddToBlocked => '加入封鎖名單';

  @override
  String get memberRemoveFromBlocked => '移出封鎖名單';

  @override
  String get memberRemoveFollower => '移除粉絲';

  @override
  String get memberShareUploader => '分享 UP 主';

  @override
  String get memberShareMyProfile => '分享我的主頁';

  @override
  String get memberAddToHomeScreen => '加入主畫面';

  @override
  String get memberRandomPlay => '隨機播放';

  @override
  String get memberReservation => '預約';

  @override
  String get memberReserved => '已預約';

  @override
  String get memberReservationPost => '預約動態';

  @override
  String memberReservationCount(Object count) {
    return '$count 人預約';
  }

  @override
  String get memberWebUploads => '網頁投稿';

  @override
  String get memberPremiumXp => '大會員經驗';

  @override
  String get memberSignInHistory => '登入記錄';

  @override
  String get memberCoinHistory => '硬幣記錄';

  @override
  String get memberXpHistory => '經驗記錄';

  @override
  String memberFollowingSince(Object date) {
    return '關注時間：$date';
  }

  @override
  String get memberAccountBanned => '此帳號已被停權';

  @override
  String memberSupporterCount(Object count) {
    return '$count 人為 TA 充電';
  }

  @override
  String memberGuardCount(Object count) {
    return '$count 人加入大航海';
  }

  @override
  String get memberMyRecommendations => '我的推薦';

  @override
  String memberRecommendationsBy(String name) {
    return '$name的推薦';
  }

  @override
  String memberCollectionCount(int count) {
    return '合集：$count';
  }

  @override
  String memberListCount(int count) {
    return '清單：$count';
  }

  @override
  String memberGuardTitle(String name) {
    return '$name的艦隊';
  }

  @override
  String memberGuardTitleWithCount(String name, Object count) {
    return '$name的艦隊（$count）';
  }

  @override
  String get memberAlsoFollowed => '也關注了 TA';

  @override
  String memberAlsoFollowedWithOthers(Object count) {
    return '等 $count 人也關注了 TA';
  }

  @override
  String get memberLikesReceived => '獲讚';

  @override
  String get memberFollowingTime => '關注時間';

  @override
  String commonSelectedCount(Object count) {
    return '已選：$count';
  }

  @override
  String get commonSelectAll => '全選';

  @override
  String get commonCancelSelection => '取消選擇';

  @override
  String get imageSaveImage => '儲存圖片';

  @override
  String get imageSaveAll => '全部儲存';

  @override
  String get imageSaveAllImages => '儲存全部圖片';

  @override
  String get imageSaveVideo => '儲存影片';

  @override
  String get imageSaveLivePhoto => '儲存原況照片';

  @override
  String get imageOpenInBrowser => '在瀏覽器中開啟';

  @override
  String get commonDone => '完成';

  @override
  String get commonCreate => '建立';

  @override
  String get favoriteSortMethod => '排序方式';

  @override
  String favoriteContentCount(num count) {
    return '$count個內容';
  }

  @override
  String favoriteContentSummary(num count, Object visibility) {
    return '$count個內容 · $visibility';
  }

  @override
  String get favoriteEditInfo => '編輯資訊';

  @override
  String get favoriteShareToPost => '分享到動態';

  @override
  String get favoriteClearUnavailable => '清除失效內容';

  @override
  String get favoriteDeleteFolderConfirm => '確定刪除這個收藏夾？';

  @override
  String get favoriteRemoveSelectedConfirm => '確認刪除所選收藏嗎？';

  @override
  String get favoriteRemoved => '已取消收藏';

  @override
  String get favoriteFolderAdded => '收藏夾收藏成功';

  @override
  String get favoriteFolderRemoved => '已取消收藏夾收藏';

  @override
  String get favoriteClearSucceeded => '清除成功';

  @override
  String get favoriteTooManyToSort => '內容超過 1000 筆，不支援排序';

  @override
  String get favoriteRemoveConfirm => '要取消收藏嗎？';

  @override
  String get favoriteConfirmRemove => '確定取消';

  @override
  String get favoriteAudio => '音訊';

  @override
  String get favoriteAddToFolder => '加入收藏夾';

  @override
  String get favoriteNameRequired => '名稱不能為空';

  @override
  String get favoriteFolderCreated => '建立成功';

  @override
  String get favoriteFolderUpdated => '編輯成功';

  @override
  String get favoriteCrop => '裁切';

  @override
  String get favoriteReplaceCover => '替換封面';

  @override
  String get favoriteRemoveCover => '移除封面';

  @override
  String get favoriteCover => '封面';

  @override
  String get favoriteName => '名稱';

  @override
  String get favoriteIntro => '簡介';

  @override
  String get favoriteIntroHint => '可填寫簡介';

  @override
  String get favoritePublicSetting => '公開';

  @override
  String get favoriteCollectionBadge => '合集';

  @override
  String get favoriteFolderBadge => '收藏夾';

  @override
  String favoriteUploaderCollectionSummary(Object count, Object name) {
    return '$count個內容 · $name';
  }

  @override
  String favoriteCreatedCollectionSummary(
    Object count,
    Object name,
    Object views,
  ) {
    return '建立者：$name\n$count個影片 · $views播放';
  }

  @override
  String get favoriteOrderRecentlyAdded => '最近收藏';

  @override
  String get favoriteOrderMostPlayed => '最多播放';

  @override
  String get favoriteOrderRecentlyPublished => '最近投稿';

  @override
  String get profileTitle => '帳號資料';

  @override
  String get profileAvatar => '頭像';

  @override
  String get profileNickname => '暱稱';

  @override
  String get profileGender => '性別';

  @override
  String get profileBirthday => '出生年月';

  @override
  String get profileBio => '個人簽名';

  @override
  String get profileAvatarDecoration => '頭像掛件';

  @override
  String get profileVerification => '嗶哩嗶哩認證';

  @override
  String get profileInsufficientCoins => '硬幣不足';

  @override
  String get profileGenderMale => '男';

  @override
  String get profileGenderPrivate => '保密';

  @override
  String get profileGenderFemale => '女';

  @override
  String profileEditField(Object field) {
    return '修改$field';
  }

  @override
  String profileSameAsCurrent(Object field) {
    return '與原$field相同';
  }

  @override
  String get profileReloginRequired => '請登出帳號後重新登入';

  @override
  String get profileUpdateSucceeded => '修改成功';

  @override
  String get profileGifNotSupported => '不能選擇 GIF';

  @override
  String get shutdownPauseVideo => '暫停影片';

  @override
  String get shutdownExitApp => '退出應用程式';

  @override
  String get shutdownTitle => '定時關閉';

  @override
  String get shutdownCanceled => '已取消定時關閉';

  @override
  String shutdownScheduledAfter(Object duration) {
    return '已設定在 $duration 後定時關閉';
  }

  @override
  String get shutdownTimeReachedPaused => '定時時間已到，已暫停';

  @override
  String shutdownHoursMinutes(Object hours, Object minutes) {
    return '$hours小時$minutes分鐘';
  }

  @override
  String shutdownHours(Object hours) {
    return '$hours小時';
  }

  @override
  String shutdownMinutes(Object minutes) {
    return '$minutes分鐘';
  }

  @override
  String get shutdownCustom => '自訂';

  @override
  String get shutdownWaitUntilVideoEnds => '額外等待影片播放完畢';

  @override
  String get shutdownActionAtEnd => '倒數結束：';

  @override
  String get replyViewComments => '查看評論';

  @override
  String get replyAppeal => '申訴';

  @override
  String get replyCheckResult => '評論檢查結果';

  @override
  String replyMainListError(Object error) {
    return '取得評論主列表時發生錯誤：$error';
  }

  @override
  String replyCheckNormal(Object message) {
    return '未登入狀態下找到了你的評論，評論正常！\n\n你的評論：$message';
  }

  @override
  String replyCheckNotFound(Object message) {
    return '無法找到你的評論。\n\n你的評論：$message';
  }

  @override
  String replyCheckShadowBanned(Object message) {
    return '你的評論可能僅自己可見！\n\n你的評論：$message';
  }

  @override
  String replyCheckInvisible(Object error, Object message) {
    return '評論不可見（$error）：$message';
  }

  @override
  String replyCheckSuspicious(Object message, Object url) {
    return '你的評論狀態有些可疑。未登入瀏覽評論區時無法看到，但可以透過以下網址直接取得：\n$url\n評論區可能受到限制，或者這是你的影片。\n\n你的評論：$message';
  }

  @override
  String replyCheckInvisibleSimple(Object message) {
    return '評論不可見：$message';
  }

  @override
  String get replyContentText => '文字';

  @override
  String get replyContentEmoji => '表情';

  @override
  String get replyFilterChangeConfirm => '確認套用評論過濾變更？';

  @override
  String get replyAddToFilter => '加入過濾';

  @override
  String memberReportTitle(Object name) {
    return '檢舉：$name';
  }

  @override
  String get memberReportContentRequired => '檢舉內容（必選，可複選）';

  @override
  String get memberReportReasonOptional => '檢舉理由（單選，非必選）';

  @override
  String get memberReportAvatar => '頭像違規';

  @override
  String get memberReportNickname => '暱稱違規';

  @override
  String get memberReportBio => '簽名違規';

  @override
  String get memberReportChooseContent => '至少選擇一項作為檢舉內容';

  @override
  String get reportFailed => '檢舉失敗';

  @override
  String get feedPinned => '置頂成功';

  @override
  String get feedUnpinned => '取消置頂成功';

  @override
  String get updateCheckFailed => '檢查更新失敗，GitHub 介面未回傳資料，請檢查網路';

  @override
  String get updateSelfCompiled => '自行編譯版不參與更新';

  @override
  String get updateAlreadyLatest => '已是最新版本';

  @override
  String get updateNewVersion => '🎉 發現新版本';

  @override
  String get updateViewFullChanges => '查看完整提交記錄';

  @override
  String get updateStopReminding => '不再提醒';

  @override
  String get commonUnsupportedType => '尚未支援此類型，請聯絡開發者';

  @override
  String get commonGettingResource => '資源取得中…';

  @override
  String get commonResourceLoadFailed => '資源載入失敗';

  @override
  String routeUnknown(Object uri) {
    return '未知路徑：$uri，請截圖回報給開發者';
  }

  @override
  String videoLoadFailed(Object error) {
    return '影片取得失敗：$error';
  }

  @override
  String get liveTitle => '直播';

  @override
  String get rankingTitle => '排行榜';

  @override
  String get commonPlaylist => '播放清單';

  @override
  String get videoParts => '分 P';

  @override
  String get videoChargingOnly => '充電專屬';

  @override
  String get videoTrailerBadge => '預告';

  @override
  String get videoLimitedFreeBadge => '限免';

  @override
  String get subscriptionSubscribe => '訂閱';

  @override
  String get subscriptionUnsubscribe => '取消訂閱';

  @override
  String get subscriptionSubscribed => '訂閱成功';

  @override
  String get commonJumpToTop => '跳至頂部';

  @override
  String get commonJumpToBottom => '跳至底部';

  @override
  String get commonJumpToCurrent => '跳至目前';

  @override
  String get commonAscendingOrder => '順序';

  @override
  String get commonDescendingOrder => '倒序';

  @override
  String get searchUserByUid => '透過 UID 搜尋使用者';

  @override
  String get searchTrending => '大家都在搜';

  @override
  String get searchDiscover => '搜尋發現';

  @override
  String get searchFullRanking => '完整榜單';

  @override
  String get searchHistory => '搜尋記錄';

  @override
  String get searchRecordHistory => '記錄搜尋';

  @override
  String get searchIncognito => '無痕搜尋';

  @override
  String get searchImportExportHistory => '匯入或匯出搜尋記錄';

  @override
  String get searchClearHistoryConfirm => '確定清空搜尋記錄？';

  @override
  String searchTabCount(Object count, Object label) {
    return '$label $count';
  }

  @override
  String memberSearchHint(Object name) {
    return '搜尋「$name」的動態、影片';
  }

  @override
  String get favoriteDeleteSelectedNotesConfirm => '確定刪除已選取的筆記嗎？';

  @override
  String get favoriteRemoveCourseConfirm => '確定取消收藏這個課程？';

  @override
  String get downloadDeleteSelectedConfirm => '確定刪除選取的影片？';

  @override
  String get downloadQueueTitle => '正在快取';

  @override
  String get downloadViewDetails => '查看詳情頁';

  @override
  String get downloadOpenLocalFolder => '開啟本機資料夾';

  @override
  String downloadVisitUploader(Object name) {
    return '前往$name';
  }

  @override
  String get downloadUserProfile => '使用者主頁';

  @override
  String get downloadWatched => '已看完';

  @override
  String get downloadStatusDownloading => '正在下載';

  @override
  String get downloadStatusAudioDownloading => '正在下載音訊';

  @override
  String get downloadStatusGettingDanmaku => '取得彈幕';

  @override
  String get downloadStatusGettingPlayUrl => '取得播放位址';

  @override
  String get downloadStatusCompleted => '下載完成';

  @override
  String get downloadStatusFailed => '下載失敗';

  @override
  String get downloadStatusAudioFailed => '音訊下載失敗';

  @override
  String get downloadStatusDanmakuFailed => '取得彈幕失敗';

  @override
  String get downloadStatusPlayUrlFailed => '取得播放位址失敗';

  @override
  String get downloadStatusPaused => '已暫停';

  @override
  String get downloadStatusWaiting => '等待中';

  @override
  String get commonSettings => '設定';

  @override
  String get commonEmoji => '表情';

  @override
  String get messagesRecall => '收回';

  @override
  String get messagesRecalled => '收回成功';

  @override
  String get messagesSent => '傳送成功';

  @override
  String get messagesInputHint => '傳送訊息…';

  @override
  String get messagesUploadingImage => '正在上傳圖片…';

  @override
  String get messagesChatSettings => '聊天設定';

  @override
  String get messagesAddToBlocked => '加入黑名單';

  @override
  String get messagesReceivePush => '接收訊息推播';

  @override
  String get messagesPushDescription => '關閉後將不再收到該帳號的圖文訊息與稿件推播，但通知類訊息不受影響。';

  @override
  String get messagesPinChat => '置頂聊天';

  @override
  String get messagesMute => '訊息勿擾';

  @override
  String get messagesDisablePushConfirm => '確認關閉內容推播嗎？';

  @override
  String get messagesBlockConfirm => '確認封鎖這位使用者？';

  @override
  String get messagesBlockDescription =>
      '加入黑名單後，將自動解除關注關係和對該使用者的合集訂閱關係，並禁止對方與你互動或查看你的個人空間。';

  @override
  String get messagesBvNotFound => '未找到 BV 號';

  @override
  String get commonAdd => '新增';

  @override
  String get messagesBlockedKeywords => '訊息封鎖關鍵字';

  @override
  String get messagesTapKeywordToDelete => '點選封鎖關鍵字即可刪除';

  @override
  String get messagesDeleteKeywordConfirm => '刪除封鎖關鍵字？';

  @override
  String get messagesKeywordNoLongerApplies => '這個封鎖關鍵字將不再生效';

  @override
  String get messagesAddBlockedKeyword => '新增訊息封鎖關鍵字';

  @override
  String get messagesNoBlockedKeywords => '尚未新增封鎖關鍵字';

  @override
  String get messagesBlockedKeywordDescription => '新增後，將不再接收包含封鎖關鍵字的訊息';

  @override
  String get messagesEnterKeyword => '請輸入';

  @override
  String get messagesMarkAllRead => '全部標為已讀';

  @override
  String get messagesMarkAllReadConfirm => '是否清除全部新訊息提醒？';

  @override
  String get messagesClearList => '清空列表';

  @override
  String get messagesClearListConfirm => '清空後所有訊息將被刪除，無法復原';

  @override
  String get messagesMenuSettings => '訊息設定';

  @override
  String get messagesUploaderAssistant => 'UP主助手';

  @override
  String get messagesContacts => '聯絡人';

  @override
  String get messagesFanGroupAssistant => '粉絲團助手';

  @override
  String get feedSelectTopic => '選擇話題';

  @override
  String get feedOptionalTitleHint => '標題，選填 20 字';

  @override
  String get feedEditPostTitle => '編輯動態';

  @override
  String get feedCreatePostTitle => '發佈動態';

  @override
  String get feedScheduledPost => '定時發佈';

  @override
  String feedScheduleAtLeastMinutes(Object minutes) {
    return '請至少選擇 $minutes 分鐘之後的時間';
  }

  @override
  String get feedLiveReservation => '直播預約';

  @override
  String get feedStartedPoll => '我發起了一個投票';

  @override
  String get feedPosting => '正在發佈…';

  @override
  String get feedPosted => '發佈成功';

  @override
  String feedLiveReservationTitle(Object title) {
    return '直播預約：$title';
  }

  @override
  String feedLiveStartsAt(Object time) {
    return '$time 直播';
  }

  @override
  String get feedAllowComments => '允許評論';

  @override
  String get feedCloseComments => '關閉評論';

  @override
  String get feedFeaturedComments => '精選評論';

  @override
  String get voteCreateTitle => '發起投票';

  @override
  String get voteEditTitle => '投票';

  @override
  String get voteType => '投票類型';

  @override
  String get voteTitle => '投票標題';

  @override
  String get voteTitleHint => '請填寫標題';

  @override
  String get voteDescription => '投票說明';

  @override
  String voteOptionLabel(Object number) {
    return '選項$number';
  }

  @override
  String get voteOptionHint => '選項內容，最多 20 字';

  @override
  String get voteAddOption => '新增選項';

  @override
  String get voteChoiceMode => '單選或多選';

  @override
  String get voteSingleChoice => '單選';

  @override
  String voteMaxChoices(Object count) {
    return '最多選 $count 項';
  }

  @override
  String get voteEndTime => '投票截止時間';

  @override
  String get voteAtLeastFiveMinutes => '至少選擇 5 分鐘之後';

  @override
  String get voteCreate => '發起投票';

  @override
  String get voteTextType => '文字投票';

  @override
  String get voteImageType => '圖片投票';

  @override
  String get reserveAddLive => '新增直播預約';

  @override
  String get reserveType => '類型';

  @override
  String get reservePublicLive => '公開直播';

  @override
  String get reserveSupporterLive => '大航海直播';

  @override
  String get reserveTime => '時間';

  @override
  String get reserveTitle => '標題';

  @override
  String get reserveTitleHint => '請填寫標題，最多 14 字';

  @override
  String get reserveAdd => '新增預約';

  @override
  String get mentionInputHint => '輸入你想 @ 的人';

  @override
  String get topicSearchHint => '搜尋話題';

  @override
  String get commonBlock => '封鎖';

  @override
  String get commonBlockSucceeded => '封鎖成功';

  @override
  String get commonShow => '顯示';

  @override
  String get commonHide => '隱藏';

  @override
  String get playerEnterFullscreen => '進入全螢幕';

  @override
  String get playerExitFullscreen => '退出全螢幕';

  @override
  String get playerTurnOffBackgroundPlayback => '關閉背景播放';

  @override
  String get liveSendDanmaku => '發彈幕';

  @override
  String get liveSwitchRoute => '切換路線';

  @override
  String get liveShareRoom => '分享直播間';

  @override
  String livePlayerVolume(Object value) {
    return '播放器音量：$value%';
  }

  @override
  String get liveBackToBottom => '回到底部';

  @override
  String get liveCopyDanmakuInfo => '複製彈幕資訊';

  @override
  String get liveGoToUserProfile => '前往 TA 的個人空間';

  @override
  String get liveBlockSender => '封鎖傳送者';

  @override
  String get liveBlocked => '封鎖成功';

  @override
  String get liveLikeSucceeded => '按讚成功';

  @override
  String get liveDanmakuInputHint => '輸入彈幕內容';

  @override
  String get audioNoOrder => '無序';

  @override
  String audioPlaybackSpeed(Object speed) {
    return '播放倍速（$speed×）';
  }

  @override
  String get audioPlaybackMode => '播放模式';

  @override
  String get videoTripleSucceeded => '三連成功';

  @override
  String get danmakuBlockTitle => '彈幕封鎖';

  @override
  String get danmakuBlockKeyword => '關鍵字';

  @override
  String get danmakuBlockRegex => '正規表示式';

  @override
  String get danmakuBlockUser => '使用者';

  @override
  String danmakuBlockTabCount(Object count, Object label) {
    return '$label（$count）';
  }

  @override
  String get danmakuDeleteRuleConfirm => '確定刪除這個規則？';

  @override
  String get danmakuKeywordHint => '輸入過濾關鍵字；其他類別請切換分頁後新增。';

  @override
  String get danmakuRegexHint => '輸入 // 之間的正規表示式，無需包含首尾斜線。';

  @override
  String get danmakuUidHint => '輸入使用者 UID';

  @override
  String danmakuRuleDialogTitle(Object action, Object type) {
    return '$action$type規則';
  }

  @override
  String get danmakuInputEmpty => '輸入內容不能為空';

  @override
  String get danmakuInputUnchanged => '輸入內容與上次相同';

  @override
  String get danmakuSyncingRules => '正在同步彈幕封鎖規則…';

  @override
  String get danmakuDeletingRule => '正在刪除彈幕封鎖規則…';

  @override
  String get danmakuAddingRule => '正在新增彈幕封鎖規則…';

  @override
  String get liveDanmakuGlobalBlock => '全域封鎖';

  @override
  String get liveDanmakuBlockEnabled => '封鎖已開啟';

  @override
  String get liveDanmakuBlockDisabled => '封鎖未開啟';

  @override
  String get liveDanmakuUserLevel => '使用者等級';

  @override
  String liveDanmakuBelowLevel(Object level) {
    return '$level 以下';
  }

  @override
  String get liveDanmakuUnofficialUser => '非正式會員';

  @override
  String get liveDanmakuUnverifiedPhone => '未綁定手機的使用者';

  @override
  String get liveDanmakuKeywordBlock => '關鍵字封鎖';

  @override
  String get commonInput => '輸入';

  @override
  String get favoriteFolderSortTitle => '收藏夾排序';

  @override
  String get favoriteDefaultFolderSortUnsupported => '預設收藏夾不支援排序';

  @override
  String favoriteSortFolderTitle(String folder) {
    return '排序：$folder';
  }

  @override
  String get followSaveToDefaultGroup => '儲存至預設分組';

  @override
  String get commonVideo => '影片';

  @override
  String get commonLongImage => '長圖';

  @override
  String imagePositionSemantics(int position, int total) {
    return '圖片，第 $position 張，共 $total 張';
  }

  @override
  String get downloadVideoCachedNotification => '影片已快取完成';

  @override
  String get topicJoin => '參與話題';

  @override
  String get topicStarted => '發起';

  @override
  String topicStats(String views, String discussions) {
    return '$views 次瀏覽 · $discussions 則討論';
  }

  @override
  String get replyPinned => '留言置頂成功';

  @override
  String get replyUnpinned => '已取消留言置頂';

  @override
  String get webRefresh => '重新整理';

  @override
  String get webCopyLink => '複製連結';

  @override
  String get webOpenInBrowser => '在瀏覽器中開啟';

  @override
  String get webClearCache => '清除快取';

  @override
  String get webResetCookie => '重新設定 Cookie';

  @override
  String get webGoBack => '返回';

  @override
  String get webCacheCleared => '已清理';

  @override
  String get webCookieResetSucceeded => '設定成功，請重新整理或重新開啟網頁';

  @override
  String webDownloadFileConfirm(String filename) {
    return '下載檔案：$filename？';
  }

  @override
  String webConfirmWithFileSize(String size) {
    return '確定（$size）';
  }

  @override
  String get webExternalLinkConfirm => '目前網頁將要開啟外部連結，是否開啟？';

  @override
  String get webOpen => '開啟';

  @override
  String get commonUnliked => '已取消按讚';

  @override
  String get articleShareTitle => 'bilibili 專欄';

  @override
  String articleCount(String count) {
    return '$count 篇專欄';
  }

  @override
  String articleWordCount(String count) {
    return '$count 個字';
  }

  @override
  String articleReadCount(String count) {
    return '$count 次閱讀';
  }

  @override
  String articleUpdatedAt(String date) {
    return '$date 更新';
  }

  @override
  String articleCollectionId(int id) {
    return '文集編號：$id';
  }

  @override
  String followUserFollowers(String name) {
    return '$name 的粉絲';
  }

  @override
  String followRemoveFollowerConfirm(String name) {
    return '確定移除 $name？';
  }

  @override
  String get followFollowerRemoved => '移除成功';

  @override
  String get matchDetails => '比賽詳情';

  @override
  String get matchWatchLive => '觀看直播';

  @override
  String matchEndedAt(String date) {
    return '$date · 已結束';
  }

  @override
  String get castNoDevices => '找不到投放裝置';

  @override
  String get liveSearchHint => '搜尋直播間或實況主';

  @override
  String get liveContributionRankOnline => '線上榜';

  @override
  String get liveContributionRankDaily => '日榜';

  @override
  String get liveContributionRankWeekly => '週榜';

  @override
  String get liveContributionRankMonthly => '月榜';

  @override
  String liveSearchRooms(String count) {
    return '正在直播 $count';
  }

  @override
  String liveSearchUploaders(String count) {
    return '實況主 $count';
  }

  @override
  String get liveAllTags => '全部標籤';

  @override
  String get liveFavoriteTags => '我的常用標籤';

  @override
  String get liveTapTagHint => '點擊進入標籤';

  @override
  String get favoriteWantToWatch => '想看';

  @override
  String get favoriteWatching => '在看';

  @override
  String get favoriteWatched => '看過';

  @override
  String get favoriteUnpublishedNotes => '未發佈筆記';

  @override
  String get favoritePublicNotes => '公開筆記';

  @override
  String get memberOrderMostPlayed => '最多播放';

  @override
  String get memberOrderMostFavorited => '最多收藏';

  @override
  String get memberReverseOrder => '反向';

  @override
  String get memberJumpToPage => '跳至';

  @override
  String get memberPageNumber => '頁數';

  @override
  String get memberLocateLastWatched => '定位至上次觀看';

  @override
  String audioTrackCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '共 $count 首',
    );
    return '$_temp0';
  }

  @override
  String get memberMyRecentCoinedVideos => '我的最近投幣';

  @override
  String memberUserRecentCoinedVideos(String name) {
    return '$name 的最近投幣';
  }

  @override
  String get memberFanMedalWall => '粉絲勳章牆';

  @override
  String memberFanMedalCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '共擁有 $count 枚粉絲勳章',
    );
    return '$_temp0';
  }

  @override
  String get memberMedalWearing => '佩戴中';

  @override
  String favoriteAddedAt(String date) {
    return '收藏於 $date';
  }

  @override
  String get memberLastWatched => '上次觀看';

  @override
  String get reviewLong => '長評';

  @override
  String get reviewShort => '短評';

  @override
  String get reviewWriteLong => '撰寫長評';

  @override
  String get reviewWriteShort => '撰寫短評';

  @override
  String get reviewLatest => '最新';

  @override
  String get reviewRatingAwful => '很差';

  @override
  String get reviewRatingPoor => '較差';

  @override
  String get reviewRatingOkay => '還行';

  @override
  String get reviewRatingGreat => '很好';

  @override
  String get reviewRatingExcellent => '佳作';

  @override
  String get reviewTapToRate => '輕觸評分';

  @override
  String get reviewEdited => '編輯成功';

  @override
  String get reviewPublished => '點評成功';

  @override
  String get reviewDeleteConfirm => '刪除短評，同時刪除評分？';

  @override
  String reviewCount(String count) {
    return '$count 則點評';
  }

  @override
  String get searchFilter => '篩選';

  @override
  String searchFilteredBy(String filter) {
    return '「$filter」的篩選結果';
  }

  @override
  String searchSortValue(String value) {
    return '排序：$value';
  }

  @override
  String searchZoneValue(String value) {
    return '分區：$value';
  }

  @override
  String searchUserTypeValue(String value) {
    return '使用者類型：$value';
  }

  @override
  String get searchZone => '分區';

  @override
  String get searchUserSort => '依粉絲數與等級排序';

  @override
  String get searchUserType => '使用者分類';

  @override
  String get searchPublishedTime => '發佈時間';

  @override
  String get searchDateTo => '至';

  @override
  String get searchContentDuration => '內容時長';

  @override
  String get searchContentZone => '內容分區';

  @override
  String get searchOrderRelevance => '綜合排序';

  @override
  String get searchOrderNewest => '最新發佈';

  @override
  String get searchOrderMostClicked => '最多點擊';

  @override
  String get searchOrderMostLiked => '最多喜歡';

  @override
  String get searchOrderMostCommented => '最多留言';

  @override
  String get searchOrderDefault => '預設排序';

  @override
  String get searchOrderMostPlayed => '播放最多';

  @override
  String get searchOrderMostDanmaku => '彈幕最多';

  @override
  String get searchOrderMostFavorited => '收藏最多';

  @override
  String get searchFollowersHighToLow => '粉絲數由高到低';

  @override
  String get searchFollowersLowToHigh => '粉絲數由低到高';

  @override
  String get searchLevelHighToLow => '等級由高到低';

  @override
  String get searchLevelLowToHigh => '等級由低到高';

  @override
  String get searchAllUsers => '全部使用者';

  @override
  String get searchUploaders => 'UP 主';

  @override
  String get searchRegularUsers => '一般使用者';

  @override
  String get searchVerifiedUsers => '認證使用者';

  @override
  String get searchAnyTime => '不限';

  @override
  String get searchLastDay => '最近一天';

  @override
  String get searchLastWeek => '最近一週';

  @override
  String get searchLastSixMonths => '最近半年';

  @override
  String get searchAllDurations => '全部時長';

  @override
  String get searchDurationUnderTen => '0–10 分鐘';

  @override
  String get searchDurationTenToThirty => '10–30 分鐘';

  @override
  String get searchDurationThirtyToSixty => '30–60 分鐘';

  @override
  String get searchDurationOverSixty => '60 分鐘以上';

  @override
  String get searchAllZones => '全部分區';

  @override
  String get searchZoneAnimation => '動畫';

  @override
  String get searchZoneAnime => '番劇';

  @override
  String get searchZoneChineseAnimation => '國創';

  @override
  String get searchZoneMusic => '音樂';

  @override
  String get searchZoneDance => '舞蹈';

  @override
  String get searchZoneGames => '遊戲';

  @override
  String get searchZoneKnowledge => '知識';

  @override
  String get searchZoneTechnology => '科技';

  @override
  String get searchZoneSports => '運動';

  @override
  String get searchZoneCars => '汽車';

  @override
  String get searchZoneLife => '生活';

  @override
  String get searchZoneFood => '美食';

  @override
  String get searchZoneAnimals => '動物';

  @override
  String get searchZoneKichiku => '鬼畜';

  @override
  String get searchZoneFashion => '時尚';

  @override
  String get searchZoneNews => '資訊';

  @override
  String get searchZoneEntertainment => '娛樂';

  @override
  String get searchZoneFilmTv => '影視';

  @override
  String get searchZoneDocumentary => '紀錄片';

  @override
  String get searchZoneMovies => '電影';

  @override
  String get searchZoneTv => '電視';

  @override
  String get searchZoneInterests => '興趣';

  @override
  String get searchZoneLightNovels => '輕小說';

  @override
  String get searchZoneNotes => '筆記';

  @override
  String get commonAlbum => '相簿';

  @override
  String get commonArticle => '專欄';

  @override
  String get messagesAutoReply => '此訊息為自動回覆';

  @override
  String messagesLiveBy(String author) {
    return '$author · 直播';
  }

  @override
  String get liveNow => '直播中';

  @override
  String memberFollowerCount(String count) {
    return '$count 位粉絲';
  }

  @override
  String get commonViewMore => '查看更多內容';

  @override
  String get commonExit => '退出';

  @override
  String get audioWatchMv => '看 MV';

  @override
  String liveHighEnergyAudience(String count) {
    return '高能觀眾（$count）';
  }

  @override
  String get liveJustStarted => '剛剛開播';

  @override
  String liveStartedFor(String duration) {
    return '開播 $duration';
  }

  @override
  String get livePlaybackUrlUnavailable => '無法取得播放位址';

  @override
  String liveVisitUser(String name) {
    return '造訪：$name';
  }

  @override
  String get liveCopySuperChatInfo => '複製 SC 資訊';

  @override
  String get commonExpand => '展開';

  @override
  String get commonCollapse => '收起';

  @override
  String get feedTopics => '話題';

  @override
  String get commonTime => '時間';

  @override
  String get commonReason => '原因';

  @override
  String get logChange => '變化';

  @override
  String get logLocation => '地理位置';

  @override
  String get logExperienceHistory => '經驗記錄';

  @override
  String get logLoginHistory => '登入記錄';

  @override
  String get saveWatch => '觀看';

  @override
  String get saveContent => '內容';

  @override
  String get saveCollection => '合集';

  @override
  String saveScanQrToOpen(String action, String item) {
    return '掃描 QR Code，$action$item';
  }

  @override
  String musicReleaseDate(String date) {
    return '發行日期：$date';
  }

  @override
  String musicOriginalArtist(String artist) {
    return '原唱：$artist';
  }

  @override
  String musicAlbum(String album) {
    return '專輯：$album';
  }

  @override
  String musicSource(String source) {
    return '出處：$source';
  }

  @override
  String get musicHotSongRanking => '熱門歌曲排行';

  @override
  String get musicPopularity => '熱度';

  @override
  String get musicTotalPlays => '總播放量';

  @override
  String get musicVideosUsingTrack => '使用稿件數';

  @override
  String musicRecentPopularityTrend(int days) {
    return '近 $days 日熱度趨勢';
  }

  @override
  String articleAuthorReads(String author, int count) {
    return '$author · $count 次閱讀';
  }

  @override
  String articlePriceFrom(String price) {
    return '$price 起';
  }

  @override
  String get articleFeedOrArticle => '動態 / 專欄';

  @override
  String articleUnsupportedType(String type) {
    return '不支援的類型（$type）';
  }

  @override
  String articleInvalidType(String error) {
    return '錯誤的類型：$error';
  }

  @override
  String memberShopFrom(String source) {
    return '來自 $source';
  }

  @override
  String get loginMainAccountSucceeded => '主帳號登入成功';

  @override
  String loginCookieFailed(String error) {
    return '登入失敗，請檢查 Cookie 是否正確。$error';
  }

  @override
  String get memberAllCollectionsAndLists => '全部合集 / 清單';

  @override
  String get memberAllPosts => '全部圖文';

  @override
  String get memberPosts => '圖文';

  @override
  String memberSupportRanking(String name, String count) {
    return '$name 的充電排行榜 $count';
  }

  @override
  String get memberSupport => '充電';

  @override
  String get memberSupportDaysSuffix => ' 天';

  @override
  String liveSearchUserStats(String area, String followers) {
    return '分區：$area · 關注數：$followers';
  }

  @override
  String bubbleSiteTitle(String name) {
    return '$name 小站';
  }

  @override
  String liveSwitchPreviewTo(String target) {
    return '切換至$target';
  }

  @override
  String get liveCover => '封面';

  @override
  String get liveFirstFrame => '首幀';

  @override
  String get liveShowMenu => '顯示選單';

  @override
  String get liveReportSelectedDanmaku => '檢舉選取的彈幕';

  @override
  String get mediaTvSeries => '電視劇';

  @override
  String get mediaComics => '漫畫';

  @override
  String get mediaVarietyShows => '綜藝';

  @override
  String memberUserLevelSemantics(int level) {
    return '$level 級';
  }

  @override
  String get avatarVipBadge => '大會員';

  @override
  String get avatarVerifiedIndividual => '個人認證';

  @override
  String get avatarVerifiedOrganization => '機構認證';

  @override
  String memberHardcoreUserLevelSemantics(int level) {
    return '硬核 $level 級';
  }

  @override
  String get playerProgressBar => '進度條';

  @override
  String get commonPlay => '播放';

  @override
  String get settingsSpeedTestTimeout => '測速逾時';

  @override
  String get commonSave => '儲存';

  @override
  String get videoShareAsTicket => '分享為分享票';

  @override
  String get shareTicketTitle => '分享票';

  @override
  String get shareTicketPostscript => '分享附言';

  @override
  String get shareTicketPostscriptHint => '寫下你的推薦語';

  @override
  String get shareTicketSave => '儲存圖片';

  @override
  String get shareTicketShare => '系統分享';

  @override
  String get shareTicketLoadFailed => '分享票所需資源載入失敗，請重試';

  @override
  String get shareTicketRetry => '重試';

  @override
  String get shareTicketPublishedAt => '發布';

  @override
  String get shareTicketPlays => '播放';

  @override
  String get shareTicketDanmaku => '彈幕';

  @override
  String get shareTicketLikes => '按讚';

  @override
  String get shareTicketSharer => '分享者';

  @override
  String get shareTicketFrom => '分享來自 ExPiliPlus';

  @override
  String get videoNoteWindowPinned => '筆記視窗已置頂';

  @override
  String get videoNoteWindowOpened => '已在新視窗開啟筆記';

  @override
  String get settingsEnableDocProvider => '允許第三方 APP 存取私有儲存空間';

  @override
  String get settingsEnableDocProviderDescription =>
      '允許第三方 APP 透過外部儲存空間存取應用程式私有檔案';

  @override
  String get settingsEnableEmoteTooltip => '點擊表情顯示 Tooltip';

  @override
  String get settingsEnableEmoteTooltipDescription => '長按或懸停表情時顯示預覽';

  @override
  String get settingsAicuLookupEnabled => '啟用 AICU 評論查詢';

  @override
  String get settingsAicuLookupEnabledDescription => '在評論選單中顯示 AICU 查詢入口';

  @override
  String get settingsAicuProbe => 'AICU 服務狀態';

  @override
  String get aicuProbeNotChecked => '尚未檢查，點擊以檢查';

  @override
  String get aicuProbeChecking => '正在檢查 AICU 服務…';

  @override
  String get aicuProbeReachable => '服務回應正常';

  @override
  String get aicuProbeLimited => '服務可達，但本次探測受限';

  @override
  String get aicuProbeUnavailable => '目前網路無法連線服務';

  @override
  String get aicuProbeTimedOut => '服務探測逾時';

  @override
  String get aicuProbeUnexpectedResponse => '服務傳回非預期回應';

  @override
  String get aicuLookup => '在 AICU 中查詢';

  @override
  String get aicuLookupTitle => 'AICU 評論查詢';

  @override
  String get aicuThirdPartyNotice =>
      '第三方網站頁面，可能顯示廣告並使用分析服務。查詢不會附帶 B 站登入憑據。';

  @override
  String get aicuLookupLoadFailed => 'AICU 頁面載入失敗，請檢查網路或重試。';

  @override
  String get aicuWebViewUnsupported => '此平台不支援應用程式內網頁，請選擇外部瀏覽器開啟。';

  @override
  String get aicuOpenInBrowser => '在瀏覽器中開啟';

  @override
  String get aicuExternalLinkBlocked => '應用程式內僅允許開啟安全的 AICU 頁面。';

  @override
  String get aicuOpenExternal => '在外部開啟連結';

  @override
  String get aicuInvalidTarget => '沒有有效的評論使用者 UID。';
}
