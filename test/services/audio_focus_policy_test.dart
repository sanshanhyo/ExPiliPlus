import 'package:ex_piliplus/services/audio_focus_policy.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AudioFocusPolicy standard mode', () {
    late AudioFocusPolicy policy;

    setUp(() {
      policy = AudioFocusPolicy(mixWithOthers: false);
    });

    test('requests focus and handles duck without changing state twice', () {
      expect(policy.shouldRequestFocus, isTrue);
      expect(
        policy.handleInterruption(
          begin: true,
          kind: AudioFocusInterruptionKind.duck,
          isPlaying: true,
        ),
        [AudioFocusAction.duck],
      );
      expect(
        policy.handleInterruption(
          begin: true,
          kind: AudioFocusInterruptionKind.duck,
          isPlaying: true,
        ),
        isEmpty,
      );
      expect(
        policy.handleInterruption(
          begin: false,
          kind: AudioFocusInterruptionKind.duck,
          isPlaying: true,
        ),
        [AudioFocusAction.unduck],
      );
    });

    test('resumes only a transient interruption pause', () {
      expect(
        policy.handleInterruption(
          begin: true,
          kind: AudioFocusInterruptionKind.pause,
          isPlaying: true,
        ),
        [AudioFocusAction.pause],
      );
      expect(
        policy.handleInterruption(
          begin: false,
          kind: AudioFocusInterruptionKind.pause,
          isPlaying: false,
        ),
        [AudioFocusAction.resume],
      );
      expect(
        policy.handleInterruption(
          begin: false,
          kind: AudioFocusInterruptionKind.pause,
          isPlaying: false,
        ),
        isEmpty,
      );
    });

    test('does not resume after permanent focus loss', () {
      expect(
        policy.handleInterruption(
          begin: true,
          kind: AudioFocusInterruptionKind.unknown,
          isPlaying: true,
        ),
        [AudioFocusAction.pause],
      );
      expect(
        policy.handleInterruption(
          begin: false,
          kind: AudioFocusInterruptionKind.unknown,
          isPlaying: false,
        ),
        isEmpty,
      );
    });

    test('manual deactivation prevents interruption resume', () {
      policy.handleInterruption(
        begin: true,
        kind: AudioFocusInterruptionKind.pause,
        isPlaying: true,
      );

      expect(policy.deactivateManually(), isEmpty);
      expect(
        policy.handleInterruption(
          begin: false,
          kind: AudioFocusInterruptionKind.pause,
          isPlaying: false,
        ),
        isEmpty,
      );
    });
  });

  group('AudioFocusPolicy mixing mode', () {
    test('skips focus and ignores every interruption kind', () {
      final policy = AudioFocusPolicy(mixWithOthers: true);

      expect(policy.shouldRequestFocus, isFalse);
      for (final kind in AudioFocusInterruptionKind.values) {
        expect(
          policy.handleInterruption(
            begin: true,
            kind: kind,
            isPlaying: true,
          ),
          isEmpty,
        );
        expect(
          policy.handleInterruption(
            begin: false,
            kind: kind,
            isPlaying: true,
          ),
          isEmpty,
        );
      }
    });

    test('enabling mixing releases focus and resumes only focus pause', () {
      final policy = AudioFocusPolicy(mixWithOthers: false)
        ..handleInterruption(
          begin: true,
          kind: AudioFocusInterruptionKind.pause,
          isPlaying: true,
        );

      final transition = policy.updateMixWithOthers(
        true,
        isPlaying: false,
      );

      expect(transition.releaseFocus, isTrue);
      expect(transition.requestFocus, isFalse);
      expect(transition.actions, [AudioFocusAction.resume]);
      expect(policy.shouldRequestFocus, isFalse);
    });

    test('disabling mixing requests focus only during playback', () {
      var policy = AudioFocusPolicy(mixWithOthers: true);
      var transition = policy.updateMixWithOthers(true, isPlaying: true);
      expect(transition.requestFocus, isFalse);

      transition = policy.updateMixWithOthers(false, isPlaying: true);
      expect(transition.requestFocus, isTrue);
      expect(transition.releaseFocus, isFalse);

      policy = AudioFocusPolicy(mixWithOthers: true);
      transition = policy.updateMixWithOthers(false, isPlaying: false);
      expect(transition.requestFocus, isFalse);
    });

    test('headphone disconnect still pauses in both modes', () {
      expect(
        AudioFocusPolicy(
          mixWithOthers: false,
        ).handleBecomingNoisy(),
        [AudioFocusAction.pauseAndDeactivate],
      );
      expect(
        AudioFocusPolicy(
          mixWithOthers: true,
        ).handleBecomingNoisy(),
        [AudioFocusAction.pauseAndDeactivate],
      );
    });
  });
}
