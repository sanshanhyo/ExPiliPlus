from __future__ import annotations

import re
import subprocess
import sys
import tempfile
import unittest
from pathlib import Path

from compare_android_manifest_hashes import compare_manifest_hashes

GIF_FILTER_PATCHER_DIR = Path(__file__).parents[2].joinpath("lib", "scripts")
sys.path.insert(0, str(GIF_FILTER_PATCHER_DIR))
from enable_android_gif_filters import enable_gif_filters


BENCHMARK_SCRIPT = Path(__file__).with_name("run_android_benchmark.sh").read_text(
    encoding="utf-8"
)
BENCHMARK_WORKFLOW = Path(__file__).parents[1].joinpath(
    "workflows", "android-benchmark.yml"
).read_text(encoding="utf-8")
TEST_WORKFLOW = Path(__file__).parents[1].joinpath(
    "workflows", "test.yml"
).read_text(encoding="utf-8")
APP_GIF_VALIDATION = Path(__file__).with_name(
    "run_android_app_gif_validation.sh"
).read_text(encoding="utf-8")
ANDROID_INTEGRATION_TEST = Path(__file__).with_name(
    "android_integration_test.sh"
).read_text(encoding="utf-8")
APP_SMOKE_TEST = Path(__file__).parents[2].joinpath(
    "integration_test", "app_smoke_test.dart"
).read_text(encoding="utf-8")
BENCHMARK_PREFLIGHT = Path(__file__).with_name(
    "check_android_benchmark_harness.sh"
).read_text(encoding="utf-8")
GIF_BENCHMARK_TEST = Path(__file__).parents[1].joinpath(
    "benchmarks", "android_gif_benchmark_test.dart"
).read_text(encoding="utf-8")
GIF_CONVERTER = Path(__file__).parents[2].joinpath(
    "lib", "plugin", "pl_player", "widgets", "mpv_convert_gif.dart"
).read_text(encoding="utf-8")
GIF_VALIDATOR = Path(__file__).with_name("validate_android_gif.py").read_text(
    encoding="utf-8"
)
GIF_BUILD_SCRIPT = Path(__file__).parents[2].joinpath(
    "lib", "scripts", "build_android_gif_libmpv.sh"
).read_text(encoding="utf-8")
GIF_FILTER_PATCHER = GIF_FILTER_PATCHER_DIR.joinpath(
    "enable_android_gif_filters.py"
).read_text(encoding="utf-8")
GIF_BUILD_PATCH = Path(__file__).parents[2].joinpath(
    "third_party", "android-gif-libmpv", "enable-gif.patch"
).read_text(encoding="utf-8")
GIF_BUILD_WORKFLOW = Path(__file__).parents[1].joinpath(
    "workflows", "android-gif-libmpv.yml"
).read_text(encoding="utf-8")


def function_body(name: str, next_marker: str) -> str:
    start = BENCHMARK_SCRIPT.index(f"{name}() {{")
    end = BENCHMARK_SCRIPT.index(next_marker, start)
    return BENCHMARK_SCRIPT[start:end]


