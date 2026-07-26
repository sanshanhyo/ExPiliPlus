import 'package:ex_piliplus/common/assets.dart';
import 'package:ex_piliplus/common/style.dart';
import 'package:ex_piliplus/common/widgets/badge.dart';
import 'package:ex_piliplus/common/widgets/image/network_img_layer.dart';
import 'package:ex_piliplus/models/common/badge_type.dart';
import 'package:ex_piliplus/models/dynamics/result.dart';
import 'package:ex_piliplus/utils/extension/num_ext.dart';
import 'package:ex_piliplus/utils/extension/l10n_ext.dart';
import 'package:flutter/material.dart';

Widget liveRcmdPanel(
  BuildContext context, {
  required int floor,
  required ThemeData theme,
  required DynamicItemModel item,
  required bool isDetail,
  Function(List<String>, int)? callback,
}) {
  DynamicLiveModel? liveRcmd = item.modules.moduleDynamic?.major?.liveRcmd;
  if (liveRcmd == null) {
    return const SizedBox.shrink();
  }
  EdgeInsets padding;
  if (floor == 1) {
    padding = const EdgeInsets.symmetric(horizontal: 12);
  } else {
    padding = EdgeInsets.zero;
  }
  return Padding(
    padding: padding,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            LayoutBuilder(
              builder: (context, constraints) => NetworkImgLayer(
                width: constraints.maxWidth,
                height: constraints.maxWidth / Style.aspectRatio,
                src: liveRcmd.cover,
                quality: 40,
              ),
            ),
            PBadge(
              text: liveRcmd.watchedShow?.textLarge,
              top: 6,
              right: 65,
              fontSize: 10.5,
              type: PBadgeType.gray,
            ),
            if (liveRcmd.liveStatus == 1)
              Positioned(
                right: 6,
                top: 6,
                child: Image.asset(
                  height: 16,
                  cacheHeight: 16.cacheSize(context),
                  Assets.livingRect,
                  filterQuality: FilterQuality.low,
                ),
              )
            else
              PBadge(
                text: context.l10n.feedLiveEnded,
                top: 6,
                right: 6,
                type: PBadgeType.gray,
              ),
            if (liveRcmd.areaName case final areaName?)
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  height: 80,
                  alignment: Alignment.bottomLeft,
                  padding: const EdgeInsets.fromLTRB(12, 0, 10, 10),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: <Color>[
                        Colors.transparent,
                        Colors.black45,
                      ],
                    ),
                    borderRadius: BorderRadius.vertical(
                      bottom: Style.imgRadius,
                    ),
                  ),
                  child: Text(
                    areaName,
                    style: TextStyle(
                      fontSize: theme.textTheme.labelMedium!.fontSize,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 6),
        if (liveRcmd.title case final title?)
          Text(
            title,
            maxLines: isDetail ? null : 1,
            style: const TextStyle(fontWeight: FontWeight.bold),
            overflow: isDetail ? null : TextOverflow.ellipsis,
          ),
        const SizedBox(height: 2),
      ],
    ),
  );
}
