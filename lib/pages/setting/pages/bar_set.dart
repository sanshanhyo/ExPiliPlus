import 'package:ex_piliplus/common/widgets/pair.dart';
import 'package:ex_piliplus/common/widgets/reorder_mixin.dart';
import 'package:ex_piliplus/models/common/enum_with_label.dart';
import 'package:ex_piliplus/models/common/home_tab_type.dart';
import 'package:ex_piliplus/models/common/nav_bar_config.dart';
import 'package:ex_piliplus/utils/extension/l10n_ext.dart';
import 'package:ex_piliplus/utils/storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';

class BarSetPage extends StatefulWidget {
  const BarSetPage({super.key});

  @override
  State<BarSetPage> createState() => _BarSetPageState();
}

class _BarSetPageState extends State<BarSetPage> with ReorderMixin {
  late final String key;
  late final String title;
  late final List<Pair<EnumWithLabel, bool>> list;
  late EdgeInsets padding;

  @override
  void initState() {
    super.initState();
    final Map<String, dynamic> args = Get.arguments;
    key = args['key'];
    title = args['title'];
    final List? cache = GStorage.setting.get(key);
    list = (args['defaultBars'] as List<EnumWithLabel>)
        .map((e) => Pair(first: e, second: cache?.contains(e.index) ?? true))
        .toList();
    if (cache != null && cache.isNotEmpty) {
      final cacheIndex = {for (int i = 0; i < cache.length; i++) cache[i]: i};
      list.sort((a, b) {
        final indexA = cacheIndex[a.first.index] ?? cacheIndex.length;
        final indexB = cacheIndex[b.first.index] ?? cacheIndex.length;
        return indexA.compareTo(indexB);
      });
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final viewPad = MediaQuery.viewPaddingOf(context);
    padding = .only(top: 10, right: viewPad.right + 34, bottom: viewPad.bottom);
  }

  void saveEdit() {
    GStorage.setting.put(
      key,
      list.where((e) => e.second).map((e) => e.first.index).toList(),
    );
    SmartDialog.showToast(context.l10n.settingsSavedNextLaunch);
  }

  void onReset() {
    Get.back();
    GStorage.setting.delete(key);
    SmartDialog.showToast(context.l10n.settingsResetNextLaunch);
  }

  void onReorderItem(int oldIndex, int newIndex) {
    list.insert(newIndex, list.removeAt(oldIndex));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(context.l10n.settingsEditTitle(title)),
        actions: [
          TextButton(
            onPressed: onReset,
            child: Text(context.l10n.settingsReset),
          ),
          TextButton(
            onPressed: saveEdit,
            child: Text(context.l10n.settingsSave),
          ),
          const SizedBox(width: 12),
        ],
      ),
      body: ReorderableListView(
        onReorderItem: onReorderItem,
        proxyDecorator: proxyDecorator,
        footer: Padding(
          padding: padding,
          child: Align(
            alignment: Alignment.centerRight,
            child: Text(context.l10n.settingsLongPressToReorder),
          ),
        ),
        children: list
            .map(
              (e) => CheckboxListTile(
                key: ValueKey(e.hashCode),
                value: e.second,
                onChanged: (bool? value) {
                  e.second = value!;
                  setState(() {});
                },
                title: Text(
                  switch (e.first) {
                    final HomeTabType type => type.localizedLabel(context.l10n),
                    final NavigationBarType type => type.localizedLabel(
                      context.l10n,
                    ),
                    _ => e.first.label,
                  },
                ),
                secondary: const Icon(Icons.drag_indicator_rounded),
              ),
            )
            .toList(),
      ),
    );
  }
}
