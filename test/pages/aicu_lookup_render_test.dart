import 'dart:io';
import 'dart:ui' as ui;

import 'package:ex_piliplus/grpc/bilibili/main/community/reply/v1.pb.dart'
    show Content, ReplyInfo;
import 'package:ex_piliplus/l10n/app_localization_delegates.dart';
import 'package:ex_piliplus/l10n/generated/app_localizations.dart';
import 'package:ex_piliplus/models/common/aicu_probe_status.dart';
import 'package:ex_piliplus/pages/aicu_lookup/view.dart';
import 'package:ex_piliplus/pages/setting/models/ex_features_settings.dart';
import 'package:ex_piliplus/pages/video/reply/widgets/reply_item_grpc.dart';
import 'package:ex_piliplus/services/aicu_probe_service.dart';
import 'package:ex_piliplus/models/common/account_type.dart';
import 'package:ex_piliplus/utils/accounts.dart';
import 'package:ex_piliplus/utils/accounts/account.dart';
import 'package:ex_piliplus/utils/aicu_url_policy.dart';
import 'package:ex_piliplus/utils/storage.dart';
import 'package:ex_piliplus/utils/storage_key.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fixnum/fixnum.dart';
import 'package:get/get.dart';
import 'package:hive_ce/hive.dart';
import 'package:material_ui/material_ui.dart';

import '../support/render_test_fonts.dart';

const _captureKey = ValueKey('aicu-capture');

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
    final removed = _values.length;
    _values.clear();
    return removed;
  }

  void reset() => _values.clear();

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

Future<void> _saveCapture(WidgetTester tester, String filename) async {
  final boundary = tester.renderObject<RenderRepaintBoundary>(
    find.byKey(_captureKey),
  );
  await tester.runAsync(() async {
    final image = await boundary.toImage(pixelRatio: 2);
    try {
      final data = await image.toByteData(format: ui.ImageByteFormat.png);
      final file = File('build/test-artifacts/aicu/$filename');
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
  final settingBox = _MemoryBox();
  final localCacheBox = _MemoryBox();

  setUpAll(() async {
    await loadRenderTestFonts();
    GStorage.setting = settingBox;
    GStorage.localCache = localCacheBox;
    GStorage.reply = null;
  });

  setUp(() {
    settingBox.reset();
    localCacheBox.reset();
    AicuProbeService.instance.status.value = AicuProbeStatus.notChecked;
  });

  tearDown(() {
    Accounts.accountMode[AccountType.main.index] = AnonymousAccount();
  });

  testWidgets('shows the AICU action as a production comment-menu row', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(420, 720));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    const syntheticAuthorUid = 987654321012345;
    final reply = ReplyInfo(
      id: Int64(9001),
      oid: Int64(5001),
      type: Int64(1),
      mid: Int64(syntheticAuthorUid),
      content: Content(message: '只用于菜单渲染的虚构评论'),
    );
    final replyWidget = ReplyItemGrpc(
      replyItem: reply,
      replyLevel: 1,
      upMid: Int64(1001),
    );
    // This in-memory synthetic account only selects the same report row shown
    // to signed-in users; it is never persisted or used for network requests.
    Accounts.accountMode[AccountType.main.index] = LoginAccount(
      BiliCookieJar.fromJson({'DedeUserID': '123456789', 'bili_jct': 'test'}),
      null,
      null,
    );
    await tester.pumpWidget(
      _app(
        Scaffold(
          body: Center(
            child: Builder(
              builder: (context) => GestureDetector(
                onLongPress: () => showModalBottomSheet<void>(
                  context: context,
                  useSafeArea: true,
                  isScrollControlled: true,
                  builder: (sheetContext) => Material(
                    child: replyWidget.morePanel(
                      context: sheetContext,
                      item: reply,
                      onDelete: () {},
                      isSubReply: false,
                    ),
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(24),
                  child: Text('长按虚构评论打开菜单'),
                ),
              ),
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    await tester.longPress(find.text('长按虚构评论打开菜单'));
    await tester.pumpAndSettle();

    expect(find.text('在 AICU 中查询'), findsOneWidget);
    expect(find.text('举报'), findsOneWidget);
    expect(find.text('复制全部'), findsOneWidget);
    await _saveCapture(tester, 'comment-menu-dark.png');
    await tester.tap(find.text('在 AICU 中查询'));
    await tester.pumpAndSettle();
    expect(find.text('AICU 评论查询'), findsOneWidget);
    expect(find.text('此平台不支持应用内网页，请选择外部浏览器打开。'), findsOneWidget);
  }, timeout: const Timeout(Duration(minutes: 3)));

  testWidgets('settings starts enabled and exposes a manual probe status', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(440, 260));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(
      _app(
        Builder(
          builder: (context) => Scaffold(
            body: ListView(
              children: exFeatureSettings(context)
                  .take(2)
                  .map((setting) => setting.widget)
                  .toList(),
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    final toggle = tester.widget<Switch>(find.byType(Switch));
    expect(toggle.value, isTrue);
    expect(find.text('AICU 服务状态'), findsOneWidget);
    expect(find.text('尚未检测，点击检测'), findsOneWidget);
    await _saveCapture(tester, 'settings-status-dark.png');
    await tester.tap(find.text('启用 AICU 评论查询'));
    await tester.pumpAndSettle();
    expect(
      GStorage.setting.get(SettingBoxKey.enableAicuCommentLookup),
      isFalse,
    );
  }, timeout: const Timeout(Duration(minutes: 3)));

  testWidgets('renders the in-app page shell without a UID or network request', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(420, 720));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(
      _app(
        AicuLookupPage(
          initialUri: Uri.https(AicuUrlPolicy.host, '/reply'),
          contentBuilder: (context, uri) => ColoredBox(
            color: Theme.of(context).colorScheme.surface,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.chat_bubble_outline,
                    size: 38,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(height: 12),
                  const Text('AICU 页面内容预览'),
                  const SizedBox(height: 4),
                  Text(uri.path),
                  const SizedBox(height: 8),
                  const Text('演示内容；未查询 UID，也未发起网络请求'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('AICU 评论查询'), findsOneWidget);
    expect(find.textContaining('第三方网站页面'), findsOneWidget);
    expect(find.text('AICU 页面内容预览'), findsOneWidget);
    expect(find.text('/reply'), findsOneWidget);
    await _saveCapture(tester, 'lookup-page-shell-dark.png');
  }, timeout: const Timeout(Duration(minutes: 3)));
}
