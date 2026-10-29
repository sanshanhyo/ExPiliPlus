#!/usr/bin/env bash
set -uo pipefail

evidence_dir="build/test-artifacts/aicu-real-webview"
mkdir -p "$evidence_dir"
logcat_file="$evidence_dir/android-logcat.txt"
flutter_log="$evidence_dir/flutter-drive.log"
screenshot_file="$evidence_dir/uid-2-android-webview.png"

adb logcat -c
adb logcat -v threadtime >"$logcat_file" 2>&1 &
logcat_pid=$!

cleanup() {
  kill "$logcat_pid" >/dev/null 2>&1 || true
  wait "$logcat_pid" 2>/dev/null || true
}
trap cleanup EXIT

set +e
flutter drive \
  --driver=integration_test/aicu_real_webview_driver.dart \
  --target=integration_test/aicu_real_webview_test.dart \
  --no-pub \
  -d emulator-5554 2>&1 | tee "$flutter_log" | while IFS= read -r line; do
  printf '%s\n' "$line"
  if [[ "$line" == *AICU_REAL_WEBVIEW_SCREENSHOT_READY* && ! -s "$screenshot_file" ]]; then
    # Capture the emulator display directly while the production WebView is
    # still open. This avoids asking Flutter's integration binding to convert
    # a platform WebView surface after Chromium has become unstable.
    sleep 1
    if adb -s emulator-5554 exec-out screencap -p >"$screenshot_file"; then
      signature=$(od -An -tx1 -N8 "$screenshot_file" | tr -d ' \n')
      if [[ "$signature" == "89504e470d0a1a0a" ]]; then
        echo "Captured real Android emulator screen with AICU UID 2 in-app WebView: $screenshot_file"
      else
        echo "Android screen capture did not produce a PNG signature"
        rm -f "$screenshot_file"
      fi
    else
      echo "adb screencap failed while the AICU page was open"
      rm -f "$screenshot_file"
    fi
  fi
done
pipeline_status=("${PIPESTATUS[@]}")
status="${pipeline_status[0]}"

# flutter drive may surface the integration app's failure only in its streamed
# test output. Do not let a screenshot alone make a timed-out test look green.
if grep -Fq 'Some tests failed' "$flutter_log" || \
   grep -Eq 'TimeoutException after .*Test timed out' "$flutter_log"; then
  echo "Flutter integration output contains a failed or timed-out test."
  status=1
fi

for marker in \
  'AICU_REAL_WEBVIEW_SCREENSHOT_READY' \
  'AICU_REAL_WEBVIEW_SCROLL_VERIFIED' \
  'AICU_REAL_WEBVIEW_ROUTE_CLOSED'; do
  if ! grep -Fq "$marker" "$flutter_log"; then
    echo "Missing required real WebView verification marker: $marker"
    status=1
  fi
done

cleanup
trap - EXIT

if [[ ! -s "$screenshot_file" ]]; then
  echo "No real Android screenshot was captured after the AICU UID 2 page loaded."
  status=1
fi

if (( status != 0 )); then
  echo "AICU Android WebView test failed with exit code $status. Recent renderer/app diagnostics:"
  if [[ -f "$flutter_log" ]]; then
    tail -n 160 "$flutter_log" || true
  fi
  if [[ -f "$logcat_file" ]]; then
    grep -n -i -E -C 2 'chromium|webview|crash|fatal|oom|killed|lowmemory|xpiliplus|flutter|signal' "$logcat_file" | tail -n 240 || true
  fi
  exit "$status"
fi
