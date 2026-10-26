import 'package:ex_piliplus/l10n/generated/app_localizations.dart';
import 'package:ex_piliplus/pages/video/widgets/shutdown_timer_indicators.dart';
import 'package:ex_piliplus/services/shutdown_timer_snapshot.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart' as mui show CircularProgressIndicator;

void main() {
  testWidgets('quick timer indicator reacts to updates', (tester) async {
    final now = DateTime.utc(2026, 10, 26, 12);
    final countdown = ValueNotifier(
      ShutdownTimerSnapshot(
        updatedAt: now,
        deadline: now.add(const Duration(minutes: 5)),
        totalDuration: const Duration(minutes: 10),
      ),
    );

    Future<void> pumpIndicator(ThemeData theme, Locale locale) {
      return tester.pumpWidget(
        MaterialApp(
          locale: locale,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          theme: theme,
          home: Scaffold(
            body: Center(
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
      );
    }

    final theme = ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
    );
    await pumpIndicator(theme, const Locale('zh'));

    expect(find.text('还剩 5分钟'), findsOneWidget);
    var ring = tester.widget<mui.CircularProgressIndicator>(
      find.byType(mui.CircularProgressIndicator),
    );
    expect(ring.value, 0.5);
    expect(ring.color, theme.colorScheme.primary);

    final updatedTheme = ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
    );
    await pumpIndicator(updatedTheme, const Locale('zh'));
    ring = tester.widget<mui.CircularProgressIndicator>(
      find.byType(mui.CircularProgressIndicator),
    );
    expect(ring.color, updatedTheme.colorScheme.primary);

    countdown.value = ShutdownTimerSnapshot(
      updatedAt: now,
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

    countdown.value = ShutdownTimerSnapshot(updatedAt: now);
    await tester.pump();

    expect(find.text('Sleep timer'), findsOneWidget);
    expect(find.byType(mui.CircularProgressIndicator), findsNothing);

    await tester.pumpWidget(const SizedBox.shrink());
    countdown.dispose();
  });
}
