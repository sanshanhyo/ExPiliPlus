#!/usr/bin/env python3
"""Decode and check the fixed Android GIF benchmark output with Pillow."""

from __future__ import annotations

import hashlib
import json
import sys
from pathlib import Path

from PIL import Image


EXPECTED_WIDTH = 480
EXPECTED_HEIGHT = 270
MIN_FRAMES = 28
MAX_FRAMES = 32
MIN_DURATION_MS = 2800
MAX_DURATION_MS = 3200


class GifValidationError(ValueError):
    pass


def validate_gif(path: Path) -> dict[str, int | str]:
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
    if width != EXPECTED_WIDTH or height != EXPECTED_HEIGHT:
        raise GifValidationError(
            f"Expected {EXPECTED_WIDTH}x{EXPECTED_HEIGHT}, got {width}x{height}"
        )
    if not MIN_FRAMES <= frame_count <= MAX_FRAMES:
        raise GifValidationError(
            f"Expected {MIN_FRAMES}..{MAX_FRAMES} decoded frames, got {frame_count}"
        )
    if loop_count != 0:
        raise GifValidationError(f"Expected infinite GIF loop (0), got {loop_count!r}")
    if not MIN_DURATION_MS <= total_duration_ms <= MAX_DURATION_MS:
        raise GifValidationError(
            "Expected 2800..3200 ms total frame duration, "
            f"got {total_duration_ms} ms"
        )

    return {
        "codec": "gif",
        "width": width,
        "height": height,
        "decoded_frames": frame_count,
        "duration_ms": total_duration_ms,
        "loop_count": loop_count,
        "bytes": path.stat().st_size,
        "sha256": hashlib.sha256(path.read_bytes()).hexdigest(),
    }


def main() -> None:
    if len(sys.argv) != 3:
        raise SystemExit("usage: validate_android_gif.py INPUT.gif OUTPUT.json")
    gif_path = Path(sys.argv[1])
    report_path = Path(sys.argv[2])
    report = validate_gif(gif_path)
    report_path.parent.mkdir(parents=True, exist_ok=True)
    report_path.write_text(json.dumps(report, indent=2, sort_keys=True) + "\n")
    print(
        "verified_gif_decode=success "
        f"width={report['width']} height={report['height']} "
        f"decoded_frames={report['decoded_frames']} "
        f"duration_ms={report['duration_ms']} bytes={report['bytes']}"
    )


if __name__ == "__main__":
    main()
