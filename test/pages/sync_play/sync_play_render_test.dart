import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:ex_piliplus/features/sync_play/sync_play_connection_history.dart';
import 'package:ex_piliplus/features/sync_play/sync_play_network_status.dart';
import 'package:ex_piliplus/features/sync_play/sync_play_service.dart';
import 'package:ex_piliplus/l10n/app_localization_delegates.dart';
import 'package:ex_piliplus/l10n/generated/app_localizations.dart';
import 'package:ex_piliplus/pages/sync_play/view.dart';
import 'package:ex_piliplus/utils/storage.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:hive_ce/hive.dart';
import 'package:material_ui/material_ui.dart';

import '../../support/render_test_fonts.dart';

const _captureKey = ValueKey('syncplay-capture');

class _MemoryBox implements Box<dynamic> {
  final Map<dynamic, dynamic> _values = {};

  @override
  dynamic get(dynamic key, {dynamic defaultValue}) =>
      _values.containsKey(key) ? _values[key] : defaultValue;

  @override
  Future<void> put(dynamic key, dynamic value) async {
    _values[key] = value;
  }

  @override
  Future<int> clear() async {
    final count = _values.length;
    _values.clear();
    return count;
  }

  void reset() => _values.clear();

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _ScreenshotSocket implements SyncPlaySocket {
  final controller = StreamController<Object?>.broadcast();

  @override
  Stream<Object?> get stream => controller.stream;

  @override
  void send(String text) {}

  void emit(Map<String, Object?> message) => controller.add(jsonEncode(message));

  @override
  Future<void> close() => controller.close();
}

class _FakeNetworkStatusSource implements SyncPlayNetworkStatusSource {
  _FakeNetworkStatusSource(this.offline);

  bool? offline;
  final StreamController<bool?> _changes =
      StreamController<bool?>.broadcast(sync: true);

  @override
  Future<bool?> checkOffline() async => offline;

  @override
  Stream<bool?> get offlineChanges => _changes.stream;

  void emit(bool? value) {
    offline = value;
    _changes.add(value);
  }

