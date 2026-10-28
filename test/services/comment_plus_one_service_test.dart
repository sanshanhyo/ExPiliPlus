import 'dart:async';

import 'package:ex_piliplus/grpc/bilibili/main/community/reply/v1.pb.dart';
import 'package:ex_piliplus/http/loading_state.dart';
import 'package:ex_piliplus/models/common/comment_plus_one_request.dart';
import 'package:ex_piliplus/services/comment_plus_one_service.dart';
import 'package:fixnum/fixnum.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('concurrent taps for the same comment send only once', () async {
    final pending = Completer<LoadingState<ReplyInfo?>>();
    var sendCount = 0;
    final service = CommentPlusOneService(
      send: (_) {
        sendCount++;
        return pending.future;
      },
    );
    final request = CommentPlusOneRequest.fromReply(
      ReplyInfo(
        id: Int64(12),
        oid: Int64(34),
        type: Int64(1),
        content: Content(message: 'repeat'),
      ),
    )!;

    final first = service.send(request);
    expect(await service.send(request), isNull);
    expect(sendCount, 1);
    pending.complete(const Success<ReplyInfo?>(null));
    expect(await first, isA<Success<ReplyInfo?>>());

    expect(await service.send(request), isA<Success<ReplyInfo?>>());
    expect(sendCount, 2);
  });
}
