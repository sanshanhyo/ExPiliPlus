import 'dart:ui' as ui;

import 'package:ex_piliplus/common/widgets/button/icon_button.dart';
import 'package:ex_piliplus/http/loading_state.dart';
import 'package:ex_piliplus/http/member.dart';
import 'package:ex_piliplus/l10n/generated/app_localizations.dart';
import 'package:ex_piliplus/models_new/video/video_detail/data.dart';
import 'package:ex_piliplus/pages/common/publish/publish_route.dart';
import 'package:ex_piliplus/services/share_ticket_service.dart';
import 'package:ex_piliplus/utils/extension/l10n_ext.dart';
import 'package:ex_piliplus/utils/extension/string_ext.dart';
import 'package:ex_piliplus/utils/image_utils.dart';
import 'package:ex_piliplus/utils/share_utils.dart';
import 'package:ex_piliplus/utils/storage_pref.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:share_plus/share_plus.dart';

class ShareTicketPage extends StatefulWidget {
  const ShareTicketPage({required this.video, super.key});

  final VideoDetailData video;

  static Future<void> push(BuildContext context, VideoDetailData video) {
    return Navigator.of(context).push<void>(
      PublishRoute(
        pageBuilder: (context, animation, secondaryAnimation) =>
            ShareTicketPage(video: video),
        transitionDuration: const Duration(milliseconds: 255),
        transitionBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation.drive(CurveTween(curve: Curves.easeInOut)),
            child: child,
          );
        },
      ),
    );
  }

  @override
  State<ShareTicketPage> createState() => _ShareTicketPageState();
}

class _ShareTicketPageState extends State<ShareTicketPage> {
  static const double _canvasWidth = 1086;
  static const double _canvasHeight = 1448;

  final GlobalKey _boundaryKey = GlobalKey();
  final TextEditingController _postscriptController = TextEditingController();

