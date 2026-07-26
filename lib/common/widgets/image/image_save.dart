import 'package:ex_piliplus/common/style.dart';
import 'package:ex_piliplus/common/widgets/button/icon_button.dart';
import 'package:ex_piliplus/common/widgets/image/network_img_layer.dart';
import 'package:ex_piliplus/common/widgets/selection_text.dart';
import 'package:ex_piliplus/http/user.dart';
import 'package:ex_piliplus/utils/extension/l10n_ext.dart';
import 'package:ex_piliplus/utils/image_utils.dart';
import 'package:ex_piliplus/utils/platform_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';

void imageSaveDialog({
  required String? title,
  required String? cover,
  dynamic aid,
  String? bvid,
}) {
  final double imgWidth = MediaQuery.sizeOf(Get.context!).shortestSide - 16;
  SmartDialog.show(
    animationType: SmartAnimationType.centerScale_otherSlide,
    builder: (context) {
      const iconSize = 20.0;
      final theme = Theme.of(context);
      return Container(
        width: imgWidth,
        margin: const .symmetric(horizontal: Style.safeSpace),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: Style.mdRadius,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                GestureDetector(
                  onTap: SmartDialog.dismiss,
                  child: NetworkImgLayer(
                    src: cover,
                    quality: 100,
                    width: imgWidth,
                    height: imgWidth / Style.aspectRatio16x9,
                    borderRadius: const .vertical(top: Style.imgRadius),
                  ),
                ),
                Positioned(
                  right: 8,
                  top: 8,
                  width: 30,
                  height: 30,
                  child: IconButton(
                    tooltip: context.l10n.commonClose,
                    style: IconButton.styleFrom(
                      padding: .zero,
                      backgroundColor: Colors.black.withValues(alpha: 0.3),
                    ),
                    onPressed: SmartDialog.dismiss,
                    icon: const Icon(
                      Icons.close,
                      size: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 10, 8, 10),
              child: Row(
                children: [
                  if (title != null)
                    Expanded(
                      child: SelectionText(
                        title,
                        style: theme.textTheme.titleSmall,
                      ),
                    )
                  else
                    const Spacer(),
                  if (aid != null || bvid != null)
                    iconButton(
                      iconSize: iconSize,
                      tooltip: context.l10n.mineWatchLater,
                      onPressed: () => {
                        SmartDialog.dismiss(),
                        UserHttp.toViewLater(aid: aid, bvid: bvid),
                      },
                      icon: const Icon(Icons.watch_later_outlined),
                    ),
                  if (cover != null && cover.isNotEmpty) ...[
                    if (PlatformUtils.isMobile)
                      iconButton(
                        iconSize: iconSize,
                        tooltip: context.l10n.commonShare,
                        onPressed: () {
                          SmartDialog.dismiss();
                          ImageUtils.onShareImg(cover);
                        },
                        icon: const Icon(Icons.share),
                      ),
                    iconButton(
                      iconSize: iconSize,
                      tooltip: context.l10n.videoSaveCover,
                      onPressed: () async {
                        bool saveStatus = await ImageUtils.downloadImg([cover]);
                        if (saveStatus) {
                          SmartDialog.dismiss();
                        }
                      },
                      icon: const Icon(Icons.download),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      );
    },
  );
}
