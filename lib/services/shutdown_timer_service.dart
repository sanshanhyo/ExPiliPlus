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
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';

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

class ShutdownTimerService {
  ShutdownTimerService._internal();

  VoidCallback? onPause;
  ValueGetter<bool>? isPlaying;

  Timer? _shutdownTimer;
  bool get isActive => _shutdownTimer?.isActive ?? false;
  int _durationInMinutes = 0;
  _ShutdownType _shutdownType = .pause;

  bool _isWaiting = false;
  bool get isWaiting => _isWaiting;
  bool _waitUntilCompleted = false;

  void _stopTimer() {
    if (_shutdownTimer != null) {
      _shutdownTimer!.cancel();
      _shutdownTimer = null;
    }
  }

  void reset([int durationInMinutes = 0]) {
    _stopTimer();
    _isWaiting = false;
    _durationInMinutes = durationInMinutes;
  }

  void _startShutdownTimer(int durationInMinutes) {
    final l10n = Get.context!.l10n;
    reset(durationInMinutes);
    if (durationInMinutes == 0) {
      SmartDialog.showToast(l10n.shutdownCanceled);
      return;
    }
    SmartDialog.showToast(
      l10n.shutdownScheduledAfter(_format(l10n, durationInMinutes)),
    );
    _shutdownTimer = Timer(
      Duration(minutes: durationInMinutes),
      _handleShutdown,
    );
  }

  void _handleShutdown() {
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
  }

  void handleWaiting() {
    switch (_shutdownType) {
      case _ShutdownType.pause:
        _isWaiting = false;
        _durationInMinutes = 0;
        SmartDialog.showToast(Get.context!.l10n.shutdownTimeReachedPaused);
      case _ShutdownType.exit:
        _syncProgressAndExit();
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
        res.whenComplete(() => exit(0));
        return;
      }
    }
    exit(0);
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

    final child = StatefulBuilder(
      builder: (context, setState) {
        final ThemeData theme = Theme.of(context);
        return Padding(
          padding: const .all(12),
          child: Material(
            clipBehavior: .hardEdge,
            color: theme.colorScheme.surface,
            borderRadius: const .all(.circular(12)),
            child: ListView(
              padding: const .symmetric(vertical: 14),
              children: [
                Center(
                  child: Text(context.l10n.shutdownTitle, style: titleStyle),
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
                  onTap: () {
                    final (int hour, int minute) = _parseMinutes(
                      _durationInMinutes,
                    );
                    showTimePicker(
                      context: context,
                      initialEntryMode: .inputOnly,
                      initialTime: TimeOfDay(hour: hour, minute: minute),
                      builder: (context, child) => MediaQuery(
                        data: MediaQuery.of(
                          context,
                        ).copyWith(alwaysUse24HourFormat: true),
                        child: child!,
                      ),
                    ).then((time) {
                      if (time != null) {
                        _startShutdownTimer(time.hour * 60 + time.minute);
                        setState(() {});
                      }
                    });
                  },
                  title: Text(
                    context.l10n.shutdownCustom,
                    style: titleStyle,
                  ),
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
