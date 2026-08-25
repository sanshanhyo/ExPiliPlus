import 'package:ex_piliplus/common/widgets/button/icon_button.dart';
import 'package:ex_piliplus/common/widgets/dialog/dialog.dart';
import 'package:ex_piliplus/common/widgets/keep_alive_wrapper.dart';
import 'package:ex_piliplus/common/widgets/loading_widget/loading_widget.dart';
import 'package:ex_piliplus/common/widgets/scroll_physics.dart';
import 'package:ex_piliplus/models/common/dm_block_type.dart';
import 'package:ex_piliplus/models/user/danmaku_block.dart';
import 'package:ex_piliplus/models/user/danmaku_rule.dart';
import 'package:ex_piliplus/pages/danmaku_block/controller.dart';
import 'package:ex_piliplus/plugin/pl_player/controller.dart';
import 'package:ex_piliplus/utils/storage.dart';
import 'package:ex_piliplus/utils/extension/l10n_ext.dart';
import 'package:ex_piliplus/utils/storage_key.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';

class DanmakuBlockPage extends StatefulWidget {
  const DanmakuBlockPage({super.key});

  @override
  State<DanmakuBlockPage> createState() => _DanmakuBlockPageState();
}

class _DanmakuBlockPageState extends State<DanmakuBlockPage> {
  final DanmakuBlockController _controller = Get.put(DanmakuBlockController());
  late PlPlayerController plPlayerController;

  @override
  void initState() {
    super.initState();
    plPlayerController = Get.arguments as PlPlayerController;
  }

  @override
  void dispose() {
    final ruleFilter = RuleFilter.fromRuleTypeEntries(_controller.rules);
    plPlayerController.filters = ruleFilter;
    GStorage.localCache.put(LocalCacheKey.danmakuFilterRules, ruleFilter);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(context.l10n.danmakuBlockTitle),
        bottom: TabBar(
          controller: _controller.tabController,
          tabs: DmBlockType.values
              .map(
                (e) => Obx(
                  () => Tab(
                    text: context.l10n.danmakuBlockTabCount(
                      e.localizedLabel(context.l10n),
                      _controller.rules[e.index].length,
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ),
      body: tabBarView(
        controller: _controller.tabController,
        children: DmBlockType.values
            .map(
              (e) => KeepAliveWrapper(
                child: Obx(
                  () => tabViewBuilder(e.index, _controller.rules[e.index]),
                ),
              ),
            )
            .toList(),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: context.l10n.commonAdd,
        onPressed: () =>
            _showAddDialog(DmBlockType.values[_controller.tabController.index]),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget tabViewBuilder(int tabIndex, List<SimpleRule> list) {
    if (list.isEmpty) {
      return scrollableError;
    }
    return ListView.builder(
      itemCount: list.length,
      padding: EdgeInsets.only(
        bottom: MediaQuery.viewPaddingOf(context).bottom + 100,
      ),
      itemBuilder: (context, itemIndex) {
        final SimpleRule item = list[itemIndex];
        final child = iconButton(
          iconSize: 20,
          tooltip: context.l10n.commonDelete,
          icon: const Icon(Icons.delete_outlined),
          onPressed: () => showConfirmDialog(
            context: context,
            title: Text(context.l10n.danmakuDeleteRuleConfirm),
            onConfirm: () => _controller.danmakuFilterDel(
              tabIndex,
              itemIndex,
              item.id,
            ),
          ),
        );
        return ListTile(
          title: Text(
            item.filter,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          trailing: tabIndex == 2
              ? child
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    iconButton(
                      iconSize: 20,
                      tooltip: context.l10n.commonEdit,
                      icon: const Icon(Icons.edit_outlined),
                      onPressed: () => _showAddDialog(
                        DmBlockType.values[_controller.tabController.index],
                        initFilter: item.filter,
                        itemIndex: itemIndex,
                        itemId: item.id,
                      ),
                    ),
                    child,
                  ],
                ),
        );
      },
    );
  }

  void _showAddDialog(
    DmBlockType type, {
    String initFilter = '',
    int? itemIndex,
    int? itemId,
  }) {
    assert((itemIndex == null) == (itemId == null));
    String filter = initFilter;
    final hintText = switch (type) {
      DmBlockType.keyword => context.l10n.danmakuKeywordHint,
      DmBlockType.regex => context.l10n.danmakuRegexHint,
      DmBlockType.uid => context.l10n.danmakuUidHint,
    };
    final isUid = type == DmBlockType.uid;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          context.l10n.danmakuRuleDialogTitle(
            itemId != null ? context.l10n.commonEdit : context.l10n.commonAdd,
            type.localizedLabel(context.l10n),
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(hintText),
            TextFormField(
              autofocus: true,
              initialValue: filter,
              onChanged: (value) => filter = value,
              keyboardType: isUid ? TextInputType.number : null,
              inputFormatters: isUid
                  ? [FilteringTextInputFormatter.digitsOnly]
                  : null,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: Get.back,
            child: Text(
              context.l10n.commonCancel,
              style: TextStyle(color: Theme.of(context).colorScheme.outline),
            ),
          ),
          TextButton(
            child: Text(context.l10n.commonConfirm),
            onPressed: () async {
              if (filter != initFilter) {
                Get.back();
                if (itemId != null) {
                  await _controller.danmakuFilterDel(
                    type.index,
                    itemIndex!,
                    itemId,
                  );
                }
                await _controller.danmakuFilterAdd(
                  filter: filter,
                  type: type.index,
                );
              } else {
                SmartDialog.showToast(
                  filter.isEmpty
                      ? context.l10n.danmakuInputEmpty
                      : context.l10n.danmakuInputUnchanged,
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
