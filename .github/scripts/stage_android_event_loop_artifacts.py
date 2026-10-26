#!/usr/bin/env python3
"""Stage the lock-matched event-loop .so into temporary Android GIF JARs."""

from __future__ import annotations

import argparse
import hashlib
import re
import shutil
import subprocess
import tempfile
import zipfile
from pathlib import Path


SOURCE_REPOSITORY = "https://github.com/My-Responsitories/media-kit.git"
SOURCE_COMMIT = "73771ec38176be2d984a3049c28177bce23b54a0"
JARS = (
    ("arm64-v8a", "default-arm64-v8a.jar"),
    ("armeabi-v7a", "default-armeabi-v7a.jar"),
    ("x86_64", "default-x86_64.jar"),
)
EVENT_LOOP_PATH_TEMPLATE = "lib/{abi}/libmedia_kit_native_event_loop.so"
METADATA_PREFIX = "media_kit_native_event_loop_"
LICENSE_INVENTORY_ENTRY = "media_kit_native_event_loop/LICENSE"


def sha256_file(path: Path) -> str:
    digest = hashlib.sha256()
    with path.open("rb") as source:
        for block in iter(lambda: source.read(1024 * 1024), b""):
            digest.update(block)
    return digest.hexdigest()


def file_size(path: Path) -> int:
    return path.stat().st_size


def _zip_entries(path: Path) -> dict[str, bytes]:
    with zipfile.ZipFile(path) as archive:
        names = [info.filename for info in archive.infolist()]
        duplicates = sorted({name for name in names if names.count(name) > 1})
        if duplicates:
            raise ValueError(f"Duplicate entries in {path}: {', '.join(duplicates)}")
        bad_entry = archive.testzip()
        if bad_entry:
            raise ValueError(f"Corrupt ZIP entry in {path}: {bad_entry}")
        return {name: archive.read(name) for name in names}


def _copy_archive_with_event_loop(
    source_jar: Path,
    output_jar: Path,
    abi: str,
    event_loop_so: Path,
    scratch_root: Path,
) -> None:
    event_path = EVENT_LOOP_PATH_TEMPLATE.format(abi=abi)
    original_entries = _zip_entries(source_jar)
    if event_path not in original_entries:
        raise ValueError(f"{source_jar} is missing {event_path}")

    shutil.copy2(source_jar, output_jar)
    scratch_dir = scratch_root / abi
    entry_file = scratch_dir / event_path
    entry_file.parent.mkdir(parents=True)
    shutil.copyfile(event_loop_so, entry_file)
    result = subprocess.run(
        ["zip", "-q", "-9", str(output_jar), event_path],
        cwd=scratch_dir,
        check=False,
        capture_output=True,
        text=True,
    )
    if result.returncode != 0:
        raise RuntimeError(
            f"zip failed for {source_jar.name} ({abi}), exit {result.returncode}: "
            f"{result.stderr.strip()}"
        )

    staged_entries = _zip_entries(output_jar)
    if staged_entries.keys() != original_entries.keys():
        raise ValueError(f"Staged JAR entry set changed for {source_jar.name}")
    for name, content in original_entries.items():
        if name == event_path:
            if content == staged_entries[name]:
                raise ValueError(f"Event-loop library was not replaced in {source_jar.name}")
        elif staged_entries[name] != content:
            raise ValueError(f"Unexpected JAR content changed: {source_jar.name}:{name}")
    if staged_entries[event_path] != event_loop_so.read_bytes():
        raise ValueError(f"Staged event-loop bytes do not match built library: {source_jar.name}")


def _metadata_rows(artifact_dir: Path) -> dict[str, str]:
    metadata_path = artifact_dir / "build-metadata.txt"
    if not metadata_path.is_file():
        raise ValueError(f"GIF artifact metadata is missing: {metadata_path}")
    rows: dict[str, str] = {}
    for line in metadata_path.read_text(encoding="utf-8").splitlines():
        fields = line.split()
        if len(fields) == 4 and fields[0].endswith(".jar") and fields[3] == "bytes":
            rows[fields[0]] = line
    return rows


