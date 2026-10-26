# Android benchmark

`android-benchmark.yml` runs only when `refactor/shutdown-timer-ui` is pushed.
It compares the fixed baseline `6da1b7711b02dbec0b8825caf6bc08e9791abfbd`
with the pushed commit on one Ubuntu 22.04 runner.

The job builds the Android release variant with split APKs and retains the
arm64 APK for byte-level and ZIP-component comparison. It uses stable build
defines with `pili.release=false`; this is a size-measurement artifact, not a
GitHub Release, store upload, or install package for users.

For runtime timing, the job creates an eight-second H.264 clip locally with
FFmpeg, embeds the same bytes into a temporary integration-test target, and
invokes the production `createGifConverter` path in profile mode. It performs
one warmup and five measured 3-second, 480-pixel-wide, 10-FPS conversions. It
checks the in-app GIF structure and decodes the saved output with FFmpeg and
ffprobe. Android `TOTAL PSS` is sampled once per second during the test.
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
