import 'dart:math' as math;

import 'package:ex_piliplus/features/sync_play/sync_play_player_binding.dart';
import 'package:ex_piliplus/features/sync_play/sync_play_protocol.dart';
import 'package:ex_piliplus/features/sync_play/sync_play_service.dart';
import 'package:ex_piliplus/http/loading_state.dart';
import 'package:ex_piliplus/http/video.dart';
import 'package:ex_piliplus/l10n/generated/app_localizations.dart';
import 'package:ex_piliplus/models/common/video/video_type.dart';
import 'package:ex_piliplus/utils/extension/l10n_ext.dart';
import 'package:ex_piliplus/utils/page_utils.dart';
import 'package:ex_piliplus/utils/storage.dart';
import 'package:collection/collection.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:material_ui/material_ui.dart';

class SyncPlayLaunchContext {
  const SyncPlayLaunchContext({
    required this.video,
    required this.title,
    required this.player,
    required this.currentVideoId,
    this.currentPart,
  });

  final SyncPlayVideoRef video;
  final String title;
  final PlPlayerSyncPort player;
  final String Function() currentVideoId;
  final int? Function()? currentPart;
}

abstract final class SyncPlayPreferenceKeys {
  static const serverAddress = 'syncPlayServerUrl';
  static const displayName = 'syncPlayDisplayName';
}

class SyncPlayPage extends StatefulWidget {
  const SyncPlayPage({
    super.key,
    this.launchContext,
    this.embedded = false,
    this.onClose,
  });

  final SyncPlayLaunchContext? launchContext;
  final bool embedded;
  final VoidCallback? onClose;

  @override
  State<SyncPlayPage> createState() => _SyncPlayPageState();
}

/// Renders the SyncPlay quick action using the player's existing circular
/// shortcut style. The widget is shared with the actual player menu so its
/// label, icon, and touch target can be covered by rendered UI tests.
class SyncPlayPlayerMenuAction extends StatelessWidget {
  const SyncPlayPlayerMenuAction({
    required this.title,
    required this.icon,
    required this.iconSize,
    required this.labelFontSize,
    required this.onPressed,
    this.available = true,
    this.active = false,
    super.key,
  });

  final String title;
  final IconData icon;
  final double iconSize;
  final double labelFontSize;
  final VoidCallback? onPressed;
  final bool available;
  final bool active;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          key: const ValueKey('syncplay-player-menu-button'),
          tooltip: title,
          iconSize: iconSize,
          constraints: BoxConstraints.tightFor(
            width: iconSize + 16,
            height: iconSize + 16,
          ),
          padding: const EdgeInsets.all(8),
          onPressed: available ? onPressed : null,
          icon: Icon(icon),
          style: IconButton.styleFrom(
            shape: const CircleBorder(),
            backgroundColor: active
                ? theme.colorScheme.secondaryContainer
                : theme.colorScheme.surfaceContainerHighest,
            foregroundColor: active
                ? theme.colorScheme.onSecondaryContainer
                : available
                ? theme.colorScheme.onSurfaceVariant
                : theme.colorScheme.outline,
          ),
        ),
        const SizedBox(height: 8),
        Flexible(
          child: Text(
            title,
            key: const ValueKey('syncplay-player-menu-label'),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.labelMedium?.copyWith(
              fontSize: labelFontSize,
              height: 1.15,
              color: available ? null : theme.colorScheme.outline,
            ),
          ),
        ),
      ],
    );
  }
}

/// Opens the player overlay only after the More settings sheet has closed.
/// Keeping this flow in one place lets the player and its menu regression test
/// exercise the same route transition and duplicate-open guard.
class SyncPlayPanelLauncher {
  bool _isOpening = false;

  bool get isOpening => _isOpening;

  Future<void> openFromPlayerMenu({
    required BuildContext playerContext,
    required VoidCallback closeMenu,
    SyncPlayLaunchContext? launchContext,
    ThemeData? panelTheme,
  }) async {
    if (_isOpening) return;
    _isOpening = true;
    try {
      closeMenu();
      await Future<void>.delayed(Duration.zero);
      if (!playerContext.mounted) return;
      await showSyncPlayPanel(
        playerContext,
        launchContext: launchContext,
        panelTheme: panelTheme,
      );
    } finally {
      _isOpening = false;
    }
  }
}

