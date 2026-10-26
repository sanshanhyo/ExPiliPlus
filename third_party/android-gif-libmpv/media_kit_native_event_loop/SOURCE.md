# Android event loop ABI source

This is the `media_kit_native_event_loop` source from
[`My-Responsitories/media-kit`](https://github.com/My-Responsitories/media-kit)
at the lockfile revision `73771ec38176be2d984a3049c28177bce23b54a0`.
The `.cc`, `.h`, `dart_api_types.h`, and `LICENSE` files are copied from that
commit without edits. Their Git blob IDs are recorded below so the checked-in
source can be verified against the upstream tree.

| File | Upstream blob |
| --- | --- |
| `src/media_kit_native_event_loop.cc` | `545b1218929f5483bd085a2d0837287e503fcc32` |
| `src/media_kit_native_event_loop.h` | `163436ba26bb58273845e2e248c52717e87d2f16` |
| `src/dart_api_types.h` | `96220c4768b6462cd6629eaefe3d14ba64480957` |
| `LICENSE` | `c4c95d9821b2ed414bc44b034c4477c2786d07b8` |

The Android build applies `android-opaque-mpv-handle.patch`. In this source,
`mpv_handle` is only used as an opaque pointer whose address is posted to
Dart; the callback does not call libmpv. The patch replaces a dependency on
the full libmpv client header with the equivalent opaque type declaration.
It does not replace or stub either exported function.

The expected FFI contract comes from
`media_kit/lib/src/player/native/core/initializer_native_event_loop.dart` at
the same revision: initialization stores `NativeApi.postCObject` and the
receive port, and the native wakeup callback posts the handle address as a
`Dart_CObject_kInt64`. Dart installs the callback with
`mpv_set_wakeup_callback` and clears it when disposing the handle.

The package is MIT licensed. The license text is preserved in `LICENSE` and
included in the staged Android artifact license inventory.
