import 'dart:async';
import 'dart:io';

import 'package:crypto/crypto.dart' as crypto;
import 'package:ex_piliplus/common/widgets/custom_toast.dart';
import 'package:ex_piliplus/features/sync_play/sync_play_player_binding.dart';
import 'package:ex_piliplus/features/sync_play/sync_play_network_status.dart';
import 'package:ex_piliplus/features/sync_play/sync_play_protocol.dart';
import 'package:ex_piliplus/features/sync_play/sync_play_service.dart';
import 'package:ex_piliplus/l10n/app_localization_delegates.dart';
import 'package:ex_piliplus/l10n/generated/app_localizations.dart';
import 'package:ex_piliplus/pages/sync_play/view.dart';
import 'package:ex_piliplus/plugin/pl_player/controller.dart';
import 'package:ex_piliplus/plugin/pl_player/models/data_source.dart';
import 'package:ex_piliplus/utils/path_utils.dart'
    show appSupportDirPath, tmpDirPath;
import 'package:ex_piliplus/utils/storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:hive_ce/hive.dart';
import 'package:integration_test/integration_test.dart';
import 'package:material_ui/material_ui.dart' as mui;
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart' as media_video;
import 'package:path/path.dart' as path;
import 'package:web_socket_channel/io.dart';

const _upstreamRevision = 'f9258d976570492a1d1e2c469d3da90a8cfade96';
const _origin = 'https://syncplay-integration.test';
final _video = SyncPlayVideoRef.fromPlayer(
  bvid: 'BV1gA411M7RN',
  cid: 2002,
  part: 1,
);

class _ChannelSocket implements SyncPlaySocket {
  _ChannelSocket(this.channel);

  final IOWebSocketChannel channel;

  @override
  Stream<Object?> get stream => channel.stream;

  @override
  void send(String text) => channel.sink.add(text);

  @override
  Future<void> close() async => channel.sink.close();
}

class _IdleOwnerPlayer implements SyncPlayPlayerPort {
  @override
  final Object identity = Object();
  @override
  int positionMs = 0;
  @override
  int durationMs = 16_000;
  @override
  double playbackRate = 1;
  @override
  double get syncPlaybackRate => playbackRate;
  @override
  bool isTransientSpeed = false;
  @override
  bool isPlaying = false;
  @override
  bool isCompleted = false;
  @override
  bool isBuffering = false;

  final Set<void Function(Duration)> _positionListeners = {};
  final Set<void Function()> _statusListeners = {};
  final Set<void Function(PlPlayerExplicitAction)> _actionListeners = {};

  @override
  void addPositionListener(void Function(Duration) listener) =>
      _positionListeners.add(listener);
  @override
  void removePositionListener(void Function(Duration) listener) =>
      _positionListeners.remove(listener);
  @override
  void addStatusListener(void Function() listener) =>
      _statusListeners.add(listener);
  @override
  void removeStatusListener(void Function() listener) =>
      _statusListeners.remove(listener);
  @override
  void addExplicitActionListener(
    void Function(PlPlayerExplicitAction) listener,
  ) =>
      _actionListeners.add(listener);
  @override
  void removeExplicitActionListener(
    void Function(PlPlayerExplicitAction) listener,
  ) =>
      _actionListeners.remove(listener);
  @override
  Future<void> seekToMs(int milliseconds) async => positionMs = milliseconds;
  @override
  Future<void> setPlaybackRate(double rate) async => playbackRate = rate;
  @override
  Future<void> play() async => isPlaying = true;
  @override
  Future<void> pause() async => isPlaying = false;
}

class _OnlineNetwork implements SyncPlayNetworkStatusSource {
  @override
  Future<bool?> checkOffline() async => false;

  @override
  Stream<bool?> get offlineChanges => const Stream<bool?>.empty();
}

Future<void> _waitUntil(
  String description,
  bool Function() condition, {
  Duration timeout = const Duration(seconds: 15),
}) async {
  final stopwatch = Stopwatch()..start();
  while (stopwatch.elapsed < timeout) {
    if (condition()) return;
    await Future<void>.delayed(const Duration(milliseconds: 50));
  }
  throw TimeoutException('Timed out waiting for $description.', timeout);
}