class AndroidBenchmarkScriptCheckTest(unittest.TestCase):
    def test_injected_benchmark_targets_are_analyzed_before_emulator_and_release(self) -> None:
        self.assertNotIn("ffmpeg", BENCHMARK_WORKFLOW)
        self.assertIn("Pillow==12.3.0", BENCHMARK_WORKFLOW)
        self.assertIn("Install Android GIF native build tools", BENCHMARK_WORKFLOW)
        self.assertIn("Rebuild pinned filter-enabled GIF libmpv for all Android ABIs", BENCHMARK_WORKFLOW)
        self.assertIn("Stage the locked media_kit callback into the rebuilt JARs", BENCHMARK_WORKFLOW)
        self.assertIn("sha256sum --check SHA256SUMS", BENCHMARK_WORKFLOW)
        self.assertIn("android-benchmark-source.mp4", BENCHMARK_WORKFLOW)
        preflight = BENCHMARK_WORKFLOW.index(
            "Compile injected GIF benchmark targets before APK builds"
        )
        kvm = BENCHMARK_WORKFLOW.index("Verify KVM for the ephemeral Android runner")
        emulator = BENCHMARK_WORKFLOW.index(
            "script: bash .github/scripts/run_android_benchmark.sh"
        )
        upload_evidence = BENCHMARK_WORKFLOW.index(
            "Upload Android package and performance evidence"
        )

        self.assertIn("check_android_benchmark_harness.sh", BENCHMARK_WORKFLOW)
        native_build = BENCHMARK_WORKFLOW.index(
            "Rebuild pinned filter-enabled GIF libmpv for all Android ABIs"
        )
        callback_stage = BENCHMARK_WORKFLOW.index(
            "Stage the locked media_kit callback into the rebuilt JARs"
        )
        self.assertLess(preflight, kvm)
        self.assertLess(preflight, emulator)
        self.assertLess(native_build, callback_stage)
        self.assertLess(callback_stage, preflight)
        self.assertLess(emulator, upload_evidence)
        self.assertIn("flutter analyze", BENCHMARK_PREFLIGHT)
        self.assertIn("integration_test/android_gif_benchmark_test.dart", BENCHMARK_PREFLIGHT)
        self.assertIn("integration_test/android_benchmark_driver.dart", BENCHMARK_PREFLIGHT)
        self.assertNotIn("apply_android_gif_common_lifecycle_fix.py", BENCHMARK_PREFLIGHT)
        self.assertIn('baseline_sha="${5:-}"', BENCHMARK_PREFLIGHT)
        self.assertIn("Measured-before baseline Dart analysis failed", BENCHMARK_PREFLIGHT)
        self.assertLess(
            BENCHMARK_PREFLIGHT.index('cp "$video_data_dart"'),
            BENCHMARK_PREFLIGHT.index("flutter analyze"),
        )
        self.assertLess(
            BENCHMARK_WORKFLOW.index("Compile injected GIF benchmark targets before APK builds"),
            BENCHMARK_WORKFLOW.index(
                "Build matched APKs and benchmark synthetic GIF conversion"
            ),
        )

    def test_app_gif_validation_and_benchmark_are_separate_jobs(self) -> None:
        self.assertIn("run_android_app_gif_validation.sh", BENCHMARK_WORKFLOW)
        self.assertIn("android_integration_test.sh", APP_GIF_VALIDATION)
        self.assertIn("validate_android_gif.py", APP_GIF_VALIDATION)
        self.assertIn("timeout --signal=TERM --kill-after=30s 35m", APP_GIF_VALIDATION)
        self.assertIn('tee "$evidence_dir/integration-step.log"', APP_GIF_VALIDATION)
        self.assertIn('if [ "$integration_status" -eq 0 ]; then', APP_GIF_VALIDATION)
        self.assertIn('tee "$evidence_dir/validation-status.txt"', APP_GIF_VALIDATION)
        self.assertIn("flutter test --reporter expanded integration_test/app_smoke_test.dart", ANDROID_INTEGRATION_TEST)
        self.assertIn("trap 'exit 143' TERM", ANDROID_INTEGRATION_TEST)
        self.assertIn("trap 'exit 130' INT", ANDROID_INTEGRATION_TEST)
        app_validation = BENCHMARK_WORKFLOW.index(
            "name: Run Android app and GIF export validation"
        )
        app_gif_decoder = BENCHMARK_WORKFLOW.index(
            "Install pinned Pillow decoder for app GIF verification"
        )
        app_emulator = BENCHMARK_WORKFLOW.index(
            "Run app playback, timer, and real GIF export on Android"
        )
        self.assertLess(app_validation, app_gif_decoder)
        self.assertLess(app_gif_decoder, app_emulator)
        self.assertIn("Pillow==12.3.0", BENCHMARK_WORKFLOW[app_gif_decoder:app_emulator])
        self.assertIn("android-gif-build-toolchain.txt", BENCHMARK_WORKFLOW)
        self.assertIn("needs: [native, app-integration]", BENCHMARK_WORKFLOW)
        self.assertIn("needs.native.result == 'success'", BENCHMARK_WORKFLOW)
        self.assertIn("run_android_benchmark.sh", BENCHMARK_WORKFLOW)
        self.assertLess(
            BENCHMARK_WORKFLOW.index("name: Run Android app and GIF export validation"),
            BENCHMARK_WORKFLOW.index("name: Compare APK size and synthetic-video GIF performance"),
        )

    def test_public_video_query_finishes_before_the_smoke_test_taps_play(self) -> None:
        ready_marker = APP_SMOKE_TEST.index(
            "ANDROID_SMOKE_PHASE=public-video-play-sources-ready"
        )
        play_tap = APP_SMOKE_TEST.index(
            "description: 'start video playback from the detail page'"
        )
        self.assertLess(ready_marker, play_tap)
        readiness_wait = APP_SMOKE_TEST.index(
            "description:\n              'public video play URLs finish loading before manual playback'"
        )
        self.assertLess(readiness_wait, ready_marker)
        self.assertIn("!videoDetailController.isQuerying", APP_SMOKE_TEST)
        self.assertIn("videoDetailController.videoUrl != null", APP_SMOKE_TEST)
        self.assertIn("videoDetailController.audioUrl != null", APP_SMOKE_TEST)
        self.assertIn("ANDROID_PLAYER_CREATION_DIAGNOSTICS", APP_SMOKE_TEST)

    def test_benchmark_uses_exact_measured_before_and_reuses_native_cache(self) -> None:
        self.assertIn("85415402420eaabeae08fb33e496d3eaced232cc", BENCHMARK_WORKFLOW)
        self.assertIn("Restore the pinned Android GIF artifact cache", BENCHMARK_WORKFLOW)
        self.assertIn("Verify restored pinned native GIF artifacts", BENCHMARK_WORKFLOW)
        self.assertIn("steps.native-artifact-cache.outputs.cache-hit", BENCHMARK_WORKFLOW)
        self.assertIn("exact measured-before source", BENCHMARK_WORKFLOW)
        self.assertIn(
            'script: bash .github/scripts/run_android_benchmark.sh '
            '85415402420eaabeae08fb33e496d3eaced232cc "${{ github.sha }}"',
            BENCHMARK_WORKFLOW,
        )
        self.assertIn('"label": "measured-before baseline"', BENCHMARK_SCRIPT)
        self.assertIn("This comparison must isolate only the GIF converter source change.", BENCHMARK_SCRIPT)
        self.assertNotIn("apply_android_gif_common_lifecycle_fix.py", BENCHMARK_SCRIPT)
        self.assertNotIn("apply_android_gif_common_lifecycle_fix.py", BENCHMARK_PREFLIGHT)
        self.assertIn(
            "if: github.ref != 'refs/heads/refactor/shutdown-timer-ui'",
            TEST_WORKFLOW,
        )
        self.assertIn(
            "The refactor branch runs this same app/GIF integration after building",
            TEST_WORKFLOW,
        )

    def test_gif_benchmark_uses_the_production_file_validator_api(self) -> None:
        self.assertIn(
            "package:ex_piliplus/plugin/pl_player/widgets/gif_file_validator.dart",
            GIF_BENCHMARK_TEST,
        )
        self.assertIn("GifFileValidation.fromBytes(bytes)", GIF_BENCHMARK_TEST)
        self.assertNotIn("GifFileValidator", GIF_BENCHMARK_TEST)

    def test_gif_benchmark_checks_requested_filters_and_output_contract(self) -> None:
        self.assertIn(
            "'lavfi=[fps=fps=$fps,scale=w=$width:h=-2:flags=lanczos]'",
            GIF_CONVERTER,
        )
        self.assertNotIn("lavfi-fps=", GIF_CONVERTER)
        self.assertNotIn("lavfi-scale=", GIF_CONVERTER)
        self.assertIn("_command(['vf', 'set', _videoFilters])", GIF_CONVERTER)
        self.assertLess(
            GIF_CONVERTER.index("mpv_request_log_messages"),
            GIF_CONVERTER.index("_command(['vf', 'set', _videoFilters])"),
        )
        self.assertIn("command=\"$command\" result=$result", GIF_CONVERTER)
        self.assertIn("filterFlags=$enabledFilterFlags", GIF_CONVERTER)
        self.assertIn("if (filterResult < 0)", GIF_CONVERTER)
        self.assertIn("_readOsdProperty('vf')", GIF_CONVERTER)
        self.assertIn("_readOsdProperty('video-out-params/w')", GIF_CONVERTER)
        self.assertIn("_readOsdProperty('video-out-params/h')", GIF_CONVERTER)
        self.assertIn("_readOsdProperty('estimated-vf-fps')", GIF_CONVERTER)
        self.assertIn("GifConvert: input loaded runtime=", GIF_CONVERTER)
        self.assertIn("GifConvert: end-file before native teardown", GIF_CONVERTER)
        self.assertIn("GifConvert: after native teardown", GIF_CONVERTER)
        self.assertIn("Timer.run(() => _finishAfterEndFile", GIF_CONVERTER)
        self.assertEqual(
            GIF_CONVERTER.count("_command(['vf', 'set', _videoFilters])"), 1
        )
        loaded_case = GIF_CONVERTER.split(
            "case generated.mpv_event_id.MPV_EVENT_FILE_LOADED:", 1
        )[1].split(
            "case generated.mpv_event_id.MPV_EVENT_LOG_MESSAGE:", 1
        )[0]
        self.assertNotIn("_command(", loaded_case)
        self.assertIn("MPV_END_FILE_REASON_EOF", GIF_CONVERTER)
        self.assertIn("eof=$reachedEof", GIF_CONVERTER)
        self.assertIn("validation?.isValid == true", GIF_CONVERTER)
        self.assertIn("vf=$_videoFilters", GIF_CONVERTER)
        self.assertIn("validate_android_gif.py", BENCHMARK_SCRIPT)
        self.assertIn("expected_fixture_sha", BENCHMARK_SCRIPT)
        self.assertNotIn("ffprobe", BENCHMARK_SCRIPT)
        self.assertNotIn("ffmpeg", BENCHMARK_SCRIPT)
        self.assertIn("const _expectedGifHeight = 270;", GIF_BENCHMARK_TEST)
        self.assertIn(
            "_expectedFrameCount - _frameCountTolerance",
            GIF_BENCHMARK_TEST,
        )
        self.assertIn("_expectedFrameCount + _frameCountTolerance", GIF_BENCHMARK_TEST)
        for scenario in (
            "keyframe-aligned-1-to-4",
            "keyframe-aligned-0-to-3",
            "non-keyframe-1.1-to-4.1",
        ):
            self.assertIn(scenario, GIF_BENCHMARK_TEST)
        self.assertIn("'speed': '1'", GIF_CONVERTER)
        self.assertLess(
            GIF_BENCHMARK_TEST.index("binding.reportData ="),
            GIF_BENCHMARK_TEST.index("expect(\n        diagnosticsPassed"),
        )
        self.assertIn("--diagnostic", BENCHMARK_SCRIPT)
        self.assertIn("image.load()", GIF_VALIDATOR)
        self.assertIn("EXPECTED_WIDTH = 480", GIF_VALIDATOR)
        self.assertIn("EXPECTED_HEIGHT = 270", GIF_VALIDATOR)
        self.assertIn("MIN_FRAMES = 28", GIF_VALIDATOR)
        self.assertIn("MAX_FRAMES = 32", GIF_VALIDATOR)
        self.assertIn("MIN_DURATION_MS = 2800", GIF_VALIDATOR)
        self.assertIn("MAX_DURATION_MS = 3200", GIF_VALIDATOR)

    def test_pinned_android_gif_build_enables_and_verifies_required_lavfi_filters(self) -> None:
        self.assertIn("Flutter SDK is required to package the Android library artifacts.", GIF_BUILD_SCRIPT)
        self.assertIn("--enable-muxer=gif", GIF_BUILD_PATCH)
        self.assertIn("--enable-encoder=gif", GIF_BUILD_PATCH)
        self.assertIn("--enable-filter=fps", GIF_FILTER_PATCHER)
        self.assertIn("--enable-filter=scale", GIF_FILTER_PATCHER)
        self.assertIn("CONFIG_FPS_FILTER", GIF_BUILD_SCRIPT)
        self.assertIn("CONFIG_SCALE_FILTER", GIF_BUILD_SCRIPT)
        self.assertIn("enable_android_gif_filters.py", GIF_BUILD_SCRIPT)
        self.assertIn("one unmodified equalizer filter", GIF_FILTER_PATCHER)
        self.assertIn("ff_vf_fps", GIF_BUILD_SCRIPT)
        self.assertIn("ff_vf_scale", GIF_BUILD_SCRIPT)
        for symbol in ("ff_vf_fps", "ff_vf_scale"):
            self.assertIn(symbol, GIF_BUILD_WORKFLOW)

    def test_pinned_android_gif_filter_patch_is_precise_and_idempotent(self) -> None:
        source = (
            "--enable-filter=overlay \\\n"
            "\t--enable-filter=equalizer \\\n"
            "\t--enable-filter=aresample \\\n"
        )
        expected = (
            "--enable-filter=overlay \\\n"
            "\t--enable-filter=equalizer \\\n"
            "\t--enable-filter=fps \\\n"
            "\t--enable-filter=scale \\\n"
            "\t--enable-filter=aresample \\\n"
        )
        patched = enable_gif_filters(source)
        self.assertEqual(patched, expected)
        self.assertEqual(enable_gif_filters(patched), expected)
        with self.assertRaisesRegex(ValueError, "one unmodified equalizer filter"):
            enable_gif_filters(source.replace("equalizer", "missing"))

    def test_player_controls_wait_for_state_before_repeating_surface_tap(self) -> None:
        integration_test = Path(__file__).parents[2].joinpath(
            "integration_test", "app_smoke_test.dart"
        ).read_text(encoding="utf-8")
        helper_start = integration_test.index("Future<void> _showPlayerControls(")
        helper_end = integration_test.index("Finder _playerControls(", helper_start)
        helper = integration_test[helper_start:helper_end]
        tap_start = integration_test.index("Future<void> _tapUnique(")
        tap_end = integration_test.index("Future<void> _captureCountdownScreenshot(", tap_start)
        tap_helper = integration_test[tap_start:tap_end]
        self.assertIn("if (!controller.showControls.value)", helper)
        self.assertNotIn(
            "if (playPauseButton.hitTestable().evaluate().isEmpty)", helper
        )
        self.assertIn("controller.controlsLock.value", helper)
        self.assertIn("controller.isBuffering.value", helper)
        self.assertIn("finder.hitTestable().evaluate().length == 1", tap_helper)
        self.assertIn("state.rate == 1.5", integration_test)
        self.assertIn("find.text('1.5X')", integration_test)

    def test_countdown_screenshots_share_one_surface_conversion_per_test(self) -> None:
        integration_test = Path(__file__).parents[2].joinpath(
            "integration_test", "app_smoke_test.dart"
        ).read_text(encoding="utf-8")
        self.assertEqual(integration_test.count("convertFlutterSurfaceToImage()"), 1)
        self.assertIn("_countdownScreenshotSurfaceConverted", integration_test)
        self.assertNotIn("revertFlutterImage", integration_test)
        self.assertIn("'countdown_quick_bar'", integration_test)
        self.assertIn("'countdown_outside_tile'", integration_test)

    def test_manifest_hash_comparison_ignores_sha256sum_output_paths(self) -> None:
        digest = "35b1de752a9cdf894c67eee838538f616d6d72654f7e4aa2cf80409749a43cc2"
        with tempfile.TemporaryDirectory() as temporary_directory:
            root = Path(temporary_directory)
            baseline = root / "baseline" / "production-pubspec.sha256"
            candidate = root / "candidate" / "production-pubspec.sha256"
            baseline.parent.mkdir()
            candidate.parent.mkdir()
            baseline.write_text(
                f"{digest}  /runner/temp/baseline/production-pubspec.yaml\n",
                encoding="utf-8",
            )
            candidate.write_text(
                f"{digest}  /runner/temp/candidate/production-pubspec.yaml\n",
                encoding="utf-8",
            )

            self.assertEqual(compare_manifest_hashes(baseline, candidate), digest)

    def test_manifest_hash_comparison_rejects_different_content_hashes(self) -> None:
        with tempfile.TemporaryDirectory() as temporary_directory:
            root = Path(temporary_directory)
            baseline = root / "baseline.sha256"
            candidate = root / "candidate.sha256"
            baseline.write_text(f"{'a' * 64}  baseline.yaml\n", encoding="utf-8")
            candidate.write_text(f"{'b' * 64}  candidate.yaml\n", encoding="utf-8")

            with self.assertRaisesRegex(ValueError, "content hashes differ"):
                compare_manifest_hashes(baseline, candidate)

    def test_release_build_uses_separate_validated_production_dependencies(self) -> None:
        release = function_body("build_release_revision", "run_profile_revision() {")
        enforce_full_lock = release.index("flutter pub get --enforce-lockfile")
        strip_test_dependency = release.index(
            'dependency = "  integration_test:\\n    sdk: flutter\\n"'
        )
        production_pub_get = release.index(
            "benchmark stage: resolve production-only dependencies"
        )
        verify_production_lock = release.index("verify_android_production_lock.py")
        enforce_production_lock = release.index(
            "benchmark stage: enforce production-only lock"
        )
        production_config = release.index("flutter build apk --config-only --no-pub")
        plugin_metadata_check = release.index(
            'grep -Fq "integration_test" "$plugin_metadata"'
        )
        registrant_check = release.index(
            'grep -Fq "dev.flutter.plugins.integration_test" "$registrant"'
        )
        release_build = re.search(
            r"^\s+flutter build apk --release", release, re.MULTILINE
        ).start()

        self.assertLess(enforce_full_lock, strip_test_dependency)
        self.assertLess(strip_test_dependency, production_pub_get)
        self.assertLess(production_pub_get, verify_production_lock)
        self.assertLess(verify_production_lock, enforce_production_lock)
        self.assertLess(enforce_production_lock, production_config)
        self.assertLess(enforce_production_lock, plugin_metadata_check)
        self.assertLess(plugin_metadata_check, registrant_check)
        self.assertLess(registrant_check, release_build)
        self.assertIn("--build-name=", release)
        self.assertIn("--build-number=", release)

    def test_profile_command_uses_drive_flags_without_build_identity_flags(self) -> None:
        profile = function_body(
            "run_profile_revision", 'build_release_revision baseline "$baseline_sha"'
        )
        self.assertIn("flutter drive --profile --no-pub", profile)
        self.assertIn("--dart-define-from-file=", profile)
        self.assertNotIn("--build-name", profile)
        self.assertNotIn("--build-number", profile)

    def test_both_release_apks_and_size_summary_precede_profile_runs(self) -> None:
        baseline_release = BENCHMARK_SCRIPT.index(
            'build_release_revision baseline "$baseline_sha"'
        )
        candidate_release = BENCHMARK_SCRIPT.index(
            'build_release_revision candidate "$candidate_sha"'
        )
        size_report = BENCHMARK_SCRIPT.index(
            'python3 "$repo_root/.github/scripts/android_apk_report.py"'
        )
        profile_start = BENCHMARK_SCRIPT.index(
            'run_profile_revision baseline "$baseline_sha"'
        )
        profile_candidate = BENCHMARK_SCRIPT.index(
            'run_profile_revision candidate "$candidate_sha"'
        )

        self.assertLess(baseline_release, candidate_release)
        self.assertLess(candidate_release, size_report)
        self.assertLess(size_report, profile_start)
        self.assertLess(profile_start, profile_candidate)
        self.assertIn("--summary-output", BENCHMARK_SCRIPT)
        self.assertIn("GITHUB_STEP_SUMMARY", BENCHMARK_SCRIPT)

    def test_apk_summary_receives_both_revision_ids(self) -> None:
        summary_start = BENCHMARK_SCRIPT.index(
            'python3 - "$evidence_dir" "$baseline_sha" "$candidate_sha" <<\'PY\''
        )
        summary_end = BENCHMARK_SCRIPT.index("\nPY\n", summary_start)
        summary = BENCHMARK_SCRIPT[summary_start:summary_end]

        self.assertIn("baseline_sha, candidate_sha = sys.argv[2:]", summary)
        self.assertIn('f"- Measured-before baseline: `{baseline_sha}` (no source patch)."', summary)
        self.assertIn('f"- Candidate: `{candidate_sha}`."', summary)

    def test_candidate_profile_runs_even_if_baseline_gif_validation_fails(self) -> None:
        baseline = BENCHMARK_SCRIPT.index(
            'run_profile_revision baseline "$baseline_sha" &'
        )
        baseline_wait = BENCHMARK_SCRIPT.index('wait "$baseline_profile_pid"', baseline)
        candidate = BENCHMARK_SCRIPT.index(
            'run_profile_revision candidate "$candidate_sha" &', baseline_wait
        )
        candidate_wait = BENCHMARK_SCRIPT.index(
            'wait "$candidate_profile_pid"', candidate
        )
        result_check = BENCHMARK_SCRIPT.index(
            'if [ "$baseline_profile_status" -ne 0 ]', candidate_wait
        )
        profile = function_body(
            "run_profile_revision", 'build_release_revision baseline "$baseline_sha"'
        )

        self.assertLess(baseline, baseline_wait)
        self.assertLess(baseline_wait, candidate)
        self.assertLess(candidate, candidate_wait)
        self.assertLess(candidate_wait, result_check)
        self.assertIn(
            'local source_dir="$runner_temp/expiliplus-android-profile-$label"',
            profile,
        )
        self.assertIn('profile_source_dir="$runner_temp/expiliplus-android-profile-$label"', BENCHMARK_SCRIPT)

    def test_profile_harness_is_copied_only_after_release_build_function(self) -> None:
        release = function_body("build_release_revision", "run_profile_revision() {")
        profile = function_body(
            "run_profile_revision", 'build_release_revision baseline "$baseline_sha"'
        )
        self.assertIn('cp "$release_apk" "$output_dir/expiliplus-arm64-release.apk"', release)
        self.assertNotIn("android_gif_benchmark_test.dart", release)
        self.assertIn("android_gif_benchmark_test.dart", profile)
        self.assertIn("android_benchmark_video_data.dart", profile)

    def test_android_revisions_share_one_locked_event_loop_artifact_set(self) -> None:
        self.assertIn(
            "':(exclude)third_party/android-gif-libmpv/media_kit_native_event_loop'",
            BENCHMARK_SCRIPT,
        )
        self.assertIn("MEDIA_KIT_ANDROID_VIDEO_ARTIFACT_DIR", BENCHMARK_SCRIPT)
        self.assertIn("media_kit_native_event_loop_source_commit=73771ec", BENCHMARK_SCRIPT)
        self.assertIn('"identical_staged_jar_sha256": {}', BENCHMARK_SCRIPT)
        self.assertIn("hashlib.sha256(path.read_bytes()).hexdigest()", BENCHMARK_SCRIPT)
        self.assertIn(
            "MEDIA_KIT_ANDROID_VIDEO_ARTIFACT_DIR: ${{ runner.temp }}/android-gif-event-loop-artifacts",
            BENCHMARK_WORKFLOW,
        )

    def test_dependency_guard_excludes_only_the_shared_event_loop_builder_source(self) -> None:
        with tempfile.TemporaryDirectory() as temporary_directory:
            root = Path(temporary_directory)

            def git(*arguments: str) -> str:
                result = subprocess.run(
                    ["git", *arguments],
                    cwd=root,
                    check=True,
                    capture_output=True,
                    text=True,
                )
                return result.stdout.strip()

            git("init", "--quiet")
            git("config", "user.name", "Test")
            git("config", "user.email", "test@example.invalid")
            event_source = root / "third_party/android-gif-libmpv/media_kit_native_event_loop/source.md"
            production_input = root / "third_party/media-plugin/artifact.jar"
            event_source.parent.mkdir(parents=True)
            production_input.parent.mkdir(parents=True)
            event_source.write_text("pinned callback source\n", encoding="utf-8")
            production_input.write_text("unchanged product artifact\n", encoding="utf-8")
            git("add", "third_party")
            git("commit", "--quiet", "-m", "base")
            baseline = git("rev-parse", "HEAD")

            event_source.write_text("candidate callback source\n", encoding="utf-8")
            git("add", "third_party/android-gif-libmpv/media_kit_native_event_loop/source.md")
            git("commit", "--quiet", "-m", "event-loop builder source")
            candidate = git("rev-parse", "HEAD")
            guarded_paths = [
                "third_party/",
                ":(exclude)third_party/android-gif-libmpv/media_kit_native_event_loop",
            ]
            unchanged = subprocess.run(
                ["git", "diff", "--quiet", baseline, candidate, "--", *guarded_paths],
                cwd=root,
                check=False,
            )
            self.assertEqual(unchanged.returncode, 0)

            production_input.write_text("changed product artifact\n", encoding="utf-8")
            git("add", "third_party/media-plugin/artifact.jar")
            git("commit", "--quiet", "-m", "product artifact change")
            changed = subprocess.run(
                ["git", "diff", "--quiet", baseline, "HEAD", "--", *guarded_paths],
                cwd=root,
                check=False,
            )
            self.assertEqual(changed.returncode, 1)


if __name__ == "__main__":
    unittest.main()
