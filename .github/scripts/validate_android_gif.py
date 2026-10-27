#!/usr/bin/env python3
"""Decode and check the fixed Android GIF benchmark output with Pillow."""

from __future__ import annotations

import hashlib
import json
import sys
from pathlib import Path
from typing import Any

from PIL import Image


EXPECTED_WIDTH = 480
EXPECTED_HEIGHT = 270
MIN_FRAMES = 28
MAX_FRAMES = 32
MIN_DURATION_MS = 2800
MAX_DURATION_MS = 3200


class GifValidationError(ValueError):
    pass


def benchmark_contract_passed(report: dict[str, Any]) -> bool:
    return (
        report.get("width") == EXPECTED_WIDTH
        and report.get("height") == EXPECTED_HEIGHT
        and MIN_FRAMES <= report.get("decoded_frames", 0) <= MAX_FRAMES
        and report.get("loop_count") == 0
        and MIN_DURATION_MS <= report.get("duration_ms", 0) <= MAX_DURATION_MS
    )


def validate_gif(
    path: Path, *, require_benchmark_contract: bool = True
) -> dict[str, Any]:
    if not path.is_file() or path.stat().st_size == 0:
        raise GifValidationError("GIF output is missing or empty")

    try:
        with Image.open(path) as image:
            if image.format != "GIF":
                raise GifValidationError(f"Expected GIF format, got {image.format!r}")
            width, height = image.size
            frame_count = image.n_frames
            loop_count = image.info.get("loop")
            durations: list[int] = []
            for frame_index in range(frame_count):
                image.seek(frame_index)
                image.load()
                duration = image.info.get("duration")
                if not isinstance(duration, int) or duration <= 0:
                    raise GifValidationError(
                        f"Frame {frame_index} has invalid duration {duration!r}"
                    )
                durations.append(duration)
    except GifValidationError:
        raise
    except Exception as error:
        raise GifValidationError(f"GIF frame decode failed: {error}") from error

    total_duration_ms = sum(durations)
    report: dict[str, Any] = {
        "codec": "gif",
        "width": width,
        "height": height,
        "decoded_frames": frame_count,
        "duration_ms": total_duration_ms,
        "loop_count": loop_count,
        "bytes": path.stat().st_size,
        "sha256": hashlib.sha256(path.read_bytes()).hexdigest(),
    }
    report["benchmark_contract_passed"] = benchmark_contract_passed(report)
    if require_benchmark_contract and not report["benchmark_contract_passed"]:
        raise GifValidationError(
            "GIF decoded, but failed the strict benchmark contract: "
            f"{report}"
        )
    return report


def main() -> None:
    if len(sys.argv) not in (3, 4):
        raise SystemExit(
            "usage: validate_android_gif.py INPUT.gif OUTPUT.json [--diagnostic]"
        )
    gif_path = Path(sys.argv[1])
    report_path = Path(sys.argv[2])
    diagnostic = len(sys.argv) == 4 and sys.argv[3] == "--diagnostic"
    if len(sys.argv) == 4 and not diagnostic:
        raise SystemExit(f"unsupported option: {sys.argv[3]}")
    report = validate_gif(
        gif_path, require_benchmark_contract=not diagnostic
    )
    report_path.parent.mkdir(parents=True, exist_ok=True)
    report_path.write_text(json.dumps(report, indent=2, sort_keys=True) + "\n")
    label = "diagnostic_gif_decode" if diagnostic else "verified_gif_decode"
    print(
        f"{label}=success "
        f"benchmark_contract_passed={report['benchmark_contract_passed']} "
        f"width={report['width']} height={report['height']} "
        f"decoded_frames={report['decoded_frames']} "
        f"duration_ms={report['duration_ms']} bytes={report['bytes']}"
    )


if __name__ == "__main__":
    main()
