#!/usr/bin/env python3
"""Small unit test for APK ZIP component reporting."""

from __future__ import annotations

import tempfile
import unittest
import zipfile
from pathlib import Path

from android_apk_report import compare_apks, format_summary, inspect_apk
from summarize_android_benchmark import _memory_comparison, _memory_summary


class ApkReportTest(unittest.TestCase):
    def _apk(self, root: Path, name: str, native_bytes: bytes) -> Path:
        path = root / name
        with zipfile.ZipFile(path, "w", compression=zipfile.ZIP_DEFLATED) as apk:
            apk.writestr("AndroidManifest.xml", b"manifest")
            apk.writestr("lib/arm64-v8a/libmpv.so", native_bytes)
            apk.writestr("assets/flutter_assets/AssetManifest.bin", b"assets")
        return path

    def test_reports_exact_size_and_native_component(self) -> None:
        with tempfile.TemporaryDirectory() as directory:
            apk_path = self._apk(Path(directory), "sample.apk", b"native" * 32)
            report = inspect_apk(apk_path)
            self.assertEqual(report["apk_bytes"], apk_path.stat().st_size)
            self.assertEqual(
                report["components"]["native/arm64-v8a"]["uncompressed_bytes"],
                len(b"native" * 32),
            )
            self.assertEqual(
                report["native_libraries"][0]["path"],
                "lib/arm64-v8a/libmpv.so",
            )

    def test_comparison_reports_candidate_delta(self) -> None:
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            before = self._apk(root, "before.apk", b"a" * 32)
            after = self._apk(root, "after.apk", b"b" * 96)
            report = compare_apks(before, after, "before", "after")
            self.assertEqual(
                report["apk_download_size"]["delta_bytes"],
                after.stat().st_size - before.stat().st_size,
            )
            self.assertIn("native/arm64-v8a", report["component_compressed_bytes"])
            summary = format_summary(report)
            self.assertIn("## Android Release APK size", summary)
            self.assertIn(f"{report['apk_download_size']['delta_bytes']:+,} bytes", summary)

    def test_memory_report_uses_sampled_pss_and_computes_delta(self) -> None:
        with tempfile.TemporaryDirectory() as directory:
            baseline_path = Path(directory) / "baseline.csv"
            candidate_path = Path(directory) / "candidate.csv"
            baseline_path.write_text(
                "elapsed_seconds,total_pss_kb\n0,100\n1,120\n",
                encoding="utf-8",
            )
            candidate_path.write_text(
                "elapsed_seconds,total_pss_kb\n0,110\n1,150\n",
                encoding="utf-8",
            )
            report = _memory_comparison(
                _memory_summary(baseline_path), _memory_summary(candidate_path)
            )
            self.assertEqual(report["max_total_pss_kb"]["delta"], 30)
            self.assertEqual(report["median_total_pss_kb"]["delta"], 20)


if __name__ == "__main__":
    unittest.main()
