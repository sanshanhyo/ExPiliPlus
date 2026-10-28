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
  static const endpoint = 'syncPlayServerUrl';
  static const origin = 'syncPlayAllowedOrigin';
  static const displayName = 'syncPlayDisplayName';
}

class SyncPlayPage extends StatefulWidget {
  const SyncPlayPage({super.key});

  @override
  State<SyncPlayPage> createState() => _SyncPlayPageState();
}

class _SyncPlayPageState extends State<SyncPlayPage> {
  late final SyncPlayService service;
  late final SyncPlayLaunchContext? launchContext;
  late final TextEditingController endpointController;
  late final TextEditingController originController;
  late final TextEditingController nameController;
  final inviteController = TextEditingController();
  bool isOpeningVideo = false;

  @override
  void initState() {
    super.initState();
    launchContext = Get.arguments is SyncPlayLaunchContext
        ? Get.arguments as SyncPlayLaunchContext
        : null;
    if (!Get.isRegistered<SyncPlayService>()) {
      Get.put(SyncPlayService(), permanent: true);
    }
    service = Get.find<SyncPlayService>();
    endpointController = TextEditingController(
      text: GStorage.setting.get(
        SyncPlayPreferenceKeys.endpoint,
        defaultValue: 'ws://localhost:8787',
      ),
    );
    originController = TextEditingController(
      text: GStorage.setting.get(
        SyncPlayPreferenceKeys.origin,
        defaultValue: '',
      ),
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
    endpointController.dispose();
    originController.dispose();
    nameController.dispose();
    inviteController.dispose();
    super.dispose();
  }

  SyncPlayConnectionSettings _settings() => SyncPlayConnectionSettings(
    endpoint: endpointController.text,
    origin: originController.text,
    displayName: nameController.text,
  );

  Future<void> _saveSettings() async {
    await Future.wait([
      GStorage.setting.put(
        SyncPlayPreferenceKeys.endpoint,
        endpointController.text.trim(),
      ),
      GStorage.setting.put(
        SyncPlayPreferenceKeys.origin,
        originController.text.trim(),
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
    if (shared) Get.back<void>();
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
    return Scaffold(
      appBar: AppBar(title: Text(l10n.syncPlayTitle)),
      body: AnimatedBuilder(
        animation: service,
        builder: (context, _) => ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text(l10n.syncPlayDescription),
            const SizedBox(height: 16),
            _field(
              controller: endpointController,
              label: l10n.syncPlayServerUrl,
              hint: 'wss://your-syncplay-server.example',
            ),
            const SizedBox(height: 12),
            _field(
              controller: originController,
              label: l10n.syncPlayAllowedOrigin,
              hint: 'https://your-app.example',
            ),
            const SizedBox(height: 6),
            Text(
              l10n.syncPlayOriginHelp,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 12),
            _field(
              controller: nameController,
              label: l10n.syncPlayNickname,
              maxLength: 32,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Icon(
                  service.isConnected ? Icons.cloud_done : Icons.cloud_off,
                  color: service.isConnected
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.outline,
                ),
                const SizedBox(width: 8),
                Text(_statusLabel(l10n)),
              ],
            ),
            if (_errorLabel(l10n, service.lastErrorCode) case final error?) ...[
              const SizedBox(height: 8),
              Text(
                error,
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
            ],
            if (service.credentials == null) ...[
              const SizedBox(height: 12),
              FilledButton.icon(
                onPressed: service.status == SyncPlayConnectionStatus.connecting
                    ? null
                    : _createRoom,
                icon: const Icon(Icons.add_link),
                label: Text(l10n.syncPlayCreateRoom),
              ),
              const SizedBox(height: 12),
              _field(
                controller: inviteController,
                label: l10n.syncPlayInviteCode,
                hint: 'ROOMCODE:JOIN_TOKEN',
              ),
              const SizedBox(height: 8),
              OutlinedButton.icon(
                onPressed: service.status == SyncPlayConnectionStatus.connecting
                    ? null
                    : _joinRoom,
                icon: const Icon(Icons.login),
                label: Text(l10n.syncPlayJoinRoom),
              ),
            ] else ...[
              const Divider(height: 28),
              _roomSection(context, l10n),
            ],
            const SizedBox(height: 12),
            Text(
              l10n.syncPlayPrivacyNote,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _field({
    required TextEditingController controller,
    required String label,
    String? hint,
    int? maxLength,
  }) => TextField(
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
