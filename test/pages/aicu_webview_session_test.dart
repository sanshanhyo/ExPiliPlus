import 'package:ex_piliplus/pages/aicu_lookup/aicu_webview_session.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('renderer termination marks the page failed and retries with a new view', () {
    final session = AicuWebViewSession();

    session.markRendererProcessGone();
    expect(session.loadFailed, isTrue);
    expect(session.rendererProcessGone, isTrue);
    expect(session.generation, 0);

    session.retry();
    expect(session.generation, 1);
    expect(session.loadFailed, isFalse);
    expect(session.rendererProcessGone, isFalse);
  });

  test('ordinary load errors also get a fresh WebView on retry', () {
    final session = AicuWebViewSession();

    session.markLoadFailed();
    expect(session.loadFailed, isTrue);
    expect(session.rendererProcessGone, isFalse);

    session.retry();
    expect(session.generation, 1);
    expect(session.loadFailed, isFalse);
    expect(session.rendererProcessGone, isFalse);
  });
}
