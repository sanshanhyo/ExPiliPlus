// 定时关闭服务
import 'dart:async';

import 'package:ex_piliplus/l10n/generated/app_localizations.dart';
import 'package:ex_piliplus/plugin/pl_player/controller.dart';
import 'package:ex_piliplus/services/shutdown_timer_controls.dart';
import 'package:ex_piliplus/services/shutdown_timer_snapshot.dart';
import 'package:ex_piliplus/utils/device_utils.dart';
import 'package:ex_piliplus/utils/extension/l10n_ext.dart';
import 'package:flutter/foundation.dart'
    show ValueGetter, ValueListenable, ValueNotifier, VoidCallback;
import 'package:flutter/widgets.dart'
    show AppLifecycleState, WidgetsBinding, WidgetsBindingObserver;
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';

final shutdownTimerService = ShutdownTimerService._internal();

class ShutdownTimerService
    with WidgetsBindingObserver
    implements ShutdownTimerControls {
  ShutdownTimerService._internal();

  VoidCallback? onPause;
  ValueGetter<bool>? isPlaying;

  DateTime? _deadline;
  DateTime? get deadline => _deadline;
  Timer? _shutdownTimer;
  Timer? _countdownRefreshTimer;
  bool get isActive => _shutdownTimer?.isActive ?? false;
  int _durationInMinutes = 0;
  @override
  int get durationInMinutes => _durationInMinutes;

  ShutdownTimerAction _shutdownType = .pause;
  @override
  ShutdownTimerAction get shutdownAction => _shutdownType;

  bool _isWaiting = false;
  bool get isWaiting => _isWaiting;
  bool _waitUntilCompleted = false;
  @override
  bool get waitUntilCompleted => _waitUntilCompleted;
  bool _isObservingLifecycle = false;

  final ValueNotifier<ShutdownTimerSnapshot> _countdown = ValueNotifier(
    ShutdownTimerSnapshot(updatedAt: DateTime.now(), isTimerActive: false),
  );

  @override
  ValueListenable<ShutdownTimerSnapshot> get countdown => _countdown;

  void _publishCountdown() {
    _countdown.value = ShutdownTimerSnapshot(
      updatedAt: DateTime.now(),
      isTimerActive: isActive,
      deadline: _deadline,
      totalDuration: Duration(minutes: _durationInMinutes),
      isWaiting: _isWaiting,
    );
  }

  @override
  void refreshCountdown() {
    _publishCountdown();
  }

  @override
  void schedule(int durationInMinutes) =>
      _startShutdownTimer(durationInMinutes);

  @override
  void setWaitUntilCompleted(bool value) => _waitUntilCompleted = value;

  @override
  void setShutdownAction(ShutdownTimerAction value) => _shutdownType = value;

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

  void _handleShutdown() {
    try {
      switch (_shutdownType) {
        case ShutdownTimerAction.pause:
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
        case ShutdownTimerAction.exit:
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
      _stopTimer();
      _stopCountdownRefresh();
      _stopObservingLifecycle();
      _publishCountdown();
    }
  }

  void handleWaiting() {
    try {
      _isWaiting = false;
      switch (_shutdownType) {
        case ShutdownTimerAction.pause:
          _durationInMinutes = 0;
          SmartDialog.showToast(Get.context!.l10n.shutdownTimeReachedPaused);
        case ShutdownTimerAction.exit:
          _syncProgressAndExit();
      }
    } finally {
      _stopTimer();
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
}
