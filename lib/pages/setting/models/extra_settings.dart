import 'dart:io';
import 'dart:math' show max;

import 'package:ex_piliplus/common/widgets/custom_icon.dart';
import 'package:ex_piliplus/common/widgets/dialog/simple_dialog_option.dart';
import 'package:ex_piliplus/common/widgets/flutter/refresh_indicator.dart';
import 'package:ex_piliplus/common/widgets/gesture/horizontal_drag_gesture_recognizer.dart'
    show deviceTouchSlop, touchSlopH;
import 'package:ex_piliplus/common/widgets/image_grid/image_grid_view.dart'
    show ImageGridView, ImageModel;
import 'package:ex_piliplus/common/widgets/pendant_avatar.dart';
import 'package:ex_piliplus/grpc/reply.dart';
import 'package:ex_piliplus/http/fav.dart';
import 'package:ex_piliplus/http/loading_state.dart';
import 'package:ex_piliplus/models/common/audio_normalization.dart';
import 'package:ex_piliplus/models/common/dynamic/dynamics_type.dart';
import 'package:ex_piliplus/models/common/member/tab_type.dart';
import 'package:ex_piliplus/models/common/reply/reply_sort_type.dart';
import 'package:ex_piliplus/models/common/sponsor_block/skip_type.dart';
import 'package:ex_piliplus/models/common/super_resolution_type.dart';
import 'package:ex_piliplus/models/dynamics/result.dart'
    show DynamicsDataModel, ItemModulesModel;
import 'package:ex_piliplus/pages/common/slide/common_slide_page.dart';
import 'package:ex_piliplus/pages/home/controller.dart';
import 'package:ex_piliplus/pages/main/controller.dart';
import 'package:ex_piliplus/pages/setting/models/model.dart';
import 'package:ex_piliplus/pages/setting/widgets/select_dialog.dart';
import 'package:ex_piliplus/pages/setting/widgets/slider_dialog.dart';
import 'package:ex_piliplus/pages/video/reply/widgets/reply_item_grpc.dart';
import 'package:ex_piliplus/plugin/pl_player/controller.dart';
import 'package:ex_piliplus/services/download/download_service.dart';
import 'package:ex_piliplus/utils/accounts.dart';
import 'package:ex_piliplus/utils/cache_manager.dart';
import 'package:ex_piliplus/utils/extension/num_ext.dart';
import 'package:ex_piliplus/utils/extension/l10n_ext.dart';
import 'package:ex_piliplus/utils/feed_back.dart';
import 'package:ex_piliplus/utils/filtering_text.dart';
import 'package:ex_piliplus/utils/global_data.dart';
import 'package:ex_piliplus/utils/image_utils.dart';
import 'package:ex_piliplus/utils/path_utils.dart';
import 'package:ex_piliplus/utils/platform_utils.dart';
import 'package:ex_piliplus/utils/storage.dart';
import 'package:ex_piliplus/utils/storage_key.dart';
import 'package:ex_piliplus/utils/storage_pref.dart';
import 'package:ex_piliplus/utils/update.dart';
import 'package:ex_piliplus/utils/utils.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/material.dart' hide RefreshIndicator;
import 'package:flutter/services.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

