import 'package:ex_piliplus/common/skeleton/msg_feed_top.dart';
import 'package:ex_piliplus/common/widgets/dialog/dialog.dart';
import 'package:ex_piliplus/common/widgets/dialog/simple_dialog_option.dart';
import 'package:ex_piliplus/common/widgets/flutter/list_tile.dart';
import 'package:ex_piliplus/common/widgets/flutter/refresh_indicator.dart';
import 'package:ex_piliplus/common/widgets/image/network_img_layer.dart';
import 'package:ex_piliplus/common/widgets/loading_widget/http_error.dart';
import 'package:ex_piliplus/common/widgets/pair.dart';
import 'package:ex_piliplus/grpc/bilibili/app/im/v1.pbenum.dart'
    show IMSettingType;
import 'package:ex_piliplus/http/loading_state.dart';
import 'package:ex_piliplus/models/common/image_type.dart';
import 'package:ex_piliplus/models_new/msg/msg_like/item.dart';
import 'package:ex_piliplus/pages/msg_feed_top/like_me/controller.dart';
import 'package:ex_piliplus/pages/whisper_settings/view.dart';
import 'package:ex_piliplus/utils/app_scheme.dart';
import 'package:ex_piliplus/utils/date_utils.dart';
import 'package:ex_piliplus/utils/extension/l10n_ext.dart';
import 'package:ex_piliplus/utils/platform_utils.dart';
import 'package:flutter/material.dart' hide ListTile;
import 'package:get/get.dart';

class LikeMePage extends StatefulWidget {
  const LikeMePage({super.key});

  @override
  State<LikeMePage> createState() => _LikeMePageState();
}

