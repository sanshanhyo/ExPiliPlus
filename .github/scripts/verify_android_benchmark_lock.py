#!/usr/bin/env python3
"""Validate the narrowly expected lockfile metadata refresh for Android CI."""

from __future__ import annotations

import argparse
import hashlib
import json
import re
from pathlib import Path
from typing import Any


_PACKAGE_HEADER = re.compile(r"^  (?P<name>[A-Za-z0-9_.-]+):\s*$")
_FIELD = re.compile(r"^    (?P<name>[A-Za-z0-9_-]+):(?:[ \t]*(?P<value>.*))?$")
_DESCRIPTION_FIELD = re.compile(
    r"^      (?P<name>[A-Za-z0-9_-]+):(?:[ \t]*(?P<value>.*))?$"
)

EXPECTED_ADDED = {
    "flutter_driver",
    "fuchsia_remote_debug_protocol",
    "sync_http",
    "webdriver",
}
EXPECTED_REMOVED = {"gtk", "menu_base", "shortid"}
EXPECTED_DEPENDENCY_CHANGES = {
    "cupertino_ui": ("transitive", "direct main"),
    "ffi": ("transitive", "direct main"),
}


class LockNormalizationError(ValueError):
    pass


def _scalar(value: str) -> str | None:
    value = value.strip()
    if not value:
        return None
    if value.startswith('"'):
        try:
            parsed = json.loads(value)
        except json.JSONDecodeError as error:
            raise LockNormalizationError(f"Invalid quoted lock scalar: {value}") from error
        if not isinstance(parsed, str):
            raise LockNormalizationError(f"Expected string lock scalar: {value}")
        return parsed
    if value.startswith("'") and value.endswith("'"):
        return value[1:-1].replace("''", "'")
    return value


def parse_lockfile(text: str) -> dict[str, dict[str, Any]]:
    lines = text.splitlines()
    try:
        package_section = next(index for index, line in enumerate(lines) if line == "packages:")
    except StopIteration as error:
        raise LockNormalizationError("pubspec.lock has no packages section") from error

    headers: list[tuple[int, str]] = []
    for index in range(package_section + 1, len(lines)):
        header = _PACKAGE_HEADER.match(lines[index])
        if header:
            headers.append((index, header.group("name")))
        elif lines[index] and not lines[index].startswith(" "):
            break

    if not headers:
        raise LockNormalizationError("pubspec.lock packages section is empty")

    packages: dict[str, dict[str, Any]] = {}
    for header_index, (start, name) in enumerate(headers):
        end = headers[header_index + 1][0] if header_index + 1 < len(headers) else len(lines)
        fields: dict[str, Any] = {}
        index = start + 1
        while index < end:
            field = _FIELD.match(lines[index])
            if field is None:
                index += 1
                continue
            field_name = field.group("name")
            value = field.group("value") or ""
            index += 1
            if field_name == "description" and not value.strip():
                description: dict[str, str | None] = {}
                while index < end and (
                    not lines[index].strip()
                    or len(lines[index]) - len(lines[index].lstrip(" ")) >= 6
                ):
                    child = _DESCRIPTION_FIELD.match(lines[index])
                    if child:
                        child_name = child.group("name")
                        if child_name in description:
                            raise LockNormalizationError(
                                f"Duplicate description field {child_name!r} in {name}"
                            )
                        description[child_name] = _scalar(child.group("value") or "")
                    index += 1
                fields[field_name] = description
            else:
                fields[field_name] = _scalar(value)

        missing = {"source", "version"} - fields.keys()
        if missing:
            raise LockNormalizationError(
                f"Package {name!r} lacks required lock fields: {sorted(missing)}"
            )
        packages[name] = fields

    return packages


def _outside_package_sections(text: str) -> tuple[str, str]:
    """Return the lockfile header and trailing metadata (for example, SDK bounds)."""
    lines = text.splitlines(keepends=True)
    try:
        package_start = next(index for index, line in enumerate(lines) if line.rstrip("\r\n") == "packages:")
    except StopIteration as error:
        raise LockNormalizationError("pubspec.lock has no packages section") from error

    trailing_start = None
    for index in range(package_start + 1, len(lines)):
        if lines[index].startswith("sdks:"):
            trailing_start = index
            break
    if trailing_start is None:
        raise LockNormalizationError("pubspec.lock has no SDK constraints section")

    return "".join(lines[:package_start]), "".join(lines[trailing_start:])


