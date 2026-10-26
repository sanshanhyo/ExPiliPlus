# Android benchmark

`android-benchmark.yml` runs only when `refactor/shutdown-timer-ui` is pushed.
It compares the fixed baseline `6da1b7711b02dbec0b8825caf6bc08e9791abfbd`
with the pushed commit on one Ubuntu 22.04 runner.

The job builds the Android release variant with split APKs and retains the
arm64 APK for byte-level and ZIP-component comparison. It uses stable build
defines with `pili.release=false`; this is a size-measurement artifact, not a
GitHub Release, store upload, or install package for users.

For runtime timing, the repository carries one 83 KB synthetic 8-second H.264
clip. CI verifies its SHA-256 before embedding those exact bytes into the
temporary integration-test target, so no media tool is installed on the runner.
The job invokes the production `createGifConverter` path in profile mode and
performs one warmup and five measured 3-second, 480-pixel-wide, 10-FPS
conversions. It checks the in-app GIF structure, then Pillow 12.3.0 decodes
every saved GIF frame and verifies dimensions, frame count, total duration, and
loop metadata. Android `TOTAL PSS` is sampled once per second during the test.
The conversion timing isolates the native export path; it does not claim to
measure player-page navigation or overall app frame performance.

The memory and timing figures describe the GitHub Android 35 x86_64 emulator
with SwiftShader and audio disabled. They support same-run comparisons only;
they do not establish physical-device performance. No network video, account,
user media, Mac, or Xcode is used.

The workflow stops if the baseline and candidate differ in Flutter dependency
locks, Android project files, native plugin artifacts, or Android patch script.
If one of those inputs changes, update the measurement design deliberately so
both builds still use matched dependencies and build configuration.

The original committed lock is checked with `flutter pub get` under the pinned
Flutter 3.47.7 toolchain. The benchmark only accepts the reviewed metadata
normalization: `cupertino_ui` and `ffi` become direct dependencies, four
Flutter-driver packages are added, and the now-unreachable `gtk`, `menu_base`,
and `shortid` packages are removed. Existing package versions, sources, checksums,
and Git revisions must remain unchanged. The baseline's normalized lock is
saved with its original lock hash and unified diff, copied byte-for-byte to the
candidate, and verified with `flutter pub get --enforce-lockfile` on both sides.
The run records both final lock hashes and the complete resolved package graph;
the APK and GIF comparisons stop unless the two final lock files are identical.
The normalization is paired within one run: the newly required package pins
are taken from that reviewed normalized lock and therefore used verbatim by
both revisions. If a later run produces a different normalized lock hash or
new package identities, that run represents a different dependency set and
must be reviewed before comparing its measurements with prior runs.
