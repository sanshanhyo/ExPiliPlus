// 定时关闭服务
import 'dart:async';
import 'dart:io';

import 'package:ex_piliplus/l10n/generated/app_localizations.dart';
import 'package:ex_piliplus/pages/video/introduction/ugc/widgets/menu_row.dart';
import 'package:ex_piliplus/plugin/pl_player/controller.dart';
import 'package:ex_piliplus/plugin/pl_player/models/play_status.dart';
import 'package:ex_piliplus/utils/extension/l10n_ext.dart';
import 'package:ex_piliplus/utils/page_utils.dart';
import 'package:ex_piliplus/utils/theme_utils.dart';
import 'package:ex_piliplus/models/common/enum_with_label.dart';
import 'package:ex_piliplus/utils/duration_utils.dart';
import 'package:ex_piliplus/utils/device_utils.dart';
import 'package:ex_piliplus/services/shutdown_timer_snapshot.dart';

import 'package:collection/collection.dart';
import 'package:cupertino_ui/cupertino_ui.dart' show CupertinoPicker;
import 'package:flutter/foundation.dart' show ValueListenable;
import 'package:material_ui/material_ui.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';

const _kSqueeze = 1.25;
const _kItemExtent = 38.0;

enum _ShutdownType {
  pause,
  exit,
  ;

  String localizedLabel(AppLocalizations l10n) => switch (this) {
    .pause => l10n.shutdownPauseVideo,
    .exit => l10n.shutdownExitApp,
  };
}

final shutdownTimerService = ShutdownTimerService._internal();

class ShutdownTimerService with WidgetsBindingObserver {
  ShutdownTimerService._internal();

  VoidCallback? onPause;
  ValueGetter<bool>? isPlaying;

  DateTime? _deadline;
  DateTime? get deadline => _deadline;
  Timer? _shutdownTimer;
  Timer? _countdownRefreshTimer;
  bool get isActive => _shutdownTimer?.isActive ?? false;
  int _durationInMinutes = 0;
  _ShutdownType _shutdownType = .pause;

  bool _isWaiting = false;
  bool get isWaiting => _isWaiting;
  bool _waitUntilCompleted = false;
  bool _isObservingLifecycle = false;

  final ValueNotifier<ShutdownTimerSnapshot> _countdown = ValueNotifier(
    ShutdownTimerSnapshot(updatedAt: DateTime.now()),
  );

  ValueListenable<ShutdownTimerSnapshot> get countdown => _countdown;

  void _publishCountdown() {
    _countdown.value = ShutdownTimerSnapshot(
      updatedAt: DateTime.now(),
      deadline: _deadline,
      totalDuration: Duration(minutes: _durationInMinutes),
      isWaiting: _isWaiting,
    );
  }

  void refreshCountdown() {
    _publishCountdown();
  }

