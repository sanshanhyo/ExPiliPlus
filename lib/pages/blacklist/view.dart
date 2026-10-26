import 'package:ex_piliplus/common/skeleton/msg_feed_top.dart';
import 'package:ex_piliplus/common/widgets/flutter/refresh_indicator.dart';
import 'package:ex_piliplus/common/widgets/image/network_img_layer.dart';
import 'package:ex_piliplus/common/widgets/loading_widget/http_error.dart';
import 'package:ex_piliplus/http/loading_state.dart';
import 'package:ex_piliplus/models/common/image_type.dart';
import 'package:ex_piliplus/models_new/blacklist/list.dart';
import 'package:ex_piliplus/pages/blacklist/controller.dart';
import 'package:ex_piliplus/utils/date_utils.dart';
import 'package:ex_piliplus/utils/global_data.dart';
import 'package:ex_piliplus/utils/extension/l10n_ext.dart';
import 'package:ex_piliplus/utils/storage_pref.dart';
import 'package:material_ui/material_ui.dart';
import 'package:ex_piliplus/common/sliver_single_child_delegate.dart';
import 'package:ex_piliplus/common/widgets/scaffold/simple_scaffold.dart';
import 'package:ex_piliplus/common/widgets/dialog/dialog.dart';
import 'package:ex_piliplus/common/widgets/dialog/export_import.dart';
import 'package:ex_piliplus/common/widgets/scroll_physics.dart';
import 'package:ex_piliplus/common/widgets/sliver_wrap.dart';
import 'package:ex_piliplus/common/widgets/view_sliver_safe_area.dart';
import 'package:ex_piliplus/pages/search/widgets/search_text.dart';
import 'package:ex_piliplus/utils/utils.dart';
import 'package:flutter/services.dart' show FilteringTextInputFormatter;
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

import 'package:get/get.dart';

enum _BlockType { local, online }

class BlackListPage extends StatefulWidget {
  const BlackListPage({super.key});

  @override
  State<BlackListPage> createState() => _BlackListPageState();
}