List<SettingsModel> extraSettings(BuildContext context) {
  final l10n = context.l10n;
  return [
    if (PlatformUtils.isDesktop) ...[
      SwitchModel(
        title: l10n.settingsMinimizeOnExit,
        leading: const Icon(Icons.exit_to_app),
        setKey: SettingBoxKey.minimizeOnExit,
        defaultVal: true,
        onChanged: (value) {
          try {
            Get.find<MainController>().minimizeOnExit = value;
          } catch (_) {}
        },
      ),
      NormalModel(
        title: l10n.settingsCachePath,
        getSubtitle: () => downloadPath,
        leading: const Icon(Icons.storage),
        onTap: _showDownPathDialog,
      ),
    ],
    SplitModel(
      normalModel: NormalModel.split(
        title: l10n.settingsSponsorBlock,
        subtitle: l10n.settingsTapToConfigure,
        leading: const Icon(CustomIcons.shield_play_arrow),
      ),
      switchModel: SwitchModel.split(
        defaultVal: false,
        setKey: SettingBoxKey.enableSponsorBlock,
        onTap: (context) => Get.toNamed('/sponsorBlock'),
      ),
    ),
    PopupModel<SkipType>(
      title: l10n.settingsAnimeIntroOutroSkip,
      leading: const Icon(MdiIcons.debugStepOver),
      value: () => Pref.pgcSkipType,
      items: SkipType.values,
      labelBuilder: (value) => value.localizedLabel(l10n),
      onSelected: (value, setState) => GStorage.setting
          .put(SettingBoxKey.pgcSkipType, value.index)
          .whenComplete(setState),
    ),
    SplitModel(
      normalModel: NormalModel.split(
        title: l10n.settingsCheckUnreadFeed,
        subtitle: l10n.settingsCheckUnreadFeedDescription,
        leading: const Icon(Icons.notifications_none),
      ),
      switchModel: SwitchModel.split(
        defaultVal: true,
        setKey: SettingBoxKey.checkDynamic,
        onChanged: (value) => Get.find<MainController>().checkDynamic = value,
        onTap: _showDynDialog,
      ),
    ),
    SwitchModel(
      title: l10n.settingsVideoChapters,
      leading: const Icon(CustomIcons.view_headline_rotate_90),
      setKey: SettingBoxKey.showViewPoints,
      defaultVal: true,
    ),
    SwitchModel(
      title: l10n.settingsRelatedVideos,
      leading: const Icon(MdiIcons.motionPlayOutline),
      setKey: SettingBoxKey.showRelatedVideo,
      defaultVal: true,
    ),
    SwitchModel(
      title: l10n.settingsVideoComments,
      leading: const Icon(MdiIcons.commentTextOutline),
      setKey: SettingBoxKey.showVideoReply,
      defaultVal: true,
    ),
    SwitchModel(
      title: l10n.settingsAnimeComments,
      leading: const Icon(MdiIcons.commentTextOutline),
      setKey: SettingBoxKey.showBangumiReply,
      defaultVal: true,
    ),
    SwitchModel(
      title: l10n.settingsExpandVideoDescription,
      leading: const Icon(Icons.expand_more),
      setKey: SettingBoxKey.alwaysExpandIntroPanel,
      defaultVal: false,
    ),
    SwitchModel(
      title: l10n.settingsExpandVideoDescriptionLandscape,
      leading: const Icon(Icons.expand_more),
      setKey: SettingBoxKey.expandIntroPanelH,
      defaultVal: false,
    ),
    SwitchModel(
      title: l10n.settingsLandscapeEpisodeTabs,
      leading: const Icon(Icons.format_list_numbered_rtl_sharp),
      setKey: SettingBoxKey.horizontalSeasonPanel,
      defaultVal: Pref.horizontalScreen,
    ),
    SwitchModel(
      title: l10n.settingsLandscapeUploaderSidebar,
      leading: const Icon(Icons.account_circle_outlined),
      setKey: SettingBoxKey.horizontalMemberPage,
      defaultVal: Pref.horizontalScreen,
    ),
    SwitchModel(
      title: l10n.settingsLandscapeImagePreview,
      leading: const Icon(Icons.photo_outlined),
      setKey: SettingBoxKey.horizontalPreview,
      defaultVal: false,
      onChanged: (value) => ImageGridView.horizontalPreview = value,
    ),
    NormalModel(
      title: l10n.settingsCommentFoldLines,
      subtitle: l10n.settingsZeroLinesDoNotFold,
      leading: const Icon(Icons.compress),
      getTrailing: (theme) => Text(
        l10n.settingsLineCount(
          ReplyItemGrpc.replyLengthLimit?.toString() ?? '0',
        ),
        style: theme.textTheme.titleSmall,
      ),
      onTap: _showReplyLengthDialog,
    ),
    NormalModel(
      title: l10n.settingsDanmakuLineHeight,
      subtitle: l10n.settingsDefaultNumber('1.6'),
      leading: const Icon(CustomIcons.dm_settings),
      getTrailing: (theme) => Text(
        Pref.danmakuLineHeight.toString(),
        style: theme.textTheme.titleSmall,
      ),
      onTap: _showDmHeightDialog,
    ),
    SwitchModel(
      title: l10n.settingsVideoWarnings,
      leading: const Icon(Icons.warning_amber_rounded),
      setKey: SettingBoxKey.showArgueMsg,
      defaultVal: true,
    ),
    SwitchModel(
      title: l10n.settingsFeedWarnings,
      leading: const Icon(Icons.warning_amber_rounded),
      setKey: SettingBoxKey.showDynDispute,
      defaultVal: false,
      onChanged: (val) => ItemModulesModel.showDynDispute = val,
    ),
    SwitchModel(
      title: l10n.settingsReverseEpisodesFromFirst,
      subtitle: l10n.settingsReverseEpisodesFromFirstDescription,
      leading: const Icon(MdiIcons.sort),
      setKey: SettingBoxKey.reverseFromFirst,
      defaultVal: true,
    ),
    SwitchModel(
      title: l10n.settingsDisableSslVerification,
      subtitle: l10n.settingsDisableSslVerificationDescription,
      leading: const Icon(Icons.security),
      needReboot: true,
      setKey: SettingBoxKey.badCertificateCallback,
    ),
    SwitchModel(
      title: l10n.settingsContinuePartPrompt,
      leading: const Icon(Icons.local_parking),
      setKey: SettingBoxKey.continuePlayingPart,
      defaultVal: true,
    ),
    getBanWordModel(
      context: context,
      title: l10n.settingsCommentKeywordFilter,
      key: SettingBoxKey.banWordForReply,
      onChanged: (value) {
        ReplyGrpc.replyRegExp = value;
        ReplyGrpc.enableFilter = value.pattern.isNotEmpty;
      },
    ),
    getBanWordModel(
      context: context,
      title: l10n.settingsFeedKeywordFilter,
      key: SettingBoxKey.banWordForDyn,
      onChanged: (value) {
        DynamicsDataModel.banWordForDyn = value;
        DynamicsDataModel.enableFilter = value.pattern.isNotEmpty;
      },
    ),
    SwitchModel(
      title: l10n.settingsExternalBrowser,
      leading: const Icon(Icons.open_in_browser),
      setKey: SettingBoxKey.openInBrowser,
      defaultVal: false,
    ),
    NormalModel(
      title: l10n.settingsHorizontalSwipeThreshold,
      getSubtitle: () => l10n.settingsCurrentAndSystemDefault(
        Pref.touchSlopH.toString(),
        deviceTouchSlop.toString(),
      ),
      onTap: _showTouchSlopDialog,
      leading: const Icon(Icons.pan_tool_alt_outlined),
    ),
    NormalModel(
      title: l10n.settingsRefreshDragDistance,
      leading: const Icon(Icons.refresh),
      getSubtitle: () =>
          l10n.settingsCurrentMultiplier(Pref.refreshDragPercentage.toString()),
      onTap: _showRefreshDragDialog,
    ),
    NormalModel(
      title: l10n.settingsRefreshIndicatorHeight,
      leading: const Icon(Icons.height),
      getSubtitle: () =>
          l10n.settingsCurrentValue(Pref.refreshDisplacement.toString()),
      onTap: _showRefreshDialog,
    ),
    SwitchModel(
      title: l10n.settingsVipDanmaku,
      leading: const Icon(MdiIcons.gradientHorizontal),
      setKey: SettingBoxKey.showVipDanmaku,
      defaultVal: true,
    ),
    SwitchModel(
      title: l10n.settingsMergeDanmaku,
      subtitle: l10n.settingsMergeDanmakuDescription,
      leading: const Icon(Icons.merge),
      setKey: SettingBoxKey.mergeDanmaku,
      defaultVal: false,
    ),
    SwitchModel(
      title: l10n.settingsTrendingRecommendations,
      subtitle: l10n.settingsTrendingRecommendationsDescription,
      leading: const Icon(Icons.local_fire_department_outlined),
      setKey: SettingBoxKey.showHotRcmd,
      defaultVal: false,
      needReboot: true,
    ),
    if (kDebugMode || Platform.isAndroid)
      NormalModel(
        title: l10n.settingsAudioNormalization,
        leading: const Icon(Icons.multitrack_audio),
        getSubtitle: () {
          final audioNormalization =
              AudioNormalization.localizedTitleFromConfig(
                Pref.audioNormalization,
                l10n,
              );
          String fallback = Pref.fallbackNormalization;
          if (fallback == '0') {
            fallback = '';
          } else {
            fallback = l10n.settingsFallbackValue(
              AudioNormalization.localizedTitleFromConfig(fallback, l10n),
            );
          }
          return '${l10n.settingsCurrentValue(audioNormalization)}$fallback';
        },
        onTap: audioNormalization,
      ),
    NormalModel(
      title: l10n.settingsSuperResolution,
      leading: const Icon(Icons.stay_current_landscape_outlined),
      getSubtitle: () => l10n.settingsSuperResolutionDescription(
        Pref.superResolutionType.localizedLabel(l10n),
      ),
      onTap: _showSuperResolutionDialog,
    ),
    SwitchModel(
      title: l10n.settingsPreinitializePlayer,
      subtitle: l10n.settingsPreinitializePlayerDescription,
      leading: const Icon(Icons.play_circle_outlined),
      setKey: SettingBoxKey.preInitPlayer,
      defaultVal: false,
    ),
    SwitchModel(
      title: l10n.settingsHomePageAnimation,
      leading: const Icon(Icons.home_outlined),
      setKey: SettingBoxKey.mainTabBarView,
      defaultVal: false,
      needReboot: true,
    ),
    SwitchModel(
      title: l10n.settingsSearchSuggestions,
      leading: const Icon(Icons.search),
      setKey: SettingBoxKey.searchSuggestion,
      defaultVal: true,
    ),
    SwitchModel(
      title: l10n.settingsSearchHistory,
      leading: const Icon(Icons.history),
      setKey: SettingBoxKey.recordSearchHistory,
      defaultVal: true,
    ),
    SwitchModel(
      title: l10n.settingsShowDecorations,
      leading: const Icon(MdiIcons.stickerCircleOutline),
      setKey: SettingBoxKey.showDecorate,
      defaultVal: true,
      onChanged: (value) => PendantAvatar.showDecorate = value,
    ),
    SwitchModel(
      title: l10n.settingsFanMedals,
      leading: const Icon(MdiIcons.medalOutline),
      setKey: SettingBoxKey.showMedal,
      defaultVal: true,
      onChanged: (value) => GlobalData().showMedal = value,
    ),
    SwitchModel(
      title: l10n.settingsLivePhotoPreview,
      subtitle: l10n.settingsLivePhotoPreviewDescription,
      leading: const Icon(Icons.image_outlined),
      setKey: SettingBoxKey.enableLivePhoto,
      defaultVal: true,
      onChanged: (value) => ImageModel.enableLivePhoto = value,
    ),
    SwitchModel(
      title: l10n.settingsSeekPreviewThumbnails,
      leading: const Icon(Icons.preview_outlined),
      setKey: SettingBoxKey.showSeekPreview,
      defaultVal: true,
    ),
    SwitchModel(
      title: l10n.settingsDanmakuHeatmap,
      subtitle: l10n.settingsDanmakuHeatmapDescription,
      leading: const Icon(Icons.show_chart),
      setKey: SettingBoxKey.showDmChart,
      defaultVal: false,
    ),
    SwitchModel(
      title: l10n.settingsSaveComments,
      leading: const Icon(Icons.message_outlined),
      setKey: SettingBoxKey.saveReply,
      defaultVal: true,
      needReboot: true,
    ),
    SwitchModel(
      title: l10n.settingsCommentAntifraud,
      subtitle: l10n.settingsCommentAntifraudDescription,
      leading: const Icon(CustomIcons.shield_reply),
      setKey: SettingBoxKey.enableCommAntifraud,
      defaultVal: false,
    ),
    if (Platform.isAndroid)
      SwitchModel(
        title: l10n.settingsUseBilibiliCommentCheck,
        leading: const Icon(
          FontAwesomeIcons.b,
          size: 22,
        ),
        setKey: SettingBoxKey.biliSendCommAntifraud,
        defaultVal: false,
      ),
    SwitchModel(
      title: l10n.settingsFeedPostAntifraud,
      subtitle: l10n.settingsFeedPostAntifraudDescription,
      leading: const Icon(CustomIcons.shield_published),
      setKey: SettingBoxKey.enableCreateDynAntifraud,
      defaultVal: false,
    ),
    SwitchModel(
      title: l10n.settingsBlockShoppingPosts,
      leading: const Icon(CustomIcons.shopping_bag_not_interested),
      setKey: SettingBoxKey.antiGoodsDyn,
      defaultVal: false,
      onChanged: (value) => DynamicsDataModel.antiGoodsDyn = value,
    ),
    SwitchModel(
      title: l10n.settingsBlockShoppingComments,
      leading: const Icon(CustomIcons.shopping_bag_not_interested),
      setKey: SettingBoxKey.antiGoodsReply,
      defaultVal: false,
      onChanged: (value) => ReplyGrpc.antiGoodsReply = value,
    ),
    SwitchModel(
      title: l10n.settingsSwipeToCloseSecondaryPages,
      leading: const Icon(CustomIcons.touch_app_rotate_270),
      setKey: SettingBoxKey.slideDismissReplyPage,
      defaultVal: Platform.isIOS,
      onChanged: (value) => CommonSlideMixin.slideDismissReplyPage = value,
    ),
    SwitchModel(
      title: l10n.settingsPinchToShrinkVideo,
      leading: const Icon(Icons.pinch),
      setKey: SettingBoxKey.enableShrinkVideoSize,
      defaultVal: true,
    ),
    SwitchModel(
      title: l10n.settingsSecondaryPageActionBar,
      leading: const Icon(Icons.more_horiz),
      setKey: SettingBoxKey.showDynActionBar,
      defaultVal: true,
    ),
    SwitchModel(
      title: l10n.settingsDragSubtitles,
      leading: const Icon(MdiIcons.dragVariant),
      setKey: SettingBoxKey.enableDragSubtitle,
      defaultVal: false,
    ),
    SwitchModel(
      title: l10n.settingsAnimeSchedule,
      leading: const Icon(MdiIcons.chartTimelineVariantShimmer),
      setKey: SettingBoxKey.showPgcTimeline,
      defaultVal: true,
      needReboot: true,
    ),
    SwitchModel(
      title: l10n.settingsSilentImageDownload,
      subtitle: l10n.settingsSilentImageDownloadDescription,
      leading: const Icon(Icons.download_for_offline_outlined),
      setKey: SettingBoxKey.silentDownImg,
      defaultVal: false,
      onChanged: (value) => ImageUtils.silentDownImg = value,
    ),
    SwitchModel(
      title: l10n.settingsImageContextMenu,
      leading: const Icon(Icons.menu),
      setKey: SettingBoxKey.enableImgMenu,
      defaultVal: false,
      onChanged: (value) => ImageGridView.enableImgMenu = value,
    ),
    SwitchModel(
      setKey: SettingBoxKey.feedBackEnable,
      onChanged: (value) {
        enableFeedback = value;
        feedBack();
      },
      leading: const Icon(Icons.vibration_outlined),
      title: l10n.settingsHapticFeedback,
      subtitle: l10n.settingsHapticFeedbackDescription,
    ),
    SwitchModel(
      title: l10n.settingsTrendingSearches,
      subtitle: l10n.settingsTrendingSearchesDescription,
      leading: const Icon(Icons.data_thresholding_outlined),
      setKey: SettingBoxKey.enableHotKey,
      defaultVal: true,
    ),
    SwitchModel(
      title: l10n.settingsSearchDiscovery,
      subtitle: l10n.settingsSearchDiscoveryDescription,
      leading: const Icon(Icons.search_outlined),
      setKey: SettingBoxKey.enableSearchRcmd,
      defaultVal: true,
    ),
    SwitchModel(
      title: l10n.settingsDefaultSearchTerm,
      subtitle: l10n.settingsDefaultSearchTermDescription,
      leading: const Icon(Icons.whatshot_outlined),
      setKey: SettingBoxKey.enableSearchWord,
      defaultVal: false,
      onChanged: (val) {
        try {
          final controller = Get.find<HomeController>()..enableSearchWord = val;
          if (val) {
            controller.querySearchDefault();
          } else {
            controller.defaultSearch.value = '';
          }
        } catch (_) {}
      },
    ),
    SwitchModel(
      title: l10n.settingsQuickFavorite,
      subtitle: l10n.settingsQuickFavoriteDescription,
      leading: const Icon(Icons.bookmark_add_outlined),
      setKey: SettingBoxKey.enableQuickFav,
      onTap: _showFavDialog,
      defaultVal: false,
    ),
    SwitchModel(
      title: l10n.settingsCommentSearchKeywords,
      subtitle: l10n.settingsCommentSearchKeywordsDescription,
      leading: const Icon(Icons.search_outlined),
      setKey: SettingBoxKey.enableWordRe,
      defaultVal: false,
      onChanged: (value) => ReplyItemGrpc.enableWordRe = value,
    ),
    SwitchModel(
      title: l10n.settingsAiSummary,
      subtitle: l10n.settingsAiSummaryDescription,
      leading: const Icon(Icons.engineering_outlined),
      setKey: SettingBoxKey.enableAi,
      defaultVal: false,
    ),
    SwitchModel(
      title: l10n.settingsDisableReceivedLikes,
      subtitle: l10n.settingsDisableReceivedLikesDescription,
      leading: const Icon(Icons.beach_access_outlined),
      setKey: SettingBoxKey.disableLikeMsg,
      defaultVal: false,
    ),
    SwitchModel(
      title: l10n.settingsShowCommentsByDefault,
      subtitle: l10n.settingsShowCommentsByDefaultDescription,
      leading: const Icon(Icons.mode_comment_outlined),
      setKey: SettingBoxKey.defaultShowComment,
      defaultVal: false,
    ),
    SwitchModel(
      title: l10n.settingsHttp2,
      leading: const Icon(Icons.swap_horizontal_circle_outlined),
      setKey: SettingBoxKey.enableHttp2,
      defaultVal: false,
      needReboot: true,
    ),
    NormalModel(
      title: l10n.settingsRetryCount,
      subtitle: l10n.settingsZeroDisables,
      leading: const Icon(Icons.repeat),
      onTap: _showReplyCountDialog,
    ),
    NormalModel(
      title: l10n.settingsRetryDelay,
      subtitle: l10n.settingsRetryDelayDescription,
      leading: const Icon(Icons.more_time_outlined),
      onTap: _showReplyDelayDialog,
    ),
    NormalModel(
      title: l10n.settingsCommentDisplay,
      leading: const Icon(Icons.whatshot_outlined),
      getSubtitle: () => l10n.settingsCurrentlyPrioritize(
        Pref.replySortType.localizedTitle(l10n),
      ),
      onTap: _showReplySortDialog,
    ),
    NormalModel(
      title: l10n.settingsFeedDisplay,
      leading: const Icon(Icons.dynamic_feed_rounded),
      getSubtitle: () => l10n.settingsCurrentlyPrioritize(
        Pref.defaultDynamicType.localizedLabel(l10n),
      ),
      onTap: _showDefDynDialog,
    ),
    SwitchModel(
      title: l10n.settingsFeedInteractions,
      subtitle: l10n.settingsFeedInteractionsDescription,
      leading: const Icon(Icons.quickreply_outlined),
      setKey: SettingBoxKey.showDynInteraction,
      defaultVal: true,
      onChanged: (val) => ItemModulesModel.showDynInteraction = val,
    ),
    NormalModel(
      title: l10n.settingsMemberDefaultTab,
      leading: const Icon(Icons.tab),
      getSubtitle: () => l10n.settingsCurrentlyPrioritize(
        Pref.memberTab.localizedTitle(l10n),
      ),
      onTap: _showMemberTabDialog,
    ),
    SwitchModel(
      title: l10n.settingsUploaderShopTab,
      leading: const Icon(Icons.shop_outlined),
      setKey: SettingBoxKey.showMemberShop,
      defaultVal: false,
      onChanged: (value) => MemberTabType.showMemberShop = value,
    ),
    SplitModel(
      normalModel: NormalModel.split(
        title: l10n.settingsProxy,
        subtitle: l10n.settingsProxyDescription,
        leading: const Icon(Icons.airplane_ticket_outlined),
      ),
      switchModel: SwitchModel.split(
        defaultVal: false,
        setKey: SettingBoxKey.enableSystemProxy,
        onTap: _showProxyDialog,
      ),
    ),
    NormalModel(
      title: l10n.settingsMaximumCacheSize,
      getSubtitle: () => l10n.settingsCurrentMaximumCacheSize(
        CacheManager.formatSize(Pref.maxCacheSize),
      ),
      leading: const Icon(Icons.delete_outlined),
      onTap: _showCacheDialog,
    ),
    SwitchModel(
      title: l10n.settingsCheckForUpdates,
      subtitle: l10n.settingsCheckForUpdatesDescription,
      leading: const Icon(Icons.system_update_alt),
      setKey: SettingBoxKey.autoUpdate,
      defaultVal: true,
      onChanged: (val) {
        if (val) {
          Update.checkUpdate(false);
        }
      },
    ),
  ];
}

