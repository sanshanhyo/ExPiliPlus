import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:web_socket_channel/io.dart';

import 'sync_play_player_binding.dart';
import 'sync_play_protocol.dart';

bool _isRoomCode(Object? value) =>
    value is String && RegExp(r'^[A-Z0-9]{6}$').hasMatch(value);

bool _isToken(Object? value) =>
    value is String && value.length >= 16 && value.length <= 128;

bool _isActorId(Object? value) =>
    value is String && RegExp(r'^[A-Za-z0-9](?:[A-Za-z0-9:_-]{0,63})$').hasMatch(value);

abstract interface class SyncPlaySocket {
  Stream<Object?> get stream;
  void send(String text);
  Future<void> close();
}

typedef SyncPlaySocketFactory = Future<SyncPlaySocket> Function(
  Uri endpoint,
  String origin,
);

class IoSyncPlaySocket implements SyncPlaySocket {
  IoSyncPlaySocket._(this._channel);

  final IOWebSocketChannel _channel;

  static Future<SyncPlaySocket> connect(Uri endpoint, String origin) async {
    final channel = IOWebSocketChannel.connect(
      endpoint,
      headers: {'Origin': origin},
      connectTimeout: const Duration(seconds: 12),
      pingInterval: const Duration(seconds: 25),
    );
    await channel.ready;
    return IoSyncPlaySocket._(channel);
  }

  @override
  Stream<Object?> get stream => _channel.stream;

  @override
  void send(String text) => _channel.sink.add(text);

  @override
  Future<void> close() async {
    await _channel.sink.close();
  }
}

enum SyncPlayConnectionStatus {
  disconnected,
  connecting,
  connected,
  reconnecting,
}

class SyncPlayServerAddress {
  const SyncPlayServerAddress._({required this.endpoint, required this.origin});

  final Uri endpoint;
  final Uri origin;

  /// Accepts a host (optionally with a scheme, port and WebSocket path) and
  /// derives both values from the same authority. Public plaintext endpoints
  /// are rejected; the request Origin is never user-supplied.
  static SyncPlayServerAddress? tryParse(String raw) {
    final value = raw.trim();
    if (value.isEmpty || value.contains(RegExp(r'\s'))) return null;

    final hasAuthorityScheme = RegExp(
      r'^[a-z][a-z0-9+.-]*://',
      caseSensitive: false,
    ).hasMatch(value);
    final hasBareHostAndPort = RegExp(
      r'^[a-z0-9.-]+:\d+(?:/.*)?$',
      caseSensitive: false,
    ).hasMatch(value);
    final hasMalformedScheme = RegExp(
      r'^[a-z][a-z0-9+.-]*:',
      caseSensitive: false,
    ).hasMatch(value);
    if (!hasAuthorityScheme && hasMalformedScheme && !hasBareHostAndPort) {
      return null;
    }

    final input = hasAuthorityScheme ? value : 'wss://$value';
    final uri = Uri.tryParse(input);
    if (uri == null ||
        !uri.hasAuthority ||
        !const {'https', 'wss'}.contains(uri.scheme.toLowerCase()) ||
        uri.host.isEmpty ||
        uri.userInfo.isNotEmpty ||
        uri.hasQuery ||
        uri.hasFragment) {
      return null;
    }

    try {
      if (uri.hasPort && (uri.port < 1 || uri.port > 65535)) return null;
      final host = uri.host.toLowerCase();
      final endpoint = uri.replace(scheme: 'wss', host: host);
      final origin = Uri(
        scheme: 'https',
        host: host,
        port: uri.hasPort ? uri.port : null,
      );
      return SyncPlayServerAddress._(endpoint: endpoint, origin: origin);
    } on FormatException {
      return null;
    }
  }
}

class SyncPlayConnectionSettings {
  const SyncPlayConnectionSettings({
    required this.serverAddress,
    required this.displayName,
  });

  final String serverAddress;
  final String displayName;

  String get endpoint =>
      SyncPlayServerAddress.tryParse(serverAddress)?.endpoint.toString() ?? '';
  String get origin =>
      SyncPlayServerAddress.tryParse(serverAddress)?.origin.toString() ?? '';

  static String? validateDisplayName(String raw) {
    final value = raw.trim();
    if (value.isEmpty || value.length > 32) return null;
    return value;
  }
}

class SyncPlayRoomCredentials {
  const SyncPlayRoomCredentials({
    required this.roomCode,
    required this.joinToken,
    this.memberToken,
  });

