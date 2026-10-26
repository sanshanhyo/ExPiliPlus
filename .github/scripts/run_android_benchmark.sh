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

case "$source_dir" in
  "$runner_temp"/*) ;;
  *) echo "Refusing unexpected temporary worktree path: $source_dir" >&2; exit 1 ;;
esac

mkdir -p "$evidence_dir/baseline" "$evidence_dir/candidate" "$evidence_dir/toolchain"
git -C "$repo_root" cat-file -e "${baseline_sha}^{commit}"
git -C "$repo_root" cat-file -e "${candidate_sha}^{commit}"

if ! git -C "$repo_root" diff --quiet "$baseline_sha" "$candidate_sha" -- \
  pubspec.yaml pubspec.lock UPSTREAM_VERSION android/ third_party/ \
  lib/scripts/patch.ps1; then
  echo "Baseline and candidate have different dependency or Android build inputs." >&2
  echo "This benchmark requires a reviewed matched toolchain/configuration pair." >&2
  git -C "$repo_root" diff --stat "$baseline_sha" "$candidate_sha" -- \
    pubspec.yaml pubspec.lock UPSTREAM_VERSION android/ third_party/ \
    lib/scripts/patch.ps1 >&2
  exit 1
fi

python3 -m unittest discover -s "$repo_root/.github/scripts" \
  -p 'android_apk_report_unit_tests.py' -v

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
  "$build_name" "$build_number" "$upstream_version" <<'PY'
import json
import sys

output, baseline, candidate, lock_sha, name, code, upstream = sys.argv[1:]
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
    "pubspec_lock_sha256": lock_sha,
    "release_apk": {
        "mode": "release",
        "command": "flutter build apk --release --split-per-abi --no-pub --dart-define-from-file=<fixed benchmark defines> --build-name=<fixed> --build-number=<fixed>",
        "reported_abi": "arm64-v8a",
        "version_name": name,
        "version_code": int(code),
        "pili_release": False,
        "pili_upstream": upstream,
        "pili_hash": "0" * 40,
        "pili_time": 0,
    },
    "gif_profile": {
        "warmup_runs": 1,
        "measured_runs": 5,
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

run_one_revision() {
  local label="$1"
  local source_sha="$2"
  local output_dir="$evidence_dir/$label"
  local release_apk

  git -C "$repo_root" worktree add --detach "$source_dir" "$source_sha"
  cp "$repo_root/.github/benchmarks/android_gif_benchmark_test.dart" \
    "$source_dir/integration_test/android_gif_benchmark_test.dart"
  cp "$repo_root/.github/benchmarks/android_benchmark_driver.dart" \
    "$source_dir/integration_test/android_benchmark_driver.dart"
  cp "$runner_temp/android_benchmark_video_data.dart" \
    "$source_dir/integration_test/android_benchmark_video_data.dart"

  local build_status=0
  if (
    cd "$source_dir" &&
    echo "benchmark stage: Android patch ($label)" &&
    pwsh lib/scripts/patch.ps1 Android &&
    echo "benchmark stage: dependency resolution ($label)" &&
    timeout --foreground --signal=TERM --kill-after=60s 15m \
      flutter pub get --enforce-lockfile &&
    echo "benchmark stage: release APK build ($label)" &&
    timeout --foreground --signal=TERM --kill-after=60s 45m \
      flutter build apk --release --split-per-abi --no-pub \
      --dart-define-from-file="$defines_file" \
      --build-name="$build_name" --build-number="$build_number"
  ) > "$output_dir/release-build.log" 2>&1; then
    :
  else
    build_status=$?
    echo "Android build preparation failed for $label ($source_sha), status $build_status." >&2
    echo "Last 120 lines of $output_dir/release-build.log:" >&2
    tail -n 120 "$output_dir/release-build.log" >&2 || true
    return "$build_status"
  fi

  release_apk="$source_dir/build/app/outputs/flutter-apk/app-arm64-v8a-release.apk"
  if [ ! -s "$release_apk" ]; then
    echo "Release ARM64 APK was not produced for $label ($source_sha)" >&2
    cat "$output_dir/release-build.log" >&2
    return 1
  fi
  cp "$release_apk" "$output_dir/expiliplus-arm64-release.apk"
  printf '%s\n' "$source_sha" > "$output_dir/source-sha.txt"

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
      --dart-define-from-file="$defines_file" \
      --build-name="$build_name" --build-number="$build_number"
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

run_one_revision baseline "$baseline_sha"
run_one_revision candidate "$candidate_sha"

python3 "$repo_root/.github/scripts/android_apk_report.py" \
  --baseline "$evidence_dir/baseline/expiliplus-arm64-release.apk" \
  --candidate "$evidence_dir/candidate/expiliplus-arm64-release.apk" \
  --baseline-sha "$baseline_sha" --candidate-sha "$candidate_sha" \
  --output "$evidence_dir/apk-size-comparison.json"

python3 "$repo_root/.github/scripts/summarize_android_benchmark.py" \
  --evidence-dir "$evidence_dir" \
  --baseline-sha "$baseline_sha" --candidate-sha "$candidate_sha" \
  --output "$evidence_dir/comparison.json"

printf 'benchmark_baseline_sha=%s\nbenchmark_candidate_sha=%s\n' \
  "$baseline_sha" "$candidate_sha" | tee "$evidence_dir/commits.txt"
printf 'benchmark_elapsed_seconds=%s\n' "$(($(date +%s) - start_epoch))" \
  | tee "$evidence_dir/elapsed.txt"
cat "$evidence_dir/comparison.json"
