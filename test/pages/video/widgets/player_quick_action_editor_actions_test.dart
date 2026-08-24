import 'package:ex_piliplus/pages/video/widgets/player_quick_action_editor_actions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('places restore left and cancel/save right', (tester) async {
    var restoreCount = 0;
    var cancelCount = 0;
    var saveCount = 0;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: PlayerQuickActionEditorActions(
            restoreDefaultTooltip: 'Restore defaults',
            cancelLabel: 'Cancel',
            saveLabel: 'Save',
            onRestoreDefault: () => restoreCount++,
            onCancel: () => cancelCount++,
            onSave: () => saveCount++,
            saveEnabled: true,
          ),
        ),
      ),
    );

    final restore = tester.getTopLeft(
      find.byKey(const ValueKey('player-quick-actions-restore-default')),
    );
    final cancel = tester.getTopLeft(
      find.byKey(const ValueKey('player-quick-actions-cancel')),
    );
    final save = tester.getTopLeft(
      find.byKey(const ValueKey('player-quick-actions-save')),
    );

    expect(restore.dx, lessThan(cancel.dx));
    expect(cancel.dx, lessThan(save.dx));
    expect(find.text('Cancel'), findsOneWidget);
    expect(find.text('Save'), findsOneWidget);

    await tester.tap(
      find.byKey(const ValueKey('player-quick-actions-restore-default')),
    );
    await tester.tap(find.byKey(const ValueKey('player-quick-actions-cancel')));
    await tester.tap(find.byKey(const ValueKey('player-quick-actions-save')));

    expect(restoreCount, 1);
    expect(cancelCount, 1);
    expect(saveCount, 1);
  });

  testWidgets('disables save when there is no selection', (tester) async {
    var saveCount = 0;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: PlayerQuickActionEditorActions(
            restoreDefaultTooltip: 'Restore defaults',
            cancelLabel: 'Cancel',
            saveLabel: 'Save',
            onRestoreDefault: () {},
            onCancel: () {},
            onSave: () => saveCount++,
            saveEnabled: false,
          ),
        ),
      ),
    );

    await tester.tap(find.byKey(const ValueKey('player-quick-actions-save')));
    expect(saveCount, 0);
  });
}
