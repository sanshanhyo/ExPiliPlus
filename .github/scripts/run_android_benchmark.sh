#!/usr/bin/env bash
set -euo pipefail

if [ "$#" -ne 3 ]; then
  echo "Usage: run_android_benchmark.sh BASELINE_SHA CANDIDATE_SHA EVIDENCE_DIR" >&2
  exit 2
fi

baseline_sha="$1"
candidate_sha="$2"
evidence_dir="$3"
repo_root="${GITHUB_WORKSPACE:-$(git rev-parse --show-toplevel)}"
runner_temp="${RUNNER_TEMP:-${TMPDIR:-/tmp}}"
source_dir="$runner_temp/expiliplus-android-benchmark-source"
fixture="$runner_temp/expiliplus-android-benchmark-source.mp4"
defines_file="$runner_temp/expiliplus-android-benchmark-defines.json"
package_name="io.github.sanshanhyo.expiliplus"
start_epoch="$(date +%s)"
event_loop_artifact_dir="${MEDIA_KIT_ANDROID_VIDEO_ARTIFACT_DIR:-}"
event_loop_metadata=""
if [ -n "$event_loop_artifact_dir" ]; then
  event_loop_metadata="$event_loop_artifact_dir/build-metadata.txt"
fi

case "$source_dir" in
  "$runner_temp"/*) ;;
  *) echo "Refusing unexpected temporary worktree path: $source_dir" >&2; exit 1 ;;
esac

mkdir -p "$evidence_dir/baseline" "$evidence_dir/candidate" "$evidence_dir/toolchain"
git -C "$repo_root" cat-file -e "${baseline_sha}^{commit}"
git -C "$repo_root" cat-file -e "${candidate_sha}^{commit}"

if ! git -C "$repo_root" diff --quiet "$baseline_sha" "$candidate_sha" -- \
  pubspec.yaml pubspec.lock pubspec_overrides.yaml UPSTREAM_VERSION android/ third_party/ \
  ':(exclude)third_party/android-gif-libmpv/media_kit_native_event_loop' \
  lib/scripts/patch.ps1; then
  echo "Baseline and candidate have different dependency or Android build inputs." >&2
  echo "This benchmark requires a reviewed matched toolchain/configuration pair." >&2
  git -C "$repo_root" diff --stat "$baseline_sha" "$candidate_sha" -- \
    pubspec.yaml pubspec.lock pubspec_overrides.yaml UPSTREAM_VERSION android/ third_party/ \
    ':(exclude)third_party/android-gif-libmpv/media_kit_native_event_loop' \
    lib/scripts/patch.ps1 >&2
  exit 1
fi

if [ -z "$event_loop_artifact_dir" ] || [ ! -s "$event_loop_metadata" ]; then
  echo "The same staged media_kit event-loop artifacts must be provided to both Android revision builds." >&2
  exit 1
fi
if ! grep -Fxq \
  "media_kit_native_event_loop_source_commit=73771ec38176be2d984a3049c28177bce23b54a0" \
  "$event_loop_metadata" ||
  ! grep -Fxq "media_kit_native_event_loop_api=legacy-wakeup-callback-v1" \
    "$event_loop_metadata" ||
  ! grep -Fxq "media_kit_native_event_loop_ndk_version=28.2.13676358" \
    "$event_loop_metadata"; then
  echo "Staged event-loop artifacts are not the validated locked-source Android callback build." >&2
  exit 1
fi
for artifact in default-arm64-v8a.jar default-armeabi-v7a.jar default-x86_64.jar; do
  if [ ! -s "$event_loop_artifact_dir/$artifact" ]; then
    echo "Staged Android artifact is missing: $event_loop_artifact_dir/$artifact" >&2
    exit 1
  fi
done
mkdir -p "$evidence_dir/toolchain/android-event-loop"
cp "$event_loop_metadata" "$evidence_dir/toolchain/android-event-loop/build-metadata.txt"
cp "$event_loop_artifact_dir"/default-*.jar "$evidence_dir/toolchain/android-event-loop/"
cp "$event_loop_artifact_dir/licenses.txt" \
  "$evidence_dir/toolchain/android-event-loop/licenses.txt"
cp "$event_loop_artifact_dir/licenses/media_kit_native_event_loop-source-LICENSE" \
  "$evidence_dir/toolchain/android-event-loop/LICENSE"
sha256sum "$evidence_dir/toolchain/android-event-loop"/*.jar \
  > "$evidence_dir/toolchain/android-event-loop/staged-jar-hashes.txt"

python3 -m unittest discover -s "$repo_root/.github/scripts" \
  -p 'android_apk_report_unit_tests.py' -v
python3 -m unittest discover -s "$repo_root/.github/scripts" \
  -p 'android_benchmark_lock_unit_tests.py' -v

baseline_lock_sha="$(git -C "$repo_root" show "$baseline_sha:pubspec.lock" | sha256sum | awk '{print $1}')"
candidate_lock_sha="$(git -C "$repo_root" show "$candidate_sha:pubspec.lock" | sha256sum | awk '{print $1}')"
if [ "$baseline_lock_sha" != "$candidate_lock_sha" ]; then
  echo "pubspec.lock differs between benchmark inputs" >&2
  exit 1
fi

version_line="$(git -C "$repo_root" show "$baseline_sha:pubspec.yaml" | sed -n 's/^version:[[:space:]]*//p' | head -n 1 | tr -d '"')"
upstream_version="$(git -C "$repo_root" show "$baseline_sha:UPSTREAM_VERSION" | tr -d '\r\n')"
build_name="${version_line%%+*}"
build_number="${version_line#*+}"
if [ -z "$version_line" ] || [ "$build_number" = "$version_line" ]; then
  echo "Could not resolve a stable app version/build number from pubspec.yaml" >&2
  exit 1
