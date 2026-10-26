import 'package:ex_piliplus/common/widgets/dialog/dialog.dart';
import 'package:ex_piliplus/http/black.dart';
import 'package:ex_piliplus/http/loading_state.dart';
import 'package:ex_piliplus/http/video.dart';
import 'package:ex_piliplus/models_new/blacklist/data.dart';
import 'package:ex_piliplus/models_new/blacklist/list.dart';
import 'package:ex_piliplus/pages/common/common_list_controller.dart';
import 'package:ex_piliplus/utils/extension/l10n_ext.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:ex_piliplus/utils/accounts.dart';
import 'package:ex_piliplus/utils/extension/num_ext.dart';
import 'package:ex_piliplus/utils/global_data.dart';
import 'package:ex_piliplus/utils/storage_pref.dart';
import 'package:material_ui/material_ui.dart';


class BlackListController
    extends CommonListController<BlackListData, BlackListItem> {
  int? _total;
  final RxInt total = (-1).obs;
  final blackMids = GlobalData().blackMids;

  @override
  void onInit() {
    super.onInit();
    if (Accounts.main.isLogin) {
      queryData();
    } else {
      loadingState.value = Error(Get.context!.l10n.accountPleaseSignIn);
    }
  }

  @override
  List<BlackListItem>? getDataList(BlackListData response) {
    _total = response.total;
    total.value = _total ?? -1;
    return response.list;
  }

  @override
  void checkIsEnd(int length) {
    if (_total != null && length >= _total!) {
      isEnd = true;
    }
  }

  Future<bool> onRemove(BuildContext context, int index, name, mid) async {
    final confirm = await showConfirmDialog(
      context: context,
      title: Text(context.l10n.blacklistRemoveConfirm('$name')),
    );
    if (!confirm) return false;

    final result = await VideoHttp.relationMod(mid: mid, act: 6, reSrc: 11);
    if (!result.isSuccess) {
      result.toast();
      return false;
    }

    loadingState
      ..value.data!.removeAt(index)
      ..refresh();
    if (_total != null) {
      _total = _total! - 1;
      total.value = _total!;
    }
    SmartDialog.showToast(context.l10n.blacklistRemoved);
    return true;
  }

  @override
  Future<LoadingState<BlackListData>> customGetData() =>
      BlackHttp.blackList(pn: page);

  @override
  void onClose() {
    super.onClose();
    if (loadingState.value case Success(:final response?)) {
      blackMids.addAll(response.map((e) => e.mid!));
    }
    Pref.blackMids = blackMids;
  }
}