  Future<void> close() => _changes.close();
}

void _setTestViewSize(WidgetTester tester, Size size) {
  tester.view.devicePixelRatio = 1;
  tester.view.physicalSize = size;
}

void _resetTestViewSize(WidgetTester tester) {
  tester.view.resetPhysicalSize();
  tester.view.resetDevicePixelRatio();
}

Future<void> _saveCapture(WidgetTester tester, String filename) async {
  final boundary = tester.renderObject<RenderRepaintBoundary>(
    find.byKey(_captureKey),
  );
  await tester.runAsync(() async {
    final image = await boundary.toImage(pixelRatio: 2);
    try {
      final data = await image.toByteData(format: ui.ImageByteFormat.png);
      final file = File('build/test-artifacts/syncplay/$filename');
      await file.parent.create(recursive: true);
      await file.writeAsBytes(data!.buffer.asUint8List());
    } finally {
      image.dispose();
    }
  });
}

Widget _app(Widget child) {
  final theme = ThemeData.dark(useMaterial3: true);
  return RepaintBoundary(
    key: _captureKey,
    child: GetMaterialApp(
      debugShowCheckedModeBanner: false,
      locale: const Locale('zh'),
      localizationsDelegates: appLocalizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: theme.copyWith(
        textTheme: theme.textTheme.apply(fontFamily: 'Source Han Serif CN'),
      ),
      home: child,
    ),
  );
}

void main() {
  final box = _MemoryBox();

  setUpAll(() async {
    await loadRenderTestFonts();
    GStorage.setting = box;
  });

  setUp(() {
    Get.reset();
    box.reset();
  });

  tearDown(() {
    Get.reset();
  });

  testWidgets('renders the single secure server-address form', (
    tester,
  ) async {
    _setTestViewSize(tester, const Size(440, 820));
    addTearDown(() => _resetTestViewSize(tester));
    final service = SyncPlayService(reconnectEnabled: false);
    Get.put(service, permanent: true);

    await tester.pumpWidget(_app(const SyncPlayPage()));
    await tester.pumpAndSettle();

    expect(find.text('Bili-SyncPlay'), findsOneWidget);
    expect(
      tester.widget<SwitchListTile>(
        find.byKey(const ValueKey('syncplay-advanced-mode')),
      ).value,
      isFalse,
    );
    expect(
      find.byKey(const ValueKey('syncplay-advanced-websocket-url')),
      findsNothing,
    );
    expect(
      find.byKey(const ValueKey('syncplay-server-address')),
      findsOneWidget,
    );
    expect(find.text('服务器允许的 Origin'), findsNothing);
    expect(find.textContaining('不要伪装浏览器扩展身份'), findsNothing);
    expect(find.textContaining('不会发送 B 站 Cookie'), findsNothing);
    expect(find.text('创建房间'), findsOneWidget);
    expect(find.text('加入房间'), findsOneWidget);
    expect(
      tester
          .widget<TextField>(
            find.byKey(const ValueKey('syncplay-server-address')),
          )
          .controller!
          .text,
      isEmpty,
    );
    final nicknameRect = tester.getRect(
      find.byKey(const ValueKey('syncplay-display-name')),
    );
    final createRect = tester.getRect(
      find.byKey(const ValueKey('syncplay-create-room')),
    );
    final inviteRect = tester.getRect(
      find.byKey(const ValueKey('syncplay-invite-code')),
    );
    final joinRect = tester.getRect(
      find.byKey(const ValueKey('syncplay-join-room')),
    );
    expect(createRect.top, greaterThan(nicknameRect.bottom));
    expect(joinRect.top, greaterThan(inviteRect.bottom));
    await _saveCapture(tester, 'connection-form-dark-zh.png');

    await tester.enterText(
      find.byKey(const ValueKey('syncplay-server-address')),
      'sync.example.test:9443/ws',
    );
    await tester.tap(find.byKey(const ValueKey('syncplay-advanced-mode')));
    await tester.pumpAndSettle();
    expect(
      tester.widget<SwitchListTile>(
        find.byKey(const ValueKey('syncplay-advanced-mode')),
      ).value,
      isTrue,
    );
    expect(
      tester
          .widget<TextField>(
            find.byKey(const ValueKey('syncplay-server-address')),
          )
          .enabled,
      isFalse,
    );
    expect(
      tester
          .widget<TextField>(
            find.byKey(const ValueKey('syncplay-advanced-websocket-url')),
          )
          .controller!
          .text,
      'wss://sync.example.test:9443/ws',
    );
    expect(
      tester
          .widget<TextField>(
            find.byKey(const ValueKey('syncplay-advanced-origin')),
          )
          .controller!
          .text,
      'https://sync.example.test:9443',
    );
    expect(find.text('WebSocket 连接地址'), findsOneWidget);
    expect(find.text('服务器允许的 Origin'), findsOneWidget);
    await _saveCapture(tester, 'connection-form-advanced-dark-zh.png');
    service.dispose();
    Get.reset();
  }, timeout: const Timeout(Duration(minutes: 3)));

  testWidgets('landscape connection form places each action beside its field', (
    tester,
  ) async {
    _setTestViewSize(tester, const Size(900, 720));
    addTearDown(() => _resetTestViewSize(tester));
    final service = SyncPlayService(reconnectEnabled: false);
    Get.put(service, permanent: true);

    await tester.pumpWidget(_app(const SyncPlayPage()));
    await tester.pumpAndSettle();
    final nicknameRect = tester.getRect(
      find.byKey(const ValueKey('syncplay-display-name')),
    );
    final createRect = tester.getRect(
      find.byKey(const ValueKey('syncplay-create-room')),
    );
    final inviteRect = tester.getRect(
      find.byKey(const ValueKey('syncplay-invite-code')),
    );
    final joinRect = tester.getRect(
      find.byKey(const ValueKey('syncplay-join-room')),
    );
    expect(createRect.left, greaterThan(nicknameRect.right));
    expect(joinRect.left, greaterThan(inviteRect.right));
    expect(createRect.center.dy, greaterThan(nicknameRect.top));
    expect(createRect.center.dy, lessThan(nicknameRect.bottom));
    expect(joinRect.center.dy, greaterThan(inviteRect.top));
    expect(joinRect.center.dy, lessThan(inviteRect.bottom));
    expect(tester.takeException(), isNull);
    await _saveCapture(tester, 'connection-form-landscape-dark-zh.png');

    await tester.enterText(
      find.byKey(const ValueKey('syncplay-server-address')),
      'sync.example.test:9443/ws',
    );
    await tester.tap(find.byKey(const ValueKey('syncplay-advanced-mode')));
    await tester.pumpAndSettle();
    expect(
      find.byKey(const ValueKey('syncplay-advanced-websocket-url')),
      findsOneWidget,
    );
    expect(tester.takeException(), isNull);
    await _saveCapture(
      tester,
      'connection-form-landscape-advanced-dark-zh.png',
    );

    service.dispose();
    Get.reset();
  }, timeout: const Timeout(Duration(minutes: 3)));

  testWidgets('advanced values persist across mode changes but off derives Origin', (
    tester,
  ) async {
    _setTestViewSize(tester, const Size(440, 900));
    addTearDown(() => _resetTestViewSize(tester));
    final observed = <(Uri, String)>[];
    final service = SyncPlayService(
      reconnectEnabled: false,
      socketFactory: (endpoint, origin) async {
        observed.add((endpoint, origin));
        return _ScreenshotSocket();
      },
    );
    Get.put(service, permanent: true);

    await tester.pumpWidget(_app(const SyncPlayPage()));
    await tester.pumpAndSettle();
    await tester.enterText(
      find.byKey(const ValueKey('syncplay-server-address')),
      'simple.example.test:9443/path',
    );
    await tester.tap(find.byKey(const ValueKey('syncplay-advanced-mode')));
    await tester.pumpAndSettle();
    await tester.enterText(
      find.byKey(const ValueKey('syncplay-advanced-websocket-url')),
      'wss://socket.example.test:9444/room',
    );
    await tester.enterText(
      find.byKey(const ValueKey('syncplay-advanced-origin')),
      'https://client.example.test:8443',
    );

    await tester.tap(find.byKey(const ValueKey('syncplay-advanced-mode')));
    await tester.pumpAndSettle();
    expect(
      find.byKey(const ValueKey('syncplay-advanced-websocket-url')),
      findsNothing,
    );
    expect(
      GStorage.setting.get(SyncPlayPreferenceKeys.advancedWebSocketUrl),
      'wss://socket.example.test:9444/room',
    );
    expect(
      GStorage.setting.get(SyncPlayPreferenceKeys.advancedOrigin),
      'https://client.example.test:8443',
    );
    await tester.tap(find.byKey(const ValueKey('syncplay-advanced-mode')));
    await tester.pumpAndSettle();
    expect(
      tester
          .widget<TextField>(
            find.byKey(const ValueKey('syncplay-advanced-websocket-url')),
          )
          .controller!
          .text,
      'wss://socket.example.test:9444/room',
    );
    expect(
      tester
          .widget<TextField>(
            find.byKey(const ValueKey('syncplay-advanced-origin')),
          )
          .controller!
          .text,
      'https://client.example.test:8443',
    );

    await tester.tap(find.byKey(const ValueKey('syncplay-advanced-mode')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('syncplay-create-room')));
    await tester.pumpAndSettle();
    expect(observed.single.$1.toString(), 'wss://simple.example.test:9443/path');
    expect(observed.single.$2, 'https://simple.example.test:9443');
    expect(GStorage.setting.get(SyncPlayPreferenceKeys.advancedMode), isFalse);

    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pumpWidget(_app(const SyncPlayPage()));
    await tester.pumpAndSettle();
    expect(
      tester.widget<SwitchListTile>(
        find.byKey(const ValueKey('syncplay-advanced-mode')),
      ).value,
      isFalse,
    );
    await tester.tap(find.byKey(const ValueKey('syncplay-advanced-mode')));
    await tester.pumpAndSettle();
    expect(
      tester
          .widget<TextField>(
            find.byKey(const ValueKey('syncplay-advanced-websocket-url')),
          )
          .controller!
          .text,
      'wss://socket.example.test:9444/room',
    );
    expect(
      tester
          .widget<TextField>(
            find.byKey(const ValueKey('syncplay-advanced-origin')),
          )
          .controller!
          .text,
      'https://client.example.test:8443',
    );

    await tester.pumpWidget(const SizedBox.shrink());
    service.dispose();
    Get.reset();
  }, timeout: const Timeout(Duration(minutes: 3)));

  testWidgets('renders an active room and shared public-video card', (
    tester,
  ) async {
    _setTestViewSize(tester, const Size(440, 900));
    addTearDown(() => _resetTestViewSize(tester));
    final socket = _ScreenshotSocket();
    final service = SyncPlayService(
      reconnectEnabled: false,
      socketFactory: (_, __) async => socket,
    );
    Get.put(service, permanent: true);

    await tester.pumpWidget(_app(const SyncPlayPage()));
    await tester.pumpAndSettle();
    await tester.enterText(
      find.byKey(const ValueKey('syncplay-server-address')),
      'sync.example.test:9443/ws',
    );
    await tester.tap(find.text('创建房间'));
    await tester.pumpAndSettle();
    socket.emit({
      'type': 'room:created',
      'payload': {
        'roomCode': 'ROOM42',
        'memberId': 'render-member',
        'joinToken': 'render-only-token',
        'memberToken': 'render-member-token',
      },
    });
    await tester.pump();
    socket.emit({
      'type': 'room:state',
      'payload': {
        'roomCode': 'ROOM42',
        'members': [
          {'id': 'render-member', 'name': '测试成员'},
          {'id': 'synthetic-peer', 'name': '虚构成员'},
        ],
        'sharedVideo': {
          'videoId': 'BV1gA411M7RN:2002',
          'url': 'https://www.bilibili.com/video/BV1gA411M7RN?cid=2002',
          'title': '仅用于截图的合成视频标题',
          'sharedByMemberId': 'synthetic-peer',
          'sharedByDisplayName': '虚构成员',
        },
        'playback': {
          'url': 'https://www.bilibili.com/video/BV1gA411M7RN?cid=2002',
          'currentTime': 32.5,
          'playState': 'paused',
          'playbackRate': 1,
          'updatedAt': 100,
          'serverTime': 200,
          'actorId': 'synthetic-peer',
          'seq': 1,
        },
      },
    });
    await tester.pumpAndSettle();

    final rawHistory = GStorage.setting.get(
      SyncPlayPreferenceKeys.connectionHistory,
    );
    expect(rawHistory, isA<List>());
    final storedEntry = (rawHistory as List).single as Map;
    expect(storedEntry.keys.toSet(), {
      'displayName',
      'serverAddress',
      'connectedAtEpochMs',
    });
    expect(jsonEncode(rawHistory), isNot(contains('render-only-token')));
    expect(jsonEncode(rawHistory), isNot(contains('render-member-token')));
    expect(
      storedEntry['serverAddress'],
      'wss://sync.example.test:9443/ws',
    );
    expect(storedEntry['displayName'], 'ExPiliPlus');
    expect(
      find.byWidgetPredicate(
        (widget) => widget is Text && widget.data?.contains('ROOM42') == true,
      ),
      findsOneWidget,
    );
    expect(find.text('测试成员'), findsOneWidget);
    expect(find.text('虚构成员'), findsOneWidget);
    expect(find.text('仅用于截图的合成视频标题'), findsOneWidget);
    expect(find.textContaining('render-only-token'), findsOneWidget);
    await _saveCapture(tester, 'active-room-dark-zh.png');
    try {
      await tester.runAsync(
        service.leaveRoom,
      ).timeout(
        const Duration(seconds: 5),
        onTimeout: () => throw TimeoutException(
          'SyncPlay leaveRoom did not finish during render-test cleanup',
        ),
      );
    } finally {
      service.dispose();
      Get.reset();
    }
  }, timeout: const Timeout(Duration(minutes: 3)));

  testWidgets('cloud states are icon-only and successful rooms create safe history', (
    tester,
  ) async {
    _setTestViewSize(tester, const Size(440, 820));
    addTearDown(() => _resetTestViewSize(tester));
    final network = _FakeNetworkStatusSource(false);
    addTearDown(network.close);
    final socket = _ScreenshotSocket();
    final service = SyncPlayService(
      reconnectEnabled: false,
      socketFactory: (_, __) async => socket,
    );
    Get.put(service, permanent: true);

    await tester.pumpWidget(
      _app(SyncPlayPage(networkStatusSource: network)),
    );
    await tester.pumpAndSettle();
    expect(
      find.byKey(const ValueKey('syncplay-cloud-disconnected')),
      findsOneWidget,
    );
    expect(find.text('未连接'), findsNothing);
    final disconnectedSemantics = tester.widget<Semantics>(
      find.byKey(const ValueKey('syncplay-cloud-status')),
    );
    expect(disconnectedSemantics.properties.label, '尚未连接到房间');
    expect(
      tester
          .widget<Icon>(
            find.byKey(const ValueKey('syncplay-cloud-disconnected')),
          )
          .color,
      Colors.white,
    );

    network.emit(true);
    await tester.pump();
    expect(find.byKey(const ValueKey('syncplay-cloud-offline')), findsOneWidget);
    final offlineIcon = tester.widget<Icon>(
      find.byKey(const ValueKey('syncplay-cloud-offline')),
    );
    expect(offlineIcon.icon, Icons.cloud_off);
    expect(
      offlineIcon.color,
      ThemeData.dark(useMaterial3: true).colorScheme.error,
    );
    expect(
      tester
          .widget<Semantics>(find.byKey(const ValueKey('syncplay-cloud-status')))
          .properties
          .label,
      '设备网络不可用',
    );

    network.emit(null);
    await tester.pump();
    expect(find.byKey(const ValueKey('syncplay-cloud-offline')), findsNothing);
    expect(
      tester
          .widget<Icon>(find.byKey(const ValueKey('syncplay-cloud-disconnected')))
          .color,
      Colors.white,
    );

    network.emit(false);
    await tester.pump();
    service.lastErrorCode = 'origin_not_allowed';
    service.notifyListeners();
    await tester.pump();
    expect(find.byKey(const ValueKey('syncplay-cloud-offline')), findsNothing);
    expect(
      tester
          .widget<Icon>(find.byKey(const ValueKey('syncplay-cloud-disconnected')))
          .color,
      Colors.white,
    );
    expect(find.byKey(const ValueKey('syncplay-connection-error')), findsOneWidget);
    service.lastErrorCode = null;
    service.notifyListeners();
    await tester.pump();
    await tester.enterText(
      find.byKey(const ValueKey('syncplay-server-address')),
      'http://insecure.example.test/ws',
    );
    await tester.tap(find.byKey(const ValueKey('syncplay-create-room')));
    await tester.pumpAndSettle();
    expect(find.byKey(const ValueKey('syncplay-connection-error')), findsOneWidget);
    expect(find.byKey(const ValueKey('syncplay-cloud-offline')), findsNothing);
    expect(
      tester
          .widget<Icon>(find.byKey(const ValueKey('syncplay-cloud-disconnected')))
          .color,
      Colors.white,
    );
    expect(
      GStorage.setting.get(SyncPlayPreferenceKeys.connectionHistory),
      isNull,
    );

    await tester.enterText(
      find.byKey(const ValueKey('syncplay-server-address')),
      'sync.example.test:9443/ws',
    );
    await tester.tap(find.byKey(const ValueKey('syncplay-create-room')));
    await tester.pumpAndSettle();
    socket.emit({
      'type': 'room:created',
      'payload': {
        'roomCode': 'ROOM42',
        'memberId': 'render-member',
        'joinToken': 'private-join-token-do-not-store',
        'memberToken': 'private-member-token-do-not-store',
      },
    });
    await tester.pumpAndSettle();
    expect(find.byKey(const ValueKey('syncplay-cloud-connected')), findsOneWidget);
    final connectedIcon = tester.widget<Icon>(
      find.byKey(const ValueKey('syncplay-cloud-connected')),
    );
    expect(connectedIcon.icon, Icons.cloud_done);
    expect(connectedIcon.color, Colors.white);
    expect(find.text('ExPiliPlus'), findsOneWidget);
    expect(find.text('wss://sync.example.test:9443/ws'), findsOneWidget);
    final stored = GStorage.setting.get(
      SyncPlayPreferenceKeys.connectionHistory,
    ) as List;
    expect(stored, hasLength(1));
    expect(jsonEncode(stored), isNot(contains('private-join-token')));
    expect(jsonEncode(stored), isNot(contains('private-member-token')));
    expect(jsonEncode(stored), isNot(contains('ROOM42')));
    expect(tester.takeException(), isNull);
    service.dispose();
    Get.reset();
  }, timeout: const Timeout(Duration(minutes: 3)));

  testWidgets('renders synthetic local history without empty-state placeholder', (
    tester,
  ) async {
    final network = _FakeNetworkStatusSource(false);
    addTearDown(network.close);
    _setTestViewSize(tester, const Size(440, 820));
    addTearDown(() => _resetTestViewSize(tester));
    await tester.pumpWidget(
      _app(SyncPlayPage(networkStatusSource: network)),
    );
    await tester.pumpAndSettle();
    expect(find.byKey(const ValueKey('syncplay-history-time')), findsNothing);
    expect(find.textContaining('syncPlayHistory'), findsNothing);

    final connectedAt = DateTime.now().toUtc().millisecondsSinceEpoch;
    await tester.runAsync(() async {
      await GStorage.setting.put(
        SyncPlayPreferenceKeys.connectionHistory,
        [
          {
            'displayName': '海风房间',
            'serverAddress': 'wss://sync.example.test:9443/ws',
            'connectedAtEpochMs': connectedAt,
          },
        ],
      );
    });
    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pumpWidget(
      _app(SyncPlayPage(networkStatusSource: network)),
    );
    await tester.pumpAndSettle();
    expect(find.text('海风房间'), findsOneWidget);
    expect(find.text('wss://sync.example.test:9443/ws'), findsOneWidget);
    expect(find.byKey(const ValueKey('syncplay-history-time')), findsOneWidget);
    expect(
      tester
          .widget<Text>(find.byKey(const ValueKey('syncplay-history-time')))
          .data,
      matches(RegExp(r'^\d{2}/\d{2}/\d{2} \d{2}:\d{2}$')),
    );
    expect(tester.takeException(), isNull);
    await _saveCapture(tester, 'connection-history-portrait-dark-zh.png');

    _setTestViewSize(tester, const Size(900, 620));
    await tester.pumpAndSettle();
    expect(find.text('海风房间'), findsOneWidget);
    expect(tester.takeException(), isNull);
    await _saveCapture(tester, 'connection-history-landscape-dark-zh.png');
  }, timeout: const Timeout(Duration(minutes: 3)));

  testWidgets(
    'player panel overlays video, adapts orientation, and preserves the room on close',
    (tester) async {
      _setTestViewSize(tester, const Size(420, 900));
      addTearDown(() => _resetTestViewSize(tester));
      final socket = _ScreenshotSocket();
      var socketConnections = 0;
      final service = SyncPlayService(
        reconnectEnabled: false,
        socketFactory: (_, __) async {
          socketConnections++;
          return socket;
        },
      );
      Get.put(service, permanent: true);

      Future<void> openPanel() async {
        await tester.tap(find.text('Open SyncPlay'));
        await tester.pumpAndSettle();
      }

      await tester.pumpWidget(
        _app(
          Scaffold(
            body: Column(
              children: [
                const Expanded(
                  child: ColoredBox(
                    color: Color(0xff151515),
                    child: Center(
                      child: Text(
                        '模拟视频画面',
                        key: ValueKey('syncplay-video-stays-mounted'),
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                Builder(
                  builder: (context) => FilledButton(
                    onPressed: () => showSyncPlayPanel(context),
                    child: const Text('Open SyncPlay'),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      await openPanel();
      expect(
        find.byKey(const ValueKey('syncplay-player-panel')),
        findsOneWidget,
      );
      expect(
        find.byKey(const ValueKey('syncplay-video-stays-mounted')),
        findsOneWidget,
      );
      final portraitSize = MediaQuery.sizeOf(
        tester.element(find.byKey(const ValueKey('syncplay-video-stays-mounted'))),
      );
      final portraitPanelRect = tester.getRect(
        find.byKey(const ValueKey('syncplay-player-panel')),
      );
      expect(portraitSize.height, greaterThan(portraitSize.width));
      expect(portraitPanelRect.width, greaterThan(portraitSize.width * 0.95));
      expect(find.text('房间昵称'), findsOneWidget);
      expect(find.text('邀请代码'), findsOneWidget);
      expect(find.text('创建房间'), findsOneWidget);
      expect(find.text('加入房间'), findsOneWidget);
      expect(tester.takeException(), isNull);
      await _saveCapture(tester, 'player-panel-portrait-dark-zh.png');

      final serverAddressField = tester.widget<TextField>(
        find.byKey(const ValueKey('syncplay-server-address')),
      );
      serverAddressField.controller!.text = 'sync.example.test:9443/ws';
      await tester.tap(find.byKey(const ValueKey('syncplay-advanced-mode')));
      await tester.pumpAndSettle();
      await _saveCapture(tester, 'player-panel-portrait-advanced-dark-zh.png');
      await tester.tap(find.byKey(const ValueKey('syncplay-advanced-mode')));
      await tester.pumpAndSettle();
      _setTestViewSize(tester, const Size(900, 560));
      await tester.pumpAndSettle();
      final landscapeNicknameRect = tester.getRect(
        find.byKey(const ValueKey('syncplay-display-name')),
      );
      final landscapeCreateRect = tester.getRect(
        find.byKey(const ValueKey('syncplay-create-room')),
      );
      final landscapeInviteRect = tester.getRect(
        find.byKey(const ValueKey('syncplay-invite-code')),
      );
      final landscapeJoinRect = tester.getRect(
        find.byKey(const ValueKey('syncplay-join-room')),
      );
      expect(landscapeCreateRect.left, greaterThan(landscapeNicknameRect.right));
      expect(landscapeJoinRect.left, greaterThan(landscapeInviteRect.right));
      expect(tester.takeException(), isNull);
      await _saveCapture(tester, 'player-panel-landscape-form-dark-zh.png');
      await tester.tap(find.text('创建房间'));
      await tester.pumpAndSettle();
      expect(socketConnections, 1);
      socket.emit({
        'type': 'room:created',
        'payload': {
          'roomCode': 'ROOM42',
          'memberId': 'render-member',
          'joinToken': 'render-only-token',
          'memberToken': 'render-member-token',
        },
      });
      await tester.pump();
      socket.emit({
        'type': 'room:state',
        'payload': {
          'roomCode': 'ROOM42',
          'members': [
            {'id': 'render-member', 'name': '测试成员'},
            {'id': 'synthetic-peer', 'name': '虚构成员'},
          ],
        },
      });
      await tester.pumpAndSettle();
      expect(service.credentials?.roomCode, 'ROOM42');
      expect(find.text('测试成员'), findsOneWidget);

      _setTestViewSize(tester, const Size(900, 560));
      await tester.pumpAndSettle();
      final landscapeRect = tester.getRect(
        find.byKey(const ValueKey('syncplay-player-panel')),
      );
      expect(landscapeRect.left, greaterThan(440));
      expect(landscapeRect.right, greaterThan(850));
      expect(
        find.byKey(const ValueKey('syncplay-video-stays-mounted')),
        findsOneWidget,
      );
      expect(find.text('虚构成员'), findsOneWidget);
      await _saveCapture(tester, 'player-panel-landscape-room-dark-zh.png');

      await tester.binding.handlePopRoute();
      await tester.pumpAndSettle();
      expect(
        find.byKey(const ValueKey('syncplay-player-panel')),
        findsNothing,
      );
      expect(
        find.byKey(const ValueKey('syncplay-video-stays-mounted')),
        findsOneWidget,
      );
      expect(Get.find<SyncPlayService>(), same(service));
      expect(service.credentials?.roomCode, 'ROOM42');
      expect(socketConnections, 1);

      await tester.tap(find.text('Open SyncPlay'));
      await tester.pumpAndSettle();
      await tester.tap(find.byTooltip('关闭'));
      await tester.pumpAndSettle();
      expect(
        find.byKey(const ValueKey('syncplay-player-panel')),
        findsNothing,
      );
      expect(Get.find<SyncPlayService>(), same(service));
      expect(service.credentials?.roomCode, 'ROOM42');
      expect(socketConnections, 1);
      service.dispose();
      Get.reset();
    },
    timeout: const Timeout(Duration(minutes: 3)),
  );

  testWidgets('portrait panel stays readable on a narrow phone viewport', (
    tester,
  ) async {
    _setTestViewSize(tester, const Size(360, 800));
    addTearDown(() => _resetTestViewSize(tester));
    final service = SyncPlayService(reconnectEnabled: false);
    Get.put(service, permanent: true);
    late BuildContext playerContext;

    await tester.pumpWidget(
      _app(
        Scaffold(
          body: Stack(
            children: [
              const Positioned.fill(
                child: ColoredBox(
                  color: Color(0xff151515),
                  child: Center(child: Text('模拟视频')),
                ),
              ),
              Builder(
                builder: (context) {
                  playerContext = context;
                  return Align(
                    alignment: Alignment.bottomCenter,
                    child: FilledButton(
                      onPressed: () => showSyncPlayPanel(playerContext),
                      child: const Text('Open SyncPlay'),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('Open SyncPlay'));
    await tester.pumpAndSettle();

    final viewport = MediaQuery.sizeOf(tester.element(find.text('模拟视频')));
    final panel = tester.getRect(
      find.byKey(const ValueKey('syncplay-player-panel')),
    );
    expect(viewport, const Size(360, 800));
    expect(panel.width, greaterThan(viewport.width * 0.95));
    expect(find.text('房间昵称'), findsOneWidget);
    expect(find.text('邀请代码'), findsOneWidget);
    expect(find.text('创建房间'), findsOneWidget);
    expect(find.text('加入房间'), findsOneWidget);
    expect(tester.takeException(), isNull);
    await _saveCapture(tester, 'player-panel-narrow-portrait-dark-zh.png');

    await tester.tap(find.byTooltip('关闭'));
    await tester.pumpAndSettle();
    service.dispose();
    Get.reset();
  }, timeout: const Timeout(Duration(minutes: 3)));

  testWidgets('playback menu SyncPlay action opens the same player overlay', (
    tester,
  ) async {
    _setTestViewSize(tester, const Size(420, 900));
    addTearDown(() => _resetTestViewSize(tester));
    final service = SyncPlayService(reconnectEnabled: false);
    Get.put(service, permanent: true);
    final launcher = SyncPlayPanelLauncher();
    late BuildContext playerContext;

    await tester.pumpWidget(
      _app(
        Scaffold(
          body: Stack(
            children: [
              const Positioned.fill(
                child: ColoredBox(
                  color: Color(0xff151515),
                  child: Center(
                    child: Text(
                      '模拟视频画面',
                      key: ValueKey('syncplay-video-stays-mounted'),
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              Builder(
                builder: (context) {
                  playerContext = context;
                  return Align(
                    alignment: Alignment.bottomCenter,
                    child: FilledButton(
                      onPressed: () {
                        unawaited(
                          showModalBottomSheet<void>(
                            context: playerContext,
                            builder: (menuContext) => SafeArea(
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(16, 18, 16, 24),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: TextButton(
                                        onPressed: () =>
                                            Navigator.of(menuContext).pop(),
                                        child: const Text('编辑快捷操作'),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: SyncPlayPlayerMenuAction(
                                            title: 'Bili-SyncPlay',
                                            icon: Icons.groups_2_outlined,
                                            iconSize: 28,
                                            labelFontSize: 13,
                                            onPressed: () => unawaited(
                                              launcher.openFromPlayerMenu(
                                                playerContext: playerContext,
                                                closeMenu: () =>
                                                    Navigator.of(menuContext)
                                                        .pop(),
                                                panelTheme: Theme.of(
                                                  playerContext,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      child: const Text('播放页菜单'),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('播放页菜单'));
    await tester.pumpAndSettle();
    expect(
      find.byKey(const ValueKey('syncplay-player-menu-button')),
      findsOneWidget,
    );
    expect(
      find.byKey(const ValueKey('syncplay-player-menu-label')),
      findsOneWidget,
    );
    expect(find.text('Bili-SyncPlay'), findsOneWidget);
    await _saveCapture(tester, 'playback-menu-syncplay-dark-zh.png');

    await tester.tap(find.byKey(const ValueKey('syncplay-player-menu-button')));
    await tester.pumpAndSettle();
    expect(find.byKey(const ValueKey('syncplay-player-panel')), findsOneWidget);
    expect(
      find.byKey(const ValueKey('syncplay-video-stays-mounted')),
      findsOneWidget,
    );
    expect(launcher.isOpening, isTrue);
    await tester.tap(find.byTooltip('关闭'));
    await tester.pumpAndSettle();
    expect(find.byKey(const ValueKey('syncplay-player-panel')), findsNothing);
    expect(launcher.isOpening, isFalse);
    expect(Get.find<SyncPlayService>(), same(service));

    service.dispose();
    Get.reset();
  }, timeout: const Timeout(Duration(minutes: 3)));

  testWidgets('shows a clear error for an explicitly insecure public address', (
    tester,
  ) async {
    _setTestViewSize(tester, const Size(440, 820));
    addTearDown(() => _resetTestViewSize(tester));
    var socketAttempts = 0;
    final service = SyncPlayService(
      reconnectEnabled: false,
      socketFactory: (_, __) async {
        socketAttempts++;
        throw StateError('Should not attempt an insecure public endpoint');
      },
    );
    Get.put(service, permanent: true);

    await tester.pumpWidget(_app(const SyncPlayPage()));
    await tester.pumpAndSettle();
    await tester.enterText(
      find.byKey(const ValueKey('syncplay-server-address')),
      'ws://sync.example.test',
    );
    await tester.tap(find.text('创建房间'));
    await tester.pumpAndSettle();

    expect(socketAttempts, 0);
    expect(find.byKey(const ValueKey('syncplay-connection-error')), findsOneWidget);
    expect(find.textContaining('wss://'), findsOneWidget);
    service.dispose();
    Get.reset();
  }, timeout: const Timeout(Duration(minutes: 3)));
}
