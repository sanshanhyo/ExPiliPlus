#!/usr/bin/env bash
set -uo pipefail

evidence_dir="build/test-artifacts/aicu-real-webview"
mkdir -p "$evidence_dir"
logcat_file="$evidence_dir/android-logcat.txt"

adb logcat -c
adb logcat -v threadtime >"$logcat_file" 2>&1 &
logcat_pid=$!

cleanup() {
  kill "$logcat_pid" >/dev/null 2>&1 || true
  wait "$logcat_pid" 2>/dev/null || true
}
trap cleanup EXIT

flutter drive \
  --driver=integration_test/aicu_real_webview_driver.dart \
  --target=integration_test/aicu_real_webview_test.dart \
  --no-pub \
  -d emulator-5554
status=$?

cleanup
trap - EXIT

if (( status != 0 )); then
  echo "AICU Android WebView test failed with exit code $status. Recent renderer/app diagnostics:"
  if [[ -f "$logcat_file" ]]; then
    rg -n -i -C 2 'chromium|webview|crash|fatal|oom|killed|lowmemory|xpiliplus|flutter|signal' "$logcat_file" | tail -n 240 || true
  fi
  exit "$status"
fi
