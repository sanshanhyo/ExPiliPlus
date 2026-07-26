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
  String replyReplyPrefix(String name, String message) {
    return '回复 @$name：$message';
  }

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
  String replyReplyPrefix(String name, String message) {
    return '回覆 @$name：$message';
  }

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
}