  void _startCountdownRefresh() {
    _countdownRefreshTimer?.cancel();
    _publishCountdown();
    // This is only a UI refresh tick; every snapshot is derived from _deadline.
    _countdownRefreshTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      _publishCountdown();
      if (!_countdown.value.isScheduled) {
        _stopCountdownRefresh();
      }
    });
  }

  void _stopCountdownRefresh() {
    _countdownRefreshTimer?.cancel();
    _countdownRefreshTimer = null;
  }

  void _observeLifecycle() {
    if (_isObservingLifecycle) return;
    WidgetsBinding.instance.addObserver(this);
    _isObservingLifecycle = true;
  }

  void _stopObservingLifecycle() {
    if (!_isObservingLifecycle) return;
    WidgetsBinding.instance.removeObserver(this);
    _isObservingLifecycle = false;
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _publishCountdown();
      if (_deadline != null && !_isWaiting && _countdown.value.isScheduled) {
        _startCountdownRefresh();
      }
    } else {
      _stopCountdownRefresh();
    }
  }

  void _stopTimer() {
    _deadline = null;
    _shutdownTimer?.cancel();
    _shutdownTimer = null;
  }

  void reset([int durationInMinutes = 0]) {
    _stopTimer();
    _stopCountdownRefresh();
    _stopObservingLifecycle();
    _isWaiting = false;
    _durationInMinutes = durationInMinutes;
    _publishCountdown();
  }

  void _startShutdownTimer(int durationInMinutes) {
    final l10n = Get.context!.l10n;
    reset(durationInMinutes);
    if (durationInMinutes == 0) {
      SmartDialog.showToast(l10n.shutdownCanceled);
      return;
    }
    SmartDialog.showToast(
      '设置 ${_format(l10n, durationInMinutes)} 后定时关闭',
    );
    _deadline = DateTime.now().add(Duration(minutes: durationInMinutes));
    _shutdownTimer = Timer(
      Duration(minutes: durationInMinutes),
      _handleShutdown,
    );
    _observeLifecycle();
    _startCountdownRefresh();
  }

  void _handleShutdown() {
    try {
      switch (_shutdownType) {
        case _ShutdownType.pause:
          late final player = PlPlayerController.instance;
          final isPlaying =
              this.isPlaying?.call() ?? player?.playerStatus.isPlaying ?? false;
          if (isPlaying) {
            if (_waitUntilCompleted) {
              _isWaiting = true;
            } else {
              _durationInMinutes = 0;
              (onPause ?? player?.pause)?.call();
              SmartDialog.showToast(
                Get.context!.l10n.shutdownTimeReachedPaused,
              );
            }
          }
        case _ShutdownType.exit:
          if (_waitUntilCompleted) {
            final isPlaying =
                this.isPlaying?.call() ??
                PlPlayerController.instance?.playerStatus.isPlaying ??
                false;
            if (isPlaying) {
              _isWaiting = true;
              return;
            }
          }
          _syncProgressAndExit();
      }
    } finally {
      _stopCountdownRefresh();
      _stopObservingLifecycle();
      _publishCountdown();
    }
  }

  void handleWaiting() {
    try {
      switch (_shutdownType) {
        case _ShutdownType.pause:
          _isWaiting = false;
          _durationInMinutes = 0;
          SmartDialog.showToast(Get.context!.l10n.shutdownTimeReachedPaused);
        case _ShutdownType.exit:
          _syncProgressAndExit();
      }
    } finally {
      _stopCountdownRefresh();
      _stopObservingLifecycle();
      _publishCountdown();
    }
  }

  void _syncProgressAndExit() {
    if (PlPlayerController.instance case final player?) {
      final res = player.makeHeartBeat(
        player.position.value,
        type: .completed,
        isManual: true,
      );
      if (res != null) {
        res.whenComplete(DeviceUtils.exitApp);
        return;
      }
    }
    DeviceUtils.exitApp();
  }

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

  Widget _pickerBuider(
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

  void _showTimePickerDialog(
    BuildContext context,
    VoidCallback onCountdown,
    StateSetter setState,
  ) {
    final values = _parseMinutes(_durationInMinutes);
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
              _startShutdownTimer(hour * 60 + minute);
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

  void showScheduleExitDialog(
    BuildContext context, {
    required bool isFullScreen,
    bool isLive = false,
  }) {
    const Set<int> scheduleTimeMinutes = {0, 15, 30, 45, 60};
    const TextStyle titleStyle = TextStyle(fontSize: 14);
    if (isLive) {
      _waitUntilCompleted = false;
    }

    final child = ShutdownPanel(
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
                ...{...scheduleTimeMinutes, _durationInMinutes}
                    .sorted(Comparable.compare)
                    .map(
                      (minutes) => ListTile(
                        dense: true,
                        onTap: () {
                          Navigator.pop(context);
                          _startShutdownTimer(minutes);
                        },
                        title: Text(
                          switch (minutes) {
                            0 => context.l10n.commonDisabled,
                            _ => _format(context.l10n, minutes),
                          },
                          style: titleStyle,
                        ),
                        trailing: _durationInMinutes == minutes
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
                  onTap: () =>
                      _showTimePickerDialog(context, onCountdown, setState),
                  title: const Text('自定义', style: titleStyle),
                ),
                if (!isLive) ...[
                  Builder(
                    builder: (context) {
                      void onChanged([_]) {
                        _waitUntilCompleted = !_waitUntilCompleted;
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
                            value: _waitUntilCompleted,
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
                          ..._ShutdownType.values.map(
                            (e) => ActionRowLineItem(
                              onTap: () {
                                _shutdownType = e;
                                (context as Element).markNeedsBuild();
                              },
                              text: ' ${e.localizedLabel(context.l10n)} ',
                              selectStatus: _shutdownType == e,
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
    this.buildCountdownText = _kBuildCountdownText,
  });

  final ShutdownStatefulWidgetBuilder builder;
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
      valueListenable: shutdownTimerService.countdown,
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
    return widget.builder(context, countdown, _startTimer, setState);
  }

  void _startTimer() => shutdownTimerService.refreshCountdown();
}
