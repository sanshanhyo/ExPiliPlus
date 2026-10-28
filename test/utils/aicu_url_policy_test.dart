import 'package:ex_piliplus/utils/aicu_url_policy.dart';
import 'package:ex_piliplus/pages/video/reply/widgets/aicu_lookup_menu_tile.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('builds a URL only for an explicit positive author UID', () {
    const syntheticUid = 987654321012345;
    expect(
      AicuUrlPolicy.replyForUid(syntheticUid).toString(),
      'https://www.aicu.cc/reply?uid=$syntheticUid',
    );
    expect(AicuUrlPolicy.replyForUid(0), isNull);
    expect(AicuUrlPolicy.replyForUid(-1), isNull);
  });

  test('allows only secure official hosts as top-level pages', () {
    expect(
      AicuUrlPolicy.isAllowedTopLevel(
        Uri.parse('https://www.aicu.cc/redirect?url=https%3A%2F%2Fwww.aicu.cc%2Freply'),
      ),
      isTrue,
    );
    expect(
      AicuUrlPolicy.isAllowedTopLevel(Uri.parse('https://api.aicu.cc/about/debug')),
      isTrue,
    );
    for (final url in [
      'http://www.aicu.cc/reply?uid=987654321012345',
      'https://aicu.cc.evil.example/reply',
      'https://evil.example/?next=https://www.aicu.cc',
      'https://user@www.aicu.cc/reply',
      'https://www.aicu.cc:444/reply',
    ]) {
      expect(AicuUrlPolicy.isAllowedTopLevel(Uri.parse(url)), isFalse, reason: url);
    }
  });

  test('blocks insecure resources while permitting secure third-party assets', () {
    expect(
      AicuUrlPolicy.isAllowedResource(Uri.parse('https://analytics.example/pixel')),
      isTrue,
    );
    expect(
      AicuUrlPolicy.isAllowedResource(Uri.parse('http://analytics.example/pixel')),
      isFalse,
    );
  });

  test('fails closed when frame context is unknown', () {
    final thirdParty = Uri.parse('https://analytics.example/pixel');
    final official = Uri.parse('https://www.aicu.cc/redirect?url=%2Freply');
    expect(
      AicuUrlPolicy.allowsNavigation(thirdParty, isMainFrame: false),
      isTrue,
    );
    expect(
      AicuUrlPolicy.allowsNavigation(thirdParty, isMainFrame: null),
      isFalse,
    );
    expect(
      AicuUrlPolicy.allowsNavigation(thirdParty, isMainFrame: true),
      isFalse,
    );
    expect(
      AicuUrlPolicy.allowsNavigation(official, isMainFrame: null),
      isTrue,
    );
  });

  test('menu action requires an enabled feature and positive author UID', () {
    const syntheticUid = 987654321012345;
    expect(AicuLookupMenuTile.shouldShow(enabled: true, authorUid: syntheticUid), isTrue);
    expect(AicuLookupMenuTile.shouldShow(enabled: false, authorUid: syntheticUid), isFalse);
    expect(AicuLookupMenuTile.shouldShow(enabled: true, authorUid: 0), isFalse);
  });
}
