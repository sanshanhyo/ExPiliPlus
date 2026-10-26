#!/usr/bin/env bash
set -euo pipefail

if [ "$#" -ne 2 ]; then
  echo "Usage: build_android_event_loop_compat.sh STAGED_ARTIFACT_DIR EVIDENCE_DIR" >&2
  exit 2
fi

artifact_dir="$1"
evidence_dir="$2"
root_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
source_dir="$root_dir/third_party/android-gif-libmpv/media_kit_native_event_loop"
source_patch="$source_dir/android-opaque-mpv-handle.patch"
ndk_version="28.2.13676358"
android_api="21"
run_root="${RUNNER_TEMP:-${TMPDIR:-/tmp}}/expiliplus-event-loop-build"
native_output="$run_root/native-libs"
build_log="$evidence_dir/native-build.log"
ndk_log="$evidence_dir/ndk-install.log"

if [[ "${OSTYPE:-}" != linux* ]]; then
  echo "This compatibility builder is restricted to the authorized Linux Android CI runner." >&2
  exit 1
fi

runner_temp="$(cd "${RUNNER_TEMP:-${TMPDIR:-/tmp}}" && pwd)"
for output_path in "$artifact_dir" "$evidence_dir"; do
  output_parent="$(dirname "$output_path")"
  mkdir -p "$output_parent"
  output_parent="$(cd "$output_parent" && pwd)"
  case "$output_parent/$(basename "$output_path")" in
    "$runner_temp"/*) ;;
    *) echo "Refusing output outside the ephemeral runner temp directory: $output_path" >&2; exit 1 ;;
  esac
done
if [ "$artifact_dir" = "$evidence_dir" ]; then
  echo "Staged artifacts and build evidence must use separate directories." >&2
  exit 1
fi

rm -rf "$evidence_dir"
mkdir -p "$evidence_dir"
rm -rf "$run_root"
mkdir -p "$run_root" "$native_output"
trap 'rm -rf "$run_root"' EXIT

verify_blob() {
  local path="$1"
  local expected="$2"
  local actual
  actual="$(git -C "$root_dir" hash-object "$path")"
  if [ "$actual" != "$expected" ]; then
    echo "Pinned event-loop source changed: $path expected=$expected actual=$actual" >&2
    exit 1
  fi
}

verify_blob "$source_dir/src/media_kit_native_event_loop.cc" "545b1218929f5483bd085a2d0837287e503fcc32"
verify_blob "$source_dir/src/media_kit_native_event_loop.h" "163436ba26bb58273845e2e248c52717e87d2f16"
verify_blob "$source_dir/src/dart_api_types.h" "96220c4768b6462cd6629eaefe3d14ba64480957"
verify_blob "$source_dir/LICENSE" "c4c95d9821b2ed414bc44b034c4477c2786d07b8"

work_source="$run_root/src"
cp -a "$source_dir/src" "$run_root/"
patch --fuzz=0 -d "$run_root" -p1 < "$source_patch"

if ! g++ -DANDROID -std=c++17 -Wall -Wextra -Werror \
  -I "$work_source" \
  "$work_source/media_kit_native_event_loop.cc" \
  "$root_dir/.github/scripts/android_event_loop_callback_contract_test.cc" \
  -o "$run_root/callback-contract-test" > "$build_log" 2>&1; then
  echo "Could not compile the pinned media_kit callback contract test." >&2
  tail -n 120 "$build_log" >&2 || true
  exit 1
fi
if ! "$run_root/callback-contract-test" >> "$build_log" 2>&1; then
  echo "The pinned callback failed to post the expected Dart port and handle." >&2
  tail -n 120 "$build_log" >&2 || true
  exit 1
fi
echo "host_callback_contract=passed" | tee -a "$build_log"

android_sdk="${ANDROID_SDK_ROOT:-${ANDROID_HOME:-/usr/local/lib/android/sdk}}"
ndk_root="$android_sdk/ndk/$ndk_version"
sdkmanager=""
for candidate in \
  "$android_sdk/cmdline-tools/latest/bin/sdkmanager" \
  "$android_sdk/tools/bin/sdkmanager"; do
  if [ -x "$candidate" ]; then
    sdkmanager="$candidate"
    break
  fi
done
if [ -z "$sdkmanager" ] && command -v sdkmanager >/dev/null 2>&1; then
  sdkmanager="$(command -v sdkmanager)"
fi

if [ ! -d "$ndk_root" ]; then
  if [ -z "$sdkmanager" ]; then
    echo "Android NDK $ndk_version is missing and sdkmanager was not found under $android_sdk." >&2
    exit 1
  fi
  if timeout --foreground --signal=TERM --kill-after=30s 5m \
    bash -c 'set +o pipefail; yes | "$1" --sdk_root="$2" --licenses' _ "$sdkmanager" "$android_sdk" \
    > "$ndk_log" 2>&1; then
    :
  else
    status=$?
    echo "Accepting Android SDK licenses failed or timed out (status $status)." >&2
    tail -n 120 "$ndk_log" >&2 || true
    exit "$status"
  fi
  if timeout --foreground --signal=TERM --kill-after=30s 15m \
    "$sdkmanager" --sdk_root="$android_sdk" --install "ndk;$ndk_version" \
    >> "$ndk_log" 2>&1; then
    :
  else
    status=$?
    echo "Installing the pinned Android NDK failed or timed out (status $status)." >&2
    tail -n 120 "$ndk_log" >&2 || true
    exit "$status"
  fi
fi

host_toolchain="$ndk_root/toolchains/llvm/prebuilt/linux-x86_64/bin"
llvm_nm="$host_toolchain/llvm-nm"
llvm_readelf="$host_toolchain/llvm-readelf"
if [ ! -x "$llvm_nm" ] || [ ! -x "$llvm_readelf" ]; then
  echo "Pinned NDK toolchain is incomplete: $host_toolchain" >&2
  exit 1
fi

build_one_abi() {
  local abi="$1"
  local compiler_name="$2"
  local compiler="$host_toolchain/$compiler_name"
  local abi_dir="$native_output/$abi"
  local library="$abi_dir/libmedia_kit_native_event_loop.so"
  local symbol_file="$evidence_dir/$abi.dynamic-symbols.txt"
  local compile_log="$evidence_dir/$abi.compile.log"

  if [ ! -x "$compiler" ]; then
    echo "Pinned NDK compiler for $abi is missing: $compiler" >&2
    exit 1
  fi
  mkdir -p "$abi_dir"
  "$compiler" --version > "$evidence_dir/$abi.compiler-version.txt"
  if ! "$compiler" \
    -DANDROID \
    -std=c++17 \
    -fno-exceptions \
    -fno-rtti \
    -nostdlib++ \
    -O2 \
    -fPIC \
    -fvisibility=hidden \
    -shared \
    -Wl,--no-undefined \
    -Wl,-z,max-page-size=16384 \
    -Wl,-soname,libmedia_kit_native_event_loop.so \
    -I "$work_source" \
    "$work_source/media_kit_native_event_loop.cc" \
    -o "$library" > "$compile_log" 2>&1; then
    echo "Pinned event-loop compilation failed for $abi." >&2
    tail -n 120 "$compile_log" >&2 || true
    exit 1
  fi
  test -s "$library"
  "$llvm_nm" --dynamic --defined-only "$library" \
    | awk '{ print $NF }' | sort -u > "$symbol_file"
  for symbol in MediaKitEventLoopHandlerInitialize MediaKitEventLoopHandlerCallback; do
    if ! grep -Fxq "$symbol" "$symbol_file"; then
      echo "Missing exported $symbol in $library" >&2
      cat "$symbol_file" >&2
      exit 1
    fi
  done
  if grep -Eq '^MediaKitEventLoopHandler(Register|Notify|Dispose)$' "$symbol_file"; then
    echo "Unexpected threaded event-loop ABI in $library" >&2
    cat "$symbol_file" >&2
    exit 1
  fi
  dependency_file="$evidence_dir/$abi.dynamic-dependencies.txt"
  "$llvm_readelf" --dynamic "$library" > "$dependency_file"
  if grep -E 'NEEDED.*(libmpv|libmediakitandroidhelper|libc\+\+_shared)' \
    "$dependency_file" >/dev/null; then
    echo "The callback library unexpectedly depends on libmpv/helper/C++ runtime: $library" >&2
    cat "$dependency_file" >&2
    exit 1
  fi
  printf 'abi=%s bytes=%s sha256=%s\n' \
    "$abi" \
    "$(wc -c < "$library" | tr -d ' ')" \
    "$(sha256sum "$library" | awk '{print $1}')" \
    | tee -a "$build_log"
  echo "exports_verified=$abi" | tee -a "$build_log"
}

build_one_abi arm64-v8a aarch64-linux-android${android_api}-clang++
build_one_abi armeabi-v7a armv7a-linux-androideabi${android_api}-clang++
build_one_abi x86_64 x86_64-linux-android${android_api}-clang++

python3 "$root_dir/.github/scripts/check_media_kit_event_loop_contract.py" "$root_dir" \
  | tee -a "$build_log"
python3 "$root_dir/.github/scripts/stage_android_event_loop_artifacts.py" \
  --base-artifacts "$root_dir/third_party/android-gif-libmpv/artifacts" \
  --native-libs "$native_output" \
  --output-dir "$artifact_dir" \
  --source-dir "$source_dir" \
  --patch-file "$source_patch" \
  --ndk-version "$ndk_version" \
  --host-contract-test passed | tee -a "$build_log"

cp -a "$native_output" "$evidence_dir/native-libs"
cp "$artifact_dir/build-metadata.txt" "$evidence_dir/staged-build-metadata.txt"
sha256sum "$artifact_dir"/*.jar > "$evidence_dir/staged-jar-hashes.txt"

echo "event_loop_source_commit=73771ec38176be2d984a3049c28177bce23b54a0"
echo "event_loop_ndk_version=$ndk_version"
echo "event_loop_build_complete=true"
