#!/usr/bin/env python3
"""Verify release lock only removes the Android integration-test SDK graph."""

from __future__ import annotations

import argparse
import json
from pathlib import Path

from verify_android_benchmark_lock import validate_production_lock


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--full-lock", required=True, type=Path)
    parser.add_argument("--production-lock", required=True, type=Path)
    parser.add_argument("--report", required=True, type=Path)
    args = parser.parse_args()

    report = validate_production_lock(
        args.full_lock.read_text(encoding="utf-8"),
        args.production_lock.read_text(encoding="utf-8"),
    )
    args.report.parent.mkdir(parents=True, exist_ok=True)
    args.report.write_text(
        json.dumps(report, indent=2, sort_keys=True) + "\n", encoding="utf-8"
    )
    print(
        "Verified production dependency graph: "
        f"full={report['full_lock_sha256']} "
        f"production={report['production_lock_sha256']} "
        f"retained={report['retained_packages']} "
        f"removed={','.join(report['removed_test_only_packages'])}"
    )
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
