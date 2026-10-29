import 'package:ex_piliplus/features/sync_play/sync_play_protocol.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('SyncPlayVideoRef', () {
    test('keeps multi-part identity distinct for p and cid URLs', () {
      final firstPart = SyncPlayVideoRef.parse(
        'https://www.bilibili.com/video/BV1gA411M7RN?p=1',
      );
      final secondPart = SyncPlayVideoRef.parse(
        'https://www.bilibili.com/video/BV1gA411M7RN?p=2',
      );
      final cidPart = SyncPlayVideoRef.parse(
        'https://www.bilibili.com/video/BV1gA411M7RN?cid=2002',
      );

      expect(firstPart?.videoId, 'BV1gA411M7RN:p1');
      expect(secondPart?.videoId, 'BV1gA411M7RN:p2');
      expect(cidPart?.videoId, 'BV1gA411M7RN:2002');
      expect(firstPart?.videoId, isNot(secondPart?.videoId));
      expect(secondPart?.videoId, isNot(cidPart?.videoId));
    });

    test('maps protocol page IDs only with matching local page metadata', () {
      final localPageTwo = SyncPlayVideoRef.fromPlayer(
        bvid: 'BV1gA411M7RN',
        cid: 2002,
      );
      final pageTwo = SyncPlayVideoRef.parse(
        'https://www.bilibili.com/video/BV1gA411M7RN?p=2',
      )!;
      final defaultVideo = SyncPlayVideoRef.parse(
        'https://www.bilibili.com/video/BV1gA411M7RN',
      )!;

      expect(pageTwo.matchesLocalPage(localPageTwo, localPage: 2), isTrue);
      expect(pageTwo.matchesLocalPage(localPageTwo, localPage: 1), isFalse);
      expect(pageTwo.matchesLocalPage(localPageTwo, localPage: null), isFalse);
      expect(defaultVideo.matchesLocalPage(localPageTwo, localPage: 1), isTrue);
      expect(defaultVideo.matchesLocalPage(localPageTwo, localPage: 2), isFalse);
      expect(
        pageTwo.matchesLocalPage(
          SyncPlayVideoRef.fromPlayer(bvid: 'BV1gA411M7RN', cid: 2001),
          localPage: 1,
        ),
        isFalse,
      );
    });

    test('accepts plain video links and normalizes their origin', () {
      final ref = SyncPlayVideoRef.parse(
        'http://www.bilibili.com/video/BV1gA411M7RN/',
      );

      expect(ref?.videoId, 'BV1gA411M7RN');
      expect(ref?.url, 'https://www.bilibili.com/video/BV1gA411M7RN');
    });

    test('rejects lookalike hosts and mismatched ids', () {
      expect(
        SyncPlayVideoRef.parse(
          'https://www.bilibili.com.evil.example/video/BV1gA411M7RN?cid=12',
        ),
        isNull,
      );
      expect(
        SyncPlayVideoRef.parse(
          'https://www.bilibili.com/video/BV1gA411M7RN?cid=12',
          expectedVideoId: 'BV1gA411M7RN:p2',
        ),
        isNull,
      );
      expect(
        SyncPlayVideoRef.parse(
          'https://user@www.bilibili.com/video/BV1gA411M7RN?cid=12',
        ),
        isNull,
      );
    });

    test('uses cid identity when the protocol URL has both cid and p', () {
      final ref = SyncPlayVideoRef.parse(
        'https://www.bilibili.com/video/BV1gA411M7RN?p=3&cid=3300',
      );
      expect(ref?.videoId, 'BV1gA411M7RN:3300');
      expect(
        SyncPlayVideoRef.parse(
          'https://www.bilibili.com/video/BV1gA411M7RN?p=invalid&cid=3300',
        )?.videoId,
        'BV1gA411M7RN:3300',
      );
    });

    test('rejects non-positive cid and p values', () {
      expect(
        SyncPlayVideoRef.parse(
          'https://www.bilibili.com/video/BV1gA411M7RN?cid=0',
        ),
        isNull,
      );
      expect(
        SyncPlayVideoRef.parse(
          'https://www.bilibili.com/video/BV1gA411M7RN?p=-1',
        ),
        isNull,
      );
    });
  });

  group('SyncPlay protocol parsing', () {
    test('rejects malformed room state rather than accepting partial members', () {
      expect(
        SyncPlayRoomSnapshot.tryParse({
          'roomCode': 'ROOM42',
          'members': [
            {'id': 'ok', 'name': 'Member'},
            {'id': 42, 'name': 'Malformed'},
          ],
          'sharedVideo': null,
          'playback': null,
        }),
        isNull,
      );
    });

    test('rejects invalid playback values and accepts supported sync intent', () {
      final base = <String, Object?>{
        'url': 'https://www.bilibili.com/video/BV1gA411M7RN?cid=12',
        'currentTime': 1.25,
        'playState': 'playing',
        'playbackRate': 1.5,
        'updatedAt': 100,
        'serverTime': 200,
        'actorId': 'member',
        'seq': 4,
        'syncIntent': 'explicit-ratechange',
      };

      expect(
        SyncPlayPlayback.tryParse(base)?.syncIntent,
        'explicit-ratechange',
      );
      expect(
        SyncPlayPlayback.tryParse({...base, 'currentTime': double.nan}),
        isNull,
      );
      expect(
        SyncPlayPlayback.tryParse({...base, 'syncIntent': 'unknown'}),
        isNull,
      );
    });

    test('decodes JSON objects and rejects invalid JSON', () {
      expect(decodeSyncPlayMessage('{"type":"sync:pong","payload":{}}'), {
        'type': 'sync:pong',
        'payload': <String, Object?>{},
      });
      expect(decodeSyncPlayMessage('{broken'), isNull);
      expect(decodeSyncPlayMessage([1, 2]), isNull);
    });

    test('rejects invalid snapshot ages and playback for a different video', () {
      final base = <String, Object?>{
        'roomCode': 'ROOM42',
        'members': <Object?>[],
        'sharedVideo': {
          'videoId': 'BV1gA411M7RN:12',
          'url': 'https://www.bilibili.com/video/BV1gA411M7RN?cid=12',
          'title': 'Shared video',
        },
        'playback': {
          'url': 'https://www.bilibili.com/video/BV1gA411M7RN?cid=13',
          'currentTime': 1,
          'playState': 'playing',
          'playbackRate': 1,
          'updatedAt': 100,
          'serverTime': 100,
          'actorId': 'member',
          'seq': 1,
        },
      };
      expect(SyncPlayRoomSnapshot.tryParse(base), isNull);
      expect(
        SyncPlayRoomSnapshot.tryParse({...base, 'playback': null, 'playbackAgeMs': -1}),
        isNull,
      );
      expect(
        SyncPlayRoomSnapshot.tryParse({...base, 'playback': null, 'playbackAgeMs': double.infinity}),
        isNull,
      );
    });
  });
}
