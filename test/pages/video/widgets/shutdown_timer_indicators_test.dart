import 'package:ex_piliplus/l10n/generated/app_localizations.dart';
import 'package:ex_piliplus/pages/video/widgets/shutdown_timer_indicators.dart';
import 'package:ex_piliplus/services/shutdown_timer_snapshot.dart';
import 'package:flutter/foundation.dart' show ValueNotifier;
import 'package:flutter/material.dart' show MaterialApp, Locale, SizedBox;
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart' as mui;

void main() {
  testWidgets('quick timer indicator reacts to updates', (tester) async {
    final now = DateTime.utc(2026, 10, 26, 12);
    final countdown = ValueNotifier(
      ShutdownTimerSnapshot(
        updatedAt: now,
        isTimerActive: true,
        deadline: now.add(const Duration(minutes: 5)),
        totalDuration: const Duration(minutes: 10),
      ),
    );

    Future<void> pumpIndicator(mui.ThemeData theme, Locale locale) {
      return tester.pumpWidget(
        MaterialApp(
          locale: locale,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: mui.Theme(
            data: theme,
            child: mui.Scaffold(
              body: mui.Center(
                child: ShutdownTimerQuickActionContent(
                  countdown: countdown,
                  idleLabel: 'Sleep timer',
                  iconSize: 32,
                  labelFontSize: 14,
                  onPressed: () {},
                ),
              ),
            ),
          ),
        ),
      );
    }

    final theme = mui.ThemeData(
      colorScheme: mui.ColorScheme.fromSeed(seedColor: mui.Colors.teal),
    );
    await pumpIndicator(theme, const Locale('zh'));

    expect(find.text('还剩 5分钟'), findsOneWidget);
    var ring = tester.widget<mui.CircularProgressIndicator>(
      find.byType(mui.CircularProgressIndicator),
    );
    expect(ring.value, 0.5);
    expect(ring.color, theme.colorScheme.primary);

    final updatedTheme = mui.ThemeData(
      colorScheme: mui.ColorScheme.fromSeed(seedColor: mui.Colors.deepPurple),
    );
    await pumpIndicator(updatedTheme, const Locale('zh'));
    ring = tester.widget<mui.CircularProgressIndicator>(
      find.byType(mui.CircularProgressIndicator),
    );
    expect(ring.color, updatedTheme.colorScheme.primary);

    countdown.value = ShutdownTimerSnapshot(
      updatedAt: now,
      isTimerActive: true,
      deadline: now.add(const Duration(minutes: 3)),
      totalDuration: const Duration(minutes: 12),
    );
    await tester.pump();

    expect(find.text('还剩 3分钟'), findsOneWidget);
    ring = tester.widget<mui.CircularProgressIndicator>(
      find.byType(mui.CircularProgressIndicator),
    );
    expect(ring.value, 0.25);

    await pumpIndicator(updatedTheme, const Locale('en'));
    expect(find.text('3 min remaining'), findsOneWidget);

    countdown.value = ShutdownTimerSnapshot(
      updatedAt: now.subtract(const Duration(minutes: 45)),
      isTimerActive: false,
      deadline: now.add(const Duration(minutes: 15)),
      totalDuration: const Duration(minutes: 15),
    );
    await tester.pump();

    expect(find.text('Sleep timer'), findsOneWidget);
    expect(find.byType(mui.CircularProgressIndicator), findsNothing);

    await tester.pumpWidget(const SizedBox.shrink());
    countdown.dispose();
  });

  testWidgets('outside timer row shows a gray remaining subtitle', (
    tester,
  ) async {
    final now = DateTime.utc(2026, 10, 26, 12);
    final countdown = ValueNotifier(
      ShutdownTimerSnapshot(
        updatedAt: now,
        isTimerActive: true,
        deadline: now.add(const Duration(minutes: 5)),
        totalDuration: const Duration(minutes: 10),
      ),
    );
    final theme = mui.ThemeData(
      colorScheme: mui.ColorScheme.fromSeed(seedColor: mui.Colors.teal),
    );

    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('zh'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: mui.Theme(
          data: theme,
          child: mui.Scaffold(
            body: ShutdownTimerListTile(
              countdown: countdown,
              title: '定时关闭',
              titleStyle: theme.textTheme.bodyLarge,
              onTap: () {},
            ),
          ),
        ),
      ),
    );

    var tile = tester.widget<mui.ListTile>(find.byType(mui.ListTile));
    final subtitle = tile.subtitle! as mui.Text;
    expect(subtitle.data, '还剩 5分钟');
    expect(subtitle.style?.color, theme.colorScheme.outline);

    countdown.value = ShutdownTimerSnapshot(
      updatedAt: now,
      isTimerActive: false,
    );
    await tester.pump();

    tile = tester.widget<mui.ListTile>(find.byType(mui.ListTile));
    expect(tile.subtitle, isNull);

    await tester.pumpWidget(const SizedBox.shrink());
    countdown.dispose();
  });
}
