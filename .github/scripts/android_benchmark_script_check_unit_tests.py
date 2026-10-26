from __future__ import annotations

import re
import unittest
from pathlib import Path


BENCHMARK_SCRIPT = Path(__file__).with_name("run_android_benchmark.sh").read_text(
    encoding="utf-8"
)


class AndroidBenchmarkScriptCheckTest(unittest.TestCase):
    def test_refreshes_flutter_android_config_after_locked_pub_get(self) -> None:
        enforce_lock = BENCHMARK_SCRIPT.index(
            "flutter pub get --enforce-lockfile"
        )
        refresh_config = BENCHMARK_SCRIPT.index(
            "flutter build apk --config-only --no-pub"
        )
        release_build = re.search(
            r"^\s+flutter build apk --release", BENCHMARK_SCRIPT, re.MULTILINE
        ).start()

        self.assertLess(enforce_lock, refresh_config)
        self.assertLess(refresh_config, release_build)
        self.assertIn("config_lock_sha", BENCHMARK_SCRIPT)

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
