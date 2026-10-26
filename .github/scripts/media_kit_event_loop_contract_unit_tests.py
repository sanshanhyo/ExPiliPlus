from __future__ import annotations

import json
import tempfile
import unittest
from pathlib import Path

from check_media_kit_event_loop_contract import LOCKED_COMMIT, verify_contract


CONTRACT_SOURCE = "\n".join(
    (
        "MediaKitEventLoopHandlerInitializeCXX",
        "MediaKitEventLoopHandlerCallback",
        "NativeApi.postCObject",
        "_receiver.sendPort.nativePort",
        "Dart_CObject_kInt64",
        "mpv.mpv_set_wakeup_callback(handle, _handle, handle.cast());",
        "NativePlayer.mpv.mpv_set_wakeup_callback(handle, nullptr, nullptr);",
        "_callbacks.remove(handle.address)",
    )
)


class MediaKitEventLoopContractTest(unittest.TestCase):
    def setUp(self) -> None:
        self.temporary = tempfile.TemporaryDirectory()
        self.root = Path(self.temporary.name)
        package_root = self.root / "packages" / "media_kit"
        dart_file = package_root / "lib/src/player/native/core/initializer_native_event_loop.dart"
        dart_file.parent.mkdir(parents=True)
        dart_file.write_text(CONTRACT_SOURCE, encoding="utf-8")
        self.config_path = self.root / ".dart_tool/package_config.json"
        self.config_path.parent.mkdir(parents=True)
        self.config_path.write_text(
            json.dumps(
                {
                    "configVersion": 2,
                    "packages": [
                        {"name": "media_kit", "rootUri": "../packages/media_kit/"}
                    ],
                }
            ),
            encoding="utf-8",
        )
        package_blocks = []
        for name in ("media_kit", "media_kit_native_event_loop"):
            package_blocks.extend(
                (
                    f"  {name}:",
                    '    dependency: "direct main"',
                    "    description:",
                    '      path: "media_kit"',
                    f'      resolved-ref: "{LOCKED_COMMIT}"',
                    '      url: "https://github.com/My-Responsitories/media-kit.git"',
                    "    source: git",
                    '    version: "1.1.11"',
                )
            )
        (self.root / "pubspec.lock").write_text("\n".join(package_blocks) + "\n", encoding="utf-8")

    def tearDown(self) -> None:
        self.temporary.cleanup()

    def test_accepts_locked_callback_registration_post_and_dispose_contract(self) -> None:
        path = verify_contract(self.root)
        self.assertEqual(path.name, "initializer_native_event_loop.dart")

    def test_rejects_a_different_locked_native_revision(self) -> None:
        lock = self.root / "pubspec.lock"
        lock.write_text(
            lock.read_text(encoding="utf-8").replace(LOCKED_COMMIT, "a" * 40),
            encoding="utf-8",
        )
        with self.assertRaisesRegex(ValueError, "not resolved from the locked FFI source"):
            verify_contract(self.root)

    def test_rejects_a_new_threaded_native_api(self) -> None:
        dart_file = (
            self.root
            / "packages/media_kit/lib/src/player/native/core/initializer_native_event_loop.dart"
        )
        dart_file.write_text(CONTRACT_SOURCE + "\nMediaKitEventLoopHandlerRegisterCXX", encoding="utf-8")
        with self.assertRaisesRegex(ValueError, "does not match the callback ABI"):
            verify_contract(self.root)

    def test_rejects_lost_callback_disposal(self) -> None:
        dart_file = (
            self.root
            / "packages/media_kit/lib/src/player/native/core/initializer_native_event_loop.dart"
        )
        dart_file.write_text(
            CONTRACT_SOURCE.replace("_callbacks.remove(handle.address)", ""),
            encoding="utf-8",
        )
        with self.assertRaisesRegex(ValueError, "contract markers are missing"):
            verify_contract(self.root)


if __name__ == "__main__":
    unittest.main()
