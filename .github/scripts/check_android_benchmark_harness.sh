#!/usr/bin/env bash
set -euo pipefail

if [ "$#" -lt 3 ] || [ "$#" -gt 4 ]; then
  echo "Usage: check_android_benchmark_harness.sh CANDIDATE_SHA VIDEO_DATA_DART EVIDENCE_DIR [STAGED_ARTIFACT_DIR]" >&2
  exit 2
fi

candidate_sha="$1"
video_data_dart="$2"
evidence_dir="$3"
repo_root="${GITHUB_WORKSPACE:-$(git rev-parse --show-toplevel)}"
runner_temp="${RUNNER_TEMP:-${TMPDIR:-/tmp}}"
source_dir="$runner_temp/expiliplus-benchmark-harness-preflight"
patch_log="$evidence_dir/android-patch.log"
event_loop_log="$evidence_dir/event-loop-build.log"
analyze_log="$evidence_dir/dart-analyze.log"
staged_artifact_dir="${4:-}"

case "$source_dir" in
  "$runner_temp"/*) ;;
  *) echo "Refusing unexpected preflight worktree path: $source_dir" >&2; exit 1 ;;
esac

mkdir -p "$evidence_dir"
git -C "$repo_root" cat-file -e "${candidate_sha}^{commit}"

cleanup() {
  if git -C "$repo_root" worktree list --porcelain |
    awk -v target="$source_dir" '$1 == "worktree" && $2 == target { found = 1 } END { exit !found }'; then
    git -C "$repo_root" worktree remove --force "$source_dir" || true
  fi
}
trap cleanup EXIT

git -C "$repo_root" worktree add --detach "$source_dir" "$candidate_sha"
if (
  cd "$source_dir"
  GITHUB_WORKSPACE="$source_dir" timeout --foreground --signal=TERM --kill-after=60s 20m \
    pwsh lib/scripts/patch.ps1 Android
) > "$patch_log" 2>&1; then
  :
else
  status=$?
  echo "Benchmark harness Android dependency setup failed with status $status." >&2
  tail -n 120 "$patch_log" >&2 || true
  exit "$status"
fi

cp "$source_dir/.github/benchmarks/android_gif_benchmark_test.dart" \
  "$source_dir/integration_test/android_gif_benchmark_test.dart"
cp "$source_dir/.github/benchmarks/android_benchmark_driver.dart" \
  "$source_dir/integration_test/android_benchmark_driver.dart"
cp "$video_data_dart" "$source_dir/integration_test/android_benchmark_video_data.dart"

if (
  cd "$source_dir"
  timeout --foreground --signal=TERM --kill-after=30s 5m \
    flutter analyze --no-pub --no-fatal-infos --no-fatal-warnings \
    integration_test/android_gif_benchmark_test.dart \
    integration_test/android_benchmark_driver.dart
) > "$analyze_log" 2>&1; then
  cat "$analyze_log"
else
  status=$?
  echo "Injected GIF benchmark Dart analysis failed with status $status." >&2
  tail -n 120 "$analyze_log" >&2 || true
  exit "$status"
fi

echo "Android GIF benchmark injection passed Dart analysis for $candidate_sha."

if [ -n "$staged_artifact_dir" ]; then
  for artifact in default-arm64-v8a.jar default-armeabi-v7a.jar default-x86_64.jar; do
    if [ ! -s "$staged_artifact_dir/$artifact" ]; then
      echo "Prebuilt GIF artifact is missing: $staged_artifact_dir/$artifact" >&2
      exit 1
    fi
  done
  metadata="$staged_artifact_dir/build-metadata.txt"
  if ! grep -Fxq \
    "media_kit_native_event_loop_source_commit=73771ec38176be2d984a3049c28177bce23b54a0" \
    "$metadata" ||
    ! grep -Fxq 'fps_filter=enabled' "$metadata" ||
    ! grep -Fxq 'scale_filter=enabled' "$metadata"; then
    echo "Prebuilt GIF artifact metadata is missing the pinned callback or filters." >&2
    cat "$metadata" >&2
    exit 1
  fi
  printf 'reused_staged_gif_artifacts=%s\n' "$staged_artifact_dir" \
    | tee "$event_loop_log"
else
  if (
    cd "$source_dir"
    bash lib/scripts/build_android_event_loop_compat.sh \
      "$runner_temp/android-gif-event-loop-artifacts" \
      "$evidence_dir/event-loop-build"
  ) > "$event_loop_log" 2>&1; then
    cat "$event_loop_log"
  else
    status=$?
    echo "Benchmark event-loop compatibility build failed with status $status." >&2
    tail -n 120 "$event_loop_log" >&2 || true
    exit "$status"
  fi
fi
