#!/usr/bin/env python3
"""Require Android emulator action scripts to be single-line commands."""

from __future__ import annotations

import re
import sys
from pathlib import Path


_EMULATOR_ACTION = re.compile(
    r"^(?P<indent> *)uses:[ \t]*reactivecircus/android-emulator-runner@\S+\s*$"
)
_SCRIPT_INPUT = re.compile(r"^(?P<indent> *)script:[ \t]*(?P<value>.*)$")


def check_workflow_text(text: str) -> list[str]:
    lines = text.splitlines()
    errors: list[str] = []

    for index, line in enumerate(lines):
        action = _EMULATOR_ACTION.match(line)
        if action is None:
            continue

        action_indent = len(action.group("indent"))
        block_end = index + 1
        while block_end < len(lines):
            candidate = lines[block_end]
            if candidate.strip() and len(candidate) - len(candidate.lstrip(" ")) < action_indent:
                break
            block_end += 1

        script_inputs = []
        for line_index in range(index + 1, block_end):
            script = _SCRIPT_INPUT.match(lines[line_index])
            if script is not None:
                script_inputs.append((line_index + 1, script.group("value").strip()))

        if len(script_inputs) != 1:
            errors.append(
                f"line {index + 1}: expected exactly one inline `script:` command "
                f"for Android emulator action; found {len(script_inputs)}"
            )
            continue

        line_number, value = script_inputs[0]
        if not value or value in {"|", "|-", "|+", ">", ">-", ">+"}:
            errors.append(
                f"line {line_number}: emulator action `script:` must be one inline command; "
                "put multi-step logic in a checked-in shell script"
            )
        elif value.endswith("\\"):
            errors.append(
                f"line {line_number}: emulator action `script:` must not end with a "
                "shell line-continuation backslash"
            )

    return errors


def main() -> int:
    workflow_dir = Path(__file__).resolve().parents[1] / "workflows"
    workflows = sorted((*workflow_dir.glob("*.yml"), *workflow_dir.glob("*.yaml")))
    errors: list[str] = []

    for workflow in workflows:
        for error in check_workflow_text(workflow.read_text(encoding="utf-8")):
            errors.append(f"{workflow.relative_to(workflow_dir.parent.parent)}:{error}")

    if errors:
        print("Android emulator workflow script check failed:", file=sys.stderr)
        print("\n".join(errors), file=sys.stderr)
        return 1

    print(f"Checked Android emulator script inputs in {len(workflows)} workflow files.")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
