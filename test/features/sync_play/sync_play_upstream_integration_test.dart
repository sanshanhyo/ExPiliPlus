import 'dart:async';
import 'dart:io' show HttpClient, HttpOverrides, Platform;

import 'package:crypto/crypto.dart' as crypto;
import 'package:ex_piliplus/features/sync_play/sync_play_player_binding.dart';
import 'package:ex_piliplus/features/sync_play/sync_play_protocol.dart';
import 'package:ex_piliplus/features/sync_play/sync_play_service.dart';
import 'package:ex_piliplus/plugin/pl_player/controller.dart'
    show PlPlayerExplicitAction;
import 'package:flutter_test/flutter_test.dart';
import 'package:web_socket_channel/io.dart';

const _upstreamRevision = 'f9258d976570492a1d1e2c469d3da90a8cfade96';

class _TrackedSocket implements SyncPlaySocket {
  _TrackedSocket(this.delegate, this.frames);

  final SyncPlaySocket delegate;
  final List<String> frames;

  @override
  Stream<Object?> get stream => delegate.stream.map((raw) {
    final message = decodeSyncPlayMessage(raw);
    if (message != null) {
      final type = message['type'];
      final payload = message['payload'];
      if (type == 'room:state' && payload is Map) {
        final shared = payload['sharedVideo'];
        final videoId = shared is Map ? shared['videoId'] : null;
        final playback = payload['playback'];
        final seq = playback is Map ? playback['seq'] : null;
        frames.add('room:state(videoId=$videoId,seq=$seq)');
      } else if (type == 'error' && payload is Map) {
        frames.add('error(code=${payload['code']})');
      } else {
        frames.add('$type');
      }
    } else {
      frames.add('unparseable-frame');
    }
    return raw;
  });

  @override
  void send(String text) {
    final message = decodeSyncPlayMessage(text);
    if (message != null) frames.add('send:${message['type']}');
    delegate.send(text);
  }

  @override
  Future<void> close() => delegate.close();
}

class _LoopbackTestSocket implements SyncPlaySocket {
  _LoopbackTestSocket(this._channel);

  final IOWebSocketChannel _channel;

  @override
  Stream<Object?> get stream => _channel.stream;

  @override
  void send(String text) => _channel.sink.add(text);

  @override
  Future<void> close() async => _channel.sink.close();
}

class _RealHttpOverrides extends HttpOverrides {}

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

SyncPlayConnectionSettings _settings(String displayName) =>
    SyncPlayConnectionSettings(
      serverAddress: 'https://syncplay-integration.test',
      displayName: displayName,
    );

Future<SyncPlaySocket> _connectToPinnedServer(
  Uri endpoint,
  String origin,
  int loopbackPort,
) async {
  expect(endpoint.scheme, 'wss');
  expect(endpoint.host, 'syncplay-integration.test');
  expect(endpoint.hasPort, isFalse);
  expect(endpoint.path, isEmpty);

  // Keep the production service's secure endpoint/origin derivation in the
  // assertion, while using plain WebSocket only on this private loopback
  // transport. TLS certificate negotiation is deliberately not covered here.
  final loopback = Uri(
    scheme: 'ws',
    host: '127.0.0.1',
    port: loopbackPort,
    path: endpoint.path,
  );
  final channel = IOWebSocketChannel.connect(
    loopback,
    headers: {'Origin': origin},
    connectTimeout: const Duration(seconds: 12),
    pingInterval: const Duration(seconds: 25),
  );
  await channel.ready;
  return _LoopbackTestSocket(channel);
}

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