Future<SyncPlaySocket> _connectToPinnedUpstream(
  Uri requestedEndpoint,
  String requestedOrigin,
  int tlsPort,
  HttpClient trustedClient,
) async {
  expect(requestedEndpoint.scheme, 'wss');
  expect(requestedEndpoint.host, '127.0.0.1');
  expect(requestedEndpoint.port, tlsPort);
  expect(requestedOrigin, _origin);
  final channel = IOWebSocketChannel.connect(
    requestedEndpoint,
    headers: const {'Origin': _origin},
    connectTimeout: const Duration(seconds: 8),
    pingInterval: const Duration(seconds: 25),
    customClient: trustedClient,
  );
  await channel.ready;
  return _ChannelSocket(channel);
}

SyncPlayConnectionSettings _settings(String name, int tlsPort) =>
    SyncPlayConnectionSettings(
      serverAddress: '',
      displayName: name,
      advancedMode: true,
      advancedWebSocketUrl: 'wss://127.0.0.1:$tlsPort',
      advancedOrigin: _origin,
    );

GetMaterialApp _testApp(Widget home) => GetMaterialApp(
  debugShowCheckedModeBanner: false,
  locale: const Locale('en'),
  localizationsDelegates: appLocalizationsDelegates,
  supportedLocales: AppLocalizations.supportedLocales,
  builder: FlutterSmartDialog.init(
    toastBuilder: CustomToast.new,
    loadingBuilder: LoadingWidget.new,
    notifyStyle: const FlutterSmartNotifyStyle(
      warningBuilder: NotifyWarning.new,
    ),
  ),
  navigatorObservers: [FlutterSmartDialog.observer],
  home: home,
);

