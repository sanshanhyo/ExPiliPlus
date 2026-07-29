import 'package:ex_piliplus/common/widgets/dialog/dialog.dart';
import 'package:ex_piliplus/common/widgets/image/network_img_layer.dart';
import 'package:ex_piliplus/models/common/dynamic/dynamic_banned_up.dart';
import 'package:ex_piliplus/models/common/image_type.dart';
import 'package:ex_piliplus/pages/dynamics/controller.dart';
import 'package:ex_piliplus/utils/extension/l10n_ext.dart';
import 'package:ex_piliplus/utils/storage_pref.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';

class DynamicBannedUpListPage extends StatefulWidget {
  const DynamicBannedUpListPage({super.key});

  @override
  State<DynamicBannedUpListPage> createState() =>
      _DynamicBannedUpListPageState();
}

class _DynamicBannedUpListPageState extends State<DynamicBannedUpListPage> {
  late List<DynamicBannedUp> _items;

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  void _loadItems() {
    _items = Pref.dynamicBannedUps.toList()
      ..sort((a, b) {
        final aName = a.name.isEmpty ? a.mid.toString() : a.name;
        final bName = b.name.isEmpty ? b.mid.toString() : b.name;
        return aName.compareTo(bName);
      });
  }

  Future<void> _remove(DynamicBannedUp item) async {
    final l10n = context.l10n;
    final name = item.name.isEmpty
        ? l10n.dynamicBlockedUpUnknownName(item.mid.toString())
        : item.name;
    final confirmed = await showConfirmDialog(
      context: context,
      title: Text(l10n.dynamicBlockedUpRemoveConfirm(name)),
    );
    if (!confirmed) return;

    await Pref.setDynamicAuthorPermanentlyBlocked(item.mid, false);
    if (Get.isRegistered<DynamicsController>()) {
      Get.find<DynamicsController>().reloadDynamicTabs();
    }
    if (mounted) {
      setState(_loadItems);
    }
    SmartDialog.showToast(l10n.dynamicBlockedUpRemoved);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          l10n.dynamicBlockedUpListTitle(_items.length),
        ),
      ),
      body: _items.isEmpty
          ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.visibility_off_outlined,
                    size: 48,
                    color: Theme.of(context).colorScheme.outline,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    l10n.dynamicBlockedUpListEmpty,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.outline,
                    ),
                  ),
                ],
              ),
            )
          : ListView.separated(
              padding: EdgeInsets.only(
                bottom: MediaQuery.viewPaddingOf(context).bottom + 32,
              ),
              itemCount: _items.length,
              separatorBuilder: (_, _) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final item = _items[index];
                return ListTile(
                  onTap: () => Get.toNamed('/member?mid=${item.mid}'),
                  leading: NetworkImgLayer(
                    src: item.face,
                    width: 44,
                    height: 44,
                    type: ImageType.avatar,
                  ),
                  title: Text(
                    item.name.isEmpty
                        ? l10n.dynamicBlockedUpUnknownName(item.mid.toString())
                        : item.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text(
                    l10n.dynamicBlockedUpUid(item.mid.toString()),
                  ),
                  trailing: TextButton(
                    onPressed: () => _remove(item),
                    child: Text(l10n.commonRemove),
                  ),
                );
              },
            ),
    );
  }
}
