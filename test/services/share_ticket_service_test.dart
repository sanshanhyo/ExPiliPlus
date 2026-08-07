import 'package:ex_piliplus/models/model_owner.dart';
import 'package:ex_piliplus/models/user/info.dart';
import 'package:ex_piliplus/models_new/video/video_detail/data.dart';
import 'package:ex_piliplus/models_new/video/video_detail/stat.dart';
import 'package:ex_piliplus/services/share_ticket_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('maps UGC video data into a share ticket', () {
    final video = VideoDetailData(
      bvid: 'BV1TEST123',
      pic: 'https://example.com/cover.jpg',
      title: '测试视频',
      pubdate: DateTime(2024, 5, 20, 18, 30).millisecondsSinceEpoch ~/ 1000,
      duration: 222,
      owner: Owner(
        mid: 100,
        name: '测试 UP 主',
        face: 'https://example.com/face.jpg',
      ),
      stat: VideoStat.fromJson({
        'view': 128000,
        'danmaku': 3264,
        'like': 12000,
      }),
    );

    final ticket = ShareTicketData.fromVideo(
      video: video,
      uploaderLevel: 6,
      sharer: UserInfoData(
        isLogin: true,
        uname: '分享者',
        face: 'https://example.com/sharer.jpg',
      ),
    );

    expect(ticket.videoUrl, 'https://www.bilibili.com/video/BV1TEST123');
    expect(ticket.qrContent, ticket.videoUrl);
    expect(ticket.uploader.name, '测试 UP 主');
    expect(ticket.uploaderLevel, 6);
    expect(ticket.stats.viewText, '128K');
    expect(ticket.stats.danmakuText, '3.3K');
    expect(ticket.stats.likeText, '12K');
    expect(ticket.sharerName, '分享者');
    expect(ticket.sharerFace, 'https://example.com/sharer.jpg');
    expect(ticket.publishedAt, isNotEmpty);
    expect(ticket.durationText, '03:42');
  });

  test('truncates a postscript to the supported length', () {
    final ticket = ShareTicketData(
      bvid: 'BV1TEST123',
      cover: 'https://example.com/cover.jpg',
      title: '测试视频',
      pubdate: null,
      duration: null,
      uploader: Owner(mid: 100, name: '测试 UP 主'),
      uploaderLevel: 1,
      stats: const ShareTicketStats(view: 0, danmaku: 0, like: 0),
      sharer: null,
      postscript: '字' * 101,
    );

    expect(ticket.postscript.runes.length, ShareTicketData.maxPostscriptLength);
  });

  test('allows an anonymous sharer to leave the identity blank', () {
    final video = VideoDetailData(
      bvid: 'BV1TEST123',
      pic: 'https://example.com/cover.jpg',
      title: '测试视频',
      owner: Owner(mid: 100, name: '测试 UP 主'),
    );

    final ticket = ShareTicketData.fromVideo(
      video: video,
      uploaderLevel: 1,
    );

    expect(ticket.sharerName, isEmpty);
    expect(ticket.sharerFace, isEmpty);
  });

  test('rejects incomplete video data', () {
    expect(
      () => ShareTicketData.fromVideo(
        video: VideoDetailData(
          bvid: 'BV1TEST123',
          title: '缺少封面',
          owner: Owner(mid: 100, name: '测试 UP 主'),
        ),
        uploaderLevel: 1,
      ),
      throwsFormatException,
    );
  });
}
