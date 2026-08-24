# Local Android media-kit libraries

This package keeps the Android native library boundary inside ExPiliPlus so
only the audited GIF-only JARs are checked by SHA-256 before Gradle consumes
them.

The artifact directory is supplied by
`MEDIA_KIT_ANDROID_VIDEO_ARTIFACT_DIR` in CI, or by the bundled
`third_party/android-gif-libmpv/artifacts` directory for a release checkout.
It must contain the GIF-only artifacts, `build-metadata.txt`,
`source-license.txt`, and `licenses.txt` produced by the fixed-source CI
build and license audit described in
[`docs/engineering/android-gif-export-debugging.md`](../../docs/engineering/android-gif-export-debugging.md).

There is intentionally no fallback to the old playback baseline JARs. A
build without an approved GIF-only artifact directory fails during Gradle
configuration instead of silently shipping a library without GIF support.

When `MEDIA_KIT_ANDROID_VIDEO_ARTIFACT_DIR` is set, the directory must contain
the three JARs and the metadata emitted by
`lib/scripts/build_android_gif_libmpv.sh`. Gradle verifies each JAR against
the hash recorded in that metadata, requires the pinned native source commit,
and requires the GIF-only, non-GPL-encoder, and no-x264 metadata markers before
packaging it.
