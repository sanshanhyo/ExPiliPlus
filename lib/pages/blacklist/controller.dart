import 'package:ex_piliplus/common/widgets/dialog/dialog.dart';
import 'package:ex_piliplus/http/black.dart';
import 'package:ex_piliplus/http/loading_state.dart';
import 'package:ex_piliplus/http/video.dart';
import 'package:ex_piliplus/models_new/blacklist/data.dart';
import 'package:ex_piliplus/models_new/blacklist/list.dart';
import 'package:ex_piliplus/pages/common/common_list_controller.dart';
import 'package:ex_piliplus/utils/extension/l10n_ext.dart';
import 'package:flutter/material.dart';
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
  final blackMids = GlobalData().blackMids;

  @override
  void onInit() {
    super.onInit();
    if (Accounts.main.isLogin) {
      queryData();
    } else {
      loadingState.value = const Error('账号未登录');
    }
  }

  @override
  List<BlackListItem>? getDataList(BlackListData response) {
    _total = response.total;
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
      onConfirm: () async {
        final result = await VideoHttp.relationMod(mid: mid, act: 6, reSrc: 11);
        if (result.isSuccess) {
          loadingState
            ..value.data!.removeAt(index)
            ..refresh();
          total.value -= 1;
          SmartDialog.showToast(context.l10n.blacklistRemoved);
        }
      },
    );
    if (confirm) {
      final result = await VideoHttp.relationMod(mid: mid, act: 6, reSrc: 11);
      if (result.isSuccess) {
        loadingState
          ..value.data!.removeAt(index)
          ..refresh();
        _total -= 1;
        SmartDialog.showToast('移除成功');
        return true;
      }
    }
    return false;
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
