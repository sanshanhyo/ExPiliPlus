import 'package:ex_piliplus/services/shutdown_timer_snapshot.dart';
import 'package:ex_piliplus/utils/extension/l10n_ext.dart';
import 'package:flutter/foundation.dart' show ValueListenable;
import 'package:material_ui/material_ui.dart';

String shutdownTimerRemainingLabel(
  BuildContext context,
  ShutdownTimerSnapshot snapshot,
) => context.l10n.statisticsRemaining(
  context.l10n.shutdownMinutes(snapshot.remainingMinutes),
);

class ShutdownTimerQuickActionContent extends StatelessWidget {
  const ShutdownTimerQuickActionContent({
    super.key,
    required this.countdown,
    required this.idleLabel,
    required this.iconSize,
    required this.labelFontSize,
    required this.onPressed,
  });

  final ValueListenable<ShutdownTimerSnapshot> countdown;
  final String idleLabel;
  final double iconSize;
  final double labelFontSize;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ShutdownTimerSnapshot>(
      valueListenable: countdown,
      builder: (context, snapshot, _) {
        final theme = Theme.of(context);
        final scheduled = snapshot.isScheduled;
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              iconSize: iconSize,
              constraints: BoxConstraints.tightFor(
                width: iconSize + 16,
                height: iconSize + 16,
              ),
              padding: const EdgeInsets.all(8),
              onPressed: onPressed,
              icon: scheduled
                  ? SizedBox.square(
                      dimension: iconSize,
                      child: Stack(
                        fit: StackFit.expand,
                        alignment: Alignment.center,
                        children: [
                          CircularProgressIndicator(
                            value: snapshot.progress,
                            strokeWidth: 2.5,
                            color: theme.colorScheme.primary,
                            backgroundColor: theme.colorScheme.outlineVariant,
                          ),
                          Center(
                            child: Icon(
                              Icons.hourglass_top_outlined,
                              size: iconSize * 0.58,
                              color: theme.colorScheme.primary,
                            ),
                          ),
                        ],
                      ),
                    )
                  : const Icon(Icons.hourglass_top_outlined),
              style: IconButton.styleFrom(
                shape: const CircleBorder(),
                backgroundColor: theme.colorScheme.surfaceContainerHighest,
                foregroundColor: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 8),
            Flexible(
              child: Text(
                scheduled
                    ? shutdownTimerRemainingLabel(context, snapshot)
                    : idleLabel,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.labelMedium?.copyWith(
                  fontSize: labelFontSize,
                  height: 1.15,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
