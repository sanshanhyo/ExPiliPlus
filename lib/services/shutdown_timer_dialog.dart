import 'package:ex_piliplus/l10n/generated/app_localizations.dart';
import 'package:ex_piliplus/services/shutdown_timer_coordinator.dart';
import 'package:ex_piliplus/services/shutdown_timer_controls.dart';
import 'package:ex_piliplus/services/shutdown_timer_snapshot.dart';
import 'package:ex_piliplus/utils/duration_utils.dart';
import 'package:ex_piliplus/utils/extension/l10n_ext.dart';
import 'package:ex_piliplus/utils/page_utils.dart';
import 'package:ex_piliplus/utils/theme_utils.dart';
import 'package:ex_piliplus/pages/video/introduction/ugc/widgets/menu_row.dart';
import 'package:collection/collection.dart';
import 'package:cupertino_ui/cupertino_ui.dart' show CupertinoPicker;
import 'package:flutter/foundation.dart' show ValueListenable, VoidCallback;
import 'package:material_ui/material_ui.dart';

const _kSqueeze = 1.25;
const _kItemExtent = 38.0;

abstract final class ShutdownTimerDialog {
  static (int hour, int minute) _parseMinutes(int minutes) =>
      (minutes ~/ 60, minutes % 60);

  static String _format(AppLocalizations l10n, int minutes) {
    final (int hour, int minute) = _parseMinutes(minutes);
    if (hour > 0 && minute > 0) {
      return l10n.shutdownHoursMinutes(hour, minute);
    } else if (hour > 0) {
      return l10n.shutdownHours(hour);
    } else {
      return l10n.shutdownMinutes(minute);
    }
  }

  static Widget _pickerBuider(
    int count, {
    required ValueChanged<int> onSelectedItemChanged,
    required FixedExtentScrollController scrollController,
  }) {
    return CupertinoPicker(
      // looping: true,
      squeeze: _kSqueeze,
      itemExtent: _kItemExtent,
      scrollController: scrollController,
      onSelectedItemChanged: onSelectedItemChanged,
      children: List.generate(
        count,
        (index) => Center(
          child: Text(
            index.toString().padLeft(2, '0'),
            style: const TextStyle(fontSize: 20, letterSpacing: .4),
          ),
        ),
      ),
    );
  }