Future<void> audioNormalization(
  BuildContext context,
  VoidCallback setState, {
  bool fallback = false,
}) async {
  final key = fallback
      ? SettingBoxKey.fallbackNormalization
      : SettingBoxKey.audioNormalization;
  final res = await showDialog<String>(
    context: context,
    builder: (context) {
      String audioNormalization = fallback
          ? Pref.fallbackNormalization
          : Pref.audioNormalization;
      Set<String> values = {
        '0',
        '1',
        if (!fallback) '2',
        audioNormalization,
        '3',
      };
      return SelectDialog<String>(
        title: fallback
            ? context.l10n.settingsFallbackNormalization
            : context.l10n.settingsAudioNormalization,
        toggleable: true,
        value: audioNormalization,
        values: values
            .map(
              (e) => (
                e,
                switch (e) {
                  '0' => AudioNormalization.disable.localizedTitle(
                    context.l10n,
                  ),
                  '1' => AudioNormalization.dynaudnorm.localizedTitle(
                    context.l10n,
                  ),
                  '2' => AudioNormalization.loudnorm.localizedTitle(
                    context.l10n,
                  ),
                  '3' => AudioNormalization.custom.localizedTitle(
                    context.l10n,
                  ),
                  _ => e,
                },
              ),
            )
            .toList(),
      );
    },
  );
  if (res != null && context.mounted) {
    if (res == '3') {
      String param = '';
      await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(context.l10n.settingsCustomParameters),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: 16,
            children: [
              Text(context.l10n.settingsAudioNormalizationParameterHelp),
              TextField(
                autofocus: true,
                onChanged: (value) => param = value,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: Get.back,
              child: Text(
                context.l10n.commonCancel,
                style: TextStyle(color: ColorScheme.of(context).outline),
              ),
            ),
            TextButton(
              onPressed: () {
                Get.back();
                GStorage.setting.put(key, param);
                if (!fallback &&
                    PlPlayerController.loudnormRegExp.hasMatch(param)) {
                  audioNormalization(context, setState, fallback: true);
                }
                setState();
              },
              child: Text(context.l10n.commonConfirm),
            ),
          ],
        ),
      );
    } else {
      GStorage.setting.put(key, res);
      if (res == '2') {
        audioNormalization(context, setState, fallback: true);
      }
      setState();
    }
  }
}