fi

python3 - "$defines_file" "$build_name" "$build_number" "$upstream_version" <<'PY'
import json
import sys

output, name, code, upstream = sys.argv[1:]
defines = {
    "pili.name": f"{name}-benchmark",
    "pili.code": int(code),
    "pili.upstream": upstream,
    "pili.release": False,
    "pili.hash": "0" * 40,
    "pili.time": 0,
}
with open(output, "w", encoding="utf-8") as target:
    json.dump(defines, target, sort_keys=True, separators=(",", ":"))
    target.write("\n")
PY

flutter --version --machine > "$evidence_dir/toolchain/flutter.json"
java -version > "$evidence_dir/toolchain/java-version.txt" 2>&1
ffmpeg -version > "$evidence_dir/toolchain/ffmpeg-version.txt" 2>&1
adb shell getprop ro.build.version.release > "$evidence_dir/toolchain/android-release.txt"
adb shell getprop ro.build.version.sdk > "$evidence_dir/toolchain/android-api.txt"
sha256sum "$defines_file" > "$evidence_dir/toolchain/benchmark-defines.sha256"
python3 - "$evidence_dir/benchmark-metadata.json" \
  "$baseline_sha" "$candidate_sha" "$baseline_lock_sha" \
  "$build_name" "$build_number" "$upstream_version" "$event_loop_artifact_dir" <<'PY'
import json
import hashlib
import sys
from pathlib import Path

output, baseline, candidate, lock_sha, name, code, upstream, event_loop_dir = sys.argv[1:]
metadata = {
    "baseline_sha": baseline,
    "candidate_sha": candidate,
    "runner": "ubuntu-22.04",
    "flutter": "3.47.7",
    "java": "Temurin 17",
    "android_emulator": {
        "api": 35,
        "abi": "x86_64",
        "profile": "pixel_6",
        "gpu": "swiftshader_indirect",
        "audio": "disabled",
    },
    "pubspec_lock_input_sha256": lock_sha,
    "release_apk": {
        "mode": "release",
        "command": "flutter build apk --release --split-per-abi --no-pub --dart-define-from-file=<fixed benchmark defines> --build-name=<fixed> --build-number=<fixed>",
        "dependency_profile": "production pubspec with only the integration_test SDK dev dependency omitted",
        "integration_test_and_synthetic_fixture_in_release_apk": False,
        "reported_abi": "arm64-v8a",
        "version_name": name,
        "version_code": int(code),
        "pili_release": False,
        "pili_upstream": upstream,
        "pili_hash": "0" * 40,
        "pili_time": 0,
    },
    "android_event_loop_artifacts": {
        "source_commit": "73771ec38176be2d984a3049c28177bce23b54a0",
        "api": "legacy-wakeup-callback-v1",
        "ndk_version": "28.2.13676358",
        "identical_staged_jar_sha256": {},
    },
    "gif_profile": {
        "warmup_runs": 1,
        "measured_runs": 5,
        "dependency_profile": "full normalized lock restored after Release APK capture",
        "memory_samples_include_integration_test_harness": True,
        "clip": "synthetic testsrc 854x480, 30 fps, 8 seconds, H.264, no audio",
        "start_seconds": 1,
        "duration_seconds": 3,
        "width": 480,
        "fps": 10,
        "converter": "production createGifConverter / Android MPV FFI path",
        "test_mode": "isolated Flutter profile integration target; no app UI or network playback",
        "memory_sampling_interval_seconds": 1,
    },
}
for artifact in (
    "default-arm64-v8a.jar",
    "default-armeabi-v7a.jar",
    "default-x86_64.jar",
):
    path = Path(event_loop_dir) / artifact
    metadata["android_event_loop_artifacts"]["identical_staged_jar_sha256"][artifact] = (
        hashlib.sha256(path.read_bytes()).hexdigest()
    )
