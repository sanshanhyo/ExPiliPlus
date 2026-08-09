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

  static const _cyan = Color(0xFF2ECAD3);
  static const _coral = Color(0xFFFF4F55);
  static const _onDark = Color(0xFFF1F4F6);
  static const _mutedOnDark = Color(0xFFAAB3BC);
  static const _onLight = Color(0xFF202630);
  static const _mutedOnLight = Color(0xFF66717C);

  @override
  Widget build(BuildContext context) {
    const base = TextStyle(
      color: _onDark,
      decoration: TextDecoration.none,
    );
    final titleStyle = base.copyWith(
      fontSize: 34,
      height: 1.22,
      fontWeight: FontWeight.w700,
    );
    return SizedBox(
      width: width,
      height: height,
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/share_ticket/share_ticket_v2_terminal.png',
              fit: BoxFit.fill,
            ),
          ),
          Positioned(
            left: 116,
            top: 66,
            width: 854,
            height: 58,
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    'assets/images/logo/logo.png',
                    width: 48,
                    height: 48,
                  ),
                ),
                const SizedBox(width: 14),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'ExPiliPlus',
                      style: base.copyWith(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        letterSpacing: .8,
                      ),
                    ),
                    Text(
                      l10n.shareTicketTitle,
                      style: base.copyWith(
                        color: _mutedOnDark,
                        fontSize: 15,
                        letterSpacing: .5,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 9,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: _cyan.withValues(alpha: .55)),
                    borderRadius: BorderRadius.circular(8),
                    color: const Color(0xB3161B22),
                  ),
                  child: Text(
                    data.bvid,
                    style: base.copyWith(
                      color: _cyan,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1,
                      fontFeatures: const [FontFeature.tabularFigures()],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 116,
            top: 148,
            width: 854,
            height: 480,
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: _cyan.withValues(alpha: .7)),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x73000000),
                    blurRadius: 22,
                    offset: Offset(0, 10),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(19),
                child: Image.network(
                  data.cover.http2https,
                  fit: BoxFit.cover,
                  errorBuilder: (_, _, _) => const SizedBox.shrink(),
                ),
              ),
            ),
          ),
          Positioned(
            right: 136,
            top: 168,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: const Color(0xD9161B22),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.white24),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 7,
                ),
                child: Text(
                  data.durationText,
                  style: base.copyWith(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    fontFeatures: const [FontFeature.tabularFigures()],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 124,
            top: 654,
            width: 838,
            height: 90,
            child: Text(
              data.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: titleStyle,
            ),
          ),
          Positioned(
            left: 124,
            top: 766,
            width: 838,
            height: 66,
            child: Row(
              children: [
                _Avatar(
                  image: _networkImage(data.uploader.face ?? ''),
                  size: 64,
                  borderColor: _cyan,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              data.uploader.name ?? '',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: base.copyWith(
                                fontSize: 23,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          DecoratedBox(
                            decoration: BoxDecoration(
                              color: _cyan,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 3,
                              ),
                              child: Text(
                                'LV${data.uploaderLevel}',
                                style: base.copyWith(
                                  color: _onLight,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${data.publishedAt} ${l10n.shareTicketPublishedAt}',
                        style: base.copyWith(
                          color: _mutedOnDark,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 124,
            top: 854,
            width: 838,
            height: 82,
            child: Row(
              children: [
                Expanded(
                  child: _StatItem(
                    icon: Icons.play_arrow_rounded,
                    value: data.stats.viewText,
                    label: l10n.shareTicketPlays,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: _StatItem(
                    icon: Icons.chat_bubble_outline_rounded,
                    value: data.stats.danmakuText,
                    label: l10n.shareTicketDanmaku,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: _StatItem(
                    icon: Icons.thumb_up_alt_outlined,
                    value: data.stats.likeText,
                    label: l10n.shareTicketLikes,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 124,
            top: 958,
            width: 838,
            height: 116,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: const Color(0x96171D25),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: Colors.white12),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    width: 6,
                    decoration: const BoxDecoration(
                      color: _coral,
                      borderRadius: BorderRadius.horizontal(
                        left: Radius.circular(14),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(22, 14, 20, 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            l10n.shareTicketPostscript,
                            style: base.copyWith(
                              color: _cyan,
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              letterSpacing: .8,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Expanded(
                            child: Text(
                              data.postscript,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: base.copyWith(fontSize: 21, height: 1.28),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 124,
            top: 1174,
            width: 200,
            height: 200,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [
                  BoxShadow(color: Color(0x24000000), blurRadius: 10),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(12),
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
            left: 364,
            top: 1176,
            width: 590,
            height: 50,
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    'assets/images/logo/logo.png',
                    width: 44,
                    height: 44,
                  ),
                ),
                const SizedBox(width: 14),
                Text(
                  l10n.shareTicketFrom,
                  style: base.copyWith(
                    color: _onLight,
                    fontSize: 23,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 364,
            top: 1252,
            width: 590,
            height: 82,
            child: Row(
              children: [
                _Avatar(
                  image: _networkImage(data.sharerFace),
                  size: 78,
                  borderColor: _onLight,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.shareTicketSharer,
                        style: base.copyWith(
                          color: _mutedOnLight,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        data.sharerName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: base.copyWith(
                          color: _onLight,
                          fontSize: 25,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 364,
            top: 1351,
            width: 590,
            child: Row(
              children: [
                Container(width: 34, height: 3, color: _cyan),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    data.videoUrl,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: base.copyWith(
                      color: _mutedOnLight,
                      fontSize: 15,
                      letterSpacing: .2,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  ImageProvider<Object>? _networkImage(String url) {
    return url.isEmpty ? null : NetworkImage(url.http2https);
  }
}

class _Avatar extends StatelessWidget {
  const _Avatar({
    required this.image,
    required this.size,
    required this.borderColor,
  });

  final ImageProvider<Object>? image;
  final double size;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: borderColor, width: 2),
      ),
      child: ClipOval(
        child: image == null
            ? const SizedBox.shrink()
            : Image(
                image: image!,
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) => const SizedBox.shrink(),
              ),
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
    return DecoratedBox(
      decoration: BoxDecoration(
        color: const Color(0x8F171D25),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white12),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Row(
          children: [
            Icon(icon, size: 27, color: ShareTicketCanvas._cyan),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    value,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: ShareTicketCanvas._onDark,
                      fontSize: 23,
                      fontWeight: FontWeight.w700,
                      decoration: TextDecoration.none,
                      fontFeatures: [FontFeature.tabularFigures()],
                    ),
                  ),
                  Text(
                    label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: ShareTicketCanvas._mutedOnDark,
                      fontSize: 14,
                      decoration: TextDecoration.none,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
