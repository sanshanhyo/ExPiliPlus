import 'dart:async';

import 'package:ex_piliplus/plugin/pl_player/controller.dart';
import 'package:ex_piliplus/plugin/pl_player/models/play_status.dart';

import 'sync_play_protocol.dart';
import 'sync_play_service.dart';

abstract interface class SyncPlayPlayerPort {
  Object get identity;
  int get positionMs;
  int get durationMs;
  double get playbackRate;
  double get syncPlaybackRate;
  bool get isTransientSpeed;
  bool get isPlaying;
  bool get isCompleted;
  bool get isBuffering;
  void addPositionListener(void Function(Duration position) listener);
  void removePositionListener(void Function(Duration position) listener);
  void addStatusListener(void Function() listener);
  void removeStatusListener(void Function() listener);
  void addExplicitActionListener(
    void Function(PlPlayerExplicitAction action) listener,
  );
  void removeExplicitActionListener(
    void Function(PlPlayerExplicitAction action) listener,
  );
  Future<void> seekToMs(int milliseconds);
  Future<void> setPlaybackRate(double rate);
  Future<void> play();
  Future<void> pause();
}

class PlPlayerSyncPort implements SyncPlayPlayerPort {
  PlPlayerSyncPort(this.controller);

  final PlPlayerController controller;

  @override
  Object get identity => controller;
  @override
  int get positionMs => controller.positionInMilliseconds;
  @override
  int get durationMs => controller.durationInMilliseconds;
  @override
  double get playbackRate => controller.playbackSpeed;
  @override
  double get syncPlaybackRate => controller.longPressStatus.value
      ? controller.lastPlaybackSpeed
      : controller.playbackSpeed;
  @override
  bool get isTransientSpeed =>
      controller.longPressStatus.value || controller.tripling;
  @override
  bool get isPlaying => controller.playerStatus.isPlaying;
  @override
  bool get isCompleted => controller.playerStatus.isCompleted;
  @override
  bool get isBuffering => controller.isBuffering.value;

  @override
  void addPositionListener(void Function(Duration) listener) =>
      controller.addPositionListener(listener);

  @override
  void removePositionListener(void Function(Duration) listener) =>
      controller.removePositionListener(listener);

  @override
  void addStatusListener(void Function() listener) {
    final adapter = _statusAdapters.putIfAbsent(
      listener,
      () => (_) => listener(),
    );
    controller.addStatusLister(adapter);
  }

  @override
  void removeStatusListener(void Function() listener) {
    final adapter = _statusAdapters.remove(listener);
    if (adapter != null) controller.removeStatusLister(adapter);
  }

  final Map<void Function(), void Function(PlayerStatus)> _statusAdapters = {};

  @override
  void addExplicitActionListener(
    void Function(PlPlayerExplicitAction action) listener,
  ) => controller.addExplicitActionListener(listener);

  @override
  void removeExplicitActionListener(
    void Function(PlPlayerExplicitAction action) listener,
  ) => controller.removeExplicitActionListener(listener);

  @override
  Future<void> seekToMs(int milliseconds) => controller.seek(
    Duration(milliseconds: milliseconds.clamp(0, durationMs).toInt()),
    isSeek: false,
  );

  @override
  Future<void> setPlaybackRate(double rate) =>
      controller.setPlaybackSpeed(rate);

  @override
  Future<void> play() => controller.play();

  @override
  Future<void> pause() => controller.pause();
}

class SyncPlayPlayerBinding {
  SyncPlayPlayerBinding({
    required this.service,
    required this.player,
    required this.video,
    required Duration Function() monotonicNow,
    String Function()? currentVideoId,
    bool localPlaybackAuthority = false,
  }) : _monotonicNow = monotonicNow,
       _currentVideoId = currentVideoId ?? (() => video.videoId),
       _remotePlaybackAuthoritative = !localPlaybackAuthority;

  final SyncPlayService service;
  final SyncPlayPlayerPort player;
  final SyncPlaySharedVideo video;
  final Duration Function() _monotonicNow;
  final String Function() _currentVideoId;
  late final void Function(Duration) _positionListener = _onPosition;
  late final void Function() _statusListener = _onStatus;

  Timer? _ticker;
  bool _started = false;
  bool _disposed = false;
  bool _samplingPaused = false;
  bool _applyingRemote = false;
  bool _remotePlaybackAuthoritative;
  bool _lastCompleted = false;
  int _generation = 0;
  Duration _lastBroadcastAt = Duration.zero;
  Duration _suppressBroadcastUntil = Duration.zero;
  String? _lastAppliedRemoteKey;

  bool matchesPlayer(SyncPlayPlayerPort other) =>
      identical(player.identity, other.identity);

  bool matchesIdentity(Object identity) => identical(player.identity, identity);

  void start({bool applyCurrentRemoteState = false}) {
    if (_started || _disposed) return;
    _started = true;
    _lastBroadcastAt = _monotonicNow();
    _lastCompleted = player.isCompleted;
    player
      ..addPositionListener(_positionListener)
      ..addStatusListener(_statusListener)
      ..addExplicitActionListener(_onExplicitAction);
    _startTicker();
    if (applyCurrentRemoteState) onServiceChanged();
  }

  void _startTicker() {
    _ticker?.cancel();
    if (_samplingPaused || _disposed) return;
    _ticker = Timer.periodic(const Duration(milliseconds: 2100), (_) {
      _checkIdentityAndPublish();
    });
  }

  void pauseSampling() {
    _samplingPaused = true;
    _ticker?.cancel();
    _ticker = null;
  }

  void resumeSampling() {
    if (!_samplingPaused || _disposed) return;
    _samplingPaused = false;
    _lastBroadcastAt = _monotonicNow();
    _suppressBroadcastUntil = _lastBroadcastAt + const Duration(
      milliseconds: 650,
    );
    _startTicker();
  }

