import 'dart:async' show Timer;
import 'dart:convert' show jsonDecode, utf8;
import 'dart:io' show Platform, File;
import 'dart:typed_data' show Uint8List;

import 'package:ex_piliplus/common/constants.dart';
import 'package:ex_piliplus/common/widgets/button/icon_button.dart';
import 'package:ex_piliplus/common/widgets/custom_icon.dart';
import 'package:ex_piliplus/common/widgets/dialog/report.dart';
import 'package:ex_piliplus/common/widgets/dialog/simple_dialog_option.dart';
import 'package:ex_piliplus/common/widgets/marquee.dart';
import 'package:ex_piliplus/http/danmaku.dart';
import 'package:ex_piliplus/http/danmaku_block.dart';
import 'package:ex_piliplus/http/init.dart';
import 'package:ex_piliplus/http/live.dart';
import 'package:ex_piliplus/http/loading_state.dart';
import 'package:ex_piliplus/http/video.dart';
import 'package:ex_piliplus/models/common/super_resolution_type.dart';
import 'package:ex_piliplus/models/common/video/audio_quality.dart';
import 'package:ex_piliplus/models/common/video/cdn_type.dart';
import 'package:ex_piliplus/models/common/video/video_decode_type.dart';
import 'package:ex_piliplus/models/common/video/video_quality.dart';
import 'package:ex_piliplus/models/video/play/url.dart';
import 'package:ex_piliplus/models_new/video/video_play_info/subtitle.dart';
import 'package:ex_piliplus/pages/common/common_intro_controller.dart';
import 'package:ex_piliplus/pages/danmaku/danmaku_model.dart';
import 'package:ex_piliplus/pages/setting/models/play_settings.dart'
    show showPlayerVolumeDialog;
import 'package:ex_piliplus/pages/setting/widgets/popup_item.dart';
import 'package:ex_piliplus/pages/setting/widgets/select_dialog.dart';
import 'package:ex_piliplus/pages/video/controller.dart';
import 'package:ex_piliplus/pages/video/introduction/local/controller.dart';
import 'package:ex_piliplus/pages/video/introduction/pgc/controller.dart';
import 'package:ex_piliplus/pages/video/introduction/ugc/controller.dart';
import 'package:ex_piliplus/pages/video/introduction/ugc/widgets/action_item.dart';
import 'package:ex_piliplus/pages/video/introduction/ugc/widgets/menu_row.dart';
import 'package:ex_piliplus/pages/video/widgets/header_mixin.dart';
import 'package:ex_piliplus/plugin/pl_player/controller.dart';
import 'package:ex_piliplus/plugin/pl_player/models/data_source.dart';
import 'package:ex_piliplus/plugin/pl_player/models/play_repeat.dart';
import 'package:ex_piliplus/services/shutdown_timer_service.dart'
    show shutdownTimerService;
import 'package:ex_piliplus/utils/accounts.dart';
import 'package:ex_piliplus/utils/accounts/account.dart';
import 'package:ex_piliplus/utils/android/bindings.g.dart';
import 'package:ex_piliplus/utils/connectivity_utils.dart';
import 'package:ex_piliplus/utils/extension/num_ext.dart';
import 'package:ex_piliplus/utils/extension/l10n_ext.dart';
import 'package:ex_piliplus/utils/extension/string_ext.dart';
import 'package:ex_piliplus/utils/image_utils.dart';
import 'package:ex_piliplus/utils/page_utils.dart';
import 'package:ex_piliplus/utils/platform_utils.dart';
import 'package:ex_piliplus/utils/storage.dart';
import 'package:ex_piliplus/utils/storage_key.dart';
import 'package:ex_piliplus/utils/storage_pref.dart';
import 'package:ex_piliplus/utils/storage_utils.dart';
import 'package:ex_piliplus/utils/subtitle_utils.dart';
import 'package:ex_piliplus/utils/utils.dart';
import 'package:ex_piliplus/utils/video_utils.dart';
import 'package:battery_plus/battery_plus.dart';
import 'package:canvas_danmaku/canvas_danmaku.dart';
import 'package:collection/collection.dart';
import 'package:dio/dio.dart';
import 'package:easy_debounce/easy_throttle.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart' show compute;
import 'package:flutter/material.dart' hide showBottomSheet;
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:hive_ce/hive.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:media_kit/media_kit.dart' show NativePlayer;

mixin TimeBatteryMixin<T extends StatefulWidget> on State<T> {
  PlPlayerController get plPlayerController;
  late final titleKey = GlobalKey();
  ContextSingleTicker? provider;
  ContextSingleTicker get effectiveProvider => provider ??= ContextSingleTicker(
    context,
    autoStart: () =>
        plPlayerController.showControls.value &&
        !plPlayerController.controlsLock.value,
  );

  bool get isPortrait;
  bool get isFullScreen;
  bool get horizontalScreen;

  Timer? _clock;
  RxString now = ''.obs;

  static final _format = DateFormat('HH:mm');

  @override
  void dispose() {
    stopClock();
    super.dispose();
  }

  void startClock() {
    if (!_showCurrTime) return;
    if (_clock == null) {
      now.value = _format.format(DateTime.now());
      _clock ??= Timer.periodic(const Duration(seconds: 1), (Timer t) {
        if (!mounted) {
          stopClock();
          return;
        }
        now.value = _format.format(DateTime.now());
      });
    }
  }

  void stopClock() {
    _clock?.cancel();
    _clock = null;
  }

  bool _showCurrTime = false;
  void showCurrTimeIfNeeded(bool isFullScreen) {
    _showCurrTime = !isPortrait && (isFullScreen || !horizontalScreen);
    if (!_showCurrTime) {
      stopClock();
    }
  }

  late final _battery = Battery();
  late final RxnInt _batteryLevel = RxnInt();
  late final _showBatteryLevel = Pref.showBatteryLevel;
  void getBatteryLevelIfNeeded() {
    if (!_showCurrTime || !_showBatteryLevel) return;
    EasyThrottle.throttle(
      'getBatteryLevel$hashCode',
      const Duration(seconds: 30),
      () async {
        try {
          _batteryLevel.value = await _battery.batteryLevel;
        } catch (_) {}
      },
    );
  }

  List<Widget>? get timeBatteryWidgets {
    if (_showCurrTime) {
      return [
        if (_showBatteryLevel) ...[
          Obx(
            () {
              final batteryLevel = _batteryLevel.value;
              if (batteryLevel == null) {
                return const SizedBox.shrink();
              }
              return Text(
                '$batteryLevel%',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                ),
              );
            },
          ),
          const SizedBox(width: 10),
        ],
        Obx(
          () => Text(
            now.value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 13,
            ),
          ),
        ),
      ];
    }
    return null;
  }
}

class HeaderControl extends StatefulWidget {
  const HeaderControl({
    required this.isPortrait,
    required this.controller,
    required this.videoDetailCtr,
    required this.heroTag,
    super.key,
  });

  final bool isPortrait;
  final PlPlayerController controller;
  final VideoDetailController videoDetailCtr;
  final String heroTag;

  @override
  State<HeaderControl> createState() => HeaderControlState();

  static Future<bool> likeDanmaku(VideoDanmaku extra, int cid) async {
    final l10n = Get.context!.l10n;
    if (!Accounts.main.isLogin) {
      SmartDialog.showToast(l10n.accountPleaseSignIn);
      return false;
    }
    final isLike = !extra.isLike;
    final res = await DanmakuHttp.danmakuLike(
      isLike: isLike,
      cid: cid,
      id: extra.id,
    );
    if (res.isSuccess) {
      extra.isLike = isLike;
      if (isLike) {
        extra.like++;
      } else {
        extra.like--;
      }
      SmartDialog.showToast(
        isLike ? l10n.videoLikeSucceeded : l10n.videoUnlikeSucceeded,
      );
      return true;
    } else {
      res.toast();
      if (res case Error(:final code)) {
        if (code == 65006) {
          extra.isLike = true;
          return true;
        }
        if (code == 65004) {
          extra.isLike = false;
          return true;
        }
      }
      return false;
    }
  }

