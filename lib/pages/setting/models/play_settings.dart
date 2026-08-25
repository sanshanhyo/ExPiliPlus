import 'dart:async' show unawaited;
import 'dart:io' show Platform;

import 'package:ex_piliplus/common/widgets/custom_icon.dart';
import 'package:ex_piliplus/models/common/super_chat_type.dart';
import 'package:ex_piliplus/models/common/video/subtitle_pref_type.dart';
import 'package:ex_piliplus/pages/main/controller.dart';
import 'package:ex_piliplus/pages/setting/models/model.dart';
import 'package:ex_piliplus/pages/setting/pages/fullscreen_sc_size.dart';
import 'package:ex_piliplus/pages/setting/widgets/select_dialog.dart';
import 'package:ex_piliplus/pages/setting/widgets/slider_dialog.dart';
import 'package:ex_piliplus/plugin/pl_player/models/bottom_progress_behavior.dart';
import 'package:ex_piliplus/plugin/pl_player/models/fullscreen_mode.dart';
import 'package:ex_piliplus/plugin/pl_player/models/play_repeat.dart';
import 'package:ex_piliplus/services/service_locator.dart';
import 'package:ex_piliplus/services/network_type_service.dart';
import 'package:ex_piliplus/utils/extension/num_ext.dart';
import 'package:ex_piliplus/utils/extension/l10n_ext.dart';
import 'package:ex_piliplus/utils/platform_utils.dart';
import 'package:ex_piliplus/utils/storage.dart';
import 'package:ex_piliplus/utils/storage_key.dart';
import 'package:ex_piliplus/utils/storage_pref.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

