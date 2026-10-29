import 'dart:convert';

const int syncPlayProtocolVersion = 5;

bool _isActorId(Object? value) =>
    value is String &&
    RegExp(r'^[A-Za-z0-9](?:[A-Za-z0-9:_-]{0,63})$').hasMatch(value);

enum SyncPlayPlaybackState { playing, paused, buffering }

class SyncPlayVideoRef {
  const SyncPlayVideoRef({
    required this.bvid,
    required this.videoId,
    required this.url,
    this.cid,
    this.part,
  });

  final String bvid;
  final int? cid;
  final int? part;
  final String videoId;
  final String url;

  /// Whether this protocol identity names the currently selected local page.
  ///
  /// SyncPlay deliberately keeps `bvid:pN`, `bvid:cid`, and bare `bvid`
  /// distinct on the wire. A local player exposes a CID instead of the
  /// protocol page identity, so only map a page URL when the app's video
  /// metadata confirms the exact page number. A bare BVID maps only to page 1.
  bool matchesLocalPage(SyncPlayVideoRef local, {required int? localPage}) {
    if (videoId == local.videoId) return true;
    if (bvid != local.bvid || cid != null || localPage == null) return false;
    return part == null ? localPage == 1 : part == localPage;
  }

  static final RegExp _bvidPattern = RegExp(r'^BV[0-9A-Za-z]+$');

  factory SyncPlayVideoRef.fromPlayer({
    required String bvid,
    required int cid,
    int? part,
  }) {
    if (!_bvidPattern.hasMatch(bvid) || cid <= 0) {
      throw const FormatException('Unsupported Bilibili video reference');
    }
    return SyncPlayVideoRef(
      bvid: bvid,
      cid: cid,
      part: part,
      videoId: '$bvid:$cid',
      url: Uri.https('www.bilibili.com', '/video/$bvid', {
        'cid': '$cid',
      }).toString(),
    );
  }

  static SyncPlayVideoRef? parse(String rawUrl, {String? expectedVideoId}) {
    final uri = Uri.tryParse(rawUrl);
    if (uri == null ||
        !const {'http', 'https'}.contains(uri.scheme.toLowerCase()) ||
        uri.host.toLowerCase() != 'www.bilibili.com' ||
        uri.userInfo.isNotEmpty ||
        uri.hasFragment) {
      return null;
    }
    final match = RegExp(r'^/video/(BV[0-9A-Za-z]{10})/?$').firstMatch(
      uri.path,
    );
    if (match == null) return null;
    final bvid = match.group(1)!;
    final cidValue = int.tryParse(uri.queryParameters['cid'] ?? '');
    final partValue = int.tryParse(uri.queryParameters['p'] ?? '');
    if (uri.queryParameters.containsKey('cid') &&
        (cidValue == null || cidValue <= 0)) {
      return null;
    }
    if (cidValue == null &&
        uri.queryParameters.containsKey('p') &&
        (partValue == null || partValue <= 0)) {
      return null;
    }

    final videoId = cidValue != null
        ? '$bvid:$cidValue'
        : partValue != null
        ? '$bvid:p$partValue'
        : bvid;
    if (expectedVideoId != null && expectedVideoId != videoId) return null;
    return SyncPlayVideoRef(
      bvid: bvid,
      cid: cidValue,
      part: partValue,
      videoId: videoId,
      url: cidValue != null
          ? Uri.https('www.bilibili.com', '/video/$bvid', {
              'cid': '$cidValue',
            }).toString()
          : partValue != null
          ? Uri.https('www.bilibili.com', '/video/$bvid', {
              'p': '$partValue',
            }).toString()
          : Uri.https('www.bilibili.com', '/video/$bvid').toString(),
    );
  }
}

class SyncPlayMember {
  const SyncPlayMember({required this.id, required this.name});

  final String id;
  final String name;

