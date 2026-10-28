import 'package:ex_piliplus/services/shutdown_timer_snapshot.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ShutdownTimerSnapshot', () {
    final start = DateTime.utc(2026, 10, 26, 12);

    test('rounds remaining minutes up', () {
      final snapshot = ShutdownTimerSnapshot(
        updatedAt: start,
        isTimerActive: true,
        deadline: start.add(const Duration(minutes: 2, microseconds: 1)),
        totalDuration: const Duration(minutes: 10),
      );

      expect(snapshot.remainingMinutes, 3);
    });

    test('calculates progress from the deadline and scheduled duration', () {
      final snapshot = ShutdownTimerSnapshot(
        updatedAt: start,
        isTimerActive: true,
        deadline: start.add(const Duration(minutes: 15)),
        totalDuration: const Duration(minutes: 30),
      );

      expect(snapshot.isScheduled, isTrue);
      expect(snapshot.progress, 0.5);
    });

    test('clamps progress when remaining time exceeds the new duration', () {
      final snapshot = ShutdownTimerSnapshot(
        updatedAt: start,
        isTimerActive: true,
        deadline: start.add(const Duration(minutes: 20)),
        totalDuration: const Duration(minutes: 10),
      );

      expect(snapshot.progress, 1);
    });

    test('expires and waits without exposing a scheduled countdown', () {
      final expired = ShutdownTimerSnapshot(
        updatedAt: start,
        isTimerActive: true,
        deadline: start.subtract(const Duration(microseconds: 1)),
        totalDuration: const Duration(minutes: 10),
      );
      final waiting = ShutdownTimerSnapshot(
        updatedAt: start,
        isTimerActive: false,
        deadline: start.add(const Duration(minutes: 10)),
        totalDuration: const Duration(minutes: 10),
        isWaiting: true,
      );

      expect(expired.remaining, Duration.zero);
      expect(expired.remainingMinutes, 0);
      expect(expired.isScheduled, isFalse);
      expect(expired.progress, 0);
      expect(waiting.isWaiting, isTrue);
      expect(waiting.isTimerActive, isFalse);
      expect(waiting.isScheduled, isFalse);
      expect(waiting.progress, 0);
    });

    test('treats a cleared deadline as an unscheduled timer', () {
      final snapshot = ShutdownTimerSnapshot(
        updatedAt: start,
        isTimerActive: false,
        totalDuration: const Duration(minutes: 10),
      );

      expect(snapshot.remaining, Duration.zero);
      expect(snapshot.remainingMinutes, 0);
      expect(snapshot.isScheduled, isFalse);
      expect(snapshot.progress, 0);
    });

    test('uses the latest schedule as the progress denominator', () {
      final deadline = start.add(const Duration(minutes: 5));
      final firstSchedule = ShutdownTimerSnapshot(
        updatedAt: start,
        isTimerActive: true,
        deadline: deadline,
        totalDuration: const Duration(minutes: 10),
      );
      final rescheduled = ShutdownTimerSnapshot(
        updatedAt: start,
        isTimerActive: true,
        deadline: deadline,
        totalDuration: const Duration(minutes: 20),
      );

      expect(firstSchedule.progress, 0.5);
      expect(rescheduled.progress, 0.25);
    });

    test('does not revive an expired timer after the wall clock moves back', () {
      final deadline = start.add(const Duration(minutes: 15));
      // The 15-minute Timer has fired, but a one-hour clock rollback makes its
      // original deadline appear 60 minutes in the future.
      final clockAfterOneHourAdjustment = start.subtract(
        const Duration(minutes: 45),
      );
      final snapshot = ShutdownTimerSnapshot(
        updatedAt: clockAfterOneHourAdjustment,
        isTimerActive: false,
        deadline: deadline,
        totalDuration: const Duration(minutes: 15),
      );

      expect(snapshot.remaining, const Duration(minutes: 60));
      expect(snapshot.isScheduled, isFalse);
      expect(snapshot.progress, 0);
    });
  });
}