def _write_metadata(
    artifact_dir: Path,
    source_dir: Path,
    patch_file: Path,
    ndk_version: str,
    host_contract_test: str,
) -> None:
    metadata_path = artifact_dir / "build-metadata.txt"
    old_lines = metadata_path.read_text(encoding="utf-8").splitlines()
    source_files = (
        source_dir / "src/media_kit_native_event_loop.cc",
        source_dir / "src/media_kit_native_event_loop.h",
        source_dir / "src/dart_api_types.h",
        source_dir / "LICENSE",
        patch_file,
    )
    missing = [path for path in source_files if not path.is_file()]
    if missing:
        raise ValueError("Event-loop source manifest is incomplete: " + ", ".join(map(str, missing)))

    manifest_hash = hashlib.sha256()
    for path in source_files:
        manifest_hash.update(path.name.encode("utf-8"))
        manifest_hash.update(b"\0")
        manifest_hash.update(bytes.fromhex(sha256_file(path)))

    additional = {
        "media_kit_native_event_loop_source_repository": SOURCE_REPOSITORY,
        "media_kit_native_event_loop_source_commit": SOURCE_COMMIT,
        "media_kit_native_event_loop_api": "legacy-wakeup-callback-v1",
        "media_kit_native_event_loop_ndk_version": ndk_version,
        "media_kit_native_event_loop_source_manifest_sha256": manifest_hash.hexdigest(),
        "media_kit_native_event_loop_license": "MIT",
        "media_kit_native_event_loop_license_sha256": sha256_file(source_dir / "LICENSE"),
        "media_kit_native_event_loop_patch_sha256": sha256_file(patch_file),
        "media_kit_native_event_loop_callback_contract_test": host_contract_test,
    }
    jar_rows = {
        name: f"{name} {sha256_file(artifact_dir / name)} {file_size(artifact_dir / name)} bytes"
        for _, name in JARS
    }

    result: list[str] = []
    inserted = False
    for line in old_lines:
        if line.startswith(METADATA_PREFIX):
            continue
        if line == "artifacts=":
            result.extend(f"{key}={value}" for key, value in additional.items())
            inserted = True
            result.append(line)
            continue
        fields = line.split()
        if fields and fields[0] in jar_rows:
            result.append(jar_rows.pop(fields[0]))
        else:
            result.append(line)
    if not inserted:
        raise ValueError("GIF artifact metadata is missing the artifacts= section")
    if jar_rows:
        raise ValueError("GIF artifact metadata is missing JAR rows: " + ", ".join(jar_rows))
    metadata_path.write_text("\n".join(result) + "\n", encoding="utf-8")


def stage_artifacts(
    base_artifacts: Path,
    native_libs: Path,
    output_dir: Path,
    source_dir: Path,
    patch_file: Path,
    ndk_version: str,
    host_contract_test: str = "passed",
) -> None:
    base_artifacts = base_artifacts.resolve()
    native_libs = native_libs.resolve()
    output_dir = output_dir.resolve()
    source_dir = source_dir.resolve()
    patch_file = patch_file.resolve()
    if output_dir == base_artifacts or base_artifacts in output_dir.parents:
        raise ValueError("Staged artifacts must be outside the checked-in source artifacts directory")
    if not (base_artifacts / "source-license.txt").is_file():
        raise ValueError("Base GIF artifact source license is missing")
    if not (base_artifacts / "licenses.txt").is_file():
        raise ValueError("Base GIF artifact license inventory is missing")

    upstream_license = (
        base_artifacts
        / "licenses/buildscripts/deps/media_kit/media_kit_native_event_loop/LICENSE"
    )
    if not upstream_license.is_file() or upstream_license.read_bytes() != (source_dir / "LICENSE").read_bytes():
        raise ValueError("Locked event-loop MIT license does not match the packaged inventory")

    rows = _metadata_rows(base_artifacts)
    if set(rows) != {name for _, name in JARS}:
        raise ValueError("Base GIF artifact metadata does not list exactly the three Android ABI JARs")

    if output_dir.exists():
        shutil.rmtree(output_dir)
    shutil.copytree(base_artifacts, output_dir)
    with tempfile.TemporaryDirectory(prefix="android-event-loop-stage-") as temporary:
        scratch_root = Path(temporary)
        for abi, name in JARS:
            source_jar = base_artifacts / name
            output_jar = output_dir / name
            event_loop_so = native_libs / abi / "libmedia_kit_native_event_loop.so"
            if not event_loop_so.is_file() or event_loop_so.stat().st_size == 0:
                raise ValueError(f"Built event-loop library is missing or empty: {event_loop_so}")
            _copy_archive_with_event_loop(
                source_jar, output_jar, abi, event_loop_so, scratch_root
            )

    license_inventory = output_dir / "licenses.txt"
    entries = license_inventory.read_text(encoding="utf-8").splitlines()
    if LICENSE_INVENTORY_ENTRY not in entries:
        entries.append(LICENSE_INVENTORY_ENTRY)
    license_inventory.write_text("\n".join(entries) + "\n", encoding="utf-8")
    license_copy = output_dir / "licenses" / "media_kit_native_event_loop-source-LICENSE"
    license_copy.parent.mkdir(parents=True, exist_ok=True)
    shutil.copyfile(source_dir / "LICENSE", license_copy)

    _write_metadata(
        output_dir,
        source_dir,
        patch_file,
        ndk_version,
        host_contract_test,
    )


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--base-artifacts", type=Path, required=True)
    parser.add_argument("--native-libs", type=Path, required=True)
    parser.add_argument("--output-dir", type=Path, required=True)
    parser.add_argument("--source-dir", type=Path, required=True)
    parser.add_argument("--patch-file", type=Path, required=True)
    parser.add_argument("--ndk-version", required=True)
    parser.add_argument("--host-contract-test", default="passed")
    arguments = parser.parse_args()
    stage_artifacts(
        arguments.base_artifacts,
        arguments.native_libs,
        arguments.output_dir,
        arguments.source_dir,
        arguments.patch_file,
        arguments.ndk_version,
        arguments.host_contract_test,
    )
    print(f"Staged ABI-matched GIF artifacts at {arguments.output_dir.resolve()}")
    for _, jar_name in JARS:
        jar = arguments.output_dir / jar_name
        print(f"staged_jar={jar_name} sha256={sha256_file(jar)} size_bytes={file_size(jar)}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
