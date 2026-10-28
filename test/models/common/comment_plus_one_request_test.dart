import 'package:ex_piliplus/grpc/bilibili/main/community/reply/v1.pb.dart';
import 'package:ex_piliplus/models/common/comment_plus_one_request.dart';
import 'package:fixnum/fixnum.dart';
import 'package:flutter_test/flutter_test.dart';

ReplyInfo _reply({
  required int id,
  int root = 0,
  String message = 'A useful comment',
  List<Picture> pictures = const [],
  Vote? vote,
  List<MapEntry<String, Url>> urls = const [],
  Map<String, int> mentions = const {},
}) => ReplyInfo(
  id: Int64(id),
  oid: Int64(55),
  type: Int64(1),
  root: Int64(root),
  content: Content(
    message: message,
    pictures: pictures,
    vote: vote,
    urls: urls,
    atNameToMid: mentions.entries.map(
      (entry) => MapEntry(entry.key, Int64(entry.value)),
    ),
  ),
);

void main() {
  test('top-level replay becomes a new top-level reply', () {
    final request = CommentPlusOneRequest.fromReply(_reply(id: 123));

    expect(request, isNotNull);
    expect(request!.sourceReplyId, 123);
    expect(request.type, 1);
    expect(request.oid, 55);
    expect(request.root, 123);
    expect(request.parent, 123);
    expect(request.message, 'A useful comment');
  });

  test('second-level replay targets the first-floor comment', () {
    final request = CommentPlusOneRequest.fromReply(
      _reply(id: 456, root: 123, message: 'A second-floor comment'),
    );

    expect(request, isNotNull);
    expect(request!.sourceReplyId, 456);
    expect(request.root, 123);
    expect(request.parent, 123);
  });

  test('preserves only mapped plain-text mentions', () {
    final request = CommentPlusOneRequest.fromReply(
      _reply(
        id: 1,
        message: 'Thanks @Alice!',
        mentions: const {'Alice': 1001},
      ),
    );

    expect(request, isNotNull);
    expect(request!.message, 'Thanks @Alice!');
    expect(request.atNameToMid, {'Alice': 1001});
    expect(
      () => request.atNameToMid['Other'] = 2002,
      throwsUnsupportedError,
    );
  });

  test('rejects unmapped or ambiguous mentions and email-like text is plain', () {
    expect(
      CommentPlusOneRequest.fromReply(_reply(id: 1, message: 'Hi @unknown')),
      isNull,
    );
    expect(
      CommentPlusOneRequest.fromReply(
        _reply(
          id: 1,
          message: 'Hi @Alice你好',
          mentions: const {'Alice': 1001},
        ),
      ),
      isNull,
    );
    expect(
      CommentPlusOneRequest.fromReply(
        _reply(id: 1, message: 'mail me at person@example.com'),
      ),
      isNotNull,
    );
  });

  test('rejects media, votes, rich cards, and invalid identifiers', () {
    expect(
      CommentPlusOneRequest.fromReply(
        _reply(id: 1, pictures: [Picture()]),
      ),
      isNull,
    );
    expect(
      CommentPlusOneRequest.fromReply(_reply(id: 1, vote: Vote())),
      isNull,
    );
    expect(
      CommentPlusOneRequest.fromReply(
        _reply(
          id: 1,
          urls: [MapEntry('note-link', Url(clickReport: '{"cvid":123}'))],
        ),
      ),
      isNull,
    );
    expect(
      CommentPlusOneRequest.fromReply(_reply(id: 1, message: '{vote:12}')),
      isNull,
    );
    expect(
      CommentPlusOneRequest.fromReply(_reply(id: 0)),
      isNull,
    );
    expect(
      CommentPlusOneRequest.fromReply(_reply(id: 1, message: '   ')),
      isNull,
    );
  });
}