class _SyncPlayPageState extends State<SyncPlayPage> {
  late final SyncPlayService service;
  late final SyncPlayLaunchContext? launchContext;
  late final TextEditingController serverAddressController;
  late final TextEditingController nameController;
  final inviteController = TextEditingController();
  bool isOpeningVideo = false;

  @override
  void initState() {
    super.initState();
    final routeArguments = Get.arguments;
    launchContext = widget.launchContext ??
        (routeArguments is SyncPlayLaunchContext ? routeArguments : null);
    if (!Get.isRegistered<SyncPlayService>()) {
      Get.put(SyncPlayService(), permanent: true);
    }
    service = Get.find<SyncPlayService>();
    final savedAddress = GStorage.setting.get(
      SyncPlayPreferenceKeys.serverAddress,
      defaultValue: '',
    );
    serverAddressController = TextEditingController(
      // Earlier builds used this only as a placeholder. Do not treat it as a
      // real user-selected server after moving to the single-address form.
      text: savedAddress is String && savedAddress != 'ws://localhost:8787'
          ? savedAddress
          : '',
    );
    nameController = TextEditingController(
      text: GStorage.setting.get(
        SyncPlayPreferenceKeys.displayName,
        defaultValue: 'ExPiliPlus',
      ),
    );
  }

  @override
  void dispose() {
    serverAddressController.dispose();
    nameController.dispose();
    inviteController.dispose();
    super.dispose();
  }

  SyncPlayConnectionSettings _settings() => SyncPlayConnectionSettings(
    serverAddress: serverAddressController.text,
    displayName: nameController.text,
  );

  Future<void> _saveSettings() async {
    await Future.wait([
      GStorage.setting.put(
        SyncPlayPreferenceKeys.serverAddress,
        serverAddressController.text.trim(),
      ),
      GStorage.setting.put(
        SyncPlayPreferenceKeys.displayName,
        nameController.text.trim(),
      ),
    ]);
  }

  Future<void> _createRoom() async {
    await _saveSettings();
    await service.createRoom(_settings());
  }

  Future<void> _joinRoom() async {
    await _saveSettings();
    await service.joinRoom(_settings(), inviteController.text);
  }

  Future<void> _shareCurrentVideo() async {
    final launch = launchContext;
    if (launch == null) return;
    final shared = await service.shareCurrentVideo(
      video: launch.video,
      title: launch.title,
      player: launch.player,
      currentVideoId: launch.currentVideoId,
    );
    if (!mounted) return;
    if (shared && !widget.embedded) Get.back<void>();
  }

