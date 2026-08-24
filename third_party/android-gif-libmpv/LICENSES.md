# Android GIF-only native build licensing

This directory defines the licensing boundary for the ExPiliPlus Android
GIF-only libmpv build. The final native JARs must be produced by
`lib/scripts/build_android_gif_libmpv.sh` from the pinned source commit and
must not be replaced by the `encoders-gpl` flavor.

The build is based on the upstream default flavor. Its only additional
FFmpeg selections are:

- `--enable-muxer=gif`
- `--enable-encoder=gif`

The build retains `--disable-gpl`, `--disable-nonfree`, and
`--enable-version3`. It does not enable x264, all encoders, or all muxers.
The upstream source license and every dependency license remain applicable to
the resulting native libraries.

The reproducible build output must contain:

- `source-license.txt`, copied from the pinned source tree;
- `licenses.txt`, listing the dependency license files used by the build;
- `licenses/`, containing those license files;
- `build-metadata.txt`, containing the source commit, patch hash, build
  command, and per-ABI artifact hashes;
- the corresponding source revision and `enable-gif.patch`.

The root ExPiliPlus project is distributed under GPLv3. This file is a
compliance guide for the native dependency boundary, not a relicensing of
upstream or dependency code. Before distributing a final APK, verify the
generated inventory and corresponding source against the exact JARs in that
APK.
