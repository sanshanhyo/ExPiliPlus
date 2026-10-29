import 'dart:async';
import 'dart:io';

import 'package:ex_piliplus/features/sync_play/sync_play_player_binding.dart';
import 'package:ex_piliplus/features/sync_play/sync_play_protocol.dart';
import 'package:ex_piliplus/features/sync_play/sync_play_service.dart';
import 'package:flutter_test/flutter_test.dart';

const _upstreamRevision = 'f9258d976570492a1d1e2c469d3da90a8cfade96';

class _TrackedSocket implements SyncPlaySocket {
  _TrackedSocket(this.delegate);

  final SyncPlaySocket delegate;

  @override
  Stream<Object?> get stream => delegate.stream;

  @override
  void send(String text) => delegate.send(text);

  @override
  Future<void> close() => delegate.close();
}

class _IdlePlayer implements SyncPlayPlayerPort {
  @override
  final Object identity = Object();
  @override
  int positionMs = 42_000;
  @override
  int durationMs = 240_000;
  @override
  double playbackRate = 1;
  @override
  double get syncPlaybackRate => playbackRate;
  @override
  bool isTransientSpeed = false;
  @override
  bool isPlaying = false;
  @override
  bool isCompleted = false;
  @override
  bool isBuffering = false;

  final Set<void Function(Duration)> _positionListeners = {};
  final Set<void Function()> _statusListeners = {};
  final Set<void Function(PlPlayerExplicitAction)> _actionListeners = {};

  @override
  void addPositionListener(void Function(Duration) listener) =>
      _positionListeners.add(listener);
  @override
  void removePositionListener(void Function(Duration) listener) =>
      _positionListeners.remove(listener);
  @override
  void addStatusListener(void Function() listener) =>
      _statusListeners.add(listener);
  @override
  void removeStatusListener(void Function() listener) =>
      _statusListeners.remove(listener);
  @override
  void addExplicitActionListener(
    void Function(PlPlayerExplicitAction) listener,
  ) => _actionListeners.add(listener);
  @override
  void removeExplicitActionListener(
    void Function(PlPlayerExplicitAction) listener,
  ) => _actionListeners.remove(listener);
  @override
  Future<void> seekToMs(int milliseconds) async => positionMs = milliseconds;
  @override
  Future<void> setPlaybackRate(double rate) async => playbackRate = rate;
  @override
  Future<void> play() async => isPlaying = true;
  @override
  Future<void> pause() async => isPlaying = false;
}

SyncPlayConnectionSettings _settings(int port, String displayName) =>
    SyncPlayConnectionSettings(
      serverAddress: 'https://127.0.0.1:$port',
      displayName: displayName,
    );

Future<void> _waitUntil(
  String description,
  bool Function() condition, {
  Duration timeout = const Duration(seconds: 12),
}) async {
  final watch = Stopwatch()..start();
  while (watch.elapsed < timeout) {
    if (condition()) return;
    await Future<void>.delayed(const Duration(milliseconds: 20));
  }
  throw TimeoutException('Timed out waiting for $description.', timeout);
}

