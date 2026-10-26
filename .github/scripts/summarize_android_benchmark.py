#!/usr/bin/env python3
"""Combine APK, GIF timing and sampled Android memory measurements."""

from __future__ import annotations

import argparse
import csv
import json
import statistics
from pathlib import Path
from typing import Any


def _load_json(path: Path) -> dict[str, Any]:
    return json.loads(path.read_text(encoding="utf-8"))


def _memory_summary(path: Path) -> dict[str, Any]:
    samples: list[dict[str, int]] = []
    if path.exists():
        with path.open(newline="", encoding="utf-8") as source:
            for row in csv.DictReader(source):
                if row.get("total_pss_kb", "").isdigit():
                    samples.append(
                        {
                            "elapsed_seconds": int(row["elapsed_seconds"]),
                            "total_pss_kb": int(row["total_pss_kb"]),
                        }
                    )
    values = [sample["total_pss_kb"] for sample in samples]
    return {
        "sample_count": len(values),
        "sampling_interval_seconds": 1,
        "max_total_pss_kb": max(values) if values else None,
        "median_total_pss_kb": statistics.median(values) if values else None,
        "samples": samples,
    }


def _timing_comparison(before: dict[str, Any], after: dict[str, Any]) -> dict[str, Any]:
    before_ms = int(before["median_ms"])
    after_ms = int(after["median_ms"])
    delta = after_ms - before_ms
    return {
        "baseline_median_ms": before_ms,
        "candidate_median_ms": after_ms,
        "delta_ms": delta,
        "delta_percent": delta * 100 / before_ms if before_ms else None,
        "baseline_runs_ms": before["measured_runs"],
        "candidate_runs_ms": after["measured_runs"],
    }


def _memory_comparison(before: dict[str, Any], after: dict[str, Any]) -> dict[str, Any]:
    before_max = before["max_total_pss_kb"]
    after_max = after["max_total_pss_kb"]
    before_median = before["median_total_pss_kb"]
    after_median = after["median_total_pss_kb"]

    def delta(before_value: Any, after_value: Any) -> dict[str, Any]:
        if before_value is None or after_value is None:
            return {"baseline": before_value, "candidate": after_value, "delta": None, "delta_percent": None}
        difference = after_value - before_value
        return {
            "baseline": before_value,
            "candidate": after_value,
            "delta": difference,
            "delta_percent": difference * 100 / before_value if before_value else None,
        }

    return {
        "max_total_pss_kb": delta(before_max, after_max),
        "median_total_pss_kb": delta(before_median, after_median),
        "baseline_samples": before["sample_count"],
        "candidate_samples": after["sample_count"],
    }


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--evidence-dir", required=True, type=Path)
    parser.add_argument("--baseline-sha", required=True)
    parser.add_argument("--candidate-sha", required=True)
    parser.add_argument("--output", required=True, type=Path)
    args = parser.parse_args()

    baseline = args.evidence_dir / "baseline"
    candidate = args.evidence_dir / "candidate"
    size = _load_json(args.evidence_dir / "apk-size-comparison.json")
    before_gif = _load_json(baseline / "gif-benchmark.json")
    after_gif = _load_json(candidate / "gif-benchmark.json")
    if before_gif["fixture_sha256"] != after_gif["fixture_sha256"]:
        raise SystemExit("Baseline and candidate used different video fixtures")
    if before_gif["options"] != after_gif["options"]:
        raise SystemExit("Baseline and candidate used different GIF options")
    if not before_gif["result"]["valid"] or not after_gif["result"]["valid"]:
        raise SystemExit("At least one native GIF output failed structural validation")
    report = {
        "baseline_sha": args.baseline_sha,
        "candidate_sha": args.candidate_sha,
        "environment": {
            "platform": "Android emulator, API 35, x86_64, Pixel 6 profile, SwiftShader, no audio",
            "performance_note": "Comparative CI emulator measurements; not a physical-device performance claim.",
            "memory_note": "Android TOTAL PSS sampled by adb once per second during profile integration test.",
        },
        "apk_size": size["apk_download_size"],
        "apk_components": size["component_compressed_bytes"],
        "gif_options": before_gif["options"],
        "fixture_sha256": before_gif["fixture_sha256"],
        "gif_timing": _timing_comparison(before_gif, after_gif),
        "gif_memory": _memory_comparison(
            _memory_summary(baseline / "memory.csv"),
            _memory_summary(candidate / "memory.csv"),
        ),
        "gif_correctness": {
            "baseline": before_gif["result"],
            "candidate": after_gif["result"],
            "fixture_and_options_match": (
                before_gif["fixture_sha256"] == after_gif["fixture_sha256"]
                and before_gif["options"] == after_gif["options"]
            ),
        },
    }
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(
        json.dumps(report, indent=2, sort_keys=True) + "\n", encoding="utf-8"
    )


if __name__ == "__main__":
    main()
