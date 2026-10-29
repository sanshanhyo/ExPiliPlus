import 'package:ex_piliplus/features/sync_play/sync_play_service.dart';

/// A deliberately small, credential-free record of a successful room join.
/// Room codes, join/member tokens and Bilibili account data are never stored.
class SyncPlayConnectionHistoryEntry {
  const SyncPlayConnectionHistoryEntry({
    required this.displayName,
    required this.serverAddress,
    required this.connectedAtEpochMs,
  });

  static const maxEntries = 12;

  final String displayName;
  final String serverAddress;
  final int connectedAtEpochMs;

  static SyncPlayConnectionHistoryEntry? fromSuccessfulSettings(
    SyncPlayConnectionSettings settings, {
    required int connectedAtEpochMs,
  }) {
    final name = SyncPlayConnectionSettings.validateDisplayName(
      settings.displayName,
    );
    final address = settings.parsedAddress;
    if (name == null || address == null) return null;

    // SyncPlayServerAddress rejects user-info, query strings, and fragments.
    // Keep only the normalized secure endpoint that was actually connected.
    final endpoint = address.endpoint;
    if (endpoint.scheme != 'wss' ||
        endpoint.host.isEmpty ||
        endpoint.userInfo.isNotEmpty ||
        endpoint.hasQuery ||
        endpoint.hasFragment) {
      return null;
    }
    return SyncPlayConnectionHistoryEntry(
      displayName: name,
      serverAddress: endpoint.toString(),
      connectedAtEpochMs: connectedAtEpochMs,
    );
  }

  Map<String, Object> toJson() => {
    'displayName': displayName,
    'serverAddress': serverAddress,
    'connectedAtEpochMs': connectedAtEpochMs,
  };

  static SyncPlayConnectionHistoryEntry? tryParse(Object? value) {
    if (value is! Map) return null;
    final name = value['displayName'];
    final rawAddress = value['serverAddress'];
    final timestamp = value['connectedAtEpochMs'];
    if (name is! String || rawAddress is! String || timestamp is! int) {
      return null;
    }
    final validName = SyncPlayConnectionSettings.validateDisplayName(name);
    final endpoint = SyncPlayServerAddress.tryParseAdvancedWebSocketUrl(
      rawAddress,
    );
    if (validName == null || endpoint == null) return null;
    return SyncPlayConnectionHistoryEntry(
      displayName: validName,
      serverAddress: endpoint.toString(),
      connectedAtEpochMs: timestamp,
    );
  }

  static List<SyncPlayConnectionHistoryEntry> parse(Object? value) {
    if (value is! Iterable) return const [];
    final parsed = <SyncPlayConnectionHistoryEntry>[];
    for (final item in value) {
      final entry = tryParse(item);
      if (entry != null) parsed.add(entry);
    }
    parsed.sort((a, b) => b.connectedAtEpochMs.compareTo(a.connectedAtEpochMs));
    final seen = <String>{};
    final unique = <SyncPlayConnectionHistoryEntry>[];
    for (final entry in parsed) {
      final identity = '${entry.displayName}\u0000${entry.serverAddress}';
      if (seen.add(identity)) unique.add(entry);
      if (unique.length == maxEntries) break;
    }
    return List.unmodifiable(unique);
  }

  static List<SyncPlayConnectionHistoryEntry> record(
    Iterable<SyncPlayConnectionHistoryEntry> existing,
    SyncPlayConnectionHistoryEntry added,
  ) {
    final identity = '${added.displayName}\u0000${added.serverAddress}';
    final candidates = [
      added,
      ...existing.where(
        (item) => '${item.displayName}\u0000${item.serverAddress}' != identity,
      ),
    ]
      ..sort((a, b) => b.connectedAtEpochMs.compareTo(a.connectedAtEpochMs));
    final seen = <String>{};
    final updated = <SyncPlayConnectionHistoryEntry>[];
    for (final item in candidates) {
      final identity = '${item.displayName}\u0000${item.serverAddress}';
      if (seen.add(identity)) updated.add(item);
      if (updated.length == maxEntries) break;
    }
    return List.unmodifiable(updated);
  }
}
