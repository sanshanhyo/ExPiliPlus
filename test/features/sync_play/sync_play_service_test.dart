import 'dart:async';
import 'dart:convert';

import 'package:ex_piliplus/features/sync_play/sync_play_player_binding.dart';
import 'package:ex_piliplus/features/sync_play/sync_play_protocol.dart';
import 'package:ex_piliplus/features/sync_play/sync_play_service.dart';
import 'package:ex_piliplus/plugin/pl_player/controller.dart'
    show PlPlayerExplicitAction;
import 'package:flutter_test/flutter_test.dart';

class _FakeSocket implements SyncPlaySocket {
  final StreamController<Object?> controller = StreamController<Object?>.broadcast();
  final List<Map<String, Object?>> sent = [];

  @override
  Stream<Object?> get stream => controller.stream;

  @override
  void send(String text) => sent.add(
    (jsonDecode(text) as Map).cast<String, Object?>(),
  );

  void emit(Map<String, Object?> message) => controller.add(jsonEncode(message));

  @override
  Future<void> close() => controller.close();
}

class _FakePlayer implements SyncPlayPlayerPort {
  _FakePlayer(this.identity);

  @override
  final Object identity;
  @override
  int positionMs = 0;
  @override
  int durationMs = 120000;
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

  final Set<void Function(Duration)> _positions = {};
  final Set<void Function()> _statuses = {};
  final Set<void Function(PlPlayerExplicitAction)> _explicitActions = {};
  int seekCount = 0;

  @override
  void addPositionListener(void Function(Duration position) listener) =>
      _positions.add(listener);

  @override
  void removePositionListener(void Function(Duration position) listener) =>
      _positions.remove(listener);

  @override
  void addStatusListener(void Function() listener) => _statuses.add(listener);

  @override
  void removeStatusListener(void Function() listener) => _statuses.remove(listener);

  @override
  void addExplicitActionListener(
    void Function(PlPlayerExplicitAction action) listener,
  ) => _explicitActions.add(listener);

  @override
  void removeExplicitActionListener(
    void Function(PlPlayerExplicitAction action) listener,
  ) => _explicitActions.remove(listener);

  @override
  Future<void> seekToMs(int milliseconds) async {
    seekCount++;
    positionMs = milliseconds;
  }

  @override
  Future<void> setPlaybackRate(double rate) async => playbackRate = rate;

  @override
  Future<void> play() async => isPlaying = true;

  @override
  Future<void> pause() async => isPlaying = false;

  void emitStatus() {
    for (final listener in _statuses.toList()) {
      listener();
    }
  }

  void emitPosition() {
    final position = Duration(milliseconds: positionMs);
    for (final listener in _positions.toList()) {
      listener(position);
    }
  }

  void emitExplicitAction(PlPlayerExplicitAction action) {
    for (final listener in _explicitActions.toList()) {
      listener(action);
    }
  }
}

const _settings = SyncPlayConnectionSettings(
  endpoint: 'wss://sync.example.test/ws',
  origin: 'https://expiliplus.example.test',
  displayName: 'Tester',
);

Future<void> _flush() => Future<void>.delayed(Duration.zero);

