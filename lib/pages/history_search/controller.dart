import 'package:ex_piliplus/common/widgets/dialog/dialog.dart';
import 'package:ex_piliplus/http/loading_state.dart';
import 'package:ex_piliplus/http/user.dart';
import 'package:ex_piliplus/models_new/history/data.dart';
import 'package:ex_piliplus/models_new/history/list.dart';
import 'package:ex_piliplus/pages/common/multi_select/base.dart';
import 'package:ex_piliplus/pages/common/search/common_search_controller.dart';
import 'package:ex_piliplus/utils/accounts.dart';
import 'package:ex_piliplus/utils/extension/l10n_ext.dart';
import 'package:flutter/widgets.dart' show Text;
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';

class HistorySearchController
    extends CommonSearchController<HistoryData, HistoryItemModel>
    with CommonMultiSelectMixin<HistoryItemModel>, DeleteItemMixin {
  @override
  Future<LoadingState<HistoryData>> customGetData() => UserHttp.searchHistory(
    pn: page,
    keyword: editController.value.text,
    account: account,
  );

  @override
  List<HistoryItemModel>? getDataList(HistoryData response) {
    return response.list;
  }

  final account = Accounts.history;

  Future<void> onDelHistory(int index, kid, String business) async {
    final res = await UserHttp.delHistory(
      '${business}_$kid',
      account: account,
    );
    if (res.isSuccess) {
      loadingState
        ..value.data!.removeAt(index)
        ..refresh();
      SmartDialog.showToast(Get.context!.l10n.commonDeleteSucceeded);
    } else {
      res.toast();
    }
  }

  @override
  void onRemove() {
    final l10n = Get.context!.l10n;
    showConfirmDialog(
      context: Get.context!,
      title: Text(l10n.commonNotice),
      content: Text(l10n.historyDeleteSelectedConfirm),
      onConfirm: () async {
        SmartDialog.showLoading(msg: l10n.commonLoading);
        final removeList = allChecked.toSet();
        final response = await UserHttp.delHistory(
          removeList
              .map((item) => '${item.history.business!}_${item.kid!}')
              .join(','),
          account: account,
        );
        if (response.isSuccess) {
          afterDelete(removeList);
          SmartDialog.showToast(l10n.commonDeleteSucceeded);
        } else {
          response.toast();
        }
        SmartDialog.dismiss();
      },
    );
  }
}
