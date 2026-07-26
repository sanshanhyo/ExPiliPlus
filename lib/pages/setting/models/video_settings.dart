import 'dart:io';

import 'package:ex_piliplus/models/common/video/audio_quality.dart';
import 'package:ex_piliplus/models/common/video/cdn_type.dart';
import 'package:ex_piliplus/models/common/video/live_quality.dart';
import 'package:ex_piliplus/models/common/video/video_decode_type.dart';
import 'package:ex_piliplus/models/common/video/video_quality.dart';
import 'package:ex_piliplus/pages/setting/models/model.dart';
import 'package:ex_piliplus/pages/setting/widgets/ordered_multi_select_dialog.dart';
import 'package:ex_piliplus/pages/setting/widgets/select_dialog.dart';
import 'package:ex_piliplus/plugin/pl_player/models/audio_output_type.dart';
import 'package:ex_piliplus/plugin/pl_player/models/hwdec_type.dart';
import 'package:ex_piliplus/utils/filtering_text.dart';
import 'package:ex_piliplus/utils/extension/l10n_ext.dart';
import 'package:ex_piliplus/utils/storage.dart';
import 'package:ex_piliplus/utils/storage_key.dart';
import 'package:ex_piliplus/utils/storage_pref.dart';
import 'package:ex_piliplus/utils/video_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show FilteringTextInputFormatter;
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