List<SettingsModel> playSettings(BuildContext context) {
  final l10n = context.l10n;
  return [
    SwitchModel(
      title: l10n.settingsDanmakuEnabled,
      subtitle: l10n.settingsDanmakuEnabledDescription,
      leading: const Icon(CustomIcons.dm_settings),
      setKey: SettingBoxKey.enableShowDanmaku,
      defaultVal: true,
    ),
    if (PlatformUtils.isMobile)
      SwitchModel(
        title: l10n.settingsTapDanmaku,
        subtitle: l10n.settingsTapDanmakuDescription,
        leading: const Icon(Icons.touch_app_outlined),
        setKey: SettingBoxKey.enableTapDm,
        defaultVal: true,
      ),
    NormalModel(
      onTap: (context, setState) => Get.toNamed('/playSpeedSet'),
      leading: const Icon(Icons.speed_outlined),
      title: l10n.settingsPlaybackSpeed,
      subtitle: l10n.settingsPlaybackSpeedDescription,
    ),
    if (Platform.isAndroid)
      NormalModel(
        onTap: _showAngleDegreesDialog,
        leading: const Icon(MdiIcons.angleAcute),
        title: l10n.settingsTiltAngleThreshold,
        getSubtitle: () => l10n.settingsCurrentValue('${Pref.angleDegrees}°'),
      ),
    SwitchModel(
      title: l10n.settingsAutoplay,
      subtitle: l10n.settingsAutoplayDescription,
      leading: const Icon(Icons.motion_photos_auto_outlined),
      setKey: SettingBoxKey.autoPlayEnable,
      defaultVal: false,
    ),
    SwitchModel(
      title: l10n.settingsFullscreenLockButton,
      leading: const Icon(Icons.lock_outline),
      setKey: SettingBoxKey.showFsLockBtn,
      defaultVal: true,
    ),
    SwitchModel(
      title: l10n.settingsFullscreenScreenshotButton,
      leading: const Icon(Icons.photo_camera_outlined),
      setKey: SettingBoxKey.showFsScreenshotBtn,
      defaultVal: true,
    ),
    SwitchModel(
      title: l10n.settingsFullscreenBattery,
      leading: const Icon(Icons.battery_3_bar),
      setKey: SettingBoxKey.showBatteryLevel,
      defaultVal: PlatformUtils.isMobile,
    ),
    if (PlatformUtils.isMobile)
      SwitchModel(
        title: l10n.settingsFullscreenNetworkType,
        subtitle: l10n.settingsFullscreenNetworkTypeDescription,
        leading: const Icon(Icons.network_check_outlined),
        setKey: SettingBoxKey.showNetworkType,
        defaultVal: Platform.isIOS,
        onChanged: (value) => NetworkTypeService.setEnabled(value),
        isEnabled: () => NetworkTypeService.phonePermissionGranted.value,
        onDisabledTap: NetworkTypeService.requestPhonePermission,
      ),
    SwitchModel(
      title: l10n.settingsDoubleTapSeek,
      subtitle: l10n.settingsDoubleTapSeekDescription,
      leading: const Icon(Icons.touch_app_outlined),
      setKey: SettingBoxKey.enableQuickDouble,
      defaultVal: true,
    ),
    SwitchModel(
      title: l10n.settingsSlideBrightnessVolume,
      leading: const Icon(MdiIcons.tuneVerticalVariant),
      setKey: SettingBoxKey.enableSlideVolumeBrightness,
      defaultVal: true,
    ),
    if (Platform.isAndroid)
      SwitchModel(
        title: l10n.settingsSystemBrightness,
        leading: const Icon(Icons.brightness_6_outlined),
        setKey: SettingBoxKey.setSystemBrightness,
        defaultVal: false,
      ),
    SwitchModel(
      title: l10n.settingsSlideFullscreen,
      leading: const Icon(MdiIcons.panVertical),
      setKey: SettingBoxKey.enableSlideFS,
      defaultVal: true,
    ),
    if (PlatformUtils.isMobile)
      NormalModel(
        title: l10n.settingsPlayerVolume,
        leading: const Icon(Icons.volume_up),
        getSubtitle: () => l10n.settingsCurrentValue(
          '${Pref.playerVolume.toStringAsFixed(0)}%',
        ),
        onTap: showPlayerVolumeDialog,
      )
    else
      NormalModel(
        title: l10n.settingsMaximumVolume,
        leading: const Icon(Icons.volume_up),
        getSubtitle: () => l10n.settingsCurrentValue(
          '${(Pref.maxVolume * 100).toStringAsFixed(0)}%',
        ),
        onTap: _showMaxVolumeDialog,
      ),
    getVideoFilterSelectModel(
      context: context,
      title: l10n.settingsDoubleTapSeekDuration,
      suffix: 's',
      key: SettingBoxKey.fastForBackwardDuration,
      values: [5, 10, 15],
      defaultValue: 10,
      isFilter: false,
    ),
    SwitchModel(
      title: l10n.settingsRelativeSlideSeek,
      leading: const Icon(Icons.swap_horiz_outlined),
      setKey: SettingBoxKey.useRelativeSlide,
      defaultVal: false,
    ),
    getVideoFilterSelectModel(
      context: context,
      title: l10n.settingsSlideSeekDuration,
      subtitle: l10n.settingsSlideSeekDurationDescription,
      suffix: Pref.useRelativeSlide ? '%' : 's',
      key: SettingBoxKey.sliderDuration,
      values: [25, 50, 90, 100],
      defaultValue: 90,
      isFilter: false,
    ),
    NormalModel(
      title: l10n.settingsAutomaticSubtitles,
      leading: const Icon(Icons.closed_caption_outlined),
      getSubtitle: () => l10n.settingsCurrentPreference(
        Pref.subtitlePreferenceV2.localizedDescription(l10n),
      ),
      onTap: _showSubtitleDialog,
    ),
    if (PlatformUtils.isDesktop)
      SwitchModel(
        title: l10n.settingsPauseWhenMinimized,
        leading: const Icon(Icons.pause_circle_outline),
        setKey: SettingBoxKey.pauseOnMinimize,
        defaultVal: false,
        onChanged: (value) {
          try {
            Get.find<MainController>().pauseOnMinimize = value;
          } catch (_) {}
        },
      ),
    SwitchModel(
      title: l10n.settingsKeyboardControls,
      leading: const Icon(Icons.keyboard_alt_outlined),
      setKey: SettingBoxKey.keyboardControl,
      defaultVal: true,
    ),
    NormalModel(
      title: l10n.settingsSuperChatDisplay,
      leading: const Icon(Icons.live_tv),
      getSubtitle: () => l10n.settingsCurrentValue(
        Pref.superChatType.localizedTitle(l10n),
      ),
      onTap: _showSuperChatDialog,
    ),
    NormalModel(
      title: l10n.settingsFullscreenSuperChatSize,
      subtitle: l10n.settingsFullscreenSuperChatSizeDescription,
      leading: const Icon(Icons.open_in_full),
      onTap: (_, _) => Get.to(const FullScreenScSize()),
    ),
    SwitchModel(
      title: l10n.settingsExpandPortraitVideo,
      subtitle: l10n.settingsExpandPortraitVideoDescription,
      leading: const Icon(Icons.expand_outlined),
      setKey: SettingBoxKey.enableVerticalExpand,
      defaultVal: false,
    ),
    SwitchModel(
      title: l10n.settingsAutoEnterFullscreen,
      subtitle: l10n.settingsAutoEnterFullscreenDescription,
      leading: const Icon(Icons.fullscreen_outlined),
      setKey: SettingBoxKey.enableAutoEnter,
      defaultVal: false,
    ),
    SwitchModel(
      title: l10n.settingsAutoExitFullscreen,
      subtitle: l10n.settingsAutoExitFullscreenDescription,
      leading: const Icon(Icons.fullscreen_exit_outlined),
      setKey: SettingBoxKey.enableAutoExit,
      defaultVal: true,
    ),
    SwitchModel(
      title: l10n.settingsExtendPlayerControls,
      subtitle: l10n.settingsExtendPlayerControlsDescription,
      leading: const Icon(Icons.timer_outlined),
      setKey: SettingBoxKey.enableLongShowControl,
      defaultVal: false,
    ),
    if (PlatformUtils.isMobile)
      SwitchModel(
        title: l10n.settingsBackgroundPlayback,
        subtitle: l10n.settingsBackgroundPlaybackDescription,
        leading: const Icon(Icons.motion_photos_pause_outlined),
        setKey: SettingBoxKey.continuePlayInBackground,
        defaultVal: false,
      ),
    if (Platform.isAndroid) ...[
      SwitchModel(
        title: l10n.settingsBackgroundPictureInPicture,
        subtitle: l10n.settingsBackgroundPictureInPictureDescription,
        leading: const Icon(Icons.picture_in_picture_outlined),
        setKey: SettingBoxKey.autoPiP,
        defaultVal: false,
        onChanged: (val) {
          if (val && !videoPlayerServiceHandler!.enableBackgroundPlay) {
            SmartDialog.showToast(l10n.settingsEnableBackgroundAudioSuggestion);
          }
        },
      ),
      SwitchModel(
        title: l10n.settingsHideDanmakuInPictureInPicture,
        subtitle: l10n.settingsHideDanmakuInPictureInPictureDescription,
        leading: const Icon(CustomIcons.dm_off),
        setKey: SettingBoxKey.pipNoDanmaku,
        defaultVal: false,
      ),
    ],
    SwitchModel(
      title: l10n.settingsReverseFullscreenGesture,
      subtitle: l10n.settingsReverseFullscreenGestureDescription,
      leading: const Icon(Icons.swap_vert),
      setKey: SettingBoxKey.fullScreenGestureReverse,
      defaultVal: false,
    ),
    SwitchModel(
      title: l10n.settingsFullscreenActionButtons,
      leading: const Icon(MdiIcons.dotsHorizontalCircleOutline),
      setKey: SettingBoxKey.showFSActionItem,
      defaultVal: true,
    ),
    SwitchModel(
      title: l10n.settingsOnlineViewerCount,
      subtitle: l10n.settingsOnlineViewerCountDescription,
      leading: const Icon(Icons.people_outlined),
      setKey: SettingBoxKey.enableOnlineTotal,
      defaultVal: false,
    ),
    NormalModel(
      title: l10n.settingsDefaultFullscreenOrientation,
      leading: const Icon(Icons.open_with_outlined),
      getSubtitle: () => l10n.settingsCurrentFullscreenOrientation(
        Pref.fullScreenMode.localizedDescription(l10n),
      ),
      onTap: _showFullScreenModeDialog,
    ),
    NormalModel(
      title: l10n.settingsBottomProgressBar,
      leading: const Icon(Icons.border_bottom_outlined),
      getSubtitle: () => l10n.settingsCurrentBottomProgressBar(
        Pref.btmProgressBehavior.localizedDescription(l10n),
      ),
      onTap: _showProgressBehaviorDialog,
    ),
    if (PlatformUtils.isMobile)
      SwitchModel(
        title: l10n.settingsBackgroundAudioService,
        subtitle: l10n.settingsBackgroundAudioServiceDescription,
        leading: const Icon(Icons.volume_up_outlined),
        setKey: SettingBoxKey.enableBackgroundPlay,
        defaultVal: true,
        onChanged: (value) =>
            videoPlayerServiceHandler!.enableBackgroundPlay = value,
      ),
    if (Platform.isAndroid)
      SwitchModel(
        title: l10n.settingsMixAudioWithOtherApps,
        subtitle: l10n.settingsMixAudioWithOtherAppsDescription,
        leading: const Icon(Icons.library_music_outlined),
        setKey: SettingBoxKey.mixAudioWithOtherApps,
        defaultVal: false,
        onChanged: (value) {
          if (audioSessionHandler case final handler?) {
            unawaited(handler.updateMixWithOthers(value));
          }
        },
      ),
    PopupModel(
      title: l10n.settingsPlaybackOrder,
      leading: const Icon(Icons.repeat),
      value: () => Pref.playRepeat,
      items: PlayRepeat.values,
      labelBuilder: (value) => value.localizedLabel(l10n),
      onSelected: (value, setState) => GStorage.video
          .put(VideoBoxKey.playRepeat, value.index)
          .whenComplete(setState),
    ),
    SwitchModel(
      title: l10n.settingsTemporaryPlayerSettings,
      subtitle: l10n.settingsTemporaryPlayerSettingsDescription,
      leading: const Icon(Icons.video_settings_outlined),
      setKey: SettingBoxKey.tempPlayerConf,
      defaultVal: false,
    ),
  ];
}