void _showDownPathDialog(BuildContext context, VoidCallback setState) {
  showDialog(
    context: context,
    builder: (context) => SimpleDialog(
      clipBehavior: Clip.hardEdge,
      contentPadding: const EdgeInsets.symmetric(vertical: 12),
      children: [
        DialogOption(
          onPressed: () {
            Get.back();
            Utils.copyText(downloadPath);
          },
          child: Text(
            context.l10n.commonCopyLink,
            style: const TextStyle(fontSize: 14),
          ),
        ),
        DialogOption(
          onPressed: () {
            Get.back();
            final defPath = defDownloadPath;
            if (downloadPath == defPath) return;
            downloadPath = defPath;
            setState();
            Get.find<DownloadService>().initDownloadList();
            GStorage.setting.delete(SettingBoxKey.downloadPath);
          },
          child: Text(
            context.l10n.settingsReset,
            style: const TextStyle(fontSize: 14),
          ),
        ),
        DialogOption(
          onPressed: () async {
            Get.back();
            final path = await FilePicker.getDirectoryPath();
            if (path == null || path == downloadPath) return;
            downloadPath = path;
            setState();
            Get.find<DownloadService>().initDownloadList();
            GStorage.setting.put(SettingBoxKey.downloadPath, path);
          },
          child: Text(
            context.l10n.settingsSetNewPath,
            style: const TextStyle(fontSize: 14),
          ),
        ),
      ],
    ),
  );
}