  static void _showTimePickerDialog(
    BuildContext context,
    ShutdownTimerControls controller,
    VoidCallback onCountdown,
    StateSetter setState,
  ) {
    final values = _parseMinutes(controller.durationInMinutes);
    var hour = values.$1;
    var minute = values.$2;

    final hourController = FixedExtentScrollController(initialItem: hour);
    final minuteController = FixedExtentScrollController(initialItem: minute);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        contentPadding: const .fromLTRB(20, 6, 20, 0),
        actionsPadding: const .fromLTRB(20, 0, 20, 16),
        constraints: const .tightFor(width: 320, height: 320),
        content: Row(
          children: [
            Expanded(
              child: _pickerBuider(
                25,
                scrollController: hourController,
                onSelectedItemChanged: (value) => hour = value,
              ),
            ),
            const Text('时'),
            const SizedBox(width: 10),
            Expanded(
              child: _pickerBuider(
                60,
                scrollController: minuteController,
                onSelectedItemChanged: (value) => minute = value,
              ),
            ),
            const Text('分'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              '取消',
              style: TextStyle(color: ColorScheme.of(context).outline),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              controller.schedule(hour * 60 + minute);
              onCountdown();
              setState(() {});
            },
            child: const Text('确认'),
          ),
        ],
      ),
    ).whenComplete(() {
      hourController.dispose();
      minuteController.dispose();
    });
  }

  static void show(
    ShutdownTimerControls controller,
    BuildContext context, {
    required bool isFullScreen,
    bool isLive = false,
  }) {
    const Set<int> scheduleTimeMinutes = {0, 15, 30, 45, 60};
    const TextStyle titleStyle = TextStyle(fontSize: 14);
    if (isLive) {
      controller.setWaitUntilCompleted(false);
    }

    final child = ShutdownPanel(
      countdown: controller.countdown,
      onRefreshCountdown: controller.refreshCountdown,
      builder: (context, countdown, onCountdown, setState) {
        final theme = Theme.of(context);
        return Padding(
          padding: const .all(12),
          child: Material(
            clipBehavior: .hardEdge,
            color: theme.colorScheme.surface,
            borderRadius: const .all(.circular(12)),
            child: ListView(
              padding: const .symmetric(vertical: 14),
              children: [
                Stack(
                  alignment: .center,
                  clipBehavior: .none,
                  children: [
                    const Text('定时关闭', style: titleStyle),
                    Positioned(top: 0, bottom: 0, right: 16, child: countdown),
                  ],
                ),
                const SizedBox(height: 10),
                ...{...scheduleTimeMinutes, controller.durationInMinutes}
                    .sorted(Comparable.compare)
                    .map(
                      (minutes) => ListTile(
                        dense: true,
                        onTap: () {
                          Navigator.pop(context);
                          controller.schedule(minutes);
                        },
                        title: Text(
                          switch (minutes) {
                            0 => context.l10n.commonDisabled,
                            _ => _format(context.l10n, minutes),
                          },
                          style: titleStyle,
                        ),
                        trailing: controller.durationInMinutes == minutes
                            ? Icon(
                                size: 20,
                                Icons.done,
                                color: theme.colorScheme.primary,
                              )
                            : null,
                      ),
                    ),
                ListTile(
                  dense: true,
                  onTap: () => _showTimePickerDialog(
                    context,
                    controller,
                    onCountdown,
                    setState,
                  ),
                  title: const Text('自定义', style: titleStyle),
                ),
                if (!isLive) ...[
                  Builder(
                    builder: (context) {
                      void onChanged([_]) {
                        controller.setWaitUntilCompleted(
                          !controller.waitUntilCompleted,
                        );
                        (context as Element).markNeedsBuild();
                      }

                      return ListTile(
                        dense: true,
                        onTap: onChanged,
                        title: Text(
                          context.l10n.shutdownWaitUntilVideoEnds,
                          style: titleStyle,
                        ),
                        trailing: Transform.scale(
                          alignment: Alignment.centerRight,
                          scale: 0.8,
                          child: Switch(
                            value: controller.waitUntilCompleted,
                            onChanged: onChanged,
                          ),
                        ),
                      );
                    },
                  ),
                ],
                const SizedBox(height: 5),
                Padding(
                  padding: const .only(left: 18),
                  child: Builder(
                    builder: (context) {
                      return Row(
                        spacing: 12,
                        children: [
                          Text(
                            context.l10n.shutdownActionAtEnd,
                            style: titleStyle,
                          ),
                          ...ShutdownTimerAction.values.map(
                            (e) => ActionRowLineItem(
                              onTap: () {
                                controller.setShutdownAction(e);
                                (context as Element).markNeedsBuild();
                              },
                              text:
                                  ' ${switch (e) {
                                    ShutdownTimerAction.pause => context
                                        .l10n
                                        .shutdownPauseVideo,
                                    ShutdownTimerAction.exit => context
                                        .l10n
                                        .shutdownExitApp,
                                  }} ',
                              selectStatus: controller.shutdownAction == e,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
    PageUtils.showVideoBottomSheet(
      context,
      maxWidth: 512,
      child: isLive ? Theme(data: ThemeUtils.darkTheme, child: child) : child,
    );
  }
}

typedef ShutdownStatefulWidgetBuilder = Widget Function(
  BuildContext context,
  Widget countdown,
  VoidCallback onCountdown,
  StateSetter setState,
);

class ShutdownPanel extends StatefulWidget {
  const ShutdownPanel({
    super.key,
    required this.builder,
    this.countdown,
    this.onRefreshCountdown,
    this.buildCountdownText = _kBuildCountdownText,
  });

  final ShutdownStatefulWidgetBuilder builder;
  final ValueListenable<ShutdownTimerSnapshot>? countdown;
  final VoidCallback? onRefreshCountdown;
  final Widget Function(String? text) buildCountdownText;

  static Widget _kBuildCountdownText(String? text) {
    if (text == null) {
      return const SizedBox.shrink();
    }
    return Text(text);
  }

  @override
  State<ShutdownPanel> createState() => _ShutdownPanelState();
}

class _ShutdownPanelState extends State<ShutdownPanel> {
  @override
  Widget build(BuildContext context) {
    final countdown = ValueListenableBuilder<ShutdownTimerSnapshot>(
      valueListenable: widget.countdown ?? shutdownTimerService.countdown,
      builder: (context, snapshot, _) {
        if (snapshot.isWaiting) {
          return widget.buildCountdownText('当前播放结束后关闭');
        }
        final text = snapshot.isScheduled
            ? DurationUtils.formatDuration(snapshot.remaining.inSeconds)
            : null;
        return widget.buildCountdownText(text);
      },
    );
    return widget.builder(context, countdown, _refreshCountdown, setState);
  }

  void _refreshCountdown() =>
      (widget.onRefreshCountdown ?? shutdownTimerService.refreshCountdown)();
}

extension ShutdownTimerDialogExtension on ShutdownTimerControls {
  void showScheduleExitDialog(
    BuildContext context, {
    required bool isFullScreen,
    bool isLive = false,
  }) => ShutdownTimerDialog.show(
    this,
    context,
    isFullScreen: isFullScreen,
    isLive: isLive,
  );
}