Future<void> _showSubtitleDialog(
  BuildContext context,
  VoidCallback setState,
) async {
  final res = await showDialog<SubtitlePrefType>(
    context: context,
    builder: (context) => SelectDialog<SubtitlePrefType>(
      title: context.l10n.settingsSubtitlePreference,
      value: Pref.subtitlePreferenceV2,
      values: SubtitlePrefType.values
          .map((e) => (e, e.localizedDescription(context.l10n)))
          .toList(),
    ),
  );
  if (res != null) {
    await GStorage.setting.put(
      SettingBoxKey.subtitlePreferenceV2,
      res.index,
    );
    setState();
  }
}

Future<void> _showSuperChatDialog(
  BuildContext context,
  VoidCallback setState,
) async {
  final res = await showDialog<SuperChatType>(
    context: context,
    builder: (context) => SelectDialog<SuperChatType>(
      title: context.l10n.settingsSuperChatDisplay,
      value: Pref.superChatType,
      values: SuperChatType.values
          .map((e) => (e, e.localizedTitle(context.l10n)))
          .toList(),
    ),
  );
  if (res != null) {
    await GStorage.setting.put(SettingBoxKey.superChatType, res.index);
    setState();
  }
}

Future<void> _showFullScreenModeDialog(
  BuildContext context,
  VoidCallback setState,
) async {
  final res = await showDialog<FullScreenMode>(
    context: context,
    builder: (context) => SelectDialog<FullScreenMode>(
      title: context.l10n.settingsDefaultFullscreenOrientation,
      value: Pref.fullScreenMode,
      values: FullScreenMode.values
          .map((e) => (e, e.localizedDescription(context.l10n)))
          .toList(),
    ),
  );
  if (res != null) {
    await GStorage.setting.put(SettingBoxKey.fullScreenMode, res.index);
    setState();
  }
}

