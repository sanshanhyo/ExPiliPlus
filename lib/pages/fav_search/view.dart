import 'package:ex_piliplus/models/common/fav_order_type.dart';
import 'package:ex_piliplus/models_new/fav/fav_detail/data.dart';
import 'package:ex_piliplus/models_new/fav/fav_detail/media.dart';
import 'package:ex_piliplus/pages/common/search/common_search_page.dart';
import 'package:ex_piliplus/pages/fav_detail/widget/fav_video_card.dart';
import 'package:ex_piliplus/pages/fav_search/controller.dart';
import 'package:ex_piliplus/utils/accounts.dart';
import 'package:ex_piliplus/utils/extension/l10n_ext.dart';
import 'package:ex_piliplus/utils/grid.dart';
import 'package:ex_piliplus/utils/request_utils.dart';
import 'package:ex_piliplus/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FavSearchPage extends StatefulWidget {
  const FavSearchPage({super.key});

  @override
  State<FavSearchPage> createState() => _FavSearchPageState();
}

class _FavSearchPageState
    extends
        CommonSearchPageState<FavSearchPage, FavDetailData, FavDetailItemModel>
    with GridMixin {
  @override
  final FavSearchController controller = Get.put(
    FavSearchController(),
    tag: Utils.generateRandomString(8),
  );

  @override
  List<Widget>? get multiSelectActions {
    final btnStyle = TextButton.styleFrom(visualDensity: .compact);
    final textStyle = TextStyle(
      color: ColorScheme.of(context).onSurfaceVariant,
    );
    return [
      TextButton(
        style: btnStyle,
        onPressed: () => RequestUtils.onCopyOrMove<FavDetailItemModel>(
          context: context,
          isCopy: true,
          ctr: controller,
          mediaId: controller.mediaId,
          mid: Accounts.main.mid,
        ),
        child: Text(context.l10n.commonCopy, style: textStyle),
      ),
      TextButton(
        style: btnStyle,
        onPressed: () => RequestUtils.onCopyOrMove<FavDetailItemModel>(
          context: context,
          isCopy: false,
          ctr: controller,
          mediaId: controller.mediaId,
          mid: Accounts.main.mid,
        ),
        child: Text(context.l10n.commonMove, style: textStyle),
      ),
    ];
  }

  @override
  List<Widget>? get extraActions => [
    Obx(
      () {
        return PopupMenuButton<FavOrderType>(
          icon: const Icon(Icons.sort),
          requestFocus: false,
          initialValue: controller.order.value,
          tooltip: context.l10n.favoriteSortMethod,
          onSelected: (value) => controller
            ..order.value = value
            ..onReload(),
          itemBuilder: (context) => FavOrderType.values
              .map(
                (e) => PopupMenuItem(
                  value: e,
                  child: Text(e.localizedLabel(context.l10n)),
                ),
              )
              .toList(),
        );
      },
    ),
  ];

  @override
  Widget buildList(List<FavDetailItemModel> list) {
    return SliverGrid.builder(
      gridDelegate: gridDelegate,
      itemBuilder: (context, index) {
        if (index == list.length - 1) {
          controller.onLoadMore();
        }
        final item = list[index];
        return FavVideoCardH(
          item: item,
          index: index,
          ctr: controller,
        );
      },
      itemCount: list.length,
    );
  }
}
