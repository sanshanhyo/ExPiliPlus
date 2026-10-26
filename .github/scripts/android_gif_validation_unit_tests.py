from __future__ import annotations

import tempfile
import unittest
from pathlib import Path

from PIL import Image

from validate_android_gif import GifValidationError, validate_gif


def make_gif(path: Path, *, size: tuple[int, int] = (480, 270), frames: int = 30) -> None:
    images = [
        Image.new("RGB", size, (index * 7 % 255, index * 13 % 255, index * 19 % 255))
        for index in range(frames)
    ]
    images[0].save(
        path,
        format="GIF",
        save_all=True,
        append_images=images[1:],
        duration=100,
        loop=0,
        optimize=False,
    )


class AndroidGifValidationTest(unittest.TestCase):
    def test_decodes_all_frames_and_checks_dimensions_duration_and_loop(self) -> None:
        with tempfile.TemporaryDirectory() as temporary_directory:
            path = Path(temporary_directory) / "valid.gif"
            make_gif(path)

            result = validate_gif(path)

        self.assertEqual(result["codec"], "gif")
        self.assertEqual(result["width"], 480)
        self.assertEqual(result["height"], 270)
        self.assertEqual(result["decoded_frames"], 30)
        self.assertEqual(result["duration_ms"], 3000)
        self.assertEqual(result["loop_count"], 0)
        self.assertGreater(result["bytes"], 0)

    def test_rejects_wrong_dimensions(self) -> None:
        with tempfile.TemporaryDirectory() as temporary_directory:
            path = Path(temporary_directory) / "wrong-size.gif"
            make_gif(path, size=(854, 480))

            with self.assertRaisesRegex(GifValidationError, "Expected 480x270"):
                validate_gif(path)

    def test_rejects_wrong_frame_count(self) -> None:
        with tempfile.TemporaryDirectory() as temporary_directory:
            path = Path(temporary_directory) / "wrong-frames.gif"
            make_gif(path, frames=85)

            with self.assertRaisesRegex(GifValidationError, "85"):
                validate_gif(path)

    def test_rejects_corrupt_frame_data(self) -> None:
        with tempfile.TemporaryDirectory() as temporary_directory:
            path = Path(temporary_directory) / "corrupt.gif"
            make_gif(path)
            path.write_bytes(path.read_bytes()[:128])

            with self.assertRaises(GifValidationError):
                validate_gif(path)


if __name__ == "__main__":
    unittest.main()
