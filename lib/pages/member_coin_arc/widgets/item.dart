import 'package:ex_piliplus/common/style.dart';
import 'package:ex_piliplus/common/widgets/badge.dart';
import 'package:ex_piliplus/common/widgets/image/image_save.dart';
import 'package:ex_piliplus/common/widgets/image/network_img_layer.dart';
import 'package:ex_piliplus/common/widgets/stat/stat.dart';
import 'package:ex_piliplus/common/widgets/video_card/video_card_v.dart';
import 'package:ex_piliplus/http/search.dart';
import 'package:ex_piliplus/models/common/badge_type.dart';
import 'package:ex_piliplus/models/common/stat_type.dart';
import 'package:ex_piliplus/models_new/member/coin_like_arc/item.dart';
import 'package:ex_piliplus/utils/date_utils.dart';
import 'package:ex_piliplus/utils/duration_utils.dart';
import 'package:ex_piliplus/utils/extension/l10n_ext.dart';
import 'package:ex_piliplus/utils/page_utils.dart';
import 'package:ex_piliplus/utils/platform_utils.dart';
import 'package:flutter/material.dart';

class MemberCoinLikeItem extends StatelessWidget {
  final CoinLikeArcItem item;

  const MemberCoinLikeItem({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    void onLongPress() => imageSaveDialog(
      title: item.title,
      cover: item.cover,
      aid: item.param,
    );
    return Card(
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: () async {
          if (item.isPgc == true) {
            if (item.uri?.isNotEmpty == true) {
              PageUtils.viewPgcFromUri(item.uri!);
            }
            return;
          }

          if (item.param != null) {
            final res = await SearchHttp.ab2cWithDimension(aid: item.param);
            final cid = res?.cid;
            if (cid != null) {
              PageUtils.toVideoPage(
                aid: int.parse(item.param!),
                cid: cid,
                cover: item.cover,
                title: item.title,
                dimension: res!.dimension,
              );
            }
          }
        },
        onLongPress: onLongPress,
        onSecondaryTap: PlatformUtils.isMobile ? null : onLongPress,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: Style.aspectRatio,
              child: LayoutBuilder(
                builder: (context, boxConstraints) {
                  double maxWidth = boxConstraints.maxWidth;
                  double maxHeight = boxConstraints.maxHeight;
                  return Stack(
                    clipBehavior: Clip.none,
                    children: [
                      NetworkImgLayer(
                        src: item.cover,
                        width: maxWidth,
                        height: maxHeight,
                        type: .emote,
                      ),
                      if (item.isCooperation == true)
                        PBadge(
                          text: context.l10n.videoCooperation,
                          top: 6,
                          right: 6,
                        )
                      else if (item.isSteins == true)
                        PBadge(
                          text: context.l10n.videoInteractive,
                          top: 6,
                          right: 6,
                        ),
                      if (item.duration != null && item.duration! > 0)
                        PBadge(
                          bottom: 6,
                          right: 6,
                          type: PBadgeType.gray,
                          text: DurationUtils.formatDuration(item.duration),
                        ),
                    ],
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(5, 6, 0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${item.title}\n',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      StatWidget(
                        type: StatType.play,
                        value: item.play,
                      ),
                      const SizedBox(width: 8),
                      StatWidget(
                        type: StatType.danmaku,
                        value: item.danmaku,
                      ),
                      const Spacer(),
                      Text(
                        DateFormatUtils.dateFormat(
                          item.ctime,
                          short: VideoCardV.shortFormat,
                          long: VideoCardV.longFormat,
                        ),
                        style: TextStyle(
                          fontSize: 11,
                          color: Theme.of(context).colorScheme.outline,
                        ),
                      ),
                      const SizedBox(width: 6),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
