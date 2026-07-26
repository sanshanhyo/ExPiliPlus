import 'package:ex_piliplus/common/widgets/image/network_img_layer.dart';
import 'package:ex_piliplus/models_new/fav/fav_folder/list.dart';
import 'package:ex_piliplus/utils/bili_utils.dart';
import 'package:ex_piliplus/utils/extension/l10n_ext.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FavFolderItem extends StatelessWidget {
  const FavFolderItem({
    super.key,
    required this.item,
    required this.onPop,
    required this.heroTag,
  });

  final FavFolderInfo item;
  final VoidCallback onPop;
  final String heroTag;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = context.l10n;
    return GestureDetector(
      onTap: () {
        Get.toNamed(
          '/favDetail',
          arguments: item,
          parameters: {
            'mediaId': item.id.toString(),
            'heroTag': heroTag,
          },
        )?.whenComplete(onPop);
      },
      behavior: HitTestBehavior.opaque,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              boxShadow: [
                BoxShadow(
                  color: theme.colorScheme.onInverseSurface.withValues(
                    alpha: 0.4,
                  ),
                  offset: const Offset(6, -8),
                  blurRadius: 0.0,
                  spreadRadius: 0.0,
                ),
              ],
            ),
            child: Hero(
              tag: heroTag,
              child: NetworkImgLayer(
                src: item.cover,
                width: 180,
                height: 110,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            ' ${item.title}',
            overflow: TextOverflow.fade,
            maxLines: 1,
          ),
          Text(
            ' ${l10n.favoriteFolderSummary(
              item.mediaCount,
              BiliUtils.isPublicFav(item.attr) ? l10n.favoritePublic : l10n.favoritePrivate,
            )}',
            style: theme.textTheme.labelSmall!.copyWith(
              color: theme.colorScheme.outline,
            ),
          ),
        ],
      ),
    );
  }
}
