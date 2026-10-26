#!/usr/bin/env python3
"""Enable the two FFmpeg filters used by ExPiliPlus GIF conversion."""

from __future__ import annotations

import sys
from pathlib import Path

MARKER = "\t--enable-filter=equalizer \\\n"
FILTERS = "\t--enable-filter=fps \\\n\t--enable-filter=scale \\\n"


def enable_gif_filters(config: str) -> str:
    marker_count = config.count(MARKER)
    fps_count = config.count("\t--enable-filter=fps \\\n")
    scale_count = config.count("\t--enable-filter=scale \\\n")
    if marker_count == 1 and fps_count == 0 and scale_count == 0:
        return config.replace(MARKER, MARKER + FILTERS, 1)
    if marker_count == 1 and fps_count == 1 and scale_count == 1:
        expected = MARKER + FILTERS
        if config.count(expected) == 1:
            return config
    raise ValueError(
        "Pinned FFmpeg default.sh did not contain one unmodified equalizer filter; "
        f"marker={marker_count}, fps={fps_count}, scale={scale_count}"
    )


def patch_file(path: Path) -> None:
    original = path.read_text(encoding="utf-8")
    updated = enable_gif_filters(original)
    if updated != original:
        path.write_text(updated, encoding="utf-8")
    print("android_gif_filters=fps,scale")


def main() -> int:
    if len(sys.argv) != 2:
        print("usage: enable_android_gif_filters.py PATH_TO_DEFAULT_SH", file=sys.stderr)
        return 2
    try:
        patch_file(Path(sys.argv[1]))
    except (OSError, ValueError) as error:
        print(f"could not enable Android GIF filters: {error}", file=sys.stderr)
        return 1
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
