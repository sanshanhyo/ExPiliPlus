from __future__ import annotations

import re
import unittest
from pathlib import Path


BENCHMARK_SCRIPT = Path(__file__).with_name("run_android_benchmark.sh").read_text(
    encoding="utf-8"
)


class AndroidBenchmarkScriptCheckTest(unittest.TestCase):
    def test_release_uses_separate_validated_production_dependencies(self) -> None:
        enforce_lock = BENCHMARK_SCRIPT.index(
            "flutter pub get --enforce-lockfile"
        )
        strip_test_dependency = BENCHMARK_SCRIPT.index(
            'dependency = "  integration_test:\\n    sdk: flutter\\n"'
        )
        production_pub_get = BENCHMARK_SCRIPT.index(
            "benchmark stage: resolve production-only dependencies"
        )
        verify_production_lock = BENCHMARK_SCRIPT.index(
            "verify_android_production_lock.py"
        )
        enforce_production_lock = BENCHMARK_SCRIPT.index(
            "benchmark stage: enforce production-only lock"
        )
        production_config = BENCHMARK_SCRIPT.index(
            "flutter build apk --config-only --no-pub"
        )
        registrant_exclusion = BENCHMARK_SCRIPT.index(
            'grep -Fq "dev.flutter.plugins.integration_test"'
        )
        production_plugin_check = BENCHMARK_SCRIPT.index(
            'grep -Fq "integration_test" "$plugin_metadata"'
        )
        release_build = re.search(
            r"^\s+flutter build apk --release", BENCHMARK_SCRIPT, re.MULTILINE
        ).start()
        restore_full_manifest = BENCHMARK_SCRIPT.index(
            'cp "$output_dir/full-pubspec.yaml" "$source_dir/pubspec.yaml"'
        )
        restore_full_lock = BENCHMARK_SCRIPT.index(
            'cp "$evidence_dir/toolchain/normalized-pubspec.lock" "$source_dir/pubspec.lock"',
            restore_full_manifest,
        )
        profile_pub_get = BENCHMARK_SCRIPT.index(
            'echo "benchmark stage: restore and enforce full test lock'
        )
        profile_plugin_check = BENCHMARK_SCRIPT.index(
            'if ! grep -Fq "integration_test" "$plugin_metadata"'
        )
        test_harness_copy = BENCHMARK_SCRIPT.index(
            'cp "$repo_root/.github/benchmarks/android_gif_benchmark_test.dart"'
        )

        self.assertLess(enforce_lock, strip_test_dependency)
        self.assertLess(strip_test_dependency, production_pub_get)
        self.assertLess(production_pub_get, verify_production_lock)
        self.assertLess(verify_production_lock, enforce_production_lock)
        self.assertLess(enforce_production_lock, production_config)
        self.assertLess(enforce_production_lock, production_plugin_check)
        self.assertLess(production_plugin_check, production_config)
        self.assertLess(production_config, registrant_exclusion)
        self.assertLess(registrant_exclusion, release_build)
        self.assertLess(release_build, restore_full_manifest)
        self.assertLess(restore_full_manifest, restore_full_lock)
        self.assertLess(restore_full_lock, profile_pub_get)
        self.assertLess(profile_pub_get, profile_plugin_check)
        self.assertLess(profile_plugin_check, test_harness_copy)

    def test_benchmark_harness_and_fixture_are_added_after_release_apk(self) -> None:
        release_build = re.search(
            r"^\s+flutter build apk --release", BENCHMARK_SCRIPT, re.MULTILINE
        ).start()
        release_apk_copy = BENCHMARK_SCRIPT.index(
            'cp "$release_apk" "$output_dir/expiliplus-arm64-release.apk"'
        )
        test_harness_copy = BENCHMARK_SCRIPT.index(
            'cp "$repo_root/.github/benchmarks/android_gif_benchmark_test.dart"'
        )
        driver_copy = BENCHMARK_SCRIPT.index(
            'cp "$repo_root/.github/benchmarks/android_benchmark_driver.dart"'
        )
        synthetic_fixture_copy = BENCHMARK_SCRIPT.index(
            'cp "$runner_temp/android_benchmark_video_data.dart"'
        )
        profile_run = re.search(
            r"^\s+flutter drive --profile --no-pub", BENCHMARK_SCRIPT, re.MULTILINE
        ).start()

        self.assertLess(release_build, release_apk_copy)
        self.assertLess(release_apk_copy, test_harness_copy)
        self.assertLess(test_harness_copy, driver_copy)
        self.assertLess(driver_copy, synthetic_fixture_copy)
        self.assertLess(synthetic_fixture_copy, profile_run)


if __name__ == "__main__":
    unittest.main()
