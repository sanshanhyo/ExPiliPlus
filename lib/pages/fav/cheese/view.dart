import 'package:ex_piliplus/common/widgets/dialog/dialog.dart';
import 'package:ex_piliplus/common/widgets/flutter/refresh_indicator.dart';
import 'package:ex_piliplus/common/widgets/loading_widget/http_error.dart';
import 'package:ex_piliplus/http/loading_state.dart';
import 'package:ex_piliplus/models_new/space/space_cheese/item.dart';
import 'package:ex_piliplus/pages/fav/cheese/controller.dart';
import 'package:ex_piliplus/pages/member_cheese/widgets/item.dart';
import 'package:ex_piliplus/utils/grid.dart';
import 'package:ex_piliplus/utils/extension/l10n_ext.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FavCheesePage extends StatefulWidget {
  const FavCheesePage({super.key});

  @override
  State<FavCheesePage> createState() => _FavCheesePageState();
}

class _FavCheesePageState extends State<FavCheesePage>
    with AutomaticKeepAliveClientMixin, GridMixin {
  final FavCheeseController _controller = Get.put(FavCheeseController());

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final ThemeData theme = Theme.of(context);
    return refreshIndicator(
      onRefresh: _controller.onRefresh,
      child: CustomScrollView(
        controller: _controller.scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          SliverPadding(
            padding: EdgeInsets.only(
              top: 7,
              bottom: MediaQuery.viewPaddingOf(context).bottom + 100,
            ),
            sliver: Obx(
              () => _buildBody(theme, _controller.loadingState.value),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBody(
    ThemeData theme,
    LoadingState<List<SpaceCheeseItem>?> loadingState,
  ) {
    return switch (loadingState) {
      Loading() => gridSkeleton,
      Success(:final response) =>
        response != null && response.isNotEmpty
            ? SliverGrid.builder(
                gridDelegate: gridDelegate,
                itemBuilder: (context, index) {
                  if (index == response.length - 1) {
                    _controller.onLoadMore();
                  }
                  final item = response[index];
                  return MemberCheeseItem(
                    item: item,
                    onRemove: () => showConfirmDialog(
                      context: context,
                      title: Text(context.l10n.favoriteRemoveCourseConfirm),
                      onConfirm: () =>
                          _controller.onRemove(index, item.seasonId!),
                    ),
                  );
                },
                itemCount: response.length,
              )
            : HttpError(onReload: _controller.onReload),
      Error(:final errMsg) => HttpError(
        errMsg: errMsg,
        onReload: _controller.onReload,
      ),
    };
  }
}