void _showDynDialog(BuildContext context) {
  String dynamicPeriod = Pref.dynamicPeriod.toString();
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(context.l10n.settingsCheckInterval),
      content: TextFormField(
        autofocus: true,
        initialValue: dynamicPeriod,
        keyboardType: TextInputType.number,
        onChanged: (value) => dynamicPeriod = value,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        decoration: const InputDecoration(suffixText: 'min'),
      ),
      actions: [
        TextButton(
          onPressed: Get.back,
          child: Text(
            context.l10n.commonCancel,
            style: TextStyle(color: ColorScheme.of(context).outline),
          ),
        ),
        TextButton(
          onPressed: () {
            try {
              final val = int.parse(dynamicPeriod);
              Get.back();
              GStorage.setting.put(SettingBoxKey.dynamicPeriod, val);
              Get.find<MainController>().dynamicPeriod = val * 60 * 1000;
            } catch (e) {
              SmartDialog.showToast(e.toString());
            }
          },
          child: Text(context.l10n.commonConfirm),
        ),
      ],
    ),
  );
}

void _showReplyLengthDialog(BuildContext context, VoidCallback setState) {
  String replyLengthLimit = ReplyItemGrpc.replyLengthLimit.toString();
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(context.l10n.settingsCommentFoldLines),
      content: TextFormField(
        autofocus: true,
        initialValue: replyLengthLimit,
        keyboardType: TextInputType.number,
        onChanged: (value) => replyLengthLimit = value,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        decoration: InputDecoration(
          suffixText: context.l10n.settingsLineCount(''),
        ),
      ),
      actions: [
        TextButton(
          onPressed: Get.back,
          child: Text(
            context.l10n.commonCancel,
            style: TextStyle(color: ColorScheme.of(context).outline),
          ),
        ),
        TextButton(
          onPressed: () async {
            try {
              final val = int.parse(replyLengthLimit);
              Get.back();
              ReplyItemGrpc.replyLengthLimit = val == 0 ? null : val;
              await GStorage.setting.put(SettingBoxKey.replyLengthLimit, val);
              setState();
            } catch (e) {
              SmartDialog.showToast(e.toString());
            }
          },
          child: Text(context.l10n.commonConfirm),
        ),
      ],
    ),
  );
}

