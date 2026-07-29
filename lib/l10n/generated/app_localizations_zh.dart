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

  @override
  String get settingsOpenOnboarding => '重新打开欢迎引导';

  @override
  String get settingsOpenOnboardingDescription => '再次查看语言、主题和数据迁移引导，不会清除现有设置';

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
    return '$title\nUploader：$uploader\n$url';
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
    return '确定拉黑 $name（$id）？\n\n被拉黑的 Uploader 可在隐私设置的黑名单管理中解除。';
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
  String feedBlockAuthorPosts(String name) {
    return '屏蔽 $name 的动态';
  }

  @override
  String feedAuthorPostsBlocked(String name, String id) {
    return '已屏蔽 $name（$id）的动态';
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
  String get followActionFollowing => '已关注';

  @override
  String followSharedWithUser(String name) {
    return '我与 $name 的共同关注';
  }

  @override
  String get settingsSignInRequired => '登录后查看';

  @override
  String get settingsBlockedUsersManagement => '黑名单管理';

  @override
  String get settingsBlockedUsersDescription => '已拉黑用户';

  @override
  String get settingsAccountModeDetails => '账号模式详情';

  @override
  String get settingsLearnAccountModes => '了解账号模式';

  @override
  String get settingsAccountModesApiDescription => '查看各个账号模式所使用的 API 列表';

  @override
  String get settingsAccountModeMain => '主账号';

  @override
  String get settingsAccountModeWatchHistory => '记录观看';

  @override
  String get settingsAccountModeRecommendation => '推荐';

  @override
  String get settingsAccountModeVideoStream => '视频取流';

  @override
  String get settingsUseAppRecommendations => '首页使用 App 端推荐';

  @override
  String get settingsUseAppRecommendationsDescription =>
      '若 Web 端推荐不太符合预期，可尝试切换至 App 端推荐';

  @override
  String get settingsKeepPreviousRecommendations => '保留首页推荐刷新';

  @override
  String get settingsKeepPreviousRecommendationsDescription => '下拉刷新时保留上次内容';

  @override
  String get settingsShowLastPosition => '显示上次看到位置提示';

  @override
  String get settingsShowLastPositionDescription => '保留上次推荐时，在上次刷新位置显示提示';

  @override
  String get settingsLikeRatio => '点赞率';

  @override
  String get settingsTitleKeywordFilter => '标题关键词过滤';

  @override
  String get settingsCategoryKeywordFilter => 'App 推荐／热门／排行榜：视频分区关键词过滤';

  @override
  String get settingsVideoDuration => '视频时长';

  @override
  String get settingsPlayCount => '播放量';

  @override
  String get settingsExemptFollowedUploaders => '已关注 UP 豁免推荐过滤';

  @override
  String get settingsExemptFollowedUploadersDescription => '推荐中已关注用户发布的内容不会被过滤';

  @override
  String get settingsApplyFilterToRelatedVideos => '过滤器也应用于详情页相关视频';

  @override
  String get settingsApplyFilterToRelatedVideosDescription =>
      '热门视频、搜索等其它页面不受过滤器影响；相关视频中的已关注 UP 无法豁免';

  @override
  String get settingsTapToAdd => '点击添加';

  @override
  String get settingsKeywordSeparatorHelp => '使用 | 隔开，例如：尝试|测试';

  @override
  String get settingsSaved => '已保存';

  @override
  String settingsFilterTitle(String title) {
    return '$title过滤';
  }

  @override
  String settingsFilterBelow(String title, int value, String suffix) {
    return '过滤掉$title小于「$value$suffix」的视频';
  }

  @override
  String settingsCurrentNamedValue(String title, int value, String suffix) {
    return '当前$title：「$value$suffix」';
  }

  @override
  String settingsChooseFilterValue(String title, String filterHint) {
    return '选择$title$filterHint';
  }

  @override
  String get settingsZeroDisablesFilter => '（0 即不过滤）';

  @override
  String get settingsCustomValue => '自定义';

  @override
  String settingsCustomNamedValue(String title) {
    return '自定义$title';
  }

  @override
  String get settingsChooseAccountsToSignOut => '选择要登出的账号 UID';

  @override
  String settingsConfirmSignOutAccounts(String accounts) {
    return '确认要退出以下账号登录吗？\n\n$accounts';
  }

  @override
  String get settingsSignOutCancel => '点错了';

  @override
  String get settingsSignOutOnly => '仅登出';

  @override
  String get settingsDanmakuEnabled => '弹幕开关';

  @override
  String get settingsDanmakuEnabledDescription => '是否展示弹幕';

  @override
  String get settingsTapDanmaku => '启用点击弹幕';

  @override
  String get settingsTapDanmakuDescription => '点击弹幕悬停，支持点赞、复制、举报操作';

  @override
  String get settingsPlaybackSpeed => '倍速设置';

  @override
  String get settingsPlaybackSpeedDescription => '设置视频播放速度';

  @override
  String get settingsTiltAngleThreshold => '倾斜角度阈值';

  @override
  String get settingsAutoplay => '自动播放';

  @override
  String get settingsAutoplayDescription => '进入详情页自动播放';

  @override
  String get settingsFullscreenLockButton => '全屏显示锁定按钮';

  @override
  String get settingsFullscreenScreenshotButton => '全屏显示截图按钮';

  @override
  String get settingsFullscreenBattery => '全屏显示电池电量';

  @override
  String get settingsDoubleTapSeek => '双击快退／快进';

  @override
  String get settingsDoubleTapSeekDescription => '左侧双击快退，右侧双击快进；关闭后双击均为暂停／播放';

  @override
  String get settingsSlideBrightnessVolume => '左右侧滑动调节亮度／音量';

  @override
  String get settingsSystemBrightness => '调节系统亮度';

  @override
  String get settingsSlideFullscreen => '中间滑动进入／退出全屏';

  @override
  String get settingsPlayerVolume => '播放器音量';

  @override
  String get settingsMaximumVolume => '最高音量';

  @override
  String get settingsDoubleTapSeekDuration => '双击快进／快退时长';

  @override
  String get settingsRelativeSlideSeek => '滑动快进／快退使用相对时长';

  @override
  String get settingsSlideSeekDuration => '滑动快进／快退时长';

  @override
  String get settingsSlideSeekDurationDescription => '从播放器一端滑到另一端的快进／快退时长';

  @override
  String get settingsAutomaticSubtitles => '自动启用字幕';

  @override
  String settingsCurrentPreference(String value) {
    return '当前选择偏好：$value';
  }

  @override
  String get settingsPauseWhenMinimized => '最小化时暂停／还原时播放';

  @override
  String get settingsKeyboardControls => '启用键盘控制';

  @override
  String get settingsSuperChatDisplay => 'SuperChat（醒目留言）显示类型';

  @override
  String get settingsFullscreenSuperChatSize => '全屏 SC 大小';

  @override
  String get settingsFullscreenSuperChatSizeDescription =>
      'SuperChat（醒目留言）大小设置';

  @override
  String get settingsExpandPortraitVideo => '竖屏扩大展示';

  @override
  String get settingsExpandPortraitVideoDescription =>
      '小屏竖屏视频宽高比由 16:9 扩大至 1:1（不支持收起）；横屏适配时扩大至 9:16';

  @override
  String get settingsAutoEnterFullscreen => '自动全屏';

  @override
  String get settingsAutoEnterFullscreenDescription => '视频开始播放时进入全屏';

  @override
  String get settingsAutoExitFullscreen => '自动退出全屏';

  @override
  String get settingsAutoExitFullscreenDescription => '视频结束播放时退出全屏';

  @override
  String get settingsExtendPlayerControls => '延长播放控件显示时间';

  @override
  String get settingsExtendPlayerControlsDescription =>
      '开启后延长至 30 秒，便于屏幕阅读器滑动切换控件焦点';

  @override
  String get settingsBackgroundPlayback => '后台播放';

  @override
  String get settingsBackgroundPlaybackDescription => '进入后台时继续播放';

  @override
  String get settingsBackgroundPictureInPicture => '后台画中画';

  @override
  String get settingsBackgroundPictureInPictureDescription =>
      '进入后台时以小窗形式（PiP）播放';

  @override
  String get settingsEnableBackgroundAudioSuggestion => '建议开启后台音频服务';

  @override
  String get settingsHideDanmakuInPictureInPicture => '画中画不加载弹幕';

  @override
  String get settingsHideDanmakuInPictureInPictureDescription =>
      '小窗播放时屏蔽弹幕以获得更好的体验';

  @override
  String get settingsReverseFullscreenGesture => '全屏手势反向';

  @override
  String get settingsReverseFullscreenGestureDescription =>
      '默认向上滑动进入全屏、向下退出；开启后方向相反';

  @override
  String get settingsFullscreenActionButtons => '全屏展示点赞、投币、收藏等操作按钮';

  @override
  String get settingsOnlineViewerCount => '观看人数';

  @override
  String get settingsOnlineViewerCountDescription => '展示同时在看人数';

  @override
  String get settingsDefaultFullscreenOrientation => '默认全屏方向';

  @override
  String settingsCurrentFullscreenOrientation(String value) {
    return '当前全屏方向：$value';
  }

  @override
  String get settingsBottomProgressBar => '底部进度条展示';

  @override
  String settingsCurrentBottomProgressBar(String value) {
    return '当前展示方式：$value';
  }

  @override
  String get settingsBackgroundAudioService => '后台音频服务';

  @override
  String get settingsBackgroundAudioServiceDescription => '避免画中画没有播放暂停功能';

  @override
  String get settingsPlaybackOrder => '播放顺序';

  @override
  String get settingsTemporaryPlayerSettings => '播放器设置仅对当前生效';

  @override
  String get settingsTemporaryPlayerSettingsDescription => '弹幕、字幕及部分设置中没有的设置除外';

  @override
  String get settingsSubtitlePreference => '字幕选择偏好';

  @override
  String get settingsSubtitlePreferenceOff => '默认不显示字幕';

  @override
  String get settingsSubtitlePreferencePreferHuman => '优先选择非自动生成（AI）字幕';

  @override
  String get settingsSubtitlePreferenceSkipAi => '跳过自动生成（AI）字幕，选择第一个可用字幕';

  @override
  String get settingsSubtitlePreferenceAuto => '静音时优先非自动字幕，非静音时跳过自动字幕';

  @override
  String get settingsSuperChatValidOnly => '有效时间内显示';

  @override
  String get settingsSuperChatPersistent => '常驻显示';

  @override
  String get settingsSuperChatDisabled => '不显示';

  @override
  String get settingsFullscreenOrientationAuto => '按视频方向（默认）';

  @override
  String get settingsFullscreenOrientationUnchanged => '不改变当前方向';

  @override
  String get settingsFullscreenOrientationPortrait => '强制竖屏';

  @override
  String get settingsFullscreenOrientationLandscape => '强制横屏';

  @override
  String settingsFullscreenOrientationRatio(double ratio) {
    return '屏幕长宽比小于 $ratio 或为竖屏视频时竖屏，否则横屏';
  }

  @override
  String get settingsFullscreenOrientationGravity =>
      '忽略系统方向锁定，强制按重力转屏（仅 Android）';

  @override
  String get settingsProgressAlwaysShow => '始终展示';

  @override
  String get settingsProgressAlwaysHide => '始终隐藏';

  @override
  String get settingsProgressFullscreenOnly => '仅全屏时展示';

  @override
  String get settingsProgressHideFullscreen => '仅全屏时隐藏';

  @override
  String get settingsHardwareDecoding => '开启硬解';

  @override
  String get settingsHardwareDecodingDescription => '以较低功耗播放视频，若异常卡死请关闭';

  @override
  String get settingsGuest1080p => '免登录 1080P';

  @override
  String get settingsGuest1080pDescription => '未登录时也尝试播放 1080P 视频';

  @override
  String get settingsBilibiliDataPlan => 'B 站定向流量支持';

  @override
  String get settingsBilibiliDataPlanDescription =>
      '若套餐含 B 站定向流量则会自动使用，可查阅运营商的流量记录确认';

  @override
  String get settingsCdn => 'CDN 设置';

  @override
  String settingsCurrentCdn(String value) {
    return '当前使用：$value。部分 CDN 可能失效，如无法播放请尝试切换';
  }

  @override
  String get settingsLiveCdn => '直播 CDN 设置';

  @override
  String settingsCurrentSource(String value) {
    return '当前使用：$value';
  }

  @override
  String get settingsCdnSpeedTest => 'CDN 测速';

  @override
  String get settingsCdnSpeedTestDescription => '测速通过模拟加载视频实现，请注意流量消耗，结果仅供参考';

  @override
  String get settingsSeparateAudioCdn => '音频不跟随 CDN 设置';

  @override
  String get settingsSeparateAudioCdnDescription => '直接采用备用 URL，可解决部分视频无声';

  @override
  String get settingsDefaultVideoQuality => '默认画质';

  @override
  String get settingsCellularVideoQuality => '蜂窝网络画质';

  @override
  String get settingsDefaultAudioQuality => '默认音质';

  @override
  String get settingsCellularAudioQuality => '蜂窝网络音质';

  @override
  String get settingsDefaultLiveQuality => '直播默认画质';

  @override
  String get settingsCellularLiveQuality => '蜂窝网络直播默认画质';

  @override
  String settingsCurrentVideoQuality(String value) {
    return '当前画质：$value';
  }

  @override
  String settingsCurrentAudioQuality(String value) {
    return '当前音质：$value';
  }

  @override
  String get settingsPreferredCodecs => '首选解码格式';

  @override
  String settingsPreferredCodecsDescription(String value) {
    return '首选解码格式：$value。请根据设备支持情况与需求调整';
  }

  @override
  String get settingsAudioOutput => '音频输出设备';

  @override
  String get settingsBufferSize => '缓冲大小';

  @override
  String settingsBufferSizeDescription(double value) {
    return '当前：$value MB。此值同时作为前向和后向缓冲区大小；直播流会全部用于前向缓冲（mpv：--demuxer-max-bytes、--demuxer-max-back-bytes）';
  }

  @override
  String get settingsBufferDuration => '缓冲时长';

  @override
  String settingsBufferDurationDescription(double value) {
    return '当前：$value 秒。实际缓冲取大小与时长限制中的较小值；直播流不使用此项（mpv：--cache-secs）';
  }

  @override
  String get settingsAutoSync => '自动同步';

  @override
  String settingsAutoSyncDescription(String value) {
    return '当前：$value（mpv：--autosync）';
  }

  @override
  String get settingsVideoSync => '视频同步';

  @override
  String settingsVideoSyncDescription(String value) {
    return '当前：$value（mpv：--video-sync）';
  }

  @override
  String get settingsHardwareDecodingMode => '硬解模式';

  @override
  String settingsHardwareDecodingModeDescription(String value) {
    return '当前：$value（mpv：--hwdec）';
  }

  @override
  String get settingsEnterCdnHost => '输入 CDN Host';

  @override
  String get settingsLiveQualityDolby => '杜比';

  @override
  String get settingsLiveQuality4kOriginal => '4K 原画';

  @override
  String get settingsLiveQuality4k => '4K';

  @override
  String get settingsLiveQuality2k => '2K';

  @override
  String get settingsLiveQualityOriginal => '原画';

  @override
  String get settingsLiveQualityBluRay => '蓝光';

  @override
  String get settingsLiveQualitySuperHd => '超清';

  @override
  String get settingsLiveQualityHd => '高清';

  @override
  String get settingsLiveQualitySmooth => '流畅';

  @override
  String get settingsHwdecSoftware => '启用软解';

  @override
  String get settingsHwdecAny => '启用任意可用解码器';

  @override
  String get settingsHwdecBest => '启用最佳解码器';

  @override
  String get settingsHwdecBestCopy => '启用带拷贝功能的最佳解码器';

  @override
  String get settingsHwdecNonDirect => '非直通';

  @override
  String settingsHwdecExclusive(String vendor) {
    return '$vendor 独占';
  }

  @override
  String get settingsHwdecExperimental => '实验性';

  @override
  String get settingsHwdecDeprecated => '已过时';

  @override
  String get settingsHwdecAllPlatforms => '全平台';

  @override
  String get settingsHwdecPartialRockchip => '仅部分 Rockchip 芯片';

  @override
  String get settingsWindowTitleBar => '显示窗口标题栏';

  @override
  String get settingsTrayIcon => '显示托盘图标';

  @override
  String get settingsLandscapeLayout => '横屏适配';

  @override
  String get settingsLandscapeLayoutDescription =>
      '启用横屏布局与逻辑，平板、折叠屏等可开启；建议全屏方向设为“不改变当前方向”';

  @override
  String get settingsUseSidebar => '改用侧边栏';

  @override
  String get settingsUseSidebarDescription => '开启后底栏与顶栏会被替换，相关设置将失效';

  @override
  String get settingsUiScale => '界面缩放';

  @override
  String settingsCurrentUiScale(String value) {
    return '当前缩放比例：$value';
  }

  @override
  String get settingsPageTransition => '页面过渡动画';

  @override
  String get settingsOptimizeTabletNavigation => '优化平板导航栏';

  @override
  String get settingsMaterialYouBottomBar => 'MD3 样式底栏';

  @override
  String get settingsMaterialYouBottomBarDescription =>
      'Material You 设计规范底栏，关闭后可变窄';

  @override
  String get settingsFloatingBottomBar => '悬浮底栏';

  @override
  String get settingsListWidthLimit => '列表宽度（dp）限制';

  @override
  String settingsListWidthDescription(int home, int other, String screen) {
    return '当前：主页 $home dp，其他 $other dp，屏幕宽度 $screen dp。宽度越小，列数越多。';
  }

  @override
  String get settingsRemovePlayerSafeArea => '播放页移除安全边距';

  @override
  String get settingsDarkVideoPage => '视频播放页使用深色主题';

  @override
  String get settingsFeedWaterfall => 'Feed 启用瀑布流';

  @override
  String get settingsFeedWaterfallDescription => '关闭后显示为单列';

  @override
  String get settingsFeedUploaderPosition => 'Feed Uploader 显示位置';

  @override
  String get settingsShowAllFollowedUploaders => 'Feed 显示所有已关注 Uploader';

  @override
  String get settingsExpandLiveUploaders => 'Feed 展开正在直播的 Uploader 列表';

  @override
  String get settingsFeedUnreadBadge => 'Feed 未读标记';

  @override
  String get settingsMessageUnreadBadge => '消息未读标记';

  @override
  String settingsCurrentBadgeStyle(String value) {
    return '当前标记样式：$value';
  }

  @override
  String get settingsMessageUnreadTypes => '消息未读类型';

  @override
  String settingsCurrentMessageTypes(String value) {
    return '当前消息类型：$value';
  }

  @override
  String get settingsBarCollapseBehavior => '顶／底栏收起类型';

  @override
  String get settingsCollapseHomeTopBar => '首页顶栏收起';

  @override
  String get settingsCollapseHomeTopBarDescription => '首页列表滑动时收起顶栏';

  @override
  String get settingsCollapseHomeBottomBar => '首页底栏收起';

  @override
  String get settingsCollapseHomeBottomBarDescription => '首页列表滑动时收起底栏';

  @override
  String get settingsImageQuality => '图片质量';

  @override
  String get settingsImagePreviewQuality => '查看大图质量';

  @override
  String get settingsImageQualityDescription => '选择合适的图片清晰度，上限 100%';

  @override
  String get settingsDarkImageOverlay => '深色下图片颜色叠加';

  @override
  String get settingsDarkImageOverlayDescription => '显示颜色＝图片原色 × 所选颜色；大图查看不受影响';

  @override
  String get settingsToastOpacity => '气泡提示不透明度';

  @override
  String get settingsToastOpacityDescription => '自定义气泡提示（Toast）不透明度';

  @override
  String get settingsThemeMode => '主题模式';

  @override
  String settingsCurrentMode(String value) {
    return '当前模式：$value';
  }

  @override
  String get settingsPureBlackTheme => '纯黑主题';

  @override
  String get settingsAppTheme => '应用主题';

  @override
  String settingsCurrentTheme(String value) {
    return '当前主题：$value';
  }

  @override
  String get settingsDynamicColor => '动态取色';

  @override
  String get settingsExPiliPlusCustomColor => 'ExPiliPlus 自定义颜色';

  @override
  String get settingsSpecifiedColor => '指定颜色';

  @override
  String get settingsDefaultStartPage => '默认启动页';

  @override
  String settingsCurrentStartPage(String value) {
    return '当前启动页：$value';
  }

  @override
  String get settingsSpringParameters => '滑动动画弹簧参数';

  @override
  String get settingsFontSize => '字体大小';

  @override
  String get settingsHomeTabs => '首页标签页';

  @override
  String get settingsHomeTabsDescription => '删除或调换首页标签页';

  @override
  String get settingsNavigationBarEditor => 'Navbar 编辑';

  @override
  String get settingsNavigationBarEditorDescription => '删除或调换 Navbar';

  @override
  String get settingsExitDirectlyOnBack => '返回时直接退出';

  @override
  String get settingsExitDirectlyOnBackDescription =>
      '开启后，在主页任意标签页按返回键都会直接退出；关闭后先回到 Navbar 的第一个标签页';

  @override
  String get settingsScreenRefreshRate => '屏幕帧率';

  @override
  String get settingsSucceeded => '设置成功';

  @override
  String get settingsRestartRequired => '重启生效';

  @override
  String get settingsSucceededRestartRequired => '设置成功，重启生效';

  @override
  String get settingsReset => '重置';

  @override
  String get settingsResetSucceededRestartRequired => '重置成功，重启生效';

  @override
  String get settingsScaleRatio => '缩放比例';

  @override
  String get settingsSpringParametersTitle => '弹簧参数';

  @override
  String get settingsSpringDurationMode => '滑动时间';

  @override
  String get settingsSpringPhysicalMode => '物理参数';

  @override
  String get settingsListMaxColumnWidth => '列表最大列宽度（默认 240 dp）';

  @override
  String get settingsHomeRecommendationFeed => '主页推荐流';

  @override
  String settingsConfirmDarkColor(String color) {
    return '确认使用 $color？';
  }

  @override
  String get settingsDarkColorWarning => '所选颜色过于昏暗，可能会影响图片观看';

  @override
  String get settingsUseServerSideDecoration =>
      '使用 SSD（Server-Side Decoration）';

  @override
  String get settingsUpPositionTop => '顶部';

  @override
  String get settingsUpPositionLeftFixed => '左侧常驻';

  @override
  String get settingsUpPositionRightFixed => '右侧常驻';

  @override
  String get settingsUpPositionLeftDrawer => '左侧抽屉';

  @override
  String get settingsUpPositionRightDrawer => '右侧抽屉';

  @override
  String get settingsBadgeHidden => '隐藏';

  @override
  String get settingsBadgeDot => '红点';

  @override
  String get settingsBadgeNumber => '数字';

  @override
  String get settingsUnreadPrivateMessages => '私信';

  @override
  String get settingsUnreadReplies => '回复我的';

  @override
  String get settingsUnreadMentions => '@我';

  @override
  String get settingsUnreadLikes => '收到的赞';

  @override
  String get settingsUnreadSystem => '系统通知';

  @override
  String get settingsBarCollapseInstant => '即时';

  @override
  String get settingsBarCollapseSynchronized => '同步';

  @override
  String get settingsMinimizeOnExit => '退出时最小化';

  @override
  String get settingsCachePath => '缓存路径';

  @override
  String get settingsSponsorBlock => '空降助手';

  @override
  String get settingsAnimeIntroOutroSkip => '番剧片头／片尾跳过类型';

  @override
  String get settingsCheckUnreadFeed => '检查未读 Feed';

  @override
  String get settingsCheckUnreadFeedDescription => '点击设置检查周期（分钟）';

  @override
  String get settingsVideoChapters => '显示视频分段信息';

  @override
  String get settingsRelatedVideos => '视频页显示相关视频';

  @override
  String get settingsVideoComments => '显示视频评论';

  @override
  String get settingsAnimeComments => '显示番剧评论';

  @override
  String get settingsExpandVideoDescription => '默认展开视频简介';

  @override
  String get settingsExpandVideoDescriptionLandscape => '横屏自动展开视频简介';

  @override
  String get settingsLandscapeEpisodeTabs => '横屏分 P／合集列表显示在 Tab 栏';

  @override
  String get settingsLandscapeUploaderSidebar => '横屏播放页在侧栏打开 Uploader 主页';

  @override
  String get settingsLandscapeImagePreview => '横屏在侧栏打开图片预览';

  @override
  String get settingsCommentFoldLines => '评论折叠行数';

  @override
  String get settingsZeroLinesDoNotFold => '0 行时不折叠';

  @override
  String settingsLineCount(String count) {
    return '$count 行';
  }

  @override
  String get settingsDanmakuLineHeight => '弹幕行高';

  @override
  String settingsDefaultNumber(String value) {
    return '默认 $value';
  }

  @override
  String get settingsVideoWarnings => '显示视频警告／争议信息';

  @override
  String get settingsFeedWarnings => '显示 Feed 警告／争议信息';

  @override
  String get settingsReverseEpisodesFromFirst => '分 P／合集：倒序播放从首集开始';

  @override
  String get settingsReverseEpisodesFromFirstDescription =>
      '开启后自动切换到倒序首集，否则保持当前集';

  @override
  String get settingsDisableSslVerification => '禁用 SSL 证书验证';

  @override
  String get settingsDisableSslVerificationDescription => '请谨慎开启，禁用后容易受到中间人攻击';

  @override
  String get settingsContinuePartPrompt => '显示继续播放分 P 提示';

  @override
  String get settingsCommentKeywordFilter => '评论关键词过滤';

  @override
  String get settingsFeedKeywordFilter => 'Feed 关键词过滤';

  @override
  String get settingsExternalBrowser => '使用外部浏览器打开链接';

  @override
  String get settingsHorizontalSwipeThreshold => '横向滑动阈值';

  @override
  String settingsCurrentAndSystemDefault(String current, String defaultValue) {
    return '当前：$current；系统默认值：$defaultValue';
  }

  @override
  String get settingsRefreshDragDistance => '刷新滑动距离';

  @override
  String settingsCurrentMultiplier(String value) {
    return '当前：$value×';
  }

  @override
  String get settingsRefreshIndicatorHeight => '刷新指示器高度';

  @override
  String get settingsVipDanmaku => '显示会员彩色弹幕';

  @override
  String get settingsMergeDanmaku => '合并弹幕';

  @override
  String get settingsMergeDanmakuDescription => '合并一段时间内获取到的相同弹幕';

  @override
  String get settingsTrendingRecommendations => '显示热门推荐';

  @override
  String get settingsTrendingRecommendationsDescription => '热门页面显示每周必看等推荐内容入口';

  @override
  String get settingsAudioNormalization => '音量均衡';

  @override
  String get settingsFallbackNormalization => '服务器无 loudnorm 配置时使用';

  @override
  String settingsFallbackValue(String value) {
    return '无参数时：$value';
  }

  @override
  String get settingsAudioNormalizationDisabled => '禁用';

  @override
  String get settingsAudioNormalizationDynaudnorm => '预设 dynaudnorm';

  @override
  String get settingsAudioNormalizationLoudnorm => '预设 loudnorm';

  @override
  String get settingsCustomParameters => '自定义参数';

  @override
  String get settingsAudioNormalizationParameterHelp =>
      '等同于 --lavfi-complex=\"[aid1] 参数 [ao]\"';

  @override
  String get settingsSuperResolution => '超分辨率';

  @override
  String settingsSuperResolutionDescription(String value) {
    return '当前：$value\n默认设置对番剧生效，其它视频默认关闭\n超分辨率需要启用硬件解码；若仍未生效，请尝试将硬件解码器切换为 auto-copy';
  }

  @override
  String get settingsPreinitializePlayer => '提前初始化播放器';

  @override
  String get settingsPreinitializePlayerDescription => '相对减少手动播放的加载时间';

  @override
  String get settingsHomePageAnimation => '首页切换页面动画';

  @override
  String get settingsSearchSuggestions => '搜索建议';

  @override
  String get settingsSearchHistory => '记录搜索历史';

  @override
  String get settingsShowDecorations => '展示头像、评论和 Feed 装饰';

  @override
  String get settingsFanMedals => '显示粉丝勋章';

  @override
  String get settingsLivePhotoPreview => '预览 Live Photo';

  @override
  String get settingsLivePhotoPreviewDescription =>
      '开启后以视频形式预览 Live Photo，否则预览静态图片';

  @override
  String get settingsSeekPreviewThumbnails => '滑动跳转预览视频缩略图';

  @override
  String get settingsDanmakuHeatmap => '显示高能进度条';

  @override
  String get settingsDanmakuHeatmapDescription => '高能进度条反映单位时间内弹幕发送量的变化趋势';

  @override
  String get settingsSaveComments => '记录评论';

  @override
  String get settingsCommentAntifraud => '发评反诈';

  @override
  String get settingsCommentAntifraudDescription => '发送评论后检查评论是否可见';

  @override
  String get settingsUseBilibiliCommentCheck => '使用“哔哩发评反诈”检查评论';

  @override
  String get settingsFeedPostAntifraud => '发布／转发 Feed 反诈';

  @override
  String get settingsFeedPostAntifraudDescription => '发布／转发后检查 Feed 内容是否可见';

  @override
  String get settingsBlockShoppingPosts => '屏蔽带货 Feed';

  @override
  String get settingsBlockShoppingComments => '屏蔽带货评论';

  @override
  String get settingsSwipeToCloseSecondaryPages => '侧滑关闭二级页面';

  @override
  String get settingsPinchToShrinkVideo => '启用双指缩小视频';

  @override
  String get settingsSecondaryPageActionBar => 'Feed／专栏详情页展示底部操作栏';

  @override
  String get settingsDragSubtitles => '启用拖拽字幕调整底部边距';

  @override
  String get settingsAnimeSchedule => '展示追番时间表';

  @override
  String get settingsSilentImageDownload => '静默下载图片';

  @override
  String get settingsSilentImageDownloadDescription => '不显示下载 Loading 弹窗';

  @override
  String get settingsImageContextMenu => '长按／右键显示图片菜单';

  @override
  String get settingsHapticFeedback => '振动反馈';

  @override
  String get settingsHapticFeedbackDescription => '请确认手机系统设置中已开启振动反馈';

  @override
  String get settingsTrendingSearches => '大家都在搜';

  @override
  String get settingsTrendingSearchesDescription => '展示“大家都在搜”';

  @override
  String get settingsSearchDiscovery => '搜索发现';

  @override
  String get settingsSearchDiscoveryDescription => '展示“搜索发现”';

  @override
  String get settingsDefaultSearchTerm => '搜索默认词';

  @override
  String get settingsDefaultSearchTermDescription => '在搜索框中展示默认词';

  @override
  String get settingsQuickFavorite => '快速收藏';

  @override
  String get settingsQuickFavoriteDescription =>
      '点击设置默认收藏夹\n点按收藏至默认收藏夹，长按选择文件夹';

  @override
  String get settingsCommentSearchKeywords => '评论区搜索关键词';

  @override
  String get settingsCommentSearchKeywordsDescription => '展示评论区搜索关键词';

  @override
  String get settingsAiSummary => '启用 AI 总结';

  @override
  String get settingsAiSummaryDescription => '在视频详情页开启 AI 总结';

  @override
  String get settingsDisableReceivedLikes => '消息页禁用“收到的赞”';

  @override
  String get settingsDisableReceivedLikesDescription => '禁止打开入口，降低网络社交依赖';

  @override
  String get settingsShowCommentsByDefault => '默认展示评论区';

  @override
  String get settingsShowCommentsByDefaultDescription =>
      '视频详情页默认切换至评论区（仅 Tab 型布局）';

  @override
  String get settingsHttp2 => '启用 HTTP/2';

  @override
  String get settingsRetryCount => '连接重试次数';

  @override
  String get settingsZeroDisables => '设为 0 时禁用';

  @override
  String get settingsRetryDelay => '连接重试间隔';

  @override
  String get settingsRetryDelayDescription => '实际间隔＝间隔 × 第 n 次重试';

  @override
  String get settingsCommentDisplay => '评论展示';

  @override
  String settingsCurrentlyPrioritize(String value) {
    return '当前优先展示“$value”';
  }

  @override
  String get settingsFeedDisplay => 'Feed 展示';

  @override
  String get settingsFeedInteractions => '显示 Feed 互动内容';

  @override
  String get settingsFeedInteractionsDescription =>
      '在 Feed 卡片底部显示互动内容，例如关注的人点赞、热评等';

  @override
  String get settingsMemberDefaultTab => '用户页默认展示 Tab';

  @override
  String get settingsUploaderShopTab => '显示 Uploader 主页小店 Tab';

  @override
  String get settingsProxy => '设置代理';

  @override
  String get settingsProxyDescription => '设置代理 host:port';

  @override
  String get settingsProxyHostHint => '请输入 Host，使用 . 分隔';

  @override
  String get settingsProxyPortHint => '请输入 Port';

  @override
  String get settingsMaximumCacheSize => '最大缓存大小';

  @override
  String settingsCurrentMaximumCacheSize(String value) {
    return '当前最大缓存大小：$value';
  }

  @override
  String get settingsCheckForUpdates => '检查更新';

  @override
  String get settingsCheckForUpdatesDescription => '每次启动时检查是否需要更新';

  @override
  String get settingsSetNewPath => '设置新路径';

  @override
  String get settingsCheckInterval => '检查周期';

  @override
  String get settingsChooseDefaultFavorite => '选择默认收藏夹';

  @override
  String get replySortNewest => '最新评论';

  @override
  String get replySortHottest => '最热评论';

  @override
  String get replySortFeatured => '精选评论';

  @override
  String get replySortNewestShort => '最新';

  @override
  String get replySortHottestShort => '最热';

  @override
  String get replySortFeaturedShort => '精选';

  @override
  String get memberTabDefault => '默认';

  @override
  String get memberTabHome => '主页';

  @override
  String get memberTabFeed => 'Feed';

  @override
  String get memberTabUploads => '投稿';

  @override
  String get memberTabFavorites => '收藏';

  @override
  String get memberTabAnime => '番剧';

  @override
  String get memberTabCourses => '课堂';

  @override
  String get memberTabShop => '小店';

  @override
  String get logsTitle => '日志';

  @override
  String get logsCopied => '复制成功';

  @override
  String get logsCleared => '已清空';

  @override
  String get logsTriggerError => '引发错误';

  @override
  String get logsEnabledRestartRequired => '已开启，重启生效';

  @override
  String get logsDisabledRestartRequired => '已关闭，重启生效';

  @override
  String get logsEnable => '开启日志';

  @override
  String get logsDisable => '关闭日志';

  @override
  String get logsCopy => '复制日志';

  @override
  String get logsErrorFeedback => '错误反馈';

  @override
  String get logsClear => '清空日志';

  @override
  String get logsRelatedInformation => '相关信息';

  @override
  String get logsCollapse => '收起';

  @override
  String get logsExpand => '展开';

  @override
  String get logsDeviceInformation => '设备信息';

  @override
  String get logsAppInformation => '应用信息';

  @override
  String get logsBuildInformation => '编译信息';

  @override
  String logsCopiedTimestamp(String time) {
    return '已将 $time 复制至剪贴板';
  }

  @override
  String get logsErrorDetails => '错误详情';

  @override
  String get logsStackTrace => '堆栈跟踪';

  @override
  String get settingsPlaybackSpeedSetDefault => '设置为默认倍速';

  @override
  String get settingsPlaybackSpeedSetLongPress => '设置为默认长按倍速';

  @override
  String get settingsPlaybackSpeedDelete => '删除该项';

  @override
  String get settingsPlaybackSpeedAdd => '添加倍速';

  @override
  String get settingsPlaybackSpeedCustom => '自定义倍速';

  @override
  String get settingsPlaybackSpeedExists => '该倍速已存在';

  @override
  String get settingsPlaybackSpeedDefaultCannotDelete => '不支持删除默认倍速';

  @override
  String get settingsPlaybackSpeedHint => '点击下方按钮设置默认倍速和长按倍速';

  @override
  String get settingsPlaybackSpeedDefault => '默认倍速';

  @override
  String get settingsPlaybackSpeedDynamicLongPress => '动态长按倍速';

  @override
  String get settingsPlaybackSpeedDynamicLongPressDescription =>
      '根据默认倍速，长按时自动使用双倍速度';

  @override
  String get settingsPlaybackSpeedDefaultLongPress => '默认长按倍速';

  @override
  String get settingsPlaybackSpeedList => '倍速列表';

  @override
  String get settingsAdd => '添加';

  @override
  String get settingsSavedNextLaunch => '保存成功，下次启动时生效';

  @override
  String get settingsResetNextLaunch => '重置成功，下次启动时生效';

  @override
  String settingsEditTitle(String title) {
    return '$title编辑';
  }

  @override
  String get settingsSave => '保存';

  @override
  String get settingsLongPressToReorder => '长按拖动排序';

  @override
  String settingsCurrentFontSize(String value) {
    return '当前字体大小：$value';
  }

  @override
  String get settingsSmall => '小';

  @override
  String get settingsLarge => '大';

  @override
  String get settingsScreenRefreshRateTitle => '屏幕帧率设置';

  @override
  String get settingsRestartIfDisplayModeFails => '没有生效？请尝试重启 App';

  @override
  String get settingsAutomatic => '自动';

  @override
  String get settingsSystemModeMarker => '系统';

  @override
  String get settingsChooseAppTheme => '选择应用主题';

  @override
  String get settingsPaletteStyle => '调色板风格';

  @override
  String get settingsDynamicColorUnsupported => '设备可能不支持动态取色';

  @override
  String settingsUseFont(String font) {
    return '使用 $font';
  }

  @override
  String get settingsViewLicense => '查看许可协议';

  @override
  String get settingsAgreeAndDownload => '同意并下载';

  @override
  String settingsFontDownloaded(String font) {
    return '$font 下载完成';
  }

  @override
  String settingsFontDownloading(int progress) {
    return '正在下载 $progress%';
  }

  @override
  String get settingsFontConnecting => '正在连接下载源';

  @override
  String settingsDownloadedWithSize(String size) {
    return '已下载 · $size';
  }

  @override
  String get settingsDownloaded => '已下载';

  @override
  String get settingsDownloadFont => '下载字体';

  @override
  String get settingsFontErrorIncompleteFile => '字体文件不完整，请重新下载';

  @override
  String get settingsFontErrorLoadFailed => '字体加载失败，请重新下载';

  @override
  String settingsFontErrorHttp(String status) {
    return '字体下载失败（HTTP $status）';
  }

  @override
  String get settingsFontErrorLicenseExtraction => '字体许可文件提取失败，请重试';

  @override
  String get settingsFontErrorDownloadFailed => '字体下载失败，请稍后重试';

  @override
  String get settingsFontErrorSizeMismatch => '字体文件大小校验失败，请重试';

  @override
  String get settingsFontErrorChecksumMismatch => '字体校验失败，请重试';

  @override
  String get settingsFontErrorTimeout => '字体下载连接超时，请检查网络后重试';

  @override
  String get settingsFontErrorNetwork => '无法下载字体，请检查网络';

  @override
  String get settingsFontErrorSaveFailed => '字体文件保存失败，请检查存储空间';

  @override
  String get settingsAppFontTitle => 'App 字体';

  @override
  String get settingsFontLxgwWenKai => '霞鹜文楷';

  @override
  String get settingsFontLxgwZhenKai => '霞鹜臻楷';

  @override
  String get settingsFontLxgwNeoXiHei => '霞鹜新晰黑';

  @override
  String get settingsFontLxgwZhuqueFangsong => '霞鹜朱雀仿宋';

  @override
  String get settingsFontSourceHanSans => '思源黑体';

  @override
  String get settingsFontSourceHanSerif => '思源宋体';

  @override
  String get settingsFontFusionPixel => '缝合像素字体';

  @override
  String settingsFontLicenseNotice(String font) {
    return '本软件将使用 $font。下载和使用即表示你同意其官方许可协议。';
  }

  @override
  String get settingsFullscreenSuperChatSizeTitle => '全屏 SC 大小设置';

  @override
  String get themeColorDefaultGreen => '默认绿';

  @override
  String get themeColorPink => '粉红色';

  @override
  String get themeColorRed => '红色';

  @override
  String get themeColorOrange => '橙色';

  @override
  String get themeColorAmber => '琥珀色';

  @override
  String get themeColorYellow => '黄色';

  @override
  String get themeColorLime => '酸橙色';

  @override
  String get themeColorLightGreen => '浅绿色';

  @override
  String get themeColorGreen => '绿色';

  @override
  String get themeColorTeal => '青色';

  @override
  String get themeColorCyan => '蓝绿色';

  @override
  String get themeColorLightBlue => '浅蓝色';

  @override
  String get themeColorBlue => '蓝色';

  @override
  String get themeColorIndigo => '靛蓝色';

  @override
  String get themeColorPurple => '紫色';

  @override
  String get themeColorDeepPurple => '深紫色';

  @override
  String get themeColorBlueGrey => '蓝灰色';

  @override
  String get themeColorBrown => '棕色';

  @override
  String get themeColorGrey => '灰色';

  @override
  String get commonCopy => '复制';

  @override
  String get homeFollowingAnime => '已追番';

  @override
  String get homeRankings => '排行榜';

  @override
  String get homeWeeklyMustWatch => '每周必看';

  @override
  String get homeEssentialVideos => '入站必刷';

  @override
  String get homeLastSeenRefresh => '上次看到这里\n点击刷新';

  @override
  String get homeSwitchToCover => '切换封面';

  @override
  String get homeSwitchToFirstFrame => '切换首帧';

  @override
  String get homeGameEvents => '游戏赛事';

  @override
  String get homeAllLiveCategories => '全部标签';

  @override
  String get homeMyLiveFollowing => '我的关注';

  @override
  String homeLiveFollowingCount(String count) {
    return '$count 人正在直播';
  }

  @override
  String get aboutAppDescription => '使用 Flutter 开发的 B 站第三方客户端';

  @override
  String get aboutAppSemantics => '与你一起，发现不一样的世界';

  @override
  String get aboutAccessibilityAdapted => '无障碍适配';

  @override
  String get aboutCurrentVersion => '当前版本';

  @override
  String get aboutOpenSupportedLinks => '打开受支持的链接';

  @override
  String get aboutIssueFeedback => '问题反馈';

  @override
  String get aboutErrorLogs => '错误日志';

  @override
  String get aboutClearLogsHint => '长按清除日志';

  @override
  String get aboutClearCacheConfirm => '该操作将清除图片及网络请求缓存数据，确认清除？';

  @override
  String get aboutClearing => '正在清除…';

  @override
  String get aboutClearSucceeded => '清除成功';

  @override
  String get aboutClearCache => '清除缓存';

  @override
  String aboutImageNetworkCache(Object size) {
    return '图片及网络缓存 $size';
  }

  @override
  String get aboutImportExportLogin => '导入/导出登录信息';

  @override
  String get aboutLoginData => '登录信息';

  @override
  String get aboutImportExportSettings => '导入/导出设置';

  @override
  String get aboutSettingsData => '设置';

  @override
  String get aboutResetAllSettings => '重置所有设置';

  @override
  String get aboutResetAllSettingsQuestion => '是否重置所有设置？';

  @override
  String get aboutResetSucceeded => '重置成功';

  @override
  String get aboutResetExportableSettings => '重置可导出的设置';

  @override
  String get aboutResetAllData => '重置所有数据（含登录信息）';

  @override
  String importExportTitle(Object title) {
    return '导入/导出$title';
  }

  @override
  String importConfirmPreview(Object title) {
    return '是否导入如下$title？';
  }

  @override
  String importInputTitle(Object title) {
    return '输入$title';
  }

  @override
  String importJsonParseFailed(Object error) {
    return '解析 JSON 失败：$error';
  }

  @override
  String get importSucceeded => '导入成功';

  @override
  String importFailed(Object error) {
    return '导入失败：$error';
  }

  @override
  String get importClipboardEmpty => '剪贴板无数据';

  @override
  String get exportToClipboard => '导出至剪贴板';

  @override
  String get exportToLocalFile => '导出文件至本地';

  @override
  String get importEnterManually => '输入';

  @override
  String get importFromClipboard => '从剪贴板导入';

  @override
  String get importFromLocalFile => '从本地文件导入';

  @override
  String get memberHomeVideos => '视频';

  @override
  String get memberHomeFavorites => '收藏';

  @override
  String get memberHomeRecentCoinedVideos => '最近投币的视频';

  @override
  String get memberHomeRecentLikedVideos => '最近点赞的视频';

  @override
  String get memberHomePosts => '图文';

  @override
  String get memberHomeAudio => '音频';

  @override
  String get memberHomeComics => '漫画';

  @override
  String get memberHomeAnime => '追番';

  @override
  String blacklistTitle(Object count) {
    return '黑名单管理$count';
  }

  @override
  String blacklistCountSuffix(Object count) {
    return ': $count';
  }

  @override
  String blacklistAddedAt(Object date) {
    return '添加时间：$date';
  }

  @override
  String blacklistRemoveConfirm(Object name) {
    return '确定将 $name 移出黑名单？';
  }

  @override
  String get blacklistRemoved => '移除成功';

  @override
  String get webDavSettingsTitle => 'WebDAV 设置';

  @override
  String get webDavBackupSettings => '备份设置';

  @override
  String get webDavRestoreSettings => '恢复设置';

  @override
  String get webDavConfigurationSucceeded => '配置成功';

  @override
  String webDavConfigurationFailed(Object error) {
    return '配置失败：$error';
  }

  @override
  String webDavBackupConfigurationFailed(Object error) {
    return '备份失败，请检查配置：$error';
  }

  @override
  String get webDavBackupSucceeded => '备份成功';

  @override
  String webDavBackupFailed(Object error) {
    return '备份失败：$error';
  }

  @override
  String get webDavRestoreSucceeded => '恢复成功';

  @override
  String webDavRestoreFailed(Object error) {
    return '恢复失败：$error';
  }

  @override
  String webDavCheckConfiguration(Object error) {
    return '请检查配置：$error';
  }

  @override
  String get webDavBackupNotFound => '未找到备份文件';

  @override
  String get sponsorBlockTitle => '空降助手';

  @override
  String get sponsorBlockMinimumDuration => '最短片段时长';

  @override
  String get sponsorBlockMinimumDurationDescription => '忽略短于此时长的片段';

  @override
  String get sponsorBlockAbout => '关于空降助手';

  @override
  String get sponsorBlockUserId => '用户 ID';

  @override
  String get sponsorBlockUserIdValidation => '用户 ID 要求至少为 30 个字符长度的纯字母数字字符串';

  @override
  String get sponsorBlockRandom => '随机';

  @override
  String get sponsorBlockShowSkipToast => '显示跳过提示';

  @override
  String get sponsorBlockTrackSkips => '跳过次数统计跟踪';

  @override
  String get sponsorBlockTrackSkipsDescription =>
      '此功能会报告您跳过的片段，让提交者知道帮助了多少人；点赞结果也会用于避免垃圾信息污染数据库。每次跳过片段时都会向服务器发送消息，开启后可让统计更准确。';

  @override
  String get sponsorBlockYourInformation => '您的信息';

  @override
  String sponsorBlockUserInformation(
    Object minutes,
    Object segments,
    Object views,
  ) {
    return '您提交了 $segments 个片段\n您的片段已帮助观众 $views 次\n（节省 $minutes 分钟）';
  }

  @override
  String get sponsorBlockServerError => '服务器错误';

  @override
  String get sponsorBlockServerAddress => '服务器地址';

  @override
  String get sponsorBlockServerStatus => '服务器状态';

  @override
  String get sponsorBlockServerNormal => '正常';

  @override
  String get sponsorBlockServerUnavailable => '错误';

  @override
  String sponsorBlockColorPickerTitle(Object category) {
    return '$category的颜色';
  }

  @override
  String get sponsorBlockDescriptionSponsor => '付费推广、赞助和直接广告，不包含无偿提及。';

  @override
  String get sponsorBlockDescriptionSelfPromotion => '无偿或自我推广，包括商品、捐赠或合作者信息。';

  @override
  String get sponsorBlockDescriptionExclusiveAccess =>
      '标记整个展示免费或优惠获得的产品、服务或场地的视频。';

  @override
  String get sponsorBlockDescriptionInteraction =>
      '简短提醒观众点赞、关注或互动；较长且有实质内容的片段应归为自我推广。';

  @override
  String get sponsorBlockDescriptionHighlight => '大多数观众正在寻找的精彩时刻，例如封面所示的时间点。';

  @override
  String get sponsorBlockDescriptionIntro => '没有实际内容的过场或片头，例如暂停、静止画面或重复动画。';

  @override
  String get sponsorBlockDescriptionOutro => '没有额外内容的片尾或鸣谢画面。';

  @override
  String get sponsorBlockDescriptionPreview => '本片或同系列稍后会再次出现内容的回顾或预览。';

  @override
  String get sponsorBlockDescriptionPadding => '搬运内容前后无实质意义、与主体无关的空白或填充画面。';

  @override
  String get sponsorBlockDescriptionFiller => '理解主要内容不需要的离题闲聊或玩笑；这是一个较激进的分类。';

  @override
  String get sponsorBlockDescriptionMusicOfftopic => '仅限音乐视频：不属于其他分类的非音乐片段。';

  @override
  String get videoCooperation => '合作';

  @override
  String get commonSort => '排序';

  @override
  String get commonMultiSelect => '多选';

  @override
  String get commonUpdate => '更新';

  @override
  String get commonUpdateSucceeded => '更新成功';

  @override
  String get commonUpdateFailed => '更新失败';

  @override
  String get commonMove => '移动';

  @override
  String get commonPlayAll => '播放全部';

  @override
  String get favoriteTitle => '我的收藏';

  @override
  String get favoriteNewFolder => '新建收藏夹';

  @override
  String get favoriteFolderSort => '收藏夹排序';

  @override
  String get favoriteLoadAllBeforeSorting => '加载全部收藏夹再排序';

  @override
  String get favoriteTabVideos => '视频';

  @override
  String get favoriteTabAnime => '追番';

  @override
  String get favoriteTabSeries => '追剧';

  @override
  String get favoriteTabArticles => '专栏';

  @override
  String get favoriteTabNotes => '笔记';

  @override
  String get favoriteTabTopics => '话题';

  @override
  String get favoriteTabCourses => '课堂';

  @override
  String get laterAll => '全部';

  @override
  String get laterUnfinished => '未看完';

  @override
  String get laterRecentlyAdded => '最近添加';

  @override
  String get laterEarliestAdded => '最早添加';

  @override
  String get laterClearInvalid => '清空失效';

  @override
  String get laterClearWatched => '清空看完';

  @override
  String get laterClearAll => '清空全部';

  @override
  String get historyAll => '全部';

  @override
  String get historyTitle => '观看记录';

  @override
  String get historyPause => '暂停观看记录';

  @override
  String get historyResume => '恢复观看记录';

  @override
  String get historyClear => '清空观看记录';

  @override
  String get historyDeleteWatched => '删除已看记录';

  @override
  String get historyDisabled => ' 历史记录功能已关闭';

  @override
  String get historyTapToEnable => '点击开启';

  @override
  String get downloadOfflineTitle => '离线缓存';

  @override
  String downloadDownloadingCount(Object count) {
    return '正在缓存（$count）';
  }

  @override
  String get downloadDownloadedVideos => '已缓存视频';

  @override
  String downloadVideoCount(Object count) {
    return '$count 个视频';
  }

  @override
  String get downloadCourse => '课程';

  @override
  String get downloadAnime => '番剧';

  @override
  String get downloadMovie => '电影';

  @override
  String get downloadDocumentary => '纪录片';

  @override
  String get downloadChineseAnimation => '国创';

  @override
  String get downloadTvSeries => '电视剧';

  @override
  String get downloadVarietyShow => '综艺';

  @override
  String get downloadConfirmDelete => '确定删除？';

  @override
  String get downloadUpdateDanmaku => '更新弹幕';

  @override
  String get messagesTitle => '消息';

  @override
  String get messagesNewFollowers => '新增粉丝';

  @override
  String get messagesRepliesToMe => '回复我的';

  @override
  String get messagesMentions => '@我';

  @override
  String get messagesReceivedLikes => '收到的赞';

  @override
  String get messagesSystemNotifications => '系统通知';

  @override
  String get messagesMarkedAsRead => '已标为已读';

  @override
  String get messagesMarkAsRead => '标为已读';

  @override
  String get messagesEnableDoNotDisturb => '开启免打扰';

  @override
  String get messagesDisableDoNotDisturb => '关闭免打扰';

  @override
  String get messagesDeleteConversationConfirm => '确定删除该对话？';

  @override
  String get contactsTitle => '通讯录';

  @override
  String get loginDevicesTitle => '登录设备';

  @override
  String get loginDevicesCurrentDevice => '（本机）';

  @override
  String get memberMyFeed => '我的动态';

  @override
  String get memberSpaceSettings => '空间设置';

  @override
  String get messagesLikeDetails => '点赞详情';

  @override
  String get messagesMentionsMe => '@我的';

  @override
  String get messagesDeleteNotificationConfirm => '确定删除该通知？';

  @override
  String messagesMentionedIn(Object business) {
    return ' 在$business中@了我';
  }

  @override
  String get messagesAndOthers => ' 等人';

  @override
  String messagesCommentsOnMyItem(Object business, Object count) {
    return ' 对我的$business发布了$count条评论';
  }

  @override
  String get messagesLatest => '最新';

  @override
  String get messagesTotal => '累计';

  @override
  String get messagesDeleteLikeNoticeConfirm => '该条通知删除后，当有新点赞时会重新出现在列表，是否继续？';

  @override
  String get messagesStopNotifications => '不再通知';

  @override
  String get messagesStopNotificationsConfirm => '这条内容的点赞将不再通知，但仍可在列表内查看，是否继续？';

  @override
  String get messagesReceiveNotifications => '接收通知';

  @override
  String messagesAndPeople(Object count) {
    return ' 等$count人';
  }

  @override
  String messagesLikedMyItem(Object business) {
    return ' 赞了我的$business';
  }

  @override
  String get messagesViewFeed => '查看动态';

  @override
  String get messagesWebLink => '网页链接';

  @override
  String get accountSwitchAnonymousHint => 'mid 为 0 时使用匿名模式';

  @override
  String get accountSwitchDetailed => '详细';

  @override
  String get accountSwitchQuick => '快速';

  @override
  String get accountSignInFirst => '请先登录';

  @override
  String replyIpLocation(Object region) {
    return 'IP 属地：$region';
  }

  @override
  String get videoPersonalOpinionDisclaimer => '个人观点，仅供参考';

  @override
  String videoAllEpisodes(Object count) {
    return '全 $count 话';
  }

  @override
  String get feedPostedVideo => '投稿了视频';

  @override
  String get feedCoCreated => '与他人共同创作';

  @override
  String get feedLikesAndReposts => '赞与转发';

  @override
  String get feedSaySomething => '说点什么吧…';

  @override
  String get feedShareToFeed => '分享至动态';

  @override
  String get feedRepostFeed => '转发动态';

  @override
  String get feedPublishNow => '立即发布';

  @override
  String get feedRepostNow => '立即转发';

  @override
  String get feedPublish => '发布';

  @override
  String get feedRepostSucceeded => '转发成功';

  @override
  String get commonCopied => '已复制';

  @override
  String get commonExport => '导出';

  @override
  String get commonNoData => '没有数据';

  @override
  String get commonTapToRetry => '点击重试';

  @override
  String get watchLaterAdded => '已添加至稍后再看';

  @override
  String get watchLaterRemoved => '已从稍后再看移除';

  @override
  String get myCommentsTitle => '我的评论';

  @override
  String get subscriptionFolder => '收藏夹';

  @override
  String get subscriptionCollection => '合集';

  @override
  String subscriptionOtherType(Object type) {
    return '其它（$type）';
  }

  @override
  String subscriptionUnavailable(Object type) {
    return '该$type已失效';
  }

  @override
  String subscriptionUploader(Object name) {
    return 'UP 主：$name';
  }

  @override
  String subscriptionVideoCount(Object count) {
    return '$count 个视频';
  }

  @override
  String subscriptionTotalVideos(Object count) {
    return '共 $count 个视频';
  }

  @override
  String subscriptionPlayCount(Object count) {
    return '$count 次播放';
  }

  @override
  String get subscriptionCancelConfirm => '确定取消订阅吗？';

  @override
  String get subscriptionCanceled => '取消订阅成功';

  @override
  String get commonSaving => '正在保存…';

  @override
  String get commonSaved => '已保存';

  @override
  String get commonSaveFailed => '保存失败';

  @override
  String commonSaveFailedWithError(Object error) {
    return '保存失败：$error';
  }

  @override
  String get commonSaveCanceled => '取消保存';

  @override
  String get commonDownloadCanceled => '已取消下载';

  @override
  String get commonDownloading => '正在下载…';

  @override
  String get commonDownloadingOriginal => '正在下载原图…';

  @override
  String get commonFileNotFound => '文件不存在';

  @override
  String get permissionStorageRequired => '存储权限未授权';

  @override
  String get permissionOpenSettings => '去授权';

  @override
  String get laterDeleteSelectedConfirm => '确认删除所选稍后再看吗？';

  @override
  String get laterRemoveVideoConfirm => '即将移除该视频，确定是否移除？';

  @override
  String get laterRemoveConfirmed => '确认移除';

  @override
  String get laterClearInvalidConfirm => '确定清空已失效视频吗？';

  @override
  String get laterClearWatchedConfirm => '确定清空已看完视频吗？';

  @override
  String get laterClearAllConfirm => '确定清空稍后再看列表吗？';

  @override
  String get laterCleared => '已清空稍后再看';

  @override
  String get videoPremiumRequired => '需要大会员';

  @override
  String videoSwitchingTo(Object title) {
    return '切换到：$title';
  }

  @override
  String get shareTo => '分享给';

  @override
  String get shareChooseRecipients => '请选择分享的用户';

  @override
  String get shareSucceeded => '分享成功';

  @override
  String get shareFailed => '分享失败';

  @override
  String get sharePartiallyFailed => '部分分享失败';

  @override
  String get followCreateGroup => '新建分组';

  @override
  String get followGroupCreated => '创建成功';

  @override
  String get followSucceeded => '关注成功';

  @override
  String get followAddPriority => '加入特别关注';

  @override
  String get followRemovePriority => '移除特别关注';

  @override
  String get followPriorityAdded => '加入特别关注成功';

  @override
  String get followPriorityRemoved => '移除特别关注成功';

  @override
  String get followSetGroup => '设置分组';

  @override
  String get followUnfollow => '取消关注';

  @override
  String get followUnfollowSucceeded => '取消关注成功';

  @override
  String get commonCopyTo => '复制到';

  @override
  String get commonMoveTo => '移动到';

  @override
  String get commonMoved => '移动成功';

  @override
  String get feedAppeal => '申诉';

  @override
  String get feedCheckResult => '动态检查结果';

  @override
  String get feedCheckPassed => '无账号状态下找到了你的动态，动态正常！';

  @override
  String get feedCheckShadowBanned => '你的动态可能仅自己可见！';

  @override
  String feedPostContent(Object content) {
    return '动态内容：$content';
  }

  @override
  String get commonMissingParameters => '参数为空';

  @override
  String get videoCoinSucceeded => '投币成功';

  @override
  String get historyNoWatchedItems => '无已看记录';

  @override
  String get historyDeleteSelectedConfirm => '确认删除所选历史记录吗？';

  @override
  String get historyClearConfirm => '确定清空观看历史吗？';

  @override
  String get historyCleared => '已清空观看历史';

  @override
  String get historyConfirmClear => '确认清空';

  @override
  String get historyPauseConfirm => '确定暂停观看历史吗？';

  @override
  String get historyResumeConfirm => '确定恢复观看历史吗？';

  @override
  String get historyPaused => '已暂停观看历史';

  @override
  String get historyResumed => '已恢复观看历史';

  @override
  String get historyConfirmPause => '确认暂停';

  @override
  String get historyConfirmResume => '确认恢复';

  @override
  String get commonActionsMenu => '功能菜单';

  @override
  String get commonFavorited => '已收藏';

  @override
  String get liveNotStarted => '直播未开播';

  @override
  String get historyDeleteRecord => '删除记录';

  @override
  String get loginTitle => '登录';

  @override
  String get loginWithQr => '使用 bilibili 官方 App 扫码登录';

  @override
  String loginQrExpiresIn(Object seconds) {
    return '剩余有效时间：$seconds 秒';
  }

  @override
  String get loginRefreshQr => '刷新二维码';

  @override
  String get loginGeneratingScreenshot => '正在生成截图';

  @override
  String get loginSaveToGallery => '保存至相册';

  @override
  String get loginOpenInAnotherApp => '其他应用打开';

  @override
  String get loginQrCopiedHint => '已复制到剪贴板，可粘贴至已登录的 App 私信处发送，然后点击已发送的链接打开。';

  @override
  String loginTrustedSourceNotice(Object appName) {
    return '请务必在 $appName 开源仓库等可信渠道下载安装。';
  }

  @override
  String get loginWithCookie => '使用 Cookie 登录';

  @override
  String get loginCookieLimit => '使用 App 端 API 实现的功能将不可用';

  @override
  String get loginWithPassword => '使用账号密码登录';

  @override
  String get loginAccount => '账号';

  @override
  String get loginEmailOrPhone => '邮箱/手机号';

  @override
  String get loginPassword => '密码';

  @override
  String get loginShowPassword => '显示密码';

  @override
  String get loginForgotPasswordQuestion => '忘记密码？';

  @override
  String get loginForgotPasswordHint => '试试扫码、手机号登录，或选择找回密码页面。';

  @override
  String get loginRecoverPasswordMobile => '找回密码（手机版）';

  @override
  String get loginRecoverPasswordDesktop => '找回密码（电脑版）';

  @override
  String loginPasswordSecurityNotice(Object appName) {
    return '根据 bilibili 官方登录接口规范，密码将在本地加盐、加密后传输。盐与公钥均由官方提供；以 RSA/ECB/PKCS1Padding 方式加密。账号密码仅用于该登录接口，不予保存；本地仅存储登录凭证。\n请务必在 $appName 开源仓库等可信渠道下载安装。';
  }

  @override
  String get loginWithSms => '使用手机短信验证码登录';

  @override
  String loginCountryCodeTooltip(Object code, Object name) {
    return '选择国际冠码，当前为 $name（+$code）';
  }

  @override
  String get loginCountryOrRegion => '国家/地区';

  @override
  String get loginPhoneNumber => '手机号';

  @override
  String get loginVerificationCode => '验证码';

  @override
  String loginWaitSeconds(Object seconds) {
    return '等待 $seconds 秒';
  }

  @override
  String get loginGetVerificationCode => '获取验证码';

  @override
  String loginSmsPrivacyNotice(Object appName) {
    return '手机号仅用于 bilibili 官方发送验证码与登录接口，不予保存；本地仅存储登录凭证。\n请务必在 $appName 开源仓库等可信渠道下载安装。';
  }

  @override
  String get loginPasswordTab => '密码';

  @override
  String get loginSmsTab => '短信';

  @override
  String get loginQrTab => '扫码';

  @override
  String get loginQrExpired => '二维码已过期，请刷新';

  @override
  String get loginQrSucceeded => '扫码成功';

  @override
  String get loginVerificationSucceeded => '验证成功';

  @override
  String get loginCookieRequired => 'Cookie 不能为空';

  @override
  String get loginSucceeded => '登录成功';

  @override
  String loginFailedWithError(Object error) {
    return '登录失败：$error';
  }

  @override
  String get loginSessionExpired => 'bilibili 登录已失效，请重新登录';

  @override
  String get loginUserInfoFailed => '获取 bilibili 用户信息失败，可前往账号管理重试';

  @override
  String get loginCredentialsRequired => '用户名或密码不能为空';

  @override
  String loginNoDataReturned(Object message) {
    return '登录异常，接口未返回数据：$message';
  }

  @override
  String loginTryAnotherMethod(Object details) {
    return '请尝试其他登录方式。\n$details';
  }

  @override
  String get loginPhoneVerificationUnavailable => '当前账号不支持手机号验证，请尝试其他登录方式';

  @override
  String get loginPhoneVerificationRequired => '本次登录需要验证您的手机号';

  @override
  String get loginPhoneUnavailable => '未能获取手机号';

  @override
  String get loginEnterVerificationCode => '请输入短信验证码';

  @override
  String get loginSendVerificationCode => '发送验证码';

  @override
  String get loginVerificationCodeSent => '短信验证码已发送，请查收';

  @override
  String get loginVerifyingAndSigningIn => '验证成功，正在登录';

  @override
  String loginMissingIdentity(Object details) {
    return '登录异常，接口未返回身份信息，可能是因为账号风控，请尝试其他登录方式。\n$details';
  }

  @override
  String get loginSavingIdentity => '正在保存身份信息';

  @override
  String get loginPhoneRequired => '手机号不能为空';

  @override
  String get loginRequestCodeFirst => '请先点击获取验证码';

  @override
  String get loginVerificationCodeRequired => '验证码不能为空';

  @override
  String get loginVerificationCodeExpired => '验证码已过期，请重新获取';

  @override
  String get loginSucceededSetAccountMode => '登录成功，请先设置账号模式';

  @override
  String get commonServerError => '服务器错误';

  @override
  String get networkBadCertificate => '证书无效';

  @override
  String get networkServerError => '服务器异常，请稍后重试';

  @override
  String get networkRequestCancelled => '请求已取消';

  @override
  String get networkConnectionError => '连接错误，请检查网络设置';

  @override
  String get networkConnectionTimeout => '网络连接超时，请检查网络设置';

  @override
  String get networkResponseTimeout => '响应超时，请稍后重试';

  @override
  String get networkSendTimeout => '发送请求超时，请检查网络设置';

  @override
  String get networkTransformTimeout => '转换响应数据超时';

  @override
  String networkUnknownError(String error) {
    return '网络异常：$error';
  }

  @override
  String get searchSecurityCheckTriggered => '触发风控校验';

  @override
  String get loginVerificationTitle => '验证码';

  @override
  String get loginCompleteVerificationWindow => '请在弹出的新窗口中完成验证';

  @override
  String get memberBlockConfirm => '确定拉黑 UP 主吗？';

  @override
  String get memberUnblockConfirm => '从黑名单移除该 UP 主吗？';

  @override
  String get memberNoPlayableVideos => '该 UP 主暂无可播放视频';

  @override
  String get memberVideoPlayInfoUnavailable => '无法获取视频播放信息';

  @override
  String memberRandomVideoFailed(Object error) {
    return '随机视频获取失败：$error';
  }

  @override
  String get memberFollowerRemoved => '移除粉丝成功';

  @override
  String get memberPremiumRewardClaimed => '领取成功';

  @override
  String get memberAddToBlocked => '加入黑名单';

  @override
  String get memberRemoveFromBlocked => '移除黑名单';

  @override
  String get memberRemoveFollower => '移除粉丝';

  @override
  String get memberShareUploader => '分享 UP 主';

  @override
  String get memberShareMyProfile => '分享我的主页';

  @override
  String get memberAddToHomeScreen => '添加至桌面';

  @override
  String get memberRandomPlay => '随机播放';

  @override
  String get memberReservation => '预约';

  @override
  String get memberReserved => '已预约';

  @override
  String get memberReservationPost => '预约动态';

  @override
  String memberReservationCount(Object count) {
    return '$count 人预约';
  }

  @override
  String get memberWebUploads => '网页投稿';

  @override
  String get memberPremiumXp => '大会员经验';

  @override
  String get memberSignInHistory => '登录记录';

  @override
  String get memberCoinHistory => '硬币记录';

  @override
  String get memberXpHistory => '经验记录';

  @override
  String memberFollowingSince(Object date) {
    return '关注时间：$date';
  }

  @override
  String get memberAccountBanned => '该账号封禁中';

  @override
  String memberSupporterCount(Object count) {
    return '$count 人为 TA 充电';
  }

  @override
  String memberGuardCount(Object count) {
    return '$count 人加入大航海';
  }

  @override
  String get memberMyRecommendations => '我的推荐';

  @override
  String memberRecommendationsBy(String name) {
    return '$name的推荐';
  }

  @override
  String memberCollectionCount(int count) {
    return '合集：$count';
  }

  @override
  String memberListCount(int count) {
    return '列表：$count';
  }

  @override
  String memberGuardTitle(String name) {
    return '$name的舰队';
  }

  @override
  String memberGuardTitleWithCount(String name, Object count) {
    return '$name的舰队（$count）';
  }

  @override
  String get memberAlsoFollowed => '也关注了 TA';

  @override
  String memberAlsoFollowedWithOthers(Object count) {
    return '等 $count 人也关注了 TA';
  }

  @override
  String get memberLikesReceived => '获赞';

  @override
  String get memberFollowingTime => '关注时间';

  @override
  String commonSelectedCount(Object count) {
    return '已选：$count';
  }

  @override
  String get commonSelectAll => '全选';

  @override
  String get commonCancelSelection => '取消选择';

  @override
  String get imageSaveImage => '保存图片';

  @override
  String get imageSaveAll => '保存全部';

  @override
  String get imageSaveAllImages => '保存全部图片';

  @override
  String get imageSaveVideo => '保存视频';

  @override
  String get imageSaveLivePhoto => '保存实况照片';

  @override
  String get imageOpenInBrowser => '在浏览器中打开';

  @override
  String get commonDone => '完成';

  @override
  String get commonCreate => '创建';

  @override
  String get favoriteSortMethod => '排序方式';

  @override
  String favoriteContentCount(num count) {
    return '$count个内容';
  }

  @override
  String favoriteContentSummary(num count, Object visibility) {
    return '$count个内容 · $visibility';
  }

  @override
  String get favoriteEditInfo => '编辑信息';

  @override
  String get favoriteShareToPost => '分享至动态';

  @override
  String get favoriteClearUnavailable => '清除失效内容';

  @override
  String get favoriteDeleteFolderConfirm => '确定删除该收藏夹？';

  @override
  String get favoriteRemoveSelectedConfirm => '确认删除所选收藏吗？';

  @override
  String get favoriteRemoved => '已取消收藏';

  @override
  String get favoriteFolderAdded => '收藏夹收藏成功';

  @override
  String get favoriteFolderRemoved => '已取消收藏夹收藏';

  @override
  String get favoriteClearSucceeded => '清除成功';

  @override
  String get favoriteTooManyToSort => '内容超过 1000 条，不支持排序';

  @override
  String get favoriteRemoveConfirm => '要取消收藏吗？';

  @override
  String get favoriteConfirmRemove => '确定取消';

  @override
  String get favoriteAudio => '音频';

  @override
  String get favoriteAddToFolder => '添加到收藏夹';

  @override
  String get favoriteNameRequired => '名称不能为空';

  @override
  String get favoriteFolderCreated => '创建成功';

  @override
  String get favoriteFolderUpdated => '编辑成功';

  @override
  String get favoriteCrop => '裁剪';

  @override
  String get favoriteReplaceCover => '替换封面';

  @override
  String get favoriteRemoveCover => '移除封面';

  @override
  String get favoriteCover => '封面';

  @override
  String get favoriteName => '名称';

  @override
  String get favoriteIntro => '简介';

  @override
  String get favoriteIntroHint => '可填写简介';

  @override
  String get favoritePublicSetting => '公开';

  @override
  String get favoriteCollectionBadge => '合集';

  @override
  String get favoriteFolderBadge => '收藏夹';

  @override
  String favoriteUploaderCollectionSummary(Object count, Object name) {
    return '$count个内容 · $name';
  }

  @override
  String favoriteCreatedCollectionSummary(
    Object count,
    Object name,
    Object views,
  ) {
    return '创建者：$name\n$count个视频 · $views播放';
  }

  @override
  String get favoriteOrderRecentlyAdded => '最近收藏';

  @override
  String get favoriteOrderMostPlayed => '最多播放';

  @override
  String get favoriteOrderRecentlyPublished => '最近投稿';

  @override
  String get profileTitle => '账号资料';

  @override
  String get profileAvatar => '头像';

  @override
  String get profileNickname => '昵称';

  @override
  String get profileGender => '性别';

  @override
  String get profileBirthday => '出生年月';

  @override
  String get profileBio => '个性签名';

  @override
  String get profileAvatarDecoration => '头像挂件';

  @override
  String get profileVerification => '哔哩哔哩认证';

  @override
  String get profileInsufficientCoins => '硬币不足';

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
    return '与原$field相同';
  }

  @override
  String get profileReloginRequired => '请退出账号后重新登录';

  @override
  String get profileUpdateSucceeded => '修改成功';

  @override
  String get profileGifNotSupported => '不能选择 GIF';

  @override
  String get shutdownPauseVideo => '暂停视频';

  @override
  String get shutdownExitApp => '退出应用';

  @override
  String get shutdownTitle => '定时关闭';

  @override
  String get shutdownCanceled => '已取消定时关闭';

  @override
  String shutdownScheduledAfter(Object duration) {
    return '已设置在 $duration 后定时关闭';
  }

  @override
  String get shutdownTimeReachedPaused => '定时时间已到，已暂停';

  @override
  String shutdownHoursMinutes(Object hours, Object minutes) {
    return '$hours小时$minutes分钟';
  }

  @override
  String shutdownHours(Object hours) {
    return '$hours小时';
  }

  @override
  String shutdownMinutes(Object minutes) {
    return '$minutes分钟';
  }

  @override
  String get shutdownCustom => '自定义';

  @override
  String get shutdownWaitUntilVideoEnds => '额外等待视频播放完毕';

  @override
  String get shutdownActionAtEnd => '倒计时结束：';

  @override
  String get replyViewComments => '查看评论';

  @override
  String get replyAppeal => '申诉';

  @override
  String get replyCheckResult => '评论检查结果';

  @override
  String replyMainListError(Object error) {
    return '获取评论主列表时发生错误：$error';
  }

  @override
  String replyCheckNormal(Object message) {
    return '无账号状态下找到了你的评论，评论正常！\n\n你的评论：$message';
  }

  @override
  String replyCheckNotFound(Object message) {
    return '无法找到你的评论。\n\n你的评论：$message';
  }

  @override
  String replyCheckShadowBanned(Object message) {
    return '你的评论可能仅自己可见！\n\n你的评论：$message';
  }

  @override
  String replyCheckInvisible(Object error, Object message) {
    return '评论不可见（$error）：$message';
  }

  @override
  String replyCheckSuspicious(Object message, Object url) {
    return '你的评论状态有些可疑。无账号浏览评论区时无法看到，但可以通过以下地址直接获取：\n$url\n评论区可能受到限制，或者这是你的视频。\n\n你的评论：$message';
  }

  @override
  String replyCheckInvisibleSimple(Object message) {
    return '评论不可见：$message';
  }

  @override
  String get replyContentText => '文本';

  @override
  String get replyContentEmoji => '表情';

  @override
  String get replyFilterChangeConfirm => '确认应用评论过滤变更？';

  @override
  String get replyAddToFilter => '加入过滤';

  @override
  String memberReportTitle(Object name) {
    return '举报：$name';
  }

  @override
  String get memberReportContentRequired => '举报内容（必选，可多选）';

  @override
  String get memberReportReasonOptional => '举报理由（单选，非必选）';

  @override
  String get memberReportAvatar => '头像违规';

  @override
  String get memberReportNickname => '昵称违规';

  @override
  String get memberReportBio => '签名违规';

  @override
  String get memberReportChooseContent => '至少选择一项作为举报内容';

  @override
  String get reportFailed => '举报失败';

  @override
  String get feedPinned => '置顶成功';

  @override
  String get feedUnpinned => '取消置顶成功';

  @override
  String get updateCheckFailed => '检查更新失败，GitHub 接口未返回数据，请检查网络';

  @override
  String get updateAlreadyLatest => '已是最新版本';

  @override
  String get updateNewVersion => '🎉 发现新版本';

  @override
  String get updateViewFullChanges => '查看完整提交记录';

  @override
  String get updateStopReminding => '不再提醒';

  @override
  String get commonUnsupportedType => '暂未支持此类型，请联系开发者';

  @override
  String get commonGettingResource => '资源获取中…';

  @override
  String get commonResourceLoadFailed => '资源加载失败';

  @override
  String routeUnknown(Object uri) {
    return '未知路径：$uri，请截图反馈给开发者';
  }

  @override
  String videoLoadFailed(Object error) {
    return '视频获取失败：$error';
  }

  @override
  String get liveTitle => '直播';

  @override
  String get rankingTitle => '排行榜';

  @override
  String get commonPlaylist => '播放列表';

  @override
  String get videoParts => '分 P';

  @override
  String get videoChargingOnly => '充电专属';

  @override
  String get videoTrailerBadge => '预告';

  @override
  String get videoLimitedFreeBadge => '限免';

  @override
  String get subscriptionSubscribe => '订阅';

  @override
  String get subscriptionUnsubscribe => '取消订阅';

  @override
  String get subscriptionSubscribed => '订阅成功';

  @override
  String get commonJumpToTop => '跳至顶部';

  @override
  String get commonJumpToBottom => '跳至底部';

  @override
  String get commonJumpToCurrent => '跳至当前';

  @override
  String get commonAscendingOrder => '顺序';

  @override
  String get commonDescendingOrder => '倒序';

  @override
  String get searchUserByUid => '通过 UID 搜索用户';

  @override
  String get searchTrending => '大家都在搜';

  @override
  String get searchDiscover => '搜索发现';

  @override
  String get searchFullRanking => '完整榜单';

  @override
  String get searchHistory => '搜索历史';

  @override
  String get searchRecordHistory => '记录搜索';

  @override
  String get searchIncognito => '无痕搜索';

  @override
  String get searchImportExportHistory => '导入或导出搜索历史';

  @override
  String get searchClearHistoryConfirm => '确定清空搜索历史？';

  @override
  String searchTabCount(Object count, Object label) {
    return '$label $count';
  }

  @override
  String memberSearchHint(Object name) {
    return '搜索「$name」的动态、视频';
  }

  @override
  String get favoriteDeleteSelectedNotesConfirm => '确定删除已选中的笔记吗？';

  @override
  String get favoriteRemoveCourseConfirm => '确定取消收藏该课堂？';

  @override
  String get downloadDeleteSelectedConfirm => '确定删除选中视频？';

  @override
  String get downloadQueueTitle => '正在缓存';

  @override
  String get downloadViewDetails => '查看详情页';

  @override
  String get downloadOpenLocalFolder => '打开本地文件夹';

  @override
  String downloadVisitUploader(Object name) {
    return '访问$name';
  }

  @override
  String get downloadUserProfile => '用户主页';

  @override
  String get downloadWatched => '已看完';

  @override
  String get downloadStatusDownloading => '正在下载';

  @override
  String get downloadStatusAudioDownloading => '正在下载音频';

  @override
  String get downloadStatusGettingDanmaku => '获取弹幕';

  @override
  String get downloadStatusGettingPlayUrl => '获取播放地址';

  @override
  String get downloadStatusCompleted => '下载完成';

  @override
  String get downloadStatusFailed => '下载失败';

  @override
  String get downloadStatusAudioFailed => '音频下载失败';

  @override
  String get downloadStatusDanmakuFailed => '获取弹幕失败';

  @override
  String get downloadStatusPlayUrlFailed => '获取播放地址失败';

  @override
  String get downloadStatusPaused => '暂停中';

  @override
  String get downloadStatusWaiting => '等待中';

  @override
  String get commonSettings => '设置';

  @override
  String get commonEmoji => '表情';

  @override
  String get messagesRecall => '撤回';

  @override
  String get messagesRecalled => '撤回成功';

  @override
  String get messagesSent => '发送成功';

  @override
  String get messagesInputHint => '发个消息聊聊吧…';

  @override
  String get messagesUploadingImage => '正在上传图片…';

  @override
  String get messagesChatSettings => '聊天设置';

  @override
  String get messagesAddToBlocked => '加入黑名单';

  @override
  String get messagesReceivePush => '接收消息推送';

  @override
  String get messagesPushDescription => '关闭后将不再收到该账号的图文消息与稿件推送，但通知类消息不受影响。';

  @override
  String get messagesPinChat => '置顶聊天';

  @override
  String get messagesMute => '消息免打扰';

  @override
  String get messagesDisablePushConfirm => '确认关闭内容推送吗？';

  @override
  String get messagesBlockConfirm => '确认拉黑该用户？';

  @override
  String get messagesBlockDescription =>
      '加入黑名单后，将自动解除关注关系和对该用户的合集订阅关系，并禁止该用户与你互动或查看你的空间。';

  @override
  String get messagesBvNotFound => '未匹配到 BV 号';

  @override
  String get commonAdd => '添加';

  @override
  String get messagesBlockedKeywords => '消息屏蔽词';

  @override
  String get messagesTapKeywordToDelete => '点击屏蔽词即可删除';

  @override
  String get messagesDeleteKeywordConfirm => '删除屏蔽词？';

  @override
  String get messagesKeywordNoLongerApplies => '该屏蔽词将不再生效';

  @override
  String get messagesAddBlockedKeyword => '添加消息屏蔽词';

  @override
  String get messagesNoBlockedKeywords => '还未添加屏蔽词';

  @override
  String get messagesBlockedKeywordDescription => '添加后，将不再接收包含屏蔽词的消息';

  @override
  String get messagesEnterKeyword => '请输入';

  @override
  String get messagesMarkAllRead => '一键已读';

  @override
  String get messagesMarkAllReadConfirm => '是否清除全部新消息提醒？';

  @override
  String get messagesClearList => '清空列表';

  @override
  String get messagesClearListConfirm => '清空后所有消息将被删除，无法恢复';

  @override
  String get messagesMenuSettings => '消息设置';

  @override
  String get messagesUploaderAssistant => 'UP主助手';

  @override
  String get messagesContacts => '联系人';

  @override
  String get messagesFanGroupAssistant => '粉丝团助手';

  @override
  String get feedSelectTopic => '选择话题';

  @override
  String get feedOptionalTitleHint => '标题，选填 20 字';

  @override
  String get feedEditPostTitle => '编辑动态';

  @override
  String get feedCreatePostTitle => '发布动态';

  @override
  String get feedScheduledPost => '定时发布';

  @override
  String feedScheduleAtLeastMinutes(Object minutes) {
    return '请至少选择 $minutes 分钟之后的时间';
  }

  @override
  String get feedLiveReservation => '直播预约';

  @override
  String get feedStartedPoll => '我发起了一个投票';

  @override
  String get feedPosting => '正在发布…';

  @override
  String get feedPosted => '发布成功';

  @override
  String feedLiveReservationTitle(Object title) {
    return '直播预约：$title';
  }

  @override
  String feedLiveStartsAt(Object time) {
    return '$time 直播';
  }

  @override
  String get feedAllowComments => '允许评论';

  @override
  String get feedCloseComments => '关闭评论';

  @override
  String get feedFeaturedComments => '精选评论';

  @override
  String get voteCreateTitle => '发起投票';

  @override
  String get voteEditTitle => '投票';

  @override
  String get voteType => '投票类型';

  @override
  String get voteTitle => '投票标题';

  @override
  String get voteTitleHint => '请填写标题';

  @override
  String get voteDescription => '投票说明';

  @override
  String voteOptionLabel(Object number) {
    return '选项$number';
  }

  @override
  String get voteOptionHint => '选项内容，最多 20 字';

  @override
  String get voteAddOption => '添加选项';

  @override
  String get voteChoiceMode => '单选或多选';

  @override
  String get voteSingleChoice => '单选';

  @override
  String voteMaxChoices(Object count) {
    return '最多选 $count 项';
  }

  @override
  String get voteEndTime => '投票截止时间';

  @override
  String get voteAtLeastFiveMinutes => '至少选择 5 分钟之后';

  @override
  String get voteCreate => '发起投票';

  @override
  String get voteTextType => '文字投票';

  @override
  String get voteImageType => '图片投票';

  @override
  String get reserveAddLive => '添加直播预约';

  @override
  String get reserveType => '类型';

  @override
  String get reservePublicLive => '公开直播';

  @override
  String get reserveSupporterLive => '大航海直播';

  @override
  String get reserveTime => '时间';

  @override
  String get reserveTitle => '标题';

  @override
  String get reserveTitleHint => '请填写标题，最多 14 字';

  @override
  String get reserveAdd => '添加预约';

  @override
  String get mentionInputHint => '输入你想 @ 的人';

  @override
  String get topicSearchHint => '搜索话题';

  @override
  String get commonBlock => '屏蔽';

  @override
  String get commonShow => '显示';

  @override
  String get commonHide => '隐藏';

  @override
  String get playerEnterFullscreen => '进入全屏';

  @override
  String get playerExitFullscreen => '退出全屏';

  @override
  String get playerTurnOffBackgroundPlayback => '关闭后台播放';

  @override
  String get liveSendDanmaku => '发弹幕';

  @override
  String get liveSwitchRoute => '切换路线';

  @override
  String get liveShareRoom => '分享直播间';

  @override
  String livePlayerVolume(Object value) {
    return '播放器音量：$value%';
  }

  @override
  String get liveBackToBottom => '回到底部';

  @override
  String get liveCopyDanmakuInfo => '复制弹幕信息';

  @override
  String get liveGoToUserProfile => '去 TA 的个人空间';

  @override
  String get liveBlockSender => '屏蔽发送者';

  @override
  String get liveBlocked => '屏蔽成功';

  @override
  String get liveLikeSucceeded => '点赞成功';

  @override
  String get liveDanmakuInputHint => '输入弹幕内容';

  @override
  String get audioNoOrder => '无序';

  @override
  String audioPlaybackSpeed(Object speed) {
    return '播放倍速（$speed×）';
  }

  @override
  String get audioPlaybackMode => '播放模式';

  @override
  String get videoTripleSucceeded => '三连成功';

  @override
  String get danmakuBlockTitle => '弹幕屏蔽';

  @override
  String get danmakuBlockKeyword => '关键词';

  @override
  String get danmakuBlockRegex => '正则';

  @override
  String get danmakuBlockUser => '用户';

  @override
  String danmakuBlockTabCount(Object count, Object label) {
    return '$label（$count）';
  }

  @override
  String get danmakuDeleteRuleConfirm => '确定删除该规则？';

  @override
  String get danmakuKeywordHint => '输入过滤关键词；其他类别请切换标签页后添加。';

  @override
  String get danmakuRegexHint => '输入 // 之间的正则表达式，无需包含首尾斜杠。';

  @override
  String get danmakuUidHint => '输入用户 UID';

  @override
  String danmakuRuleDialogTitle(Object action, Object type) {
    return '$action$type规则';
  }

  @override
  String get danmakuInputEmpty => '输入内容不能为空';

  @override
  String get danmakuInputUnchanged => '输入内容与上次相同';

  @override
  String get danmakuSyncingRules => '正在同步弹幕屏蔽规则…';

  @override
  String get danmakuDeletingRule => '正在删除弹幕屏蔽规则…';

  @override
  String get danmakuAddingRule => '正在添加弹幕屏蔽规则…';

  @override
  String get liveDanmakuGlobalBlock => '全局屏蔽';

  @override
  String get liveDanmakuBlockEnabled => '屏蔽已开启';

  @override
  String get liveDanmakuBlockDisabled => '屏蔽未开启';

  @override
  String get liveDanmakuUserLevel => '用户等级';

  @override
  String liveDanmakuBelowLevel(Object level) {
    return '$level 以下';
  }

  @override
  String get liveDanmakuUnofficialUser => '非正式会员';

  @override
  String get liveDanmakuUnverifiedPhone => '未绑定手机用户';

  @override
  String get liveDanmakuKeywordBlock => '关键词屏蔽';

  @override
  String get commonInput => '输入';

  @override
  String get favoriteFolderSortTitle => '收藏夹排序';

  @override
  String get favoriteDefaultFolderSortUnsupported => '默认收藏夹不支持排序';

  @override
  String favoriteSortFolderTitle(String folder) {
    return '排序：$folder';
  }

  @override
  String get followSaveToDefaultGroup => '保存至默认分组';

  @override
  String get commonVideo => '视频';

  @override
  String get commonLongImage => '长图';

  @override
  String imagePositionSemantics(int position, int total) {
    return '图片，第 $position 张，共 $total 张';
  }

  @override
  String get downloadVideoCachedNotification => '视频已缓存完成';

  @override
  String get topicJoin => '参与话题';

  @override
  String get topicStarted => '发起';

  @override
  String topicStats(String views, String discussions) {
    return '$views 浏览 · $discussions 讨论';
  }

  @override
  String get replyPinned => '评论置顶成功';

  @override
  String get replyUnpinned => '已取消评论置顶';

  @override
  String get webRefresh => '刷新';

  @override
  String get webCopyLink => '复制链接';

  @override
  String get webOpenInBrowser => '在浏览器中打开';

  @override
  String get webClearCache => '清除缓存';

  @override
  String get webResetCookie => '重新设置 Cookie';

  @override
  String get webGoBack => '返回';

  @override
  String get webCacheCleared => '已清理';

  @override
  String get webCookieResetSucceeded => '设置成功，请刷新或重新打开网页';

  @override
  String webDownloadFileConfirm(String filename) {
    return '下载文件：$filename？';
  }

  @override
  String webConfirmWithFileSize(String size) {
    return '确定（$size）';
  }

  @override
  String get webExternalLinkConfirm => '当前网页将要打开外部链接，是否打开？';

  @override
  String get webOpen => '打开';

  @override
  String get commonUnliked => '已取消点赞';

  @override
  String get articleShareTitle => '哔哩哔哩专栏';

  @override
  String articleCount(String count) {
    return '$count 篇专栏';
  }

  @override
  String articleWordCount(String count) {
    return '$count 个字';
  }

  @override
  String articleReadCount(String count) {
    return '$count 次阅读';
  }

  @override
  String articleUpdatedAt(String date) {
    return '$date 更新';
  }

  @override
  String articleCollectionId(int id) {
    return '文集号：$id';
  }

  @override
  String followUserFollowers(String name) {
    return '$name 的粉丝';
  }

  @override
  String followRemoveFollowerConfirm(String name) {
    return '确定移除 $name？';
  }

  @override
  String get followFollowerRemoved => '移除成功';

  @override
  String get matchDetails => '比赛详情';

  @override
  String get matchWatchLive => '看直播';

  @override
  String matchEndedAt(String date) {
    return '$date · 已结束';
  }

  @override
  String get castNoDevices => '没有找到投屏设备';

  @override
  String get liveSearchHint => '搜索房间或主播';

  @override
  String get liveContributionRankOnline => '在线榜';

  @override
  String get liveContributionRankDaily => '日榜';

  @override
  String get liveContributionRankWeekly => '周榜';

  @override
  String get liveContributionRankMonthly => '月榜';

  @override
  String liveSearchRooms(String count) {
    return '正在直播 $count';
  }

  @override
  String liveSearchUploaders(String count) {
    return '主播 $count';
  }

  @override
  String get liveAllTags => '全部标签';

  @override
  String get liveFavoriteTags => '我的常用标签';

  @override
  String get liveTapTagHint => '点击进入标签';

  @override
  String get favoriteWantToWatch => '想看';

  @override
  String get favoriteWatching => '在看';

  @override
  String get favoriteWatched => '看过';

  @override
  String get favoriteUnpublishedNotes => '未发布笔记';

  @override
  String get favoritePublicNotes => '公开笔记';

  @override
  String get memberOrderMostPlayed => '最多播放';

  @override
  String get memberOrderMostFavorited => '最多收藏';

  @override
  String get memberReverseOrder => '倒序';

  @override
  String get memberJumpToPage => '跳至';

  @override
  String get memberPageNumber => '页数';

  @override
  String get memberLocateLastWatched => '定位至上次观看';

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
  String get memberMyRecentCoinedVideos => '我的最近投币';

  @override
  String memberUserRecentCoinedVideos(String name) {
    return '$name 的最近投币';
  }

  @override
  String get memberFanMedalWall => '粉丝勋章墙';

  @override
  String memberFanMedalCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '共拥有 $count 枚粉丝勋章',
    );
    return '$_temp0';
  }

  @override
  String get memberMedalWearing => '佩戴中';

  @override
  String favoriteAddedAt(String date) {
    return '收藏于 $date';
  }

  @override
  String get memberLastWatched => '上次观看';

  @override
  String get reviewLong => '长评';

  @override
  String get reviewShort => '短评';

  @override
  String get reviewWriteLong => '写长评';

  @override
  String get reviewWriteShort => '写短评';

  @override
  String get reviewLatest => '最新';

  @override
  String get reviewRatingAwful => '很差';

  @override
  String get reviewRatingPoor => '较差';

  @override
  String get reviewRatingOkay => '还行';

  @override
  String get reviewRatingGreat => '很好';

  @override
  String get reviewRatingExcellent => '佳作';

  @override
  String get reviewTapToRate => '轻触评分';

  @override
  String get reviewEdited => '编辑成功';

  @override
  String get reviewPublished => '点评成功';

  @override
  String get reviewDeleteConfirm => '删除短评，同时删除评分？';

  @override
  String reviewCount(String count) {
    return '$count 条点评';
  }

  @override
  String get searchFilter => '筛选';

  @override
  String searchFilteredBy(String filter) {
    return '“$filter”的筛选结果';
  }

  @override
  String searchSortValue(String value) {
    return '排序：$value';
  }

  @override
  String searchZoneValue(String value) {
    return '分区：$value';
  }

  @override
  String searchUserTypeValue(String value) {
    return '用户类型：$value';
  }

  @override
  String get searchZone => '分区';

  @override
  String get searchUserSort => '用户粉丝数及等级排序顺序';

  @override
  String get searchUserType => '用户分类';

  @override
  String get searchPublishedTime => '发布时间';

  @override
  String get searchDateTo => '至';

  @override
  String get searchContentDuration => '内容时长';

  @override
  String get searchContentZone => '内容分区';

  @override
  String get searchOrderRelevance => '综合排序';

  @override
  String get searchOrderNewest => '最新发布';

  @override
  String get searchOrderMostClicked => '最多点击';

  @override
  String get searchOrderMostLiked => '最多喜欢';

  @override
  String get searchOrderMostCommented => '最多评论';

  @override
  String get searchOrderDefault => '默认排序';

  @override
  String get searchOrderMostPlayed => '播放多';

  @override
  String get searchOrderMostDanmaku => '弹幕多';

  @override
  String get searchOrderMostFavorited => '收藏多';

  @override
  String get searchFollowersHighToLow => '粉丝数由高到低';

  @override
  String get searchFollowersLowToHigh => '粉丝数由低到高';

  @override
  String get searchLevelHighToLow => '等级由高到低';

  @override
  String get searchLevelLowToHigh => '等级由低到高';

  @override
  String get searchAllUsers => '全部用户';

  @override
  String get searchUploaders => 'UP 主';

  @override
  String get searchRegularUsers => '普通用户';

  @override
  String get searchVerifiedUsers => '认证用户';

  @override
  String get searchAnyTime => '不限';

  @override
  String get searchLastDay => '最近一天';

  @override
  String get searchLastWeek => '最近一周';

  @override
  String get searchLastSixMonths => '最近半年';

  @override
  String get searchAllDurations => '全部时长';

  @override
  String get searchDurationUnderTen => '0–10 分钟';

  @override
  String get searchDurationTenToThirty => '10–30 分钟';

  @override
  String get searchDurationThirtyToSixty => '30–60 分钟';

  @override
  String get searchDurationOverSixty => '60 分钟以上';

  @override
  String get searchAllZones => '全部分区';

  @override
  String get searchZoneAnimation => '动画';

  @override
  String get searchZoneAnime => '番剧';

  @override
  String get searchZoneChineseAnimation => '国创';

  @override
  String get searchZoneMusic => '音乐';

  @override
  String get searchZoneDance => '舞蹈';

  @override
  String get searchZoneGames => '游戏';

  @override
  String get searchZoneKnowledge => '知识';

  @override
  String get searchZoneTechnology => '科技';

  @override
  String get searchZoneSports => '运动';

  @override
  String get searchZoneCars => '汽车';

  @override
  String get searchZoneLife => '生活';

  @override
  String get searchZoneFood => '美食';

  @override
  String get searchZoneAnimals => '动物';

  @override
  String get searchZoneKichiku => '鬼畜';

  @override
  String get searchZoneFashion => '时尚';

  @override
  String get searchZoneNews => '资讯';

  @override
  String get searchZoneEntertainment => '娱乐';

  @override
  String get searchZoneFilmTv => '影视';

  @override
  String get searchZoneDocumentary => '纪录片';

  @override
  String get searchZoneMovies => '电影';

  @override
  String get searchZoneTv => '电视';

  @override
  String get searchZoneInterests => '兴趣';

  @override
  String get searchZoneLightNovels => '轻小说';

  @override
  String get searchZoneNotes => '笔记';

  @override
  String get commonAlbum => '相簿';

  @override
  String get commonArticle => '专栏';

  @override
  String get messagesAutoReply => '此条消息为自动回复';

  @override
  String messagesLiveBy(String author) {
    return '$author · 直播';
  }

  @override
  String get liveNow => '直播中';

  @override
  String memberFollowerCount(String count) {
    return '$count 粉丝';
  }

  @override
  String get commonViewMore => '查看更多内容';

  @override
  String get commonExit => '退出';

  @override
  String get audioWatchMv => '看 MV';

  @override
  String liveHighEnergyAudience(String count) {
    return '高能观众（$count）';
  }

  @override
  String get liveJustStarted => '刚刚开播';

  @override
  String liveStartedFor(String duration) {
    return '开播 $duration';
  }

  @override
  String get livePlaybackUrlUnavailable => '无法获取播放地址';

  @override
  String liveVisitUser(String name) {
    return '访问：$name';
  }

  @override
  String get liveCopySuperChatInfo => '复制 SC 信息';

  @override
  String get commonExpand => '展开';

  @override
  String get commonCollapse => '收起';

  @override
  String get feedTopics => '话题';

  @override
  String get commonTime => '时间';

  @override
  String get commonReason => '原因';

  @override
  String get logChange => '变化';

  @override
  String get logLocation => '地理位置';

  @override
  String get logExperienceHistory => '经验记录';

  @override
  String get logLoginHistory => '登录记录';

  @override
  String get saveWatch => '观看';

  @override
  String get saveContent => '内容';

  @override
  String get saveCollection => '合集';

  @override
  String saveScanQrToOpen(String action, String item) {
    return '识别二维码，$action$item';
  }

  @override
  String musicReleaseDate(String date) {
    return '发行日期：$date';
  }

  @override
  String musicOriginalArtist(String artist) {
    return '原唱：$artist';
  }

  @override
  String musicAlbum(String album) {
    return '专辑：$album';
  }

  @override
  String musicSource(String source) {
    return '出处：$source';
  }

  @override
  String get musicHotSongRanking => '热歌榜排名';

  @override
  String get musicPopularity => '热度';

  @override
  String get musicTotalPlays => '总播放量';

  @override
  String get musicVideosUsingTrack => '使用稿件量';

  @override
  String musicRecentPopularityTrend(int days) {
    return '近 $days 日热度趋势';
  }

  @override
  String articleAuthorReads(String author, int count) {
    return '$author · $count 阅读';
  }

  @override
  String articlePriceFrom(String price) {
    return '$price 起';
  }

  @override
  String get articleFeedOrArticle => '动态 / 专栏';

  @override
  String articleUnsupportedType(String type) {
    return '不支持的类型（$type）';
  }

  @override
  String articleInvalidType(String error) {
    return '错误的类型：$error';
  }

  @override
  String memberShopFrom(String source) {
    return '来自 $source';
  }

  @override
  String get loginMainAccountSucceeded => '主账号登录成功';

  @override
  String loginCookieFailed(String error) {
    return '登录失败，请检查 Cookie 是否正确。$error';
  }

  @override
  String get memberAllCollectionsAndLists => '全部合集 / 列表';

  @override
  String get memberAllPosts => '全部图文';

  @override
  String get memberPosts => '图文';

  @override
  String memberSupportRanking(String name, String count) {
    return '$name 的充电排行榜 $count';
  }

  @override
  String get memberSupport => '充电';

  @override
  String get memberSupportDaysSuffix => ' 天';

  @override
  String liveSearchUserStats(String area, String followers) {
    return '分区：$area · 关注数：$followers';
  }

  @override
  String bubbleSiteTitle(String name) {
    return '$name 小站';
  }

  @override
  String liveSwitchPreviewTo(String target) {
    return '切换至$target';
  }

  @override
  String get liveCover => '封面';

  @override
  String get liveFirstFrame => '首帧';

  @override
  String get liveShowMenu => '显示菜单';

  @override
  String get liveReportSelectedDanmaku => '举报选中弹幕';

  @override
  String get mediaTvSeries => '电视剧';

  @override
  String get mediaComics => '漫画';

  @override
  String get mediaVarietyShows => '综艺';

  @override
  String memberUserLevelSemantics(int level) {
    return '$level 级';
  }

  @override
  String get avatarVipBadge => '大会员';

  @override
  String get avatarVerifiedIndividual => '认证个人';

  @override
  String get avatarVerifiedOrganization => '认证机构';

  @override
  String memberHardcoreUserLevelSemantics(int level) {
    return '硬核 $level 级';
  }

  @override
  String get playerProgressBar => '进度条';

  @override
  String get commonPlay => '播放';

  @override
  String get settingsSpeedTestTimeout => '测速超时';

  @override
  String get commonSave => '保存';
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

  @override
  String get settingsOpenOnboarding => '重新開啟歡迎引導';

  @override
  String get settingsOpenOnboardingDescription => '再次查看語言、主題與資料遷移引導，不會清除現有設定';

  @override
  String settingsDefaultValue(String value) {
    return '預設值：$value';
  }

  @override
  String get commonDisabled => '停用';

  @override
  String get commonUnavailable => '無法使用';

  @override
  String get commonDeleted => '已刪除';

  @override
  String get commonDelete => '刪除';

  @override
  String get commonDeleting => '正在刪除…';

  @override
  String get commonDeleteSucceeded => '刪除成功';

  @override
  String commonDeleteFailed(String error) {
    return '刪除失敗：$error';
  }

  @override
  String commonLoadFailed(String error) {
    return '載入失敗：$error';
  }

  @override
  String get commonReport => '檢舉';

  @override
  String get commonFormat => '格式';

  @override
  String get commonPin => '置頂';

  @override
  String get commonUnpin => '取消置頂';

  @override
  String get commonLike => '按讚';

  @override
  String get commonLiked => '已按讚';

  @override
  String get commonDislike => '倒讚';

  @override
  String get commonDisliked => '已倒讚';

  @override
  String get commonAddToFavorites => '加入收藏';

  @override
  String get commonRemoveFromFavorites => '取消收藏';

  @override
  String get commonShare => '分享';

  @override
  String get commonRepost => '轉發';

  @override
  String get commonOther => '其他';

  @override
  String get commonBack => '返回';

  @override
  String get commonPause => '暫停';

  @override
  String get commonClose => '關閉';

  @override
  String get commonLoading => '載入中…';

  @override
  String get commonSavingMayTakeTime => '正在儲存，可能需要一些時間';

  @override
  String get commonTapToReload => '點選重新載入';

  @override
  String get commonCopyLink => '複製連結';

  @override
  String get commonOpenInAnotherApp => '使用其他應用程式開啟';

  @override
  String get commonNoMore => '沒有更多了';

  @override
  String get commonSend => '傳送';

  @override
  String get commonSending => '傳送中…';

  @override
  String get commonSent => '傳送成功';

  @override
  String get commonImage => '圖片';

  @override
  String get commonEdit => '編輯';

  @override
  String get commonPreview => '預覽';

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
    return '提交失敗：$error';
  }

  @override
  String get commonSucceeded => '成功';

  @override
  String get commonUndo => '復原';

  @override
  String get commonUnknown => '未知';

  @override
  String get commonDataUnavailable => '無法取得所需資料';

  @override
  String get commonFeedback => '意見回饋';

  @override
  String get commonNotice => '提示';

  @override
  String get commonJumpFailed => '跳轉失敗';

  @override
  String get commonOriginal => '原文';

  @override
  String get commonTranslate => '翻譯';

  @override
  String get commonReply => '回覆';

  @override
  String get commonVote => '投票';

  @override
  String get commonNote => '筆記';

  @override
  String get commonNotes => '筆記';

  @override
  String get commonClear => '清除';

  @override
  String get commonVideos => '影片';

  @override
  String get commonArticles => '專欄';

  @override
  String get commonLiveRooms => '直播間';

  @override
  String get commonUsers => '使用者';

  @override
  String get commonAllTypes => '全部類型';

  @override
  String get commonViewDetails => '查看詳情';

  @override
  String get commonDetails => '詳細資料';

  @override
  String get commonView => '查看';

  @override
  String get commonViewAll => '查看全部';

  @override
  String get commonGoTo => '前往';

  @override
  String get commonColorPicker => '選擇顏色';

  @override
  String get commonSmall => '小';

  @override
  String get commonStandard => '標準';

  @override
  String get commonWifi => 'Wi-Fi';

  @override
  String get commonMobileData => '行動數據';

  @override
  String get commonNewestPublished => '最新發佈';

  @override
  String get commonMostViewed => '最多播放';

  @override
  String get downloadHighestQuality => '最高畫質';

  @override
  String downloadCurrentNetwork(String network) {
    return '目前網路：$network';
  }

  @override
  String get downloadCacheAll => '下載全部';

  @override
  String get downloadConfirmCacheAll => '確定下載全部？';

  @override
  String get downloadViewCached => '查看下載';

  @override
  String get accountPremium => '大會員';

  @override
  String get accountPremiumRequired => '需要大會員';

  @override
  String get accountSignInAgainRequired => '請登出帳號後重新登入';

  @override
  String get memberQuietlyFollowing => '悄悄關注';

  @override
  String get memberFollowing => '已關注';

  @override
  String get memberMutualFollow => '互相關注';

  @override
  String get memberBlocked => '已封鎖';

  @override
  String get memberSpecialFollow => '特別關注';

  @override
  String get memberFollow => '關注';

  @override
  String memberFollowersAndVideos(String followers, String videos) {
    return '$followers 位粉絲 · $videos 部影片';
  }

  @override
  String get memberEditProfile => '編輯個人資料';

  @override
  String get memberViewProfile => '查看主頁';

  @override
  String get playerSuperResolutionEfficiency => '效率';

  @override
  String get playerSuperResolutionQuality => '畫質';

  @override
  String get playerSuperResolution => '超解析度';

  @override
  String get playerRepeatPauseAtEnd => '播完暫停';

  @override
  String get playerRepeatListOrder => '清單依序播放';

  @override
  String get playerRepeatSingle => '單集循環';

  @override
  String get playerRepeatList => '清單循環';

  @override
  String get playerRepeatAutoplayRelated => '自動播放相關影片';

  @override
  String get playerFitStretch => '拉伸';

  @override
  String get playerFitAuto => '自動';

  @override
  String get playerFitCrop => '裁剪';

  @override
  String get playerFitWidth => '符合寬度';

  @override
  String get playerFitHeight => '符合高度';

  @override
  String get playerFitOriginal => '原始大小';

  @override
  String get playerFitScaleDown => '縮小以符合';

  @override
  String get playerQuality8k => '8K 超高畫質';

  @override
  String get playerQualityDolbyVision => '杜比視界';

  @override
  String get playerQualityHdr => 'HDR';

  @override
  String get playerQuality4k => '4K 超高畫質';

  @override
  String get playerQuality1080p60 => '1080P 60 幀';

  @override
  String get playerQuality1080pHighBitrate => '1080P 高位元率';

  @override
  String get playerQuality1080p => '1080P 高畫質';

  @override
  String get playerQuality720p60 => '720P 60 幀';

  @override
  String get playerQuality720p => '720P';

  @override
  String get playerQuality480p => '480P 標準畫質';

  @override
  String get playerQuality360p => '360P 流暢';

  @override
  String get playerQuality240p => '240P 極速';

  @override
  String get playerCdnBaseUrl => '主要線路';

  @override
  String get playerCdnBackupUrl => '備用線路';

  @override
  String playerCdnAlibaba(String name) {
    return '阿里雲（$name）';
  }

  @override
  String playerCdnTencent(String name) {
    return '騰訊雲（$name）';
  }

  @override
  String playerCdnTencentVod(String name) {
    return '騰訊 VOD（$name）';
  }

  @override
  String playerCdnHuaweiFusion(String name) {
    return '華為融合（$name）';
  }

  @override
  String playerCdnHuawei(String name) {
    return '華為雲（$name）';
  }

  @override
  String playerCdnAkamaiInternational(String name) {
    return 'Akamai 國際（$name）';
  }

  @override
  String playerCdnAlibabaInternational(String name) {
    return '阿里雲國際（$name）';
  }

  @override
  String playerCdnTencentInternational(String name) {
    return '騰訊雲國際（$name）';
  }

  @override
  String playerCdnHuaweiInternational(String name) {
    return '華為雲國際（$name）';
  }

  @override
  String playerCdnBilibiliInternational(String name) {
    return '嗶哩嗶哩國際（$name）';
  }

  @override
  String get playerCdnMayNotWork => '此線路可能無法使用';

  @override
  String get playerCdnSpeedTestFailed => '測速失敗';

  @override
  String get playerCdnSettings => 'CDN 設定';

  @override
  String playerCurrentCdn(String cdn) {
    return '目前 CDN：$cdn';
  }

  @override
  String playerCdnSetReloading(String cdn) {
    return '已切換至 $cdn，正在重新載入';
  }

  @override
  String get playerMoreSettings => '更多播放設定';

  @override
  String get playerPlay => '播放';

  @override
  String get playerSleepTimer => '睡眠計時器';

  @override
  String get playerPlaybackUrl => '播放網址';

  @override
  String get playerReloadVideo => '重新載入影片';

  @override
  String get playerVolume => '音量';

  @override
  String get playerFlipHorizontal => '水平翻轉';

  @override
  String get playerFlipVertical => '垂直翻轉';

  @override
  String get playerAudioOnly => '僅播放音訊';

  @override
  String get playerBackgroundPlayback => '背景播放';

  @override
  String get playerSelectVideoQuality => '選擇影片畫質';

  @override
  String playerCurrentVideoQuality(String quality) {
    return '目前畫質：$quality';
  }

  @override
  String get playerSelectAudioQuality => '選擇音質';

  @override
  String playerCurrentAudioQuality(String quality) {
    return '目前音質：$quality';
  }

  @override
  String get playerCodec => '編碼格式';

  @override
  String playerCurrentCodec(String codec) {
    return '目前編碼：$codec';
  }

  @override
  String get playerPlaybackOrder => '播放順序';

  @override
  String get playerDanmakuList => '彈幕清單';

  @override
  String get playerDanmakuSettings => '彈幕設定';

  @override
  String get playerSubtitleSettings => '字幕設定';

  @override
  String get playerLoadSubtitles => '載入字幕';

  @override
  String get playerSaveSubtitles => '儲存字幕';

  @override
  String get playerPlaybackInfo => '播放資訊';

  @override
  String get playerInfoResolution => '解析度';

  @override
  String get playerInfoVideoParameters => '影片參數';

  @override
  String get playerInfoAudioParameters => '音訊參數';

  @override
  String get playerInfoMedia => '媒體';

  @override
  String get playerInfoAudioTrack => '音軌';

  @override
  String get playerInfoVideoTrack => '影片軌';

  @override
  String get playerInfoPlaybackRate => '播放速度';

  @override
  String get playerInfoHardwareDecoder => '硬體解碼';

  @override
  String get playerVideoQualityNotSupported => '目前影片不支援選擇畫質';

  @override
  String get playerPremiumQualityHint => '此畫質需要大會員或登入後使用';

  @override
  String playerVideoQualityChanged(String quality) {
    return '畫質已切換為 $quality';
  }

  @override
  String playerAudioQualityChanged(String quality) {
    return '音質已切換為 $quality';
  }

  @override
  String get playerCodecNotSupported => '目前影片不支援切換編碼';

  @override
  String get playerSelectCodec => '選擇編碼格式';

  @override
  String playerCodecChanged(String codec) {
    return '編碼已切換為 $codec';
  }

  @override
  String playerFontSize(String value) {
    return '字型大小：$value';
  }

  @override
  String playerFullscreenFontSize(String value) {
    return '全螢幕字型大小：$value';
  }

  @override
  String playerFontWeightMayVary(String value) {
    return '字重：$value（效果依字型而異）';
  }

  @override
  String playerStrokeWidth(String value) {
    return '描邊寬度：$value';
  }

  @override
  String playerHorizontalMargin(String value) {
    return '水平邊距：$value';
  }

  @override
  String playerBottomMargin(String value) {
    return '底部邊距：$value';
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
    return '$count 人正在觀看';
  }

  @override
  String get playerCast => '投放';

  @override
  String get playerCastingNotSupported => '不支援投放';

  @override
  String get playerSubmitSegment => '提交片段';

  @override
  String get playerSegmentInfo => '片段資訊';

  @override
  String get playerTurnOffDanmaku => '關閉彈幕';

  @override
  String get playerTurnOnDanmaku => '開啟彈幕';

  @override
  String get playerPictureInPicture => '子母畫面';

  @override
  String get playerDanmakuScrolling => '捲動';

  @override
  String get playerDanmakuTop => '頂部';

  @override
  String get playerDanmakuBottom => '底部';

  @override
  String get playerDanmakuColored => '彩色';

  @override
  String get playerDanmakuAdvanced => '進階';

  @override
  String playerDanmakuCloudFilterLevel(int level) {
    return '雲端過濾等級：$level';
  }

  @override
  String playerDanmakuFilterManagement(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '過濾管理（$count）',
      zero: '過濾管理',
    );
    return '$_temp0';
  }

  @override
  String get playerDanmakuFilterByType => '依類型過濾';

  @override
  String get playerDanmakuMassiveMode => '海量模式';

  @override
  String get playerDanmakuConvertStaticToScrolling => '固定彈幕轉捲動彈幕';

  @override
  String get playerDanmakuFixedSpeed => '固定速度';

  @override
  String playerDanmakuDisplayArea(String value) {
    return '顯示區域：$value';
  }

  @override
  String playerScrollingDanmakuDuration(String value) {
    return '捲動彈幕時間：$value 秒';
  }

  @override
  String playerStaticDanmakuDuration(String value) {
    return '固定彈幕時間：$value 秒';
  }

  @override
  String playerDanmakuLineHeight(String value) {
    return '彈幕行高：$value';
  }

  @override
  String get playerPreviousEpisode => '上一集';

  @override
  String get playerNextEpisode => '下一集';

  @override
  String get playerAlreadyFirstEpisode => '已經是第一集了';

  @override
  String get playerAlreadyLastEpisode => '已經是最後一集了';

  @override
  String get playerHighlightHeatmap => '高能進度條';

  @override
  String get playerChapterInfo => '章節資訊';

  @override
  String get playerEpisodes => '選集';

  @override
  String get playerAspectRatio => '畫面比例';

  @override
  String get playerTranslation => '翻譯';

  @override
  String get playerTurnOffTranslation => '關閉翻譯';

  @override
  String get playerSubtitles => '字幕';

  @override
  String get playerTurnOffSubtitles => '關閉字幕';

  @override
  String get playerPlaybackSpeed => '播放速度';

  @override
  String playerSpeedSemantic(String speed) {
    return '$speed 倍速';
  }

  @override
  String get playerVideoQuality => '影片畫質';

  @override
  String get playerExitFullScreen => '退出全螢幕';

  @override
  String get playerFullScreen => '全螢幕';

  @override
  String get playerReleaseToCancelSeeking => '放開以取消定位';

  @override
  String playerSpeedActive(String speed) {
    return '$speed 倍速播放';
  }

  @override
  String get playerResetView => '重設畫面';

  @override
  String get playerUnlock => '解鎖';

  @override
  String get playerLock => '鎖定';

  @override
  String get playerScreenshot => '螢幕截圖';

  @override
  String get playerMuted => '已靜音';

  @override
  String get playerUnmuted => '已取消靜音';

  @override
  String get playerAnimatedScreenshot => '動態截圖';

  @override
  String get playerWebpPreset => 'WebP 預設';

  @override
  String get playerWebpCpuWarning => '產生動態截圖會使用較多處理器資源';

  @override
  String get playerTranscodeFailedOrCanceled => '轉碼失敗或已取消';

  @override
  String get playerWebpPresetNone => '無';

  @override
  String get playerWebpPresetPicture => '圖片';

  @override
  String get playerWebpPresetPhoto => '相片';

  @override
  String get playerWebpPresetDrawing => '繪圖';

  @override
  String get playerWebpPresetIcon => '圖示';

  @override
  String get playerWebpPresetText => '文字';

  @override
  String get playerWebpPresetNoneDescription => '不使用預設';

  @override
  String get playerWebpPresetDefaultDescription => '平衡畫質與檔案大小';

  @override
  String get playerWebpPresetPictureDescription => '適合一般圖片';

  @override
  String get playerWebpPresetPhotoDescription => '適合相片與複雜畫面';

  @override
  String get playerWebpPresetDrawingDescription => '適合繪圖與插畫';

  @override
  String get playerWebpPresetIconDescription => '適合圖示與小型圖形';

  @override
  String get playerWebpPresetTextDescription => '適合包含文字的畫面';

  @override
  String get playerDanmakuFontSize => '彈幕字型大小';

  @override
  String get playerDanmakuStyle => '彈幕樣式';

  @override
  String get playerDanmakuColor => '彈幕顏色';

  @override
  String get playerDanmakuInputHint => '輸入彈幕內容';

  @override
  String get playerNowPlaying => '正在播放';

  @override
  String playerNowPlayingTitle(String title) {
    return '正在播放：$title';
  }

  @override
  String get playerPlayInOrder => '依序播放';

  @override
  String get playerPlayInReverse => '倒序播放';

  @override
  String playerSkipSegment(String segment) {
    return '略過：$segment';
  }

  @override
  String get playerUploaderDisabledDanmaku => 'UP 主已關閉彈幕';

  @override
  String playerRewindSeconds(int seconds) {
    return '倒退 $seconds 秒';
  }

  @override
  String playerForwardSeconds(int seconds) {
    return '快轉 $seconds 秒';
  }

  @override
  String get playerVideoOpenFailedRetrying => '影片連結開啟失敗，正在重試';

  @override
  String playerDecoderLoadFailed(String error) {
    return '無法載入解碼器：$error，可能會切換至軟體解碼';
  }

  @override
  String get playerTakingScreenshot => '正在截圖';

  @override
  String get playerTapPreviewToSaveScreenshot => '點選預覽圖儲存截圖';

  @override
  String get playerScreenshotFailed => '截圖失敗';

  @override
  String get replyPostComment => '發表留言';

  @override
  String get replyNoCommentsYet => '目前沒有留言';

  @override
  String get replyInputHint => '新增留言…';

  @override
  String get replyImagesNotSupported => '目前留言區不支援圖片';

  @override
  String get replyAlsoPostToFeed => '同時轉發至動態';

  @override
  String get replyInsertContent => '插入內容';

  @override
  String get replyVideoProgress => '影片時間點';

  @override
  String replyMaxImages(int limit) {
    String _temp0 = intl.Intl.pluralLogic(
      limit,
      locale: localeName,
      other: '最多可加入 $limit 張圖片',
    );
    return '$_temp0';
  }

  @override
  String get replyVideoScreenshot => '影片截圖';

  @override
  String get replyVoteRedSide => '紅方';

  @override
  String get replyVoteBlueSide => '藍方';

  @override
  String replyVoteParticipants(String count) {
    return '$count 人參與';
  }

  @override
  String get replyTranslationEmpty => '翻譯結果為空';

  @override
  String replyTranslationFailed(String error) {
    return '翻譯失敗：$error';
  }

  @override
  String get replyViewConversation => '查看對話';

  @override
  String get replyJumpToReply => '跳轉至回覆';

  @override
  String get replyUploaderAndOthers => 'UP 主等人';

  @override
  String replyCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '共 $count 則回覆',
      zero: '目前沒有回覆',
    );
    return '$_temp0';
  }

  @override
  String replyVoteTitle(String title) {
    return '投票：$title';
  }

  @override
  String replyJumpTo(String time) {
    return '跳轉至：$time';
  }

  @override
  String replyJumpFailed(String error) {
    return '跳轉失敗：$error';
  }

  @override
  String get replyDeleteComment => '刪除留言';

  @override
  String get replyConfirmDeleteComment => '確定刪除這則留言嗎？';

  @override
  String get replyCopyAll => '全部複製';

  @override
  String get replyCopySelection => '自由複製';

  @override
  String get replySaveComment => '儲存留言';

  @override
  String get replyCheckComment => '檢查留言';

  @override
  String get replyDetails => '留言詳細資料';

  @override
  String get replyConversation => '對話清單';

  @override
  String replyRelatedCount(String count) {
    return '相關回覆共 $count 則';
  }

  @override
  String get replyMayHaveBeenDeleted => '留言可能已被刪除';

  @override
  String get replyDislikeSucceeded => '倒讚成功';

  @override
  String get replyRemoveDislikeSucceeded => '已取消倒讚';

  @override
  String get replyLikeSucceeded => '按讚成功';

  @override
  String get replyUnlikeSucceeded => '已取消按讚';

  @override
  String get reportChooseReason => '請選擇檢舉原因：';

  @override
  String get reportDetailsHint => '為協助審核人員更快處理，請補充問題類型、出現位置等詳細資訊';

  @override
  String get reportReasonRequired => '原因不能為空';

  @override
  String get reportBlockUser => '封鎖此使用者';

  @override
  String get reportSucceeded => '檢舉成功';

  @override
  String get reportGroupIllegal => '違反法律法規';

  @override
  String get reportGroupMisinformation => '謠言類不實資訊';

  @override
  String get reportGroupPersonalRights => '侵犯個人權益';

  @override
  String get reportGroupCommunity => '危害社群環境';

  @override
  String get reportIllegal => '違法違規';

  @override
  String get reportPornography => '色情';

  @override
  String get reportVulgar => '低俗';

  @override
  String get reportGamblingOrScam => '賭博詐騙';

  @override
  String get reportIllegalExternalLink => '違法資訊外部連結';

  @override
  String get reportPoliticalRumor => '政治謠言';

  @override
  String get reportMisinformation => '虛假不實資訊';

  @override
  String get reportSocialEventRumor => '社會事件謠言';

  @override
  String get reportPersonalAttack => '人身攻擊';

  @override
  String get reportPrivacyViolation => '侵犯隱私';

  @override
  String get reportSpam => '垃圾廣告';

  @override
  String get reportProvocation => '引戰';

  @override
  String get reportSpoiler => '劇透';

  @override
  String get reportFlooding => '惡意洗版';

  @override
  String get reportIrrelevant => '與影片無關';

  @override
  String get reportIllegalLottery => '違規抽獎';

  @override
  String get reportHarmfulToMinors => '青少年不良資訊';

  @override
  String get reportIllegalOrHarmful => '違法有害資訊';

  @override
  String get reportPornographicOrVulgar => '色情低俗';

  @override
  String get reportAbuseOrProvocation => '辱罵引戰';

  @override
  String get reportPoliticallySensitive => '政治敏感';

  @override
  String get reportAdHarassment => '廣告騷擾';

  @override
  String get reportScam => '詐騙';

  @override
  String get sponsorBlockActionSkip => '略過';

  @override
  String get sponsorBlockActionMute => '靜音';

  @override
  String get sponsorBlockActionFullVideo => '整部影片';

  @override
  String get sponsorBlockActionHighlight => '精彩時刻';

  @override
  String get sponsorBlockAlwaysSkip => '總是略過';

  @override
  String get sponsorBlockSkipOnce => '略過一次';

  @override
  String get sponsorBlockManualSkip => '手動略過';

  @override
  String get sponsorBlockShowOnly => '僅顯示';

  @override
  String get sponsorBlockCategorySponsor => '贊助／業配';

  @override
  String get sponsorBlockCategorySponsorShort => '贊助';

  @override
  String get sponsorBlockCategorySelfPromotion => '無償／自我推廣';

  @override
  String get sponsorBlockCategorySelfPromotionShort => '推廣';

  @override
  String get sponsorBlockCategoryExclusiveAccess => '獨家存取／搶先體驗';

  @override
  String get sponsorBlockCategoryExclusiveAccessShort => '品牌合作';

  @override
  String get sponsorBlockCategoryInteraction => '互動提醒';

  @override
  String get sponsorBlockCategoryInteractionShort => '互動提醒';

  @override
  String get sponsorBlockCategoryHighlight => '精彩時刻／重點';

  @override
  String get sponsorBlockCategoryHighlightShort => '精彩時刻';

  @override
  String get sponsorBlockCategoryIntro => '過場／開場動畫';

  @override
  String get sponsorBlockCategoryIntroShort => '開場動畫';

  @override
  String get sponsorBlockCategoryOutro => '鳴謝／結束畫面';

  @override
  String get sponsorBlockCategoryOutroShort => '片尾';

  @override
  String get sponsorBlockCategoryPreview => '回顧／概要';

  @override
  String get sponsorBlockCategoryPreviewShort => '預覽';

  @override
  String get sponsorBlockCategoryPadding => '填充內容／前黑／後黑';

  @override
  String get sponsorBlockCategoryPaddingShort => '填充內容';

  @override
  String get sponsorBlockCategoryFiller => '離題閒聊／玩笑';

  @override
  String get sponsorBlockCategoryFillerShort => '離題';

  @override
  String get sponsorBlockCategoryMusicOfftopic => '音樂：非音樂部分';

  @override
  String get sponsorBlockCategoryMusicOfftopicShort => '非音樂';

  @override
  String sponsorBlockSkipped(String segment) {
    return '已略過$segment片段';
  }

  @override
  String sponsorBlockJumpedTo(String segment) {
    return '已跳至$segment';
  }

  @override
  String sponsorBlockSkipFailed(String segment) {
    return '$segment片段略過失敗';
  }

  @override
  String get sponsorBlockUpvote => '贊成票';

  @override
  String get sponsorBlockDownvote => '反對票';

  @override
  String get sponsorBlockChangeCategory => '變更類別';

  @override
  String get sponsorBlockVoteSucceeded => '投票成功';

  @override
  String sponsorBlockVoteFailed(String error) {
    return '投票失敗：$error';
  }

  @override
  String get sponsorBlockCategoryChangeSucceeded => '類別變更成功';

  @override
  String sponsorBlockCategoryChangeFailed(String error) {
    return '類別變更失敗：$error';
  }

  @override
  String sponsorBlockSegmentRange(String start, String end) {
    return '$start 至 $end';
  }

  @override
  String get sponsorBlockJumpToSegment => '跳至此片段';

  @override
  String get sponsorBlockSkipSegment => '略過此片段';

  @override
  String get videoPlayNow => '立即播放';

  @override
  String get videoReplay => '重新播放';

  @override
  String get videoResumePlayback => '繼續播放';

  @override
  String get videoBackToHome => '返回首頁';

  @override
  String get videoRelatedVideos => '相關影片';

  @override
  String get videoViewNotes => '查看筆記';

  @override
  String get videoDownload => '下載';

  @override
  String get videoSaveCover => '儲存封面';

  @override
  String get videoListenToAudio => '聆聽音訊';

  @override
  String get videoOfflineVideo => '離線影片';

  @override
  String get videoDescription => '簡介';

  @override
  String get videoComments => '留言';

  @override
  String get videoPlaylist => '播放清單';

  @override
  String videoCommentsCount(String count) {
    return '留言 $count';
  }

  @override
  String get videoSendDanmaku => '傳送彈幕';

  @override
  String get videoSeriesReverseNotSupported => '目前系列不支援倒序播放';

  @override
  String get videoLikeSucceeded => '按讚成功';

  @override
  String get videoUnlikeSucceeded => '已取消按讚';

  @override
  String get videoAddToWatchLater => '加入稍後觀看';

  @override
  String get videoCoin => '投幣';

  @override
  String get videoSupporterOnly => '充電專屬';

  @override
  String get videoInteractive => '互動影片';

  @override
  String get videoSponsorBlockSourceSync => '同步 SponsorBlock 影片來源';

  @override
  String videoSponsorBlockAlreadyLinked(String videoId) {
    return '已連結 YouTube 影片 $videoId';
  }

  @override
  String videoSponsorBlockConfirmLink(String videoId) {
    return '確定將此影片連結至 YouTube 影片 $videoId？';
  }

  @override
  String get videoSponsorBlockLinkSucceeded => '來源連結成功';

  @override
  String videoSponsorBlockLinkFailed(String error) {
    return '來源連結失敗：$error';
  }

  @override
  String get videoAiSummaryNotSupported => '目前影片暫不支援 AI 摘要';

  @override
  String get videoAiSummary => 'AI 摘要';

  @override
  String videoBgmPrefix(String content) {
    return 'BGM：$content';
  }

  @override
  String get videoGreatCoined => '已完成 Great Coined';

  @override
  String get videoCoinFailed => '投幣失敗';

  @override
  String get videoGreatCoinedSucceeded => 'Great Coined 成功';

  @override
  String get videoDislikeSucceeded => '倒讚成功';

  @override
  String get videoRemoveDislikeSucceeded => '已取消倒讚';

  @override
  String get videoShareAtCurrentTime => '從目前時間開始分享';

  @override
  String get videoShareVideo => '分享影片';

  @override
  String videoShareText(String title, String uploader, String url) {
    return '$title\nUploader：$uploader\n$url';
  }

  @override
  String get videoShareToFeed => '分享到動態';

  @override
  String get videoShareToMessages => '分享到訊息';

  @override
  String get videoNoRelatedVideosStopAutoplay => '沒有更多相關影片，已停止自動播放';

  @override
  String get videoLoadingAiSummary => '正在載入 AI 摘要…';

  @override
  String get videoAiProcessing => 'AI 摘要正在產生，請稍後再試';

  @override
  String get videoFollowAnime => '追番';

  @override
  String get videoFollowSeries => '追劇';

  @override
  String videoRating(String score) {
    return '評分 $score';
  }

  @override
  String videoAlreadyFollowing(String type) {
    return '已$type';
  }

  @override
  String videoDescriptionWithContent(String description) {
    return '簡介：$description';
  }

  @override
  String get videoRemovedFromFavorites => '已取消收藏';

  @override
  String get videoAddedToFavorites => '已加入收藏';

  @override
  String videoMarkAs(String status) {
    return '標記為$status';
  }

  @override
  String get videoStatusWatched => '看過';

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
    return '開始：$value';
  }

  @override
  String videoSegmentEnd(String value) {
    return '結束：$value';
  }

  @override
  String get videoSegmentSetCurrent => '設為目前時間';

  @override
  String get videoSegmentVideoStart => '影片開頭';

  @override
  String get videoSegmentVideoEnd => '影片結尾';

  @override
  String get videoSegmentAdd => '新增片段';

  @override
  String get videoSegmentConfirmBeforeSubmit => '確認無誤後再提交';

  @override
  String get videoSegmentConfirmSubmit => '確定提交';

  @override
  String get videoSegmentCategory => '分類';

  @override
  String get videoSegmentAction => '動作類別';

  @override
  String get videoSegmentProgressBar => '片段進度條';

  @override
  String videoResumeAtPart(int part) {
    return '上次看到第 ${part}P，點選跳轉';
  }

  @override
  String videoJumpedToPart(int part) {
    return '已跳至第 ${part}P';
  }

  @override
  String get videoExclusiveTrial => '此影片為專屬影片，僅提供試看';

  @override
  String get videoResourceUnavailable => '影片資源不存在';

  @override
  String get videoCoinLimitReached => '已達投幣上限';

  @override
  String get videoNotEnoughCoins => '硬幣不足';

  @override
  String videoCoinBalance(String balance) {
    return '硬幣餘額：$balance';
  }

  @override
  String get videoAlreadyCoinedOne => '已投 1 枚硬幣';

  @override
  String videoCoinBalanceAndCoined(String balance) {
    return '硬幣餘額：$balance，已投 1 枚硬幣';
  }

  @override
  String get videoCoinAndLike => '同時按讚';

  @override
  String get videoEpisodes => '影片選集';

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
    return '連載中，更新至$episode';
  }

  @override
  String videoEpisodeNumber(int number) {
    return '第 $number 話';
  }

  @override
  String get videoReviews => '點評';

  @override
  String get videoSummary => '簡介';

  @override
  String get videoCastAndCrew => '演職人員';

  @override
  String videoCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '共 $count 部影片',
    );
    return '$_temp0';
  }

  @override
  String get videoTypePlaybackNotSupported => '不支援播放此類型影片';

  @override
  String get videoConfirmRemove => '確定移除此影片？';

  @override
  String videoNotesCount(int count) {
    return '筆記（$count）';
  }

  @override
  String get videoStartTakingNotes => '開始記筆記';

  @override
  String videoVisitUploader(String name) {
    return '造訪：$name';
  }

  @override
  String get videoNotInterested => '不感興趣';

  @override
  String get videoDoNotWantToSee => '我不想看';

  @override
  String get videoWebFineSelectionUnsupported => 'Web 端暫不支援詳細選擇';

  @override
  String videoBlockUploader(String name) {
    return '封鎖：$name';
  }

  @override
  String videoConfirmBlockUploader(String name, String id) {
    return '確定封鎖 $name（$id）？\n\n可在隱私設定的封鎖名單管理中解除封鎖此 Uploader。';
  }

  @override
  String get timeJustNow => '剛剛';

  @override
  String timeMinutesAgo(int count) {
    return '$count 分鐘前';
  }

  @override
  String timeHoursAgo(int count) {
    return '$count 小時前';
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
    return '$count個月';
  }

  @override
  String durationDays(int count) {
    return '$count天';
  }

  @override
  String durationHours(int count) {
    return '$count小時';
  }

  @override
  String durationMinutes(int count) {
    return '$count分鐘';
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
  String get homePgcSchedule => '追番時間表';

  @override
  String get homeToday => '今天';

  @override
  String homeWeekday(String weekday) {
    return '週$weekday';
  }

  @override
  String get homeRecommendations => '推薦';

  @override
  String get homeMediaIndex => '索引';

  @override
  String get homeAllMedia => '全部';

  @override
  String get homeMovies => '電影';

  @override
  String get homeTvShows => '電視劇';

  @override
  String get homeDocumentaries => '紀錄片';

  @override
  String get homeVarietyShows => '綜藝';

  @override
  String homeRecentAnime(String count) {
    return '最近追番$count';
  }

  @override
  String homeRecentSeries(String count) {
    return '最近追劇$count';
  }

  @override
  String get homeNoAnime => '還沒有追番';

  @override
  String get homeNoSeries => '還沒有追劇';

  @override
  String get feedAll => '全部';

  @override
  String get feedUploads => '投稿';

  @override
  String get feedAnime => '番劇';

  @override
  String get feedArticles => '專欄';

  @override
  String get feedUploader => 'UP';

  @override
  String get feedCreatePost => '發佈動態';

  @override
  String get feedAllUpdates => '全部動態';

  @override
  String get feedMe => '我';

  @override
  String get feedLiveEnded => '直播結束';

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
    return '$count彈幕';
  }

  @override
  String get feedExpired => '已失效';

  @override
  String feedUnsupportedType(String id, String type) {
    return '暫未支援的類型：\n$id\n$type';
  }

  @override
  String get followMyFollowing => '我的關注';

  @override
  String followUserFollowing(String name) {
    return '$name的關注';
  }

  @override
  String get followNewGroup => '新增分組';

  @override
  String get followSortGroups => '分組排序';

  @override
  String get followBlockedUsers => '封鎖名單管理';

  @override
  String get followShared => '我們的共同關注';

  @override
  String get followAll => '全部關注';

  @override
  String get followMostRecent => '最近關注';

  @override
  String get followMostVisited => '最常造訪';

  @override
  String get followEditGroupName => '編輯分組名稱';

  @override
  String get followRenameGroup => '修改名稱';

  @override
  String get followDeleteGroup => '刪除分組';

  @override
  String get followDeleteGroupDescription => '刪除後，該分組下的使用者依舊保留。';

  @override
  String get followUpdateSucceeded => '修改成功';

  @override
  String get followDeleteSucceeded => '刪除成功';

  @override
  String get feedSupporterOnly => '充電專屬';

  @override
  String get feedPollOptions => '投票選項';

  @override
  String get feedPollEnded => '已結束';

  @override
  String get feedPollCompleted => '已完成';

  @override
  String get feedPoll => '投票';

  @override
  String get feedFollowedPeopleVotes => '關注的人的投票';

  @override
  String get feedVotedFor => '投給了';

  @override
  String feedPollEndsAt(String time) {
    return '至 $time';
  }

  @override
  String feedParticipantCount(String count) {
    return '$count人參與';
  }

  @override
  String get feedShowPercentage => '顯示比例';

  @override
  String get feedAnonymous => '匿名';

  @override
  String get feedMoreActions => '更多';

  @override
  String get feedWatchLater => '稍後再看';

  @override
  String get feedSavePost => '儲存動態';

  @override
  String get feedSharePost => '分享動態';

  @override
  String get feedShareToMessages => '分享至訊息';

  @override
  String feedBlockAuthorPosts(String name) {
    return '隱藏 $name 的動態';
  }

  @override
  String feedAuthorPostsBlocked(String name, String id) {
    return '已隱藏 $name（$id）的動態';
  }

  @override
  String feedUnblockAuthorPosts(String name) {
    return '取消隱藏 $name 的動態';
  }

  @override
  String feedAuthorPostsUnblocked(String name) {
    return '已取消隱藏 $name 的動態';
  }

  @override
  String get feedCheckPost => '檢查動態';

  @override
  String get feedPinPost => '置頂';

  @override
  String get feedUnpinPost => '取消置頂';

  @override
  String get feedEnableFeaturedComments => '開啟評論精選';

  @override
  String get feedDisableFeaturedComments => '停止評論精選';

  @override
  String get feedDisableComments => '關閉評論';

  @override
  String get feedRestoreComments => '恢復評論';

  @override
  String get feedInteractionSettings => '互動設定';

  @override
  String get feedVisibleToEveryone => '所有使用者可見';

  @override
  String get feedVisibleOnlyToMe => '僅自己可見';

  @override
  String get feedVisibility => '可見範圍';

  @override
  String get feedEditPost => '編輯動態';

  @override
  String get feedConfirmDeletePost => '確定刪除該動態？';

  @override
  String get feedExpand => '展開';

  @override
  String get feedPriceFrom => '起';

  @override
  String get feedJoin => '參與';

  @override
  String get feedComment => '評論';

  @override
  String get feedWebLink => '網頁連結';

  @override
  String get followGroupSortTitle => '關注分組排序';

  @override
  String get followSortCompleted => '排序完成';

  @override
  String followAlsoFollowed(int count, String name) {
    return '我關注的 $count 人也關注了 $name';
  }

  @override
  String get followUnknownPerson => 'TA';

  @override
  String get followActionFollow => '關注';

  @override
  String get followActionFollowing => '已關注';

  @override
  String followSharedWithUser(String name) {
    return '我與 $name 的共同關注';
  }

  @override
  String get settingsSignInRequired => '登入後查看';

  @override
  String get settingsBlockedUsersManagement => '封鎖名單管理';

  @override
  String get settingsBlockedUsersDescription => '已封鎖使用者';

  @override
  String get settingsAccountModeDetails => '帳號模式詳情';

  @override
  String get settingsLearnAccountModes => '了解帳號模式';

  @override
  String get settingsAccountModesApiDescription => '查看各個帳號模式所使用的 API 清單';

  @override
  String get settingsAccountModeMain => '主帳號';

  @override
  String get settingsAccountModeWatchHistory => '記錄觀看';

  @override
  String get settingsAccountModeRecommendation => '推薦';

  @override
  String get settingsAccountModeVideoStream => '影片串流';

  @override
  String get settingsUseAppRecommendations => '首頁使用 App 端推薦';

  @override
  String get settingsUseAppRecommendationsDescription =>
      '若 Web 端推薦不太符合預期，可嘗試切換至 App 端推薦';

  @override
  String get settingsKeepPreviousRecommendations => '保留首頁推薦重新整理';

  @override
  String get settingsKeepPreviousRecommendationsDescription => '下拉重新整理時保留上次內容';

  @override
  String get settingsShowLastPosition => '顯示上次看到位置提示';

  @override
  String get settingsShowLastPositionDescription => '保留上次推薦時，在上次重新整理位置顯示提示';

  @override
  String get settingsLikeRatio => '按讚率';

  @override
  String get settingsTitleKeywordFilter => '標題關鍵字過濾';

  @override
  String get settingsCategoryKeywordFilter => 'App 推薦／熱門／排行榜：影片分區關鍵字過濾';

  @override
  String get settingsVideoDuration => '影片時長';

  @override
  String get settingsPlayCount => '播放量';

  @override
  String get settingsExemptFollowedUploaders => '已關注 UP 豁免推薦過濾';

  @override
  String get settingsExemptFollowedUploadersDescription =>
      '推薦中已關注使用者發佈的內容不會被過濾';

  @override
  String get settingsApplyFilterToRelatedVideos => '過濾器也套用於詳情頁相關影片';

  @override
  String get settingsApplyFilterToRelatedVideosDescription =>
      '熱門影片、搜尋等其它頁面不受過濾器影響；相關影片中的已關注 UP 無法豁免';

  @override
  String get settingsTapToAdd => '點擊新增';

  @override
  String get settingsKeywordSeparatorHelp => '使用 | 隔開，例如：嘗試|測試';

  @override
  String get settingsSaved => '已儲存';

  @override
  String settingsFilterTitle(String title) {
    return '$title過濾';
  }

  @override
  String settingsFilterBelow(String title, int value, String suffix) {
    return '過濾掉$title小於「$value$suffix」的影片';
  }

  @override
  String settingsCurrentNamedValue(String title, int value, String suffix) {
    return '目前$title：「$value$suffix」';
  }

  @override
  String settingsChooseFilterValue(String title, String filterHint) {
    return '選擇$title$filterHint';
  }

  @override
  String get settingsZeroDisablesFilter => '（0 即不過濾）';

  @override
  String get settingsCustomValue => '自訂';

  @override
  String settingsCustomNamedValue(String title) {
    return '自訂$title';
  }

  @override
  String get settingsChooseAccountsToSignOut => '選擇要登出的帳號 UID';

  @override
  String settingsConfirmSignOutAccounts(String accounts) {
    return '確認要退出以下帳號登入嗎？\n\n$accounts';
  }

  @override
  String get settingsSignOutCancel => '點錯了';

  @override
  String get settingsSignOutOnly => '僅登出';

  @override
  String get settingsDanmakuEnabled => '彈幕開關';

  @override
  String get settingsDanmakuEnabledDescription => '是否顯示彈幕';

  @override
  String get settingsTapDanmaku => '啟用點擊彈幕';

  @override
  String get settingsTapDanmakuDescription => '點擊彈幕暫停，支援按讚、複製、檢舉操作';

  @override
  String get settingsPlaybackSpeed => '倍速設定';

  @override
  String get settingsPlaybackSpeedDescription => '設定影片播放速度';

  @override
  String get settingsTiltAngleThreshold => '傾斜角度閾值';

  @override
  String get settingsAutoplay => '自動播放';

  @override
  String get settingsAutoplayDescription => '進入詳情頁自動播放';

  @override
  String get settingsFullscreenLockButton => '全螢幕顯示鎖定按鈕';

  @override
  String get settingsFullscreenScreenshotButton => '全螢幕顯示截圖按鈕';

  @override
  String get settingsFullscreenBattery => '全螢幕顯示電池電量';

  @override
  String get settingsDoubleTapSeek => '雙擊倒退／快進';

  @override
  String get settingsDoubleTapSeekDescription => '左側雙擊倒退，右側雙擊快進；關閉後雙擊均為暫停／播放';

  @override
  String get settingsSlideBrightnessVolume => '左右側滑動調節亮度／音量';

  @override
  String get settingsSystemBrightness => '調節系統亮度';

  @override
  String get settingsSlideFullscreen => '中間滑動進入／退出全螢幕';

  @override
  String get settingsPlayerVolume => '播放器音量';

  @override
  String get settingsMaximumVolume => '最高音量';

  @override
  String get settingsDoubleTapSeekDuration => '雙擊快進／倒退時長';

  @override
  String get settingsRelativeSlideSeek => '滑動快進／倒退使用相對時長';

  @override
  String get settingsSlideSeekDuration => '滑動快進／倒退時長';

  @override
  String get settingsSlideSeekDurationDescription => '從播放器一端滑到另一端的快進／倒退時長';

  @override
  String get settingsAutomaticSubtitles => '自動啟用字幕';

  @override
  String settingsCurrentPreference(String value) {
    return '目前選擇偏好：$value';
  }

  @override
  String get settingsPauseWhenMinimized => '最小化時暫停／還原時播放';

  @override
  String get settingsKeyboardControls => '啟用鍵盤控制';

  @override
  String get settingsSuperChatDisplay => 'SuperChat（醒目留言）顯示類型';

  @override
  String get settingsFullscreenSuperChatSize => '全螢幕 SC 大小';

  @override
  String get settingsFullscreenSuperChatSizeDescription =>
      'SuperChat（醒目留言）大小設定';

  @override
  String get settingsExpandPortraitVideo => '直向擴大顯示';

  @override
  String get settingsExpandPortraitVideoDescription =>
      '小螢幕直向影片寬高比由 16:9 擴大至 1:1；橫向適配時擴大至 9:16';

  @override
  String get settingsAutoEnterFullscreen => '自動全螢幕';

  @override
  String get settingsAutoEnterFullscreenDescription => '影片開始播放時進入全螢幕';

  @override
  String get settingsAutoExitFullscreen => '自動退出全螢幕';

  @override
  String get settingsAutoExitFullscreenDescription => '影片結束播放時退出全螢幕';

  @override
  String get settingsExtendPlayerControls => '延長播放控制項顯示時間';

  @override
  String get settingsExtendPlayerControlsDescription =>
      '開啟後延長至 30 秒，便於螢幕閱讀器滑動切換控制項焦點';

  @override
  String get settingsBackgroundPlayback => '背景播放';

  @override
  String get settingsBackgroundPlaybackDescription => '進入背景時繼續播放';

  @override
  String get settingsBackgroundPictureInPicture => '背景子母畫面';

  @override
  String get settingsBackgroundPictureInPictureDescription =>
      '進入背景時以小窗形式（PiP）播放';

  @override
  String get settingsEnableBackgroundAudioSuggestion => '建議開啟背景音訊服務';

  @override
  String get settingsHideDanmakuInPictureInPicture => '子母畫面不載入彈幕';

  @override
  String get settingsHideDanmakuInPictureInPictureDescription =>
      '小窗播放時隱藏彈幕以獲得更好的體驗';

  @override
  String get settingsReverseFullscreenGesture => '全螢幕手勢反向';

  @override
  String get settingsReverseFullscreenGestureDescription =>
      '預設向上滑動進入全螢幕、向下退出；開啟後方向相反';

  @override
  String get settingsFullscreenActionButtons => '全螢幕顯示按讚、投幣、收藏等操作按鈕';

  @override
  String get settingsOnlineViewerCount => '觀看人數';

  @override
  String get settingsOnlineViewerCountDescription => '顯示同時在看人數';

  @override
  String get settingsDefaultFullscreenOrientation => '預設全螢幕方向';

  @override
  String settingsCurrentFullscreenOrientation(String value) {
    return '目前全螢幕方向：$value';
  }

  @override
  String get settingsBottomProgressBar => '底部進度條顯示';

  @override
  String settingsCurrentBottomProgressBar(String value) {
    return '目前顯示方式：$value';
  }

  @override
  String get settingsBackgroundAudioService => '背景音訊服務';

  @override
  String get settingsBackgroundAudioServiceDescription => '避免子母畫面沒有播放暫停功能';

  @override
  String get settingsPlaybackOrder => '播放順序';

  @override
  String get settingsTemporaryPlayerSettings => '播放器設定僅對目前影片生效';

  @override
  String get settingsTemporaryPlayerSettingsDescription => '彈幕、字幕及部分設定中沒有的選項除外';

  @override
  String get settingsSubtitlePreference => '字幕選擇偏好';

  @override
  String get settingsSubtitlePreferenceOff => '預設不顯示字幕';

  @override
  String get settingsSubtitlePreferencePreferHuman => '優先選擇非自動產生（AI）字幕';

  @override
  String get settingsSubtitlePreferenceSkipAi => '跳過自動產生（AI）字幕，選擇第一個可用字幕';

  @override
  String get settingsSubtitlePreferenceAuto => '靜音時優先非自動字幕，非靜音時跳過自動字幕';

  @override
  String get settingsSuperChatValidOnly => '有效時間內顯示';

  @override
  String get settingsSuperChatPersistent => '常駐顯示';

  @override
  String get settingsSuperChatDisabled => '不顯示';

  @override
  String get settingsFullscreenOrientationAuto => '按影片方向（預設）';

  @override
  String get settingsFullscreenOrientationUnchanged => '不改變目前方向';

  @override
  String get settingsFullscreenOrientationPortrait => '強制直向';

  @override
  String get settingsFullscreenOrientationLandscape => '強制橫向';

  @override
  String settingsFullscreenOrientationRatio(double ratio) {
    return '螢幕長寬比小於 $ratio 或為直向影片時直向，否則橫向';
  }

  @override
  String get settingsFullscreenOrientationGravity =>
      '忽略系統方向鎖定，強制按重力旋轉（僅 Android）';

  @override
  String get settingsProgressAlwaysShow => '始終顯示';

  @override
  String get settingsProgressAlwaysHide => '始終隱藏';

  @override
  String get settingsProgressFullscreenOnly => '僅全螢幕時顯示';

  @override
  String get settingsProgressHideFullscreen => '僅全螢幕時隱藏';

  @override
  String get settingsHardwareDecoding => '開啟硬解';

  @override
  String get settingsHardwareDecodingDescription => '以較低功耗播放影片，若異常卡死請關閉';

  @override
  String get settingsGuest1080p => '免登入 1080P';

  @override
  String get settingsGuest1080pDescription => '未登入時也嘗試播放 1080P 影片';

  @override
  String get settingsBilibiliDataPlan => 'B 站定向流量支援';

  @override
  String get settingsBilibiliDataPlanDescription =>
      '若方案含 B 站定向流量則會自動使用，可查閱電信商的流量記錄確認';

  @override
  String get settingsCdn => 'CDN 設定';

  @override
  String settingsCurrentCdn(String value) {
    return '目前使用：$value。部分 CDN 可能失效，如無法播放請嘗試切換';
  }

  @override
  String get settingsLiveCdn => '直播 CDN 設定';

  @override
  String settingsCurrentSource(String value) {
    return '目前使用：$value';
  }

  @override
  String get settingsCdnSpeedTest => 'CDN 測速';

  @override
  String get settingsCdnSpeedTestDescription => '測速透過模擬載入影片實現，請注意流量消耗，結果僅供參考';

  @override
  String get settingsSeparateAudioCdn => '音訊不跟隨 CDN 設定';

  @override
  String get settingsSeparateAudioCdnDescription => '直接採用備用 URL，可解決部分影片無聲';

  @override
  String get settingsDefaultVideoQuality => '預設畫質';

  @override
  String get settingsCellularVideoQuality => '行動網路畫質';

  @override
  String get settingsDefaultAudioQuality => '預設音質';

  @override
  String get settingsCellularAudioQuality => '行動網路音質';

  @override
  String get settingsDefaultLiveQuality => '直播預設畫質';

  @override
  String get settingsCellularLiveQuality => '行動網路直播預設畫質';

  @override
  String settingsCurrentVideoQuality(String value) {
    return '目前畫質：$value';
  }

  @override
  String settingsCurrentAudioQuality(String value) {
    return '目前音質：$value';
  }

  @override
  String get settingsPreferredCodecs => '首選解碼格式';

  @override
  String settingsPreferredCodecsDescription(String value) {
    return '首選解碼格式：$value。請根據裝置支援情況與需求調整';
  }

  @override
  String get settingsAudioOutput => '音訊輸出裝置';

  @override
  String get settingsBufferSize => '緩衝大小';

  @override
  String settingsBufferSizeDescription(double value) {
    return '目前：$value MB。此值同時作為前向和後向緩衝區大小；直播串流會全部用於前向緩衝（mpv：--demuxer-max-bytes、--demuxer-max-back-bytes）';
  }

  @override
  String get settingsBufferDuration => '緩衝時長';

  @override
  String settingsBufferDurationDescription(double value) {
    return '目前：$value 秒。實際緩衝取大小與時長限制中的較小值；直播串流不使用此項（mpv：--cache-secs）';
  }

  @override
  String get settingsAutoSync => '自動同步';

  @override
  String settingsAutoSyncDescription(String value) {
    return '目前：$value（mpv：--autosync）';
  }

  @override
  String get settingsVideoSync => '影片同步';

  @override
  String settingsVideoSyncDescription(String value) {
    return '目前：$value（mpv：--video-sync）';
  }

  @override
  String get settingsHardwareDecodingMode => '硬解模式';

  @override
  String settingsHardwareDecodingModeDescription(String value) {
    return '目前：$value（mpv：--hwdec）';
  }

  @override
  String get settingsEnterCdnHost => '輸入 CDN Host';

  @override
  String get settingsLiveQualityDolby => '杜比';

  @override
  String get settingsLiveQuality4kOriginal => '4K 原畫';

  @override
  String get settingsLiveQuality4k => '4K';

  @override
  String get settingsLiveQuality2k => '2K';

  @override
  String get settingsLiveQualityOriginal => '原畫';

  @override
  String get settingsLiveQualityBluRay => '藍光';

  @override
  String get settingsLiveQualitySuperHd => '超清';

  @override
  String get settingsLiveQualityHd => '高清';

  @override
  String get settingsLiveQualitySmooth => '流暢';

  @override
  String get settingsHwdecSoftware => '啟用軟解';

  @override
  String get settingsHwdecAny => '啟用任意可用解碼器';

  @override
  String get settingsHwdecBest => '啟用最佳解碼器';

  @override
  String get settingsHwdecBestCopy => '啟用帶拷貝功能的最佳解碼器';

  @override
  String get settingsHwdecNonDirect => '非直通';

  @override
  String settingsHwdecExclusive(String vendor) {
    return '$vendor 獨占';
  }

  @override
  String get settingsHwdecExperimental => '實驗性';

  @override
  String get settingsHwdecDeprecated => '已過時';

  @override
  String get settingsHwdecAllPlatforms => '全平台';

  @override
  String get settingsHwdecPartialRockchip => '僅部分 Rockchip 晶片';

  @override
  String get settingsWindowTitleBar => '顯示視窗標題列';

  @override
  String get settingsTrayIcon => '顯示系統匣圖示';

  @override
  String get settingsLandscapeLayout => '橫向適配';

  @override
  String get settingsLandscapeLayoutDescription =>
      '啟用橫向版面與邏輯，平板、摺疊螢幕等可開啟；建議全螢幕方向設為「不改變目前方向」';

  @override
  String get settingsUseSidebar => '改用側邊欄';

  @override
  String get settingsUseSidebarDescription => '開啟後底欄與頂欄會被替換，相關設定將失效';

  @override
  String get settingsUiScale => '介面縮放';

  @override
  String settingsCurrentUiScale(String value) {
    return '目前縮放比例：$value';
  }

  @override
  String get settingsPageTransition => '頁面過渡動畫';

  @override
  String get settingsOptimizeTabletNavigation => '最佳化平板導覽列';

  @override
  String get settingsMaterialYouBottomBar => 'MD3 樣式底欄';

  @override
  String get settingsMaterialYouBottomBarDescription =>
      'Material You 設計規範底欄，關閉後可變窄';

  @override
  String get settingsFloatingBottomBar => '懸浮底欄';

  @override
  String get settingsListWidthLimit => '清單寬度（dp）限制';

  @override
  String settingsListWidthDescription(int home, int other, String screen) {
    return '目前：首頁 $home dp，其他 $other dp，螢幕寬度 $screen dp。寬度越小，欄數越多。';
  }

  @override
  String get settingsRemovePlayerSafeArea => '播放頁移除安全邊距';

  @override
  String get settingsDarkVideoPage => '影片播放頁使用深色主題';

  @override
  String get settingsFeedWaterfall => 'Feed 啟用瀑布流';

  @override
  String get settingsFeedWaterfallDescription => '關閉後顯示為單欄';

  @override
  String get settingsFeedUploaderPosition => 'Feed Uploader 顯示位置';

  @override
  String get settingsShowAllFollowedUploaders => 'Feed 顯示所有已關注 Uploader';

  @override
  String get settingsExpandLiveUploaders => 'Feed 展開正在直播的 Uploader 清單';

  @override
  String get settingsFeedUnreadBadge => 'Feed 未讀標記';

  @override
  String get settingsMessageUnreadBadge => '訊息未讀標記';

  @override
  String settingsCurrentBadgeStyle(String value) {
    return '目前標記樣式：$value';
  }

  @override
  String get settingsMessageUnreadTypes => '訊息未讀類型';

  @override
  String settingsCurrentMessageTypes(String value) {
    return '目前訊息類型：$value';
  }

  @override
  String get settingsBarCollapseBehavior => '頂／底欄收起類型';

  @override
  String get settingsCollapseHomeTopBar => '首頁頂欄收起';

  @override
  String get settingsCollapseHomeTopBarDescription => '首頁清單滑動時收起頂欄';

  @override
  String get settingsCollapseHomeBottomBar => '首頁底欄收起';

  @override
  String get settingsCollapseHomeBottomBarDescription => '首頁清單滑動時收起底欄';

  @override
  String get settingsImageQuality => '圖片品質';

  @override
  String get settingsImagePreviewQuality => '查看大圖品質';

  @override
  String get settingsImageQualityDescription => '選擇合適的圖片清晰度，上限 100%';

  @override
  String get settingsDarkImageOverlay => '深色下圖片顏色疊加';

  @override
  String get settingsDarkImageOverlayDescription => '顯示顏色＝圖片原色 × 所選顏色；大圖查看不受影響';

  @override
  String get settingsToastOpacity => '氣泡提示不透明度';

  @override
  String get settingsToastOpacityDescription => '自訂氣泡提示（Toast）不透明度';

  @override
  String get settingsThemeMode => '主題模式';

  @override
  String settingsCurrentMode(String value) {
    return '目前模式：$value';
  }

  @override
  String get settingsPureBlackTheme => '純黑主題';

  @override
  String get settingsAppTheme => '應用程式主題';

  @override
  String settingsCurrentTheme(String value) {
    return '目前主題：$value';
  }

  @override
  String get settingsDynamicColor => '動態取色';

  @override
  String get settingsExPiliPlusCustomColor => 'ExPiliPlus 自訂顏色';

  @override
  String get settingsSpecifiedColor => '指定顏色';

  @override
  String get settingsDefaultStartPage => '預設啟動頁';

  @override
  String settingsCurrentStartPage(String value) {
    return '目前啟動頁：$value';
  }

  @override
  String get settingsSpringParameters => '滑動動畫彈簧參數';

  @override
  String get settingsFontSize => '字型大小';

  @override
  String get settingsHomeTabs => '首頁標籤頁';

  @override
  String get settingsHomeTabsDescription => '刪除或調換首頁標籤頁';

  @override
  String get settingsNavigationBarEditor => 'Navbar 編輯';

  @override
  String get settingsNavigationBarEditorDescription => '刪除或調換 Navbar';

  @override
  String get settingsExitDirectlyOnBack => '返回時直接退出';

  @override
  String get settingsExitDirectlyOnBackDescription =>
      '開啟後，在首頁任意標籤頁按返回鍵都會直接退出；關閉後先回到 Navbar 的第一個標籤頁';

  @override
  String get settingsScreenRefreshRate => '螢幕更新率';

  @override
  String get settingsSucceeded => '設定成功';

  @override
  String get settingsRestartRequired => '重新啟動後生效';

  @override
  String get settingsSucceededRestartRequired => '設定成功，重新啟動後生效';

  @override
  String get settingsReset => '重設';

  @override
  String get settingsResetSucceededRestartRequired => '重設成功，重新啟動後生效';

  @override
  String get settingsScaleRatio => '縮放比例';

  @override
  String get settingsSpringParametersTitle => '彈簧參數';

  @override
  String get settingsSpringDurationMode => '滑動時間';

  @override
  String get settingsSpringPhysicalMode => '物理參數';

  @override
  String get settingsListMaxColumnWidth => '清單最大欄寬（預設 240 dp）';

  @override
  String get settingsHomeRecommendationFeed => '首頁推薦流';

  @override
  String settingsConfirmDarkColor(String color) {
    return '確認使用 $color？';
  }

  @override
  String get settingsDarkColorWarning => '所選顏色過於昏暗，可能會影響圖片觀看';

  @override
  String get settingsUseServerSideDecoration =>
      '使用 SSD（Server-Side Decoration）';

  @override
  String get settingsUpPositionTop => '頂部';

  @override
  String get settingsUpPositionLeftFixed => '左側常駐';

  @override
  String get settingsUpPositionRightFixed => '右側常駐';

  @override
  String get settingsUpPositionLeftDrawer => '左側抽屜';

  @override
  String get settingsUpPositionRightDrawer => '右側抽屜';

  @override
  String get settingsBadgeHidden => '隱藏';

  @override
  String get settingsBadgeDot => '紅點';

  @override
  String get settingsBadgeNumber => '數字';

  @override
  String get settingsUnreadPrivateMessages => '私訊';

  @override
  String get settingsUnreadReplies => '回覆我的';

  @override
  String get settingsUnreadMentions => '@我';

  @override
  String get settingsUnreadLikes => '收到的讚';

  @override
  String get settingsUnreadSystem => '系統通知';

  @override
  String get settingsBarCollapseInstant => '即時';

  @override
  String get settingsBarCollapseSynchronized => '同步';

  @override
  String get settingsMinimizeOnExit => '退出時最小化';

  @override
  String get settingsCachePath => '快取路徑';

  @override
  String get settingsSponsorBlock => '空降助手';

  @override
  String get settingsAnimeIntroOutroSkip => '番劇片頭／片尾跳過類型';

  @override
  String get settingsCheckUnreadFeed => '檢查未讀 Feed';

  @override
  String get settingsCheckUnreadFeedDescription => '點擊設定檢查週期（分鐘）';

  @override
  String get settingsVideoChapters => '顯示影片分段資訊';

  @override
  String get settingsRelatedVideos => '影片頁顯示相關影片';

  @override
  String get settingsVideoComments => '顯示影片評論';

  @override
  String get settingsAnimeComments => '顯示番劇評論';

  @override
  String get settingsExpandVideoDescription => '預設展開影片簡介';

  @override
  String get settingsExpandVideoDescriptionLandscape => '橫向自動展開影片簡介';

  @override
  String get settingsLandscapeEpisodeTabs => '橫向分 P／合集清單顯示在 Tab 欄';

  @override
  String get settingsLandscapeUploaderSidebar => '橫向播放頁在側欄開啟 Uploader 首頁';

  @override
  String get settingsLandscapeImagePreview => '橫向在側欄開啟圖片預覽';

  @override
  String get settingsCommentFoldLines => '評論折疊行數';

  @override
  String get settingsZeroLinesDoNotFold => '0 行時不折疊';

  @override
  String settingsLineCount(String count) {
    return '$count 行';
  }

  @override
  String get settingsDanmakuLineHeight => '彈幕行高';

  @override
  String settingsDefaultNumber(String value) {
    return '預設 $value';
  }

  @override
  String get settingsVideoWarnings => '顯示影片警告／爭議資訊';

  @override
  String get settingsFeedWarnings => '顯示 Feed 警告／爭議資訊';

  @override
  String get settingsReverseEpisodesFromFirst => '分 P／合集：倒序播放從首集開始';

  @override
  String get settingsReverseEpisodesFromFirstDescription =>
      '開啟後自動切換到倒序首集，否則保持目前集';

  @override
  String get settingsDisableSslVerification => '停用 SSL 憑證驗證';

  @override
  String get settingsDisableSslVerificationDescription => '請謹慎開啟，停用後容易受到中間人攻擊';

  @override
  String get settingsContinuePartPrompt => '顯示繼續播放分 P 提示';

  @override
  String get settingsCommentKeywordFilter => '評論關鍵字過濾';

  @override
  String get settingsFeedKeywordFilter => 'Feed 關鍵字過濾';

  @override
  String get settingsExternalBrowser => '使用外部瀏覽器開啟連結';

  @override
  String get settingsHorizontalSwipeThreshold => '橫向滑動閾值';

  @override
  String settingsCurrentAndSystemDefault(String current, String defaultValue) {
    return '目前：$current；系統預設值：$defaultValue';
  }

  @override
  String get settingsRefreshDragDistance => '重新整理滑動距離';

  @override
  String settingsCurrentMultiplier(String value) {
    return '目前：$value×';
  }

  @override
  String get settingsRefreshIndicatorHeight => '重新整理指示器高度';

  @override
  String get settingsVipDanmaku => '顯示會員彩色彈幕';

  @override
  String get settingsMergeDanmaku => '合併彈幕';

  @override
  String get settingsMergeDanmakuDescription => '合併一段時間內取得到的相同彈幕';

  @override
  String get settingsTrendingRecommendations => '顯示熱門推薦';

  @override
  String get settingsTrendingRecommendationsDescription => '熱門頁面顯示每週必看等推薦內容入口';

  @override
  String get settingsAudioNormalization => '音量均衡';

  @override
  String get settingsFallbackNormalization => '伺服器無 loudnorm 設定時使用';

  @override
  String settingsFallbackValue(String value) {
    return '無參數時：$value';
  }

  @override
  String get settingsAudioNormalizationDisabled => '停用';

  @override
  String get settingsAudioNormalizationDynaudnorm => '預設 dynaudnorm';

  @override
  String get settingsAudioNormalizationLoudnorm => '預設 loudnorm';

  @override
  String get settingsCustomParameters => '自訂參數';

  @override
  String get settingsAudioNormalizationParameterHelp =>
      '等同於 --lavfi-complex=\"[aid1] 參數 [ao]\"';

  @override
  String get settingsSuperResolution => '超解析度';

  @override
  String settingsSuperResolutionDescription(String value) {
    return '目前：$value\n預設設定對番劇生效，其它影片預設關閉\n超解析度需要啟用硬體解碼；若仍未生效，請嘗試將硬體解碼器切換為 auto-copy';
  }

  @override
  String get settingsPreinitializePlayer => '提前初始化播放器';

  @override
  String get settingsPreinitializePlayerDescription => '相對減少手動播放的載入時間';

  @override
  String get settingsHomePageAnimation => '首頁切換頁面動畫';

  @override
  String get settingsSearchSuggestions => '搜尋建議';

  @override
  String get settingsSearchHistory => '記錄搜尋歷史';

  @override
  String get settingsShowDecorations => '顯示頭像、評論和 Feed 裝飾';

  @override
  String get settingsFanMedals => '顯示粉絲勳章';

  @override
  String get settingsLivePhotoPreview => '預覽 Live Photo';

  @override
  String get settingsLivePhotoPreviewDescription =>
      '開啟後以影片形式預覽 Live Photo，否則預覽靜態圖片';

  @override
  String get settingsSeekPreviewThumbnails => '滑動跳轉預覽影片縮圖';

  @override
  String get settingsDanmakuHeatmap => '顯示高能進度條';

  @override
  String get settingsDanmakuHeatmapDescription => '高能進度條反映單位時間內彈幕傳送量的變化趨勢';

  @override
  String get settingsSaveComments => '記錄評論';

  @override
  String get settingsCommentAntifraud => '發評反詐';

  @override
  String get settingsCommentAntifraudDescription => '傳送評論後檢查評論是否可見';

  @override
  String get settingsUseBilibiliCommentCheck => '使用「嗶哩發評反詐」檢查評論';

  @override
  String get settingsFeedPostAntifraud => '發佈／轉發 Feed 反詐';

  @override
  String get settingsFeedPostAntifraudDescription => '發佈／轉發後檢查 Feed 內容是否可見';

  @override
  String get settingsBlockShoppingPosts => '封鎖帶貨 Feed';

  @override
  String get settingsBlockShoppingComments => '封鎖帶貨評論';

  @override
  String get settingsSwipeToCloseSecondaryPages => '側滑關閉二級頁面';

  @override
  String get settingsPinchToShrinkVideo => '啟用雙指縮小影片';

  @override
  String get settingsSecondaryPageActionBar => 'Feed／專欄詳情頁顯示底部操作欄';

  @override
  String get settingsDragSubtitles => '啟用拖曳字幕調整底部邊距';

  @override
  String get settingsAnimeSchedule => '顯示追番時間表';

  @override
  String get settingsSilentImageDownload => '靜默下載圖片';

  @override
  String get settingsSilentImageDownloadDescription => '不顯示下載 Loading 對話框';

  @override
  String get settingsImageContextMenu => '長按／右鍵顯示圖片選單';

  @override
  String get settingsHapticFeedback => '振動回饋';

  @override
  String get settingsHapticFeedbackDescription => '請確認手機系統設定中已開啟振動回饋';

  @override
  String get settingsTrendingSearches => '大家都在搜';

  @override
  String get settingsTrendingSearchesDescription => '顯示「大家都在搜」';

  @override
  String get settingsSearchDiscovery => '搜尋發現';

  @override
  String get settingsSearchDiscoveryDescription => '顯示「搜尋發現」';

  @override
  String get settingsDefaultSearchTerm => '搜尋預設詞';

  @override
  String get settingsDefaultSearchTermDescription => '在搜尋框中顯示預設詞';

  @override
  String get settingsQuickFavorite => '快速收藏';

  @override
  String get settingsQuickFavoriteDescription =>
      '點擊設定預設收藏夾\n點按收藏至預設收藏夾，長按選擇資料夾';

  @override
  String get settingsCommentSearchKeywords => '評論區搜尋關鍵字';

  @override
  String get settingsCommentSearchKeywordsDescription => '顯示評論區搜尋關鍵字';

  @override
  String get settingsAiSummary => '啟用 AI 總結';

  @override
  String get settingsAiSummaryDescription => '在影片詳情頁開啟 AI 總結';

  @override
  String get settingsDisableReceivedLikes => '訊息頁停用「收到的讚」';

  @override
  String get settingsDisableReceivedLikesDescription => '禁止開啟入口，降低網路社交依賴';

  @override
  String get settingsShowCommentsByDefault => '預設顯示評論區';

  @override
  String get settingsShowCommentsByDefaultDescription =>
      '影片詳情頁預設切換至評論區（僅 Tab 型版面）';

  @override
  String get settingsHttp2 => '啟用 HTTP/2';

  @override
  String get settingsRetryCount => '連線重試次數';

  @override
  String get settingsZeroDisables => '設為 0 時停用';

  @override
  String get settingsRetryDelay => '連線重試間隔';

  @override
  String get settingsRetryDelayDescription => '實際間隔＝間隔 × 第 n 次重試';

  @override
  String get settingsCommentDisplay => '評論顯示';

  @override
  String settingsCurrentlyPrioritize(String value) {
    return '目前優先顯示「$value」';
  }

  @override
  String get settingsFeedDisplay => 'Feed 顯示';

  @override
  String get settingsFeedInteractions => '顯示 Feed 互動內容';

  @override
  String get settingsFeedInteractionsDescription =>
      '在 Feed 卡片底部顯示互動內容，例如關注的人按讚、熱門評論等';

  @override
  String get settingsMemberDefaultTab => '使用者頁預設顯示 Tab';

  @override
  String get settingsUploaderShopTab => '顯示 Uploader 首頁小店 Tab';

  @override
  String get settingsProxy => '設定代理';

  @override
  String get settingsProxyDescription => '設定代理 host:port';

  @override
  String get settingsProxyHostHint => '請輸入 Host，使用 . 分隔';

  @override
  String get settingsProxyPortHint => '請輸入 Port';

  @override
  String get settingsMaximumCacheSize => '最大快取大小';

  @override
  String settingsCurrentMaximumCacheSize(String value) {
    return '目前最大快取大小：$value';
  }

  @override
  String get settingsCheckForUpdates => '檢查更新';

  @override
  String get settingsCheckForUpdatesDescription => '每次啟動時檢查是否需要更新';

  @override
  String get settingsSetNewPath => '設定新路徑';

  @override
  String get settingsCheckInterval => '檢查週期';

  @override
  String get settingsChooseDefaultFavorite => '選擇預設收藏夾';

  @override
  String get replySortNewest => '最新評論';

  @override
  String get replySortHottest => '最熱門評論';

  @override
  String get replySortFeatured => '精選評論';

  @override
  String get replySortNewestShort => '最新';

  @override
  String get replySortHottestShort => '最熱門';

  @override
  String get replySortFeaturedShort => '精選';

  @override
  String get memberTabDefault => '預設';

  @override
  String get memberTabHome => '首頁';

  @override
  String get memberTabFeed => 'Feed';

  @override
  String get memberTabUploads => '投稿';

  @override
  String get memberTabFavorites => '收藏';

  @override
  String get memberTabAnime => '番劇';

  @override
  String get memberTabCourses => '課堂';

  @override
  String get memberTabShop => '小店';

  @override
  String get logsTitle => '日誌';

  @override
  String get logsCopied => '複製成功';

  @override
  String get logsCleared => '已清空';

  @override
  String get logsTriggerError => '引發錯誤';

  @override
  String get logsEnabledRestartRequired => '已開啟，重新啟動後生效';

  @override
  String get logsDisabledRestartRequired => '已關閉，重新啟動後生效';

  @override
  String get logsEnable => '開啟日誌';

  @override
  String get logsDisable => '關閉日誌';

  @override
  String get logsCopy => '複製日誌';

  @override
  String get logsErrorFeedback => '錯誤回饋';

  @override
  String get logsClear => '清空日誌';

  @override
  String get logsRelatedInformation => '相關資訊';

  @override
  String get logsCollapse => '收起';

  @override
  String get logsExpand => '展開';

  @override
  String get logsDeviceInformation => '裝置資訊';

  @override
  String get logsAppInformation => '應用程式資訊';

  @override
  String get logsBuildInformation => '編譯資訊';

  @override
  String logsCopiedTimestamp(String time) {
    return '已將 $time 複製至剪貼簿';
  }

  @override
  String get logsErrorDetails => '錯誤詳情';

  @override
  String get logsStackTrace => '堆疊追蹤';

  @override
  String get settingsPlaybackSpeedSetDefault => '設為預設倍速';

  @override
  String get settingsPlaybackSpeedSetLongPress => '設為預設長按倍速';

  @override
  String get settingsPlaybackSpeedDelete => '刪除該項';

  @override
  String get settingsPlaybackSpeedAdd => '新增倍速';

  @override
  String get settingsPlaybackSpeedCustom => '自訂倍速';

  @override
  String get settingsPlaybackSpeedExists => '該倍速已存在';

  @override
  String get settingsPlaybackSpeedDefaultCannotDelete => '不支援刪除預設倍速';

  @override
  String get settingsPlaybackSpeedHint => '點擊下方按鈕設定預設倍速和長按倍速';

  @override
  String get settingsPlaybackSpeedDefault => '預設倍速';

  @override
  String get settingsPlaybackSpeedDynamicLongPress => '動態長按倍速';

  @override
  String get settingsPlaybackSpeedDynamicLongPressDescription =>
      '根據預設倍速，長按時自動使用雙倍速度';

  @override
  String get settingsPlaybackSpeedDefaultLongPress => '預設長按倍速';

  @override
  String get settingsPlaybackSpeedList => '倍速清單';

  @override
  String get settingsAdd => '新增';

  @override
  String get settingsSavedNextLaunch => '儲存成功，下次啟動時生效';

  @override
  String get settingsResetNextLaunch => '重設成功，下次啟動時生效';

  @override
  String settingsEditTitle(String title) {
    return '$title編輯';
  }

  @override
  String get settingsSave => '儲存';

  @override
  String get settingsLongPressToReorder => '長按拖動排序';

  @override
  String settingsCurrentFontSize(String value) {
    return '目前字型大小：$value';
  }

  @override
  String get settingsSmall => '小';

  @override
  String get settingsLarge => '大';

  @override
  String get settingsScreenRefreshRateTitle => '螢幕更新率設定';

  @override
  String get settingsRestartIfDisplayModeFails => '沒有生效？請嘗試重新啟動 App';

  @override
  String get settingsAutomatic => '自動';

  @override
  String get settingsSystemModeMarker => '系統';

  @override
  String get settingsChooseAppTheme => '選擇應用程式主題';

  @override
  String get settingsPaletteStyle => '調色盤風格';

  @override
  String get settingsDynamicColorUnsupported => '裝置可能不支援動態取色';

  @override
  String settingsUseFont(String font) {
    return '使用 $font';
  }

  @override
  String get settingsViewLicense => '查看授權條款';

  @override
  String get settingsAgreeAndDownload => '同意並下載';

  @override
  String settingsFontDownloaded(String font) {
    return '$font 下載完成';
  }

  @override
  String settingsFontDownloading(int progress) {
    return '正在下載 $progress%';
  }

  @override
  String get settingsFontConnecting => '正在連線下載來源';

  @override
  String settingsDownloadedWithSize(String size) {
    return '已下載 · $size';
  }

  @override
  String get settingsDownloaded => '已下載';

  @override
  String get settingsDownloadFont => '下載字型';

  @override
  String get settingsFontErrorIncompleteFile => '字型檔案不完整，請重新下載';

  @override
  String get settingsFontErrorLoadFailed => '字型載入失敗，請重新下載';

  @override
  String settingsFontErrorHttp(String status) {
    return '字型下載失敗（HTTP $status）';
  }

  @override
  String get settingsFontErrorLicenseExtraction => '字型授權檔案擷取失敗，請重試';

  @override
  String get settingsFontErrorDownloadFailed => '字型下載失敗，請稍後再試';

  @override
  String get settingsFontErrorSizeMismatch => '字型檔案大小驗證失敗，請重試';

  @override
  String get settingsFontErrorChecksumMismatch => '字型校驗失敗，請重試';

  @override
  String get settingsFontErrorTimeout => '字型下載連線逾時，請檢查網路後重試';

  @override
  String get settingsFontErrorNetwork => '無法下載字型，請檢查網路';

  @override
  String get settingsFontErrorSaveFailed => '字型檔案儲存失敗，請檢查儲存空間';

  @override
  String get settingsAppFontTitle => 'App 字型';

  @override
  String get settingsFontLxgwWenKai => '霞鶩文楷';

  @override
  String get settingsFontLxgwZhenKai => '霞鶩臻楷';

  @override
  String get settingsFontLxgwNeoXiHei => '霞鶩新晰黑';

  @override
  String get settingsFontLxgwZhuqueFangsong => '霞鶩朱雀仿宋';

  @override
  String get settingsFontSourceHanSans => '思源黑體';

  @override
  String get settingsFontSourceHanSerif => '思源宋體';

  @override
  String get settingsFontFusionPixel => '縫合像素字型';

  @override
  String settingsFontLicenseNotice(String font) {
    return '本軟體將使用 $font。下載和使用即表示你同意其官方授權條款。';
  }

  @override
  String get settingsFullscreenSuperChatSizeTitle => '全螢幕 SC 大小設定';

  @override
  String get themeColorDefaultGreen => '預設綠';

  @override
  String get themeColorPink => '粉紅色';

  @override
  String get themeColorRed => '紅色';

  @override
  String get themeColorOrange => '橙色';

  @override
  String get themeColorAmber => '琥珀色';

  @override
  String get themeColorYellow => '黃色';

  @override
  String get themeColorLime => '酸橙色';

  @override
  String get themeColorLightGreen => '淺綠色';

  @override
  String get themeColorGreen => '綠色';

  @override
  String get themeColorTeal => '青色';

  @override
  String get themeColorCyan => '藍綠色';

  @override
  String get themeColorLightBlue => '淺藍色';

  @override
  String get themeColorBlue => '藍色';

  @override
  String get themeColorIndigo => '靛藍色';

  @override
  String get themeColorPurple => '紫色';

  @override
  String get themeColorDeepPurple => '深紫色';

  @override
  String get themeColorBlueGrey => '藍灰色';

  @override
  String get themeColorBrown => '棕色';

  @override
  String get themeColorGrey => '灰色';

  @override
  String get commonCopy => '複製';

  @override
  String get homeFollowingAnime => '已追番';

  @override
  String get homeRankings => '排行榜';

  @override
  String get homeWeeklyMustWatch => '每週必看';

  @override
  String get homeEssentialVideos => '入站必刷';

  @override
  String get homeLastSeenRefresh => '上次看到這裡\n點擊重新整理';

  @override
  String get homeSwitchToCover => '切換封面';

  @override
  String get homeSwitchToFirstFrame => '切換首幀';

  @override
  String get homeGameEvents => '遊戲賽事';

  @override
  String get homeAllLiveCategories => '全部標籤';

  @override
  String get homeMyLiveFollowing => '我的關注';

  @override
  String homeLiveFollowingCount(String count) {
    return '$count 人正在直播';
  }

  @override
  String get aboutAppDescription => '使用 Flutter 開發的 B 站第三方用戶端';

  @override
  String get aboutAppSemantics => '與你一起，發現不一樣的世界';

  @override
  String get aboutAccessibilityAdapted => '無障礙適配';

  @override
  String get aboutCurrentVersion => '目前版本';

  @override
  String get aboutOpenSupportedLinks => '開啟支援的連結';

  @override
  String get aboutIssueFeedback => '問題回報';

  @override
  String get aboutErrorLogs => '錯誤日誌';

  @override
  String get aboutClearLogsHint => '長按清除日誌';

  @override
  String get aboutClearCacheConfirm => '此操作將清除圖片及網路請求快取資料，確定清除？';

  @override
  String get aboutClearing => '正在清除…';

  @override
  String get aboutClearSucceeded => '清除成功';

  @override
  String get aboutClearCache => '清除快取';

  @override
  String aboutImageNetworkCache(Object size) {
    return '圖片及網路快取 $size';
  }

  @override
  String get aboutImportExportLogin => '匯入/匯出登入資訊';

  @override
  String get aboutLoginData => '登入資訊';

  @override
  String get aboutImportExportSettings => '匯入/匯出設定';

  @override
  String get aboutSettingsData => '設定';

  @override
  String get aboutResetAllSettings => '重設所有設定';

  @override
  String get aboutResetAllSettingsQuestion => '是否重設所有設定？';

  @override
  String get aboutResetSucceeded => '重設成功';

  @override
  String get aboutResetExportableSettings => '重設可匯出的設定';

  @override
  String get aboutResetAllData => '重設所有資料（含登入資訊）';

  @override
  String importExportTitle(Object title) {
    return '匯入/匯出$title';
  }

  @override
  String importConfirmPreview(Object title) {
    return '是否匯入以下$title？';
  }

  @override
  String importInputTitle(Object title) {
    return '輸入$title';
  }

  @override
  String importJsonParseFailed(Object error) {
    return '解析 JSON 失敗：$error';
  }

  @override
  String get importSucceeded => '匯入成功';

  @override
  String importFailed(Object error) {
    return '匯入失敗：$error';
  }

  @override
  String get importClipboardEmpty => '剪貼簿沒有資料';

  @override
  String get exportToClipboard => '匯出至剪貼簿';

  @override
  String get exportToLocalFile => '匯出檔案至本機';

  @override
  String get importEnterManually => '輸入';

  @override
  String get importFromClipboard => '從剪貼簿匯入';

  @override
  String get importFromLocalFile => '從本機檔案匯入';

  @override
  String get memberHomeVideos => '影片';

  @override
  String get memberHomeFavorites => '收藏';

  @override
  String get memberHomeRecentCoinedVideos => '最近投幣的影片';

  @override
  String get memberHomeRecentLikedVideos => '最近按讚的影片';

  @override
  String get memberHomePosts => '圖文';

  @override
  String get memberHomeAudio => '音訊';

  @override
  String get memberHomeComics => '漫畫';

  @override
  String get memberHomeAnime => '追番';

  @override
  String blacklistTitle(Object count) {
    return '黑名單管理$count';
  }

  @override
  String blacklistCountSuffix(Object count) {
    return '：$count';
  }

  @override
  String blacklistAddedAt(Object date) {
    return '加入時間：$date';
  }

  @override
  String blacklistRemoveConfirm(Object name) {
    return '確定將 $name 移出黑名單？';
  }

  @override
  String get blacklistRemoved => '移除成功';

  @override
  String get webDavSettingsTitle => 'WebDAV 設定';

  @override
  String get webDavBackupSettings => '備份設定';

  @override
  String get webDavRestoreSettings => '還原設定';

  @override
  String get webDavConfigurationSucceeded => '設定成功';

  @override
  String webDavConfigurationFailed(Object error) {
    return '設定失敗：$error';
  }

  @override
  String webDavBackupConfigurationFailed(Object error) {
    return '備份失敗，請檢查設定：$error';
  }

  @override
  String get webDavBackupSucceeded => '備份成功';

  @override
  String webDavBackupFailed(Object error) {
    return '備份失敗：$error';
  }

  @override
  String get webDavRestoreSucceeded => '還原成功';

  @override
  String webDavRestoreFailed(Object error) {
    return '還原失敗：$error';
  }

  @override
  String webDavCheckConfiguration(Object error) {
    return '請檢查設定：$error';
  }

  @override
  String get webDavBackupNotFound => '找不到備份檔案';

  @override
  String get sponsorBlockTitle => '空降助手';

  @override
  String get sponsorBlockMinimumDuration => '最短片段時長';

  @override
  String get sponsorBlockMinimumDurationDescription => '忽略短於此時長的片段';

  @override
  String get sponsorBlockAbout => '關於空降助手';

  @override
  String get sponsorBlockUserId => '使用者 ID';

  @override
  String get sponsorBlockUserIdValidation => '使用者 ID 必須是至少 30 個字元的英數字串';

  @override
  String get sponsorBlockRandom => '隨機';

  @override
  String get sponsorBlockShowSkipToast => '顯示跳過提示';

  @override
  String get sponsorBlockTrackSkips => '追蹤跳過次數統計';

  @override
  String get sponsorBlockTrackSkipsDescription =>
      '此功能會回報您跳過的片段，讓提交者知道幫助了多少人；按讚結果也會用於避免垃圾資訊污染資料庫。每次跳過片段時都會向伺服器傳送訊息，開啟後可讓統計更準確。';

  @override
  String get sponsorBlockYourInformation => '您的資訊';

  @override
  String sponsorBlockUserInformation(
    Object minutes,
    Object segments,
    Object views,
  ) {
    return '您提交了 $segments 個片段\n您的片段已幫助觀眾 $views 次\n（節省 $minutes 分鐘）';
  }

  @override
  String get sponsorBlockServerError => '伺服器錯誤';

  @override
  String get sponsorBlockServerAddress => '伺服器位址';

  @override
  String get sponsorBlockServerStatus => '伺服器狀態';

  @override
  String get sponsorBlockServerNormal => '正常';

  @override
  String get sponsorBlockServerUnavailable => '錯誤';

  @override
  String sponsorBlockColorPickerTitle(Object category) {
    return '$category的顏色';
  }

  @override
  String get sponsorBlockDescriptionSponsor => '付費推廣、贊助和直接廣告，不包含無償提及。';

  @override
  String get sponsorBlockDescriptionSelfPromotion => '無償或自我推廣，包括商品、捐贈或合作者資訊。';

  @override
  String get sponsorBlockDescriptionExclusiveAccess =>
      '標記整部展示免費或優惠取得的產品、服務或場地的影片。';

  @override
  String get sponsorBlockDescriptionInteraction =>
      '簡短提醒觀眾按讚、關注或互動；較長且有實質內容的片段應歸為自我推廣。';

  @override
  String get sponsorBlockDescriptionHighlight => '大多數觀眾正在尋找的精彩時刻，例如縮圖所示的時間點。';

  @override
  String get sponsorBlockDescriptionIntro => '沒有實際內容的過場或片頭，例如暫停、靜止畫面或重複動畫。';

  @override
  String get sponsorBlockDescriptionOutro => '沒有額外內容的片尾或鳴謝畫面。';

  @override
  String get sponsorBlockDescriptionPreview => '本片或同系列稍後會再次出現內容的回顧或預覽。';

  @override
  String get sponsorBlockDescriptionPadding => '搬運內容前後無實質意義、與主體無關的空白或填充畫面。';

  @override
  String get sponsorBlockDescriptionFiller => '理解主要內容不需要的離題閒聊或玩笑；這是一個較激進的分類。';

  @override
  String get sponsorBlockDescriptionMusicOfftopic => '僅限音樂影片：不屬於其他分類的非音樂片段。';

  @override
  String get videoCooperation => '合作';

  @override
  String get commonSort => '排序';

  @override
  String get commonMultiSelect => '多選';

  @override
  String get commonUpdate => '更新';

  @override
  String get commonUpdateSucceeded => '更新成功';

  @override
  String get commonUpdateFailed => '更新失敗';

  @override
  String get commonMove => '移動';

  @override
  String get commonPlayAll => '播放全部';

  @override
  String get favoriteTitle => '我的收藏';

  @override
  String get favoriteNewFolder => '新增收藏夾';

  @override
  String get favoriteFolderSort => '收藏夾排序';

  @override
  String get favoriteLoadAllBeforeSorting => '載入全部收藏夾後再排序';

  @override
  String get favoriteTabVideos => '影片';

  @override
  String get favoriteTabAnime => '追番';

  @override
  String get favoriteTabSeries => '追劇';

  @override
  String get favoriteTabArticles => '專欄';

  @override
  String get favoriteTabNotes => '筆記';

  @override
  String get favoriteTabTopics => '話題';

  @override
  String get favoriteTabCourses => '課程';

  @override
  String get laterAll => '全部';

  @override
  String get laterUnfinished => '未看完';

  @override
  String get laterRecentlyAdded => '最近加入';

  @override
  String get laterEarliestAdded => '最早加入';

  @override
  String get laterClearInvalid => '清除失效';

  @override
  String get laterClearWatched => '清除已看完';

  @override
  String get laterClearAll => '清除全部';

  @override
  String get historyAll => '全部';

  @override
  String get historyTitle => '觀看記錄';

  @override
  String get historyPause => '暫停觀看記錄';

  @override
  String get historyResume => '恢復觀看記錄';

  @override
  String get historyClear => '清除觀看記錄';

  @override
  String get historyDeleteWatched => '刪除已看記錄';

  @override
  String get historyDisabled => ' 觀看記錄功能已關閉';

  @override
  String get historyTapToEnable => '點擊開啟';

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
}