  final String roomCode;
  final String joinToken;
  final String? memberToken;

  String get invite => '$roomCode:$joinToken';

  SyncPlayRoomCredentials copyWith({String? memberToken}) =>
      SyncPlayRoomCredentials(
        roomCode: roomCode,
        joinToken: joinToken,
        memberToken: memberToken ?? this.memberToken,
      );
}

class SyncPlayService extends ChangeNotifier with WidgetsBindingObserver {
  SyncPlayService({
    SyncPlaySocketFactory? socketFactory,
    Duration Function()? monotonicNow,
    Duration Function(int attempt)? reconnectDelay,
    bool reconnectEnabled = true,
  }) : _socketFactory = socketFactory ?? IoSyncPlaySocket.connect,
       _reconnectDelay = reconnectDelay ?? _defaultReconnectDelay,
       _reconnectEnabled = reconnectEnabled {
    _monotonicNow = monotonicNow ?? (() => _watch.elapsed);
    _watch.start();
    WidgetsBinding.instance.addObserver(this);
  }

  final SyncPlaySocketFactory _socketFactory;
  final Duration Function(int attempt) _reconnectDelay;
  late final Duration Function() _monotonicNow;
  final bool _reconnectEnabled;
  final Stopwatch _watch = Stopwatch();

  SyncPlayConnectionStatus status = SyncPlayConnectionStatus.disconnected;
  SyncPlayConnectionSettings? settings;
  SyncPlayRoomCredentials? credentials;
  String? memberId;
  String? lastErrorCode;
  SyncPlayRoomSnapshot? room;

  SyncPlaySocket? _socket;
  StreamSubscription<Object?>? _subscription;
  Timer? _reconnectTimer;
  int _reconnectAttempt = 0;
  int _playbackSequence = 0;
  Duration _roomSnapshotReceivedAt = Duration.zero;
  bool _disposed = false;
  bool _intentionalClose = false;
  bool _createOnConnect = false;
  String? _pendingInvite;
  SyncPlayPlayerBinding? _playerBinding;

  bool get isConnected => status == SyncPlayConnectionStatus.connected;
  bool get isInRoom => credentials != null && memberId != null;
  String? get invite => credentials?.invite;

  static Duration _defaultReconnectDelay(int attempt) {
    final safeAttempt = attempt.clamp(0, 5).toInt();
    return Duration(seconds: (1 << safeAttempt).clamp(1, 30).toInt());
  }

  Future<void> createRoom(SyncPlayConnectionSettings value) async {
    final parsed = _validateSettings(value);
    if (parsed == null) return;
    await _resetConnection(clearCredentials: true);
    settings = parsed;
    _createOnConnect = true;
    _pendingInvite = null;
    lastErrorCode = null;
    status = SyncPlayConnectionStatus.connecting;
    notifyListeners();
    await _openSocket();
  }

  Future<void> joinRoom(
    SyncPlayConnectionSettings value,
    String inviteText,
  ) async {
    final parsed = _validateSettings(value);
    final invite = _parseInvite(inviteText);
    if (parsed == null) return;
    if (invite == null) {
      lastErrorCode = 'invalid_invite';
      notifyListeners();
      return;
    }
    await _resetConnection(clearCredentials: true);
    settings = parsed;
    _pendingInvite = invite.invite;
    _createOnConnect = false;
    lastErrorCode = null;
    status = SyncPlayConnectionStatus.connecting;
    notifyListeners();
    await _openSocket();
  }

  SyncPlayConnectionSettings? _validateSettings(
    SyncPlayConnectionSettings value,
  ) {
    final address = SyncPlayServerAddress.tryParse(value.serverAddress);
    final name = SyncPlayConnectionSettings.validateDisplayName(
      value.displayName,
    );
    if (address == null) {
      lastErrorCode = 'invalid_server';
      notifyListeners();
      return null;
    }
    if (name == null) {
      lastErrorCode = 'invalid_display_name';
      notifyListeners();
      return null;
    }
    return SyncPlayConnectionSettings(
      serverAddress: address.endpoint.toString(),
      displayName: name,
    );
  }

  static SyncPlayRoomCredentials? _parseInvite(String raw) {
    final parts = raw.trim().split(':');
    if (parts.length != 2 ||
        !_isRoomCode(parts[0].trim()) ||
        !_isToken(parts[1].trim())) {
      return null;
    }
    return SyncPlayRoomCredentials(
      roomCode: parts[0].trim(),
      joinToken: parts[1].trim(),
    );
  }