void _showDmHeightDialog(BuildContext context, VoidCallback setState) {
  String danmakuLineHeight = Pref.danmakuLineHeight.toString();
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(context.l10n.settingsDanmakuLineHeight),
      content: TextFormField(
        autofocus: true,
        initialValue: danmakuLineHeight,
        keyboardType: const .numberWithOptions(decimal: true),
        onChanged: (value) => danmakuLineHeight = value,
        inputFormatters: FilteringText.decimal,
      ),
      actions: [
        TextButton(
          onPressed: Get.back,
          child: Text(
            context.l10n.commonCancel,
            style: TextStyle(color: ColorScheme.of(context).outline),
          ),
        ),
        TextButton(
          onPressed: () async {
            try {
              final val = max(
                1.0,
                double.parse(danmakuLineHeight).toPrecision(1),
              );
              Get.back();
              await GStorage.setting.put(SettingBoxKey.danmakuLineHeight, val);
              setState();
            } catch (e) {
              SmartDialog.showToast(e.toString());
            }
          },
          child: Text(context.l10n.commonConfirm),
        ),
      ],
    ),
  );
}

void _showTouchSlopDialog(BuildContext context, VoidCallback setState) {
  String initialValue = Pref.touchSlopH.toString();
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(context.l10n.settingsHorizontalSwipeThreshold),
      content: TextFormField(
        autofocus: true,
        initialValue: initialValue,
        keyboardType: const .numberWithOptions(decimal: true),
        onChanged: (value) => initialValue = value,
        inputFormatters: FilteringText.decimal,
      ),
      actions: [
        TextButton(
          onPressed: Get.back,
          child: Text(
            context.l10n.commonCancel,
            style: TextStyle(color: ColorScheme.of(context).outline),
          ),
        ),
        TextButton(
          onPressed: () async {
            try {
              final val = double.parse(initialValue);
              Get.back();
              touchSlopH = val;
              await GStorage.setting.put(SettingBoxKey.touchSlopH, val);
              setState();
            } catch (e) {
              SmartDialog.showToast(e.toString());
            }
          },
          child: Text(context.l10n.commonConfirm),
        ),
      ],
    ),
  );
}