with open(output, "w", encoding="utf-8") as target:
    json.dump(metadata, target, indent=2, sort_keys=True)
    target.write("\n")
PY

ffmpeg -hide_banner -loglevel error -y \
  -f lavfi -i 'testsrc=size=854x480:rate=30:duration=8' \
  -frames:v 240 -an -c:v libx264 -preset veryfast -crf 28 -threads 1 \
  -pix_fmt yuv420p -x264-params 'keyint=30:min-keyint=30:scenecut=0' \
  -movflags +faststart "$fixture"
test -s "$fixture"
sha256sum "$fixture" > "$evidence_dir/toolchain/synthetic-video.sha256"
python3 "$repo_root/.github/scripts/embed_android_benchmark_video.py" \
  "$fixture" "$runner_temp/android_benchmark_video_data.dart"

cleanup() {
  if git -C "$repo_root" worktree list --porcelain |
    awk -v target="$source_dir" '$1 == "worktree" && $2 == target { found = 1 } END { exit !found }'; then
    git -C "$repo_root" worktree remove --force "$source_dir" || true
  fi
  rm -f "$fixture" "$defines_file" "$runner_temp/android_benchmark_video_data.dart"
}
trap cleanup EXIT

build_release_revision() {
  local label="$1"
  local source_sha="$2"
  local output_dir="$evidence_dir/$label"
  local input_lock_sha
  local normalized_lock_sha
  local config_lock_sha
  local full_lock_sha
  local production_lock_sha
  local plugin_metadata
  local stage_status=0
  local release_apk

  git -C "$repo_root" worktree add --detach "$source_dir" "$source_sha"

  input_lock_sha="$(sha256sum "$source_dir/pubspec.lock" | awk '{print $1}')"
  printf '%s\n' "$input_lock_sha" > "$output_dir/input-pubspec-lock.sha256"
  cp "$source_dir/pubspec.lock" "$output_dir/input-pubspec.lock"
  if [ "$input_lock_sha" != "$baseline_lock_sha" ]; then
    echo "Input lock hash for $label does not match the recorded baseline lock." >&2
    return 1
  fi
  if [ "$label" = "baseline" ]; then
    cp "$source_dir/pubspec.lock" "$evidence_dir/toolchain/input-pubspec.lock"
  fi

  if (
    cd "$source_dir" &&
    echo "benchmark stage: Android patch ($label)" &&
    timeout --foreground --signal=TERM --kill-after=60s 20m \
      pwsh lib/scripts/patch.ps1 Android
  ) > "$output_dir/android-patch.log" 2>&1; then
    :
  else
    stage_status=$?
    echo "Android patch failed for $label ($source_sha), status $stage_status." >&2
    echo "Last 120 lines of $output_dir/android-patch.log:" >&2
    tail -n 120 "$output_dir/android-patch.log" >&2 || true
    return "$stage_status"
  fi

  if [ "$label" = "baseline" ]; then
    if (
      cd "$source_dir" &&
      echo "benchmark stage: resolve the baseline lock for pinned Flutter 3.47.7" &&
      timeout --foreground --signal=TERM --kill-after=60s 15m \
        flutter pub get
    ) > "$output_dir/pub-get-normalize.log" 2>&1; then
      :
    else
      stage_status=$?
      echo "Baseline lock normalization failed, status $stage_status." >&2
      echo "Last 120 lines of $output_dir/pub-get-normalize.log:" >&2
      tail -n 120 "$output_dir/pub-get-normalize.log" >&2 || true
      return "$stage_status"
    fi

    cp "$source_dir/pubspec.lock" "$evidence_dir/toolchain/normalized-pubspec.lock"
    if diff -u \
      "$evidence_dir/toolchain/input-pubspec.lock" \
      "$evidence_dir/toolchain/normalized-pubspec.lock" \
      > "$evidence_dir/toolchain/lock-normalization.diff"; then
      :
    else
      stage_status=$?
      if [ "$stage_status" -ne 1 ]; then
        echo "Could not create the lock normalization diff (status $stage_status)." >&2
        return "$stage_status"
      fi
    fi
    python3 "$repo_root/.github/scripts/verify_android_benchmark_lock.py" \
      --original "$evidence_dir/toolchain/input-pubspec.lock" \
      --normalized "$evidence_dir/toolchain/normalized-pubspec.lock" \
      --report "$evidence_dir/toolchain/lock-normalization.json"
    normalized_lock_sha="$(sha256sum "$evidence_dir/toolchain/normalized-pubspec.lock" | awk '{print $1}')"
    echo "Shared normalized lock SHA-256: $normalized_lock_sha"
    python3 - "$evidence_dir/benchmark-metadata.json" "$normalized_lock_sha" <<'PY'
import json
import sys

metadata_path, normalized_lock_sha = sys.argv[1:]
with open(metadata_path, encoding="utf-8") as source:
    metadata = json.load(source)
metadata["pubspec_lock_normalized_sha256"] = normalized_lock_sha
with open(metadata_path, "w", encoding="utf-8") as target:
    json.dump(metadata, target, indent=2, sort_keys=True)
    target.write("\n")
PY
  else
    if [ ! -s "$evidence_dir/toolchain/normalized-pubspec.lock" ]; then
      echo "The validated normalized lock is missing before the candidate build." >&2
      return 1
    fi
    normalized_lock_sha="$(sha256sum "$evidence_dir/toolchain/normalized-pubspec.lock" | awk '{print $1}')"
    cp "$evidence_dir/toolchain/normalized-pubspec.lock" "$source_dir/pubspec.lock"
  fi

  if (
    cd "$source_dir" &&
    echo "benchmark stage: enforce shared normalized lock ($label)" &&
    timeout --foreground --signal=TERM --kill-after=60s 15m \
      flutter pub get --enforce-lockfile
  ) > "$output_dir/pub-get-enforce.log" 2>&1; then
    :
  else
    stage_status=$?
    echo "Enforced Pub resolution failed for $label, status $stage_status." >&2
    echo "Last 120 lines of $output_dir/pub-get-enforce.log:" >&2
    tail -n 120 "$output_dir/pub-get-enforce.log" >&2 || true
    return "$stage_status"
  fi

  local resolved_lock_sha
  resolved_lock_sha="$(sha256sum "$source_dir/pubspec.lock" | awk '{print $1}')"
  printf '%s\n' "$resolved_lock_sha" > "$output_dir/resolved-pubspec-lock.sha256"
  if [ "$resolved_lock_sha" != "$normalized_lock_sha" ]; then
    echo "Enforced Pub resolution changed the shared normalized lock for $label." >&2
    diff -u "$evidence_dir/toolchain/normalized-pubspec.lock" \
      "$source_dir/pubspec.lock" > "$output_dir/enforced-lock-drift.diff" || true
    return 1
  fi

  full_lock_sha="$resolved_lock_sha"
  cp "$source_dir/pubspec.yaml" "$output_dir/full-pubspec.yaml"
  cp "$source_dir/pubspec.lock" "$output_dir/full-pubspec.lock"

  # Flutter registers integration_test even for release builds although Pub
  # strips its dev-only Android artifact. Resolve a production-only manifest
  # for the APK measurement, then restore the full test graph for profile runs.
  python3 - "$output_dir/full-pubspec.yaml" \
    "$output_dir/production-pubspec.yaml" <<'PY'
import sys
from pathlib import Path

source = Path(sys.argv[1]).read_text(encoding="utf-8")
dependency = "  integration_test:\n    sdk: flutter\n"
if source.count(dependency) != 1:
    raise SystemExit("Expected exactly one integration_test SDK dev dependency")
Path(sys.argv[2]).write_text(source.replace(dependency, "", 1), encoding="utf-8")
PY
  diff -u "$output_dir/full-pubspec.yaml" "$output_dir/production-pubspec.yaml" \
    > "$output_dir/production-pubspec.diff" || [ "$?" -eq 1 ]
  sha256sum "$output_dir/production-pubspec.yaml" \
    > "$output_dir/production-pubspec.sha256"
  cp "$output_dir/production-pubspec.yaml" "$source_dir/pubspec.yaml"

  if [ "$label" = "baseline" ]; then
    if (
      cd "$source_dir" &&
      echo "benchmark stage: resolve production-only dependencies ($label)" &&
      timeout --foreground --signal=TERM --kill-after=60s 15m flutter pub get
    ) > "$output_dir/production-pub-get-normalize.log" 2>&1; then
      :
    else
      stage_status=$?
      echo "Production dependency resolution failed for $label, status $stage_status." >&2
      tail -n 120 "$output_dir/production-pub-get-normalize.log" >&2 || true
      return "$stage_status"
    fi
    cp "$source_dir/pubspec.lock" "$output_dir/production-pubspec.lock"
    cp "$output_dir/production-pubspec.lock" \
      "$evidence_dir/toolchain/production-pubspec.lock"
  else
    if [ ! -s "$evidence_dir/toolchain/production-pubspec.lock" ]; then
      echo "Validated baseline production lock is missing for candidate build." >&2
      return 1
    fi
    cp "$evidence_dir/toolchain/production-pubspec.lock" "$source_dir/pubspec.lock"
    cp "$source_dir/pubspec.lock" "$output_dir/production-pubspec.lock"
  fi

  python3 "$repo_root/.github/scripts/verify_android_production_lock.py" \
    --full-lock "$output_dir/full-pubspec.lock" \
    --production-lock "$output_dir/production-pubspec.lock" \
    --report "$output_dir/production-lock-validation.json"

  if (
    cd "$source_dir" &&
    echo "benchmark stage: enforce production-only lock ($label)" &&
    timeout --foreground --signal=TERM --kill-after=60s 15m \
      flutter pub get --enforce-lockfile
  ) > "$output_dir/production-pub-get-enforce.log" 2>&1; then
    :
  else
    stage_status=$?
    echo "Production lock enforcement failed for $label, status $stage_status." >&2
    tail -n 120 "$output_dir/production-pub-get-enforce.log" >&2 || true
    return "$stage_status"
  fi

  production_lock_sha="$(sha256sum "$source_dir/pubspec.lock" | awk '{print $1}')"
  if [ "$production_lock_sha" != "$(sha256sum "$output_dir/production-pubspec.lock" | awk '{print $1}')" ]; then
    echo "Enforced production Pub resolution changed the validated lock for $label." >&2
    diff -u "$output_dir/production-pubspec.lock" "$source_dir/pubspec.lock" \
      > "$output_dir/production-lock-drift.diff" || true
    return 1
  fi
  printf '%s\n' "$production_lock_sha" \
    > "$output_dir/production-pubspec-lock.sha256"

  plugin_metadata="$source_dir/.flutter-plugins-dependencies"
  if [ ! -s "$plugin_metadata" ]; then
    echo "Pub did not generate Android plugin metadata for production dependencies ($label)." >&2
    return 1
  fi
  cp "$plugin_metadata" "$output_dir/production-flutter-plugins-dependencies.json"
  if grep -Fq "integration_test" "$plugin_metadata"; then
    echo "Production Flutter plugin metadata still includes integration_test ($label)." >&2
    return 1
  fi

  # Materialize and inspect the production registrant before the expensive APK
  # task so a dev-plugin leak fails with direct evidence instead of javac output.
  if (
    cd "$source_dir" &&
    echo "benchmark stage: generate production Android configuration ($label)" &&
    timeout --foreground --signal=TERM --kill-after=60s 10m \
      flutter build apk --config-only --no-pub
  ) > "$output_dir/production-config.log" 2>&1; then
    :
  else
    stage_status=$?
    echo "Production Android config generation failed for $label, status $stage_status." >&2
    echo "Last 120 lines of $output_dir/production-config.log:" >&2
    tail -n 120 "$output_dir/production-config.log" >&2 || true
    return "$stage_status"
  fi

  registrant="$source_dir/android/app/src/main/java/io/flutter/plugins/GeneratedPluginRegistrant.java"
  if [ ! -s "$registrant" ]; then
    echo "Flutter did not generate the Android plugin registrant for $label." >&2
    return 1
  fi
  cp "$registrant" "$output_dir/production-GeneratedPluginRegistrant.java"
  if grep -Fq "dev.flutter.plugins.integration_test" "$registrant"; then
    echo "Production plugin registrant still includes the test-only integration_test plugin." >&2
    return 1
  fi
  config_lock_sha="$(sha256sum "$source_dir/pubspec.lock" | awk '{print $1}')"
  if [ "$config_lock_sha" != "$production_lock_sha" ]; then
    echo "Production Android configuration changed the production lock for $label." >&2
    return 1
  fi

  if (
    cd "$source_dir" &&
    echo "benchmark stage: release APK build ($label)" &&
    timeout --foreground --signal=TERM --kill-after=60s 45m \
      flutter build apk --release --split-per-abi --no-pub \
      --dart-define-from-file="$defines_file" \
      --build-name="$build_name" --build-number="$build_number"
  ) > "$output_dir/release-build.log" 2>&1; then
    :
  else
    stage_status=$?
    echo "Release APK build failed for $label ($source_sha), status $stage_status." >&2
    echo "Last 120 lines of $output_dir/release-build.log:" >&2
    tail -n 120 "$output_dir/release-build.log" >&2 || true
    return "$stage_status"
  fi

  release_apk="$source_dir/build/app/outputs/flutter-apk/app-arm64-v8a-release.apk"
  if [ ! -s "$release_apk" ]; then
    echo "Release ARM64 APK was not produced for $label ($source_sha)" >&2
    cat "$output_dir/release-build.log" >&2
    return 1
  fi
  cp "$release_apk" "$output_dir/expiliplus-arm64-release.apk"
  printf '%s\n' "$source_sha" > "$output_dir/source-sha.txt"
  git -C "$repo_root" worktree remove --force "$source_dir"
}