Future<void> _showProgressBehaviorDialog(
  BuildContext context,
  VoidCallback setState,
) async {
  final res = await showDialog<BtmProgressBehavior>(
    context: context,
    builder: (context) => SelectDialog<BtmProgressBehavior>(
      title: context.l10n.settingsBottomProgressBar,
      value: Pref.btmProgressBehavior,
      values: BtmProgressBehavior.values
          .map((e) => (e, e.localizedDescription(context.l10n)))
          .toList(),
    ),
  );
  if (res != null) {
    await GStorage.setting.put(
      SettingBoxKey.btmProgressBehavior,
      res.index,
    );
    setState();
  }
}

Future<void> _showAngleDegreesDialog(
  BuildContext context,
  VoidCallback setState,
) async {
  final res = await showDialog<double>(
    context: context,
    builder: (context) => SliderDialog(
      title: Text(context.l10n.settingsTiltAngleThreshold),
      min: 10.0,
      max: 90.0,
      divisions: 90,
      precise: 0,
      value: Pref.angleDegrees.toDouble(),
      suffix: '°',
    ),
  );
  if (res != null) {
    await GStorage.setting.put(SettingBoxKey.angleDegrees, res.toInt());
    setState();
  }
}

Future<void> showPlayerVolumeDialog(
  BuildContext context,
  VoidCallback setState, {
  ValueChanged<double>? onChanged,
}) {
  return showVolumeDialog(
    context,
    title: Text(context.l10n.settingsPlayerVolume),
    value: Pref.playerVolume,
    onChanged: (value) => GStorage.setting
        .put(SettingBoxKey.playerVolume, value)
        .whenComplete(() {
          setState();
          onChanged?.call(value);
        }),
  );
}

Future<void> _showMaxVolumeDialog(
  BuildContext context,
  VoidCallback setState,
) {
  return showVolumeDialog(
    context,
    title: Text(context.l10n.settingsMaximumVolume),
    value: Pref.maxVolume * 100,
    onChanged: (rawValue) {
      final maxVolume = (rawValue / 100).toPrecision(2);
      if (Pref.desktopVolume > maxVolume) {
        GStorage.setting.put(SettingBoxKey.desktopVolume, maxVolume);
      }
      GStorage.setting
          .put(SettingBoxKey.maxVolume, maxVolume)
          .whenComplete(setState);
    },
  );
}

const kMinVolume = 100.0;
const kMaxVolume = 300.0;

Future<void> showVolumeDialog(
  BuildContext context, {
  required Widget title,
  required double value,
  required ValueChanged<double> onChanged,
}) async {
  final res = await showDialog<double>(
    context: context,
    builder: (context) => SliderDialog(
      title: title,
      min: kMinVolume,
      max: kMaxVolume,
      divisions: 40,
      precise: 0,
      value: value,
      suffix: '%',
    ),
  );
  if (res != null) {
    onChanged(res);
  }
}
