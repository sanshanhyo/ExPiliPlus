import 'package:ex_piliplus/grpc/bilibili/main/community/reply/v1.pb.dart'
    show ReplyInfo;
import 'package:ex_piliplus/http/loading_state.dart';
import 'package:ex_piliplus/http/video.dart';
import 'package:ex_piliplus/models/common/comment_plus_one_request.dart';

typedef CommentPlusOneSender =
    Future<LoadingState<ReplyInfo?>> Function(CommentPlusOneRequest request);

/// Sends a request once and prevents concurrent taps from duplicating it.
class CommentPlusOneService {
  CommentPlusOneService({required CommentPlusOneSender send}) : _send = send;

  static final instance = CommentPlusOneService(send: _sendWithVideoHttp);

  final CommentPlusOneSender _send;
  final Set<(int, int, int)> _inFlight = {};

  Future<LoadingState<ReplyInfo?>?> send(CommentPlusOneRequest request) async {
    final key = (request.type, request.oid, request.sourceReplyId);
    if (!_inFlight.add(key)) return null;
    try {
      return await _send(request);
    } finally {
      _inFlight.remove(key);
    }
  }

  static Future<LoadingState<ReplyInfo?>> _sendWithVideoHttp(
    CommentPlusOneRequest request,
  ) => VideoHttp.replyAdd(
    type: request.type,
    oid: request.oid,
    root: request.root,
    parent: request.parent,
    message: request.message,
    atNameToMid: request.atNameToMid,
  );
}