Future<void> _pumpUntil(
  WidgetTester tester,
  Finder finder, {
  Duration timeout = const Duration(seconds: 5),
}) async {
  final stopwatch = Stopwatch()..start();
  while (stopwatch.elapsed < timeout) {
    if (finder.evaluate().isNotEmpty) return;
    await tester.pump(const Duration(milliseconds: 100));
  }
  throw TimeoutException('Widget did not appear: $finder', timeout);
}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets(
    'real media_kit player applies upstream sync and survives player panel close',
    (tester) async {
      final upstreamRevision =
          Platform.environment['SYNCPLAY_UPSTREAM_REVISION'];
      final tlsPort = int.tryParse(
        Platform.environment['SYNCPLAY_TEST_TLS_PORT'] ?? '',
      );
      final certSha256 = Platform.environment[
        'SYNCPLAY_TEST_TLS_CERT_SHA256'
      ];
      final fixturePath = Platform.environment['SYNCPLAY_MEDIA_FIXTURE'] ??
          (throw StateError('SYNCPLAY_MEDIA_FIXTURE is required.'));
      expect(tlsPort, isNotNull);
      expect(upstreamRevision, _upstreamRevision);
      expect(certSha256, matches(RegExp(r'^[a-f0-9]{64}$')));
      late final Directory supportDirectory;
      await tester.runAsync(() async {
        expect(await File(fixturePath).exists(), isTrue);
        supportDirectory = await Directory.systemTemp.createTemp(
          'exp-syncplay-media-kit-',
        );
        appSupportDirPath = supportDirectory.path;
        tmpDirPath = supportDirectory.path;
        await GStorage.init();
        MediaKit.ensureInitialized();
      });
      Get.testMode = true;
      SmartDialog.config.toast = SmartConfigToast(displayType: .onlyRefresh);

      // The production player can report native initialization events as soon
      // as its listeners attach. Mount the same SmartDialog hooks as the app
      // before creating the player so those events have an initialized toast
      // context instead of failing on an uninitialized test root.
      await tester.pumpWidget(_testApp(const SizedBox.shrink()));

      final fixtureDirectory = path.dirname(path.dirname(fixturePath));
      final fixtureType = path.basename(path.dirname(fixturePath));
      final controller = PlPlayerController.getInstance();
      final port = PlPlayerSyncPort(controller);
      var nativePositionCallbacks = 0;
      void onPosition(Duration _) => nativePositionCallbacks++;
      final trustedPort = tlsPort!;
      final trustedFingerprint = certSha256!;
      final trustedClient = HttpClient()
        ..badCertificateCallback = (certificate, host, port) =>
            host == '127.0.0.1' &&
            port == trustedPort &&
            crypto.sha256.convert(certificate.der).toString() ==
                trustedFingerprint;
      final owner = SyncPlayService(
        socketFactory: (endpoint, origin) => _connectToPinnedUpstream(
          endpoint,
          origin,
          trustedPort,
          trustedClient,
        ),
      );
      final guest = SyncPlayService(
        socketFactory: (endpoint, origin) => _connectToPinnedUpstream(
          endpoint,
          origin,
          trustedPort,
          trustedClient,
        ),
      );
      final ownerPlayer = _IdleOwnerPlayer();
      late final Player nativePlayer;
      // This is an offline synthetic clip, never a Bilibili playback session.
      // Prevent the production controller from sending watch-heartbeat calls.
      controller.enableHeart = false;

      try {
        await tester.runAsync(
          () => controller.setDataSource(
            FileSource(
              dir: fixtureDirectory,
              isMp4: true,
              hasDashAudio: false,
              typeTag: fixtureType,
            ),
            autoplay: false,
            duration: const Duration(seconds: 16),
            width: 640,
            height: 360,
          ),
        );
        nativePlayer = controller.videoPlayerController ??
            (throw StateError(
              'Production controller did not create media_kit Player.',
            ));
        port.addPositionListener(onPosition);
        Get.put(guest, permanent: true);
        await tester.pumpWidget(
          _testApp(
            mui.Scaffold(
              body: Stack(
                fit: StackFit.expand,
                children: [
                  media_video.Video(controller: controller.videoController!),
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: Text('Local silent media_kit fixture'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
        await tester.pump(const Duration(milliseconds: 350));

        await tester.runAsync(() async {
          await _waitUntil(
            'native media duration from the generated local clip',
            () => nativePlayer.state.duration >= const Duration(seconds: 15),
            timeout: const Duration(seconds: 20),
          );
          await _waitUntil(
            'mpv video parameters from the generated local clip',
            () => nativePlayer.state.videoParams.dw != null &&
                nativePlayer.state.videoParams.dh != null &&
                nativePlayer.state.videoParams.dw! > 0 &&
                nativePlayer.state.videoParams.dh! > 0,
            timeout: const Duration(seconds: 20),
          );

          await owner.createRoom(_settings('Native player host', trustedPort));
          await _waitUntil(
            'pinned upstream host room creation',
            () => owner.credentials != null && owner.room != null,
          );
          final invite = owner.invite;
          expect(invite, isNotNull);
          await guest.joinRoom(
            _settings('Native player guest', trustedPort),
            invite!,
          );
          await _waitUntil(
            'two production Dart service sessions joined the room',
            () => owner.room?.members.length == 2 &&
                guest.room?.members.length == 2,
          );

          expect(
            await owner.shareCurrentVideo(
              video: _video,
              title: 'Synthetic local media_kit fixture',
              player: ownerPlayer,
            ),
            isTrue,
          );
          await _waitUntil(
            'upstream shared-video state reaches the native-player guest',
            () => guest.room?.sharedVideo?.videoId == _video.videoId,
          );
          guest.attachIfShared(
            video: _video,
            title: 'Synthetic local media_kit fixture',
            player: port,
          );

          final pausedSeek = SyncPlayPlayback(
            url: _video.url,
            currentTimeSeconds: 2,
            state: SyncPlayPlaybackState.paused,
            playbackRate: 1.5,
            updatedAt: DateTime.now().millisecondsSinceEpoch,
            serverTime: 0,
            actorId: owner.memberId!,
            seq: owner.nextPlaybackSequence(),
            syncIntent: 'explicit-seek',
            userInitiated: true,
          );
          owner.sendPlayback(pausedSeek);
          await _waitUntil(
            'native mpv applies remote paused seek and playback rate',
            () => (nativePlayer.state.position - const Duration(seconds: 2))
                        .inMilliseconds
                        .abs() <
                    700 &&
                (nativePlayer.state.rate - 1.5).abs() < 0.01 &&
                !port.isPlaying,
          );

          final playingSeek = SyncPlayPlayback(
            url: _video.url,
            currentTimeSeconds: 4,
            state: SyncPlayPlaybackState.playing,
            playbackRate: 1.25,
            updatedAt: DateTime.now().millisecondsSinceEpoch,
            serverTime: 0,
            actorId: owner.memberId!,
            seq: owner.nextPlaybackSequence(),
            syncIntent: 'explicit-seek',
            userInitiated: true,
          );
          owner.sendPlayback(playingSeek);
          await _waitUntil(
            'native mpv starts from remote playback state',
            () => nativePlayer.state.playing &&
                (nativePlayer.state.rate - 1.25).abs() < 0.01 &&
                nativePlayer.state.position >= const Duration(seconds: 4),
          );

          await controller.onDoubleTapCenter();
          await _waitUntil(
            'production player pause action reaches the native player',
            () => !nativePlayer.state.playing && !port.isPlaying,
          );
          await _waitUntil(
            'guest pause action is broadcast to the host service',
            () => owner.room?.playback?.actorId == guest.memberId &&
                owner.room?.playback?.state == SyncPlayPlaybackState.paused,
          );

          await controller.seekToFromUser(
            const Duration(seconds: 7),
            isSeek: false,
          );
          await _waitUntil(
            'production player seek callback reaches native mpv and host',
            () => (nativePlayer.state.position - const Duration(seconds: 7))
                        .inMilliseconds
                        .abs() <
                    800 &&
                owner.room?.playback?.syncIntent == 'explicit-seek' &&
                owner.room?.playback?.actorId == guest.memberId,
          );

          await controller.setPlaybackSpeedFromUser(1.75);
          await _waitUntil(
            'production player rate callback reaches native mpv and host',
            () => (nativePlayer.state.rate - 1.75).abs() < 0.01 &&
                owner.room?.playback?.syncIntent == 'explicit-ratechange' &&
                ((owner.room?.playback?.playbackRate ?? 0) - 1.75).abs() <
                    0.01,
          );
          await controller.onDoubleTapCenter();
          await _waitUntil(
            'production player resumes through native mpv',
            () => nativePlayer.state.playing && port.isPlaying,
          );
        });

        final launcher = SyncPlayPanelLauncher();
        final playerContext = tester.element(
          find.text('Local silent media_kit fixture'),
        );
        var menuClosed = false;
        final panelFuture = launcher.openFromPlayerMenu(
          playerContext: playerContext,
          closeMenu: () => menuClosed = true,
          launchContext: SyncPlayLaunchContext(
            video: _video,
            title: 'Synthetic local media_kit fixture',
            player: port,
            currentVideoId: () => _video.videoId,
          ),
          networkStatusSource: _OnlineNetwork(),
        );
        await _pumpUntil(tester, find.byKey(const ValueKey('syncplay-player-panel')));
        expect(menuClosed, isTrue);
        final panelContext = tester.element(
          find.byKey(const ValueKey('syncplay-player-panel')),
        );
        final closeLabel = AppLocalizations.of(panelContext)!.commonClose;
        await tester.tap(find.byTooltip(closeLabel));
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 250));
        await panelFuture;
        expect(find.byKey(const ValueKey('syncplay-player-panel')), findsNothing);
        expect(guest.isInRoom, isTrue, reason: 'Closing the overlay must not leave SyncPlay.');
        expect(identical(controller.videoPlayerController, nativePlayer), isTrue);

        final positionBeforeClose = nativePlayer.state.position;
        await tester.runAsync(
          () => Future<void>.delayed(const Duration(milliseconds: 700)),
        );
        expect(nativePlayer.state.playing, isTrue);
        expect(nativePlayer.state.position > positionBeforeClose, isTrue);
        expect(nativePositionCallbacks, greaterThan(0));
        print(
          'SYNCPLAY_REAL_PLAYER platform=linux backend=media_kit/libmpv '
          'duration_ms=${nativePlayer.state.duration.inMilliseconds} '
          'position_ms=${nativePlayer.state.position.inMilliseconds} '
          'rate=${nativePlayer.state.rate} playing=${nativePlayer.state.playing} '
          'video=${nativePlayer.state.videoParams.dw}x'
          '${nativePlayer.state.videoParams.dh} '
          'position_callbacks=$nativePositionCallbacks '
          'services=2 room_members=${guest.room?.members.length} '
          'panel_closed=true player_preserved=true audio_track=none',
        );
        expect(tester.takeException(), isNull);
      } finally {
        await tester.pumpWidget(const SizedBox.shrink());
        await tester.pump();
        port.removePositionListener(onPosition);
        if (guest.isInRoom || guest.isConnected) {
          await tester.runAsync(() => guest.leaveRoom());
        }
        if (owner.isInRoom || owner.isConnected) {
          await tester.runAsync(() => owner.leaveRoom());
        }
        guest.dispose();
        owner.dispose();
        Get.reset();
        controller.dispose();
        trustedClient.close(force: true);
        await tester.runAsync(() async {
          await Future<void>.delayed(const Duration(milliseconds: 300));
          await Hive.close();
          await supportDirectory.delete(recursive: true);
        });
      }
    },
    timeout: const Timeout(Duration(minutes: 3)),
  );
}
