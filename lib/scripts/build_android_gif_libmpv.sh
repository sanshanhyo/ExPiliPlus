#!/usr/bin/env bash

set -euo pipefail

readonly SOURCE_REPOSITORY="https://github.com/bggRGjQaUbCoE/libmpv-android-video-build.git"
readonly SOURCE_COMMIT="0bb77586769b9e882123197ef8dc940bae5de8b2"
readonly SOURCE_TAG="vnext"

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
OUTPUT_DIR="${1:-$ROOT_DIR/build/android-gif-libmpv}"
RUN_ROOT="${RUNNER_TEMP:-$(mktemp -d /tmp/expiliplus-android-gif-build.XXXXXX)}"
SOURCE_DIR="$RUN_ROOT/libmpv-android-video-build"

mkdir -p "$OUTPUT_DIR"
rm -f "$OUTPUT_DIR"/*.jar "$OUTPUT_DIR"/build-metadata.txt \
  "$OUTPUT_DIR"/build.log "$OUTPUT_DIR"/licenses.txt \
  "$OUTPUT_DIR"/source-license.txt
rm -rf "$OUTPUT_DIR/licenses"

exec > >(tee "$OUTPUT_DIR/build.log") 2>&1

echo "source_repository=$SOURCE_REPOSITORY"
echo "source_tag=$SOURCE_TAG"
echo "source_commit_expected=$SOURCE_COMMIT"
echo "patch=$ROOT_DIR/third_party/android-gif-libmpv/enable-gif.patch"
echo "compatibility_patch=$ROOT_DIR/third_party/android-gif-libmpv/local-build-compat.patch"

git clone --depth 1 --branch "$SOURCE_TAG" "$SOURCE_REPOSITORY" "$SOURCE_DIR"
actual_commit="$(git -C "$SOURCE_DIR" rev-parse HEAD)"
test "$actual_commit" = "$SOURCE_COMMIT"
git -C "$SOURCE_DIR" apply \
  "$ROOT_DIR/third_party/android-gif-libmpv/enable-gif.patch"
git -C "$SOURCE_DIR" apply \
  "$ROOT_DIR/third_party/android-gif-libmpv/local-build-compat.patch"

# Reuse a complete local Android SDK on macOS when available. The pinned
# upstream bootstrap otherwise downloads the 137 MB command-line-tools ZIP
# into every fresh temporary checkout before sdkmanager can validate/install
# the pinned platform, build-tools, NDK and CMake versions.
if [[ "$OSTYPE" == darwin* ]]; then
  local_android_sdk="${ANDROID_HOME:-${ANDROID_SDK_ROOT:-${HOME:-}/Library/Android/sdk}}"
  if [ -x "$local_android_sdk/cmdline-tools/latest/bin/sdkmanager" ]; then
    mkdir -p "$SOURCE_DIR/buildscripts/sdk"
    ln -s "$local_android_sdk" \
      "$SOURCE_DIR/buildscripts/sdk/android-sdk-mac"
    # The pinned path.sh currently uses the Linux directory name even on
    # macOS when constructing the NDK toolchain path.
    ln -s "$local_android_sdk" \
      "$SOURCE_DIR/buildscripts/sdk/android-sdk-linux"
    echo "reusing_local_android_sdk=$local_android_sdk"
  fi
fi

# The pinned bundle script assumes these ignored paths already exist before
# it removes and recreates them on a clean checkout.
mkdir -p "$SOURCE_DIR/deps" "$SOURCE_DIR/prefix" "$SOURCE_DIR/buildscripts/scripts"
touch "$SOURCE_DIR/buildscripts/scripts/ffmpeg.sh"

cd "$SOURCE_DIR/buildscripts"
./bundle_default.sh

for abi in arm64-v8a armeabi-v7a x86_64; do
  test -s "$SOURCE_DIR/output/default-${abi}.jar"
done

gif_config_files=("$SOURCE_DIR"/buildscripts/deps/ffmpeg/_build-*/ffbuild/config.mak)
gif_encoder_config=""
gif_muxer_config=""
for config_file in "${gif_config_files[@]}"; do
  [ -f "$config_file" ] || continue
  if grep -qE 'CONFIG_GIF_ENCODER[[:space:]]*=[[:space:]]*(1|yes)' "$config_file"; then
    gif_encoder_config="${config_file#"$SOURCE_DIR/"}"
  fi
  if grep -qE 'CONFIG_GIF_MUXER[[:space:]]*=[[:space:]]*(1|yes)' "$config_file"; then
    gif_muxer_config="${config_file#"$SOURCE_DIR/"}"
  fi