  static SyncPlayMember? tryParse(Object? value) {
    if (value is! Map) return null;
    final id = value['id'];
    final name = value['name'];
    if (id is! String ||
        name is! String ||
        !RegExp(r'^[A-Za-z0-9](?:[A-Za-z0-9:_-]{0,63})$').hasMatch(id) ||
        name.length > 32) {
      return null;
    }
    return SyncPlayMember(id: id, name: name);
  }
}

class SyncPlaySharedVideo {
  const SyncPlaySharedVideo({
    required this.videoId,
    required this.url,
    required this.title,
    this.sharedByMemberId,
    this.sharedByDisplayName,
  });

  final String videoId;
  final String url;
  final String title;
  final String? sharedByMemberId;
  final String? sharedByDisplayName;

  SyncPlayVideoRef? get videoRef =>
      SyncPlayVideoRef.parse(url, expectedVideoId: videoId);

  Map<String, Object?> toJson() => {
    'videoId': videoId,
    'url': url,
    'title': title,
    if (sharedByMemberId != null) 'sharedByMemberId': sharedByMemberId,
    if (sharedByDisplayName != null)
      'sharedByDisplayName': sharedByDisplayName,
  };

  /// Fields accepted from a client in `video:share`.
  ///
  /// The server assigns the sharing member from the authenticated socket, so
  /// client-supplied owner metadata is unnecessary and can be rejected by
  /// upstream guards before it reaches the handler.
  Map<String, Object?> toShareRequestJson() => {
    'videoId': videoId,
    'url': url,
    'title': title,
  };

  static SyncPlaySharedVideo? tryParse(Object? value) {
    if (value is! Map) return null;
    final videoId = value['videoId'];
    final url = value['url'];
    final title = value['title'];
    final sharedByMemberId = value['sharedByMemberId'];
    final sharedByDisplayName = value['sharedByDisplayName'];
    if (videoId is! String ||
        url is! String ||
        title is! String ||
        videoId.length > 128 ||
        url.length > 512 ||
        title.length > 128 ||
        (sharedByMemberId != null && !_isActorId(sharedByMemberId)) ||
        (sharedByDisplayName != null &&
            (sharedByDisplayName is! String ||
                sharedByDisplayName.length > 32))) {
      return null;
    }
    final ref = SyncPlayVideoRef.parse(url, expectedVideoId: videoId);
    if (ref == null) return null;
    return SyncPlaySharedVideo(
      videoId: ref.videoId,
      url: ref.url,
      title: title,
      sharedByMemberId: sharedByMemberId as String?,
      sharedByDisplayName: sharedByDisplayName as String?,
    );
  }
}

class SyncPlayPlayback {
  const SyncPlayPlayback({
    required this.url,
    required this.currentTimeSeconds,
    required this.state,
    required this.playbackRate,
    required this.updatedAt,
    required this.serverTime,
    required this.actorId,
    required this.seq,
    this.syncIntent,
    this.userInitiated = false,
    this.naturalEnd = false,
  });

  final String url;
  final double currentTimeSeconds;
  final SyncPlayPlaybackState state;
  final double playbackRate;
  final int updatedAt;
  final int serverTime;
  final String actorId;
  final int seq;
  final String? syncIntent;
  final bool userInitiated;
  final bool naturalEnd;

  Map<String, Object?> toJson() => {
    'url': url,
    'currentTime': currentTimeSeconds,
    'playState': switch (state) {
      SyncPlayPlaybackState.playing => 'playing',
      SyncPlayPlaybackState.paused => 'paused',
      SyncPlayPlaybackState.buffering => 'buffering',
    },
    if (syncIntent != null) 'syncIntent': syncIntent,
    'userInitiated': userInitiated,
    'naturalEnd': naturalEnd,
    'playbackRate': playbackRate,
    'updatedAt': updatedAt,
    'serverTime': serverTime,
    'actorId': actorId,
    'seq': seq,
  };

