#!/usr/bin/env python3
"""Report exact APK bytes and ZIP component sizes for a paired build."""

from __future__ import annotations

import argparse
import hashlib
import json
import re
import zipfile
from pathlib import Path
from typing import Any


def _component(path: str) -> str:
    parts = path.split("/")
    if len(parts) >= 3 and parts[0] == "lib":
        return f"native/{parts[1]}"
    if path.startswith("assets/flutter_assets/"):
        return "flutter_assets"
    if re.fullmatch(r"classes(?:\d+)?\.dex", path):
        return "dex"
    if path.startswith("META-INF/"):
        return "metadata"
    return parts[0] if len(parts) > 1 else "root"


def inspect_apk(apk_path: Path) -> dict[str, Any]:
    digest = hashlib.sha256(apk_path.read_bytes()).hexdigest()
    components: dict[str, dict[str, int]] = {}
    native_libraries: list[dict[str, Any]] = []
    with zipfile.ZipFile(apk_path) as apk:
        for entry in apk.infolist():
            if entry.is_dir():
                continue
            name = entry.filename
            component = _component(name)
            totals = components.setdefault(
                component, {"compressed_bytes": 0, "uncompressed_bytes": 0}
            )
            totals["compressed_bytes"] += entry.compress_size
            totals["uncompressed_bytes"] += entry.file_size
            if name.startswith("lib/") and name.endswith(".so"):
                native_libraries.append(
                    {
                        "path": name,
                        "compressed_bytes": entry.compress_size,
                        "uncompressed_bytes": entry.file_size,
                        "compression_method": entry.compress_type,
                    }
                )

    return {
        "path": apk_path.name,
        "apk_bytes": apk_path.stat().st_size,
        "sha256": digest,
        "components": dict(sorted(components.items())),
        "native_libraries": sorted(native_libraries, key=lambda item: item["path"]),
    }


def compare_apks(
    baseline: Path,
    candidate: Path,
    baseline_sha: str,
    candidate_sha: str,
) -> dict[str, Any]:
    before = inspect_apk(baseline)
    after = inspect_apk(candidate)
    delta = after["apk_bytes"] - before["apk_bytes"]
    percent = delta * 100 / before["apk_bytes"] if before["apk_bytes"] else None
    components = sorted(set(before["components"]) | set(after["components"]))
    component_delta = {}
    for name in components:
        before_size = before["components"].get(name, {}).get("compressed_bytes", 0)
        after_size = after["components"].get(name, {}).get("compressed_bytes", 0)
        component_delta[name] = {
            "baseline_compressed_bytes": before_size,
            "candidate_compressed_bytes": after_size,
            "delta_bytes": after_size - before_size,
        }
    return {
        "baseline_sha": baseline_sha,
        "candidate_sha": candidate_sha,
        "apk_download_size": {
            "baseline_bytes": before["apk_bytes"],
            "candidate_bytes": after["apk_bytes"],
            "delta_bytes": delta,
            "delta_percent": percent,
        },
        "component_compressed_bytes": component_delta,
        "baseline": before,
        "candidate": after,
    }


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--baseline", required=True, type=Path)
    parser.add_argument("--candidate", required=True, type=Path)
    parser.add_argument("--baseline-sha", required=True)
    parser.add_argument("--candidate-sha", required=True)
    parser.add_argument("--output", required=True, type=Path)
    args = parser.parse_args()
    report = compare_apks(
        args.baseline,
        args.candidate,
        args.baseline_sha,
        args.candidate_sha,
    )
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(
        json.dumps(report, indent=2, sort_keys=True) + "\n", encoding="utf-8"
    )


if __name__ == "__main__":
    main()
