// This file is a part of media_kit (https://github.com/media-kit/media-kit).
//
// Copyright © 2021 & onwards, Hitesh Kumar Saini <saini123hitesh@gmail.com>. All rights reserved.
// Use of this source code is governed by MIT license that can be found in the LICENSE file.

#ifndef MEDIA_KIT_NATIVE_EVENT_LOOP_H_
#define MEDIA_KIT_NATIVE_EVENT_LOOP_H_

#include "dart_api_types.h"

#ifdef _WIN32
#define DLLEXPORT __declspec(dllexport)
#else
#define DLLEXPORT __attribute__((visibility("default")))
#endif

#ifdef __cplusplus
extern "C" {
#endif

DLLEXPORT void MediaKitEventLoopHandlerInitialize(Dart_PostCObject post_c_object, Dart_Port send_port);

DLLEXPORT void MediaKitEventLoopHandlerCallback(void* context);

#ifdef __cplusplus
}
#endif

#endif  // MEDIA_KIT_NATIVE_EVENT_LOOP_H_
