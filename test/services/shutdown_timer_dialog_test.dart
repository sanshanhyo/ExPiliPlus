import 'package:ex_piliplus/l10n/generated/app_localizations.dart';
import 'package:ex_piliplus/services/shutdown_timer_service.dart';
import 'package:ex_piliplus/services/shutdown_timer_snapshot.dart';
import 'package:flutter/foundation.dart' show ValueListenable, ValueNotifier;
import 'package:flutter/widgets.dart' show Locale;
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:material_ui/material_ui.dart' as mui;

void main() {
  late _FakeShutdownTimerControls controller;

  setUp(() {
    controller = _FakeShutdownTimerControls();
  });

  tearDown(() {
    controller.dispose();
    Get.reset();
  });

  testWidgets('preset selection schedules and closes the panel', (tester) async {
    final l10n = await AppLocalizations.delegate.load(const Locale('zh'));
    await _openTimerDialog(tester, controller);

    await tester.tap(find.text(l10n.shutdownMinutes(30)));
    await tester.pumpAndSettle();

    expect(controller.scheduledMinutes, [30]);
    expect(find.text('定时关闭'), findsNothing);
  });

  testWidgets('custom picker confirmation uses its selected duration', (
    tester,
  ) async {
    controller.durationInMinutes = 75;
    await _openTimerDialog(tester, controller);

    await tester.ensureVisible(find.text('自定义'));
    await tester.tap(find.text('自定义'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('确认'));
    await tester.pumpAndSettle();

    expect(controller.scheduledMinutes, [75]);
    expect(controller.refreshCount, 1);
  });

  testWidgets('wait and shutdown action selections update the controller', (
    tester,
  ) async {
    final l10n = await AppLocalizations.delegate.load(const Locale('zh'));
    await _openTimerDialog(tester, controller);

    await tester.ensureVisible(find.text(l10n.shutdownWaitUntilVideoEnds));
    await tester.tap(find.text(l10n.shutdownWaitUntilVideoEnds));
    await tester.pump();
    expect(controller.waitUntilCompleted, isTrue);

    final exitAction = find.byWidgetPredicate(
      (widget) =>
          widget is mui.Text && widget.data?.trim() == l10n.shutdownExitApp,
    );
    await tester.ensureVisible(exitAction);
    await tester.tap(exitAction);
    await tester.pump();
    expect(controller.shutdownAction, ShutdownTimerAction.exit);
  });

  testWidgets('custom picker and panel cancellation do not schedule', (
    tester,
  ) async {
    await _openTimerDialog(tester, controller);

    await tester.ensureVisible(find.text('自定义'));
    await tester.tap(find.text('自定义'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('取消'));
    await tester.pumpAndSettle();
    expect(controller.scheduledMinutes, isEmpty);

    await tester.pageBack();
    await tester.pumpAndSettle();
    expect(controller.scheduledMinutes, isEmpty);
  });

  testWidgets('live timer clears wait and hides the wait option', (
    tester,
  ) async {
    final l10n = await AppLocalizations.delegate.load(const Locale('zh'));
    controller.waitUntilCompleted = true;
    await _openTimerDialog(tester, controller, isLive: true);

    expect(controller.waitUntilCompleted, isFalse);
    expect(find.text(l10n.shutdownWaitUntilVideoEnds), findsNothing);
  });
}

Future<void> _openTimerDialog(
  WidgetTester tester,
  _FakeShutdownTimerControls controller, {
  bool isLive = false,
}) async {
  await tester.pumpWidget(
    GetMaterialApp(
      locale: const Locale('zh'),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: mui.Theme(
        data: mui.ThemeData(
          colorScheme: mui.ColorScheme.fromSeed(seedColor: mui.Colors.teal),
        ),
        child: Builder(
          builder: (context) => mui.Scaffold(
            body: mui.Center(
              child: mui.TextButton(
                onPressed: () => controller.showScheduleExitDialog(
                  context,
                  isFullScreen: false,
                  isLive: isLive,
                ),
                child: const mui.Text('open timer'),
              ),
            ),
          ),
        ),
      ),
    ),
  );

  await tester.tap(find.text('open timer'));
  await tester.pumpAndSettle();
}

class _FakeShutdownTimerControls
    implements ShutdownTimerControls {
  final ValueNotifier<ShutdownTimerSnapshot> _countdown = ValueNotifier(
    ShutdownTimerSnapshot(
      updatedAt: DateTime.utc(2026, 10, 26),
      isTimerActive: false,
    ),
  );

  @override
  ValueListenable<ShutdownTimerSnapshot> get countdown => _countdown;

  @override
  int durationInMinutes = 0;

  @override
  bool waitUntilCompleted = false;

  @override
  ShutdownTimerAction shutdownAction = ShutdownTimerAction.pause;

  final List<int> scheduledMinutes = [];
  int refreshCount = 0;

  @override
  void schedule(int durationInMinutes) {
    this.durationInMinutes = durationInMinutes;
    scheduledMinutes.add(durationInMinutes);
  }

  @override
  void setWaitUntilCompleted(bool value) => waitUntilCompleted = value;

  @override
  void setShutdownAction(ShutdownTimerAction value) => shutdownAction = value;

  @override
  void refreshCountdown() => refreshCount++;

  void dispose() => _countdown.dispose();
}
