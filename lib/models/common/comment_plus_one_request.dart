import 'package:ex_piliplus/grpc/bilibili/main/community/reply/v1.pb.dart'
    show ReplyInfo;

/// A safe, plain-text replay of a video comment through the normal reply API.
/// Rich attachments and structured cards are intentionally not reconstructed.
class CommentPlusOneRequest {
  const CommentPlusOneRequest({
    required this.sourceReplyId,
    required this.type,
    required this.oid,
    required this.root,
    required this.parent,
    required this.message,
    required this.atNameToMid,
  });

  final int sourceReplyId;
  final int type;
  final int oid;
  final int root;
  final int parent;
  final String message;
  final Map<String, int> atNameToMid;

  static final _voteToken = RegExp(r'\{vote:\d+?\}');
  static final _emailLocalCharacter = RegExp(r'[A-Za-z0-9._%+-]');
  static const _mentionBoundaryPunctuation = '，。！？,.!?;:()[]{}<>“”‘’—-…';

  static CommentPlusOneRequest? fromReply(ReplyInfo reply) {
    final content = reply.content;
    final message = content.message;
    if (message.trim().isEmpty || content.pictures.isNotEmpty) return null;
    if (content.hasVote() || _voteToken.hasMatch(message)) return null;
    if (content.hasRichText() &&
        (content.richText.hasNote() || content.richText.hasOpus())) {
      return null;
    }
    if (content.urls.values.any(
      (url) => url.clickReport.trimLeft().startsWith('{"cvid'),
    )) {
      return null;
    }

    final atNameToMid = <String, int>{};
    for (final entry in content.atNameToMid.entries) {
      final name = entry.key;
      final mid = entry.value.toInt();
      if (name.isEmpty || name.startsWith('@') || mid <= 0) return null;
      if (!message.contains('@$name')) return null;
      atNameToMid[name] = mid;
    }

    final usedMentions = <String>{};
    for (var index = 0; index < message.length; index++) {
      if (message[index] != '@') continue;
      final previousIndex = index - 1;
      if (previousIndex >= 0 &&
          _emailLocalCharacter.hasMatch(message[previousIndex])) {
        continue;
      }

      final matches = atNameToMid.keys
          .where((name) => message.startsWith(name, index + 1))
          .toList()
        ..sort((a, b) => b.length.compareTo(a.length));
      if (matches.isEmpty) return null;
      final name = matches.first;
      final afterName = index + 1 + name.length;
      if (afterName < message.length &&
          !message[afterName].trim().isEmpty &&
          !_mentionBoundaryPunctuation.contains(message[afterName])) {
        // Without the original rich-text offsets, adjacent text makes it
        // impossible to tell where the username ends. Fail closed.
        return null;
      }
      usedMentions.add(name);
      index = afterName - 1;
    }
    if (usedMentions.length != atNameToMid.length) return null;

    final sourceReplyId = reply.id.toInt();
    final oid = reply.oid.toInt();
    final type = reply.type.toInt();
    final rootId = reply.root.toInt() == 0
        ? sourceReplyId
        : reply.root.toInt();
    if (sourceReplyId <= 0 || oid <= 0 || type <= 0 || rootId <= 0) {
      return null;
    }

    return CommentPlusOneRequest(
      sourceReplyId: sourceReplyId,
      type: type,
      oid: oid,
      root: rootId,
      parent: rootId,
      message: message,
      atNameToMid: Map.unmodifiable(atNameToMid),
    );
  }
}
