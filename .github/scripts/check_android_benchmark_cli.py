#!/usr/bin/env python3
"""Check the pinned Flutter drive CLI against options used by the benchmark."""

from __future__ import annotations

import argparse
import re
import subprocess
import sys
from pathlib import Path


_OPTION = re.compile(r"(?<![\w-])(--[a-z][a-z0-9-]*|-[a-z])(?=[,=\s]|$)")
_DRIVE_START = re.compile(r"^\s+flutter drive\b", re.MULTILINE)


def drive_options(script: str) -> set[str]:
    match = _DRIVE_START.search(script)
    if match is None:
        raise ValueError("No flutter drive invocation was found in benchmark script")
    command_end = script.find(') > "$output_dir/profile-benchmark.log"', match.start())
    if command_end < 0:
        raise ValueError("Could not find the end of the flutter drive invocation")
    return set(_OPTION.findall(script[match.start() : command_end]))


def validate_drive_options(help_text: str, script: str) -> set[str]:
    supported = set(_OPTION.findall(help_text))
    used = drive_options(script)
    unsupported = used - supported
    if unsupported:
        raise ValueError(
            "Pinned Flutter drive help does not support benchmark options: "
            + ", ".join(sorted(unsupported))
        )
    return used


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument(
        "--script",
        type=Path,
        default=Path(".github/scripts/run_android_benchmark.sh"),
    )
    parser.add_argument("--help-output", type=Path)
    args = parser.parse_args()

    result = subprocess.run(
        ["flutter", "drive", "--help"],
        check=False,
        stdout=subprocess.PIPE,
        stderr=subprocess.STDOUT,
        text=True,
    )
    if args.help_output is not None:
        args.help_output.parent.mkdir(parents=True, exist_ok=True)
        args.help_output.write_text(result.stdout, encoding="utf-8")
    if result.returncode != 0:
        print(result.stdout, file=sys.stderr)
        raise SystemExit(f"flutter drive --help failed with status {result.returncode}")

    try:
        used = validate_drive_options(
            result.stdout, args.script.read_text(encoding="utf-8")
        )
    except ValueError as error:
        print(result.stdout, file=sys.stderr)
        raise SystemExit(str(error)) from error

    print("Flutter drive options verified: " + ", ".join(sorted(used)))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
