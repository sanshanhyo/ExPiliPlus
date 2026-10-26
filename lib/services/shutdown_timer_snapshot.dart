/// A point-in-time view of the active shutdown timer.
///
/// Remaining time is always derived from the original deadline. UI refreshes
/// can therefore be delayed by app lifecycle changes without changing when the
/// shutdown action runs.
class ShutdownTimerSnapshot {
  const ShutdownTimerSnapshot({
    required this.updatedAt,
    this.deadline,
    this.totalDuration = Duration.zero,
    this.isWaiting = false,
  });

  final DateTime updatedAt;
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
      deadline != null && !isWaiting && remaining > Duration.zero;

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
