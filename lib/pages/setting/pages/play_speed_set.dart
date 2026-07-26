import 'dart:math';

import 'package:ex_piliplus/common/widgets/flutter/list_tile.dart';
import 'package:ex_piliplus/common/widgets/view_safe_area.dart';
import 'package:ex_piliplus/pages/setting/widgets/switch_item.dart';
import 'package:ex_piliplus/utils/extension/context_ext.dart';
import 'package:ex_piliplus/utils/extension/l10n_ext.dart';
import 'package:ex_piliplus/utils/filtering_text.dart';
import 'package:ex_piliplus/utils/storage.dart';
import 'package:ex_piliplus/utils/storage_key.dart';
import 'package:ex_piliplus/utils/storage_pref.dart';
import 'package:flutter/material.dart' hide ListTile;
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:hive_ce/hive.dart';

class PlaySpeedPage extends StatefulWidget {
  const PlaySpeedPage({super.key});

  @override
  State<PlaySpeedPage> createState() => _PlaySpeedPageState();
}

class _PlaySpeedPageState extends State<PlaySpeedPage> {
  late double playSpeedDefault = Pref.playSpeedDefault;
  late double longPressSpeedDefault = Pref.longPressSpeedDefault;
  late List<double> speedList = Pref.speedList;
  late bool enableAutoLongPressSpeed = Pref.enableAutoLongPressSpeed;
  List<({int id, String title, Icon icon})> get sheetMenu => [
    (
      id: 1,
      title: context.l10n.settingsPlaybackSpeedSetDefault,
      icon: const Icon(
        Icons.speed,
        size: 21,
      ),
    ),
    (
      id: 2,
      title: context.l10n.settingsPlaybackSpeedSetLongPress,
      icon: const Icon(
        Icons.speed_sharp,
        size: 21,
      ),
    ),
    (
      id: -1,
      title: context.l10n.settingsPlaybackSpeedDelete,
      icon: const Icon(
        Icons.delete_outline,
        size: 21,
      ),
    ),
  ];

  Box video = GStorage.video;

  // 添加自定义倍速
  void onAddSpeed() {
    String initialValue = '';
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(context.l10n.settingsPlaybackSpeedAdd),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 12),
            TextFormField(
              autofocus: true,
              initialValue: initialValue,
              keyboardType: const .numberWithOptions(decimal: true),
              decoration: InputDecoration(
                labelText: context.l10n.settingsPlaybackSpeedCustom,
                border: const OutlineInputBorder(
                  borderRadius: .all(.circular(6)),
                ),
              ),
              onChanged: (value) => initialValue = value,
              inputFormatters: FilteringText.decimal,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: Get.back,
            child: Text(
              context.l10n.commonCancel,
              style: TextStyle(color: Theme.of(context).colorScheme.outline),
            ),
          ),
          TextButton(
            onPressed: () {
              try {
                final val = double.parse(initialValue);
                if (speedList.contains(val)) {
                  SmartDialog.showToast(
                    context.l10n.settingsPlaybackSpeedExists,
                  );
                } else {
                  Get.back();
                  speedList
                    ..add(val)
                    ..sort();
                  video.put(VideoBoxKey.speedsList, speedList);
                  setState(() {});
                }
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

  // 设定倍速弹窗
  void showBottomSheet(ThemeData theme, int index) {
    showModalBottomSheet(
      context: context,
      useSafeArea: true,
      isScrollControlled: true,
      clipBehavior: Clip.hardEdge,
      constraints: BoxConstraints(
        maxWidth: min(640, context.mediaQueryShortestSide),
      ),
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 10),
            ...sheetMenu.map(
              (item) => ListTile(
                enabled: enableAutoLongPressSpeed && item.id == 2
                    ? false
                    : true,
                onTap: () {
                  Get.back();
                  menuAction(index, item.id);
                },
                minLeadingWidth: 0,
                iconColor: theme.colorScheme.onSurface,
                leading: item.icon,
                title: Text(
                  item.title,
                  style: const TextStyle(fontSize: 14),
                ),
              ),
            ),
            SizedBox(height: 25 + MediaQuery.viewPaddingOf(context).bottom),
          ],
        );
      },
    );
  }

  //
  void menuAction(int index, int id) {
    double speed = speedList[index];
    // 设置
    if (id == 1) {
      // 设置默认倍速
      playSpeedDefault = speed;
      video.put(VideoBoxKey.playSpeedDefault, playSpeedDefault);
    } else if (id == 2) {
      // 设置默认长按倍速
      longPressSpeedDefault = speed;
      video.put(VideoBoxKey.longPressSpeedDefault, longPressSpeedDefault);
    } else if (id == -1) {
      if ([
        1.0,
        playSpeedDefault,
        longPressSpeedDefault,
      ].contains(speed)) {
        SmartDialog.showToast(
          context.l10n.settingsPlaybackSpeedDefaultCannotDelete,
        );
        return;
      }
      speedList.removeAt(index);
      video.put(VideoBoxKey.speedsList, speedList);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(context.l10n.settingsPlaybackSpeed),
        actions: [
          TextButton(
            onPressed: () async {
              await video.delete(VideoBoxKey.speedsList);
              speedList = Pref.speedList;
              setState(() {});
            },
            child: Text(context.l10n.settingsReset),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: ViewSafeArea(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 14,
                right: 14,
                top: 6,
                bottom: 0,
              ),
              child: Text(
                context.l10n.settingsPlaybackSpeedHint,
                style: TextStyle(color: theme.colorScheme.outline),
              ),
            ),
            ListTile(
              title: Text(context.l10n.settingsPlaybackSpeedDefault),
              subtitle: Text(playSpeedDefault.toString()),
            ),
            SetSwitchItem(
              title: context.l10n.settingsPlaybackSpeedDynamicLongPress,
              subtitle:
                  context.l10n.settingsPlaybackSpeedDynamicLongPressDescription,
              setKey: SettingBoxKey.enableAutoLongPressSpeed,
              defaultVal: enableAutoLongPressSpeed,
              onChanged: (val) =>
                  setState(() => enableAutoLongPressSpeed = val),
            ),
            if (!enableAutoLongPressSpeed)
              ListTile(
                title: Text(
                  context.l10n.settingsPlaybackSpeedDefaultLongPress,
                ),
                subtitle: Text(longPressSpeedDefault.toString()),
              ),
            Padding(
              padding: const EdgeInsets.only(
                left: 14,
                right: 14,
                bottom: 10,
                top: 20,
              ),
              child: Row(
                children: [
                  Text(
                    context.l10n.settingsPlaybackSpeedList,
                    style: theme.textTheme.titleMedium,
                  ),
                  const SizedBox(width: 12),
                  TextButton(
                    onPressed: onAddSpeed,
                    child: Text(context.l10n.settingsAdd),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 18,
                right: 18,
                bottom: 30,
              ),
              child: Wrap(
                alignment: WrapAlignment.start,
                spacing: 8,
                runSpacing: 2,
                children: List.generate(
                  speedList.length,
                  (index) => FilledButton.tonal(
                    style: FilledButton.styleFrom(tapTargetSize: .padded),
                    onPressed: () => showBottomSheet(theme, index),
                    child: Text(speedList[index].toString()),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