run_profile_revision() {
  local label="$1"
  local source_sha="$2"
  local output_dir="$evidence_dir/$label"
  local stage_status=0
  local profile_lock_sha
  local plugin_metadata

  git -C "$repo_root" worktree add --detach "$source_dir" "$source_sha"
  if (
    cd "$source_dir" &&
    echo "benchmark stage: Android patch for profile GIF ($label)" &&
    timeout --foreground --signal=TERM --kill-after=60s 20m \
      pwsh lib/scripts/patch.ps1 Android
  ) > "$output_dir/profile-android-patch.log" 2>&1; then
    :
  else
    stage_status=$?
    echo "Profile Android patch failed for $label ($source_sha), status $stage_status." >&2
    tail -n 120 "$output_dir/profile-android-patch.log" >&2 || true
    return "$stage_status"
  fi

  cp "$evidence_dir/toolchain/normalized-pubspec.lock" "$source_dir/pubspec.lock"
  if (
    cd "$source_dir" &&
    echo "benchmark stage: resolve full profile-test dependencies ($label)" &&
    timeout --foreground --signal=TERM --kill-after=60s 15m \
      flutter pub get --enforce-lockfile
  ) > "$output_dir/profile-pub-get-enforce.log" 2>&1; then
    :
  else
    stage_status=$?
    echo "Full profile dependencies failed for $label, status $stage_status." >&2
    tail -n 120 "$output_dir/profile-pub-get-enforce.log" >&2 || true
    return "$stage_status"
  fi

  profile_lock_sha="$(sha256sum "$source_dir/pubspec.lock" | awk '{print $1}')"
  if [ "$profile_lock_sha" != "$(sha256sum "$evidence_dir/toolchain/normalized-pubspec.lock" | awk '{print $1}')" ]; then
    echo "Profile dependencies changed the shared normalized lock for $label." >&2
    return 1
  fi
  printf '%s\n' "$profile_lock_sha" > "$output_dir/resolved-pubspec-lock.sha256"
  plugin_metadata="$source_dir/.flutter-plugins-dependencies"
  if ! grep -Fq "integration_test" "$plugin_metadata"; then
    echo "Full profile dependency restore did not register integration_test ($label)." >&2
    return 1
  fi
  cp "$plugin_metadata" "$output_dir/profile-flutter-plugins-dependencies.json"

  # Only the profile integration build receives the test source and fixture.
  cp "$repo_root/.github/benchmarks/android_gif_benchmark_test.dart" \
    "$source_dir/integration_test/android_gif_benchmark_test.dart"
  cp "$repo_root/.github/benchmarks/android_benchmark_driver.dart" \
    "$source_dir/integration_test/android_benchmark_driver.dart"
  cp "$runner_temp/android_benchmark_video_data.dart" \
    "$source_dir/integration_test/android_benchmark_video_data.dart"

  adb shell settings put system volume_music 0
  adb uninstall "$package_name" >/dev/null 2>&1 || true
  adb uninstall "$package_name.debug" >/dev/null 2>&1 || true
  adb uninstall "$package_name.dev" >/dev/null 2>&1 || true
  : > "$output_dir/memory.csv"
  printf 'elapsed_seconds,total_pss_kb\n' > "$output_dir/memory.csv"

  (
    cd "$source_dir"
    export ANDROID_BENCHMARK_OUTPUT_DIR="$output_dir"
    timeout --foreground --signal=TERM --kill-after=60s 35m \
      flutter drive --profile --no-pub \
      --driver=integration_test/android_benchmark_driver.dart \
      --target=integration_test/android_gif_benchmark_test.dart \
      -d emulator-5554 \
      --dart-define-from-file="$defines_file"
  ) > "$output_dir/profile-benchmark.log" 2>&1 &
  local drive_pid=$!
  local sample_start="$(date +%s)"
  while kill -0 "$drive_pid" 2>/dev/null; do
    local elapsed="$(($(date +%s) - sample_start))"
    local pss=""
    local package_candidate
    for package_candidate in "$package_name" "$package_name.debug" "$package_name.dev"; do
      pss="$(adb shell dumpsys meminfo "$package_candidate" 2>/dev/null | awk '/TOTAL PSS:/ {gsub(/,/, "", $3); print $3; exit}' | tr -d '\r')"
      if [[ "$pss" =~ ^[0-9]+$ ]]; then
        break
      fi
    done
    if [[ "$pss" =~ ^[0-9]+$ ]]; then
      printf '%s,%s\n' "$elapsed" "$pss" >> "$output_dir/memory.csv"
    fi
    sleep 1
  done
  local drive_status=0
  wait "$drive_pid" || drive_status=$?
  if [ "$drive_status" -ne 0 ]; then
    echo "Profile GIF benchmark failed for $label ($source_sha), status $drive_status" >&2
    cat "$output_dir/profile-benchmark.log" >&2
    return "$drive_status"
  fi

  if [ ! -s "$output_dir/gif-benchmark.json" ] ||
    [ ! -s "$output_dir/synthetic-output.gif" ]; then
    echo "Profile driver did not save GIF benchmark evidence for $label" >&2
    cat "$output_dir/profile-benchmark.log" >&2
    return 1
  fi
  ffmpeg -hide_banner -v error -xerror -i "$output_dir/synthetic-output.gif" -f null -
  ffprobe -v error -count_frames -select_streams v:0 \
    -show_entries stream=codec_name,width,height,nb_read_frames \
    -of json "$output_dir/synthetic-output.gif" \
    > "$output_dir/gif-decode.json"
  python3 - "$output_dir/gif-decode.json" "$output_dir/gif-benchmark.json" <<'PY'
import json
import sys

with open(sys.argv[1], encoding="utf-8") as source:
    streams = json.load(source).get("streams", [])
with open(sys.argv[2], encoding="utf-8") as source:
    report = json.load(source)
if len(streams) != 1:
    raise SystemExit(f"Expected one GIF video stream, got {len(streams)}")
stream = streams[0]
if stream.get("codec_name") != "gif":
    raise SystemExit(f"Expected GIF codec, got {stream.get('codec_name')!r}")
if int(stream.get("width", 0)) != 480 or int(stream.get("height", 0)) <= 0:
    raise SystemExit(f"Invalid GIF dimensions: {stream.get('width')}x{stream.get('height')}")
if int(stream.get("nb_read_frames", 0)) < 2:
    raise SystemExit(f"GIF decoded fewer than two frames: {stream.get('nb_read_frames')}")
if report.get("fixture_sha256") == "" or not report.get("measured_runs"):
    raise SystemExit("GIF benchmark metadata is incomplete")
print(
    "verified_gif_decode=success "
    f"width={stream['width']} height={stream['height']} "
    f"decoded_frames={stream['nb_read_frames']}"
)
PY
  git -C "$repo_root" worktree remove --force "$source_dir"
}

