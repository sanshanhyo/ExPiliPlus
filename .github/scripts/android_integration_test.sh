#!/usr/bin/env bash
set -euo pipefail

evidence_dir="${1:?Usage: android_integration_test.sh <evidence-directory>}"
mkdir -p "$evidence_dir"

capture_emulator_evidence() {
  adb exec-out screencap -p > "$evidence_dir/emulator-screen.png" 2>/dev/null || true
  adb logcat -d -t 2000 -v time > "$evidence_dir/android-logcat.txt" 2>/dev/null || true
}
trap capture_emulator_evidence EXIT

adb shell settings put system volume_music 0
flutter test integration_test/app_smoke_test.dart -d emulator-5554

gif_file="$(adb shell find /sdcard/Pictures/ExPiliPlus -type f -iname '*.gif' -print -quit | tr -d '\r')"
test -n "$gif_file"
echo "verified_gif_export=$gif_file"

gif_copy="$evidence_dir/export.gif"
adb pull "$gif_file" "$gif_copy"
test -s "$gif_copy"
ffmpeg -v error -xerror -i "$gif_copy" -f null -
ffprobe -v error -count_frames -select_streams v:0 \
  -show_entries stream=codec_name,width,height,nb_read_frames \
  -of json "$gif_copy" > "$evidence_dir/gif-probe.json"

python3 - "$evidence_dir/gif-probe.json" <<'PY'
import json
import sys

with open(sys.argv[1], encoding="utf-8") as probe_file:
    streams = json.load(probe_file).get("streams", [])

if len(streams) != 1:
    raise SystemExit(f"Expected one decodable GIF video stream, got {len(streams)}")

stream = streams[0]
codec = stream.get("codec_name")
width = int(stream.get("width", 0))
height = int(stream.get("height", 0))
frames = int(stream.get("nb_read_frames", 0))
if codec != "gif":
    raise SystemExit(f"Expected a GIF video stream, got {codec!r}")
if width <= 0 or height <= 0:
    raise SystemExit(f"GIF dimensions are invalid: {width}x{height}")
if frames < 2:
    raise SystemExit(f"GIF has fewer than two decoded frames: {frames}")
print(
    f"verified_gif_decode=success codec={codec} "
    f"width={width} height={height} decoded_frames={frames}"
)
PY
