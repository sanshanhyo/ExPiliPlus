import 'package:ex_piliplus/models/model_owner.dart';
import 'package:ex_piliplus/models/user/info.dart';
import 'package:ex_piliplus/models_new/video/video_detail/data.dart';
import 'package:ex_piliplus/utils/date_utils.dart';
import 'package:ex_piliplus/utils/duration_utils.dart';
import 'package:ex_piliplus/utils/num_utils.dart';

class ShareTicketStats {
  const ShareTicketStats({
    required this.view,
    required this.danmaku,
    required this.like,
  });

  final int view;
  final int danmaku;
  final int like;

  String get viewText => NumUtils.numFormat(view);
  String get danmakuText => NumUtils.numFormat(danmaku);
  String get likeText => NumUtils.numFormat(like);
}

class ShareTicketData {
  static const maxPostscriptLength = 100;

  ShareTicketData({
    required this.bvid,
    required this.cover,
    required this.title,
    required this.pubdate,
    required this.duration,
    required this.uploader,
    required this.uploaderLevel,
    required this.stats,
    required this.sharer,
    String postscript = '',
  }) : _postscript = _truncatePostscript(postscript);

  factory ShareTicketData.fromVideo({
    required VideoDetailData video,
    required int uploaderLevel,
    UserInfoData? sharer,
  }) {
    final owner = video.owner;
    final bvid = video.bvid;
    final cover = video.pic;
    final title = video.title;
    if (owner == null || bvid == null || cover == null || title == null) {
      throw const FormatException('Incomplete video data');
    }

    return ShareTicketData(
      bvid: bvid,
      cover: cover,
      title: title,
      pubdate: video.pubdate,
      duration: video.duration,
      uploader: Owner(
        mid: owner.mid,
        name: owner.name,
        face: owner.face,
      ),
      uploaderLevel: uploaderLevel,
      stats: ShareTicketStats(
        view: video.stat?.view ?? 0,
        danmaku: video.stat?.danmaku ?? 0,
        like: video.stat?.like ?? 0,
      ),
      sharer: sharer,
    );
  }

  final String bvid;
  final String cover;
  final String title;
  final int? pubdate;
  final int? duration;
  final Owner uploader;
  final int uploaderLevel;
  final ShareTicketStats stats;
  final UserInfoData? sharer;
  String _postscript;

  String get postscript => _postscript;

  set postscript(String value) => _postscript = _truncatePostscript(value);

  String get videoUrl => 'https://www.bilibili.com/video/$bvid';

  String get qrContent => videoUrl;

  String get publishedAt => DateFormatUtils.format(pubdate);

  String get durationText => DurationUtils.formatDuration(duration);

  String get sharerName => sharer?.uname ?? '';

  String get sharerFace => sharer?.face ?? '';

  static String _truncatePostscript(String value) =>
      String.fromCharCodes(value.runes.take(maxPostscriptLength));
}
