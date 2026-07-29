import 'package:ex_piliplus/utils/update_policy.dart';
import 'package:flutter_test/flutter_test.dart';

Map<String, dynamic> release(
  String tag, {
  bool prerelease = false,
  bool draft = false,
}) => {
  'tag_name': tag,
  'prerelease': prerelease,
  'draft': draft,
};

void main() {
  group('UpdatePolicy', () {
    test('normalizes a leading v only', () {
      expect(UpdatePolicy.normalizeTag('v1.2.3'), '1.2.3');
      expect(UpdatePolicy.normalizeTag('1.2.3'), '1.2.3');
    });

    test('development builds update only to stable releases', () {
      final decision = UpdatePolicy.evaluate(
        currentVersion: '1.0.0-dev.1',
        isReleaseBuild: true,
        releases: [
          release('v1.0.0-dev.1', prerelease: true),
          release('v1.0.0-dev.2', prerelease: true),
          release('v1.0.0'),
        ],
      );

      expect(decision.type, UpdateDecisionType.updateAvailable);
      expect(decision.release?['tag_name'], 'v1.0.0');
    });

    test('stable builds ignore newer development releases', () {
      final decision = UpdatePolicy.evaluate(
        currentVersion: '1.0.0',
        isReleaseBuild: true,
        releases: [
          release('v1.0.0'),
          release('v1.1.0-dev.1', prerelease: true),
        ],
      );

      expect(decision.type, UpdateDecisionType.upToDate);
    });

    test('selects the newest stable release regardless of API order', () {
      final decision = UpdatePolicy.evaluate(
        currentVersion: '1.0.2',
        isReleaseBuild: true,
        releases: [
          release('v1.0.2'),
          release('v1.2.0'),
          release('v1.1.0'),
        ],
      );

      expect(decision.type, UpdateDecisionType.updateAvailable);
      expect(decision.release?['tag_name'], 'v1.2.0');
    });

    test('custom builds never receive an update target', () {
      final decision = UpdatePolicy.evaluate(
        currentVersion: '1.0.0+build.5183',
        isReleaseBuild: false,
        releases: [release('v1.0.0'), release('v1.1.0')],
      );

      expect(decision.type, UpdateDecisionType.selfCompiled);
    });

    test('unknown release builds are treated as self compiled', () {
      final decision = UpdatePolicy.evaluate(
        currentVersion: '1.0.1',
        isReleaseBuild: true,
        releases: [release('v1.0.0'), release('v1.1.0')],
      );

      expect(decision.type, UpdateDecisionType.selfCompiled);
    });

    test('draft releases are ignored', () {
      final decision = UpdatePolicy.evaluate(
        currentVersion: '1.0.0',
        isReleaseBuild: true,
        releases: [
          release('v1.0.0'),
          release('v1.1.0', draft: true),
        ],
      );

      expect(decision.type, UpdateDecisionType.upToDate);
    });
  });
}