List<SettingsModel> videoSettings(BuildContext context) {
  final l10n = context.l10n;
  return [
    SwitchModel(
      title: l10n.settingsHardwareDecoding,
      subtitle: l10n.settingsHardwareDecodingDescription,
      leading: const Icon(Icons.flash_on_outlined),
      setKey: SettingBoxKey.enableHA,
      defaultVal: true,
    ),
    SwitchModel(
      title: l10n.settingsGuest1080p,
      subtitle: l10n.settingsGuest1080pDescription,
      leading: const Icon(Icons.hd_outlined),
      setKey: SettingBoxKey.p1080,
      defaultVal: true,
    ),
    NormalModel(
      title: l10n.settingsBilibiliDataPlan,
      subtitle: l10n.settingsBilibiliDataPlanDescription,
      leading: const Icon(Icons.perm_data_setting_outlined),
      getTrailing: (theme) => IgnorePointer(
        child: Transform.scale(
          scale: 0.8,
          alignment: Alignment.centerRight,
          child: Switch(
            value: true,
            onChanged: (_) {},
            thumbIcon: WidgetStateProperty.all(
              const Icon(Icons.lock_outline_rounded),
            ),
          ),
        ),
      ),
    ),
    NormalModel(
      title: l10n.settingsCdn,
      leading: const Icon(MdiIcons.cloudPlusOutline),
      getSubtitle: () => l10n.settingsCurrentCdn(
        VideoUtils.cdnService.localizedLabel(l10n),
      ),
      onTap: _showCDNDialog,
    ),
    NormalModel(
      title: l10n.settingsLiveCdn,
      leading: const Icon(MdiIcons.cloudPlusOutline),
      getSubtitle: () => l10n.settingsCurrentSource(
        Pref.liveCdnUrl ?? l10n.commonDefault,
      ),
      onTap: _showLiveCDNDialog,
    ),
    SwitchModel(
      title: l10n.settingsCdnSpeedTest,
      leading: const Icon(Icons.speed),
      subtitle: l10n.settingsCdnSpeedTestDescription,
      setKey: SettingBoxKey.cdnSpeedTest,
      defaultVal: true,
    ),
    SwitchModel(
      title: l10n.settingsSeparateAudioCdn,
      subtitle: l10n.settingsSeparateAudioCdnDescription,
      leading: const Icon(MdiIcons.musicNotePlus),
      setKey: SettingBoxKey.disableAudioCDN,
      defaultVal: false,
      onChanged: (value) => VideoUtils.disableAudioCDN = value,
    ),
    NormalModel(
      title: l10n.settingsDefaultVideoQuality,
      leading: const Icon(Icons.video_settings_outlined),
      getSubtitle: () => l10n.settingsCurrentVideoQuality(
        VideoQuality.fromCode(Pref.defaultVideoQa).localizedLabel(l10n),
      ),
      onTap: _showVideoQaDialog,
    ),
    NormalModel(
      title: l10n.settingsCellularVideoQuality,
      leading: const Icon(Icons.video_settings_outlined),
      getSubtitle: () => l10n.settingsCurrentVideoQuality(
        VideoQuality.fromCode(
          Pref.defaultVideoQaCellular,
        ).localizedLabel(l10n),
      ),
      onTap: _showVideoCellularQaDialog,
    ),
    NormalModel(
      title: l10n.settingsDefaultAudioQuality,
      leading: const Icon(Icons.music_video_outlined),
      getSubtitle: () => l10n.settingsCurrentAudioQuality(
        AudioQuality.fromCode(Pref.defaultAudioQa).localizedLabel(l10n),
      ),
      onTap: _showAudioQaDialog,
    ),
    NormalModel(
      title: l10n.settingsCellularAudioQuality,
      leading: const Icon(Icons.music_video_outlined),
      getSubtitle: () => l10n.settingsCurrentAudioQuality(
        AudioQuality.fromCode(
          Pref.defaultAudioQaCellular,
        ).localizedLabel(l10n),
      ),
      onTap: _showAudioCellularQaDialog,
    ),
    NormalModel(
      title: l10n.settingsDefaultLiveQuality,
      leading: const Icon(Icons.video_settings_outlined),
      getSubtitle: () => l10n.settingsCurrentVideoQuality(
        LiveQuality.fromCode(Pref.liveQuality)?.localizedLabel(l10n) ??
            l10n.commonDefault,
      ),
      onTap: _showLiveQaDialog,
    ),
    NormalModel(
      title: l10n.settingsCellularLiveQuality,
      leading: const Icon(Icons.video_settings_outlined),
      getSubtitle: () => l10n.settingsCurrentVideoQuality(
        LiveQuality.fromCode(
              Pref.liveQualityCellular,
            )?.localizedLabel(l10n) ??
            l10n.commonDefault,
      ),
      onTap: _showLiveCellularQaDialog,
    ),
    NormalModel(
      title: l10n.settingsPreferredCodecs,
      leading: const Icon(Icons.movie_creation_outlined),
      getSubtitle: () => l10n.settingsPreferredCodecsDescription(
        Pref.preferCodecs.map((i) => i.name).join(', '),
      ),
      onTap: _showCodecsDialog,
    ),
    if (kDebugMode || Platform.isAndroid)
      NormalModel(
        title: l10n.settingsAudioOutput,
        leading: const Icon(Icons.speaker_outlined),
        getSubtitle: () => l10n.settingsCurrentValue(Pref.audioOutput),
        onTap: _showAudioOutputDialog,
      ),
    NormalModel(
      title: l10n.settingsBufferSize,
      leading: const Icon(Icons.storage_outlined),
      getSubtitle: () => l10n.settingsBufferSizeDescription(Pref.bufferSize),
      onTap: _showBufferSizeDialog,
    ),
    NormalModel(
      title: l10n.settingsBufferDuration,
      leading: const Icon(Icons.av_timer),
      getSubtitle: () => l10n.settingsBufferDurationDescription(Pref.bufferSec),
      onTap: _showBufferSecDialog,
    ),
    NormalModel(
      title: l10n.settingsAutoSync,
      leading: const Icon(Icons.sync_rounded),
      getSubtitle: () => l10n.settingsAutoSyncDescription(
        Pref.autosync.toString(),
      ),
      onTap: _showAutoSyncDialog,
    ),
    NormalModel(
      title: l10n.settingsVideoSync,
      leading: const Icon(Icons.view_timeline_outlined),
      getSubtitle: () => l10n.settingsVideoSyncDescription(Pref.videoSync),
      onTap: _showVideoSyncDialog,
    ),
    NormalModel(
      title: l10n.settingsHardwareDecodingMode,
      leading: const Icon(Icons.memory_outlined),
      getSubtitle: () => l10n.settingsHardwareDecodingModeDescription(
        Pref.hardwareDecoding,
      ),
      onTap: _showHwDecDialog,
    ),
  ];
}

Future<void> _showCDNDialog(BuildContext context, VoidCallback setState) async {
  final res = await showDialog<CDNService>(
    context: context,
    builder: (context) => const CdnSelectDialog(),
  );
  if (res != null) {
    VideoUtils.cdnService = res;
    await GStorage.setting.put(SettingBoxKey.CDNService, res.name);
    setState();
  }
}

