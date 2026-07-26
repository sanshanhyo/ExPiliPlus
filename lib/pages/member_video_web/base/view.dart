import 'package:ex_piliplus/common/widgets/button/icon_button.dart';
import 'package:ex_piliplus/common/widgets/dialog/dialog.dart';
import 'package:ex_piliplus/common/widgets/flutter/refresh_indicator.dart';
import 'package:ex_piliplus/common/widgets/loading_widget/http_error.dart';
import 'package:ex_piliplus/common/widgets/scroll_physics.dart';
import 'package:ex_piliplus/common/widgets/sliver/sliver_pinned_header.dart';
import 'package:ex_piliplus/common/widgets/video_card/video_card_h.dart';
import 'package:ex_piliplus/http/loading_state.dart';
import 'package:ex_piliplus/models/common/enum_with_label.dart';
import 'package:ex_piliplus/models/common/member/archive_order_type_web.dart';
import 'package:ex_piliplus/models/common/member/archive_sort_type_app.dart';
import 'package:ex_piliplus/models/horizontal_video_model.dart';
import 'package:ex_piliplus/pages/member_video_web/base/controller.dart';
import 'package:ex_piliplus/pages/search/widgets/search_text.dart';
import 'package:ex_piliplus/utils/extension/l10n_ext.dart';
import 'package:ex_piliplus/utils/grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';

abstract class BaseVideoWebState<
  S extends StatefulWidget,
  R,
  T extends HorizontalVideoModel,
  V extends EnumWithLabel
>
    extends State<S>
    with GridMixin {
  late final String name;
  BaseVideoWebCtr<R, T, V> get controller;

  @override
  void initState() {
    super.initState();
    final args = Get.arguments;
    name = args['name'];
  }

  List<V> get values;

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(name),
        actions: [
          Obx(
            () {
              final order = controller.order.value;
              return PopupMenuButton<V>(
                tooltip: context.l10n.commonSort,
                icon: const Icon(Icons.sort),
                initialValue: order,
                onSelected: controller.queryBySort,
                itemBuilder: (_) => values
                    .map(
                      (e) => PopupMenuItem(
                        value: e,
                        child: Text(_localizedOrderLabel(e)),
                      ),
                    )
                    .toList(),
              );
            },
          ),
          const SizedBox(width: 6),
        ],
      ),
      body: refreshIndicator(
        onRefresh: controller.onRefresh,
        child: CustomScrollView(
          physics: ReloadScrollPhysics(controller: controller),
          slivers: [
            SliverPadding(
              padding: .only(
                bottom: MediaQuery.viewPaddingOf(context).bottom + 100,
              ),
              sliver: Obx(
                () => buildBody(colorScheme, controller.loadingState.value),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBody(
    ColorScheme colorScheme,
    LoadingState<List<T>?> loadingState,
  ) {
    return switch (loadingState) {
      Loading() => gridSkeleton,
      Success(:final response) =>
        response != null && response.isNotEmpty
            ? SliverMainAxisGroup(
                slivers: [
                  buildHeader(colorScheme),
                  ?buildTags(colorScheme),
                  SliverGrid.builder(
                    gridDelegate: gridDelegate,
                    itemCount: response.length,
                    itemBuilder: (context, index) {
                      if (index == response.length - 1) {
                        controller.onLoadMore();
                      }
                      // TODO: dimension
                      return VideoCardH(videoItem: response[index]);
                    },
                  ),
                ],
              )
            : HttpError(onReload: controller.onReload),
      Error(:final errMsg) => HttpError(
        errMsg: errMsg,
        onReload: controller.onReload,
      ),
    };
  }

  Widget? buildTags(ColorScheme colorScheme) => null;

  Widget buildHeader(ColorScheme colorScheme) {
    return SliverPinnedHeader(
      backgroundColor: colorScheme.surface,
      child: Padding(
        padding: const .fromLTRB(14, 0, 8, 4),
        child: Stack(
          clipBehavior: .none,
          alignment: .centerLeft,
          children: [
            ?buildCount(),
            Center(child: buildPageBtn(colorScheme)),
          ],
        ),
      ),
    );
  }

  Widget? buildCount() {
    final count = controller.count;
    if (count == null) return null;
    return Text(
      context.l10n.videoCount(count),
      style: const TextStyle(height: 1),
      strutStyle: const StrutStyle(leading: 0, height: 1),
    );
  }

  Widget? buildPageBtn(ColorScheme colorScheme) {
    final totalPage = controller.totalPage;
    if (totalPage == null) return null;
    final page = controller.page - 1;
    final canBackward = page > 1;
    final canForward = page < totalPage;
    const size = 30.0;
    const iconSize = 24.0;

    final backwardBtn = iconButton(
      size: size,
      iconSize: iconSize,
      tooltip: canBackward ? context.l10n.commonPrevious : null,
      icon: const Icon(Icons.keyboard_arrow_left),
      onPressed: canBackward ? () => controller.jumpToPage(page - 1) : null,
    );

    final forwardBtn = iconButton(
      size: size,
      iconSize: iconSize,
      tooltip: canForward ? context.l10n.commonNext : null,
      icon: const Icon(Icons.keyboard_arrow_right),
      onPressed: canForward ? () => controller.jumpToPage(page + 1) : null,
    );

    final pageIndicator = SearchText(
      height: 1,
      text: '$page / $totalPage',
      borderRadius: const .all(.circular(4)),
      padding: const .symmetric(horizontal: 10, vertical: 5),
      onTap: (_) => showJumpDialog(page),
    );

    return Row(
      spacing: 6,
      mainAxisSize: .min,
      children: [
        backwardBtn,
        pageIndicator,
        forwardBtn,
      ],
    );
  }

  void showJumpDialog(int page) {
    var pageStr = page.toString();

    void onSubmit([_]) {
      try {
        controller.jumpToPage(
          int.parse(pageStr).clamp(1, controller.totalPage!),
        );
      } catch (e) {
        SmartDialog.showToast(e.toString());
      }
    }

    showConfirmDialog(
      context: context,
      title: Text(context.l10n.memberJumpToPage),
      content: TextFormField(
        autofocus: true,
        initialValue: pageStr,
        onChanged: (value) => pageStr = value,
        decoration: InputDecoration(
          labelText: context.l10n.memberPageNumber,
          border: const OutlineInputBorder(),
        ),
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        onFieldSubmitted: (_) {
          Get.back();
          onSubmit();
        },
      ),
      onConfirm: onSubmit,
    );
  }

  String _localizedOrderLabel(V value) => switch (value) {
    ArchiveOrderTypeWeb e => e.localizedLabel(context.l10n),
    ArchiveSortTypeApp e => e.localizedLabel(context.l10n),
    _ => value.label,
  };
}