void main() {
  group('SyncPlay connection configuration', () {
    test('requires secure remote servers and an explicit web Origin', () {
      expect(
        SyncPlayConnectionSettings.validateEndpoint('wss://sync.example.test'),
        isNotNull,
      );
      expect(
        SyncPlayConnectionSettings.validateEndpoint('ws://localhost:8787'),
        isNotNull,
      );
      expect(
        SyncPlayConnectionSettings.validateEndpoint('ws://sync.example.test'),
        isNull,
      );
      expect(
        SyncPlayConnectionSettings.validateEndpoint('https://sync.example.test'),
        isNull,
      );
      expect(
        SyncPlayConnectionSettings.validateOrigin('https://expiliplus.example'),
        isNotNull,
      );
      expect(
        SyncPlayConnectionSettings.validateOrigin(
          'chrome-extension://extension-id',
        ),
        isNull,
      );
      expect(
        SyncPlayConnectionSettings.validateOrigin(
          'https://expiliplus.example/path',
        ),
        isNull,
      );
    });

    test('does not send Origin as a query or persist room tokens', () async {
      final socket = _FakeSocket();
      String? observedOrigin;
      final service = SyncPlayService(
        reconnectEnabled: false,
        socketFactory: (endpoint, origin) async {
          expect(endpoint.toString(), _settings.endpoint);
          observedOrigin = origin;
          return socket;
        },
      );
      addTearDown(service.dispose);

      await service.createRoom(_settings);
      expect(observedOrigin, _settings.origin);
      expect(socket.sent.single, {
        'type': 'room:create',
        'payload': {'displayName': 'Tester', 'protocolVersion': 5},
      });
      expect(socket.sent.single.toString(), isNot(contains('Cookie')));
      socket.emit({
        'type': 'room:created',
        'payload': {
          'roomCode': 'ROOM42',
          'memberId': 'member-1',
          'joinToken': 'fake-join-token-123',
          'memberToken': 'fake-member-token',
        },
      });
      await _flush();

      expect(service.invite, 'ROOM42:fake-join-token-123');
      expect(service.credentials?.memberToken, 'fake-member-token');
      expect(service.settings?.endpoint, _settings.endpoint);
    });

    test('rejects malformed room codes and undersized invite tokens', () async {
      var opened = false;
      final service = SyncPlayService(
        reconnectEnabled: false,
        socketFactory: (_, __) async {
          opened = true;
          return _FakeSocket();
        },
      );
      addTearDown(service.dispose);

      await service.joinRoom(_settings, 'room42:short');

      expect(opened, isFalse);
      expect(service.lastErrorCode, 'invalid_invite');
      expect(service.credentials, isNull);
    });

    test('joins using protocol v5 fields and keeps a token in memory for resume', () async {
      final socket = _FakeSocket();
      final service = SyncPlayService(
        reconnectEnabled: false,
        socketFactory: (_, __) async => socket,
      );
      addTearDown(service.dispose);

      await service.joinRoom(_settings, 'ROOM42:fake-join-token-123');
      expect(socket.sent.single, {
        'type': 'room:join',
        'payload': {
          'roomCode': 'ROOM42',
          'joinToken': 'fake-join-token-123',
          'displayName': 'Tester',
          'protocolVersion': 5,
        },
      });
      socket.emit({
        'type': 'room:joined',
        'payload': {
          'roomCode': 'ROOM42',
          'memberId': 'member-2',
          'memberToken': 'fake-resume-token',
        },
      });
      await _flush();

      expect(service.isInRoom, isTrue);
      expect(service.credentials?.memberToken, 'fake-resume-token');
      expect(service.invite, 'ROOM42:fake-join-token-123');
    });
  });

  test('estimates playback from local monotonic time and playbackAgeMs duration', () async {
    final socket = _FakeSocket();
    var monotonic = const Duration(seconds: 10);
    final service = SyncPlayService(
      reconnectEnabled: false,
      monotonicNow: () => monotonic,
      socketFactory: (_, __) async => socket,
    );
    addTearDown(service.dispose);
    await service.joinRoom(_settings, 'ROOM42:fake-join-token-123');
    socket.emit({
      'type': 'room:joined',
      'payload': {
        'roomCode': 'ROOM42',
        'memberId': 'local',
        'memberToken': 'fake-member-token',
      },
    });
    await _flush();
    socket.emit({
      'type': 'room:state',
      'payload': {
        'roomCode': 'ROOM42',
        'members': [
          {'id': 'local', 'name': 'Tester'},
          {'id': 'peer', 'name': 'Peer'},
        ],
        'sharedVideo': {
          'videoId': 'BV1gA411M7RN:2002',
          'url': 'https://www.bilibili.com/video/BV1gA411M7RN?cid=2002',
          'title': 'Synthetic test video',
        },
        'playback': {
          'url': 'https://www.bilibili.com/video/BV1gA411M7RN?cid=2002',
          'currentTime': 12.3,
          'playState': 'playing',
          'playbackRate': 1.5,
          'updatedAt': 9000000000000,
          'serverTime': 1,
          'actorId': 'peer',
          'seq': 8,
        },
        'playbackAgeMs': 500,
      },
    });
    await _flush();
    expect(service.estimatedRemotePositionMs(), 13050);

    monotonic += const Duration(milliseconds: 250);
    expect(service.estimatedRemotePositionMs(), 13425);
  });

  test('applies remote rate, seek, and play state through the player port', () async {
    final socket = _FakeSocket();
    var monotonic = const Duration(seconds: 2);
    final service = SyncPlayService(
      reconnectEnabled: false,
      monotonicNow: () => monotonic,
      socketFactory: (_, __) async => socket,
    );
    addTearDown(service.dispose);
    await service.joinRoom(_settings, 'ROOM42:fake-join-token-123');
    socket.emit({
      'type': 'room:joined',
      'payload': {
        'roomCode': 'ROOM42',
        'memberId': 'local',
        'memberToken': 'fake-member-token',
      },
    });
    await _flush();
    socket.emit({
      'type': 'room:state',
      'payload': {
        'roomCode': 'ROOM42',
        'members': [],
        'sharedVideo': {
          'videoId': 'BV1gA411M7RN:2002',
          'url': 'https://www.bilibili.com/video/BV1gA411M7RN?cid=2002',
          'title': 'Synthetic test video',
        },
        'playback': {
          'url': 'https://www.bilibili.com/video/BV1gA411M7RN?cid=2002',
          'currentTime': 12,
          'playState': 'playing',
          'playbackRate': 1.5,
          'updatedAt': 123,
          'serverTime': 456,
          'actorId': 'peer',
          'seq': 3,
          'syncIntent': 'explicit-seek',
          'userInitiated': true,
        },
        'playbackAgeMs': 400,
      },
    });
    await _flush();
    final video = service.room!.sharedVideo!.videoRef!;
    final player = _FakePlayer(Object());
    service.attachIfShared(
      video: video,
      title: 'Synthetic test video',
      player: player,
    );
    await Future<void>.delayed(const Duration(milliseconds: 10));

    expect(player.playbackRate, 1.5);
    expect(player.positionMs, 12600);
    expect(player.seekCount, 1);
    expect(player.isPlaying, isTrue);

    final sendsAfterRemoteApply = socket.sent.length;
    monotonic += const Duration(seconds: 3);
    player.emitPosition();
    expect(socket.sent.length, sendsAfterRemoteApply);

    player.emitExplicitAction(PlPlayerExplicitAction.playback);
    expect(socket.sent.last['type'], 'playback:update');
    expect(socket.sent.length, sendsAfterRemoteApply + 1);
  });

  test('attaches a pN room identity only to its confirmed local page', () async {
    final socket = _FakeSocket();
    final service = SyncPlayService(
      reconnectEnabled: false,
      socketFactory: (_, __) async => socket,
    );
    addTearDown(service.dispose);
    await service.joinRoom(_settings, 'ROOM42:fake-join-token-123');
    socket.emit({
      'type': 'room:joined',
      'payload': {
        'roomCode': 'ROOM42',
        'memberId': 'local',
        'memberToken': 'fake-member-token',
      },
    });
    await _flush();
    socket.emit({
      'type': 'room:state',
      'payload': {
        'roomCode': 'ROOM42',
        'members': [],
        'sharedVideo': {
          'videoId': 'BV1gA411M7RN:p2',
          'url': 'https://www.bilibili.com/video/BV1gA411M7RN?p=2',
          'title': 'Page two',
        },
        'playback': {
          'url': 'https://www.bilibili.com/video/BV1gA411M7RN?p=2',
          'currentTime': 12,
          'playState': 'playing',
          'playbackRate': 1,
          'updatedAt': 123,
          'serverTime': 456,
          'actorId': 'peer',
          'seq': 3,
        },
      },
    });
    await _flush();

    final localPage = SyncPlayVideoRef.fromPlayer(
      bvid: 'BV1gA411M7RN',
      cid: 2002,
    );
    final wrongPagePlayer = _FakePlayer(Object());
    service.attachIfShared(
      video: localPage,
      title: 'Page two',
      player: wrongPagePlayer,
      currentPart: () => 1,
    );
    wrongPagePlayer.emitExplicitAction(PlPlayerExplicitAction.playback);
    expect(wrongPagePlayer.seekCount, 0);
    expect(socket.sent.where((message) => message['type'] == 'playback:update'), isEmpty);

    final pageTwoPlayer = _FakePlayer(Object());
    service.attachIfShared(
      video: localPage,
      title: 'Page two',
      player: pageTwoPlayer,
      currentVideoId: () => 'BV1gA411M7RN:2002',
      currentPart: () => 2,
    );
    await Future<void>.delayed(const Duration(milliseconds: 10));
    expect(pageTwoPlayer.seekCount, 1);
    expect(pageTwoPlayer.positionMs, 12000);

    pageTwoPlayer.emitExplicitAction(PlPlayerExplicitAction.playback);
    final playback =
        ((socket.sent.last['payload']! as Map)['playback'] as Map)
            .cast<String, Object?>();
    expect(socket.sent.last['type'], 'playback:update');
    expect(playback['url'], 'https://www.bilibili.com/video/BV1gA411M7RN?p=2');
  });

  test('shares a video using public identifiers, not account credentials', () async {
    final socket = _FakeSocket();
    final service = SyncPlayService(
      reconnectEnabled: false,
      socketFactory: (_, __) async => socket,
    );
    addTearDown(service.dispose);
    await service.createRoom(_settings);
    socket.emit({
      'type': 'room:created',
      'payload': {
        'roomCode': 'ROOM42',
        'memberId': 'local',
        'joinToken': 'fake-join-token-123',
        'memberToken': 'fake-member-token',
      },
    });
    await _flush();
    final player = _FakePlayer(Object())..positionMs = 45000;
    final video = SyncPlayVideoRef.fromPlayer(
      bvid: 'BV1gA411M7RN',
      cid: 2002,
    );

    expect(
      await service.shareCurrentVideo(
        video: video,
        title: 'Synthetic title',
        player: player,
      ),
      isTrue,
    );
    final sent = socket.sent.last;
    expect(sent['type'], 'video:share');
    final payload = sent['payload']! as Map<String, Object?>;
    expect(payload['memberToken'], 'fake-member-token');
    expect(payload['video'], {
      'videoId': 'BV1gA411M7RN:2002',
      'url': 'https://www.bilibili.com/video/BV1gA411M7RN?cid=2002',
      'title': 'Synthetic title',
      'sharedByMemberId': 'local',
      'sharedByDisplayName': 'Tester',
    });
    final serialized = jsonEncode(payload);
    expect(serialized, isNot(contains('DedeUserID')));
    expect(serialized, isNot(contains('accessKey')));
    expect(serialized, isNot(contains('cookie')));
    expect(serialized, isNot(contains('http://cdn')));

    player.isPlaying = true;
    player.emitStatus();
    await _flush();
    expect(socket.sent.last['type'], 'video:share');

    player.emitExplicitAction(PlPlayerExplicitAction.playback);
    await _flush();
    expect(socket.sent.last['type'], 'playback:update');
    final playback =
        ((socket.sent.last['payload']! as Map)['playback'] as Map)
            .cast<String, Object?>();
    expect(playback['currentTime'], 45.0);
    expect(playback['userInitiated'], isTrue);

    player
      ..isPlaying = false
      ..positionMs = 60000
      ..emitExplicitAction(PlPlayerExplicitAction.seek);
    final pausedSeek =
        ((socket.sent.last['payload']! as Map)['playback'] as Map)
            .cast<String, Object?>();
    expect(socket.sent.last['type'], 'playback:update');
    expect(pausedSeek['playState'], 'paused');
    expect(pausedSeek['currentTime'], 60.0);
    expect(pausedSeek['syncIntent'], 'explicit-seek');

    await service.leaveRoom();
    expect(service.credentials, isNull);
    expect(socket.sent.last['type'], 'room:leave');
  });

  test(
    'does not broadcast passive changes or transient long-press speed',
    () async {
      final socket = _FakeSocket();
      var monotonic = Duration.zero;
      final service = SyncPlayService(
        reconnectEnabled: false,
        monotonicNow: () => monotonic,
        socketFactory: (_, __) async => socket,
      );
      addTearDown(service.dispose);
      await service.createRoom(_settings);
      socket.emit({
        'type': 'room:created',
        'payload': {
          'roomCode': 'ROOM42',
          'memberId': 'local',
          'joinToken': 'fake-join-token-123',
          'memberToken': 'fake-member-token',
        },
      });
      await _flush();
      final player = _FakePlayer(Object());
      await service.shareCurrentVideo(
        video: SyncPlayVideoRef.fromPlayer(
          bvid: 'BV1gA411M7RN',
          cid: 2002,
        ),
        title: 'Synthetic title',
        player: player,
      );

      player.isPlaying = true;
      player.emitStatus();
      player.isTransientSpeed = true;
      player.playbackRate = 2;
      player.emitExplicitAction(PlPlayerExplicitAction.playbackRate);
      await _flush();
      expect(socket.sent.last['type'], 'video:share');

      player.isTransientSpeed = false;
      player.playbackRate = 1;
      player.emitExplicitAction(PlPlayerExplicitAction.playbackRate);
      await _flush();
      expect(socket.sent.last['type'], 'playback:update');
      final playback =
          ((socket.sent.last['payload']! as Map)['playback'] as Map)
              .cast<String, Object?>();
      expect(playback['playbackRate'], 1.0);
      expect(playback['syncIntent'], 'explicit-ratechange');

      final sentBeforeBackground = socket.sent.length;
      service.setPlayerAppForeground(false);
      player.emitExplicitAction(PlPlayerExplicitAction.playback);
      expect(socket.sent.length, sentBeforeBackground);

      service.setPlayerAppForeground(true);
      monotonic += const Duration(seconds: 1);
      player.emitExplicitAction(PlPlayerExplicitAction.playback);
      expect(socket.sent.length, sentBeforeBackground + 1);

      service.detachPlayer(player.identity);
      player.emitExplicitAction(PlPlayerExplicitAction.playback);
      expect(socket.sent.length, sentBeforeBackground + 1);
    },
  );

  test('reconnects with the in-memory member token after a socket closes', () async {
    final sockets = <_FakeSocket>[];
    final secondSocketOpened = Completer<void>();
    final service = SyncPlayService(
      reconnectDelay: (_) => Duration.zero,
      socketFactory: (_, __) async {
        final socket = _FakeSocket();
        sockets.add(socket);
        if (sockets.length == 2) secondSocketOpened.complete();
        return socket;
      },
    );
    addTearDown(service.dispose);

    await service.joinRoom(_settings, 'ROOM42:fake-join-token-123');
    sockets.first.emit({
      'type': 'room:joined',
      'payload': {
        'roomCode': 'ROOM42',
        'memberId': 'local',
        'memberToken': 'fake-member-token',
      },
    });
    await _flush();
    await sockets.first.controller.close();
    await secondSocketOpened.future.timeout(const Duration(seconds: 1));

    expect(service.status, SyncPlayConnectionStatus.connected);
    expect(sockets[1].sent.single, {
      'type': 'room:join',
      'payload': {
        'roomCode': 'ROOM42',
        'joinToken': 'fake-join-token-123',
        'memberToken': 'fake-member-token',
        'displayName': 'Tester',
        'protocolVersion': 5,
      },
    });
    expect(service.credentials?.memberToken, 'fake-member-token');
  });
}
