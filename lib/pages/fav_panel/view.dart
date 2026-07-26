import 'package:ex_piliplus/common/widgets/loading_widget/loading_widget.dart';
import 'package:ex_piliplus/http/loading_state.dart';
import 'package:ex_piliplus/models_new/fav/fav_folder/list.dart';
import 'package:ex_piliplus/pages/common/common_intro_controller.dart';
import 'package:ex_piliplus/utils/bili_utils.dart';
import 'package:ex_piliplus/utils/extension/l10n_ext.dart';
import 'package:ex_piliplus/utils/feed_back.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FavPanel extends StatefulWidget {
  const FavPanel({
    super.key,
    required this.ctr,
    this.scrollController,
  });

  final FavMixin ctr;
  final ScrollController? scrollController;

  @override
  State<FavPanel> createState() => _FavPanelState();
}

class _FavPanelState extends State<FavPanel> {
  LoadingState loadingState = LoadingState.loading();

  @override
  void initState() {
    super.initState();
    _queryVideoInFolder();
  }

  Future<void> _queryVideoInFolder() async {
    final res = await widget.ctr.queryVideoInFolder();
    if (mounted) {
      loadingState = res;
      setState(() {});
    }
  }

  Widget get _buildBody {
    switch (loadingState) {
      case Loading():
        return m3eLoading;
      case Success():
        final list = widget.ctr.favFolderData.value.list!;
        return ListView.builder(
          controller: widget.scrollController,
          itemCount: list.length,
          itemBuilder: (context, index) {
            FavFolderInfo item = list[index];
            return Material(
              type: .transparency,
              child: Builder(
                builder: (context) {
                  final isChecked = item.favState == 1;

                  void onTap() {
                    item
                      ..favState = isChecked ? 0 : 1
                      ..mediaCount += isChecked ? -1 : 1;
                    (context as Element).markNeedsBuild();
                  }

                  return ListTile(
                    onTap: onTap,
                    dense: true,
                    leading: BiliUtils.isPublicFav(item.attr)
                        ? const Icon(Icons.folder_outlined)
                        : const Icon(Icons.lock_outline),
                    minLeadingWidth: 0,
                    title: Text(item.title),
                    subtitle: Text(
                      context.l10n.favoriteContentSummary(
                        item.mediaCount,
                        BiliUtils.isPublicFav(item.attr)
                            ? context.l10n.favoritePublic
                            : context.l10n.favoritePrivate,
                      ),
                    ),
                    trailing: Transform.scale(
                      scale: 0.9,
                      child: Checkbox(
                        value: isChecked,
                        onChanged: (bool? checkValue) => onTap(),
                      ),
                    ),
                  );
                },
              ),
            );
          },
        );
      case Error(:final errMsg):
        return scrollErrorWidget(
          errMsg: errMsg,
          controller: widget.scrollController,
          onReload: _queryVideoInFolder,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return Column(
      children: [
        AppBar(
          backgroundColor: Colors.transparent,
          leading: IconButton(
            tooltip: context.l10n.commonClose,
            onPressed: Get.back,
            icon: const Icon(Icons.close_outlined),
          ),
          title: Text(context.l10n.favoriteAddToFolder),
          actions: [
            TextButton.icon(
              onPressed: () => Get.toNamed('/createFav')?.then((data) {
                if (data is FavFolderInfo && mounted) {
                  widget.ctr.favFolderData.value.list?.insert(
                    1,
                    data
                      ..favState = 1
                      ..mediaCount = 1,
                  );
                  setState(() {});
                }
              }),
              icon: Icon(Icons.add, color: theme.primary),
              label: Text(context.l10n.favoriteNewFolder),
              style: const ButtonStyle(
                visualDensity: .compact,
                padding: WidgetStatePropertyAll(
                  .symmetric(horizontal: 18, vertical: 14),
                ),
              ),
            ),
            const SizedBox(width: 16),
          ],
        ),
        Expanded(child: _buildBody),
        Divider(
          height: 1,
          color: theme.outline.withValues(alpha: 0.1),
        ),
        Padding(
          padding: .only(
            left: 20,
            right: 20,
            top: 12,
            bottom: MediaQuery.viewPaddingOf(context).bottom + 12,
          ),
          child: Row(
            spacing: 25,
            mainAxisAlignment: .end,
            children: [
              FilledButton.tonal(
                onPressed: Get.back,
                style: FilledButton.styleFrom(
                  visualDensity: .compact,
                  foregroundColor: theme.outline,
                  backgroundColor: theme.onInverseSurface,
                ),
                child: Text(context.l10n.commonCancel),
              ),
              FilledButton.tonal(
                onPressed: () {
                  feedBack();
                  widget.ctr.actionFavVideo();
                },
                style: const ButtonStyle(visualDensity: .compact),
                child: Text(context.l10n.commonDone),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
