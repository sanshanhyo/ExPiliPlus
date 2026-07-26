import 'package:ex_piliplus/common/widgets/reorder_mixin.dart';
import 'package:ex_piliplus/http/fav.dart';
import 'package:ex_piliplus/http/loading_state.dart';
import 'package:ex_piliplus/models_new/fav/fav_folder/list.dart';
import 'package:ex_piliplus/pages/fav/video/controller.dart';
import 'package:ex_piliplus/pages/fav/video/widgets/item.dart';
import 'package:ex_piliplus/utils/extension/l10n_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';

class FavFolderSortPage extends StatefulWidget {
  const FavFolderSortPage({super.key, required this.favController});

  final FavController favController;

  @override
  State<FavFolderSortPage> createState() => _FavFolderSortPageState();
}

class _FavFolderSortPageState extends State<FavFolderSortPage>
    with ReorderMixin {
  FavController get _favController => widget.favController;

  late List<FavFolderInfo> sortList = List<FavFolderInfo>.from(
    _favController.loadingState.value.data!,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(context.l10n.favoriteFolderSortTitle),
        actions: [
          TextButton(
            onPressed: () async {
              final successMessage = context.l10n.followSortCompleted;
              final res = await FavHttp.sortFavFolder(
                sort: sortList.map((item) => item.id).join(','),
              );
              if (res.isSuccess) {
                SmartDialog.showToast(successMessage);
                _favController.loadingState.value = Success(sortList);
                if (mounted) {
                  Get.back();
                }
              } else {
                res.toast();
              }
            },
            child: Text(context.l10n.commonDone),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: _buildBody,
    );
  }

  void onReorderItem(int oldIndex, int newIndex) {
    if (oldIndex == 0 || newIndex == 0) {
      SmartDialog.showToast(context.l10n.favoriteDefaultFolderSortUnsupported);
      return;
    }

    sortList.insert(newIndex, sortList.removeAt(oldIndex));

    setState(() {});
  }

  Widget get _buildBody {
    return ReorderableListView.builder(
      onReorderItem: onReorderItem,
      proxyDecorator: proxyDecorator,
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: sortList.length,
      padding:
          MediaQuery.viewPaddingOf(context).copyWith(top: 0) +
          const EdgeInsets.only(bottom: 100),
      itemBuilder: (context, index) {
        final item = sortList[index];
        final key = item.id.toString();
        return SizedBox(
          key: Key(key),
          height: 110,
          child: FavVideoItem(
            heroTag: key,
            item: item,
            onLongPress: index == 0
                ? () => SmartDialog.showToast(
                    context.l10n.favoriteDefaultFolderSortUnsupported,
                  )
                : null,
          ),
        );
      },
    );
  }
}
