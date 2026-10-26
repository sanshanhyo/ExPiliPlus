from __future__ import annotations

import re
import unittest
from pathlib import Path


BENCHMARK_SCRIPT = Path(__file__).with_name("run_android_benchmark.sh").read_text(
    encoding="utf-8"
)


def function_body(name: str, next_marker: str) -> str:
    start = BENCHMARK_SCRIPT.index(f"{name}() {{")
    end = BENCHMARK_SCRIPT.index(next_marker, start)
    return BENCHMARK_SCRIPT[start:end]


class AndroidBenchmarkScriptCheckTest(unittest.TestCase):
    def test_release_build_uses_separate_validated_production_dependencies(self) -> None:
        release = function_body("build_release_revision", "run_profile_revision() {")
        enforce_full_lock = release.index("flutter pub get --enforce-lockfile")
        strip_test_dependency = release.index(
            'dependency = "  integration_test:\\n    sdk: flutter\\n"'
        )
        production_pub_get = release.index(
            "benchmark stage: resolve production-only dependencies"
        )
        verify_production_lock = release.index("verify_android_production_lock.py")
        enforce_production_lock = release.index(
            "benchmark stage: enforce production-only lock"
        )
        production_config = release.index("flutter build apk --config-only --no-pub")
        plugin_metadata_check = release.index(
            'grep -Fq "integration_test" "$plugin_metadata"'
        )
        registrant_check = release.index(
            'grep -Fq "dev.flutter.plugins.integration_test" "$registrant"'
        )
        release_build = re.search(
            r"^\s+flutter build apk --release", release, re.MULTILINE
        ).start()

        self.assertLess(enforce_full_lock, strip_test_dependency)
        self.assertLess(strip_test_dependency, production_pub_get)
        self.assertLess(production_pub_get, verify_production_lock)
        self.assertLess(verify_production_lock, enforce_production_lock)
        self.assertLess(enforce_production_lock, production_config)
        self.assertLess(enforce_production_lock, plugin_metadata_check)
        self.assertLess(plugin_metadata_check, registrant_check)
        self.assertLess(registrant_check, release_build)
        self.assertIn("--build-name=", release)
        self.assertIn("--build-number=", release)

    def test_profile_command_uses_drive_flags_without_build_identity_flags(self) -> None:
        profile = function_body(
            "run_profile_revision", 'build_release_revision baseline "$baseline_sha"'
        )
        self.assertIn("flutter drive --profile --no-pub", profile)
        self.assertIn("--dart-define-from-file=", profile)
        self.assertNotIn("--build-name", profile)
        self.assertNotIn("--build-number", profile)

    def test_both_release_apks_and_size_summary_precede_profile_runs(self) -> None:
        baseline_release = BENCHMARK_SCRIPT.index(
            'build_release_revision baseline "$baseline_sha"'
        )
        candidate_release = BENCHMARK_SCRIPT.index(
            'build_release_revision candidate "$candidate_sha"'
        )
        size_report = BENCHMARK_SCRIPT.index(
            'python3 "$repo_root/.github/scripts/android_apk_report.py"'
        )
        profile_start = BENCHMARK_SCRIPT.index(
            'run_profile_revision baseline "$baseline_sha"'
        )
        profile_candidate = BENCHMARK_SCRIPT.index(
            'run_profile_revision candidate "$candidate_sha"'
        )

        self.assertLess(baseline_release, candidate_release)
        self.assertLess(candidate_release, size_report)
        self.assertLess(size_report, profile_start)
        self.assertLess(profile_start, profile_candidate)
        self.assertIn("--summary-output", BENCHMARK_SCRIPT)
        self.assertIn("GITHUB_STEP_SUMMARY", BENCHMARK_SCRIPT)

    def test_profile_harness_is_copied_only_after_release_build_function(self) -> None:
        release = function_body("build_release_revision", "run_profile_revision() {")
        profile = function_body(
            "run_profile_revision", 'build_release_revision baseline "$baseline_sha"'
        )
        self.assertIn('cp "$release_apk" "$output_dir/expiliplus-arm64-release.apk"', release)
        self.assertNotIn("android_gif_benchmark_test.dart", release)
        self.assertIn("android_gif_benchmark_test.dart", profile)
        self.assertIn("android_benchmark_video_data.dart", profile)


if __name__ == "__main__":
    unittest.main()
