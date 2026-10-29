import 'dart:io';
import 'dart:ui' as ui;

import 'package:ex_piliplus/grpc/bilibili/main/community/reply/v1.pb.dart';
import 'package:ex_piliplus/l10n/app_localization_delegates.dart';
import 'package:ex_piliplus/l10n/generated/app_localizations.dart';
import 'package:ex_piliplus/models/common/comment_plus_one_mode.dart';
import 'package:ex_piliplus/pages/setting/models/ex_features_settings.dart';
import 'package:ex_piliplus/pages/setting/pages/comment_plus_one_uploader_list.dart';
import 'package:ex_piliplus/pages/video/reply/widgets/reply_item_grpc.dart';
import 'package:ex_piliplus/utils/extension/l10n_ext.dart';
import 'package:ex_piliplus/utils/storage.dart';
import 'package:ex_piliplus/utils/storage_key.dart';
import 'package:ex_piliplus/utils/storage_pref.dart';
import 'package:fixnum/fixnum.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:hive_ce/hive.dart';
import 'package:material_ui/material_ui.dart';

import '../../../support/render_test_fonts.dart';

const _captureKey = ValueKey('comment-plus-one-capture');

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
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

Future<void> _saveRenderedCapture(WidgetTester tester, String filename) async {
  final boundary = tester.renderObject<RenderRepaintBoundary>(
    find.byKey(_captureKey),
  );
  await tester.runAsync(() async {
    final image = await boundary.toImage(pixelRatio: 2);
    try {
      final data = await image.toByteData(format: ui.ImageByteFormat.png);
      final file = File('build/test-artifacts/comment-plus-one/$filename');
      await file.parent.create(recursive: true);
      await file.writeAsBytes(data!.buffer.asUint8List());
    } finally {
      image.dispose();
    }
  });
}

Widget _capture(Widget child) {
  final theme = ThemeData.dark();
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
  setUpAll(() async {
    await loadRenderTestFonts();
    GStorage.setting = _MemoryBox();
    GStorage.localCache = _MemoryBox();
  });

  testWidgets('renders +1 after Reply and before existing reaction actions', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(420, 160));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await Pref.setCommentPlusOneMode(CommentPlusOneMode.allVideos);

    final reply = ReplyInfo(
      id: Int64(123),
      oid: Int64(456),
      type: Int64(1),
      content: Content(message: 'A visible original comment'),
    );
    await tester.pumpWidget(
      _capture(
        Scaffold(
          body: Center(
            child: SizedBox(
              width: 410,
              child: Builder(
                builder: (context) => ReplyItemGrpc(
                  replyItem: reply,
                  replyLevel: 1,
                  upMid: Int64(1001),
                  onReply: (_) {},
                  onCommentPlusOne: (_) async {},
                ).buttonAction(
                  context,
                  Theme.of(context).colorScheme,
                  ReplyControl(),
                ),
              ),
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('回复'), findsOneWidget);
    expect(find.text('+1'), findsOneWidget);
    final replyTextRect = tester.getRect(find.text('回复'));
    final plusOneButtonFinder = find.ancestor(
      of: find.text('+1'),
      matching: find.byType(TextButton),
    );
    final plusOneButton = tester.widget<TextButton>(plusOneButtonFinder);
    final plusOneButtonRect = tester.getRect(plusOneButtonFinder);
    expect(
      plusOneButton.style?.backgroundColor?.resolve(const <WidgetState>{}),
      Colors.transparent,
    );
    expect(
      plusOneButtonRect.left - replyTextRect.right,
      closeTo(6, 0.5),
    );
    expect(plusOneButtonRect.height, 32);
    await _saveRenderedCapture(tester, 'reply-actions-dark.png');
  }, timeout: const Timeout(Duration(minutes: 3)));

  testWidgets('renders the production +1 mode row and all three choices', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(420, 360));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await Pref.setCommentPlusOneMode(CommentPlusOneMode.disabled);

    await tester.pumpWidget(
      _capture(
        Builder(
          builder: (context) {
            final l10n = context.l10n;
            final model = exFeatureSettings(context).singleWhere(
              (setting) =>
                  setting.effectiveTitle == l10n.settingsCommentPlusOneMode,
            );
            return Scaffold(body: ListView(children: [model.widget]));
          },
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('评论 +1'), findsOneWidget);
    await _saveRenderedCapture(tester, 'settings-mode-off-dark.png');

    await tester.tap(find.text('评论 +1'));
    await tester.pumpAndSettle();
    expect(find.text('全部视频开启'), findsOneWidget);
    expect(find.text('指定 UP 主开启'), findsOneWidget);
    expect(find.text('关闭'), findsOneWidget);
    await _saveRenderedCapture(tester, 'settings-mode-choices-dark.png');

    await tester.tap(find.text('指定 UP 主开启'));
    await tester.pumpAndSettle();
    expect(Pref.commentPlusOneMode, CommentPlusOneMode.selectedUploaders);
  }, timeout: const Timeout(Duration(minutes: 3)));

  testWidgets('renders uploader allow-list without touching block lists', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(420, 360));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await GStorage.localCache.put(
      LocalCacheKey.commentPlusOneUpMids,
      [1001, 2002],
    );
    await GStorage.localCache.put(LocalCacheKey.blackMids, <int>{9999});

    await tester.pumpWidget(_capture(const CommentPlusOneUploaderListPage()));
    await tester.pumpAndSettle();

    expect(find.text('1001'), findsOneWidget);
    expect(find.text('2002'), findsOneWidget);
    expect(Pref.commentPlusOneUpMids, {1001, 2002});
    expect(GStorage.localCache.get(LocalCacheKey.blackMids), {9999});
    await _saveRenderedCapture(tester, 'settings-uploader-list-dark.png');

    await tester.tap(find.byTooltip('添加 UP 主'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), '3003');
    await tester.tap(find.text('确定'));
    await tester.pumpAndSettle();
    expect(Pref.commentPlusOneUpMids, {1001, 2002, 3003});
    expect(GStorage.localCache.get(LocalCacheKey.blackMids), {9999});
  }, timeout: const Timeout(Duration(minutes: 3)));

  testWidgets('unsupported media stays visible but cannot be sent', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(420, 160));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await Pref.setCommentPlusOneMode(CommentPlusOneMode.allVideos);

    final reply = ReplyInfo(
      id: Int64(123),
      oid: Int64(456),
      type: Int64(1),
      content: Content(message: 'photo comment', pictures: [Picture()]),
    );
    var sendCount = 0;
    await tester.pumpWidget(
      _capture(
        Scaffold(
          body: Center(
            child: SizedBox(
              width: 410,
              child: Builder(
                builder: (context) => ReplyItemGrpc(
                  replyItem: reply,
                  replyLevel: 1,
                  upMid: Int64(1001),
                  onReply: (_) {},
                  onCommentPlusOne: (_) async {
                    sendCount++;
                  },
                ).buttonAction(
                  context,
                  Theme.of(context).colorScheme,
                  ReplyControl(),
                ),
              ),
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    final button = tester.widget<TextButton>(
      find.ancestor(of: find.text('+1'), matching: find.byType(TextButton)),
    );
    expect(button.onPressed, isNull);
    await tester.tap(find.text('+1'));
    await tester.pumpAndSettle();
    expect(sendCount, 0);
  }, timeout: const Timeout(Duration(minutes: 3)));
}