Future<void> _showRefreshDragDialog(
  BuildContext context,
  VoidCallback setState,
) async {
  final res = await showDialog<double>(
    context: context,
    builder: (context) => SliderDialog(
      title: Text(context.l10n.settingsRefreshDragDistance),
      min: 0.1,
      max: 0.5,
      divisions: 8,
      precise: 2,
      value: Pref.refreshDragPercentage,
      suffix: 'x',
    ),
  );
  if (res != null) {
    kDragContainerExtentPercentage = res;
    await GStorage.setting.put(SettingBoxKey.refreshDragPercentage, res);
    setState();
  }
}

Future<void> _showRefreshDialog(
  BuildContext context,
  VoidCallback setState,
) async {
  final res = await showDialog<double>(
    context: context,
    builder: (context) => SliderDialog(
      title: Text(context.l10n.settingsRefreshIndicatorHeight),
      min: 10.0,
      max: 100.0,
      divisions: 9,
      value: Pref.refreshDisplacement,
    ),
  );
  if (res != null) {
    displacement = res;
    await GStorage.setting.put(SettingBoxKey.refreshDisplacement, res);
    if (WidgetsBinding.instance.rootElement case final context?) {
      context.visitChildElements(_visitor);
    }
    setState();
  }
}

void _visitor(Element context) {
  if (!context.mounted) return;
  if (context.widget is RefreshIndicator) {
    context.markNeedsBuild();
  } else {
    context.visitChildren(_visitor);
  }
}

Future<void> _showSuperResolutionDialog(
  BuildContext context,
  VoidCallback setState,
) async {
  final res = await showDialog<SuperResolutionType>(
    context: context,
    builder: (context) => SelectDialog<SuperResolutionType>(
      title: context.l10n.settingsSuperResolution,
      value: Pref.superResolutionType,
      values: SuperResolutionType.values
          .map((e) => (e, e.localizedLabel(context.l10n)))
          .toList(),
    ),
  );
  if (res != null) {
    await GStorage.setting.put(
      SettingBoxKey.superResolutionType,
      res.index,
    );
    setState();
  }
}

