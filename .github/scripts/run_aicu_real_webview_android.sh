#!/usr/bin/env bash
set -uo pipefail

evidence_dir="build/test-artifacts/aicu-real-webview"
mkdir -p "$evidence_dir"
logcat_file="$evidence_dir/android-logcat.txt"
flutter_log="$evidence_dir/flutter-drive.log"
screenshot_file="$evidence_dir/uid-2-android-webview.png"
diagnostic_screenshot_file="$evidence_dir/uid-2-webview-diagnostic.png"
capture_status_file="$evidence_dir/screenshot-capture-status.txt"
app_id="io.github.sanshanhyo.expiliplus.debug"
ack_prefix="/data/user/0/$app_id/cache/aicu-webview-capture-ack-"
rm -f "$screenshot_file" "$diagnostic_screenshot_file" "$capture_status_file"

is_valid_ack_path() {
  local candidate="$1"
  [[ "$candidate" == "$ack_prefix"* ]] || return 1
  local nonce="${candidate#"$ack_prefix"}"
  [[ "$nonce" =~ ^[0-9]+$ ]]
}

# Exercise the exact path guard before starting an emulator so a quoting
# regression fails quickly instead of waiting for the app's screenshot timeout.
if ! is_valid_ack_path "${ack_prefix}123456" || \
   is_valid_ack_path "${ack_prefix}123/../../outside"; then
  echo 'AICU screenshot acknowledgement path guard failed its preflight.'
  exit 2
fi

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
  if [[ "$line" == *AICU_REAL_WEBVIEW_CAPTURE_REQUESTED* ]]; then
    # Capture the emulator display directly while the production WebView is
    # still open. The integration test waits for the acknowledgement below
    # before it scrolls or pops the route, so capture cannot race with teardown.
    request="${line#*AICU_REAL_WEBVIEW_CAPTURE_REQUESTED }"
    purpose="${request%% path=*}"
    ack_path="${request#* path=}"
    case "$purpose" in
      purpose=verified) capture_target="$screenshot_file" ;;
      purpose=diagnostic) capture_target="$diagnostic_screenshot_file" ;;
      *) capture_target="" ;;
    esac
    if [[ -z "$capture_target" ]] || ! is_valid_ack_path "$ack_path"; then
      echo "AICU_REAL_WEBVIEW_CAPTURE_FAILED invalid app cache acknowledgement path"
    elif [[ -s "$capture_target" ]]; then
      echo "AICU_REAL_WEBVIEW_CAPTURE_FAILED duplicate screenshot request for $purpose"
    elif adb -s emulator-5554 exec-out screencap -p >"$capture_target"; then
      signature=$(od -An -tx1 -N8 "$capture_target" | tr -d ' \n')
      if [[ "$signature" == "89504e470d0a1a0a" ]]; then
        echo "Captured Android WebView $purpose screenshot: $capture_target"
        if adb -s emulator-5554 shell run-as "$app_id" touch "$ack_path"; then
          echo "AICU_REAL_WEBVIEW_CAPTURE_ACKNOWLEDGED purpose=$purpose"
          printf '%s acknowledged\n' "$purpose" >>"$capture_status_file"
        else
          echo "AICU_REAL_WEBVIEW_CAPTURE_FAILED could not acknowledge screenshot to app"
          printf '%s failed: app acknowledgement\n' "$purpose" >>"$capture_status_file"
        fi
      else
        echo "Android screen capture did not produce a PNG signature"
        rm -f "$capture_target"
        echo "AICU_REAL_WEBVIEW_CAPTURE_FAILED invalid PNG signature"
        printf '%s failed: invalid PNG signature\n' "$purpose" >>"$capture_status_file"
      fi
    else
      echo "adb screencap failed while the AICU page was open"
      rm -f "$capture_target"
      echo "AICU_REAL_WEBVIEW_CAPTURE_FAILED adb screencap failed"
      printf '%s failed: adb screencap\n' "$purpose" >>"$capture_status_file"
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
  'AICU_REAL_WEBVIEW_PAGE_TITLE_VERIFIED' \
  'AICU_REAL_WEBVIEW_SCREENSHOT_CAPTURED' \
  'AICU_REAL_WEBVIEW_SCROLL_VERIFIED' \
  'AICU_REAL_WEBVIEW_ROUTE_CLOSED'; do
  if ! grep -Fq "$marker" "$flutter_log"; then
    echo "Missing required real WebView verification marker: $marker"
    status=1
  fi
done

if ! grep -Fxq 'verified acknowledged' "$capture_status_file" 2>/dev/null; then
  echo 'The native emulator screenshot handshake failed.'
  cat "$capture_status_file" 2>/dev/null || true
  status=1
fi

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
