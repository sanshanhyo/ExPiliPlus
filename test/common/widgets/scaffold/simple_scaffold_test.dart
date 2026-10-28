import 'package:ex_piliplus/common/widgets/scaffold/simple_scaffold.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Future<void> pumpScaffold(
    WidgetTester tester,
    ThemeData theme, {
    Color? backgroundColor,
  }) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: theme,
        themeAnimationDuration: Duration.zero,
        home: SimpleScaffold(
          backgroundColor: backgroundColor,
          appBar: const SizedBox(height: 56),
          body: const SizedBox.expand(key: ValueKey('body')),
          fab: const SizedBox.square(dimension: 48, key: ValueKey('fab')),
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  Color paintedBackground(WidgetTester tester) => tester
      .widget<PhysicalModel>(
        find.descendant(
          of: find.byType(SimpleScaffold),
          matching: find.byType(PhysicalModel),
        ),
      )
      .color;

  testWidgets('background follows Flutter light, dark and runtime changes', (
    tester,
  ) async {
    for (final theme in [
      ThemeData.light(),
      ThemeData.dark(),
      ThemeData.light(),
    ]) {
      await pumpScaffold(tester, theme);
      expect(paintedBackground(tester), theme.scaffoldBackgroundColor);
      expect(tester.getTopLeft(find.byKey(const ValueKey('body'))).dy, 56);
      final fab = tester.getRect(find.byKey(const ValueKey('fab')));
      final scaffold = tester.getRect(find.byType(SimpleScaffold));
      expect(fab.bottomRight, scaffold.bottomRight);
      expect(tester.takeException(), isNull);
    }
  });

  testWidgets('explicit background takes priority over the current theme', (
    tester,
  ) async {
    const background = Color(0xFF123456);
    for (final theme in [ThemeData.light(), ThemeData.dark()]) {
      await pumpScaffold(tester, theme, backgroundColor: background);
      expect(paintedBackground(tester), background);
    }
  });

  testWidgets('pure black scaffold setting takes priority over canvas color', (
    tester,
  ) async {
    final theme = ThemeData.dark().copyWith(
      scaffoldBackgroundColor: Colors.black,
      canvasColor: const Color(0xFF242424),
    );
    await pumpScaffold(tester, theme);
    expect(paintedBackground(tester), Colors.black);
    expect(paintedBackground(tester), isNot(theme.canvasColor));
  });
}
