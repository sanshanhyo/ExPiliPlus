// This file is a part of media_kit (https://github.com/media-kit/media-kit).
//
// Copyright © 2021 & onwards, Hitesh Kumar Saini <saini123hitesh@gmail.com>. All rights reserved.
// Use of this source code is governed by MIT license that can be found in the LICENSE file.

#include <cassert>
#include <cstdio>

#if defined(_WIN32)
#include <client.h>
#elif defined(ANDROID) || defined(__ANDROID__)
#include "include/client.h"
#elif defined(__linux__)
#include <mpv/client.h>
#elif defined(__APPLE__)
#include <mpv/client.h>
#endif

#include "media_kit_native_event_loop.h"

static Dart_PostCObject g_post_c_object = nullptr;
static Dart_Port g_send_port = 0;

void MediaKitEventLoopHandlerInitialize(Dart_PostCObject post_c_object, Dart_Port send_port) {
    g_post_c_object = post_c_object;
    g_send_port = send_port;
}

void MediaKitEventLoopHandlerCallback(void* context) {
    assert(g_send_port != 0 && g_post_c_object != nullptr);

    mpv_handle* ctx = static_cast<mpv_handle*>(context);

    Dart_CObject object;
    object.type = Dart_CObject_kInt64;
    object.value.as_int64 = reinterpret_cast<int64_t>(ctx);

    if (!g_post_c_object(g_send_port, &object)) {
      std::fprintf(stderr, "MediaKitEventLoop: Failed to post wakeup message\n");
    }
}
