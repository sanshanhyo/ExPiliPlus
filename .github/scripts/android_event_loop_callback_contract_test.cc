#include <cstdint>

#include "media_kit_native_event_loop.h"

namespace {

constexpr Dart_Port kExpectedPort = 314159;
int g_calls = 0;
Dart_Port g_actual_port = 0;
int64_t g_actual_handle = 0;
Dart_CObject_Type g_actual_type = Dart_CObject_kNull;

bool CapturePostedObject(Dart_Port port, Dart_CObject* object) {
  ++g_calls;
  g_actual_port = port;
  g_actual_type = object->type;
  if (object->type == Dart_CObject_kInt64) {
    g_actual_handle = object->value.as_int64;
  }
  return true;
}

}  // namespace

int main() {
  int player_token = 0;
  MediaKitEventLoopHandlerInitialize(CapturePostedObject, kExpectedPort);
  MediaKitEventLoopHandlerCallback(&player_token);

  if (g_calls != 1 || g_actual_port != kExpectedPort ||
      g_actual_type != Dart_CObject_kInt64 ||
      g_actual_handle != reinterpret_cast<int64_t>(&player_token)) {
    return 1;
  }

  return 0;
}
