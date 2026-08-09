import 'package:ex_piliplus/l10n/generated/app_localizations.dart';
import 'package:ex_piliplus/models/model_owner.dart';
import 'package:ex_piliplus/models_new/video/video_detail/data.dart';
import 'package:ex_piliplus/models_new/video/video_detail/stat.dart';
import 'package:ex_piliplus/pages/share_ticket/view.dart';
import 'package:ex_piliplus/services/share_ticket_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

void main() {
  testWidgets('renders the v2 ticket layout with long content', (tester) async {
    final l10n = await AppLocalizations.delegate.load(const Locale('zh'));
    final ticket = ShareTicketData.fromVideo(
      video: VideoDetailData(
        bvid: 'BV1TEST123',
        pic: 'https://example.com/cover.jpg',
        title: '这一期，我们认真聊聊一段好视频为什么值得被分享',
        pubdate: DateTime(2026, 8, 9).millisecondsSinceEpoch ~/ 1000,
        duration: 42,
        owner: Owner(
          mid: 100,
          name: '测试 UP 主',
          face: '',
        ),
        stat: VideoStat.fromJson({
          'view': 128000,
          'danmaku': 3264,
          'like': 12000,
        }),
      ),
      uploaderLevel: 6,
    )..postscript = '不是为了追赶热点，只是很想把这段认真、克制又有温度的表达分享给你。';

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ShareTicketCanvas(
            data: ticket,
            l10n: l10n,
            width: 1086,
            height: 1448,
          ),
        ),
      ),
    );
    await tester.pump();

    expect(find.byType(ShareTicketCanvas), findsOneWidget);
    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is Image &&
            widget.image is AssetImage &&
            (widget.image as AssetImage).assetName ==
                'assets/images/share_ticket/share_ticket_v2_terminal.png',
      ),
      findsOneWidget,
    );
    expect(find.text(ticket.title), findsOneWidget);
    expect(find.text(ticket.postscript), findsOneWidget);
    expect(find.text('128K'), findsOneWidget);
    expect(find.text('3.3K'), findsOneWidget);
    expect(find.text('12K'), findsOneWidget);
    expect(find.text('分享者'), findsOneWidget);
    expect(find.text('00:42'), findsOneWidget);
    expect(find.text(ticket.videoUrl), findsOneWidget);
    expect(find.byType(PrettyQrView), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