  Future<void> _openSocket() async {
    final config = settings;
    if (config == null || _disposed) return;
    try {
      final socket = await _socketFactory(
        Uri.parse(config.endpoint),
        config.origin,
      );
      if (_disposed) {
        await socket.close();
        return;
      }
      _socket = socket;
      _intentionalClose = false;
      status = SyncPlayConnectionStatus.connected;
      lastErrorCode = null;
      _subscription = socket.stream.listen(
        _handleFrame,
        onError: (Object _) => _handleSocketClosed(socket),
        onDone: () => _handleSocketClosed(socket),
        cancelOnError: true,
      );
      final currentCredentials = credentials;
      if (currentCredentials != null) {
        _sendJoin(currentCredentials);
      } else if (_pendingInvite != null) {
        _sendJoin(_parseInvite(_pendingInvite!)!);
      } else if (_createOnConnect) {
        _send({
          'type': 'room:create',
          'payload': {
            'displayName': config.displayName,
            'protocolVersion': syncPlayProtocolVersion,
          },
        });
      }
      notifyListeners();
    } catch (_) {
      status = credentials != null && _reconnectEnabled
          ? SyncPlayConnectionStatus.reconnecting
          : SyncPlayConnectionStatus.disconnected;
      lastErrorCode = 'connection_failed';
      notifyListeners();
      if (credentials != null) _scheduleReconnect();
    }
  }

  void _sendJoin(SyncPlayRoomCredentials value) {
    final config = settings;
    if (config == null) return;
    _send({
      'type': 'room:join',
      'payload': {
        'roomCode': value.roomCode,
        'joinToken': value.joinToken,
        if (value.memberToken != null) 'memberToken': value.memberToken,
        'displayName': config.displayName,
        'protocolVersion': syncPlayProtocolVersion,
      },
    });
  }

  void _send(Map<String, Object?> message) {
    try {
      _socket?.send(jsonEncode(message));
    } catch (_) {
      lastErrorCode = 'connection_failed';
      notifyListeners();
    }
  }

  void _handleFrame(Object? raw) {
    if (_disposed) return;
    final message = decodeSyncPlayMessage(raw);
    if (message == null || message['type'] is! String) {
      lastErrorCode = 'invalid_server_message';
      notifyListeners();
      return;
    }
    final payload = message['payload'];
    if (payload is! Map) return;
    switch (message['type']) {
      case 'room:created':
        final code = payload['roomCode'];
        final joinToken = payload['joinToken'];
        final token = payload['memberToken'];
        final id = payload['memberId'];
        if (!_isRoomCode(code) ||
            !_isToken(joinToken) ||
            !_isToken(token) ||
            !_isActorId(id)) {
          lastErrorCode = 'invalid_server_message';
          break;
        }
        credentials = SyncPlayRoomCredentials(
          roomCode: code,
          joinToken: joinToken,
          memberToken: token,
        );
        memberId = id;
        _createOnConnect = false;
        _pendingInvite = null;
        _reconnectAttempt = 0;
        break;
      case 'room:joined':
        final code = payload['roomCode'];
        final token = payload['memberToken'];
        final id = payload['memberId'];
        final pending = credentials ??
            (_pendingInvite == null ? null : _parseInvite(_pendingInvite!));
        if (!_isRoomCode(code) ||
            !_isToken(token) ||
            !_isActorId(id) ||
            code != pending?.roomCode ||
            pending == null) {
          lastErrorCode = 'invalid_server_message';
          break;
        }
        credentials = SyncPlayRoomCredentials(
          roomCode: code,
          joinToken: pending.joinToken,
          memberToken: token,
        );
        memberId = id;
        _pendingInvite = null;
        _reconnectAttempt = 0;
        break;
      case 'room:state':
        final snapshot = SyncPlayRoomSnapshot.tryParse(payload);
        if (snapshot == null ||
            (credentials != null && snapshot.roomCode != credentials!.roomCode)) {
          lastErrorCode = 'invalid_server_message';
          break;
        }
        room = snapshot;
        _roomSnapshotReceivedAt = _monotonicNow();
        break;
      case 'room:member-joined':
        final current = room;
        final member = SyncPlayMember.tryParse(payload['member']);
        if (current != null &&
            member != null &&
            payload['roomCode'] == current.roomCode) {
          final members = [...current.members]
            ..removeWhere((item) => item.id == member.id)
            ..add(member);
          room = SyncPlayRoomSnapshot(
            roomCode: current.roomCode,
            members: List.unmodifiable(members),
            sharedVideo: current.sharedVideo,
            playback: current.playback,
            playbackAgeMs: current.playbackAgeMs,
          );
        }
        break;
      case 'room:member-left':
        final current = room;
        final member = SyncPlayMember.tryParse(payload['member']);
        if (current != null &&
            member != null &&
            payload['roomCode'] == current.roomCode) {
          room = SyncPlayRoomSnapshot(
            roomCode: current.roomCode,
            members: List.unmodifiable(
              current.members.where((item) => item.id != member.id),
            ),
            sharedVideo: current.sharedVideo,
            playback: current.playback,
            playbackAgeMs: current.playbackAgeMs,
          );
        }
        break;
      case 'error':
        final code = payload['code'];
        lastErrorCode = code is String ? code : 'server_error';
        if (lastErrorCode == 'member_token_invalid') {
          final current = credentials;
          if (current != null && current.memberToken != null) {
            final retry = SyncPlayRoomCredentials(
              roomCode: current.roomCode,
              joinToken: current.joinToken,
            );
            credentials = retry;
            _sendJoin(retry);
          }
        }
        break;
      case 'sync:pong':
      case 'server:announcement':
        // Clock offset is diagnostic only. playbackAgeMs is the duration used
        // for position extrapolation; server and device wall clocks are never
        // subtracted from one another.
        break;
      default:
        // Protocol v5 clients must tolerate additive server messages.
        break;
    }
    _playerBinding?.onServiceChanged();
    notifyListeners();
  }

