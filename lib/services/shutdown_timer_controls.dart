import 'package:ex_piliplus/services/shutdown_timer_snapshot.dart';
import 'package:flutter/foundation.dart' show ValueListenable;

enum ShutdownTimerAction { pause, exit }

/// Operations and state required by the shutdown timer dialog.
///
/// Keeping the dialog on this small interface lets its UI be exercised with a
/// fake controller without starting app timers or touching the native player.
abstract interface class ShutdownTimerControls {
  ValueListenable<ShutdownTimerSnapshot> get countdown;
  int get durationInMinutes;
  bool get waitUntilCompleted;
  ShutdownTimerAction get shutdownAction;

  void schedule(int durationInMinutes);
  void setWaitUntilCompleted(bool value);
  void setShutdownAction(ShutdownTimerAction value);
  void refreshCountdown();
}
