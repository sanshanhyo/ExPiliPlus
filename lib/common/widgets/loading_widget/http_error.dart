import 'package:ex_piliplus/common/assets.dart';
import 'package:ex_piliplus/common/widgets/selection_text.dart';
import 'package:ex_piliplus/utils/extension/l10n_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HttpError extends StatelessWidget {
  const HttpError({
    super.key,
    this.isSliver = true,
    this.errMsg,
    this.onReload,
    this.btnText,
    this.safeArea = true,
  });

  final bool isSliver;
  final String? errMsg;
  final VoidCallback? onReload;
  final String? btnText;
  final bool safeArea;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final child = Column(
      mainAxisSize: .min,
      mainAxisAlignment: .center,
      crossAxisAlignment: .center,
      children: [
        const SizedBox(height: 40),
        SvgPicture.asset(Assets.error, height: 200),
        const SizedBox(height: 30),
        Padding(
          padding: const .symmetric(horizontal: 16, vertical: 5),
          child: SelectionText(
            errMsg ?? context.l10n.commonNoData,
            textAlign: .center,
            style: theme.textTheme.titleSmall,
          ),
        ),
        if (onReload != null)
          FilledButton.tonal(
            onPressed: onReload,
            style: FilledButton.styleFrom(
              tapTargetSize: .padded,
              backgroundColor: theme.colorScheme.primary.withAlpha(20),
              shadowColor: Colors.transparent,
            ),
            child: Text(
              btnText ?? context.l10n.commonTapToRetry,
              style: TextStyle(color: theme.colorScheme.primary),
            ),
          ),
        if (safeArea)
          SizedBox(height: 40 + MediaQuery.viewPaddingOf(context).bottom),
      ],
    );

    return isSliver
        ? SliverToBoxAdapter(child: child)
        : SizedBox(width: double.infinity, child: child);
  }
}