Future<void> _showLiveCDNDialog(
  BuildContext context,
  VoidCallback setState,
) async {
  String host = Pref.liveCdnUrl ?? '';
  String? res = await showDialog<String>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(context.l10n.settingsEnterCdnHost),
      content: TextFormField(
        initialValue: host,
        autofocus: true,
        onChanged: (value) => host = value,
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
          onPressed: () => Get.back(result: host),
          child: Text(context.l10n.commonConfirm),
        ),
      ],
    ),
  );
  if (res != null) {
    if (res.isEmpty) {
      res = null;
      await GStorage.setting.delete(SettingBoxKey.liveCdnUrl);
    } else {
      if (!res.startsWith('http')) {
        res = 'https://$res';
      }
      await GStorage.setting.put(SettingBoxKey.liveCdnUrl, res);
    }
    VideoUtils.liveCdnUrl = res;
    setState();
  }
}

Future<void> _showVideoQaDialog(
  BuildContext context,
  VoidCallback setState,
) async {
  final res = await showDialog<int>(
    context: context,
    builder: (context) => SelectDialog<int>(
      title: context.l10n.settingsDefaultVideoQuality,
      value: Pref.defaultVideoQa,
      values: VideoQuality.values
          .map((e) => (e.code, e.localizedLabel(context.l10n)))
          .toList(),
    ),
  );
  if (res != null) {
    await GStorage.setting.put(SettingBoxKey.defaultVideoQa, res);
    setState();
  }
}

Future<void> _showVideoCellularQaDialog(
  BuildContext context,
  VoidCallback setState,
) async {
  final res = await showDialog<int>(
    context: context,
    builder: (context) => SelectDialog<int>(
      title: context.l10n.settingsCellularVideoQuality,
      value: Pref.defaultVideoQaCellular,
      values: VideoQuality.values
          .map((e) => (e.code, e.localizedLabel(context.l10n)))
          .toList(),
    ),
  );
  if (res != null) {
    await GStorage.setting.put(
      SettingBoxKey.defaultVideoQaCellular,
      res,
    );
    setState();
  }
}

Future<void> _showAudioQaDialog(
  BuildContext context,
  VoidCallback setState,
) async {
  final res = await showDialog<int>(
    context: context,
    builder: (context) => SelectDialog<int>(
      title: context.l10n.settingsDefaultAudioQuality,
      value: Pref.defaultAudioQa,
      values: AudioQuality.values
          .map((e) => (e.code, e.localizedLabel(context.l10n)))
          .toList(),
    ),
  );
  if (res != null) {
    await GStorage.setting.put(SettingBoxKey.defaultAudioQa, res);
    setState();
  }
}

Future<void> _showAudioCellularQaDialog(
  BuildContext context,
  VoidCallback setState,
) async {
  final res = await showDialog<int>(
    context: context,
    builder: (context) => SelectDialog<int>(
      title: context.l10n.settingsCellularAudioQuality,
      value: Pref.defaultAudioQaCellular,
      values: AudioQuality.values
          .map((e) => (e.code, e.localizedLabel(context.l10n)))
          .toList(),
    ),
  );
  if (res != null) {
    await GStorage.setting.put(
      SettingBoxKey.defaultAudioQaCellular,
      res,
    );
    setState();
  }
}

Future<void> _showLiveQaDialog(
  BuildContext context,
  VoidCallback setState,
) async {
  final res = await showDialog<int>(
    context: context,
    builder: (context) => SelectDialog<int>(
      title: context.l10n.settingsDefaultLiveQuality,
      value: Pref.liveQuality,
      values: LiveQuality.values
          .map((e) => (e.code, e.localizedLabel(context.l10n)))
          .toList(),
    ),
  );
  if (res != null) {
    await GStorage.setting.put(SettingBoxKey.liveQuality, res);
    setState();
  }
}

Future<void> _showLiveCellularQaDialog(
  BuildContext context,
  VoidCallback setState,
) async {
  final res = await showDialog<int>(
    context: context,
    builder: (context) => SelectDialog<int>(
      title: context.l10n.settingsCellularLiveQuality,
      value: Pref.liveQualityCellular,
      values: LiveQuality.values
          .map((e) => (e.code, e.localizedLabel(context.l10n)))
          .toList(),
    ),
  );
  if (res != null) {
    await GStorage.setting.put(SettingBoxKey.liveQualityCellular, res);
    setState();
  }
}

