import 'package:ex_piliplus/common/skeleton/msg_feed_top.dart';
import 'package:ex_piliplus/common/widgets/sliver/sliver_floating_header.dart';
import 'package:ex_piliplus/models/search/result.dart';
import 'package:ex_piliplus/pages/search_panel/user/controller.dart';
import 'package:ex_piliplus/pages/search_panel/user/widgets/item.dart';
import 'package:ex_piliplus/pages/search_panel/view.dart';
import 'package:ex_piliplus/utils/extension/l10n_ext.dart';
import 'package:ex_piliplus/utils/grid.dart';
import 'package:flutter/material.dart'
    hide SliverGridDelegateWithMaxCrossAxisExtent;
import 'package:get/get.dart';

class SearchUserPanel extends CommonSearchPanel {
  const SearchUserPanel({
    super.key,
    required super.keyword,
    required super.tag,
    required super.searchType,
  });

  @override
  State<SearchUserPanel> createState() => _SearchUserPanelState();
}

class _SearchUserPanelState
    extends
        CommonSearchPanelState<
          SearchUserPanel,
          SearchUserData,
          SearchUserItemModel
        > {
  @override
  late final SearchUserController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(
      SearchUserController(
        keyword: widget.keyword,
        searchType: widget.searchType,
        tag: widget.tag,
      ),
      tag: widget.searchType.name + widget.tag,
    );
  }

  @override
  Widget buildHeader(ThemeData theme) {
    return SliverFloatingHeaderWidget(
      backgroundColor: theme.colorScheme.surface,
      child: Padding(
        padding: const .fromLTRB(25, 0, 12, 4),
        child: Row(
          children: [
            Obx(
              () => Text(
                context.l10n.searchSortValue(
                  controller.userOrderType!.value.localizedLabel(context.l10n),
                ),
                maxLines: 1,
                style: TextStyle(color: theme.colorScheme.outline),
              ),
            ),
            const Spacer(),
            Obx(
              () => Text(
                context.l10n.searchUserTypeValue(
                  controller.userType!.value.localizedLabel(context.l10n),
                ),
                maxLines: 1,
                style: TextStyle(color: theme.colorScheme.outline),
              ),
            ),
            const Spacer(),
            SizedBox(
              width: 32,
              height: 32,
              child: IconButton(
                tooltip: context.l10n.searchFilter,
                style: const ButtonStyle(
                  padding: WidgetStatePropertyAll(EdgeInsets.zero),
                ),
                onPressed: () => controller.onShowFilterDialog(context),
                icon: Icon(
                  Icons.filter_list_outlined,
                  size: 18,
                  color: theme.colorScheme.primary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  late final gridDelegate = SliverGridDelegateWithMaxCrossAxisExtent(
    maxCrossAxisExtent: Grid.smallCardWidth * 2,
    mainAxisExtent: 66,
  );

  @override
  Widget buildList(ThemeData theme, List<SearchUserItemModel> list) {
    return SliverGrid.builder(
      gridDelegate: gridDelegate,
      itemBuilder: (BuildContext context, int index) {
        if (index == list.length - 1) {
          controller.onLoadMore();
        }
        return SearchUserItem(
          item: list[index],
        );
      },
      itemCount: list.length,
    );
  }

  @override
  Widget get buildLoading => SliverGrid.builder(
    gridDelegate: gridDelegate,
    itemBuilder: (context, index) => const MsgFeedTopSkeleton(),
    itemCount: 10,
  );
}
