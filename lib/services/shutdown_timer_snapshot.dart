/// A point-in-time view of the shutdown timer and its actual Timer state.
///
/// Remaining time is always derived from the original deadline. UI refreshes
/// can therefore be delayed by app lifecycle changes without changing when the
/// shutdown action runs. [isTimerActive] prevents wall-clock changes from
/// reviving a countdown after its one-shot shutdown timer has fired.
class ShutdownTimerSnapshot {
  const ShutdownTimerSnapshot({
    required this.updatedAt,
    required this.isTimerActive,
    this.deadline,
    this.totalDuration = Duration.zero,
    this.isWaiting = false,
  });

  final DateTime updatedAt;
  final bool isTimerActive;
  final DateTime? deadline;
  final Duration totalDuration;
  final bool isWaiting;

  Duration get remaining {
    final deadline = this.deadline;
    if (deadline == null) return Duration.zero;
    final value = deadline.difference(updatedAt);
    return value.isNegative ? Duration.zero : value;
  }

  bool get isScheduled =>
      isTimerActive &&
      deadline != null &&
      !isWaiting &&
      remaining > Duration.zero;

  int get remainingMinutes {
    final microseconds = remaining.inMicroseconds;
    if (microseconds == 0) return 0;
    final microsecondsPerMinute = const Duration(minutes: 1).inMicroseconds;
    return (microseconds + microsecondsPerMinute - 1) ~/ microsecondsPerMinute;
  }

  double get progress {
    final totalMicroseconds = totalDuration.inMicroseconds;
    if (!isScheduled || totalMicroseconds <= 0) return 0;
    return (remaining.inMicroseconds / totalMicroseconds)
        .clamp(0.0, 1.0)
        .toDouble();
  }
}
