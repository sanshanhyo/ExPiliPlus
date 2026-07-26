import 'package:ex_piliplus/common/widgets/appbar/appbar.dart';
import 'package:ex_piliplus/common/widgets/flutter/pop_scope.dart';
import 'package:ex_piliplus/common/widgets/loading_widget/http_error.dart';
import 'package:ex_piliplus/common/widgets/view_sliver_safe_area.dart';
import 'package:ex_piliplus/http/loading_state.dart';
import 'package:ex_piliplus/pages/common/multi_select/base.dart';
import 'package:ex_piliplus/pages/common/search/common_search_controller.dart';
import 'package:ex_piliplus/utils/extension/l10n_ext.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class CommonSearchPageState<S extends StatefulWidget, R, T>
    extends State<S> {
  CommonSearchController<R, T> get controller;

  List<Widget>? get extraActions => null;

  List<Widget>? get multiSelectActions => null;

  @override
  Widget build(BuildContext context) {
    if (controller case final MultiSelectBase multiCtr) {
      return Obx(() {
        final enableMultiSelect = multiCtr.enableMultiSelect.value;
        return popScope(
          canPop: !enableMultiSelect,
          onPopInvokedWithResult: (didPop, result) {
            if (enableMultiSelect) {
              multiCtr.handleSelect();
            }
          },
          child: _build(true),
        );
      });
    }
    return _build(false);
  }

  Widget _build(bool multiSelect) {
    return Scaffold(
      appBar: _buildBar(multiSelect),
      body: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        controller: controller.scrollController,
        slivers: [
          ViewSliverSafeArea(
            sliver: Obx(() => _buildBody(controller.loadingState.value)),
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildBar(bool multiSelect) {
    final AppBar bar = AppBar(
      actions: [
        IconButton(
          tooltip: context.l10n.commonSearch,
          onPressed: controller.onRefresh,
          icon: const Icon(Icons.search_outlined, size: 22),
        ),
        ...?extraActions,
        const SizedBox(width: 10),
      ],
      title: TextField(
        autofocus: true,
        focusNode: controller.focusNode,
        controller: controller.editController,
        textInputAction: TextInputAction.search,
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          hintText: context.l10n.commonSearch,
          visualDensity: .standard,
          border: InputBorder.none,
          suffixIcon: IconButton(
            tooltip: context.l10n.commonClear,
            icon: const Icon(Icons.clear, size: 22),
            onPressed: () => controller
              ..loadingState.value = LoadingState.loading()
              ..onClear()
              ..focusNode.requestFocus(),
          ),
        ),
        onSubmitted: (value) => controller.onRefresh(),
      ),
    );
    if (multiSelect) {
      return MultiSelectAppBarWidget(
        ctr: controller as MultiSelectBase,
        actions: multiSelectActions,
        child: bar,
      );
    }
    return bar;
  }

  Widget _buildBody(LoadingState<List<T>?> loadingState) {
    return switch (loadingState) {
      Loading() => const HttpError(),
      Success(:final response) =>
        response != null && response.isNotEmpty
            ? buildList(response)
            : HttpError(onReload: controller.onReload),
      Error(:final errMsg) => HttpError(
        errMsg: errMsg,
        onReload: controller.onReload,
      ),
    };
  }

  Widget buildList(List<T> list);
}