Future<void> _showFavDialog(BuildContext context) async {
  if (Accounts.main.isLogin) {
    final res = await FavHttp.allFavFolders(Accounts.main.mid);
    if (res case Success(:final response)) {
      final list = response.list;
      if (list == null || list.isEmpty) {
        return;
      }
      final quickFavId = Pref.quickFavId;
      if (!context.mounted) return;
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          clipBehavior: Clip.hardEdge,
          title: Text(context.l10n.settingsChooseDefaultFavorite),
          contentPadding: const EdgeInsets.only(top: 5, bottom: 18),
          content: SingleChildScrollView(
            child: RadioGroup(
              onChanged: (value) {
                Get.back();
                GStorage.setting.put(SettingBoxKey.quickFavId, value);
                SmartDialog.showToast(context.l10n.settingsSucceeded);
              },
              groupValue: quickFavId,
              child: Column(
                children: list
                    .map(
                      (item) => RadioListTile(
                        toggleable: true,
                        dense: true,
                        title: Text(item.title),
                        value: item.id,
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
        ),
      );
    } else {
      res.toast();
    }
  }
}

Future<void> _showReplyCountDialog(
  BuildContext context,
  VoidCallback setState,
) async {
  final res = await showDialog<double>(
    context: context,
    builder: (context) => SliderDialog(
      title: Text(context.l10n.settingsRetryCount),
      min: 0,
      max: 8,
      divisions: 8,
      precise: 0,
      value: Pref.retryCount.toDouble(),
    ),
  );
  if (res != null) {
    await GStorage.setting.put(SettingBoxKey.retryCount, res.toInt());
    setState();
    SmartDialog.showToast(context.l10n.settingsRestartRequired);
  }
}

Future<void> _showReplyDelayDialog(
  BuildContext context,
  VoidCallback setState,
) async {
  final res = await showDialog<double>(
    context: context,
    builder: (context) => SliderDialog(
      title: Text(context.l10n.settingsRetryDelay),
      min: 0,
      max: 1000,
      divisions: 10,
      precise: 0,
      value: Pref.retryDelay.toDouble(),
      suffix: 'ms',
    ),
  );
  if (res != null) {
    await GStorage.setting.put(SettingBoxKey.retryDelay, res.toInt());
    setState();
    SmartDialog.showToast(context.l10n.settingsRestartRequired);
  }
}

Future<void> _showReplySortDialog(
  BuildContext context,
  VoidCallback setState,
) async {
  final res = await showDialog<ReplySortType>(
    context: context,
    builder: (context) => SelectDialog<ReplySortType>(
      title: context.l10n.settingsCommentDisplay,
      value: Pref.replySortType,
      values: ReplySortType.values
          .take(2)
          .map((e) => (e, e.localizedTitle(context.l10n)))
          .toList(),
    ),
  );
  if (res != null) {
    await GStorage.setting.put(SettingBoxKey.replySortType, res.index);
    setState();
  }
}

Future<void> _showDefDynDialog(
  BuildContext context,
  VoidCallback setState,
) async {
  final res = await showDialog<DynamicsTabType>(
    context: context,
    builder: (context) => SelectDialog<DynamicsTabType>(
      title: context.l10n.settingsFeedDisplay,
      value: Pref.defaultDynamicType,
      values: DynamicsTabType.values
          .take(4)
          .map((e) => (e, e.localizedLabel(context.l10n)))
          .toList(),
    ),
  );
  if (res != null) {
    await GStorage.setting.put(
      SettingBoxKey.defaultDynamicType,
      res.index,
    );
    setState();
  }
}

Future<void> _showMemberTabDialog(
  BuildContext context,
  VoidCallback setState,
) async {
  final res = await showDialog<MemberTabType>(
    context: context,
    builder: (context) => SelectDialog<MemberTabType>(
      title: context.l10n.settingsMemberDefaultTab,
      value: Pref.memberTab,
      values: MemberTabType.values
          .map((e) => (e, e.localizedTitle(context.l10n)))
          .toList(),
    ),
  );
  if (res != null) {
    await GStorage.setting.put(SettingBoxKey.memberTab, res.index);
    setState();
  }
}

void _showProxyDialog(BuildContext context) {
  String systemProxyHost = Pref.systemProxyHost;
  String systemProxyPort = Pref.systemProxyPort;

  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(context.l10n.settingsProxy),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 6),
          TextFormField(
            initialValue: systemProxyHost,
            decoration: InputDecoration(
              isDense: true,
              labelText: context.l10n.settingsProxyHostHint,
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(6)),
              ),
            ),
            onChanged: (e) => systemProxyHost = e,
          ),
          const SizedBox(height: 10),
          TextFormField(
            initialValue: systemProxyPort,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              isDense: true,
              labelText: context.l10n.settingsProxyPortHint,
              border: const OutlineInputBorder(
                borderRadius: .all(.circular(6)),
              ),
            ),
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            onChanged: (e) => systemProxyPort = e,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: Get.back,
          child: Text(
            context.l10n.commonCancel,
            style: TextStyle(color: ColorScheme.of(context).outline),
          ),
        ),
        TextButton(
          onPressed: () {
            Get.back();
            GStorage.setting.put(
              SettingBoxKey.systemProxyHost,
              systemProxyHost,
            );
            GStorage.setting.put(
              SettingBoxKey.systemProxyPort,
              systemProxyPort,
            );
          },
          child: Text(context.l10n.commonConfirm),
        ),
      ],
    ),
  );
}

void _showCacheDialog(BuildContext context, VoidCallback setState) {
  String valueStr = '';
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(context.l10n.settingsMaximumCacheSize),
      content: TextField(
        autofocus: true,
        onChanged: (value) => valueStr = value,
        keyboardType: TextInputType.number,
        inputFormatters: FilteringText.decimal,
        decoration: const InputDecoration(suffixText: 'MB'),
      ),
      actions: [
        TextButton(
          onPressed: Get.back,
          child: Text(
            context.l10n.commonCancel,
            style: TextStyle(color: ColorScheme.of(context).outline),
          ),
        ),
        TextButton(
          onPressed: () async {
            try {
              final val = num.parse(valueStr);
              Get.back();
              await GStorage.setting.put(
                SettingBoxKey.maxCacheSize,
                val * 1024 * 1024,
              );
              setState();
            } catch (e) {
              SmartDialog.showToast(e.toString());
            }
          },
          child: Text(context.l10n.commonConfirm),
        ),
      ],
    ),
  );
}