  void _handleSocketClosed(SyncPlaySocket closedSocket) {
    if (!identical(_socket, closedSocket)) return;
    _subscription = null;
    _socket = null;
    if (_intentionalClose || _disposed) return;
    _playerBinding?.resetRemotePlaybackDeduplication();
    if (credentials == null || !_reconnectEnabled) {
      status = SyncPlayConnectionStatus.disconnected;
      lastErrorCode = 'connection_lost';
      notifyListeners();
      return;
    }
    status = SyncPlayConnectionStatus.reconnecting;
    notifyListeners();
    _scheduleReconnect();
  }

  void _scheduleReconnect() {
    if (!_reconnectEnabled || _disposed) return;
    _reconnectTimer?.cancel();
    final attempt = _reconnectAttempt++;
    _reconnectTimer = Timer(_reconnectDelay(attempt), _openSocket);
  }

  int estimatedRemotePositionMs() {
    final playback = room?.playback;
    if (playback == null) return 0;
    var age = room?.playbackAgeMs ?? 0;
    if (age < 0 || age > 30000) age = 0;
    var elapsed = (_monotonicNow() - _roomSnapshotReceivedAt).inMilliseconds;
    if (elapsed < 0 || elapsed > 30000) elapsed = 0;
    final running = playback.state == SyncPlayPlaybackState.playing
        ? ((age + elapsed) * playback.playbackRate).round()
        : 0;
    final value = (playback.currentTimeSeconds * 1000).round() + running;
    return value.clamp(0, 24 * 60 * 60 * 1000).toInt();
  }

  Future<bool> shareCurrentVideo({
    required SyncPlayVideoRef video,
    required String title,
    required SyncPlayPlayerPort player,
    String Function()? currentVideoId,
  }) async {
    final token = credentials?.memberToken;
    final id = memberId;
    if (token == null || id == null || _socket == null) return false;
    final shared = SyncPlaySharedVideo(
      videoId: video.videoId,
      url: video.url,
      title: title.trim().isEmpty ? video.bvid : title.trim(),
      sharedByMemberId: id,
      sharedByDisplayName: settings?.displayName,
    );
    room = SyncPlayRoomSnapshot(
      roomCode: credentials!.roomCode,
      members: room?.members ?? const [],
      sharedVideo: shared,
      playback: null,
    );
    _playerBinding?.dispose();
    _playerBinding = SyncPlayPlayerBinding(
      service: this,
      player: player,
      video: shared,
      monotonicNow: _monotonicNow,
      currentVideoId: currentVideoId,
      localPlaybackAuthority: true,
    )..start();
    final initial = _playerBinding!.buildPlayback(userInitiated: false);
    _send({
      'type': 'video:share',
      'payload': {
        'memberToken': token,
        'video': shared.toJson(),
        'playback': initial.toJson(),
      },
    });
    room = SyncPlayRoomSnapshot(
      roomCode: credentials!.roomCode,
      members: room!.members,
      sharedVideo: shared,
      playback: initial,
    );
    notifyListeners();
    return true;
  }