def _identity(package: dict[str, Any]) -> dict[str, Any]:
    return {
        "source": package.get("source"),
        "version": package.get("version"),
        "description": package.get("description"),
    }


def validate_normalization(original_text: str, normalized_text: str) -> dict[str, Any]:
    original_header, original_trailer = _outside_package_sections(original_text)
    normalized_header, normalized_trailer = _outside_package_sections(normalized_text)
    if original_header != normalized_header:
        raise LockNormalizationError("Lockfile header metadata changed during normalization")
    if original_trailer != normalized_trailer:
        raise LockNormalizationError("SDK constraints changed during normalization")

    original = parse_lockfile(original_text)
    normalized = parse_lockfile(normalized_text)
    original_names = set(original)
    normalized_names = set(normalized)
    added = normalized_names - original_names
    removed = original_names - normalized_names

    if added != EXPECTED_ADDED:
        raise LockNormalizationError(
            f"Unexpected packages added by normalization: {sorted(added)}; "
            f"expected {sorted(EXPECTED_ADDED)}"
        )
    if removed != EXPECTED_REMOVED:
        raise LockNormalizationError(
            f"Unexpected packages removed by normalization: {sorted(removed)}; "
            f"expected {sorted(EXPECTED_REMOVED)}"
        )

    for name in sorted(original_names & normalized_names):
        original_fields = {
            key: value for key, value in original[name].items() if key != "dependency"
        }
        normalized_fields = {
            key: value for key, value in normalized[name].items() if key != "dependency"
        }
        if original_fields != normalized_fields:
            raise LockNormalizationError(
                f"Pinned package metadata changed for existing package {name!r}: "
                f"{original_fields!r} -> {normalized_fields!r}"
            )

    dependency_changes = {
        name: (original[name].get("dependency"), normalized[name].get("dependency"))
        for name in sorted(original_names & normalized_names)
        if original[name].get("dependency") != normalized[name].get("dependency")
    }
    if dependency_changes != EXPECTED_DEPENDENCY_CHANGES:
        raise LockNormalizationError(
            f"Unexpected dependency classification changes: {dependency_changes!r}; "
            f"expected {EXPECTED_DEPENDENCY_CHANGES!r}"
        )

    return {
        "input_lock_sha256": hashlib.sha256(original_text.encode()).hexdigest(),
        "normalized_lock_sha256": hashlib.sha256(normalized_text.encode()).hexdigest(),
        "added_packages": [
            {"name": name, **_identity(normalized[name])} for name in sorted(added)
        ],
        "removed_packages": sorted(removed),
        "dependency_classification_changes": [
            {
                "name": name,
                "from": original_value,
                "to": normalized_value,
            }
            for name, (original_value, normalized_value) in dependency_changes.items()
        ],
        "existing_package_versions_sources_and_revisions_unchanged": True,
        "resolved_package_graph": [
            {"name": name, **_identity(package)}
            for name, package in sorted(normalized.items())
        ],
    }


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--original", required=True, type=Path)
    parser.add_argument("--normalized", required=True, type=Path)
    parser.add_argument("--report", required=True, type=Path)
    args = parser.parse_args()

    report = validate_normalization(
        args.original.read_text(encoding="utf-8"),
        args.normalized.read_text(encoding="utf-8"),
    )
    args.report.parent.mkdir(parents=True, exist_ok=True)
    args.report.write_text(json.dumps(report, indent=2, sort_keys=True) + "\n", encoding="utf-8")
    print(
        "Verified normalized lock: "
        f"input={report['input_lock_sha256']} "
        f"normalized={report['normalized_lock_sha256']} "
        f"packages={len(report['resolved_package_graph'])}"
    )
    for package in report["added_packages"]:
        print(
            "Normalized package pin: "
            f"{package['name']} source={package['source']} "
            f"version={package['version']} description={package['description']}"
        )
    return 0


if __name__ == "__main__":
    try:
        raise SystemExit(main())
    except LockNormalizationError as error:
        print(f"Lock normalization rejected: {error}", file=__import__("sys").stderr)
        raise SystemExit(1)
