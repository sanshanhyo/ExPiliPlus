#!/usr/bin/env bash
set -euo pipefail

if [ "$#" -ne 1 ]; then
  echo "Usage: run_android_app_gif_validation.sh EVIDENCE_DIR" >&2
  exit 2
fi

evidence_dir="$1"
repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
artifact_dir="${MEDIA_KIT_ANDROID_VIDEO_ARTIFACT_DIR:-}"

if [ -z "$artifact_dir" ] || [ ! -s "$artifact_dir/build-metadata.txt" ]; then
  echo "The validated temporary GIF artifact directory is required." >&2
  exit 1
fi
if ! grep -Fxq 'fps_filter=enabled' "$artifact_dir/build-metadata.txt" ||
  ! grep -Fxq 'scale_filter=enabled' "$artifact_dir/build-metadata.txt"; then
  echo "The staged native artifacts do not confirm both required FFmpeg filters." >&2
  exit 1
fi

mkdir -p "$evidence_dir"

echo "validation_phase=real_android_app_integration"
if bash "$repo_root/.github/scripts/android_integration_test.sh" \
  "$evidence_dir" true > "$evidence_dir/integration-step.log" 2>&1; then
  integration_status=0
else
  integration_status=$?
fi
cat "$evidence_dir/integration-step.log"

gif_validation_status=125
if [ "$integration_status" -eq 0 ]; then
  echo "validation_phase=decode_real_app_gif"
  if python3 "$repo_root/.github/scripts/validate_android_gif.py" \
    "$evidence_dir/export.gif" "$evidence_dir/gif-probe.json" \
    > "$evidence_dir/gif-validation.log" 2>&1; then
    gif_validation_status=0
    sha256sum "$evidence_dir/export.gif" \
      | awk '{print $1}' > "$evidence_dir/export-gif.sha256"
  else
    gif_validation_status=$?
  fi
  cat "$evidence_dir/gif-validation.log"
else
  echo "validation_phase=decode_real_app_gif skipped because app integration failed"
fi

{
  printf 'android_app_integration_status=%s\n' "$integration_status"
  printf 'real_app_gif_validation_status=%s\n' "$gif_validation_status"
} | tee "$evidence_dir/validation-status.txt"

if [ "$integration_status" -ne 0 ] || [ "$gif_validation_status" -ne 0 ]; then
  exit 1
fi
echo "android_app_gif_validation=passed" | tee -a "$evidence_dir/validation-status.txt"
