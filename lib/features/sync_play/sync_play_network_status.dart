import 'package:connectivity_plus/connectivity_plus.dart';

/// Returns true only when the platform definitively reports no active network.
/// Null represents an unavailable/ambiguous check and must not be shown as
/// offline (for example, server-side Origin rejection is not device offline).
bool? syncPlayIsOffline(List<ConnectivityResult> results) {
  if (results.isEmpty) return null;
  if (results.any((result) => result != ConnectivityResult.none)) return false;
  if (results.every((result) => result == ConnectivityResult.none)) return true;
  return null;
}

abstract interface class SyncPlayNetworkStatusSource {
  Future<bool?> checkOffline();
  Stream<bool?> get offlineChanges;
}

class DeviceSyncPlayNetworkStatusSource
    implements SyncPlayNetworkStatusSource {
  DeviceSyncPlayNetworkStatusSource({Connectivity? connectivity})
    : _connectivity = connectivity ?? Connectivity();

  final Connectivity _connectivity;

  @override
  Future<bool?> checkOffline() async {
    try {
      return syncPlayIsOffline(await _connectivity.checkConnectivity());
    } catch (_) {
      return null;
    }
  }

  @override
  Stream<bool?> get offlineChanges => _connectivity.onConnectivityChanged
      .map(syncPlayIsOffline);
}
