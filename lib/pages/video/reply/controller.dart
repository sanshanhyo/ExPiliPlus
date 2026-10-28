import 'package:ex_piliplus/grpc/bilibili/main/community/reply/v1.pb.dart'
    show MainListReply, ReplyInfo;
import 'package:ex_piliplus/grpc/reply.dart';
import 'package:ex_piliplus/http/loading_state.dart';
import 'package:ex_piliplus/models/common/video/video_type.dart';
import 'package:ex_piliplus/pages/common/reply_controller.dart';
import 'package:ex_piliplus/pages/video/reply/comment_plus_one_reply_mixin.dart';
import 'package:ex_piliplus/pages/video/controller.dart';
import 'package:ex_piliplus/pages/video/reply/vote/reply_vote_mixin.dart';
import 'package:ex_piliplus/utils/id_utils.dart';
import 'package:ex_piliplus/models_new/dynamic/dyn_mention/item.dart';
import 'package:flutter/foundation.dart' show kDebugMode;

import 'package:get/get.dart';

class VideoReplyController extends ReplyController<MainListReply>
    with ReplyVoteMixin, CommentPlusOneReplyMixin {
  VideoReplyController({
    required this.aid,
    required this.videoType,
    required this.heroTag,
  });
  int aid;
  final VideoType videoType;
  late final isPugv = videoType == VideoType.pugv;

  final String heroTag;
  late final videoCtr = Get.find<VideoDetailController>(tag: heroTag);

  MentionItem? get mentionItem {
    if (videoCtr.isUgc) {
      try {
        return videoCtr.ugcIntroCtr.videoDetail.value.owner?.mentionItem;
      } catch (_) {
        if (kDebugMode) rethrow;
      }
    }
    return null;
  }

  @override
  dynamic get sourceId => IdUtils.av2bv(aid);

  @override
  List<ReplyInfo>? getDataList(MainListReply response) {
    return response.replies;
  }

  @override
  Future<LoadingState<MainListReply>> customGetData() => ReplyGrpc.mainList(
    oid: isPugv ? videoCtr.epId! : aid,
    type: videoType.replyType,
    mode: mode,
    cursorNext: cursorNext,
    offset: paginationReply?.nextOffset,
  );
}
