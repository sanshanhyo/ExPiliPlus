from __future__ import annotations

import unittest

from check_android_benchmark_cli import drive_options, validate_drive_options


class AndroidBenchmarkCliTest(unittest.TestCase):
    def test_extracts_drive_flags_from_benchmark_command(self) -> None:
        script = '''
    flutter drive --profile --no-pub \\
      --driver=integration_test/driver.dart \\
      --target=integration_test/benchmark.dart \\
      -d emulator-5554 \\
      --dart-define-from-file=defines.json
  ) > "$output_dir/profile-benchmark.log" 2>&1 &
'''
        self.assertEqual(
            drive_options(script),
            {
                "--profile",
                "--no-pub",
                "--driver",
                "--target",
                "-d",
                "--dart-define-from-file",
            },
        )

    def test_accepts_only_options_listed_by_flutter_help(self) -> None:
        help_text = """
  -d, --device-id=<DEVICE_ID>
      --dart-define-from-file=<DART_DEFINES>
      --driver=<DRIVER>
      --no-pub
      --profile
      --target=<TARGET>
"""
        script = '''
    flutter drive --profile --no-pub \\
      --driver=integration_test/driver.dart \\
      --target=integration_test/benchmark.dart \\
      -d emulator-5554 \\
      --dart-define-from-file=defines.json
  ) > "$output_dir/profile-benchmark.log" 2>&1 &
'''
        self.assertEqual(len(validate_drive_options(help_text, script)), 6)

    def test_rejects_an_unsupported_build_name_flag(self) -> None:
        help_text = "--profile --no-pub --driver --target -d --dart-define-from-file"
        script = '''
    flutter drive --profile --no-pub --build-name=1.0 \\
      --driver=integration_test/driver.dart \\
      --target=integration_test/benchmark.dart \\
      -d emulator-5554 \\
      --dart-define-from-file=defines.json
  ) > "$output_dir/profile-benchmark.log" 2>&1 &
'''
        with self.assertRaisesRegex(ValueError, "--build-name"):
            validate_drive_options(help_text, script)


if __name__ == "__main__":
    unittest.main()
