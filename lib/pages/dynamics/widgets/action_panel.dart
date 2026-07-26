import 'package:ex_piliplus/models/dynamics/result.dart';
import 'package:ex_piliplus/pages/dynamics_repost/view.dart';
import 'package:ex_piliplus/utils/num_utils.dart';
import 'package:ex_piliplus/utils/page_utils.dart';
import 'package:ex_piliplus/utils/request_utils.dart';
import 'package:ex_piliplus/utils/extension/l10n_ext.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ActionPanel extends StatelessWidget {
  const ActionPanel({
    super.key,
    required this.item,
  });
  final DynamicItemModel item;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;
    final outline = theme.colorScheme.outline;
    final moduleStat = item.modules.moduleStat!;
    final forward = moduleStat.forward!;
    final comment = moduleStat.comment!;
    final like = moduleStat.like!;
    final btnStyle = TextButton.styleFrom(
      tapTargetSize: .padded,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      foregroundColor: outline,
    );
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
          child: Builder(
            builder: (context) {
              return TextButton.icon(
                onPressed: () => showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  useSafeArea: true,
                  builder: (_) => RepostPanel(
                    item: item,
                    onSuccess: () {
                      int count = forward.count ?? 0;
                      forward.count = count + 1;
                      if (context.mounted) {
                        (context as Element?)?.markNeedsBuild();
                      }
                    },
                  ),
                ),
                icon: Icon(
                  FontAwesomeIcons.shareFromSquare,
                  size: 16,
                  color: outline,
                  semanticLabel: context.l10n.commonRepost,
                ),
                style: btnStyle,
                label: Text(
                  forward.count != null
                      ? NumUtils.numFormat(forward.count)
                      : context.l10n.commonRepost,
                ),
              );
            },
          ),
        ),
        Expanded(
          child: TextButton.icon(
            onPressed: () => PageUtils.pushDynDetail(
              item,
              isPush: true,
              viewComment: true,
            ),
            icon: Icon(
              FontAwesomeIcons.comment,
              size: 16,
              color: outline,
              semanticLabel: context.l10n.feedComment,
            ),
            style: btnStyle,
            label: Text(
              comment.count != null
                  ? NumUtils.numFormat(comment.count)
                  : context.l10n.feedComment,
            ),
          ),
        ),
        Expanded(
          child: Builder(
            builder: (context) {
              final IconData icon;
              final Color color;
              final String label;
              if (like.status ?? false) {
                icon = FontAwesomeIcons.solidThumbsUp;
                color = primary;
                label = context.l10n.commonLiked;
              } else {
                icon = FontAwesomeIcons.thumbsUp;
                color = outline;
                label = context.l10n.commonLike;
              }
              final likeIcon = Icon(
                icon,
                size: 16,
                color: color,
                semanticLabel: label,
              );
              return TextButton.icon(
                onPressed: () => RequestUtils.onLikeDynamic(
                  item,
                  likeIcon.color == primary,
                  () {
                    if (context.mounted) {
                      (context as Element?)?.markNeedsBuild();
                    }
                  },
                ),
                icon: likeIcon,
                style: btnStyle,
                label: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 400),
                  transitionBuilder: (child, animation) =>
                      ScaleTransition(scale: animation, child: child),
                  child: Text(
                    like.count != null
                        ? NumUtils.numFormat(like.count)
                        : context.l10n.commonLike,
                    key: ValueKey<int?>(like.count),
                    style: TextStyle(color: like.status! ? primary : outline),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
