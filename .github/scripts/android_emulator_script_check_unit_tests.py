from __future__ import annotations

import unittest

from check_android_emulator_scripts import check_workflow_text


class AndroidEmulatorScriptCheckTest(unittest.TestCase):
    def test_accepts_single_line_emulator_command(self) -> None:
        workflow = """jobs:
  run:
    steps:
      - name: Android test
        uses: reactivecircus/android-emulator-runner@v2
        with:
          script: bash .github/scripts/android_integration_test.sh /tmp/evidence
"""
        self.assertEqual(check_workflow_text(workflow), [])

    def test_rejects_block_script_with_line_continuation(self) -> None:
        workflow = """jobs:
  run:
    steps:
      - name: Android test
        uses: reactivecircus/android-emulator-runner@v2
        with:
          script: |
            bash .github/scripts/run_android_benchmark.sh \\
              baseline candidate evidence
"""
        errors = check_workflow_text(workflow)
        self.assertEqual(len(errors), 1)
        self.assertIn("one inline command", errors[0])

    def test_rejects_trailing_continuation_on_inline_script(self) -> None:
        workflow = """jobs:
  run:
    steps:
      - name: Android test
        uses: reactivecircus/android-emulator-runner@v2
        with:
          script: bash run.sh \\
"""
        errors = check_workflow_text(workflow)
        self.assertEqual(len(errors), 1)
        self.assertIn("line-continuation backslash", errors[0])

    def test_ignores_non_emulator_multiline_scripts(self) -> None:
        workflow = """jobs:
  run:
    steps:
      - name: Github script
        uses: actions/github-script@v9
        with:
          script: |
            const ok = true;
"""
        self.assertEqual(check_workflow_text(workflow), [])


if __name__ == "__main__":
    unittest.main()