  static Future<bool> deleteDanmaku(int id, int cid) async {
    final l10n = Get.context!.l10n;
    final res = await DanmakuHttp.danmakuRecall(
      cid: cid,
      id: id,
    );
    if (res.isSuccess) {
      SmartDialog.showToast(l10n.commonDeleted);
      return true;
    } else {
      res.toast();
      return false;
    }
  }

  static Future<void> reportDanmaku(
    BuildContext context, {
    required VideoDanmaku extra,
    required PlPlayerController ctr,
  }) {
    if (Accounts.main.isLogin) {
      return autoWrapReportDialog(
        context,
        ReportOptions.danmakuReport,
        (reasonType, reasonDesc, banUid) {
          if (banUid) {
            final filter = ctr.filters;
            if (filter.dmUid.add(extra.mid)) {
              filter.count++;
              GStorage.localCache.put(
                LocalCacheKey.danmakuFilterRules,
                filter,
              );
            }
            DanmakuFilterHttp.danmakuFilterAdd(
              filter: extra.mid,
              type: 2,
            );
          }
          return DanmakuHttp.danmakuReport(
            reason: reasonType == 0 ? 11 : reasonType,
            cid: ctr.cid!,
            id: extra.id,
            content: reasonType == 0 ? reasonDesc : null,
          );
        },
      );
    } else {
      return SmartDialog.showToast(context.l10n.accountPleaseSignIn);
    }
  }

  static Future<void> reportLiveDanmaku(
    BuildContext context, {
    required int roomId,
    required String msg,
    required LiveDanmaku extra,
  }) {
    if (Accounts.main.isLogin) {
      return autoWrapReportDialog(
        context,
        ban: false,
        ReportOptions.liveDanmakuReport,
        (reasonType, reasonDesc, banUid) {
          // if (banUid) {
          //   final filter = ctr.filters;
          //   if (filter.dmUid.add(extra.mid)) {
          //     filter.count++;
          //     GStorage.localCache.put(
          //       LocalCacheKey.danmakuFilterRules,
          //       filter,
          //     );
          //   }
          //   DanmakuFilterHttp.danmakuFilterAdd(
          //     filter: extra.mid,
          //     type: 2,
          //   );
          // }
          return LiveHttp.liveDmReport(
            roomId: roomId,
            mid: extra.mid,
            msg: msg,
            reason: ReportOptions.liveDanmakuReport['']![reasonType]!,
            reasonId: reasonType,
            dmType: extra.dmType,
            idStr: extra.id,
            ts: extra.ts,
            sign: extra.ct,
          );
        },
      );
    } else {
      return SmartDialog.showToast(context.l10n.accountPleaseSignIn);
    }
  }
}