  Future<void> _copyInvite() async {
    final value = service.invite;
    if (value == null) return;
    await Clipboard.setData(ClipboardData(text: value));
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(context.l10n.syncPlayInviteCopied)),
    );
  }

  Future<void> _openSharedVideo() async {
    final shared = service.room?.sharedVideo;
    final ref = shared?.videoRef;
    if (shared == null || ref == null || isOpeningVideo) return;
    setState(() => isOpeningVideo = true);
    try {
      var cid = ref.cid;
      if (cid == null) {
        final details = await VideoHttp.videoIntro(bvid: ref.bvid);
        if (details case Success(:final response)) {
          final pages = response.pages;
          if (pages == null || pages.isEmpty) {
            throw const FormatException('No video pages found');
          }
          final page = ref.part == null
              ? pages.first
              : pages.firstWhereOrNull((item) => item.page == ref.part) ??
                    (ref.part! <= pages.length ? pages[ref.part! - 1] : null);
          cid = page?.cid;
        }
      }
      if (cid == null || cid <= 0) {
        throw const FormatException('The shared video part could not be resolved');
      }
      await PageUtils.toVideoPage(
        videoType: VideoType.ugc,
        bvid: ref.bvid,
        cid: cid,
        title: shared.title,
        progress: service.estimatedRemotePositionMs(),
      );
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(context.l10n.syncPlayVideoOpenFailed)),
        );
      }
    } finally {
      if (mounted) setState(() => isOpeningVideo = false);
    }
  }

  String _statusLabel(AppLocalizations l10n) => switch (service.status) {
    SyncPlayConnectionStatus.disconnected => l10n.syncPlayDisconnected,
    SyncPlayConnectionStatus.connecting => l10n.syncPlayConnecting,
    SyncPlayConnectionStatus.connected => l10n.syncPlayConnected,
    SyncPlayConnectionStatus.reconnecting => l10n.syncPlayReconnecting,
  };

  String? _errorLabel(AppLocalizations l10n, String? code) => switch (code) {
    'invalid_server' => l10n.syncPlayInvalidServer,
    'invalid_origin' => l10n.syncPlayInvalidOrigin,
    'invalid_display_name' => l10n.syncPlayInvalidName,
    'invalid_invite' => l10n.syncPlayInvalidInvite,
    'connection_failed' || 'connection_lost' => l10n.syncPlayConnectionFailed,
    'origin_not_allowed' => l10n.syncPlayOriginRejected,
    'room_not_found' => l10n.syncPlayRoomNotFound,
    'join_token_invalid' || 'member_token_invalid' =>
      l10n.syncPlayInviteRejected,
    'rate_limited' => l10n.syncPlayRateLimited,
    'room_full' => l10n.syncPlayRoomFull,
    'unsupported_protocol_version' => l10n.syncPlayProtocolUnsupported,
    'invalid_server_message' => l10n.syncPlayInvalidServerMessage,
    null => null,
    _ => l10n.syncPlayServerError,
  };

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final content = AnimatedBuilder(
      animation: service,
      builder: (context, _) => ListView(
        key: const ValueKey('syncplay-content'),
        padding: EdgeInsets.all(widget.embedded ? 12 : 16),
        children: [
          _field(
            key: const ValueKey('syncplay-server-address'),
            controller: serverAddressController,
            label: l10n.syncPlayServerUrl,
            hint: 'server.example:443/sync',
          ),
          const SizedBox(height: 12),
          if (service.credentials == null) ...[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: _field(
                    key: const ValueKey('syncplay-display-name'),
                    controller: nameController,
                    label: l10n.syncPlayNickname,
                    maxLength: 32,
                  ),
                ),
                const SizedBox(width: 8),
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: FilledButton.icon(
                    onPressed:
                        service.status == SyncPlayConnectionStatus.connecting
                        ? null
                        : _createRoom,
                    icon: const Icon(Icons.add_link),
                    label: Text(l10n.syncPlayCreateRoom),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: _field(
                    key: const ValueKey('syncplay-invite-code'),
                    controller: inviteController,
                    label: l10n.syncPlayInviteCode,
                    hint: 'ROOMCODE:JOIN_TOKEN',
                  ),
                ),
                const SizedBox(width: 8),
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: OutlinedButton.icon(
                    onPressed:
                        service.status == SyncPlayConnectionStatus.connecting
                        ? null
                        : _joinRoom,
                    icon: const Icon(Icons.login),
                    label: Text(l10n.syncPlayJoinRoom),
                  ),
                ),
              ],
            ),
          ] else ...[
            const Divider(height: 24),
            _roomSection(context, l10n),
          ],
          const SizedBox(height: 12),
          Row(
            children: [
              Icon(
                service.isConnected ? Icons.cloud_done : Icons.cloud_off,
                color: service.isConnected
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.outline,
              ),
              const SizedBox(width: 8),
              Expanded(child: Text(_statusLabel(l10n))),
            ],
          ),
          if (_errorLabel(l10n, service.lastErrorCode) case final error?) ...[
            const SizedBox(height: 8),
            Text(
              error,
              key: const ValueKey('syncplay-connection-error'),
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
          ],
        ],
      ),
    );

    if (!widget.embedded) {
      return Scaffold(
        appBar: AppBar(title: Text(l10n.syncPlayTitle)),
        body: content,
      );
    }
    return Material(
      color: Theme.of(context).colorScheme.surface,
      child: Column(
        children: [
          SizedBox(
            height: 56,
            child: Row(
              children: [
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    l10n.syncPlayTitle,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                IconButton(
                  tooltip: l10n.commonClose,
                  onPressed: widget.onClose,
                  icon: const Icon(Icons.close),
                ),
                const SizedBox(width: 4),
              ],
            ),
          ),
          Expanded(child: content),
        ],
      ),
    );
  }

  Widget _field({
    Key? key,
    required TextEditingController controller,
    required String label,
    String? hint,
    int? maxLength,
  }) => TextField(
    key: key,
    controller: controller,
    maxLength: maxLength,
    decoration: InputDecoration(labelText: label, hintText: hint),
  );

  Widget _roomSection(BuildContext context, AppLocalizations l10n) {
    final credentials = service.credentials!;
    final room = service.room;
    final launch = launchContext;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(l10n.syncPlayRoomCode(credentials.roomCode)),
        const SizedBox(height: 8),
        SelectableText(service.invite ?? ''),
        const SizedBox(height: 8),
        OutlinedButton.icon(
          onPressed: _copyInvite,
          icon: const Icon(Icons.copy_outlined),
          label: Text(l10n.syncPlayCopyInvite),
        ),
        const SizedBox(height: 16),
        Text(l10n.syncPlayMembers),
        const SizedBox(height: 4),
        ...?room?.members.map(
          (member) => ListTile(
            dense: true,
            leading: const Icon(Icons.person_outline),
            title: Text(member.name),
          ),
        ),
        if (launch != null &&
            !(room?.sharedVideo?.videoRef?.matchesLocalPage(
                  launch.video,
                  localPage: launch.currentPart?.call(),
                ) ??
                false))
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: FilledButton.icon(
              onPressed: _shareCurrentVideo,
              icon: const Icon(Icons.ios_share),
              label: Text(l10n.syncPlayShareCurrentVideo),
            ),
          ),
        if (room?.sharedVideo case final shared?) ...[
          const SizedBox(height: 12),
          Card(
            child: ListTile(
              leading: const Icon(Icons.play_circle_outline),
              title: Text(shared.title),
              subtitle: Text(l10n.syncPlaySharedVideo),
              trailing: IconButton(
                tooltip: l10n.syncPlayOpenSharedVideo,
                onPressed: isOpeningVideo ? null : _openSharedVideo,
                icon: isOpeningVideo
                    ? const SizedBox.square(
                        dimension: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.open_in_new),
              ),
            ),
          ),
        ],
        const SizedBox(height: 12),
        OutlinedButton.icon(
          onPressed: service.leaveRoom,
          icon: const Icon(Icons.exit_to_app),
          label: Text(l10n.syncPlayLeaveRoom),
        ),
      ],
    );
  }
}