  void attachIfShared({
    required SyncPlayVideoRef video,
    required String title,
    required SyncPlayPlayerPort player,
    String Function()? currentVideoId,
    int? Function()? currentPart,
  }) {
    final shared = room?.sharedVideo;
    final sharedRef = shared?.videoRef;
    if (credentials == null ||
        shared == null ||
        sharedRef == null ||
        !sharedRef.matchesLocalPage(video, localPage: currentPart?.call())) {
      return;
    }
    if (_playerBinding?.matchesPlayer(player) == true) return;
    _playerBinding?.dispose();
    String effectiveVideoId() {
      final actualId = currentVideoId?.call() ?? video.videoId;
      if (sharedRef.videoId == video.videoId ||
          actualId == sharedRef.videoId) {
        return actualId;
      }
      final partMatches = sharedRef.matchesLocalPage(
        video,
        localPage: currentPart?.call(),
      );
      if (partMatches && actualId.startsWith('${sharedRef.bvid}:')) {
        return sharedRef.videoId;
      }
      return actualId;
    }
    _playerBinding = SyncPlayPlayerBinding(
      service: this,
      player: player,
      video: SyncPlaySharedVideo(
        videoId: shared.videoId,
        url: shared.url,
        title: shared.title.isEmpty ? title : shared.title,
        sharedByMemberId: shared.sharedByMemberId,
        sharedByDisplayName: shared.sharedByDisplayName,
      ),
      monotonicNow: _monotonicNow,
      currentVideoId: effectiveVideoId,
      localPlaybackAuthority: room?.playback?.actorId == memberId,
    )..start(applyCurrentRemoteState: true);
  }

  void detachPlayer(Object playerIdentity) {
    if (_playerBinding?.matchesIdentity(playerIdentity) == true) {
      _playerBinding?.dispose();
      _playerBinding = null;
    }
  }

  void setPlayerAppForeground(bool isForeground) {
    if (isForeground) {
      _playerBinding?.resumeSampling();
    } else {
      _playerBinding?.pauseSampling();
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    setPlayerAppForeground(state == AppLifecycleState.resumed);
  }

  void clearPlayerBinding(SyncPlayPlayerBinding binding) {
    if (identical(_playerBinding, binding)) _playerBinding = null;
  }

  void sendPlayback(SyncPlayPlayback playback) {
    final token = credentials?.memberToken;
    if (token == null || _socket == null) return;
    if (playback.seq > _playbackSequence) _playbackSequence = playback.seq;
    room = SyncPlayRoomSnapshot(
      roomCode: room?.roomCode ?? credentials!.roomCode,
      members: room?.members ?? const [],
      sharedVideo: room?.sharedVideo,
      playback: playback,
    );
    _send({
      'type': 'playback:update',
      'payload': {'memberToken': token, 'playback': playback.toJson()},
    });
    notifyListeners();
  }

  int nextPlaybackSequence() => ++_playbackSequence;

  Future<void> leaveRoom() async {
    final token = credentials?.memberToken;
    if (token != null && _socket != null) {
      _send({'type': 'room:leave', 'payload': {'memberToken': token}});
    }
    _playerBinding?.dispose();
    _playerBinding = null;
    room = null;
    credentials = null;
    memberId = null;
    _pendingInvite = null;
    _createOnConnect = false;
    _reconnectTimer?.cancel();
    await _resetConnection(clearCredentials: false);
    status = SyncPlayConnectionStatus.disconnected;
    lastErrorCode = null;
    notifyListeners();
  }

  Future<void> _resetConnection({required bool clearCredentials}) async {
    _intentionalClose = true;
    _reconnectTimer?.cancel();
    await _subscription?.cancel();
    await _socket?.close();
    _subscription = null;
    _socket = null;
    _intentionalClose = false;
    if (clearCredentials) {
      _playerBinding?.dispose();
      _playerBinding = null;
      room = null;
      credentials = null;
      memberId = null;
    }
  }

  @override
  void dispose() {
    _disposed = true;
    WidgetsBinding.instance.removeObserver(this);
    _reconnectTimer?.cancel();
    _playerBinding?.dispose();
    unawaited(_resetConnection(clearCredentials: true));
    super.dispose();
  }
}