class _LikeMePageState extends State<LikeMePage> {
  final LikeMeController _likeMeController = Get.put(LikeMeController());

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(context.l10n.messagesReceivedLikes),
        actions: [
          IconButton(
            onPressed: () => Get.to(
              const WhisperSettingsPage(
                imSettingType: IMSettingType.SETTING_TYPE_OLD_RECEIVE_LIKE,
              ),
            ),
            icon: Icon(
              size: 20,
              Icons.settings,
              color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.8),
            ),
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: refreshIndicator(
        onRefresh: _likeMeController.onRefresh,
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            SliverPadding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.viewPaddingOf(context).bottom + 100,
              ),
              sliver: Obx(
                () => _buildBody(theme, _likeMeController.loadingState.value),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBody(ThemeData theme, LoadingState loadingState) {
    late final divider = Divider(
      indent: 72,
      endIndent: 20,
      height: 6,
      color: Colors.grey.withValues(alpha: 0.1),
    );
    return switch (loadingState) {
      Loading() => SliverList.builder(
        itemCount: 12,
        itemBuilder: (context, index) => const MsgFeedTopSkeleton(),
      ),
      Success(:final response) => Builder(
        builder: (context) {
          Pair<List<MsgLikeItem>, List<MsgLikeItem>> pair = response;
          List<MsgLikeItem> latest = pair.first;
          List<MsgLikeItem> total = pair.second;
          if (latest.isNotEmpty || total.isNotEmpty) {
            return SliverMainAxisGroup(
              slivers: [
                if (latest.isNotEmpty) ...[
                  _buildHeader(theme, context.l10n.messagesLatest),
                  SliverList.separated(
                    itemBuilder: (context, index) {
                      if (total.isEmpty && index == latest.length - 1) {
                        _likeMeController.onLoadMore();
                      }
                      return _buildItem(theme, latest[index], (id) {
                        _likeMeController.onRemove(id, index, true);
                      });
                    },
                    itemCount: latest.length,
                    separatorBuilder: (context, index) => divider,
                  ),
                ],
                if (total.isNotEmpty) ...[
                  _buildHeader(theme, context.l10n.messagesTotal),
                  SliverList.separated(
                    itemBuilder: (context, index) {
                      if (index == total.length - 1) {
                        _likeMeController.onLoadMore();
                      }
                      return _buildItem(theme, total[index], (id) {
                        _likeMeController.onRemove(id, index, false);
                      });
                    },
                    itemCount: total.length,
                    separatorBuilder: (context, index) => divider,
                  ),
                ],
              ],
            );
          }
          return HttpError(onReload: _likeMeController.onReload);
        },
      ),
      Error(:final errMsg) => HttpError(
        errMsg: errMsg,
        onReload: _likeMeController.onReload,
      ),
    };
  }

  Widget _buildHeader(ThemeData theme, String title) {
    return SliverSafeArea(
      top: false,
      bottom: false,
      sliver: SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Text(
            title,
            style: theme.textTheme.labelLarge!.copyWith(
              color: theme.colorScheme.secondary,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildItem(
    ThemeData theme,
    MsgLikeItem item,
    ValueChanged<int?> onRemove,
  ) {
    final firstUser = item.users!.first;
    Widget avatar;
    if (item.users!.length == 1) {
      avatar = NetworkImgLayer(
        width: 45,
        height: 45,
        type: ImageType.avatar,
        src: firstUser.avatar,
      );
    } else {
      avatar = SizedBox(
        width: 45,
        height: 45,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            for (var j = 0; j < item.users!.length && j < 4; j++) ...[
              Positioned(
                left: 15.0 * (j % 2),
                top: 15.0 * (j ~/ 2),
                child: NetworkImgLayer(
                  width: 30,
                  height: 30,
                  type: ImageType.avatar,
                  src: item.users![j].avatar,
                ),
              ),
            ],
          ],
        ),
      );
    }
    void onLongPress() => showDialog(
      context: context,
      builder: (context) {
        final isNotice = item.noticeState == 0;
        return SimpleDialog(
          clipBehavior: Clip.hardEdge,
          contentPadding: const EdgeInsets.symmetric(vertical: 12),
          children: [
            DialogOption(
              onPressed: () {
                Get.back();
                showConfirmDialog(
                  context: context,
                  title: Text(context.l10n.commonDelete),
                  content: Text(
                    context.l10n.messagesDeleteLikeNoticeConfirm,
                  ),
                  onConfirm: () => onRemove(item.id),
                );
              },
              child: Text(
                context.l10n.commonDelete,
                style: const TextStyle(fontSize: 14),
              ),
            ),
            DialogOption(
              onPressed: () {
                Get.back();
                if (isNotice) {
                  showConfirmDialog(
                    context: context,
                    title: Text(context.l10n.messagesStopNotifications),
                    content: Text(
                      context.l10n.messagesStopNotificationsConfirm,
                    ),
                    onConfirm: () =>
                        _likeMeController.onSetNotice(item, isNotice),
                  );
                } else {
                  _likeMeController.onSetNotice(item, isNotice);
                }
              },
              child: Text(
                isNotice
                    ? context.l10n.messagesStopNotifications
                    : context.l10n.messagesReceiveNotifications,
                style: const TextStyle(fontSize: 14),
              ),
            ),
          ],
        );
      },
    );
    return ListTile(
      safeArea: true,
      onTap: () {
        String? nativeUri = item.item?.nativeUri;
        bool isInvalid =
            nativeUri == null || nativeUri.isEmpty || nativeUri.startsWith('?');
        if (item.counts! > 1) {
          Get.toNamed(
            'msgLikeDetail',
            arguments: {
              'id': item.id!.toString(),
              if (!isInvalid) 'uri': nativeUri,
              'counts': item.counts,
            },
          );
          return;
        }
        if (isInvalid) {
          return;
        }
        PiliScheme.routePushFromUrl(nativeUri);
      },
      onLongPress: onLongPress,
      onSecondaryTap: PlatformUtils.isMobile ? null : onLongPress,
      leading: avatar,
      title: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: firstUser.nickname,
              style: theme.textTheme.titleSmall!.copyWith(
                height: 1.5,
                color: theme.colorScheme.primary,
              ),
            ),
            if (item.counts! > 1)
              TextSpan(
                text: context.l10n.messagesAndPeople(item.counts.toString()),
                style: theme.textTheme.titleSmall!.copyWith(
                  fontSize: 12,
                  height: 1.5,
                ),
              ),
            TextSpan(
              text: context.l10n.messagesLikedMyItem(
                item.item?.business ?? '',
              ),
              style: theme.textTheme.titleSmall!.copyWith(
                height: 1.5,
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (item.item?.title?.isNotEmpty == true) ...[
            const SizedBox(height: 4),
            Text(
              item.item!.title!,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.bodyMedium!.copyWith(
                color: theme.colorScheme.outline,
                height: 1.5,
              ),
            ),
          ],
          const SizedBox(height: 4),
          Text(
            DateFormatUtils.dateFormat(item.likeTime),
            style: theme.textTheme.bodyMedium!.copyWith(
              fontSize: 13,
              color: theme.colorScheme.outline,
            ),
          ),
        ],
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (item.item?.image?.isNotEmpty == true)
            NetworkImgLayer(
              width: 45,
              height: 45,
              src: item.item!.image,
              borderRadius: const BorderRadius.all(Radius.circular(8)),
            ),
          if (item.noticeState == 1) ...[
            if (item.item?.image?.isNotEmpty == true) const SizedBox(width: 4),
            Icon(
              size: 18,
              Icons.notifications_off,
              color: theme.colorScheme.outline,
            ),
          ],
        ],
      ),
    );
  }
}
