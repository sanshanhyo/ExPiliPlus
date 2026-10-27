from __future__ import annotations

import unittest
from pathlib import Path


ROOT = Path(__file__).resolve().parents[2]
BUILDER = ROOT / "lib/scripts/build_android_event_loop_compat.sh"


class AndroidEventLoopBuilderTest(unittest.TestCase):
    def setUp(self) -> None:
        self.script = BUILDER.read_text(encoding="utf-8")

    def test_builds_from_the_locked_callback_source_for_all_supported_abis(self) -> None:
        self.assertIn('ndk_version="28.2.13676358"', self.script)
        self.assertIn('work_source="$run_root/src"', self.script)
        self.assertIn('cp -a "$source_dir/src" "$run_root/"', self.script)
        self.assertIn('patch --fuzz=0 -d "$run_root" -p1', self.script)
        for abi in ("arm64-v8a", "armeabi-v7a", "x86_64"):
            self.assertIn(f"build_one_abi {abi} ", self.script)

    def test_requires_the_real_callback_and_initialization_exports(self) -> None:
        self.assertIn("MediaKitEventLoopHandlerInitialize MediaKitEventLoopHandlerCallback", self.script)
        self.assertIn("MediaKitEventLoopHandler(Register|Notify|Dispose)", self.script)
        self.assertIn("android_event_loop_callback_contract_test.cc", self.script)
        self.assertIn('"$run_root/callback-contract-test"', self.script)

    def test_native_library_does_not_add_a_cpp_runtime_or_mpv_dependency(self) -> None:
        self.assertIn("-fno-exceptions", self.script)
        self.assertIn("-fno-rtti", self.script)
        self.assertIn("-nostdlib++", self.script)
        self.assertIn("libmpv|libmediakitandroidhelper|libc\\+\\+_shared", self.script)
        self.assertIn('"$evidence_dir/$abi.dynamic-dependencies.txt"', self.script)

    def test_only_stages_after_all_native_libraries_are_built(self) -> None:
        stage_call = self.script.index("stage_android_event_loop_artifacts.py")
        last_abi_build = self.script.index("build_one_abi x86_64")
        self.assertGreater(stage_call, last_abi_build)
        self.assertNotIn("stage_android_event_loop_artifacts.py", self.script[:last_abi_build])
        self.assertNotRegex(self.script[stage_call:], r"stage_android_event_loop_artifacts\.py[\s\S]*?\|\|\s*true")

    def test_pins_source_blobs_and_keeps_output_in_ephemeral_runner_storage(self) -> None:
        self.assertIn("545b1218929f5483bd085a2d0837287e503fcc32", self.script)
        self.assertIn("163436ba26bb58273845e2e248c52717e87d2f16", self.script)
        self.assertIn("96220c4768b6462cd6629eaefe3d14ba64480957", self.script)
        self.assertIn("c4c95d9821b2ed414bc44b034c4477c2786d07b8", self.script)
        self.assertIn('"$runner_temp"/*', self.script)
        self.assertIn('"$evidence_dir/native-libs"', self.script)
        self.assertIn('"$android_sdk"/cmdline-tools/*/bin/sdkmanager', self.script)

    def test_refactor_workflow_stages_rebuilt_filter_enabled_jars_before_emulator(self) -> None:
        test_workflow = (ROOT / ".github/workflows/test.yml").read_text(encoding="utf-8")
        benchmark_workflow = (ROOT / ".github/workflows/android-benchmark.yml").read_text(
            encoding="utf-8"
        )
        self.assertIn(
            "MEDIA_KIT_ANDROID_VIDEO_ARTIFACT_DIR: ${{ runner.temp }}/android-gif-event-loop-artifacts",
            benchmark_workflow,
        )
        self.assertIn("refs/heads/refactor/shutdown-timer-ui", test_workflow)
        self.assertIn("build_android_gif_libmpv.sh", benchmark_workflow)
        self.assertIn("Refusing the upstream command-line-tools bootstrap", benchmark_workflow)
        flutter_setup = benchmark_workflow.index(
            "name: Setup Flutter for Android library packaging"
        )
        dependency_resolution = benchmark_workflow.index(
            "name: Resolve Flutter dependencies for the media_kit FFI contract"
        )
        self.assertIn('"$RUNNER_TEMP/android-gif-libmpv-base"', benchmark_workflow)
        self.assertIn("android-gif-native-artifacts.sha256", benchmark_workflow)
        self.assertIn("sha256sum --check android-gif-native-artifacts.sha256", benchmark_workflow)
        callback_stage = benchmark_workflow.index(
            "Stage the locked media_kit callback into the rebuilt JARs"
        )
        app_job = benchmark_workflow.index("name: Run Android app and GIF export validation")
        benchmark_job = benchmark_workflow.index(
            "name: Compare APK size and synthetic-video GIF performance"
        )
        self.assertLess(callback_stage, app_job)
        self.assertLess(app_job, benchmark_job)
        self.assertLess(flutter_setup, benchmark_workflow.index("name: Rebuild pinned filter-enabled GIF libmpv for all Android ABIs"))
        self.assertIn("run: flutter pub get", benchmark_workflow[dependency_resolution:])
        self.assertLess(flutter_setup, dependency_resolution)
        self.assertLess(dependency_resolution, callback_stage)
        self.assertIn("flutter-version-file: pubspec.yaml", benchmark_workflow[flutter_setup:])
        self.assertIn("needs: [native, app-integration]", benchmark_workflow)
        self.assertIn('base_artifact_dir="${3:-$root_dir/third_party/android-gif-libmpv/artifacts}"', self.script)
        benchmark_preflight = (ROOT / ".github/scripts/check_android_benchmark_harness.sh").read_text(
            encoding="utf-8"
        )
        self.assertIn("fps_filter=enabled", benchmark_preflight)
        self.assertIn("scale_filter=enabled", benchmark_preflight)
        self.assertIn('"$staged_artifact_dir"', benchmark_preflight)
        self.assertIn("build_android_event_loop_compat.sh", benchmark_preflight)
        self.assertLess(
            benchmark_preflight.index("flutter analyze"),
            benchmark_preflight.index("build_android_event_loop_compat.sh"),
        )


if __name__ == "__main__":
    unittest.main()
