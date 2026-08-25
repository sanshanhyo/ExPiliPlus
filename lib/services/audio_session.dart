import 'dart:async' show unawaited;
import 'dart:io' show Platform;

import 'package:ex_piliplus/plugin/pl_player/controller.dart';
import 'package:ex_piliplus/plugin/pl_player/models/play_status.dart';
import 'package:ex_piliplus/services/audio_focus_policy.dart';
import 'package:ex_piliplus/utils/storage_pref.dart';
import 'package:audio_session/audio_session.dart';

class AudioSessionHandler {
  AudioSessionHandler._(this.session)
    : _policy = AudioFocusPolicy(
        mixWithOthers: Platform.isAndroid && Pref.mixAudioWithOtherApps,
      );

  final AudioSession session;
  final AudioFocusPolicy _policy;

  static Future<AudioSessionHandler> create() async {
    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration.music());
    final handler = AudioSessionHandler._(session).._listen();
    return handler;
  }

  Future<bool> setActive(bool active) async {
    if (!active) {
      await _applyActions(_policy.deactivateManually());
      return session.setActive(false);
    }
    if (!_policy.shouldRequestFocus) return true;
    return session.setActive(active);
  }

  Future<void> updateMixWithOthers(bool value) async {
    if (!Platform.isAndroid) return;
    final transition = _policy.updateMixWithOthers(
      value,
      isPlaying:
          PlPlayerController.getPlayerStatusIfExists() == PlayerStatus.playing,
    );
    if (transition.releaseFocus) {
      await session.setActive(false);
    } else if (transition.requestFocus) {
      await session.setActive(true);
    }
    await _applyActions(transition.actions);
  }

  void _listen() {
    session.interruptionEventStream.listen((event) {
      unawaited(_handleInterruption(event));
    });

    // 耳机拔出暂停
    session.becomingNoisyEventStream.listen((_) {
      unawaited(_applyActions(_policy.handleBecomingNoisy()));
    });
  }

  Future<void> _handleInterruption(AudioInterruptionEvent event) {
    final actions = _policy.handleInterruption(
      begin: event.begin,
      kind: switch (event.type) {
        AudioInterruptionType.duck => AudioFocusInterruptionKind.duck,
        AudioInterruptionType.pause => AudioFocusInterruptionKind.pause,
        AudioInterruptionType.unknown => AudioFocusInterruptionKind.unknown,
      },
      isPlaying:
          PlPlayerController.getPlayerStatusIfExists() == PlayerStatus.playing,
    );
    return _applyActions(actions);
  }

  Future<void> _applyActions(List<AudioFocusAction> actions) async {
    for (final action in actions) {
      switch (action) {
        case AudioFocusAction.duck:
          await PlPlayerController.setAudioFocusVolumeMultiplierIfExists(0.5);
          break;
        case AudioFocusAction.unduck:
          await PlPlayerController.setAudioFocusVolumeMultiplierIfExists(1.0);
          break;
        case AudioFocusAction.pause:
          await PlPlayerController.pauseIfExists(isInterrupt: true);
          break;
        case AudioFocusAction.pauseAndDeactivate:
          await PlPlayerController.pauseIfExists();
          break;
        case AudioFocusAction.resume:
          await PlPlayerController.playIfExists();
          break;
      }
    }
  }
}
