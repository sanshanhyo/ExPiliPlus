import 'package:ex_piliplus/grpc/bilibili/main/community/reply/v1.pb.dart'
    show VoteCard;
import 'package:ex_piliplus/pages/dynamics/widgets/vote.dart';
import 'package:ex_piliplus/utils/extension/l10n_ext.dart';
import 'package:ex_piliplus/utils/num_utils.dart';
import 'package:flutter/material.dart';

Widget buildVoteCard(
  BuildContext context,
  ColorScheme colorScheme,
  VoteCard voteCard,
) {
  return InkWell(
    onTap: () => showVoteDialog(context, voteCard.voteId.toInt()),
    child: Padding(
      padding: const .symmetric(horizontal: 12, vertical: 6),
      child: Row(
        spacing: 10,
        children: [
          Container(
            decoration: BoxDecoration(
              color: colorScheme.onInverseSurface,
              borderRadius: const .all(.circular(8)),
            ),
            width: 60,
            height: 42,
            child: Icon(
              Icons.bar_chart_rounded,
              color: colorScheme.onSurfaceVariant,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: .start,
              children: [
                Text(voteCard.title, maxLines: 1, overflow: .ellipsis),
                Text(
                  context.l10n.replyVoteParticipants(
                    NumUtils.numFormat(voteCard.count.toInt()),
                  ),
                  maxLines: 1,
                  overflow: .ellipsis,
                  style: TextStyle(fontSize: 13, color: colorScheme.outline),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
