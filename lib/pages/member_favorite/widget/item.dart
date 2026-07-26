import 'package:ex_piliplus/common/style.dart';
import 'package:ex_piliplus/common/widgets/badge.dart';
import 'package:ex_piliplus/common/widgets/image/image_save.dart';
import 'package:ex_piliplus/common/widgets/image/network_img_layer.dart';
import 'package:ex_piliplus/models_new/space/space_fav/list.dart';
import 'package:ex_piliplus/pages/subscription_detail/view.dart';
import 'package:ex_piliplus/utils/bili_utils.dart';
import 'package:ex_piliplus/utils/extension/l10n_ext.dart';
import 'package:ex_piliplus/utils/num_utils.dart';
import 'package:ex_piliplus/utils/platform_utils.dart';
import 'package:ex_piliplus/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MemberFavItem extends StatelessWidget {
  const MemberFavItem({super.key, required this.item, this.onDelete});

  final SpaceFavItemModel item;
  final ValueChanged<bool?>? onDelete;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    void onLongPress() => imageSaveDialog(
      title: item.title,
      cover: item.cover,
    );
    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        onTap: () async {
          if (item.state == 1) {
            // invalid
            return;
          }

          if (item.type == 0 || item.type == 11) {
            final isDeleted = await Get.toNamed(
              '/favDetail',
              parameters: {
                'mediaId': item.id.toString(),
                'heroTag': Utils.makeHeroTag(item.id),
              },
            );
            onDelete?.call(isDeleted);
          } else {
            SubDetailPage.toSubDetailPage(
              item.id!,
              subInfo: item,
            );
          }
        },
        onLongPress: onLongPress,
        onSecondaryTap: PlatformUtils.isMobile ? null : onLongPress,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Style.safeSpace,
            vertical: 5,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  AspectRatio(
                    aspectRatio: Style.aspectRatio,
                    child: LayoutBuilder(
                      builder: (context, constraints) => NetworkImgLayer(
                        src: item.cover,
                        width: constraints.maxWidth,
                        height: constraints.maxHeight,
                      ),
                    ),
                  ),
                  if (item.type == 21)
                    PBadge(
                      right: 6,
                      top: 6,
                      text: context.l10n.favoriteCollectionBadge,
                    )
                  else if (item.type == 11)
                    PBadge(
                      right: 6,
                      top: 6,
                      text: context.l10n.favoriteFolderBadge,
                    ),
                ],
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title ?? '',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Spacer(),
                    Text(
                      item.type == 0
                          ? context.l10n.favoriteContentSummary(
                              item.mediaCount ?? 0,
                              BiliUtils.isPublicFav(item.attr ?? 0)
                                  ? context.l10n.favoritePublic
                                  : context.l10n.favoritePrivate,
                            )
                          : item.type == 11
                          ? context.l10n.favoriteUploaderCollectionSummary(
                              item.mediaCount ?? 0,
                              item.upper?.name ?? '',
                            )
                          : item.type == 21
                          ? context.l10n.favoriteCreatedCollectionSummary(
                              item.upper?.name ?? '',
                              item.mediaCount ?? 0,
                              NumUtils.numFormat(item.viewCount),
                            )
                          : context.l10n.favoriteContentCount(
                              item.mediaCount ?? 0,
                            ),
                      style: TextStyle(
                        fontSize: 12,
                        color: theme.colorScheme.outline,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
