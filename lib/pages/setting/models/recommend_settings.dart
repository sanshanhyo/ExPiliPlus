import 'package:ex_piliplus/http/video.dart';
import 'package:ex_piliplus/pages/rcmd/controller.dart';
import 'package:ex_piliplus/pages/setting/models/model.dart';
import 'package:ex_piliplus/utils/recommend_filter.dart';
import 'package:ex_piliplus/utils/storage_key.dart';
import 'package:ex_piliplus/utils/extension/l10n_ext.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

List<SettingsModel> recommendSettings(BuildContext context) => [
  SwitchModel(
    title: context.l10n.settingsUseAppRecommendations,
    subtitle: context.l10n.settingsUseAppRecommendationsDescription,
    leading: const Icon(Icons.model_training_outlined),
    setKey: SettingBoxKey.appRcmd,
    defaultVal: true,
    needReboot: true,
  ),
  SwitchModel(
    title: context.l10n.settingsKeepPreviousRecommendations,
    subtitle: context.l10n.settingsKeepPreviousRecommendationsDescription,
    leading: const Icon(Icons.refresh),
    setKey: SettingBoxKey.enableSaveLastData,
    defaultVal: true,
    onChanged: (value) {
      try {
        Get.find<RcmdController>()
          ..enableSaveLastData = value
          ..lastRefreshAt = null;
      } catch (e) {
        if (kDebugMode) debugPrint('$e');
      }
    },
  ),
  SwitchModel(
    title: context.l10n.settingsShowLastPosition,
    subtitle: context.l10n.settingsShowLastPositionDescription,
    leading: const Icon(Icons.tips_and_updates_outlined),
    setKey: SettingBoxKey.savedRcmdTip,
    defaultVal: true,
    onChanged: (value) {
      try {
        Get.find<RcmdController>()
          ..savedRcmdTip = value
          ..lastRefreshAt = null;
      } catch (e) {
        if (kDebugMode) debugPrint('$e');
      }
    },
  ),
  getVideoFilterSelectModel(
    context: context,
    title: context.l10n.settingsLikeRatio,
    suffix: '%',
    key: SettingBoxKey.minLikeRatioForRecommend,
    values: [0, 1, 2, 3, 4],
    onChanged: (value) => RecommendFilter.minLikeRatioForRecommend = value,
  ),
  getBanWordModel(
    context: context,
    title: context.l10n.settingsTitleKeywordFilter,
    key: SettingBoxKey.banWordForRecommend,
    onChanged: (value) {
      RecommendFilter.rcmdRegExp = value;
      RecommendFilter.enableFilter = value.pattern.isNotEmpty;
    },
  ),
  getBanWordModel(
    context: context,
    title: context.l10n.settingsCategoryKeywordFilter,
    key: SettingBoxKey.banWordForZone,
    onChanged: (value) {
      VideoHttp.zoneRegExp = value;
      VideoHttp.enableFilter = value.pattern.isNotEmpty;
    },
  ),
  getVideoFilterSelectModel(
    context: context,
    title: context.l10n.settingsVideoDuration,
    suffix: 's',
    key: SettingBoxKey.minDurationForRcmd,
    values: [0, 30, 60, 90, 120],
    onChanged: (value) => RecommendFilter.minDurationForRcmd = value,
  ),
  getVideoFilterSelectModel(
    context: context,
    title: context.l10n.settingsPlayCount,
    key: SettingBoxKey.minPlayForRcmd,
    values: [0, 50, 100, 500, 1000],
    onChanged: (value) => RecommendFilter.minPlayForRcmd = value,
  ),
  SwitchModel(
    title: context.l10n.settingsExemptFollowedUploaders,
    subtitle: context.l10n.settingsExemptFollowedUploadersDescription,
    leading: const Icon(Icons.favorite_border_outlined),
    setKey: SettingBoxKey.exemptFilterForFollowed,
    defaultVal: true,
    onChanged: (value) => RecommendFilter.exemptFilterForFollowed = value,
  ),
  SwitchModel(
    title: context.l10n.settingsApplyFilterToRelatedVideos,
    subtitle: context.l10n.settingsApplyFilterToRelatedVideosDescription,
    leading: const Icon(Icons.explore_outlined),
    setKey: SettingBoxKey.applyFilterToRelatedVideos,
    defaultVal: true,
    onChanged: (value) => RecommendFilter.applyFilterToRelatedVideos = value,
  ),
];