String _serviceState(
  SyncPlayService service, {
  List<_TrackedSocket> sockets = const [],
}) =>
    'status=${service.status.name}, error=${service.lastErrorCode}, '
    'member=${service.memberId}, room=${service.room?.roomCode}, '
    'members=${service.room?.members.map((member) => member.id).toList()}, '
    'sharedVideo=${service.room?.sharedVideo?.videoId}, '
    'playbackSeq=${service.room?.playback?.seq}, '
    'frames=${sockets.expand((socket) => socket.frames).toList()}';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final configuredPort = int.tryParse(
    Platform.environment['SYNCPLAY_TEST_SERVER_PORT'] ?? '',
  );
  final configuredTlsPort = int.tryParse(
    Platform.environment['SYNCPLAY_TEST_TLS_PORT'] ?? '',
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
        final ownerSockets = <_TrackedSocket>[];
        final guestSockets = <_TrackedSocket>[];
        final reconnectGate = Completer<void>();
        final reconnectAttempted = Completer<void>();
        var guestSocketCalls = 0;
        Object? ownerTransportError;
        Object? guestTransportError;

        Future<SyncPlaySocket> connect(
          List<_TrackedSocket> observed,
          Uri endpoint,
          String origin,
          void Function(Object) recordError,
        ) async {
          try {
            expect(origin, 'https://syncplay-integration.test');
            final socket = _TrackedSocket(
              await _connectToPinnedServer(endpoint, origin, port),
              <String>[],
            );
            observed.add(socket);
            return socket;
          } catch (error) {
            recordError(error);
            rethrow;
          }
        }

        final owner = SyncPlayService(
          socketFactory: (endpoint, origin) => connect(
            ownerSockets,
            endpoint,
            origin,
            (error) => ownerTransportError = error,
          ),
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
            return connect(
              guestSockets,
              endpoint,
              origin,
              (error) => guestTransportError = error,
            );
          },
        );

        try {
          await owner.createRoom(_settings('Dart host'));
          expect(
            owner.status,
            SyncPlayConnectionStatus.connected,
            reason: 'Allowed Origin socket failed: $ownerTransportError',
          );
          await _waitUntil(
            'host room creation (${_serviceState(owner)})',
            () => owner.credentials != null && owner.room != null,
          );
          final invite = owner.invite;
          expect(owner.status, SyncPlayConnectionStatus.connected);
          expect(invite, isNotNull);
          expect(invite, matches(RegExp(r'^[A-Z0-9]{6}:.{16,128}$')));

          await guest.joinRoom(_settings('Dart guest'), invite!);
          expect(
            guest.status,
            SyncPlayConnectionStatus.connected,
            reason: 'Allowed Origin guest socket failed: $guestTransportError',
          );
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
            'shared video reached guest (${_serviceState(guest, sockets: guestSockets)})',
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
              onTimeout: () {},
            );
          }
          if (owner.isInRoom || owner.isConnected) {
            await owner.leaveRoom().timeout(
              const Duration(seconds: 8),
              onTimeout: () {},
            );
          }
          guest.dispose();
          owner.dispose();
        }
      },
      skip: configuredPort == null,
      timeout: const Timeout(Duration(seconds: 55)),
    );

    test(
      'upstream rejects a service connection with an unapproved Origin',
      () async {
        final port = configuredPort!;
        Object? transportError;
        final service = SyncPlayService(
          socketFactory: (endpoint, origin) async {
            expect(origin, 'https://not-allowed.integration.test');
            try {
              return await _connectToPinnedServer(endpoint, origin, port);
            } catch (error) {
              transportError = error;
              rethrow;
            }
          },
        );
        try {
          await service.createRoom(
            SyncPlayConnectionSettings(
              serverAddress: '',
              displayName: 'Origin check',
              advancedMode: true,
              advancedWebSocketUrl: 'wss://syncplay-integration.test',
              advancedOrigin: 'https://not-allowed.integration.test',
            ),
          );
          expect(
            service.status,
            SyncPlayConnectionStatus.disconnected,
            reason: 'Unapproved Origin was accepted by the upstream server.',
          );
          expect(service.credentials, isNull);
          expect(service.lastErrorCode, 'connection_failed');
          expect(transportError, isNotNull);
          expect(
            transportError.toString(),
            contains('403'),
            reason: 'Connection failed before upstream Origin validation.',
          );
        } finally {
          service.dispose();
        }
      },
      skip: configuredPort == null,
      timeout: const Timeout(Duration(seconds: 20)),
    );

    test(
      'production IO WebSocket uses normal TLS validation and pinned test trust',
      () async {
        final port = configuredTlsPort!;
        final certSha256 = Platform.environment[
          'SYNCPLAY_TEST_TLS_CERT_SHA256'
        ];
        expect(certSha256, matches(RegExp(r'^[a-f0-9]{64}$')));
        final endpoint = Uri(scheme: 'wss', host: '127.0.0.1', port: port);
        const origin = 'https://syncplay-integration.test';

        await HttpOverrides.runWithHttpOverrides(
          () async {
            final defaultChannel = IOWebSocketChannel.connect(
              endpoint,
              headers: const {'Origin': origin},
              connectTimeout: const Duration(seconds: 8),
            );
            Object? defaultTrustFailure;
            final defaultSubscription = defaultChannel.stream.listen(
              (_) {},
              onError: (Object error) => defaultTrustFailure = error,
            );
            try {
              await defaultChannel.ready.timeout(const Duration(seconds: 8));
            } catch (error) {
              defaultTrustFailure ??= error;
            } finally {
              await defaultSubscription.cancel();
            }
            expect(
              defaultTrustFailure,
              isNotNull,
              reason:
                  'The ephemeral self-signed test certificate was trusted by default.',
            );
            expect(
              defaultTrustFailure.toString().toLowerCase(),
              contains('certificate'),
              reason:
                  'Default WSS rejection was not caused by certificate validation.',
            );

            final trustedClient = HttpClient()
              ..badCertificateCallback =
                  (certificate, host, certificatePort) =>
                      host == '127.0.0.1' &&
                      certificatePort == port &&
                      crypto.sha256.convert(certificate.der).toString() ==
                          certSha256;
            final service = SyncPlayService(
              socketFactory: (uri, requestedOrigin) async {
                expect(uri, endpoint);
                expect(requestedOrigin, origin);
                final channel = IOWebSocketChannel.connect(
                  uri,
                  headers: {'Origin': requestedOrigin},
                  connectTimeout: const Duration(seconds: 8),
                  pingInterval: const Duration(seconds: 25),
                  customClient: trustedClient,
                );
                await channel.ready;
                return _LoopbackTestSocket(channel);
              },
            );

            try {
              await service.createRoom(
                SyncPlayConnectionSettings(
                  serverAddress: '',
                  displayName: 'TLS Dart client',
                  advancedMode: true,
                  advancedWebSocketUrl: endpoint.toString(),
                  advancedOrigin: origin,
                ),
              );
              expect(
                service.status,
                SyncPlayConnectionStatus.connected,
                reason:
                    'Pinned certificate WSS connection failed: ${service.lastErrorCode}',
              );
              await _waitUntil(
                'TLS client room creation (${_serviceState(service)})',
                () => service.credentials != null && service.room != null,
              );
              expect(service.room?.members, hasLength(1));
            } finally {
              if (service.isInRoom || service.isConnected) {
                await service.leaveRoom().timeout(
                  const Duration(seconds: 8),
                  onTimeout: () {},
                );
              }
              service.dispose();
              trustedClient.close(force: true);
            }
          },
          _RealHttpOverrides(),
        );
      },
      skip: configuredTlsPort == null,
      timeout: const Timeout(Duration(seconds: 30)),
    );
  });
}
