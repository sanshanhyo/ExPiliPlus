#!/usr/bin/env bash
set -euo pipefail

evidence_dir="${1:?Usage: android_integration_test.sh <evidence-directory>}"
require_countdown_screenshots="${2:-false}"
mkdir -p "$evidence_dir"

pull_countdown_screenshots() {
  local screenshot
  for screenshot in countdown_quick_bar.png countdown_outside_tile.png; do
    if adb exec-out run-as io.github.sanshanhyo.expiliplus.debug \
      cat "cache/$screenshot" > "$evidence_dir/$screenshot" 2>/dev/null; then
      test -s "$evidence_dir/$screenshot"
    elif [ "$require_countdown_screenshots" = "true" ]; then
      echo "Could not pull required countdown screenshot: $screenshot" >&2
      return 1
    fi
  done
}

capture_emulator_evidence() {
  adb exec-out screencap -p > "$evidence_dir/emulator-screen.png" 2>/dev/null || true
  adb logcat -d -t 2000 -v time > "$evidence_dir/android-logcat.txt" 2>/dev/null || true
  pull_countdown_screenshots || true
}
trap capture_emulator_evidence EXIT
trap 'exit 143' TERM
trap 'exit 130' INT

adb shell settings put system volume_music 0
flutter test --reporter expanded integration_test/app_smoke_test.dart -d emulator-5554
if [ "$require_countdown_screenshots" = "true" ]; then
  pull_countdown_screenshots
fi

gif_file="$(adb shell find /sdcard/Pictures/ExPiliPlus -type f -iname '*.gif' -print -quit | tr -d '\r')"
test -n "$gif_file"
echo "verified_gif_export=$gif_file"

gif_copy="$evidence_dir/export.gif"
adb pull "$gif_file" "$gif_copy"
test -s "$gif_copy"
echo "saved_gif_for_post_screenshot_validation=$gif_copy"
