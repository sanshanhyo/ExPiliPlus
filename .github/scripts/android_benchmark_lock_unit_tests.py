from __future__ import annotations

import unittest

from verify_android_benchmark_lock import (
    LockNormalizationError,
    validate_normalization,
)


def _package(
    name: str,
    *,
    dependency: str = "transitive",
    source: str = "hosted",
    version: str = "1.0.0",
    description: str | None = None,
) -> str:
    description_block = (
        f"    description: {description}\n"
        if description is not None
        else "    description:\n      name: sample\n      sha256: abc\n      url: \"https://pub.dev\"\n"
    )
    return (
        f"  {name}:\n"
        f"    dependency: \"{dependency}\"\n"
        f"{description_block}"
        f"    source: {source}\n"
        f"    version: \"{version}\"\n"
    )


def _fixture_lock(*, normalized: bool = False) -> str:
    packages = []
    packages.append(
        _package("cupertino_ui", dependency="direct main" if normalized else "transitive")
    )
    packages.append(_package("ffi", dependency="direct main" if normalized else "transitive"))
    packages.append(
        _package(
            "kept_git_package",
            source="git",
            version="2.0.0",
            description=(
                "{ref: dev, resolved-ref: deadbeef, url: https://example.invalid/pkg.git}"
            ),
        )
    )
    if normalized:
        for name in sorted(
            {
                "flutter_driver",
                "fuchsia_remote_debug_protocol",
                "sync_http",
                "webdriver",
            }
        ):
            source = "sdk" if name in {"flutter_driver", "fuchsia_remote_debug_protocol"} else "hosted"
            packages.append(_package(name, source=source, version="0.0.0" if source == "sdk" else "1.0.0"))
    else:
        packages.extend(_package(name) for name in ("gtk", "menu_base", "shortid"))
    return (
        "packages:\n"
        + "".join(packages)
        + 'sdks:\n  dart: ">=3.0.0 <4.0.0"\n  flutter: ">=3.0.0"\n'
    )


class AndroidBenchmarkLockTest(unittest.TestCase):
    def test_accepts_narrow_symmetric_lock_normalization(self) -> None:
        report = validate_normalization(_fixture_lock(), _fixture_lock(normalized=True))
        self.assertTrue(report["existing_package_versions_sources_and_revisions_unchanged"])
        self.assertEqual(report["removed_packages"], ["gtk", "menu_base", "shortid"])
        self.assertEqual(len(report["added_packages"]), 4)
        self.assertEqual(len(report["dependency_classification_changes"]), 2)
        self.assertEqual(
            {package["name"] for package in report["added_packages"]},
            {
                "flutter_driver",
                "fuchsia_remote_debug_protocol",
                "sync_http",
                "webdriver",
            },
        )
        self.assertTrue(
            all(package["source"] and package["version"] for package in report["added_packages"])
        )

    def test_rejects_existing_version_change(self) -> None:
        normalized = _fixture_lock(normalized=True).replace(
            'version: "2.0.0"', 'version: "2.1.0"', 1
        )
        with self.assertRaisesRegex(LockNormalizationError, "Pinned package metadata changed"):
            validate_normalization(_fixture_lock(), normalized)

    def test_rejects_existing_git_revision_change(self) -> None:
        normalized = _fixture_lock(normalized=True).replace(
            "resolved-ref: deadbeef", "resolved-ref: badc0ffe"
        )
        with self.assertRaisesRegex(LockNormalizationError, "Pinned package metadata changed"):
            validate_normalization(_fixture_lock(), normalized)

    def test_rejects_changed_checksum_for_retained_package(self) -> None:
        original = _fixture_lock()
        normalized = _fixture_lock(normalized=True).replace("sha256: abc", "sha256: def", 1)
        with self.assertRaisesRegex(LockNormalizationError, "Pinned package metadata changed"):
            validate_normalization(original, normalized)

    def test_rejects_unreviewed_added_package(self) -> None:
        normalized = _fixture_lock(normalized=True).replace(
            "sdks:\n", _package("unexpected_new_package") + "sdks:\n"
        )
        with self.assertRaisesRegex(LockNormalizationError, "Unexpected packages added"):
            validate_normalization(_fixture_lock(), normalized)

    def test_rejects_changed_sdk_constraints(self) -> None:
        normalized = _fixture_lock(normalized=True).replace(
            '  flutter: ">=3.0.0"', '  flutter: ">=3.1.0"'
        )
        with self.assertRaisesRegex(LockNormalizationError, "SDK constraints changed"):
            validate_normalization(_fixture_lock(), normalized)


if __name__ == "__main__":
    unittest.main()
