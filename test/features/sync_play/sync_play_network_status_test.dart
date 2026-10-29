import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:ex_piliplus/features/sync_play/sync_play_network_status.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('offline requires an explicit none-only device network result', () {
    expect(syncPlayIsOffline(const [ConnectivityResult.none]), isTrue);
    expect(syncPlayIsOffline(const [ConnectivityResult.wifi]), isFalse);
    expect(syncPlayIsOffline(const [ConnectivityResult.mobile]), isFalse);
    expect(
      syncPlayIsOffline(const [ConnectivityResult.none, ConnectivityResult.wifi]),
      isFalse,
    );
    expect(syncPlayIsOffline(const []), isNull);
  });
}
