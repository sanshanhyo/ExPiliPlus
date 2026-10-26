#!/usr/bin/env python3
"""Embed a generated local MP4 in the temporary integration-test source."""

from __future__ import annotations

import base64
import sys
import textwrap
from pathlib import Path


def main() -> None:
    if len(sys.argv) != 3:
        raise SystemExit(
            "usage: embed_android_benchmark_video.py INPUT.mp4 OUTPUT.dart"
        )

    source = Path(sys.argv[1]).read_bytes()
    if not source:
        raise SystemExit("synthetic video fixture is empty")
    encoded = base64.b64encode(source).decode("ascii")
    chunks = textwrap.wrap(encoded, 96)
    lines = [
        "import 'dart:convert';",
        "import 'dart:typed_data';",
        "",
        "const List<String> _videoBase64Chunks = <String>[",
        *(f"  '{chunk}'," for chunk in chunks),
        "];",
        "",
        "final Uint8List androidBenchmarkVideoBytes =",
        "    base64Decode(_videoBase64Chunks.join());",
        "",
    ]
    output = Path(sys.argv[2])
    output.parent.mkdir(parents=True, exist_ok=True)
    output.write_text("\n".join(lines), encoding="utf-8")


if __name__ == "__main__":
    main()
