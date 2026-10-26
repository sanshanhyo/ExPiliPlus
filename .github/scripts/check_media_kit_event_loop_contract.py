#!/usr/bin/env python3
"""Check the locked media_kit Dart side against the Android native ABI source."""

from __future__ import annotations

import json
import re
import sys
from pathlib import Path
from urllib.parse import unquote, urljoin, urlparse


LOCKED_COMMIT = "73771ec38176be2d984a3049c28177bce23b54a0"
PACKAGE_NAMES = ("media_kit", "media_kit_native_event_loop")
REQUIRED_DART_MARKERS = (
    "MediaKitEventLoopHandlerInitializeCXX",
    "MediaKitEventLoopHandlerCallback",
    "NativeApi.postCObject",
    "_receiver.sendPort.nativePort",
    "Dart_CObject_kInt64",
    "mpv.mpv_set_wakeup_callback(handle, _handle, handle.cast());",
    "NativePlayer.mpv.mpv_set_wakeup_callback(handle, nullptr, nullptr);",
    "_callbacks.remove(handle.address)",
)
INCOMPATIBLE_DART_MARKERS = (
    "MediaKitEventLoopHandlerRegisterCXX",
    "MediaKitEventLoopHandlerNotifyCXX",
    "MediaKitEventLoopHandlerDisposeCXX",
)


def _lock_package_block(lock_text: str, name: str) -> str:
    lines = lock_text.splitlines()
    start = next(
        (index for index, line in enumerate(lines) if line == f"  {name}:"),
        None,
    )
    if start is None:
        raise ValueError(f"pubspec.lock is missing {name}")
    end = next(
        (
            index
            for index in range(start + 1, len(lines))
            if re.match(r"^  [^ ].*:$", lines[index])
        ),
        len(lines),
    )
    return "\n".join(lines[start:end])


def _package_root(config_path: Path, root_uri: str) -> Path:
    base_uri = config_path.parent.resolve().as_uri().rstrip("/") + "/"
    absolute_uri = urljoin(base_uri, root_uri)
    parsed = urlparse(absolute_uri)
    if parsed.scheme != "file":
        raise ValueError(f"media_kit package root is not a file URI: {root_uri}")
    return Path(unquote(parsed.path)).resolve()


def verify_contract(project_root: Path) -> Path:
    project_root = project_root.resolve()
    lock_path = project_root / "pubspec.lock"
    config_path = project_root / ".dart_tool" / "package_config.json"
    if not lock_path.is_file() or not config_path.is_file():
        raise ValueError("Run flutter pub get before checking the media_kit FFI contract")

    lock_text = lock_path.read_text(encoding="utf-8")
    for package_name in PACKAGE_NAMES:
        block = _lock_package_block(lock_text, package_name)
        if "source: git" not in block or f'resolved-ref: "{LOCKED_COMMIT}"' not in block:
            raise ValueError(
                f"{package_name} is not resolved from the locked FFI source "
                f"{LOCKED_COMMIT}"
            )

    package_config = json.loads(config_path.read_text(encoding="utf-8"))
    package = next(
        (item for item in package_config.get("packages", []) if item.get("name") == "media_kit"),
        None,
    )
    if package is None or not isinstance(package.get("rootUri"), str):
        raise ValueError(".dart_tool/package_config.json has no media_kit rootUri")
    package_root = _package_root(config_path, package["rootUri"])
    dart_file = package_root / "lib/src/player/native/core/initializer_native_event_loop.dart"
    if not dart_file.is_file():
        raise ValueError(f"Locked media_kit FFI source is missing: {dart_file}")

    dart_source = dart_file.read_text(encoding="utf-8")
    missing = [marker for marker in REQUIRED_DART_MARKERS if marker not in dart_source]
    if missing:
        raise ValueError("Locked Dart event-loop contract markers are missing: " + ", ".join(missing))
    incompatible = [marker for marker in INCOMPATIBLE_DART_MARKERS if marker in dart_source]
    if incompatible:
        raise ValueError("Dart event-loop API does not match the callback ABI: " + ", ".join(incompatible))

    return dart_file


def main(argv: list[str]) -> int:
    if len(argv) != 2:
        print(f"Usage: {Path(argv[0]).name} PROJECT_ROOT", file=sys.stderr)
        return 2
    try:
        dart_file = verify_contract(Path(argv[1]))
    except (OSError, ValueError, json.JSONDecodeError) as error:
        print(f"media_kit Android event-loop contract check failed: {error}", file=sys.stderr)
        return 1
    print(f"media_kit Dart FFI contract matches locked callback ABI: {dart_file}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main(sys.argv))
