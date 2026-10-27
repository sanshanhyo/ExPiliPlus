from __future__ import annotations

import sys
import unittest
from pathlib import Path

SCRIPT_DIR = Path(__file__).parent
sys.path.insert(0, str(SCRIPT_DIR))

from apply_android_gif_common_lifecycle_fix import (  # noqa: E402
    CORRECTNESS_BASELINE_SHA,
    apply_common_lifecycle_fix,
)

REPO_ROOT = SCRIPT_DIR.parents[1]
BENCHMARK_SCRIPT = (SCRIPT_DIR / "run_android_benchmark.sh").read_text(
    encoding="utf-8"
)


BASELINE_SOURCE_FIXTURE = """class PinnedBaselineFixture {
  bool _succeeded = false;

  void _initialize() {
    final options = {
      'end': (start + duration).toStringAsFixed(3),
    };
    _command(['vf', 'set', _videoFilters]);
    _use(options);
  }

  Future<void>? _onEvent(Pointer<generated.mpv_event> event) {
    switch (event.ref.event_id) {
      case generated.mpv_event_id.MPV_EVENT_FILE_LOADED:
        _command(['vf', 'set', _videoFilters]);
        break;
      case generated.mpv_event_id.MPV_EVENT_END_FILE:
        final end = event.ref.data.cast<generated.mpv_event_end_file>().ref;
        final reason = end.reason;
        final error = end.error;
        _complete(error == 0);
        break;
      case generated.mpv_event_id.MPV_EVENT_SHUTDOWN:
        _complete(false);
        break;
    }
    return null;
  }

  void _complete(bool success) {
    _succeeded = success;
  }
}
"""
class AndroidGifCommonLifecycleFixTest(unittest.TestCase):
    @classmethod
    def setUpClass(cls) -> None:
        cls.baseline = BASELINE_SOURCE_FIXTURE
        cls.candidate = (
            REPO_ROOT
            / "lib/plugin/pl_player/widgets/mpv_convert_gif.dart"
        ).read_text(encoding="utf-8")
        cls.fixed_baseline = apply_common_lifecycle_fix(cls.baseline)

    def test_fixed_baseline_shares_explicit_speed_and_deferred_teardown(self) -> None:
        for source in (self.fixed_baseline, self.candidate):
            self.assertIn("'speed': '1',", source)
            self.assertIn(
                "Timer.run(() => _finishAfterEndFile(reason, error, errorText));",
                source,
            )
            self.assertIn("void _finishAfterEndFile(", source)

    def test_baseline_preserves_the_old_filter_reapplication_as_comparison_delta(
        self,
    ) -> None:
        self.assertEqual(
            self.fixed_baseline.count("_command(['vf', 'set', _videoFilters])"), 2
        )
        self.assertEqual(
            self.candidate.count("_command(['vf', 'set', _videoFilters])"), 1
        )

    def test_baseline_end_file_callback_does_not_complete_synchronously(self) -> None:
        for source in (self.fixed_baseline, self.candidate):
            end_file_case = source.split(
                "case generated.mpv_event_id.MPV_EVENT_END_FILE:", 1
            )[1].split(
                "case generated.mpv_event_id.MPV_EVENT_SHUTDOWN:", 1
            )[0]
            self.assertIn("Timer.run(() => _finishAfterEndFile", end_file_case)
            self.assertNotIn("_complete(", end_file_case)

    def test_deferred_teardown_is_outside_callback_and_precedes_validation(self) -> None:
        for source in (self.fixed_baseline, self.candidate):
            end_file_case = source.split(
                "case generated.mpv_event_id.MPV_EVENT_END_FILE:", 1
            )[1].split(
                "case generated.mpv_event_id.MPV_EVENT_SHUTDOWN:", 1
            )[0]
            self.assertNotIn("_disposeNative()", end_file_case)
            self.assertNotIn("_complete(", end_file_case)
            finish_helper = source.split("  void _finishAfterEndFile(", 1)[1].split(
                "  void _complete(bool success)", 1
            )[0]
            self.assertLess(
                finish_helper.index("_disposeNative();"),
                finish_helper.index("output.existsSync()"),
            )
            self.assertLess(
                finish_helper.index("output.existsSync()"),
                finish_helper.index("_completer.complete(success)"),
            )

    def test_benchmark_applies_patch_to_release_and_profile_baseline(self) -> None:
        self.assertIn("apply_android_gif_common_lifecycle_fix.py", BENCHMARK_SCRIPT)
        self.assertGreaterEqual(
            BENCHMARK_SCRIPT.count("apply_baseline_correctness_patch"), 3
        )
        self.assertIn("correctness-fixed-baseline", BENCHMARK_SCRIPT)


if __name__ == "__main__":
    unittest.main()
