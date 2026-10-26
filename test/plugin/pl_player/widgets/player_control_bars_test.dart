import 'package:ex_piliplus/plugin/pl_player/widgets/app_bar_ani.dart';
import 'package:flutter/foundation.dart' show ValueKey;
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart' as mui;

void main() {
  testWidgets('player bars stay layout-safe in a compact video header', (
    tester,
  ) async {
    const playerBounds = ValueKey('player-bounds');
    const topBar = ValueKey('top-bar');
    const bottomBar = ValueKey('bottom-bar');

    await tester.pumpWidget(
      mui.MaterialApp(
        home: mui.Center(
          child: mui.ClipRect(
            child: mui.SizedBox(
              key: playerBounds,
              width: 320,
              height: 58,
              child: PlayerControlBars(
                top: const mui.SizedBox(
                  key: topBar,
                  height: 56,
                  child: mui.ColoredBox(color: mui.Colors.black),
                ),
                bottom: const mui.SizedBox(
                  key: bottomBar,
                  height: 70,
                  child: mui.ColoredBox(color: mui.Colors.blue),
                ),
              ),
            ),
          ),
        ),
      ),
    );

    expect(find.byKey(topBar), findsOneWidget);
    expect(find.byKey(bottomBar), findsOneWidget);
    expect(tester.getSize(find.byKey(playerBounds)).height, 58);
    expect(tester.takeException(), isNull);
  });
}
