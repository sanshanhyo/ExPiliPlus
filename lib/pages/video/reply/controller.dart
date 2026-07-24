import 'package:ex_piliplus/grpc/bilibili/main/community/reply/v1.pb.dart'
    show MainListReply, ReplyInfo;
import 'package:ex_piliplus/grpc/reply.dart';
import 'package:ex_piliplus/http/loading_state.dart';
import 'package:ex_piliplus/models/common/video/video_type.dart';
import 'package:ex_piliplus/pages/common/reply_controller.dart';
import 'package:ex_piliplus/pages/video/controller.dart';
import 'package:ex_piliplus/pages/video/reply/vote/reply_vote_mixin.dart';
import 'package:ex_piliplus/utils/id_utils.dart';
import 'package:get/get.dart';

class VideoReplyController extends ReplyController<MainListReply>
    with ReplyVoteMixin {
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
