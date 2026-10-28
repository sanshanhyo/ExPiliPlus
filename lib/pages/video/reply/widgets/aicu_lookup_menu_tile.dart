import 'package:ex_piliplus/pages/video/reply/widgets/aicu_mark.dart';
import 'package:ex_piliplus/utils/extension/l10n_ext.dart';
import 'package:material_ui/material_ui.dart';

class AicuLookupMenuTile extends StatelessWidget {
  const AicuLookupMenuTile({super.key, required this.onTap, this.style});

  final VoidCallback onTap;
  final TextStyle? style;

  static bool shouldShow({required bool enabled, required int authorUid}) =>
      enabled && authorUid > 0;

  @override
  Widget build(BuildContext context) => ListTile(
    onTap: onTap,
    minLeadingWidth: 0,
    leading: const AicuMark(size: 19),
    title: Text(context.l10n.aicuLookup, style: style),
  );
}
