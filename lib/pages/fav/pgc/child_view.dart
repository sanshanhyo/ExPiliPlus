import 'package:ex_piliplus/common/skeleton/fav_pgc_item.dart';
import 'package:ex_piliplus/common/widgets/button/icon_button.dart';
import 'package:ex_piliplus/common/widgets/dialog/dialog.dart';
import 'package:ex_piliplus/common/widgets/flutter/refresh_indicator.dart';
import 'package:ex_piliplus/common/widgets/loading_widget/http_error.dart';
import 'package:ex_piliplus/http/loading_state.dart';
import 'package:ex_piliplus/models_new/fav/fav_pgc/list.dart';
import 'package:ex_piliplus/pages/fav/pgc/controller.dart';
import 'package:ex_piliplus/pages/fav/pgc/widget/item.dart';
import 'package:ex_piliplus/utils/grid.dart';
import 'package:ex_piliplus/utils/extension/l10n_ext.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FavPgcChildPage extends StatefulWidget {
  const FavPgcChildPage({
    super.key,
    required this.type,
    required this.followStatus,
  });

  final int type;
  final int followStatus;

  @override
  State<FavPgcChildPage> createState() => _FavPgcChildPageState();
}

class _FavPgcChildPageState extends State<FavPgcChildPage>
    with AutomaticKeepAliveClientMixin, GridMixin {
  late final FavPgcController _favPgcController;

  @override
  void initState() {
    super.initState();
    _favPgcController = Get.put(
      FavPgcController(widget.type, widget.followStatus),
      tag: '${widget.type}${widget.followStatus}',
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final theme = Theme.of(context);
    final padding = MediaQuery.viewPaddingOf(context);
    final bottomH = 50 + padding.bottom;
    return Stack(
      clipBehavior: Clip.none,
      children: [
        refreshIndicator(
          onRefresh: _favPgcController.onRefresh,
          child: CustomScrollView(
            controller: _favPgcController.scrollController,
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              SliverPadding(
                padding: EdgeInsets.only(bottom: padding.bottom + 100),
                sliver: Obx(
                  () => _buildBody(_favPgcController.loadingState.value),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: -bottomH,
          child: Obx(
            () => AnimatedSlide(
              offset: _favPgcController.enableMultiSelect.value
                  ? const Offset(0, -1)
                  : Offset.zero,
              duration: const Duration(milliseconds: 150),
              child: Container(
                height: bottomH,
                padding: padding,
                decoration: BoxDecoration(
                  color: theme.colorScheme.onInverseSurface,
                  border: Border(
                    top: BorderSide(
                      width: 0.5,
                      color: theme.colorScheme.outline.withValues(alpha: 0.5),
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    const SizedBox(width: 16),
                    iconButton(
                      size: 32,
                      tooltip: context.l10n.commonCancel,
                      context: context,
                      icon: const Icon(Icons.clear),
                      onPressed: _favPgcController.onDisable,
                    ),
                    const SizedBox(width: 12),
                    Obx(
                      () => Checkbox(
                        value: _favPgcController.allSelected.value,
                        onChanged: (value) {
                          _favPgcController.handleSelect(
                            checked: !_favPgcController.allSelected.value,
                            disableSelect: false,
                          );
                        },
                      ),
                    ),
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () => _favPgcController.handleSelect(
                        checked: !_favPgcController.allSelected.value,
                        disableSelect: false,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 14,
                          bottom: 14,
                          right: 12,
                        ),
                        child: Text(context.l10n.commonSelectAll),
                      ),
                    ),
                    const Spacer(),
                    ...[
                          (
                            followStatus: 1,
                            title: context.l10n.videoStatusWantToWatch,
                          ),
                          (
                            followStatus: 2,
                            title: context.l10n.videoStatusWatching,
                          ),
                          (
                            followStatus: 3,
                            title: context.l10n.videoStatusWatched,
                          ),
                        ]
                        .where(
                          (item) => item.followStatus != widget.followStatus,
                        )
                        .map(
                          (item) => Padding(
                            padding: const EdgeInsets.only(left: 25),
                            child: GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () {
                                if (_favPgcController.checkedCount != 0) {
                                  _favPgcController.onUpdateList(
                                    item.followStatus,
                                  );
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 14,
                                  horizontal: 5,
                                ),
                                child: Text(
                                  context.l10n.videoMarkAs(item.title),
                                  style: TextStyle(
                                    color: theme.colorScheme.onSurfaceVariant,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                    const SizedBox(width: 20),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBody(LoadingState<List<FavPgcItemModel>?> loadingState) {
    return switch (loadingState) {
      Loading() => SliverGrid.builder(
        gridDelegate: gridDelegate,
        itemBuilder: (context, index) => const FavPgcItemSkeleton(),
        itemCount: 10,
      ),
      Success(:final response) =>
        response != null && response.isNotEmpty
            ? SliverGrid.builder(
                gridDelegate: gridDelegate,
                itemBuilder: (context, index) {
                  if (index == response.length - 1) {
                    _favPgcController.onLoadMore();
                  }
                  final item = response[index];
                  return FavPgcItem(
                    item: item,
                    ctr: _favPgcController,
                    onSelect: () => _favPgcController.onSelect(item),
                    onUpdateStatus: () => showPgcFollowDialog(
                      context: context,
                      type: widget.type == 0
                          ? context.l10n.favoriteTabAnime
                          : context.l10n.favoriteTabSeries,
                      followStatus: widget.followStatus,
                      onUpdateStatus: (followStatus) {
                        if (followStatus == -1) {
                          _favPgcController.pgcDel(
                            index,
                            item.seasonId,
                          );
                        } else {
                          _favPgcController.onUpdate(
                            index,
                            followStatus,
                            item.seasonId,
                          );
                        }
                      },
                    ),
                  );
                },
                itemCount: response.length,
              )
            : HttpError(onReload: _favPgcController.onReload),
      Error(:final errMsg) => HttpError(
        errMsg: errMsg,
        onReload: _favPgcController.onReload,
      ),
    };
  }

  @override
  bool get wantKeepAlive => true;
}