class _BlackListPageState extends State<BlackListPage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  final _blackListController = Get.put(BlackListController());
  late EdgeInsets padding;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: _BlockType.values.length,
      vsync: this,
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    padding = MediaQuery.viewPaddingOf(context);
  }

  @override
  void dispose() {
    if (_blackListController.loadingState.value case Success(:final response)) {
      final blackMids = response?.map((e) => e.mid!).toSet() ?? {};
      GlobalData().blackMids = blackMids;
      Pref.blackMids = blackMids;
    }
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Obx(
          () => Text(
            context.l10n.blacklistTitle(
              _blackListController.total.value == -1
                  ? ''
                  : context.l10n.blacklistCountSuffix(
                      _blackListController.total.value.toString(),
                    ),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          TabBar(
            controller: _tabController,
            tabs: _BlockType.values
                .map(
                  (type) => Tab(
                    text: switch (type) {
                      _BlockType.local => context.l10n.blacklistLocal,
                      _BlockType.online => context.l10n.blacklistOnline,
                    },
                  ),
                )
                .toList(),
          ),
          Expanded(
            child: tabBarView(
              controller: _tabController,
              children: _BlockType.values
                  .map(
                    (type) => switch (type) {
                      _BlockType.local => _local,
                      _BlockType.online => _online,
                    },
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget get _online {
    return refreshIndicator(
      onRefresh: _blackListController.onRefresh,
      child: CustomScrollView(
        key: const PageStorageKey(_BlockType.online),
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          ViewSliverSafeArea(
            sliver: Obx(
              () => _buildBody(_blackListController.loadingState.value),
            ),
          ),
        ],
      ),
    );
  }

  void _onAddMid(String mid) {
    if (mid.isEmpty) return;
    int intMid;
    try {
      intMid = int.parse(mid);
    } catch (e) {
      SmartDialog.showToast(e.toString());
      return;
    }
    _blackListController.blackMids.add(intMid);
    SmartDialog.showToast(context.l10n.commonSucceeded);
    setState(() {});
  }

  void _showAddMidDialog() {
    var text = '';
    showConfirmDialog(
      context: context,
      title: Text(context.l10n.blacklistAddMid),
      content: TextField(
        autofocus: true,
        textInputAction: .done,
        keyboardType: .number,
        onChanged: (value) => text = value,
        onSubmitted: (value) {
          Get.back();
          _onAddMid(value);
        },
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        decoration: InputDecoration(
          labelText: context.l10n.blacklistUid,
          border: const OutlineInputBorder(),
        ),
      ),
      onConfirm: () => _onAddMid(text),
    );
  }

  void _showImportExportDialog() {
    showImportExportDialog<List>(
      context,
      title: context.l10n.blacklistTitle(''),
      localFileName: () => 'blackMids',
      onExport: () =>
          Utils.jsonEncoder.convert(_blackListController.blackMids.toList()),
      onImport: (json) {
        final mids = Set<int>.from(json);
        _blackListController.blackMids.addAll(mids);
        setState(() {});
      },
    );
  }

  Widget get _local {
    return ScaffoldLayout(
      fab: Padding(
        padding: .only(
          right: kFloatingActionButtonMargin + padding.right,
          bottom: kFloatingActionButtonMargin + padding.bottom,
        ),
        child: Column(
          spacing: kFloatingActionButtonMargin,
          mainAxisSize: .min,
          children: [
            FloatingActionButton(
              tooltip: context.l10n.blacklistImportExport,
              onPressed: _showImportExportDialog,
              child: const Icon(Icons.swap_vert, size: 26),
            ),
            FloatingActionButton(
              tooltip: context.l10n.blacklistAddMid,
              onPressed: _showAddMidDialog,
              child: const Icon(Icons.add),
            ),
          ],
        ),
      ),
      body: CustomScrollView(
        key: const PageStorageKey(_BlockType.local),
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          ViewSliverSafeArea(
            bottom: 180,
            sliver: SliverPadding(
              padding: const .fromLTRB(12, 12, 12, 0),
              sliver: SliverFixedWrap(
                spacing: 8,
                runSpacing: 8,
                mainAxisExtent: 30,
                delegate: SliverChildBuilderDelegate(
                  addAutomaticKeepAlives: false,
                  addRepaintBoundaries: false,
                  childCount: _blackListController.blackMids.length,
                  (context, index) {
                    final mid = _blackListController.blackMids.elementAt(index);
                    return SearchText(
                      text: mid.toString(),
                      onTap: (mid) => Get.toNamed('/member?mid=$mid'),
                      onLongPress: (_) => showConfirmDialog(
                        context: context,
                        title: Text(context.l10n.blacklistRemoveConfirm(mid.toString())),
                        onConfirm: () {
                          _blackListController.blackMids.remove(mid);
                          setState(() {});
                        },
                      ),
                      height: 1,
                      maxLines: 1,
                      fontSize: 14,
                      overflow: .ellipsis,
                      padding: const .fromLTRB(11, 8, 11, 0),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBody(LoadingState<List<BlackListItem>?> loadingState) {
    late final style = TextStyle(color: Theme.of(context).colorScheme.outline);
    return switch (loadingState) {
      Loading() => const SliverPrototypeExtentList(
        prototypeItem: MsgFeedTopSkeleton(),
        delegate: SliverSingleChildDelegate(
          count: 12,
          child: MsgFeedTopSkeleton(),
        ),
      ),
      Success(:final response) =>
        response != null && response.isNotEmpty
            ? SliverList.builder(
                itemCount: response.length,
                itemBuilder: (BuildContext context, int index) {
                  if (index == response.length - 1) {
                    _blackListController.onLoadMore();
                  }
                  final item = response[index];
                  return ListTile(
                    visualDensity: .standard,
                    onTap: () => Get.toNamed('/member?mid=${item.mid}'),
                    leading: NetworkImgLayer(
                      width: 45,
                      height: 45,
                      type: ImageType.avatar,
                      src: item.face,
                    ),
                    title: Text(
                      item.uname!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 14),
                    ),
                    subtitle: Text(
                      context.l10n.blacklistAddedAt(
                        DateFormatUtils.format(
                          item.mtime,
                          format: DateFormatUtils.longFormatDs,
                        ),
                      ),
                      maxLines: 1,
                      style: style,
                      overflow: TextOverflow.ellipsis,
                    ),
                    dense: true,
                    trailing: TextButton(
                      onPressed: () => _blackListController.onRemove(
                        context,
                        index,
                        item.uname,
                        item.mid,
                      ),
                      child: Text(context.l10n.commonRemove),
                    ),
                  );
                },
              )
            : HttpError(onReload: _blackListController.onReload),
      Error(:final errMsg) => HttpError(
        errMsg: errMsg,
        onReload: _blackListController.onReload,
      ),
    };
  }
}