Future<void> _showCodecsDialog(
  BuildContext context,
  VoidCallback setState,
) async {
  final res = await showDialog<List<VideoDecodeFormatType>>(
    context: context,
    builder: (context) => OrderedMultiSelectDialog<VideoDecodeFormatType>(
      title: context.l10n.settingsPreferredCodecs,
      initValues: Pref.preferCodecs,
      values: {for (final e in VideoDecodeFormatType.values) e: e.name},
    ),
  );
  if (res != null && res.isNotEmpty) {
    await GStorage.setting.put(
      SettingBoxKey.preferCodecs,
      res.map((i) => i.name).toList(),
    );
    setState();
  }
}

Future<void> _showAudioOutputDialog(
  BuildContext context,
  VoidCallback setState,
) async {
  final res = await showDialog<List<String>>(
    context: context,
    builder: (context) => OrderedMultiSelectDialog<String>(
      title: context.l10n.settingsAudioOutput,
      initValues: Pref.audioOutput.split(','),
      values: {
        for (final e in AudioOutput.values) e.name: e.label,
      },
    ),
  );
  if (res != null && res.isNotEmpty) {
    await GStorage.setting.put(
      SettingBoxKey.audioOutput,
      res.join(','),
    );
    setState();
  }
}

Future<void> _showVideoSyncDialog(
  BuildContext context,
  VoidCallback setState,
) async {
  final res = await showDialog<String>(
    context: context,
    builder: (context) => SelectDialog<String>(
      title: context.l10n.settingsVideoSync,
      value: Pref.videoSync,
      values: const [
        'audio',
        'display-resample',
        'display-resample-vdrop',
        'display-resample-desync',
        'display-tempo',
        'display-vdrop',
        'display-adrop',
        'display-desync',
        'desync',
      ].map((e) => (e, e)).toList(),
    ),
  );
  if (res != null) {
    await GStorage.setting.put(SettingBoxKey.videoSync, res);
    setState();
  }
}

Future<void> _showHwDecDialog(
  BuildContext context,
  VoidCallback setState,
) async {
  final res = await showDialog<List<String>>(
    context: context,
    builder: (context) => OrderedMultiSelectDialog<String>(
      title: context.l10n.settingsHardwareDecodingMode,
      initValues: Pref.hardwareDecoding.split(','),
      values: {
        for (final e in HwDecType.values)
          e.hwdec: '${e.hwdec}\n${e.localizedDescription(context.l10n)}',
      },
    ),
  );
  if (res != null && res.isNotEmpty) {
    await GStorage.setting.put(
      SettingBoxKey.hardwareDecoding,
      res.join(','),
    );
    setState();
  }
}

void _showAutoSyncDialog(BuildContext context, VoidCallback setState) {
  String autosync = Pref.autosync.toString();
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(context.l10n.settingsAutoSync),
      content: TextFormField(
        autofocus: true,
        initialValue: autosync,
        keyboardType: TextInputType.number,
        onChanged: (value) => autosync = value,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
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
              // validate
              int.parse(autosync);
              Get.back();
              await GStorage.setting.put(SettingBoxKey.autosync, autosync);
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

void _showDecimalDialog(
  BuildContext context,
  VoidCallback setState, {
  required String key,
  required double defVal,
  required String title,
  required String? suffix,
}) {
  String value = (GStorage.setting.get(key) ?? defVal).toString();
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: TextFormField(
        autofocus: true,
        initialValue: value,
        keyboardType: const .numberWithOptions(decimal: true),
        onChanged: (val) => value = val,
        inputFormatters: FilteringText.decimal,
        decoration: suffix == null ? null : InputDecoration(suffixText: suffix),
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
              final val = double.parse(value);
              Get.back();
              await GStorage.setting.put(key, val);
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

void _showBufferSizeDialog(BuildContext context, VoidCallback setState) =>
    _showDecimalDialog(
      context,
      setState,
      key: SettingBoxKey.bufferSize,
      defVal: Pref.bufferSize,
      title: context.l10n.settingsBufferSize,
      suffix: 'MB',
    );

void _showBufferSecDialog(BuildContext context, VoidCallback setState) =>
    _showDecimalDialog(
      context,
      setState,
      key: SettingBoxKey.bufferSec,
      defVal: Pref.bufferSec,
      title: context.l10n.settingsBufferDuration,
      suffix: 's',
    );
