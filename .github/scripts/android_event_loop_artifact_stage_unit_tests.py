from __future__ import annotations

import hashlib
import tempfile
import unittest
import zipfile
from pathlib import Path

from stage_android_event_loop_artifacts import (
    JARS,
    SOURCE_COMMIT,
    stage_artifacts,
)


class StageAndroidEventLoopArtifactsTest(unittest.TestCase):
    def setUp(self) -> None:
        self.temporary = tempfile.TemporaryDirectory()
        self.root = Path(self.temporary.name)
        self.base = self.root / "base"
        self.native = self.root / "native"
        self.output = self.root / "staged"
        self.source = self.root / "source"
        self.patch = self.root / "event-loop.patch"
        self.native.mkdir()
        self.source.mkdir()
        self.patch.write_text("patch bytes\n", encoding="utf-8")
        (self.source / "LICENSE").write_text("MIT license fixture\n", encoding="utf-8")
        source_files = self.source / "src"
        source_files.mkdir()
        for name in (
            "media_kit_native_event_loop.cc",
            "media_kit_native_event_loop.h",
            "dart_api_types.h",
        ):
            (source_files / name).write_text(f"source fixture: {name}\n", encoding="utf-8")
        for abi, _ in JARS:
            native_dir = self.native / abi
            native_dir.mkdir()
            (native_dir / "libmedia_kit_native_event_loop.so").write_bytes(
                f"new callback library {abi}".encode("utf-8")
            )
        self.base.mkdir()
        license_path = self.base / "licenses/buildscripts/deps/media_kit/media_kit_native_event_loop/LICENSE"
        license_path.parent.mkdir(parents=True)
        license_path.write_bytes((self.source / "LICENSE").read_bytes())
        (self.base / "source-license.txt").write_text("builder license\n", encoding="utf-8")
        (self.base / "licenses.txt").write_text("upstream/LICENSE\n", encoding="utf-8")

        rows = []
        for abi, name in JARS:
            jar = self.base / name
            with zipfile.ZipFile(jar, "w", compression=zipfile.ZIP_DEFLATED) as archive:
                archive.writestr(f"lib/{abi}/libmpv.so", f"mpv-{abi}".encode())
                archive.writestr(
                    f"lib/{abi}/libmedia_kit_native_event_loop.so",
                    f"old callback library {abi}".encode(),
                )
                archive.writestr("assets/unchanged.txt", b"unchanged")
            rows.append(
                f"{name} {hashlib.sha256(jar.read_bytes()).hexdigest()} {jar.stat().st_size} bytes"
            )
        (self.base / "build-metadata.txt").write_text(
            "source_commit=0bb77586769b9e882123197ef8dc940bae5de8b2\n"
            "gif_only=true\n"
            "gif_encoder=enabled\n"
            "gif_muxer=enabled\n"
            "gpl_encoder_set=disabled\n"
            "x264=disabled\n"
            "artifacts=\n"
            + "\n".join(rows)
            + "\n",
            encoding="utf-8",
        )

    def tearDown(self) -> None:
        self.temporary.cleanup()

    def test_replaces_only_the_event_loop_entry_and_records_pinned_inputs(self) -> None:
        stage_artifacts(
            self.base,
            self.native,
            self.output,
            self.source,
            self.patch,
            "28.2.13676358",
        )

        for abi, name in JARS:
            with zipfile.ZipFile(self.base / name) as original, zipfile.ZipFile(
                self.output / name
            ) as staged:
                original_entries = {entry.filename: original.read(entry) for entry in original.infolist()}
                staged_entries = {entry.filename: staged.read(entry) for entry in staged.infolist()}
            self.assertEqual(original_entries.keys(), staged_entries.keys())
            event_loop_path = f"lib/{abi}/libmedia_kit_native_event_loop.so"
            self.assertEqual(
                staged_entries[event_loop_path],
                (self.native / abi / "libmedia_kit_native_event_loop.so").read_bytes(),
            )
            for path in original_entries.keys() - {event_loop_path}:
                self.assertEqual(staged_entries[path], original_entries[path])

        metadata = (self.output / "build-metadata.txt").read_text(encoding="utf-8")
        self.assertIn(f"media_kit_native_event_loop_source_commit={SOURCE_COMMIT}", metadata)
        self.assertIn("media_kit_native_event_loop_api=legacy-wakeup-callback-v1", metadata)
        self.assertIn("media_kit_native_event_loop_ndk_version=28.2.13676358", metadata)
        self.assertIn("media_kit_native_event_loop_callback_contract_test=passed", metadata)
        for _, name in JARS:
            self.assertIn(hashlib.sha256((self.output / name).read_bytes()).hexdigest(), metadata)
        self.assertIn(
            "media_kit_native_event_loop/LICENSE",
            (self.output / "licenses.txt").read_text(encoding="utf-8"),
        )

    def test_rejects_mismatched_event_loop_license(self) -> None:
        (self.base / "licenses/buildscripts/deps/media_kit/media_kit_native_event_loop/LICENSE").write_text(
            "different license\n", encoding="utf-8"
        )
        with self.assertRaisesRegex(ValueError, "MIT license does not match"):
            stage_artifacts(
                self.base,
                self.native,
                self.output,
                self.source,
                self.patch,
                "28.2.13676358",
            )

    def test_rejects_missing_abi_library(self) -> None:
        (self.native / "x86_64/libmedia_kit_native_event_loop.so").unlink()
        with self.assertRaisesRegex(ValueError, "missing or empty"):
            stage_artifacts(
                self.base,
                self.native,
                self.output,
                self.source,
                self.patch,
                "28.2.13676358",
            )


if __name__ == "__main__":
    unittest.main()