class HeaderControlState extends State<HeaderControl>
    with HeaderMixin, TimeBatteryMixin {
  @override
  late final PlPlayerController plPlayerController = widget.controller;
  late final VideoDetailController videoDetailCtr = widget.videoDetailCtr;
  late final PlayUrlModel videoInfo = videoDetailCtr.data;
  static const TextStyle subTitleStyle = TextStyle(fontSize: 12);
  static const TextStyle titleStyle = TextStyle(fontSize: 14);

  String get heroTag => widget.heroTag;
  late final UgcIntroController ugcIntroController;
  late final PgcIntroController pgcIntroController;
  late final LocalIntroController localIntroController;
  late CommonIntroController introController = isFileSource
      ? localIntroController
      : videoDetailCtr.isUgc
      ? ugcIntroController
      : pgcIntroController;

  @override
  bool get isPortrait => widget.isPortrait;
  @override
  late final horizontalScreen = videoDetailCtr.horizontalScreen;

  Box setting = GStorage.setting;

  @override
  void initState() {
    super.initState();
    if (isFileSource) {
      introController = Get.find<LocalIntroController>(tag: heroTag);
    } else if (videoDetailCtr.isUgc) {
      introController = Get.find<UgcIntroController>(tag: heroTag);
    } else {
      introController = Get.find<PgcIntroController>(tag: heroTag);
    }
  }

  /// 设置面板
  void showSettingSheet() {
    showBottomSheet(
      (context, setState) {
        final theme = Theme.of(context);
        final l10n = context.l10n;
        return Padding(
          padding: const EdgeInsets.all(12),
          child: Material(
            clipBehavior: Clip.hardEdge,
            color: theme.colorScheme.surface,
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 14),
              children: [
                ListTile(
                  dense: true,
                  onTap: () {
                    Get.back();
                    introController.viewLater();
                  },
                  leading: const Icon(Icons.watch_later_outlined, size: 20),
                  title: Text(l10n.videoAddToWatchLater, style: titleStyle),
                ),
                if (videoDetailCtr.epId == null)
                  ListTile(
                    dense: true,
                    onTap: () {
                      Get.back();
                      videoDetailCtr.showNoteList(context);
                    },
                    leading: const Icon(Icons.note_alt_outlined, size: 20),
                    title: Text(l10n.videoViewNotes, style: titleStyle),
                  ),
                if (!isFileSource)
                  ListTile(
                    dense: true,
                    onTap: () {
                      Get.back();
                      videoDetailCtr.onDownload(this.context);
                    },
                    leading: const Icon(
                      MdiIcons.folderDownloadOutline,
                      size: 20,
                    ),
                    title: Text(l10n.mineDownloads, style: titleStyle),
                  ),
                if (widget.videoDetailCtr.cover.value.isNotEmpty)
                  ListTile(
                    dense: true,
                    onTap: () {
                      Get.back();
                      ImageUtils.downloadImg([
                        widget.videoDetailCtr.cover.value,
                      ]);
                    },
                    leading: const Icon(Icons.image_outlined, size: 20),
                    title: Text(l10n.videoSaveCover, style: titleStyle),
                  ),
                ListTile(
                  dense: true,
                  onTap: () {
                    Get.back();
                    shutdownTimerService.showScheduleExitDialog(
                      this.context,
                      isFullScreen: isFullScreen,
                    );
                  },
                  leading: const Icon(Icons.hourglass_top_outlined, size: 20),
                  title: Text(l10n.playerSleepTimer, style: titleStyle),
                ),
                if (!isFileSource) ...[
                  ListTile(
                    dense: true,
                    onTap: () {
                      Get.back();
                      videoDetailCtr.editPlayUrl();
                    },
                    leading: const Icon(
                      Icons.link,
                      size: 20,
                    ),
                    title: Text(l10n.playerPlaybackUrl, style: titleStyle),
                  ),
                  ListTile(
                    dense: true,
                    onTap: () {
                      Get.back();
                      videoDetailCtr.queryVideoUrl(fromReset: true);
                    },
                    leading: const Icon(Icons.refresh_outlined, size: 20),
                    title: Text(l10n.playerReloadVideo, style: titleStyle),
                  ),
                ],
                PopupListTile<SuperResolutionType>(
                  dense: true,
                  leading: const Icon(
                    Icons.stay_current_landscape_outlined,
                    size: 20,
                  ),
                  title: Text(l10n.playerSuperResolution),
                  value: () {
                    final value = plPlayerController.superResolutionType.value;
                    return (value, value.localizedLabel(l10n));
                  },
                  itemBuilder: (_) => SuperResolutionType.values
                      .map(
                        (value) => PopupMenuItem(
                          value: value,
                          child: Text(value.localizedLabel(l10n)),
                        ),
                      )
                      .toList(),
                  onSelected: (value, setState) {
                    plPlayerController.setShader(value);
                    setState();
                  },
                  descFontSize: 12,
                  descPosType: .subtitle,
                ),
                if (PlatformUtils.isMobile)
                  if (plPlayerController.videoPlayerController
                      case final player?)
                    Builder(
                      builder: (context) => ListTile(
                        dense: true,
                        leading: const Icon(Icons.volume_up, size: 20),
                        title: Text(l10n.playerVolume),
                        subtitle: Text(
                          l10n.settingsCurrentValue(
                            '${Pref.playerVolume.toStringAsFixed(0)}%',
                          ),
                        ),
                        onTap: () => showPlayerVolumeDialog(
                          context,
                          () => (context as Element).markNeedsBuild(),
                          onChanged: player.setVolume,
                        ),
                      ),
                    ),
                if (!isFileSource)
                  ListTile(
                    dense: true,
                    title: Text(l10n.playerCdnSettings, style: titleStyle),
                    leading: const Icon(MdiIcons.cloudPlusOutline, size: 20),
                    subtitle: Text(
                      l10n.playerCurrentCdn(
                        VideoUtils.cdnService.localizedLabel(l10n),
                      ),
                      style: subTitleStyle,
                    ),
                    onTap: () async {
                      Get.back();
                      final result = await showDialog<CDNService>(
                        context: context,
                        builder: (context) => CdnSelectDialog(
                          sample: videoInfo.dash?.video?.firstOrNull,
                        ),
                      );
                      if (result != null) {
                        VideoUtils.cdnService = result;
                        setting.put(SettingBoxKey.CDNService, result.name);
                        SmartDialog.showToast(
                          l10n.playerCdnSetReloading(
                            result.localizedLabel(l10n),
                          ),
                        );
                        videoDetailCtr.queryVideoUrl(fromReset: true);
                      }
                    },
                  ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    spacing: 10,
                    children: [
                      Obx(
                        () {
                          final flipX = plPlayerController.flipX.value;
                          return ActionRowLineItem(
                            iconData: Icons.flip,
                            onTap: () =>
                                plPlayerController.flipX.value = !flipX,
                            text: l10n.playerFlipHorizontal,
                            selectStatus: flipX,
                          );
                        },
                      ),
                      Obx(
                        () {
                          final flipY = plPlayerController.flipY.value;
                          return ActionRowLineItem(
                            icon: Icon(
                              CustomIcons.flip_rotate_90,
                              size: 13,
                              color: flipY
                                  ? theme.colorScheme.onSecondaryContainer
                                  : theme.colorScheme.outline,
                            ),
                            onTap: () {
                              plPlayerController.flipY.value = !flipY;
                            },
                            text: l10n.playerFlipVertical,
                            selectStatus: flipY,
                          );
                        },
                      ),
                      if ((isFileSource &&
                              !(plPlayerController.dataSource as FileSource)
                                  .isMp4) ||
                          (!isFileSource &&
                              videoDetailCtr.audioUrl?.isNotEmpty == true))
                        Obx(
                          () {
                            final onlyPlayAudio =
                                plPlayerController.onlyPlayAudio.value;
                            return ActionRowLineItem(
                              iconData: Icons.headphones,
                              onTap: () {
                                plPlayerController.onlyPlayAudio.value =
                                    !onlyPlayAudio;
                                final player =
                                    plPlayerController.videoPlayerController!;
                                if (onlyPlayAudio &&
                                    player.state.tracks.video.length <= 2) {
                                  videoDetailCtr.playerInit();
                                } else {
                                  player.setProperty(
                                    'file-local-options/vid',
                                    onlyPlayAudio ? 'auto' : 'no',
                                  );
                                }
                              },
                              text: l10n.playerAudioOnly,
                              selectStatus: onlyPlayAudio,
                            );
                          },
                        ),
                      if (PlatformUtils.isMobile)
                        Obx(
                          () => ActionRowLineItem(
                            iconData: Icons.play_circle_outline,
                            onTap:
                                plPlayerController.setContinuePlayInBackground,
                            text: l10n.playerBackgroundPlayback,
                            selectStatus: plPlayerController
                                .continuePlayInBackground
                                .value,
                          ),
                        ),
                    ],
                  ),
                ),
                if (!isFileSource) ...[
                  ListTile(
                    dense: true,
                    onTap: () {
                      Get.back();
                      showSetVideoQa();
                    },
                    leading: const Icon(Icons.play_circle_outline, size: 20),
                    title: Text(
                      l10n.playerSelectVideoQuality,
                      style: titleStyle,
                    ),
                    subtitle: Text(
                      l10n.playerCurrentVideoQuality(
                        videoDetailCtr.currentVideoQa.value?.localizedLabel(
                              l10n,
                            ) ??
                            l10n.commonUnavailable,
                      ),
                      style: subTitleStyle,
                    ),
                  ),
                  if (videoDetailCtr.currentAudioQa != null)
                    ListTile(
                      dense: true,
                      onTap: () {
                        Get.back();
                        showSetAudioQa();
                      },
                      leading: const Icon(Icons.album_outlined, size: 20),
                      title: Text(
                        l10n.playerSelectAudioQuality,
                        style: titleStyle,
                      ),
                      subtitle: Text(
                        l10n.playerCurrentAudioQuality(
                          videoDetailCtr.currentAudioQa!.localizedLabel(l10n),
                        ),
                        style: subTitleStyle,
                      ),
                    ),
                  ListTile(
                    dense: true,
                    onTap: () {
                      Get.back();
                      showSetDecodeFormats();
                    },
                    leading: const Icon(Icons.av_timer_outlined, size: 20),
                    title: Text(l10n.playerCodec, style: titleStyle),
                    subtitle: Text(
                      l10n.playerCurrentCodec(
                        videoDetailCtr.currentDecodeFormats.description,
                      ),
                      style: subTitleStyle,
                    ),
                  ),
                ],
                PopupListTile(
                  dense: true,
                  leading: const Icon(Icons.repeat, size: 20),
                  title: Text(l10n.playerPlaybackOrder),
                  value: () {
                    final value = plPlayerController.playRepeat;
                    return (value, value.localizedLabel(l10n));
                  },
                  itemBuilder: (_) => PlayRepeat.values
                      .map(
                        (value) => PopupMenuItem(
                          value: value,
                          child: Text(value.localizedLabel(l10n)),
                        ),
                      )
                      .toList(),
                  onSelected: (value, setState) {
                    plPlayerController.setPlayRepeat(value);
                    setState();
                  },
                  descPosType: .subtitle,
                  descFontSize: 12,
                ),
                ListTile(
                  dense: true,
                  onTap: () {
                    Get.back();
                    showDanmakuPool();
                  },
                  leading: const Icon(CustomIcons.dm_on, size: 20),
                  title: Text(l10n.playerDanmakuList, style: titleStyle),
                ),
                ListTile(
                  dense: true,
                  onTap: () {
                    Get.back();
                    showSetDanmaku();
                  },
                  leading: const Icon(CustomIcons.dm_settings, size: 20),
                  title: Text(l10n.playerDanmakuSettings, style: titleStyle),
                ),
                ListTile(
                  dense: true,
                  onTap: () {
                    Get.back();
                    showSetSubtitle();
                  },
                  leading: const Icon(Icons.subtitles_outlined, size: 20),
                  title: Text(l10n.playerSubtitleSettings, style: titleStyle),
                ),
                ListTile(
                  dense: true,
                  onTap: () async {
                    Get.back();
                    try {
                      final result = await FilePicker.pickFile(
                        type: .custom,
                        allowedExtensions: const ['json', 'vtt', 'srt', 'ass'],
                      );
                      if (result != null) {
                        final file = result.xFile;
                        final path = file.path;
                        final name = file.name;
                        final length = videoDetailCtr.subtitles.length;
                        if (name.endsWith('.json')) {
                          final file = File(path);
                          final stream = file.openRead().transform(
                            utf8.decoder,
                          );
                          final buffer = StringBuffer();
                          await for (final chunk in stream) {
                            if (!mounted) return;
                            buffer.write(chunk);
                          }
                          if (!mounted) return;
                          String sub = buffer.toString();
                          sub = await compute<List, String>(
                            SubtitleUtils.json2Vtt,
                            jsonDecode(sub)['body'],
                          );
                          if (!mounted) return;
                          videoDetailCtr.vttSubtitles[length] = (
                            isData: true,
                            id: sub,
                          );
                        } else {
                          videoDetailCtr.vttSubtitles[length] = (
                            isData: false,
                            id: path,
                          );
                        }
                        videoDetailCtr.subtitles.add(
                          Subtitle(
                            lan: '',
                            lanDoc: name.split('.').firstOrNull ?? name,
                          ),
                        );
                        await videoDetailCtr.setSubtitle(length + 1);
                      }
                    } catch (e) {
                      SmartDialog.showToast(l10n.commonLoadFailed('$e'));
                    }
                  },
                  leading: const Icon(Icons.file_open_outlined, size: 20),
                  title: Text(l10n.playerLoadSubtitles, style: titleStyle),
                ),
                if (!videoDetailCtr.isFileSource &&
                    videoDetailCtr.subtitles.isNotEmpty)
                  ListTile(
                    dense: true,
                    onTap: () {
                      Get.back();
                      onExportSubtitle();
                    },
                    leading: const Icon(Icons.download_outlined, size: 20),
                    title: Text(l10n.playerSaveSubtitles, style: titleStyle),
                  ),
                if (plPlayerController.videoPlayerController case final player?)
                  ListTile(
                    dense: true,
                    title: Text(l10n.playerPlaybackInfo, style: titleStyle),
                    leading: const Icon(Icons.info_outline, size: 20),
                    onTap: () => showPlayerInfo(context, player: player),
                  ),
                ListTile(
                  dense: true,
                  onTap: () {
                    if (!Accounts.main.isLogin) {
                      SmartDialog.showToast(l10n.accountPleaseSignIn);
                      return;
                    }
                    Get.back();
                    PageUtils.reportVideo(videoDetailCtr.aid);
                  },
                  leading: const Icon(Icons.error_outline, size: 20),
                  title: Text(l10n.commonReport, style: titleStyle),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static void showPlayerInfo(
    BuildContext context, {
    required NativePlayer player,
  }) {
    final hwdec = player.getProperty('hwdec-current');
    final volume = player.getProperty('volume').subLength(3);
    showDialog(
      context: context,
      builder: (context) {
        final state = player.state;
        final colorScheme = ColorScheme.of(context);
        final l10n = context.l10n;
        return AlertDialog(
          title: Text(l10n.playerPlaybackInfo),
          contentPadding: const EdgeInsets.only(top: 16),
          content: Material(
            type: MaterialType.transparency,
            child: ListTileTheme(
              contentPadding: const .symmetric(horizontal: 24),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ListTile(
                      dense: true,
                      title: Text(l10n.playerInfoResolution),
                      subtitle: Text('${state.width}x${state.height}'),
                      onTap: () => Utils.copyText(
                        '${l10n.playerInfoResolution}\n${state.width}x${state.height}',
                      ),
                    ),
                    ListTile(
                      dense: true,
                      title: Text(l10n.playerInfoVideoParameters),
                      subtitle: Text(state.videoParams.toString()),
                      onTap: () => Utils.copyText(
                        '${l10n.playerInfoVideoParameters}\n${state.videoParams}',
                      ),
                    ),
                    ListTile(
                      dense: true,
                      title: Text(l10n.playerInfoAudioParameters),
                      subtitle: Text(state.audioParams.toString()),
                      onTap: () => Utils.copyText(
                        '${l10n.playerInfoAudioParameters}\n${state.audioParams}',
                      ),
                    ),
                    ListTile(
                      dense: true,
                      title: Text(l10n.playerInfoMedia),
                      subtitle: Text(state.playlist.toString()),
                      onTap: () => Utils.copyText(
                        '${l10n.playerInfoMedia}\n${state.playlist}',
                      ),
                    ),
                    ListTile(
                      dense: true,
                      title: Text(l10n.playerInfoAudioTrack),
                      subtitle: Text(state.track.audio.toString()),
                      onTap: () => Utils.copyText(
                        '${l10n.playerInfoAudioTrack}\n${state.track.audio}',
                      ),
                    ),
                    ListTile(
                      dense: true,
                      title: Text(l10n.playerInfoVideoTrack),
                      subtitle: Text(state.track.video.toString()),
                      onTap: () => Utils.copyText(
                        '${l10n.playerInfoVideoTrack}\n${state.track.audio}',
                      ),
                    ),
                    ListTile(
                      dense: true,
                      title: Text(l10n.playerInfoPlaybackRate),
                      subtitle: Text(state.rate.toString()),
                      onTap: () => Utils.copyText(
                        '${l10n.playerInfoPlaybackRate}\n${state.rate}',
                      ),
                    ),
                    ListTile(
                      dense: true,
                      title: Text(l10n.playerVolume),
                      subtitle: Text(volume.toString()),
                      onTap: () =>
                          Utils.copyText('${l10n.playerVolume}\n$volume'),
                    ),
                    ListTile(
                      dense: true,
                      title: Text(l10n.playerInfoHardwareDecoder),
                      subtitle: Text(hwdec),
                      onTap: () => Utils.copyText(
                        '${l10n.playerInfoHardwareDecoder}\n$hwdec',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: Get.back,
              child: Text(
                l10n.commonConfirm,
                style: TextStyle(color: colorScheme.outline),
              ),
            ),
          ],
        );
      },
    );
  }

  /// 选择画质
  void showSetVideoQa() {
    final l10n = context.l10n;
    if (videoInfo.dash == null) {
      SmartDialog.showToast(l10n.playerVideoQualityNotSupported);
      return;
    }
    final VideoQuality? currentVideoQa = videoDetailCtr.currentVideoQa.value;
    if (currentVideoQa == null) return;

    final List<FormatItem> videoFormat = videoInfo.supportFormats!;

    /// 总质量分类
    final int totalQaSam = videoFormat.length;

    /// 可用的质量分类
    int usefulQaSam = 0;
    final List<VideoItem> video = videoInfo.dash!.video!;
    final Set<int> idSet = {};
    for (final VideoItem item in video) {
      final int id = item.id!;
      if (!idSet.contains(id)) {
        idSet.add(id);
        usefulQaSam++;
      }
    }

    showBottomSheet(
      (context, setState) {
        final theme = Theme.of(context);
        return Padding(
          padding: const EdgeInsets.all(12),
          child: Material(
            clipBehavior: Clip.hardEdge,
            color: theme.colorScheme.surface,
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 45,
                    child: GestureDetector(
                      onTap: () => SmartDialog.showToast(
                        l10n.playerPremiumQualityHint,
                      ),
                      child: Row(
                        spacing: 8,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            l10n.playerSelectVideoQuality,
                            style: titleStyle,
                          ),
                          Icon(
                            Icons.info_outline,
                            size: 16,
                            color: theme.colorScheme.outline,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SliverList.builder(
                  itemCount: totalQaSam,
                  itemBuilder: (context, index) {
                    final item = videoFormat[index];
                    final isCurr = currentVideoQa.code == item.quality;
                    return ListTile(
                      dense: true,
                      onTap: () async {
                        if (isCurr) {
                          return;
                        }
                        Get.back();
                        final int quality = item.quality!;
                        final newQa = VideoQuality.fromCode(quality);
                        videoDetailCtr
                          ..plPlayerController.cacheVideoQa = newQa.code
                          ..currentVideoQa.value = newQa
                          ..updatePlayer();

                        SmartDialog.showToast(
                          l10n.playerVideoQualityChanged(
                            newQa.localizedLabel(l10n),
                          ),
                        );

                        // update
                        if (!plPlayerController.tempPlayerConf) {
                          setting.put(
                            await ConnectivityUtils.isWiFi
                                ? SettingBoxKey.defaultVideoQa
                                : SettingBoxKey.defaultVideoQaCellular,
                            quality,
                          );
                        }
                      },
                      // 可能包含会员解锁画质
                      enabled: index >= totalQaSam - usefulQaSam,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      title: Text(
                        VideoQuality.maybeFromCode(
                              item.quality,
                            )?.localizedLabel(l10n) ??
                            item.newDesc!,
                      ),
                      trailing: isCurr
                          ? Icon(
                              Icons.done,
                              color: theme.colorScheme.primary,
                            )
                          : Text(
                              item.format!,
                              style: subTitleStyle,
                            ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// 选择音质
  void showSetAudioQa() {
    final l10n = context.l10n;
    final AudioQuality currentAudioQa = videoDetailCtr.currentAudioQa!;
    final List<AudioItem> audio = videoInfo.dash!.audio!;
    showBottomSheet(
      (context, setState) {
        final theme = Theme.of(context);
        return Padding(
          padding: const EdgeInsets.all(12),
          child: Material(
            clipBehavior: Clip.hardEdge,
            color: theme.colorScheme.surface,
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 45,
                    child: Center(
                      child: Text(
                        l10n.playerSelectAudioQuality,
                        style: titleStyle,
                      ),
                    ),
                  ),
                ),
                SliverList.builder(
                  itemCount: audio.length,
                  itemBuilder: (context, index) {
                    final item = audio[index];
                    final isCurr = currentAudioQa.code == item.id;
                    return ListTile(
                      dense: true,
                      onTap: () async {
                        if (isCurr) {
                          return;
                        }
                        Get.back();
                        final int quality = item.id!;
                        final newQa = AudioQuality.fromCode(quality);
                        videoDetailCtr
                          ..plPlayerController.cacheAudioQa = newQa.code
                          ..currentAudioQa = newQa
                          ..updatePlayer();

                        SmartDialog.showToast(
                          l10n.playerAudioQualityChanged(
                            newQa.localizedLabel(l10n),
                          ),
                        );

                        // update
                        if (!plPlayerController.tempPlayerConf) {
                          setting.put(
                            await ConnectivityUtils.isWiFi
                                ? SettingBoxKey.defaultAudioQa
                                : SettingBoxKey.defaultAudioQaCellular,
                            quality,
                          );
                        }
                      },
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      title: Text(
                        AudioQuality.maybeFromCode(item.id)?.localizedLabel(
                              l10n,
                            ) ??
                            item.quality,
                      ),
                      subtitle: Text(
                        item.codecs!,
                        style: subTitleStyle,
                      ),
                      trailing: isCurr
                          ? Icon(
                              Icons.done,
                              color: theme.colorScheme.primary,
                            )
                          : null,
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // 选择解码格式
  void showSetDecodeFormats() {
    final l10n = context.l10n;
    final firstCode = videoDetailCtr.firstVideo.quality.code;
    // 当前视频可用的解码格式
    final videoFormat = videoInfo.supportFormats!;

    final list = videoFormat.firstWhere((e) => e.quality == firstCode).codecs;
    if (list == null) {
      SmartDialog.showToast(l10n.playerCodecNotSupported);
      return;
    }

    // 当前选中的解码格式
    final curCodecs = videoDetailCtr.currentDecodeFormats.codes;
    showBottomSheet(
      (context, setState) {
        final colorScheme = ColorScheme.of(context);
        return Padding(
          padding: const EdgeInsets.all(12),
          child: Material(
            clipBehavior: Clip.hardEdge,
            color: colorScheme.surface,
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            child: Column(
              children: [
                SizedBox(
                  height: 45,
                  child: Center(
                    child: Text(l10n.playerSelectCodec, style: titleStyle),
                  ),
                ),
                Expanded(
                  child: CustomScrollView(
                    slivers: [
                      SliverList.builder(
                        itemCount: list.length,
                        itemBuilder: (context, index) {
                          final item = list[index];
                          final format = VideoDecodeFormatType.fromString(item);
                          final isCurr = curCodecs.any(item.startsWith);
                          return ListTile(
                            dense: true,
                            onTap: () {
                              if (isCurr) return;
                              Get.back();
                              videoDetailCtr
                                ..currentDecodeFormats = format
                                ..updatePlayer();
                              SmartDialog.showToast(
                                l10n.playerCodecChanged(format.name),
                              );
                            },
                            contentPadding: const .symmetric(horizontal: 20),
                            title: Text(format.description),
                            subtitle: Text(item, style: subTitleStyle),
                            trailing: isCurr
                                ? Icon(Icons.done, color: colorScheme.primary)
                                : null,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void onExportSubtitle() {
    showDialog(
      context: context,
      builder: (context) {
        SubtitleFormat format = .vtt;
        final subtitles = videoDetailCtr.subtitles;
        final secondary = ColorScheme.of(context).secondary;
        final l10n = context.l10n;
        return SimpleDialog(
          clipBehavior: .hardEdge,
          contentPadding: const .only(bottom: 12),
          titlePadding: const .fromLTRB(20, 20, 20, 12),
          title: Row(
            children: [
              Expanded(child: Text(l10n.playerSaveSubtitles)),
              Text(
                '${l10n.commonFormat}: ',
                style: const TextStyle(fontSize: 14),
              ),
              Builder(
                builder: (context) => PopupMenuButton<SubtitleFormat>(
                  tooltip: '',
                  initialValue: format,
                  onSelected: (value) {
                    format = value;
                    (context as Element).markNeedsBuild();
                  },
                  itemBuilder: (_) => SubtitleFormat.values
                      .map(
                        (e) => PopupMenuItem(
                          value: e,
                          height: 35,
                          child: Text(e.label),
                        ),
                      )
                      .toList(),
                  child: Padding(
                    padding: const .symmetric(horizontal: 2, vertical: 5),
                    child: Text.rich(
                      style: .new(fontSize: 14, color: secondary),
                      TextSpan(
                        children: [
                          TextSpan(text: format.label),
                          WidgetSpan(
                            alignment: .middle,
                            child: Icon(
                              size: 14,
                              MdiIcons.unfoldMoreHorizontal,
                              color: secondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          children: List.generate(subtitles.length, (i) {
            final item = subtitles[i];
            return DialogOption(
              onPressed: () async {
                Get.back();
                final url = item.subtitleUrl;
                if (url == null || url.isEmpty) return;
                try {
                  final Uint8List bytes;
                  switch (format) {
                    case .vtt || .srt:
                      var subtitle = format == .vtt
                          ? videoDetailCtr.vttSubtitles[i]?.id
                          : null;
                      if (subtitle == null) {
                        final res = await VideoHttp.vttSubtitles(
                          item.subtitleUrl!,
                          format: format,
                        );
                        if (res == null) return;
                        subtitle = res;
                        if (format == .vtt) {
                          videoDetailCtr.vttSubtitles[i] = (
                            isData: true,
                            id: res,
                          );
                        }
                      }
                      bytes = utf8.encode(subtitle);
                    case .json:
                      final res = await Request.dio.get<Uint8List>(
                        url.http2https,
                        options: Options(
                          responseType: .bytes,
                          headers: Constants.baseHeaders,
                          extra: {'account': const NoAccount()},
                        ),
                      );
                      if (res.statusCode != 200) return;
                      bytes = Uint8List.fromList(
                        Request.responseBytesDecoder(
                          res.data!,
                          res.headers.map,
                        ),
                      );
                  }
                  final videoDetail = introController.videoDetail.value;
                  final name =
                      '${videoDetail.title}-${videoDetail.owner?.name}(${videoDetail.owner?.mid})-${videoDetailCtr.bvid}-${videoDetailCtr.cid.value}-${item.lanDoc}.${format.name}'
                          .replaceAll(
                            Platform.isWindows ? RegExp(r'[<>:/\\|?*"]') : '/',
                            '_',
                          );
                  // Reserved characters may not be used in file names. See: https://docs.microsoft.com/en-us/windows/win32/fileio/naming-a-file#naming-conventions
                  StorageUtils.saveBytes2File(
                    name: name,
                    bytes: bytes,
                    allowedExtensions: [format.name],
                  );
                } catch (e, s) {
                  Utils.reportError(e, s);
                  SmartDialog.showToast(e.toString());
                }
              },
              child: Text(item.lanDoc ?? item.lan),
            );
          }),
        );
      },
    );
  }

  double get subtitleFontScale => plPlayerController.subtitleFontScale;
  double get subtitleFontScaleFS => plPlayerController.subtitleFontScaleFS;
  int get subtitlePaddingH => plPlayerController.subtitlePaddingH;
  int get subtitlePaddingB => plPlayerController.subtitlePaddingB;
  double get subtitleBgOpacity => plPlayerController.subtitleBgOpacity;
  double get subtitleStrokeWidth => plPlayerController.subtitleStrokeWidth;
  int get subtitleFontWeight => plPlayerController.subtitleFontWeight;

  /// 字幕设置
  void showSetSubtitle() {
    showBottomSheet(
      padding: () => isFullScreen ? const .only(bottom: 70) : .zero,
      (context, setState) {
        final theme = Theme.of(context);
        final l10n = context.l10n;

        final sliderTheme = SliderThemeData(
          trackHeight: 10,
          trackShape: const MSliderTrackShape(),
          thumbColor: theme.colorScheme.primary,
          activeTrackColor: theme.colorScheme.primary,
          inactiveTrackColor: theme.colorScheme.onInverseSurface,
          thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6.0),
        );

        void updateStrokeWidth(double val) {
          plPlayerController
            ..subtitleStrokeWidth = val
            ..updateSubtitleStyle();
          setState(() {});
        }

        void updateOpacity(double val) {
          plPlayerController
            ..subtitleBgOpacity = val.toPrecision(2)
            ..updateSubtitleStyle();
          setState(() {});
        }

        void updateBottomPadding(double val) {
          plPlayerController
            ..subtitlePaddingB = val.round()
            ..updateSubtitleStyle();
          setState(() {});
        }

        void updateHorizontalPadding(double val) {
          plPlayerController
            ..subtitlePaddingH = val.round()
            ..updateSubtitleStyle();
          setState(() {});
        }

        void updateFontScaleFS(double val) {
          plPlayerController
            ..subtitleFontScaleFS = val.toPrecision(2)
            ..updateSubtitleStyle();
          setState(() {});
        }

        void updateFontScale(double val) {
          plPlayerController
            ..subtitleFontScale = val.toPrecision(2)
            ..updateSubtitleStyle();
          setState(() {});
        }

        void updateFontWeight(double val) {
          plPlayerController
            ..subtitleFontWeight = val.toInt()
            ..updateSubtitleStyle();
          setState(() {});
        }

        return Padding(
          padding: const EdgeInsets.all(12),
          child: Material(
            clipBehavior: Clip.hardEdge,
            color: theme.colorScheme.surface,
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  SizedBox(
                    height: 45,
                    child: Center(
                      child: Text(
                        l10n.playerSubtitleSettings,
                        style: titleStyle,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        l10n.playerFontSize(
                          '${(subtitleFontScale * 100).toStringAsFixed(1)}%',
                        ),
                      ),
                      resetBtn(theme, '100.0%', () => updateFontScale(1.0)),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 0,
                      bottom: 6,
                      left: 10,
                      right: 10,
                    ),
                    child: SliderTheme(
                      data: sliderTheme,
                      child: Slider(
                        min: 0.5,
                        max: 2.5,
                        value: subtitleFontScale,
                        divisions: 200,
                        label:
                            '${(subtitleFontScale * 100).toStringAsFixed(1)}%',
                        onChanged: updateFontScale,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        l10n.playerFullscreenFontSize(
                          '${(subtitleFontScaleFS * 100).toStringAsFixed(1)}%',
                        ),
                      ),
                      resetBtn(theme, '150.0%', () => updateFontScaleFS(1.5)),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 0,
                      bottom: 6,
                      left: 10,
                      right: 10,
                    ),
                    child: SliderTheme(
                      data: sliderTheme,
                      child: Slider(
                        min: 0.5,
                        max: 2.5,
                        value: subtitleFontScaleFS,
                        divisions: 200,
                        label:
                            '${(subtitleFontScaleFS * 100).toStringAsFixed(1)}%',
                        onChanged: updateFontScaleFS,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        l10n.playerFontWeightMayVary(
                          (subtitleFontWeight + 1).toString(),
                        ),
                      ),
                      resetBtn(theme, 6, () => updateFontWeight(5)),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 0,
                      bottom: 6,
                      left: 10,
                      right: 10,
                    ),
                    child: SliderTheme(
                      data: sliderTheme,
                      child: Slider(
                        min: 0,
                        max: 8,
                        value: subtitleFontWeight.toDouble(),
                        divisions: 8,
                        label: '${subtitleFontWeight + 1}',
                        onChanged: updateFontWeight,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        l10n.playerStrokeWidth(subtitleStrokeWidth.toString()),
                      ),
                      resetBtn(theme, 2.0, () => updateStrokeWidth(2.0)),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 0,
                      bottom: 6,
                      left: 10,
                      right: 10,
                    ),
                    child: SliderTheme(
                      data: sliderTheme,
                      child: Slider(
                        min: 0,
                        max: 5,
                        value: subtitleStrokeWidth,
                        divisions: 10,
                        label: '$subtitleStrokeWidth',
                        onChanged: updateStrokeWidth,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        l10n.playerHorizontalMargin(
                          subtitlePaddingH.toString(),
                        ),
                      ),
                      resetBtn(theme, 24, () => updateHorizontalPadding(24)),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 0,
                      bottom: 6,
                      left: 10,
                      right: 10,
                    ),
                    child: SliderTheme(
                      data: sliderTheme,
                      child: Slider(
                        min: 0,
                        max: 100,
                        value: subtitlePaddingH.toDouble(),
                        divisions: 100,
                        label: '$subtitlePaddingH',
                        onChanged: updateHorizontalPadding,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        l10n.playerBottomMargin(subtitlePaddingB.toString()),
                      ),
                      resetBtn(theme, 24, () => updateBottomPadding(24)),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 0,
                      bottom: 6,
                      left: 10,
                      right: 10,
                    ),
                    child: SliderTheme(
                      data: sliderTheme,
                      child: Slider(
                        min: 0,
                        max: 200,
                        value: subtitlePaddingB.toDouble(),
                        divisions: 200,
                        label: '$subtitlePaddingB',
                        onChanged: updateBottomPadding,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        l10n.playerBackgroundOpacity(
                          '${(subtitleBgOpacity * 100).toStringAsFixed(1)}%',
                        ),
                      ),
                      resetBtn(theme, '67%', () => updateOpacity(0.67)),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 0,
                      bottom: 6,
                      left: 10,
                      right: 10,
                    ),
                    child: SliderTheme(
                      data: sliderTheme,
                      child: Slider(
                        min: 0,
                        max: 1,
                        divisions: 100,
                        value: subtitleBgOpacity,
                        onChanged: updateOpacity,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    )?.whenComplete(plPlayerController.putSubtitleSettings);
  }

  void showDanmakuPool() {
    final ctr = plPlayerController.danmakuController;
    if (ctr == null) return;
    showBottomSheet((context, setState) {
      final theme = Theme.of(context);
      final l10n = context.l10n;
      return Container(
        margin: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: const BorderRadius.all(Radius.circular(12)),
        ),
        child: Column(
          children: [
            Container(
              height: 45,
              padding: const EdgeInsets.symmetric(horizontal: 14),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: theme.colorScheme.outline.withValues(alpha: 0.1),
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(l10n.playerDanmakuList),
                  iconButton(
                    onPressed: () => setState(() {}),
                    icon: const Icon(Icons.refresh),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Material(
                type: .transparency,
                clipBehavior: .hardEdge,
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(12),
                ),
                child: CustomScrollView(
                  slivers: [
                    ?_buildDanmakuList(ctr.staticDanmaku.nonNulls.toList()),
                    ?_buildDanmakuList(
                      ctr.scrollDanmaku.expand((e) => e).toList(),
                    ),
                    ?_buildDanmakuList(ctr.specialDanmaku.toList()),
                    const SliverToBoxAdapter(child: SizedBox(height: 12)),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget? _buildDanmakuList(List<DanmakuItem<DanmakuExtra>> list) {
    if (list.isEmpty) return null;

    return SliverList.builder(
      itemCount: list.length,
      itemBuilder: (context, index) {
        final item = list[index];
        final extra = item.content.extra! as VideoDanmaku;
        return ListTile(
          dense: true,
          contentPadding: const EdgeInsets.symmetric(horizontal: 14),
          onLongPress: () => Utils.copyText(item.content.text),
          title: Text(
            item.content.text,
            style: const TextStyle(fontSize: 14),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Builder(
                builder: (context) => Stack(
                  clipBehavior: Clip.none,
                  children: [
                    iconButton(
                      onPressed: () async {
                        if (await HeaderControl.likeDanmaku(
                              extra,
                              plPlayerController.cid!,
                            ) &&
                            context.mounted) {
                          (context as Element).markNeedsBuild();
                        }
                      },
                      icon: extra.isLike
                          ? const Icon(CustomIcons.player_dm_tip_like_solid)
                          : const Icon(CustomIcons.player_dm_tip_like),
                    ),
                    if (extra.like > 0)
                      Positioned(
                        left: 24.5,
                        top: 1.5,
                        child: Text(
                          extra.like.toString(),
                          style: const TextStyle(
                            fontSize: 10.5,
                            letterSpacing: 0,
                            // fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              if (item.content.selfSend)
                iconButton(
                  onPressed: () => HeaderControl.deleteDanmaku(
                    extra.id,
                    plPlayerController.cid!,
                  ).then((_) => item.expired = true),
                  icon: const Icon(CustomIcons.player_dm_tip_recall),
                )
              else
                iconButton(
                  onPressed: () => HeaderControl.reportDanmaku(
                    context,
                    extra: extra,
                    ctr: plPlayerController,
                  ),
                  icon: const Icon(CustomIcons.player_dm_tip_back),
                ),
            ],
          ),
        );
      },
    );
  }

  late final isFileSource = videoDetailCtr.isFileSource;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final isFullScreen = this.isFullScreen;
    final isFSOrPip = isFullScreen || plPlayerController.isDesktopPip;
    final showFSActionItem =
        !isFileSource && plPlayerController.showFSActionItem && isFSOrPip;
    showCurrTimeIfNeeded(isFullScreen);
    Widget title;
    if (introController.videoDetail.value.title != null &&
        (isFullScreen ||
            ((!horizontalScreen || plPlayerController.isDesktopPip) &&
                !isPortrait))) {
      title = Padding(
        key: titleKey,
        padding: isPortrait
            ? EdgeInsets.zero
            : const EdgeInsets.only(right: 10),
        child: Obx(
          () {
            final videoDetail = introController.videoDetail.value;
            final String title;
            if (isFileSource || videoDetail.videos == 1) {
              title = videoDetail.title!;
            } else {
              title =
                  videoDetail.pages
                      ?.firstWhereOrNull(
                        (e) => e.cid == videoDetailCtr.cid.value,
                      )
                      ?.part ??
                  videoDetail.title!;
            }
            return MarqueeText(
              title,
              spacing: 30,
              velocity: 30,
              strutStyle: const StrutStyle(fontSize: 16, leading: 0),
              style: const TextStyle(color: Colors.white, fontSize: 16),
              provider: effectiveProvider,
            );
          },
        ),
      );
      if (introController.isShowOnlineTotal) {
        title = Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            title,
            Obx(
              () => Text(
                l10n.playerWatchingNow(introController.total.value),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                ),
              ),
            ),
          ],
        );
      }
      title = Expanded(child: title);
    } else {
      title = const Spacer();
    }

    const btnWidth = 40.0;
    const btnHeight = 34.0;
    const btnStyle = ButtonStyle(padding: WidgetStatePropertyAll(.zero));

    return AppBar(
      elevation: 0,
      scrolledUnderElevation: 0,
      backgroundColor: Colors.transparent,
      foregroundColor: Colors.white,
      primary: false,
      automaticallyImplyLeading: false,
      toolbarHeight: showFSActionItem ? 112 : null,
      flexibleSpace: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 11),
          Row(
            children: [
              SizedBox(
                width: btnWidth,
                height: btnHeight,
                child: IconButton(
                  tooltip: l10n.commonBack,
                  style: btnStyle,
                  icon: const Icon(
                    FontAwesomeIcons.arrowLeft,
                    size: 15,
                    color: Colors.white,
                  ),
                  onPressed: () =>
                      plPlayerController.onPopInvokedWithResult(false, null),
                ),
              ),
              if (!plPlayerController.isDesktopPip &&
                  (!isFullScreen || !isPortrait))
                SizedBox(
                  width: btnWidth,
                  height: btnHeight,
                  child: IconButton(
                    tooltip: l10n.videoBackToHome,
                    style: btnStyle,
                    icon: const Icon(
                      FontAwesomeIcons.house,
                      size: 15,
                      color: Colors.white,
                    ),
                    onPressed: plPlayerController.onCloseAll,
                  ),
                ),
              title,
              // show current datetime
              ...?timeBatteryWidgets,
              if (PlatformUtils.isDesktop && !plPlayerController.isDesktopPip)
                Obx(() {
                  final isAlwaysOnTop = plPlayerController.isAlwaysOnTop.value;
                  return SizedBox(
                    width: btnWidth,
                    height: btnHeight,
                    child: IconButton(
                      style: btnStyle,
                      tooltip: isAlwaysOnTop
                          ? l10n.commonUnpin
                          : l10n.commonPin,
                      onPressed: () =>
                          plPlayerController.setAlwaysOnTop(!isAlwaysOnTop),
                      icon: isAlwaysOnTop
                          ? const Icon(
                              size: 19,
                              Icons.push_pin,
                              color: Colors.white,
                            )
                          : const Icon(
                              size: 19,
                              Icons.push_pin_outlined,
                              color: Colors.white,
                            ),
                    ),
                  );
                }),
              if (!isFileSource) ...[
                if (!isFSOrPip) ...[
                  if (videoDetailCtr.isUgc)
                    SizedBox(
                      width: btnWidth,
                      height: btnHeight,
                      child: IconButton(
                        tooltip: l10n.videoListenToAudio,
                        style: btnStyle,
                        onPressed: videoDetailCtr.toAudioPage,
                        icon: const Icon(
                          Icons.headphones_outlined,
                          size: 19,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  SizedBox(
                    width: btnWidth,
                    height: btnHeight,
                    child: IconButton(
                      tooltip: l10n.playerCast,
                      style: btnStyle,
                      onPressed: videoDetailCtr.onCast,
                      icon: const Icon(
                        Icons.cast,
                        size: 19,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
                if (plPlayerController.enableSponsorBlock)
                  SizedBox(
                    width: btnWidth,
                    height: btnHeight,
                    child: IconButton(
                      tooltip: l10n.playerSubmitSegment,
                      style: btnStyle,
                      onPressed: () => videoDetailCtr.onBlock(context),
                      icon: const Icon(
                        CustomIcons.shield_play_arrow,
                        size: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                Obx(
                  () => videoDetailCtr.segmentProgressList.isNotEmpty
                      ? SizedBox(
                          width: btnWidth,
                          height: btnHeight,
                          child: IconButton(
                            tooltip: l10n.playerSegmentInfo,
                            style: btnStyle,
                            onPressed: videoDetailCtr.showSBDetail,
                            icon: const Icon(
                              MdiIcons.advertisements,
                              size: 19,
                              color: Colors.white,
                            ),
                          ),
                        )
                      : const SizedBox.shrink(),
                ),
              ],
              if (!isPortrait || isFullScreen || PlatformUtils.isDesktop) ...[
                SizedBox(
                  width: btnWidth,
                  height: btnHeight,
                  child: IconButton(
                    tooltip: l10n.videoSendDanmaku,
                    style: btnStyle,
                    onPressed: videoDetailCtr.showShootDanmakuSheet,
                    icon: const Icon(
                      Icons.comment_outlined,
                      size: 19,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  width: btnWidth,
                  height: btnHeight,
                  child: Obx(
                    () {
                      final enableShowDanmaku =
                          plPlayerController.enableShowDanmaku.value;
                      return IconButton(
                        tooltip: enableShowDanmaku
                            ? l10n.playerTurnOffDanmaku
                            : l10n.playerTurnOnDanmaku,
                        style: btnStyle,
                        onPressed: () {
                          final newVal = !enableShowDanmaku;
                          plPlayerController.enableShowDanmaku.value = newVal;
                          if (!plPlayerController.tempPlayerConf) {
                            setting.put(
                              SettingBoxKey.enableShowDanmaku,
                              newVal,
                            );
                          }
                        },
                        icon: enableShowDanmaku
                            ? const Icon(
                                size: 20,
                                CustomIcons.dm_on,
                                color: Colors.white,
                              )
                            : const Icon(
                                size: 20,
                                CustomIcons.dm_off,
                                color: Colors.white,
                              ),
                      );
                    },
                  ),
                ),
              ],
              SizedBox(
                width: btnWidth,
                height: btnHeight,
                child: IconButton(
                  tooltip: l10n.playerDanmakuSettings,
                  style: btnStyle,
                  onPressed: showSetDanmaku,
                  icon: const Icon(
                    size: 20,
                    CustomIcons.dm_settings,
                    color: Colors.white,
                  ),
                ),
              ),
              if (Platform.isAndroid ||
                  (PlatformUtils.isDesktop && !isFullScreen))
                SizedBox(
                  width: btnWidth,
                  height: btnHeight,
                  child: IconButton(
                    tooltip: l10n.playerPictureInPicture,
                    style: btnStyle,
                    onPressed: () {
                      if (PlatformUtils.isDesktop) {
                        plPlayerController.toggleDesktopPip();
                        return;
                      }
                      if (AndroidHelper.isPipAvailable) {
                        plPlayerController.enterPip();
                      }
                    },
                    icon: const Icon(
                      Icons.picture_in_picture_outlined,
                      size: 19,
                      color: Colors.white,
                    ),
                  ),
                ),
              SizedBox(
                width: btnWidth,
                height: btnHeight,
                child: IconButton(
                  tooltip: l10n.playerMoreSettings,
                  style: btnStyle,
                  onPressed: showSettingSheet,
                  icon: const Icon(
                    Icons.more_vert_outlined,
                    size: 19,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          if (showFSActionItem)
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: btnWidth,
                  height: btnHeight,
                  child: Obx(
                    () => ActionItem(
                      expand: false,
                      icon: const Icon(
                        FontAwesomeIcons.thumbsUp,
                        color: Colors.white,
                      ),
                      selectIcon: const Icon(FontAwesomeIcons.solidThumbsUp),
                      selectStatus: introController.hasLike.value,
                      semanticsLabel: l10n.commonLike,
                      animation: introController.tripleAnimation,
                      onStartTriple: () {
                        plPlayerController.tripling = true;
                        introController.onStartTriple();
                      },
                      onCancelTriple: ([bool isTapUp = false]) {
                        plPlayerController
                          ..tripling = false
                          ..hideTaskControls();
                        introController.onCancelTriple(isTapUp);
                      },
                    ),
                  ),
                ),
                if (introController case final UgcIntroController ugc)
                  SizedBox(
                    width: btnWidth,
                    height: btnHeight,
                    child: Obx(
                      () => ActionItem(
                        expand: false,
                        icon: const Icon(
                          FontAwesomeIcons.thumbsDown,
                          color: Colors.white,
                        ),
                        selectIcon: const Icon(
                          FontAwesomeIcons.solidThumbsDown,
                        ),
                        onTap: () => ugc.handleAction(ugc.actionDislikeVideo),
                        selectStatus: ugc.hasDislike.value,
                        semanticsLabel: l10n.commonDislike,
                      ),
                    ),
                  ),
                SizedBox(
                  width: btnWidth,
                  height: btnHeight,
                  child: Obx(
                    () => ActionItem(
                      expand: false,
                      animation: introController.tripleAnimation,
                      icon: const Icon(
                        FontAwesomeIcons.b,
                        color: Colors.white,
                      ),
                      selectIcon: const Icon(FontAwesomeIcons.b),
                      onTap: introController.actionCoinVideo,
                      selectStatus: introController.hasCoin,
                      semanticsLabel: l10n.videoCoin,
                    ),
                  ),
                ),
                SizedBox(
                  width: btnWidth,
                  height: btnHeight,
                  child: Obx(
                    () => ActionItem(
                      expand: false,
                      animation: introController.tripleAnimation,
                      icon: const Icon(
                        FontAwesomeIcons.star,
                        color: Colors.white,
                      ),
                      selectIcon: const Icon(FontAwesomeIcons.solidStar),
                      onTap: () => introController.showFavBottomSheet(context),
                      onLongPress: () => introController.showFavBottomSheet(
                        context,
                        isLongPress: true,
                      ),
                      selectStatus: introController.hasFav.value,
                      semanticsLabel: l10n.commonAddToFavorites,
                    ),
                  ),
                ),
                SizedBox(
                  width: btnWidth,
                  height: btnHeight,
                  child: ActionItem(
                    expand: false,
                    icon: const Icon(
                      FontAwesomeIcons.shareFromSquare,
                      color: Colors.white,
                    ),
                    onTap: () => introController.actionShareVideo(context),
                    semanticsLabel: l10n.commonShare,
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
