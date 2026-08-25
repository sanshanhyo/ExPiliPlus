enum AudioFocusInterruptionKind { duck, pause, unknown }

enum AudioFocusAction { duck, unduck, pause, pauseAndDeactivate, resume }

class AudioFocusModeTransition {
  const AudioFocusModeTransition({
    this.releaseFocus = false,
    this.requestFocus = false,
    this.actions = const [],
  });

  final bool releaseFocus;
  final bool requestFocus;
  final List<AudioFocusAction> actions;
}

class AudioFocusPolicy {
  factory AudioFocusPolicy({required bool mixWithOthers}) {
    return AudioFocusPolicy._(mixWithOthers);
  }

  AudioFocusPolicy._(this._mixWithOthers);

  bool _mixWithOthers;
  bool _ducked = false;
  bool _pausedByInterruption = false;

  bool get mixWithOthers => _mixWithOthers;
  bool get shouldRequestFocus => !_mixWithOthers;

  AudioFocusModeTransition updateMixWithOthers(
    bool value, {
    required bool isPlaying,
  }) {
    if (_mixWithOthers == value) {
      return const AudioFocusModeTransition();
    }

    _mixWithOthers = value;
    if (value) {
      final actions = <AudioFocusAction>[
        if (_ducked) AudioFocusAction.unduck,
        if (_pausedByInterruption) AudioFocusAction.resume,
      ];
      _ducked = false;
      _pausedByInterruption = false;
      return AudioFocusModeTransition(
        releaseFocus: true,
        actions: actions,
      );
    }

    _ducked = false;
    _pausedByInterruption = false;
    return AudioFocusModeTransition(requestFocus: isPlaying);
  }

  List<AudioFocusAction> deactivateManually() {
    final actions = <AudioFocusAction>[
      if (_ducked) AudioFocusAction.unduck,
    ];
    _ducked = false;
    _pausedByInterruption = false;
    return actions;
  }

  List<AudioFocusAction> handleBecomingNoisy() {
    _ducked = false;
    _pausedByInterruption = false;
    return const [AudioFocusAction.pauseAndDeactivate];
  }

  List<AudioFocusAction> handleInterruption({
    required bool begin,
    required AudioFocusInterruptionKind kind,
    required bool isPlaying,
  }) {
    if (_mixWithOthers) return const [];

    if (begin) {
      if (!isPlaying) return const [];
      switch (kind) {
        case AudioFocusInterruptionKind.duck:
          if (_ducked) return const [];
          _ducked = true;
          return const [AudioFocusAction.duck];
        case AudioFocusInterruptionKind.pause:
        case AudioFocusInterruptionKind.unknown:
          final actions = <AudioFocusAction>[
            if (_ducked) AudioFocusAction.unduck,
            AudioFocusAction.pause,
          ];
          _ducked = false;
          _pausedByInterruption = true;
          return actions;
      }
    }

    switch (kind) {
      case AudioFocusInterruptionKind.duck:
        if (!_ducked) return const [];
        _ducked = false;
        return const [AudioFocusAction.unduck];
      case AudioFocusInterruptionKind.pause:
        if (!_pausedByInterruption) return const [];
        _pausedByInterruption = false;
        return const [AudioFocusAction.resume];
      case AudioFocusInterruptionKind.unknown:
        _pausedByInterruption = false;
        return const [];
    }
  }
}
