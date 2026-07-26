import 'package:ex_piliplus/http/fav.dart';
import 'package:ex_piliplus/http/loading_state.dart';
import 'package:ex_piliplus/http/user.dart';
import 'package:ex_piliplus/models_new/sub/sub/data.dart';
import 'package:ex_piliplus/models_new/sub/sub/list.dart';
import 'package:ex_piliplus/pages/common/common_list_controller.dart';
import 'package:ex_piliplus/utils/accounts.dart';
import 'package:ex_piliplus/utils/extension/l10n_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';

class SubController extends CommonListController<SubData, SubItemModel> {
  late final account = Accounts.main;

  @override
  void onInit() {
    super.onInit();
    queryData();
  }

  @override
  Future<void> queryData([bool isRefresh = true]) {
    if (!account.isLogin) {
      loadingState.value = Error(Get.context!.l10n.accountPleaseSignIn);
      return Future.syncValue(null);
    }
    return super.queryData(isRefresh);
  }

  // 取消订阅
  void cancelSub(SubItemModel subFolderItem) {
    final l10n = Get.context!.l10n;
    showDialog(
      context: Get.context!,
      builder: (context) => AlertDialog(
        title: Text(l10n.commonNotice),
        content: Text(l10n.subscriptionCancelConfirm),
        actions: [
          TextButton(
            onPressed: Get.back,
            child: Text(
              l10n.commonCancel,
              style: TextStyle(color: Theme.of(context).colorScheme.outline),
            ),
          ),
          TextButton(
            onPressed: () async {
              final res = await FavHttp.cancelSub(
                id: subFolderItem.id!,
                type: subFolderItem.type!,
              );
              if (res.isSuccess) {
                loadingState
                  ..value.data!.remove(subFolderItem)
                  ..refresh();
                SmartDialog.showToast(l10n.subscriptionCanceled);
              } else {
                res.toast();
              }
              Get.back();
            },
            child: Text(l10n.commonConfirm),
          ),
        ],
      ),
    );
  }

  @override
  List<SubItemModel>? getDataList(SubData response) {
    if (response.hasMore == false) {
      isEnd = true;
    }
    return response.list;
  }

  @override
  Future<LoadingState<SubData>> customGetData() => UserHttp.userSubFolder(
    pn: page,
    ps: 20,
    mid: account.mid,
  );
}
