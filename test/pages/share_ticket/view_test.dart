import 'package:ex_piliplus/l10n/generated/app_localizations.dart';
import 'package:ex_piliplus/models/model_owner.dart';
import 'package:ex_piliplus/models_new/video/video_detail/data.dart';
import 'package:ex_piliplus/services/share_ticket_service.dart';
import 'package:ex_piliplus/pages/share_ticket/view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

void main() {
  testWidgets('renders the share ticket template and QR code', (tester) async {
    final l10n = await AppLocalizations.delegate.load(const Locale('zh'));
    final ticket = ShareTicketData.fromVideo(
      video: VideoDetailData(
        bvid: 'BV1TEST123',
        pic: 'https://example.com/cover.jpg',
        title: '测试视频',
        duration: 42,
        owner: Owner(
          mid: 100,
          name: '测试 UP 主',
          face: '',
        ),
      ),
      uploaderLevel: 6,
    );

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
    expect(find.text('分享者'), findsOneWidget);
    expect(find.text('00:42'), findsOneWidget);
    expect(find.byType(PrettyQrView), findsOneWidget);
  });
}