/// Opens SyncPlay over the player instead of pushing another page. The
/// persistent service remains registered when this route is dismissed.
Future<void> showSyncPlayPanel(
  BuildContext context, {
  SyncPlayLaunchContext? launchContext,
  ThemeData? panelTheme,
}) async {
  final l10n = context.l10n;
  await showDialog<void>(
    context: context,
    barrierDismissible: true,
    barrierLabel: l10n.syncPlayTitle,
    useSafeArea: false,
    builder: (dialogContext) {
      final media = MediaQuery.of(dialogContext);
      return AnimatedPadding(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOut,
        padding: EdgeInsets.only(bottom: media.viewInsets.bottom),
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              // Reserve a minimum usable width for the form and room controls.
              // Compact landscape windows use the full-width sheet layout too.
              final landscape = media.size.width > media.size.height &&
                  constraints.maxWidth * 0.46 >= 400;
              final panelWidth = landscape
                  ? math.min(constraints.maxWidth * 0.46, 440.0)
                  : constraints.maxWidth;
              final panelHeight = landscape
                  ? constraints.maxHeight
                  : constraints.maxHeight * 0.9;
              final theme = panelTheme ?? Theme.of(dialogContext);
              return Align(
                alignment: landscape
                    ? Alignment.centerRight
                    : Alignment.bottomCenter,
                child: Theme(
                  data: theme,
                  child: Material(
                    key: const ValueKey('syncplay-player-panel'),
                    color: theme.colorScheme.surface,
                    clipBehavior: Clip.antiAlias,
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(20),
                      topRight: landscape
                          ? Radius.zero
                          : const Radius.circular(20),
                      bottomLeft: landscape
                          ? const Radius.circular(20)
                          : Radius.zero,
                    ),
                    child: SizedBox(
                      width: panelWidth,
                      height: panelHeight,
                      child: SyncPlayPage(
                        embedded: true,
                        launchContext: launchContext,
                        onClose: () => Navigator.of(dialogContext).pop(),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      );
    },
  );
}
