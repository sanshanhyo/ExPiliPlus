import 'package:flutter/material.dart';

class PlayerQuickActionEditorActions extends StatelessWidget {
  const PlayerQuickActionEditorActions({
    required this.restoreDefaultTooltip,
    required this.cancelLabel,
    required this.saveLabel,
    required this.onRestoreDefault,
    required this.onCancel,
    required this.onSave,
    required this.saveEnabled,
    super.key,
  });

  final String restoreDefaultTooltip;
  final String cancelLabel;
  final String saveLabel;
  final VoidCallback onRestoreDefault;
  final VoidCallback onCancel;
  final VoidCallback onSave;
  final bool saveEnabled;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 0, 12, 8),
      child: Row(
        children: [
          IconButton(
            key: const ValueKey('player-quick-actions-restore-default'),
            tooltip: restoreDefaultTooltip,
            icon: const Icon(Icons.restore),
            onPressed: onRestoreDefault,
          ),
          const Spacer(),
          TextButton(
            key: const ValueKey('player-quick-actions-cancel'),
            onPressed: onCancel,
            child: Text(cancelLabel),
          ),
          const SizedBox(width: 8),
          FilledButton(
            key: const ValueKey('player-quick-actions-save'),
            onPressed: saveEnabled ? onSave : null,
            child: Text(saveLabel),
          ),
        ],
      ),
    );
  }
}
