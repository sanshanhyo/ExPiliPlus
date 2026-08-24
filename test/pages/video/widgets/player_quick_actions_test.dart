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
          PlayerQuickActionId.sleepTimer,
          PlayerQuickActionId.cdnSettings,
        ],
      );
    });

    test('keeps a valid custom order and exactly three items', () {
      expect(
        PlayerQuickActionConfig.normalize([
          PlayerQuickActionId.report,
          PlayerQuickActionId.codec,
          PlayerQuickActionId.sleepTimer,
        ]),
        [
          PlayerQuickActionId.report,
          PlayerQuickActionId.codec,
          PlayerQuickActionId.sleepTimer,
        ],
      );
    });

    test('falls back to defaults when the stored value is absent', () {
      expect(
        PlayerQuickActionConfig.normalize(null),
        PlayerQuickActionConfig.defaults,
      );
    });

    test('keeps preferred order and fills the display capacity', () {
      expect(
        PlayerQuickActionConfig.displayOrder(
          preferred: [
            PlayerQuickActionId.cdnSettings,
            PlayerQuickActionId.audioOnly,
          ],
          available: [
            PlayerQuickActionId.watchLater,
            PlayerQuickActionId.cdnSettings,
            PlayerQuickActionId.notes,
          ],
          capacity: 4,
        ),
        [
          PlayerQuickActionId.cdnSettings,
          PlayerQuickActionId.audioOnly,
          PlayerQuickActionId.watchLater,
          PlayerQuickActionId.notes,
        ],
      );
    });

    test('truncates the display list to the available capacity', () {
      expect(
        PlayerQuickActionConfig.displayOrder(
          preferred: PlayerQuickActionConfig.defaults,
          available: PlayerQuickActionConfig.all,
          capacity: 2,
        ),
        [
          PlayerQuickActionId.sleepTimer,
          PlayerQuickActionId.cdnSettings,
        ],
      );
    });

    test('only appends actions provided as available', () {
      expect(
        PlayerQuickActionConfig.displayOrder(
          preferred: [PlayerQuickActionId.sleepTimer],
          available: [
            PlayerQuickActionId.cdnSettings,
            PlayerQuickActionId.audioOnly,
          ],
          capacity: 3,
        ),
        [
          PlayerQuickActionId.sleepTimer,
          PlayerQuickActionId.cdnSettings,
          PlayerQuickActionId.audioOnly,
        ],
      );
    });
  });
}
