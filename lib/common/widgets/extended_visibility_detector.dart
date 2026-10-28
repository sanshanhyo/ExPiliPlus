import 'package:flutter/widgets.dart';

/// Compatibility wrapper for the visibility marker used by nested panels.
/// The current extended_nested_scroll_view release does not expose its
/// detector on every platform, so the child remains layout-transparent.
class ExtendedVisibilityDetector extends StatelessWidget {
  const ExtendedVisibilityDetector({
    super.key,
    required this.uniqueKey,
    required this.child,
  });

  final Key uniqueKey;
  final Widget child;

  @override
  Widget build(BuildContext context) => KeyedSubtree(key: uniqueKey, child: child);
}