build_release_revision baseline "$baseline_sha"
build_release_revision candidate "$candidate_sha"

if ! cmp -s \
  "$evidence_dir/baseline/production-pubspec-lock.sha256" \
  "$evidence_dir/candidate/production-pubspec-lock.sha256"; then
  echo "Baseline and candidate production dependency locks differ." >&2
  diff -u "$evidence_dir/baseline/production-pubspec-lock.sha256" \
    "$evidence_dir/candidate/production-pubspec-lock.sha256" >&2 || true
  exit 1
fi
printf 'production_lock_sha256=%s\n' \
  "$(cat "$evidence_dir/baseline/production-pubspec-lock.sha256")" \
  | tee "$evidence_dir/production-lock.sha256"
if ! production_manifest_sha="$(python3 \
  "$repo_root/.github/scripts/compare_android_manifest_hashes.py" \
  "$evidence_dir/baseline/production-pubspec.sha256" \
  "$evidence_dir/candidate/production-pubspec.sha256")"; then
  echo "Baseline and candidate production manifest content hashes differ." >&2
  exit 1
fi
printf 'production_manifest_sha256=%s\n' "$production_manifest_sha" \
  | tee "$evidence_dir/production-manifest.sha256"

python3 "$repo_root/.github/scripts/android_apk_report.py" \
  --baseline "$evidence_dir/baseline/expiliplus-arm64-release.apk" \
  --candidate "$evidence_dir/candidate/expiliplus-arm64-release.apk" \
  --baseline-sha "$baseline_sha" --candidate-sha "$candidate_sha" \
  --output "$evidence_dir/apk-size-comparison.json" \
  --summary-output "$evidence_dir/apk-size-summary.md"
