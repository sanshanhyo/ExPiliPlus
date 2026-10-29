import 'package:flutter/foundation.dart' show visibleForTesting;

/// Small lifecycle state shared by the AICU page and its renderer recovery.
///
/// A failed platform view is removed from the tree. Retrying therefore needs a
/// fresh keyed WebView, rather than calling reload on its detached controller.
@visibleForTesting
class AicuWebViewSession {
  int generation = 0;
  bool loadFailed = false;
  bool rendererProcessGone = false;

  void markLoadStarted() {
    loadFailed = false;
  }

  void markLoadFailed() {
    loadFailed = true;
  }

  void markRendererProcessGone() {
    loadFailed = true;
    rendererProcessGone = true;
  }

  void retry() {
    generation++;
    loadFailed = false;
    rendererProcessGone = false;
  }
}
