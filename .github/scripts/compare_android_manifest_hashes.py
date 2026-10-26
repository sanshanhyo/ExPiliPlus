#!/usr/bin/env python3
"""Compare sha256sum output without treating the recorded file path as content."""

from __future__ import annotations

import argparse
import re
from pathlib import Path


_SHA256 = re.compile(r"^[0-9a-fA-F]{64}$")


def read_digest(path: Path) -> str:
    fields = path.read_text(encoding="utf-8").split(maxsplit=1)
    if len(fields) != 2 or not _SHA256.fullmatch(fields[0]):
        raise ValueError(f"Invalid sha256sum output in {path}")
    return fields[0].lower()


def compare_manifest_hashes(baseline: Path, candidate: Path) -> str:
    baseline_digest = read_digest(baseline)
    candidate_digest = read_digest(candidate)
    if baseline_digest != candidate_digest:
        raise ValueError(
            "Baseline and candidate production manifest content hashes differ: "
            f"{baseline_digest} != {candidate_digest}"
        )
    return baseline_digest


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("baseline", type=Path)
    parser.add_argument("candidate", type=Path)
    args = parser.parse_args()
    print(compare_manifest_hashes(args.baseline, args.candidate))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
