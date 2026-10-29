import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:ui' as ui;

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
    await tester.binding.setSurfaceSize(const Size(440, 820));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    final service = SyncPlayService(reconnectEnabled: false);
    Get.put(service, permanent: true);

    await tester.pumpWidget(_app(const SyncPlayPage()));
    await tester.pumpAndSettle();

    expect(find.text('Bili-SyncPlay'), findsOneWidget);
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
    await _saveCapture(tester, 'connection-form-dark-zh.png');
    service.dispose();
    Get.reset();
  }, timeout: const Timeout(Duration(minutes: 3)));

  testWidgets('renders an active room and shared public-video card', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(440, 900));
    addTearDown(() => tester.binding.setSurfaceSize(null));
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

  testWidgets(
    'player panel overlays video, adapts orientation, and preserves the room on close',
    (tester) async {
      await tester.binding.setSurfaceSize(const Size(440, 820));
      addTearDown(() => tester.binding.setSurfaceSize(null));
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
      await _saveCapture(tester, 'player-panel-portrait-dark-zh.png');

      final serverAddressField = tester.widget<TextField>(
        find.byKey(const ValueKey('syncplay-server-address')),
      );
      serverAddressField.controller!.text = 'sync.example.test:9443/ws';
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

      await tester.binding.setSurfaceSize(const Size(900, 560));
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

  testWidgets('shows a clear error for an explicitly insecure public address', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(440, 820));
    addTearDown(() => tester.binding.setSurfaceSize(null));
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