done
test -n "$gif_encoder_config"
test -n "$gif_muxer_config"

mkdir -p "$OUTPUT_DIR"
for abi in arm64-v8a armeabi-v7a x86_64; do
  artifact="default-${abi}.jar"
  test -s "$SOURCE_DIR/output/$artifact"
  jar_contents="$(unzip -p "$SOURCE_DIR/output/$artifact" "lib/$abi/libmpv.so" | strings)"
  printf '%s\n' "$jar_contents" | grep -q 'ff_gif_encoder'
  printf '%s\n' "$jar_contents" | grep -q 'ff_gif_muxer'
  if printf '%s\n' "$jar_contents" | grep -Eiq 'ff_libx264|--enable-libx264|libx264-lossless'; then
    echo "GIF-only artifact contains x264 symbols: $artifact" >&2
    exit 1
  fi
  cp "$SOURCE_DIR/output/$artifact" "$OUTPUT_DIR/$artifact"
done

mkdir -p "$OUTPUT_DIR/licenses"
{
  source_license="$SOURCE_DIR/LICENSE"
  if [ -f "$source_license" ]; then
    cp "$source_license" "$OUTPUT_DIR/source-license.txt"
    cp "$source_license" "$OUTPUT_DIR/licenses/libmpv-android-video-build-LICENSE"
    echo "LICENSE"
  fi
  while IFS= read -r -d '' license_file; do
    relative_path="${license_file#"$SOURCE_DIR/"}"
    destination="$OUTPUT_DIR/licenses/$relative_path"
    mkdir -p "$(dirname "$destination")"
    cp "$license_file" "$destination"
    echo "$relative_path"
  done < <(
    find "$SOURCE_DIR/deps" -type f \
      \( -iname 'LICENSE*' -o -iname 'COPYING*' \) -print0 | sort -z
  )
} > "$OUTPUT_DIR/licenses.txt"

{
  echo "source_repository=$SOURCE_REPOSITORY"
  echo "source_tag=$SOURCE_TAG"
  echo "source_commit=$actual_commit"
  echo "patch_sha256=$(shasum -a 256 "$ROOT_DIR/third_party/android-gif-libmpv/enable-gif.patch" | awk '{print $1}')"
  echo "compatibility_patch_sha256=$(shasum -a 256 "$ROOT_DIR/third_party/android-gif-libmpv/local-build-compat.patch" | awk '{print $1}')"
  echo "ffmpeg_config_gif_encoder=$gif_encoder_config"
  echo "ffmpeg_config_gif_muxer=$gif_muxer_config"
  echo "build_command=buildscripts/bundle_default.sh"
  echo "gif_only=true"
  echo "gif_encoder=enabled"
  echo "gif_muxer=enabled"
  echo "gpl_encoder_set=disabled"
  echo "x264=disabled"
  echo "license_inventory=licenses.txt"
  echo "source_license=source-license.txt"
  echo "artifacts="
  for abi in arm64-v8a armeabi-v7a x86_64; do
    artifact="default-${abi}.jar"
    printf '%s %s %s bytes\n' \
      "$artifact" \
      "$(shasum -a 256 "$OUTPUT_DIR/$artifact" | awk '{print $1}')" \
      "$(wc -c < "$OUTPUT_DIR/$artifact" | tr -d ' ')"
  done
} > "$OUTPUT_DIR/build-metadata.txt"

echo "Android GIF libmpv artifacts written to $OUTPUT_DIR"