python3 - "$evidence_dir" <<'PY'
import json
import os
import sys
from pathlib import Path

evidence = Path(sys.argv[1])
with (evidence / "toolchain/flutter.json").open(encoding="utf-8") as source:
    flutter = json.load(source)
full_lock_sha = __import__("hashlib").sha256(
    (evidence / "toolchain/normalized-pubspec.lock").read_bytes()
).hexdigest()
production_lock_sha = (evidence / "production-lock.sha256").read_text().strip().split("=", 1)[1]
production_manifest_sha = (
    evidence / "baseline/production-pubspec.sha256"
).read_text().split()[0]
java_version = (evidence / "toolchain/java-version.txt").read_text().strip().replace("\n", " ")
android_release = (evidence / "toolchain/android-release.txt").read_text().strip()
android_api = (evidence / "toolchain/android-api.txt").read_text().strip()
lines = [
    "",
    "### Matched build inputs",
    "",
    f"- Flutter {flutter.get('frameworkVersion')} ({flutter.get('frameworkRevision')}); Dart {flutter.get('dartSdkVersion')}",
    f"- Java: `{java_version}`",
    f"- Android emulator: API {android_api}, Android {android_release}",
    f"- Full profile lock SHA-256: `{full_lock_sha}`",
    f"- Production lock SHA-256: `{production_lock_sha}`",
    f"- Production manifest SHA-256: `{production_manifest_sha}`",
    "- Baseline and candidate production manifest/lock were checked identical before profiling.",
    "",
]
summary = "\n".join(lines)
with (evidence / "apk-size-summary.md").open("a", encoding="utf-8") as target:
    target.write(summary)
