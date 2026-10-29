import 'dart:async';
import 'dart:math' as math;

import 'package:collection/collection.dart';
import 'package:ex_piliplus/features/sync_play/sync_play_connection_history.dart';
import 'package:ex_piliplus/features/sync_play/sync_play_network_status.dart';
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
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
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
  static const advancedMode = 'syncPlayAdvancedMode';
  static const advancedWebSocketUrl = 'syncPlayAdvancedWebSocketUrl';
  static const advancedOrigin = 'syncPlayAdvancedOrigin';
  static const connectionHistory = 'syncPlayConnectionHistory';
}

class SyncPlayPage extends StatefulWidget {
  const SyncPlayPage({
    super.key,
    this.launchContext,
    this.embedded = false,
    this.onClose,
    this.networkStatusSource,
  });

  final SyncPlayLaunchContext? launchContext;
  final bool embedded;
  final VoidCallback? onClose;
  final SyncPlayNetworkStatusSource? networkStatusSource;

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
  late final TextEditingController advancedWebSocketController;
  late final TextEditingController advancedOriginController;
  late final TextEditingController nameController;
  late final SyncPlayNetworkStatusSource _networkStatusSource;
  StreamSubscription<bool?>? _networkSubscription;
  final inviteController = TextEditingController();
  List<SyncPlayConnectionHistoryEntry> _history = const [];
  bool _historyAttemptPending = false;
  bool _deviceOffline = false;
  bool advancedMode = false;
  bool _advancedValuesInitialized = false;
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
    service.addListener(_onServiceChanged);
    _networkStatusSource =
        widget.networkStatusSource ?? DeviceSyncPlayNetworkStatusSource();
    _networkSubscription = _networkStatusSource.offlineChanges.listen(
      _onOfflineChanged,
      onError: (Object _) => _onOfflineChanged(null),
    );
    unawaited(_refreshNetworkStatus());
    _history = SyncPlayConnectionHistoryEntry.parse(
      GStorage.setting.get(
        SyncPlayPreferenceKeys.connectionHistory,
        defaultValue: const <Object?>[],
      ),
    );
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
    final savedWebSocket = GStorage.setting.get(
      SyncPlayPreferenceKeys.advancedWebSocketUrl,
      defaultValue: '',
    );
    final savedOrigin = GStorage.setting.get(
      SyncPlayPreferenceKeys.advancedOrigin,
      defaultValue: '',
    );
    advancedWebSocketController = TextEditingController(
      text: savedWebSocket is String ? savedWebSocket : '',
    );
    advancedOriginController = TextEditingController(
      text: savedOrigin is String ? savedOrigin : '',
    );
    _advancedValuesInitialized =
        advancedWebSocketController.text.isNotEmpty ||
        advancedOriginController.text.isNotEmpty;
    advancedMode = GStorage.setting.get(
      SyncPlayPreferenceKeys.advancedMode,
      defaultValue: false,
    ) == true;
    nameController = TextEditingController(
      text: GStorage.setting.get(
        SyncPlayPreferenceKeys.displayName,
        defaultValue: 'ExPiliPlus',
      ),
    );
  }

  @override
  void dispose() {
    service.removeListener(_onServiceChanged);
    unawaited(_networkSubscription?.cancel());
    serverAddressController.dispose();
    advancedWebSocketController.dispose();
    advancedOriginController.dispose();
    nameController.dispose();
    inviteController.dispose();
    super.dispose();
  }

  void _onOfflineChanged(bool? offline) {
    if (!mounted) return;
    final isDefinitelyOffline = offline == true;
    if (_deviceOffline == isDefinitelyOffline) return;
    setState(() => _deviceOffline = isDefinitelyOffline);
  }

  Future<void> _refreshNetworkStatus() async {
    final offline = await _networkStatusSource.checkOffline();
    _onOfflineChanged(offline);
  }

  void _onServiceChanged() {
    if (_historyAttemptPending) {
      if (service.isInRoom) {
        _historyAttemptPending = false;
        final settings = service.settings;
        if (settings != null) unawaited(_recordSuccessfulConnection(settings));
      } else if (service.lastErrorCode != null) {
        _historyAttemptPending = false;
      }
    }
  }

  Future<void> _recordSuccessfulConnection(
    SyncPlayConnectionSettings settings,
  ) async {
    final entry = SyncPlayConnectionHistoryEntry.fromSuccessfulSettings(
      settings,
      connectedAtEpochMs: DateTime.now().toUtc().millisecondsSinceEpoch,
    );
    if (entry == null) return;
    final updated = SyncPlayConnectionHistoryEntry.record(_history, entry);
    if (mounted) setState(() => _history = updated);
    try {
      await GStorage.setting.put(
        SyncPlayPreferenceKeys.connectionHistory,
        updated.map((item) => item.toJson()).toList(growable: false),
      );
    } catch (_) {
      // A successful room connection remains usable even if local history
      // storage is unavailable.
    }
  }

  SyncPlayConnectionSettings _settings() => SyncPlayConnectionSettings(
    serverAddress: serverAddressController.text,
    displayName: nameController.text,
    advancedMode: advancedMode,
    advancedWebSocketUrl: advancedWebSocketController.text,
    advancedOrigin: advancedOriginController.text,
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
      GStorage.setting.put(
        SyncPlayPreferenceKeys.advancedMode,
        advancedMode,
      ),
      GStorage.setting.put(
        SyncPlayPreferenceKeys.advancedWebSocketUrl,
        advancedWebSocketController.text.trim(),
      ),
      GStorage.setting.put(
        SyncPlayPreferenceKeys.advancedOrigin,
        advancedOriginController.text.trim(),
      ),
    ]);
  }

  Future<void> _setAdvancedMode(bool enabled) async {
    if (enabled && !_advancedValuesInitialized) {
      final derived = SyncPlayServerAddress.tryParse(
        serverAddressController.text,
      );
      advancedWebSocketController.text =
          derived?.endpoint.toString() ?? '';
      advancedOriginController.text = derived?.origin.toString() ?? '';
      _advancedValuesInitialized = true;
    }
    setState(() => advancedMode = enabled);
    await _saveSettings();
  }

  void _saveAdvancedField(String key, String value) {
    _advancedValuesInitialized = true;
    unawaited(GStorage.setting.put(key, value.trim()));
  }

  Future<void> _createRoom() async {
    _historyAttemptPending = true;
    await _saveSettings();
    await service.createRoom(_settings());
  }

  Future<void> _joinRoom() async {
    _historyAttemptPending = true;
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
      builder: (context, _) => LayoutBuilder(
        builder: (context, constraints) {
          final horizontalActions =
              MediaQuery.orientationOf(context) == Orientation.landscape &&
              constraints.maxWidth >= 360;
          return ListView(
            key: const ValueKey('syncplay-content'),
            padding: EdgeInsets.all(widget.embedded ? 12 : 16),
            children: [
              _field(
                key: const ValueKey('syncplay-server-address'),
                controller: serverAddressController,
                label: l10n.syncPlayServerUrl,
                hint: 'server.example:443/sync',
                enabled: !advancedMode,
              ),
              SwitchListTile(
                key: const ValueKey('syncplay-advanced-mode'),
                contentPadding: EdgeInsets.zero,
                title: Text(l10n.syncPlayAdvancedMode),
                value: advancedMode,
                onChanged: service.status == SyncPlayConnectionStatus.connecting
                    ? null
                    : _setAdvancedMode,
              ),
              if (advancedMode) ...[
                _field(
                  key: const ValueKey('syncplay-advanced-websocket-url'),
                  controller: advancedWebSocketController,
                  label: l10n.syncPlayWebSocketUrl,
                  hint: 'wss://server.example:443/sync',
                  onChanged: (value) => _saveAdvancedField(
                    SyncPlayPreferenceKeys.advancedWebSocketUrl,
                    value,
                  ),
                ),
                const SizedBox(height: 8),
                _field(
                  key: const ValueKey('syncplay-advanced-origin'),
                  controller: advancedOriginController,
                  label: l10n.syncPlayAllowedOrigin,
                  hint: 'https://web.example',
                  onChanged: (value) => _saveAdvancedField(
                    SyncPlayPreferenceKeys.advancedOrigin,
                    value,
                  ),
                ),
                const SizedBox(height: 8),
              ],
              const SizedBox(height: 4),
              if (service.credentials == null) ...[
                _nameEntry(l10n, horizontal: horizontalActions),
                const SizedBox(height: 8),
                _inviteEntry(l10n, horizontal: horizontalActions),
              ] else ...[
                const Divider(height: 24),
                _roomSection(context, l10n),
              ],
              const SizedBox(height: 12),
              Align(
                alignment: Alignment.centerLeft,
                child: Semantics(
                  key: const ValueKey('syncplay-cloud-status'),
                  label: _deviceOffline
                      ? l10n.syncPlayNetworkOffline
                      : service.isConnected
                      ? l10n.syncPlayNetworkConnected
                      : l10n.syncPlayNetworkDisconnected,
                  liveRegion: true,
                  child: ExcludeSemantics(
                    child: Icon(
                      _deviceOffline || !service.isConnected
                          ? Icons.cloud_off
                          : Icons.cloud_done,
                      key: ValueKey(
                        _deviceOffline
                            ? 'syncplay-cloud-offline'
                            : service.isConnected
                            ? 'syncplay-cloud-connected'
                            : 'syncplay-cloud-disconnected',
                      ),
                      color: _deviceOffline
                          ? Theme.of(context).colorScheme.error
                          : Colors.white,
                    ),
                  ),
                ),
              ),
              if (_history.isNotEmpty) ...[
                const SizedBox(height: 8),
                for (final entry in _history)
                  ListTile(
                    key: ValueKey(
                      'syncplay-history-${entry.serverAddress}-${entry.displayName}',
                    ),
                    contentPadding: EdgeInsets.zero,
                    title: Text(entry.displayName),
                    subtitle: Text(entry.serverAddress),
                    trailing: Text(
                      DateFormat('yy/MM/dd HH:mm').format(
                        DateTime.fromMillisecondsSinceEpoch(
                          entry.connectedAtEpochMs,
                          isUtc: true,
                        ).toLocal(),
                      ),
                      key: const ValueKey('syncplay-history-time'),
                    ),
                  ),
              ],
              if (_errorLabel(l10n, service.lastErrorCode) case final error?) ...[
                const SizedBox(height: 8),
                Text(
                  error,
                  key: const ValueKey('syncplay-connection-error'),
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                ),
              ],
            ],
          );
        },
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
    ValueChanged<String>? onChanged,
    bool enabled = true,
  }) => TextField(
    key: key,
    controller: controller,
    maxLength: maxLength,
    onChanged: onChanged,
    enabled: enabled,
    decoration: InputDecoration(labelText: label, hintText: hint),
  );

  Widget _nameEntry(AppLocalizations l10n, {required bool horizontal}) {
    final field = _field(
      key: const ValueKey('syncplay-display-name'),
      controller: nameController,
      label: l10n.syncPlayNickname,
      maxLength: 32,
    );
    final button = FilledButton.icon(
      key: const ValueKey('syncplay-create-room'),
      onPressed: service.status == SyncPlayConnectionStatus.connecting
          ? null
          : _createRoom,
      icon: const Icon(Icons.add_link),
      label: Text(l10n.syncPlayCreateRoom),
    );
    if (horizontal) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: field),
          const SizedBox(width: 8),
          Padding(padding: const EdgeInsets.only(top: 4), child: button),
        ],
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [field, const SizedBox(height: 4), button],
    );
  }

  Widget _inviteEntry(AppLocalizations l10n, {required bool horizontal}) {
    final field = _field(
      key: const ValueKey('syncplay-invite-code'),
      controller: inviteController,
      label: l10n.syncPlayInviteCode,
      hint: 'ROOMCODE:JOIN_TOKEN',
    );
    final button = OutlinedButton.icon(
      key: const ValueKey('syncplay-join-room'),
      onPressed: service.status == SyncPlayConnectionStatus.connecting
          ? null
          : _joinRoom,
      icon: const Icon(Icons.login),
      label: Text(l10n.syncPlayJoinRoom),
    );
    if (horizontal) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: field),
          const SizedBox(width: 8),
          Padding(padding: const EdgeInsets.only(top: 4), child: button),
        ],
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [field, const SizedBox(height: 4), button],
    );
  }

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