  void onServiceChanged() {
    if (_disposed || !_started) return;
    final shared = service.room?.sharedVideo;
    if (shared != null && shared.videoId != video.videoId) {
      service.clearPlayerBinding(this);
      dispose();
      return;
    }
    final playback = service.room?.playback;
    final localId = service.memberId;
    if (playback == null || playback.actorId == localId) return;
    final key = '${playback.actorId}:${playback.seq}';
    if (_lastAppliedRemoteKey == key) return;
    _lastAppliedRemoteKey = key;
    unawaited(_applyRemote(playback));
  }

  void resetRemotePlaybackDeduplication() {
    _lastAppliedRemoteKey = null;
  }

  Future<void> _applyRemote(SyncPlayPlayback playback) async {
    final generation = ++_generation;
    _applyingRemote = true;
    _remotePlaybackAuthoritative = true;
    _suppressBroadcastUntil = _monotonicNow() + const Duration(
      milliseconds: 650,
    );
    try {
      final desiredRate = playback.playbackRate.clamp(0.25, 4.0).toDouble();
      if ((player.playbackRate - desiredRate).abs() > 0.001) {
        await player.setPlaybackRate(desiredRate);
      }
      if (generation != _generation || _disposed) return;
      final targetMs = service.estimatedRemotePositionMs();
      if ((player.positionMs - targetMs).abs() > 1500 ||
          playback.syncIntent == 'explicit-seek') {
        await player.seekToMs(targetMs);
      }
      if (generation != _generation || _disposed) return;
      if (playback.state == SyncPlayPlaybackState.playing && !player.isPlaying) {
        await player.play();
      } else if (playback.state == SyncPlayPlaybackState.paused &&
          player.isPlaying) {
        await player.pause();
      }
    } finally {
      if (generation == _generation) {
        _applyingRemote = false;
        _lastBroadcastAt = _monotonicNow();
      }
    }
  }

  void _onPosition(Duration position) => _checkIdentityAndPublish();

  void _onStatus() {
    if (_disposed || _samplingPaused) return;
    if (player.isCompleted && !_lastCompleted) {
      _lastCompleted = true;
      if (!_applyingRemote &&
          !_remotePlaybackAuthoritative &&
          _monotonicNow() >= _suppressBroadcastUntil &&
          _currentVideoId() == video.videoId) {
        service.sendPlayback(buildPlayback());
        _lastBroadcastAt = _monotonicNow();
      }
      return;
    }
    if (!player.isCompleted) _lastCompleted = false;
    _checkIdentityAndPublish();
  }

  void _checkIdentityAndPublish() {
    if (_disposed || _samplingPaused) return;
    if (_currentVideoId() != video.videoId) {
      service.clearPlayerBinding(this);
      dispose();
      return;
    }
    final current = service.room?.sharedVideo;
    if (current != null && current.videoId != video.videoId) {
      service.clearPlayerBinding(this);
      dispose();
      return;
    }
    final now = _monotonicNow();
    final suppressed = _applyingRemote || now < _suppressBroadcastUntil;
    final intervalDue = (now - _lastBroadcastAt) >=
        const Duration(seconds: 2);
      if (!suppressed &&
        !_remotePlaybackAuthoritative &&
        intervalDue &&
        player.isPlaying &&
        !player.isBuffering &&
        !player.isTransientSpeed) {
      service.sendPlayback(buildPlayback());
      _lastBroadcastAt = now;
    }
  }

  void _onExplicitAction(PlPlayerExplicitAction action) {
    if (_disposed || _samplingPaused || _applyingRemote) return;
    if (action == PlPlayerExplicitAction.playbackRate &&
        player.isTransientSpeed) {
      return;
    }
    final now = _monotonicNow();
    if (_currentVideoId() != video.videoId) {
      return;
    }
    _remotePlaybackAuthoritative = false;
    _suppressBroadcastUntil = Duration.zero;
    final syncIntent = switch (action) {
      PlPlayerExplicitAction.playback => null,
      PlPlayerExplicitAction.seek => 'explicit-seek',
      PlPlayerExplicitAction.playbackRate => 'explicit-ratechange',
    };
    service.sendPlayback(
      buildPlayback(userInitiated: true, syncIntent: syncIntent),
    );
    _lastBroadcastAt = now;
  }

  SyncPlayPlayback buildPlayback({
    bool userInitiated = false,
    String? syncIntent,
  }) {
    final state = player.isBuffering
        ? SyncPlayPlaybackState.buffering
        : player.isPlaying
        ? SyncPlayPlaybackState.playing
        : SyncPlayPlaybackState.paused;
    return SyncPlayPlayback(
      url: video.url,
      currentTimeSeconds: player.positionMs.clamp(0, 86400000) / 1000,
      state: player.isCompleted ? SyncPlayPlaybackState.paused : state,
      playbackRate: player.syncPlaybackRate.clamp(0.25, 4.0).toDouble(),
      updatedAt: DateTime.now().millisecondsSinceEpoch,
      // The server fills this field when forwarding. Zero is protocol-valid
      // for clients and must not be compared with a local wall clock.
      serverTime: 0,
      actorId: service.memberId ?? '',
      seq: service.nextPlaybackSequence(),
      syncIntent: syncIntent,
      userInitiated: userInitiated,
      naturalEnd: player.isCompleted,
    );
  }

  void dispose() {
    if (_disposed) return;
    _disposed = true;
    _generation++;
    _ticker?.cancel();
    if (_started) {
      player
        ..removePositionListener(_positionListener)
        ..removeStatusListener(_statusListener)
        ..removeExplicitActionListener(_onExplicitAction);
    }
  }
}