print(summary, end="")
summary_path = os.environ.get("GITHUB_STEP_SUMMARY")
if summary_path:
    with open(summary_path, "a", encoding="utf-8") as target:
        target.write((evidence / "apk-size-summary.md").read_text(encoding="utf-8"))
PY

# APK bytes and dependency comparability are recorded before profile GIF work.
# A later profile failure therefore cannot hide the completed package-size result.
run_profile_revision baseline "$baseline_sha"
run_profile_revision candidate "$candidate_sha"

if ! cmp -s \
  "$evidence_dir/baseline/resolved-pubspec-lock.sha256" \
  "$evidence_dir/candidate/resolved-pubspec-lock.sha256"; then
  echo "Baseline and candidate did not resolve to the same normalized full lock." >&2
  diff -u \
    "$evidence_dir/baseline/resolved-pubspec-lock.sha256" \
    "$evidence_dir/candidate/resolved-pubspec-lock.sha256" >&2 || true
  exit 1
fi
echo "Baseline and candidate profile full-lock SHA-256 matches: $(cat "$evidence_dir/baseline/resolved-pubspec-lock.sha256")"

python3 "$repo_root/.github/scripts/summarize_android_benchmark.py" \
  --evidence-dir "$evidence_dir" \
  --baseline-sha "$baseline_sha" --candidate-sha "$candidate_sha" \
  --output "$evidence_dir/comparison.json"

printf 'benchmark_baseline_sha=%s\nbenchmark_candidate_sha=%s\n' \
  "$baseline_sha" "$candidate_sha" | tee "$evidence_dir/commits.txt"
printf 'benchmark_elapsed_seconds=%s\n' "$(($(date +%s) - start_epoch))" \
  | tee "$evidence_dir/elapsed.txt"
cat "$evidence_dir/comparison.json"
