import 'package:ex_piliplus/pages/video/widgets/player_quick_actions.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('PlayerQuickActionConfig', () {
    test('normalizes duplicates, unknown values, and malformed values', () {
      expect(
        PlayerQuickActionConfig.normalize([
          PlayerQuickActionId.audioOnly,
          PlayerQuickActionId.audioOnly,
          'removed-action',
          42,
        ]),
        [
          PlayerQuickActionId.audioOnly,
        ],
      );
    });

    test('keeps an arbitrary valid custom order', () {
      expect(
        PlayerQuickActionConfig.normalize([
          PlayerQuickActionId.report,
          PlayerQuickActionId.codec,
          PlayerQuickActionId.sleepTimer,
          PlayerQuickActionId.audioOnly,
        ]),
        [
          PlayerQuickActionId.report,
          PlayerQuickActionId.codec,
          PlayerQuickActionId.sleepTimer,
          PlayerQuickActionId.audioOnly,
        ],
      );
    });

    test('falls back to defaults when the stored value is absent', () {
      expect(
        PlayerQuickActionConfig.normalize(null),
        PlayerQuickActionConfig.defaults,
      );
    });

    test('calculates the display capacity from the available width', () {
      expect(
        PlayerQuickActionConfig.capacityForWidth(
          480,
          actionCount: PlayerQuickActionConfig.all.length,
        ),
        4,
      );
      expect(
        PlayerQuickActionConfig.capacityForWidth(
          1000,
          actionCount: 3,
        ),
        3,
      );
    });
  });
}
