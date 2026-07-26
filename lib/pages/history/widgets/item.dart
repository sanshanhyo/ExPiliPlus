import 'package:ex_piliplus/common/style.dart';
import 'package:ex_piliplus/common/widgets/badge.dart';
import 'package:ex_piliplus/common/widgets/image/network_img_layer.dart';
import 'package:ex_piliplus/common/widgets/progress_bar/video_progress_indicator.dart';
import 'package:ex_piliplus/common/widgets/select_mask.dart';
import 'package:ex_piliplus/http/search.dart';
import 'package:ex_piliplus/http/user.dart';
import 'package:ex_piliplus/models/common/badge_type.dart';
import 'package:ex_piliplus/models_new/history/list.dart';
import 'package:ex_piliplus/models_new/video/video_detail/dimension.dart';
import 'package:ex_piliplus/pages/common/multi_select/base.dart';
import 'package:ex_piliplus/utils/date_utils.dart';
import 'package:ex_piliplus/utils/duration_utils.dart';
import 'package:ex_piliplus/utils/extension/l10n_ext.dart';
import 'package:ex_piliplus/utils/extension/localized_server_text.dart';
import 'package:ex_piliplus/utils/id_utils.dart';
import 'package:ex_piliplus/utils/page_utils.dart';
import 'package:ex_piliplus/utils/platform_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class HistoryItem extends StatelessWidget {
  final HistoryItemModel item;
  final MultiSelectBase ctr;
  final void Function(int kid, String business) onDelete;

  const HistoryItem({
    super.key,
    required this.item,
    required this.ctr,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final hasDuration = item.duration != null && item.duration != 0;
    int aid = item.history.oid!;
    String bvid = item.history.bvid ?? IdUtils.av2bv(aid);
    final business = item.history.business;
    final enableMultiSelect = ctr.enableMultiSelect.value;

    final onLongPress = enableMultiSelect
        ? null
        : () => ctr
            ..enableMultiSelect.value = true
            ..onSelect(item);

    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        onTap: enableMultiSelect
            ? () => ctr.onSelect(item)
            : () async {
                if (business?.contains('article') == true) {
                  PageUtils.toDupNamed(
                    '/articlePage',
                    parameters: {
                      'id': business == 'article-list'
                          ? '${item.history.cid}'
                          : '${item.history.oid}',
                      'type': 'read',
                    },
                  );
                } else if (business == 'live') {
                  if (item.liveStatus == 1) {
                    PageUtils.toLiveRoom(item.history.oid);
                  } else {
                    SmartDialog.showToast(context.l10n.liveNotStarted);
                  }
                } else if (business == 'pgc') {
                  PageUtils.viewPgc(
                    epId: item.history.epid,
                    progress: item.playbackProgress,
                  );
                } else if (business == 'cheese') {
                  if (item.uri?.isNotEmpty == true) {
                    PageUtils.viewPgcFromUri(
                      item.uri!,
                      isPgc: false,
                      aid: item.history.oid,
                      progress: item.playbackProgress,
                    );
                  }
                } else {
                  int? cid = item.history.cid;
                  Dimension? dimension;
                  if (cid == null) {
                    if (await SearchHttp.ab2cWithDimension(
                          aid: aid,
                          bvid: bvid,
                          part: item.history.page,
                        )
                        case final res?) {
                      cid = res.cid;
                      dimension = res.dimension;
                    }
                  }
                  if (cid != null) {
                    // TODO: dimension
                    PageUtils.toVideoPage(
                      aid: aid,
                      bvid: bvid,
                      cid: cid,
                      cover: item.cover,
                      title: item.title,
                      dimension: dimension,
                      progress: item.playbackProgress,
                    );
                  }
                }
              },
        onLongPress: onLongPress,
        onSecondaryTap: PlatformUtils.isMobile ? null : onLongPress,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Style.safeSpace,
                vertical: 5,
              ),
              child: Row(
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
                              src: item.cover?.isNotEmpty == true
                                  ? item.cover
                                  : item.covers?.firstOrNull ?? '',
                              width: maxWidth,
                              height: maxHeight,
                            ),
                            if (hasDuration)
                              PBadge(
                                text: item.progress == -1
                                    ? context.l10n.videoStatusWatched
                                    : '${DurationUtils.formatDuration(item.progress)}/${DurationUtils.formatDuration(item.duration)}',
                                right: 6.0,
                                bottom: 8.0,
                                type: PBadgeType.gray,
                              ),
                            if (item.isFav == 1)
                              PBadge(
                                text: context.l10n.commonFavorited,
                                top: 6.0,
                                right: 6.0,
                                type: PBadgeType.gray,
                              )
                            else if (item.badge?.isNotEmpty == true)
                              PBadge(
                                text: item.badge,
                                top: 6.0,
                                right: 6.0,
                                type: business == 'live' && item.liveStatus != 1
                                    ? PBadgeType.gray
                                    : PBadgeType.primary,
                              ),
                            if (hasDuration &&
                                item.progress != null &&
                                item.progress != 0)
                              Positioned(
                                left: 0,
                                right: 0,
                                bottom: 0,
                                child: VideoProgressIndicator(
                                  color: theme.colorScheme.primary,
                                  backgroundColor:
                                      theme.colorScheme.secondaryContainer,
                                  progress: item.progress == -1
                                      ? 1
                                      : item.progress! / item.duration!,
                                ),
                              ),
                            Positioned.fill(
                              child: selectMask(
                                theme.colorScheme,
                                item.checked,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  content(context, theme),
                ],
              ),
            ),
            Positioned(
              right: 12,
              bottom: 0,
              width: 29,
              height: 29,
              child: PopupMenuButton(
                padding: EdgeInsets.zero,
                tooltip: context.l10n.commonActionsMenu,
                icon: Icon(
                  Icons.more_vert_outlined,
                  color: theme.colorScheme.outline,
                  size: 18,
                ),
                position: PopupMenuPosition.under,
                itemBuilder: (_) => [
                  if (item.authorMid != null &&
                      item.authorName?.isNotEmpty == true)
                    PopupMenuItem(
                      onTap: () => Get.toNamed('/member?mid=${item.authorMid}'),
                      height: 38,
                      child: Row(
                        children: [
                          const Icon(
                            MdiIcons.accountCircleOutline,
                            size: 16,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            context.l10n.videoVisitUploader(item.authorName!),
                            style: const TextStyle(fontSize: 13),
                          ),
                        ],
                      ),
                    ),
                  if (business != 'pgc' &&
                      item.badge != '番剧' &&
                      item.tagName?.contains('动画') != true &&
                      business != 'live' &&
                      business?.contains('article') != true)
                    PopupMenuItem(
                      onTap: () =>
                          UserHttp.toViewLater(bvid: item.history.bvid),
                      height: 38,
                      child: Row(
                        children: [
                          const Icon(Icons.watch_later_outlined, size: 16),
                          const SizedBox(width: 6),
                          Text(
                            context.l10n.mineWatchLater,
                            style: const TextStyle(fontSize: 13),
                          ),
                        ],
                      ),
                    ),
                  PopupMenuItem(
                    onTap: () => onDelete(item.kid!, business!),
                    height: 38,
                    child: Row(
                      children: [
                        const Icon(Icons.close_outlined, size: 16),
                        const SizedBox(width: 6),
                        Text(
                          context.l10n.historyDeleteRecord,
                          style: const TextStyle(fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget content(BuildContext context, ThemeData theme) {
    return Expanded(
      child: Column(
        spacing: 2,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            item.title!,
            style: TextStyle(
              fontSize: theme.textTheme.bodyMedium!.fontSize,
              height: 1.42,
              letterSpacing: 0.3,
            ),
            maxLines: item.videos! > 1 ? 1 : 2,
            overflow: TextOverflow.ellipsis,
          ),
          if (item.history.business == 'pgc' &&
              item.showTitle?.isNotEmpty == true)
            Text(
              context.l10n.localizedEpisodeTitle(item.showTitle!),
              style: TextStyle(
                fontSize: 13,
                color: theme.colorScheme.outline,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          const Spacer(),
          if (item.authorName?.isNotEmpty == true)
            Text(
              item.authorName!,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: theme.textTheme.labelMedium!.fontSize,
                color: theme.colorScheme.outline,
              ),
            ),
          Text(
            DateFormatUtils.chatFormat(item.viewAt!, isHistory: true),
            style: TextStyle(
              fontSize: theme.textTheme.labelMedium!.fontSize,
              color: theme.colorScheme.outline,
            ),
          ),
        ],
      ),
    );
  }
}