  static SyncPlayPlayback? tryParse(Object? value) {
    if (value is! Map) return null;
    final url = value['url'];
    final currentTime = value['currentTime'];
    final playState = value['playState'];
    final rate = value['playbackRate'];
    final updatedAt = value['updatedAt'];
    final serverTime = value['serverTime'];
    final actorId = value['actorId'];
    final seq = value['seq'];
    if (url is! String ||
        SyncPlayVideoRef.parse(url) == null ||
        currentTime is! num ||
        !currentTime.isFinite ||
        currentTime < 0 ||
        playState is! String ||
        rate is! num ||
        !rate.isFinite ||
        rate <= 0 ||
        updatedAt is! num ||
        !updatedAt.isFinite ||
        serverTime is! num ||
        !serverTime.isFinite ||
        actorId is! String ||
        !_isActorId(actorId) ||
        seq is! num ||
        !seq.isFinite) {
      return null;
    }
    final state = switch (playState) {
      'playing' => SyncPlayPlaybackState.playing,
      'paused' => SyncPlayPlaybackState.paused,
      'buffering' => SyncPlayPlaybackState.buffering,
      _ => null,
    };
    if (state == null) return null;
    final syncIntent = value['syncIntent'];
    if (syncIntent != null &&
        syncIntent != 'explicit-seek' &&
        syncIntent != 'explicit-ratechange') {
      return null;
    }
    return SyncPlayPlayback(
      url: url,
      currentTimeSeconds: currentTime.toDouble(),
      state: state,
      playbackRate: rate.toDouble(),
      updatedAt: updatedAt.toInt(),
      serverTime: serverTime.toInt(),
      actorId: actorId,
      seq: seq.toInt(),
      syncIntent: syncIntent as String?,
      userInitiated: value['userInitiated'] == true,
      naturalEnd: value['naturalEnd'] == true,
    );
  }
}

class SyncPlayRoomSnapshot {
  static final RegExp _roomCodePattern = RegExp(r'^[A-Z0-9]{6}$');

  const SyncPlayRoomSnapshot({
    required this.roomCode,
    required this.members,
    this.sharedVideo,
    this.playback,
    this.playbackAgeMs,
  });

  final String roomCode;
  final List<SyncPlayMember> members;
  final SyncPlaySharedVideo? sharedVideo;
  final SyncPlayPlayback? playback;
  final int? playbackAgeMs;

  static SyncPlayRoomSnapshot? tryParse(Object? value) {
    if (value is! Map ||
        value['roomCode'] is! String ||
        !_roomCodePattern.hasMatch(value['roomCode'] as String)) {
      return null;
    }
    final membersRaw = value['members'];
    if (membersRaw is! List) return null;
    final members = <SyncPlayMember>[];
    for (final raw in membersRaw) {
      final member = SyncPlayMember.tryParse(raw);
      if (member == null) return null;
      members.add(member);
    }
    final sharedRaw = value['sharedVideo'];
    final sharedVideo = sharedRaw == null
        ? null
        : SyncPlaySharedVideo.tryParse(sharedRaw);
    if (sharedRaw != null && sharedVideo == null) return null;
    final playbackRaw = value['playback'];
    final playback = playbackRaw == null
        ? null
        : SyncPlayPlayback.tryParse(playbackRaw);
    if (playbackRaw != null && playback == null) return null;
    final age = value['playbackAgeMs'];
    if (age != null && (age is! num || !age.isFinite || age < 0)) {
      return null;
    }
    if (sharedVideo != null &&
        playback != null &&
        SyncPlayVideoRef.parse(playback.url)?.videoId != sharedVideo.videoId) {
      return null;
    }
    return SyncPlayRoomSnapshot(
      roomCode: value['roomCode'] as String,
      members: List.unmodifiable(members),
      sharedVideo: sharedVideo,
      playback: playback,
      playbackAgeMs: age is num ? age.round() : null,
    );
  }
}

Map<String, Object?>? decodeSyncPlayMessage(Object? raw) {
  try {
    final decoded = raw is String ? jsonDecode(raw) : raw;
    if (decoded is Map<String, Object?>) return decoded;
    if (decoded is Map) return decoded.cast<String, Object?>();
  } on FormatException {
    return null;
  }
  return null;
}