String _serviceState(SyncPlayService service) =>
    'status=${service.status.name}, error=${service.lastErrorCode}, '
    'member=${service.memberId}, room=${service.room?.roomCode}, '
    'members=${service.room?.members.map((member) => member.id).toList()}';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final configuredPort = int.tryParse(
    Platform.environment['SYNCPLAY_TEST_SERVER_PORT'] ?? '',
  );
  group('Dart SyncPlayService against pinned upstream server', () {
    test(
      'two production services create, invite, reconnect, sync playback, and leave',
      () async {
        final port = configuredPort!;
        expect(
          Platform.environment['SYNCPLAY_UPSTREAM_REVISION'],
          _upstreamRevision,
        );
        await HttpOverrides.runZoned(() async {
          final ownerSockets = <_TrackedSocket>[];
          final guestSockets = <_TrackedSocket>[];
          final reconnectGate = Completer<void>();
          final reconnectAttempted = Completer<void>();
          var guestSocketCalls = 0;

          Future<SyncPlaySocket> connect(
            List<_TrackedSocket> observed,
            Uri endpoint,
            String origin,
          ) async {
            expect(endpoint.scheme, 'wss');
            expect(endpoint.host, '127.0.0.1');
            expect(endpoint.port, port);
            expect(origin, 'https://127.0.0.1:$port');
            final socket = _TrackedSocket(
              await IoSyncPlaySocket.connect(endpoint, origin),
            );
            observed.add(socket);
            return socket;
          }

          final owner = SyncPlayService(
            socketFactory: (endpoint, origin) =>
                connect(ownerSockets, endpoint, origin),
          );
          final guest = SyncPlayService(
            reconnectDelay: (_) => Duration.zero,
            socketFactory: (endpoint, origin) async {
              guestSocketCalls++;
              if (guestSocketCalls > 1) {
                if (!reconnectAttempted.isCompleted) {
                  reconnectAttempted.complete();
                }
                await reconnectGate.future;
              }
              return connect(guestSockets, endpoint, origin);
            },
          );

          try {
            await owner.createRoom(_settings(port, 'Dart host'));
            await _waitUntil(
              'host room creation (${_serviceState(owner)})',
              () => owner.credentials != null && owner.room != null,
            );
            final invite = owner.invite;
            expect(invite, isNotNull);
            expect(invite, matches(RegExp(r'^[A-Z0-9]{6}:.{16,128}$')));

            await guest.joinRoom(_settings(port, 'Dart guest'), invite!);
            await _waitUntil(
              'guest join and two-member room (${_serviceState(guest)})',
              () =>
                  guest.memberId != null &&
                  guest.room?.members.length == 2 &&
                  owner.room?.members.length == 2,
            );
            final guestMemberId = guest.memberId;

            final video = SyncPlayVideoRef.fromPlayer(
              bvid: 'BV1gA411M7RN',
              cid: 2002,
              part: 1,
            );
            expect(
              await owner.shareCurrentVideo(
                video: video,
                title: 'Synthetic integration video',
                player: _IdlePlayer(),
              ),
              isTrue,
            );
            await _waitUntil(
              'shared video reached guest (${_serviceState(guest)})',
              () => guest.room?.sharedVideo?.videoId == video.videoId,
            );

            final playback = SyncPlayPlayback(
              url: video.url,
              currentTimeSeconds: 42,
              state: SyncPlayPlaybackState.paused,
              playbackRate: 1.5,
              updatedAt: DateTime.now().millisecondsSinceEpoch,
              serverTime: 0,
              actorId: owner.memberId!,
              seq: owner.nextPlaybackSequence(),
              syncIntent: 'explicit-seek',
              userInitiated: true,
            );
            owner.sendPlayback(playback);
            await _waitUntil(
              'playback update reached guest (${_serviceState(guest)})',
              () => guest.room?.playback?.seq == playback.seq,
            );
            expect(guest.room?.playback?.state, SyncPlayPlaybackState.paused);
            expect(guest.room?.playback?.currentTimeSeconds, 42);
            expect(guest.room?.playback?.playbackRate, 1.5);
            expect(guest.room?.playback?.syncIntent, 'explicit-seek');

            await guestSockets.single.close();
            await reconnectAttempted.future.timeout(
              const Duration(seconds: 8),
              onTimeout: () => throw TimeoutException(
                'Guest service never scheduled a reconnect.',
              ),
            );
            await _waitUntil(
              'upstream server to release disconnected guest seat (${_serviceState(owner)})',
              () => owner.room?.members.length == 1,
            );
            reconnectGate.complete();
            await _waitUntil(
              'guest service to reclaim its room member (${_serviceState(guest)})',
              () =>
                  guest.status == SyncPlayConnectionStatus.connected &&
                  guestSockets.length == 2 &&
                  guest.memberId == guestMemberId &&
                  owner.room?.members.length == 2 &&
                  owner.room?.members.any((member) => member.id == guestMemberId) ==
                      true,
            );

            await guest.leaveRoom().timeout(const Duration(seconds: 8));
            await _waitUntil(
              'upstream server to observe explicit guest leave (${_serviceState(owner)})',
              () => owner.room?.members.length == 1,
            );
            expect(guest.credentials, isNull);
            await owner.leaveRoom().timeout(const Duration(seconds: 8));
            expect(owner.status, SyncPlayConnectionStatus.disconnected);
          } finally {
            if (!reconnectGate.isCompleted) reconnectGate.complete();
            if (guest.isInRoom || guest.isConnected) {
              await guest.leaveRoom().timeout(
                const Duration(seconds: 8),
                onTimeout: () async {},
              );
            }
            if (owner.isInRoom || owner.isConnected) {
              await owner.leaveRoom().timeout(
                const Duration(seconds: 8),
                onTimeout: () async {},
              );
            }
            guest.dispose();
            owner.dispose();
          }
        }, createHttpClient: _createLoopbackOnlyHttpClient);
      },
      skip: configuredPort == null,
      timeout: const Timeout(Duration(seconds: 55)),
    );

    test(
      'upstream rejects a service connection with an unapproved Origin',
      () async {
        final port = configuredPort!;
        await HttpOverrides.runZoned(() async {
          final service = SyncPlayService();
          try {
            await service.createRoom(
              SyncPlayConnectionSettings(
                serverAddress: '',
                displayName: 'Origin check',
                advancedMode: true,
                advancedWebSocketUrl: 'wss://127.0.0.1:$port',
                advancedOrigin: 'https://not-allowed.integration.test',
              ),
            );
            await _waitUntil(
              'Origin rejection (${_serviceState(service)})',
              () => service.status == SyncPlayConnectionStatus.disconnected,
            );
            expect(service.credentials, isNull);
            expect(service.lastErrorCode, 'connection_failed');
          } finally {
            service.dispose();
          }
        }, createHttpClient: _createLoopbackOnlyHttpClient);
      },
      skip: configuredPort == null,
      timeout: const Timeout(Duration(seconds: 20)),
    );
  });
}

HttpClient _createLoopbackOnlyHttpClient(SecurityContext? context) =>
    HttpClient(context)
      ..badCertificateCallback = (_, host, __) => host == '127.0.0.1';
