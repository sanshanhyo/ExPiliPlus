import 'package:ex_piliplus/features/sync_play/sync_play_connection_history.dart';
import 'package:ex_piliplus/features/sync_play/sync_play_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('SyncPlayConnectionHistoryEntry', () {
    test('stores only a normalized secure endpoint and ordinary display data', () {
      final entry = SyncPlayConnectionHistoryEntry.fromSuccessfulSettings(
        const SyncPlayConnectionSettings(
          serverAddress: 'https://sync.example.test:9443/sync',
          displayName: 'Room host',
        ),
        connectedAtEpochMs: 1234,
      );

      expect(entry, isNotNull);
      expect(entry!.serverAddress, 'wss://sync.example.test:9443/sync');
      expect(entry.toJson(), {
        'displayName': 'Room host',
        'serverAddress': 'wss://sync.example.test:9443/sync',
        'connectedAtEpochMs': 1234,
      });
      expect(entry.toJson().keys, isNot(contains('joinToken')));
      expect(entry.toJson().keys, isNot(contains('memberToken')));
      expect(entry.toJson().keys, isNot(contains('roomCode')));
    });

    test('rejects query credentials and malformed stored endpoints', () {
      expect(
        SyncPlayConnectionHistoryEntry.fromSuccessfulSettings(
          const SyncPlayConnectionSettings(
            serverAddress: 'wss://sync.example.test/ws?token=secret',
            displayName: 'Room host',
          ),
          connectedAtEpochMs: 1234,
        ),
        isNull,
      );
      expect(
        SyncPlayConnectionHistoryEntry.tryParse({
          'displayName': 'Room host',
          'serverAddress': 'wss://sync.example.test/ws?token=secret',
          'connectedAtEpochMs': 1234,
        }),
        isNull,
      );
      expect(
        SyncPlayConnectionHistoryEntry.tryParse({
          'displayName': 'Room host',
          'serverAddress': 'wss://user:secret@sync.example.test/ws',
          'connectedAtEpochMs': 1234,
        }),
        isNull,
      );
    });

    test('deduplicates newest entries and keeps the history bounded', () {
      final older = _entry('Same', 'wss://sync.example.test/ws', 1);
      // The newest duplicate must outrank every other fixture timestamp.
      final newer = _entry('Same', 'wss://sync.example.test/ws', 23);
      final many = [
        for (var index = 0; index < 20; index++)
          _entry('Room $index', 'wss://host$index.example.test/ws', index + 3),
      ];

      final result = SyncPlayConnectionHistoryEntry.record(
        [older, ...many],
        newer,
      );

      expect(result, hasLength(SyncPlayConnectionHistoryEntry.maxEntries));
      expect(result.first.connectedAtEpochMs, 23);
      expect(
        result.where((item) => item.displayName == 'Same'),
        hasLength(1),
      );
    });

    test('ignores malformed old values while reading history', () {
      final result = SyncPlayConnectionHistoryEntry.parse([
        _entry('A', 'wss://a.example.test/ws', 10).toJson(),
        {'displayName': 'B', 'serverAddress': 'http://b.example.test', 'connectedAtEpochMs': 20},
        'not a map',
      ]);
      expect(result, hasLength(1));
      expect(result.single.displayName, 'A');
    });
  });
}

SyncPlayConnectionHistoryEntry _entry(String name, String url, int time) =>
    SyncPlayConnectionHistoryEntry(
      displayName: name,
      serverAddress: url,
      connectedAtEpochMs: time,
    );