  ShareTicketData? _data;
  Object? _error;
  bool _loading = true;
  bool _working = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    _postscriptController.dispose();
    super.dispose();
  }

  Future<void> _load() async {
    setState(() {
      _loading = true;
      _error = null;
      _data = null;
    });

    try {
      final video = widget.video;
      final owner = video.owner;
      final bvid = video.bvid;
      final cover = video.pic;
      final title = video.title;
      final ownerMid = owner?.mid;
      if (owner == null ||
          ownerMid == null ||
          bvid == null ||
          cover == null ||
          title == null) {
        throw const FormatException('Incomplete video data');
      }

      final memberResult = await MemberHttp.memberInfo(mid: ownerMid);
      if (memberResult is! Success) {
        throw StateError('Uploader information unavailable');
      }
      final response = (memberResult as Success).response;
      final uploaderLevel = response.level;
      final uploaderFace = response.face;
      if (uploaderLevel == null ||
          uploaderFace == null ||
          uploaderFace.isEmpty) {
        throw StateError('Uploader information incomplete');
      }

      final sharer = Pref.userInfoCache?.isLogin == true
          ? Pref.userInfoCache
          : null;
      await Future.wait([
        _precache(cover),
        _precache(uploaderFace),
        if (sharer?.face case final face? when face.isNotEmpty) _precache(face),
      ]);

      final data = ShareTicketData.fromVideo(
        video: video,
        uploaderLevel: uploaderLevel,
        sharer: sharer,
      )..postscript = _postscriptController.text;
      data.uploader.face = uploaderFace;

      if (!mounted) return;
      setState(() {
        _data = data;
        _loading = false;
      });
    } catch (error) {
      if (!mounted) return;
      setState(() {
        _error = error;
        _loading = false;
      });
    }
  }

  Future<void> _precache(String url) async {
    await precacheImage(NetworkImage(url.http2https), context);
  }

  Future<Uint8List> _capture() async {
    await WidgetsBinding.instance.endOfFrame;
    final renderObject =
        _boundaryKey.currentContext!.findRenderObject()!
            as RenderRepaintBoundary;
    final image = await renderObject.toImage(pixelRatio: 1);
    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    image.dispose();
    if (byteData == null) throw StateError('Unable to encode share ticket');
    return byteData.buffer.asUint8List();
  }

  Future<void> _save() async {
    if (_working) return;
    setState(() => _working = true);
    try {
      final bytes = await _capture();
      await ImageUtils.saveByteImg(
        bytes: bytes,
        fileName: 'share_ticket_${_data!.bvid}',
      );
    } catch (error) {
      SmartDialog.showToast(error.toString());
    } finally {
      if (mounted) setState(() => _working = false);
    }
  }

  Future<void> _share() async {
    if (_working) return;
    setState(() => _working = true);
    try {
      final bytes = await _capture();
      await SharePlus.instance.share(
        ShareParams(
          files: [
            XFile.fromData(
              bytes,
              name: 'share_ticket_${_data!.bvid}.png',
              mimeType: 'image/png',
            ),
          ],
          sharePositionOrigin: await ShareUtils.sharePositionOrigin,
        ),
      );
    } catch (error) {
      SmartDialog.showToast(error.toString());
    } finally {
      if (mounted) setState(() => _working = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.shareTicketTitle),
        leading: iconButton(
          tooltip: context.l10n.commonClose,
          icon: const Icon(Icons.close),
          onPressed: Get.back,
        ),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
          ? _buildError(context)
          : _buildEditor(context, theme),
    );
  }

  Widget _buildError(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              context.l10n.shareTicketLoadFailed,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            FilledButton.tonal(
              onPressed: _load,
              child: Text(context.l10n.shareTicketRetry),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEditor(BuildContext context, ThemeData theme) {
    final data = _data!;
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Center(
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: RepaintBoundary(
                      key: _boundaryKey,
                      child: ShareTicketCanvas(
                        data: data,
                        l10n: context.l10n,
                        width: _canvasWidth,
                        height: _canvasHeight,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
            child: TextField(
              controller: _postscriptController,
              maxLength: 100,
              maxLines: 2,
              inputFormatters: [LengthLimitingTextInputFormatter(100)],
              onChanged: (value) => setState(() => data.postscript = value),
              decoration: InputDecoration(
                labelText: context.l10n.shareTicketPostscript,
                hintText: context.l10n.shareTicketPostscriptHint,
                border: const OutlineInputBorder(),
                isDense: true,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Row(
              children: [
                Expanded(
                  child: FilledButton.tonalIcon(
                    onPressed: _working ? null : _save,
                    icon: const Icon(Icons.download),
                    label: Text(context.l10n.shareTicketSave),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: FilledButton.icon(
                    onPressed: _working ? null : _share,
                    icon: const Icon(Icons.share),
                    label: Text(context.l10n.shareTicketShare),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ShareTicketCanvas extends StatelessWidget {
  const ShareTicketCanvas({
    required this.data,
    required this.l10n,
    required this.width,
    required this.height,
    super.key,
  });

  final ShareTicketData data;
  final AppLocalizations l10n;
  final double width;
  final double height;

  static const _ink = Color(0xFF443429);
  static const _accent = Color(0xFF9B583D);

  @override
  Widget build(BuildContext context) {
    const base = TextStyle(
      color: _ink,
      fontFamily: 'Source Han Serif CN',
    );
    return SizedBox(
      width: width,
      height: height,
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/share_ticket/share2.png',
              fit: BoxFit.fill,
            ),
          ),
          Positioned(
            left: 165,
            top: 116,
            width: 756,
            height: 438,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Image.network(
                data.cover.http2https,
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) => const SizedBox.shrink(),
              ),
            ),
          ),
          Positioned(
            left: 796,
            top: 137,
            width: 108,
            child: Text(
              TimeOfDay.now().format(context),
              textAlign: TextAlign.center,
              style: base.copyWith(fontSize: 27, color: Colors.white),
            ),
          ),
          Positioned(
            left: 178,
            top: 590,
            width: 730,
            height: 112,
            child: Text(
              data.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: base.copyWith(
                fontSize: 31,
                height: 1.28,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Positioned(
            left: 178,
            top: 730,
            child: _Avatar(
              url: data.uploader.face ?? '',
              size: 78,
              borderColor: _ink,
            ),
          ),
          Positioned(
            left: 286,
            top: 744,
            width: 500,
            child: Row(
              children: [
                Flexible(
                  child: Text(
                    data.uploader.name ?? '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: base.copyWith(fontSize: 25),
                  ),
                ),
                const SizedBox(width: 10),
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: _accent,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 7,
                      vertical: 2,
                    ),
                    child: Text(
                      'LV${data.uploaderLevel}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 286,
            top: 790,
            child: Text(
              '${data.publishedAt} ${l10n.shareTicketPublishedAt}',
              style: base.copyWith(
                fontSize: 18,
                color: _ink.withValues(alpha: .72),
              ),
            ),
          ),
          Positioned(
            left: 180,
            top: 855,
            width: 730,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _StatItem(
                  icon: Icons.play_arrow,
                  value: data.stats.viewText,
                  label: l10n.shareTicketPlays,
                ),
                _StatItem(
                  icon: Icons.chat_bubble,
                  value: data.stats.danmakuText,
                  label: l10n.shareTicketDanmaku,
                ),
                _StatItem(
                  icon: Icons.thumb_up,
                  value: data.stats.likeText,
                  label: l10n.shareTicketLikes,
                ),
              ],
            ),
          ),
          Positioned(
            left: 180,
            top: 961,
            width: 735,
            height: 120,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 52,
                  height: 120,
                  alignment: Alignment.center,
                  color: _accent,
                  child: Text(
                    l10n.shareTicketPostscript,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 19,
                      height: 1.2,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(22, 12, 16, 8),
                    child: Text(
                      data.postscript,
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                      style: base.copyWith(fontSize: 23, height: 1.35),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 190,
            top: 1143,
            width: 206,
            height: 206,
            child: ColoredBox(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: PrettyQrView.data(
                  data: data.qrContent,
                  decoration: const PrettyQrDecoration(
                    shape: PrettyQrSquaresSymbol(),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 520,
            top: 1165,
            child: _Avatar(
              url: data.sharerFace,
              size: 124,
              borderColor: _ink,
            ),
          ),
          Positioned(
            left: 675,
            top: 1200,
            width: 275,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.shareTicketSharer,
                  style: base.copyWith(fontSize: 24),
                ),
                Text(
                  data.sharerName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: base.copyWith(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 365,
            top: 1380,
            width: 360,
            child: Text(
              l10n.shareTicketFrom,
              textAlign: TextAlign.center,
              style: base.copyWith(
                fontSize: 19,
                color: _ink.withValues(alpha: .8),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Avatar extends StatelessWidget {
  const _Avatar({
    required this.url,
    required this.size,
    required this.borderColor,
  });

  final String url;
  final double size;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: borderColor, width: 2),
      ),
      child: ClipOval(
        child: url.isEmpty
            ? const SizedBox.shrink()
            : Image.network(url.http2https, fit: BoxFit.cover),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  const _StatItem({
    required this.icon,
    required this.value,
    required this.label,
  });

  final IconData icon;
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 42, color: const Color(0xFF4B423A)),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              value,
              style: const TextStyle(
                color: Color(0xFF443429),
                fontSize: 27,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              label,
              style: const TextStyle(
                color: Color(0xFF443429),
                fontSize: 18,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
