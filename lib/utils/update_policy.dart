import 'package:pub_semver/pub_semver.dart';

enum UpdateDecisionType { updateAvailable, upToDate, selfCompiled }

final class UpdateDecision {
  const UpdateDecision._(this.type, [this.release]);

  const UpdateDecision.updateAvailable(Map<String, dynamic> release)
    : this._(UpdateDecisionType.updateAvailable, release);

  const UpdateDecision.upToDate() : this._(UpdateDecisionType.upToDate);

  const UpdateDecision.selfCompiled() : this._(UpdateDecisionType.selfCompiled);

  final UpdateDecisionType type;
  final Map<String, dynamic>? release;
}

abstract final class UpdatePolicy {
  static String normalizeTag(String tag) {
    final value = tag.trim();
    return value.startsWith('v') ? value.substring(1) : value;
  }

  static Version? tryParse(String value) {
    try {
      return Version.parse(normalizeTag(value));
    } on FormatException {
      return null;
    }
  }

  static bool isDevelopment(String value) =>
      tryParse(value)?.isPreRelease ?? false;

  static UpdateDecision evaluate({
    required String currentVersion,
    required bool isReleaseBuild,
    required List<dynamic> releases,
  }) {
    final current = tryParse(currentVersion);
    if (!isReleaseBuild || current == null || current.build.isNotEmpty) {
      return const UpdateDecision.selfCompiled();
    }

    final parsedReleases = <(Version, Map<String, dynamic>)>[];
    for (final item in releases) {
      if (item is! Map || item['draft'] == true) continue;
      final release = Map<String, dynamic>.from(item);
      final tag = release['tag_name'];
      if (tag is! String) continue;
      final version = tryParse(tag);
      if (version != null) {
        parsedReleases.add((version, release));
      }
    }

    final currentExists = parsedReleases.any(
      (item) => item.$1 == current,
    );
    if (!currentExists) {
      return const UpdateDecision.selfCompiled();
    }

    final candidates = parsedReleases.where(
      (item) =>
          !item.$1.isPreRelease &&
          item.$2['prerelease'] != true &&
          item.$1 > current,
    );
    if (candidates.isEmpty) {
      return const UpdateDecision.upToDate();
    }

    final latest = candidates.reduce(
      (left, right) => left.$1 > right.$1 ? left : right,
    );
    return UpdateDecision.updateAvailable(latest.$2);
  }
}
