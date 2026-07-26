import 'package:ex_piliplus/http/user.dart';
import 'package:ex_piliplus/utils/accounts.dart';
import 'package:ex_piliplus/utils/extension/l10n_ext.dart';
import 'package:ex_piliplus/utils/storage.dart';
import 'package:ex_piliplus/utils/storage_key.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';

class HistoryBaseController extends GetxController {
  RxBool pauseStatus = false.obs;

  RxBool enableMultiSelect = false.obs;
  RxInt checkedCount = 0.obs;

  final account = Accounts.history;

  // 清空观看历史
  void onClearHistory(BuildContext context, VoidCallback onSuccess) {
    final l10n = context.l10n;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.commonNotice),
        content: Text(l10n.historyClearConfirm),
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
              Get.back();
              SmartDialog.showLoading(msg: l10n.commonLoading);
              final res = await UserHttp.clearHistory(account: account);
              SmartDialog.dismiss();
              if (res.isSuccess) {
                SmartDialog.showToast(l10n.historyCleared);
                onSuccess();
              } else {
                res.toast();
              }
            },
            child: Text(l10n.historyConfirmClear),
          ),
        ],
      ),
    );
  }

  // 暂停观看历史
  void onPauseHistory(BuildContext context) {
    final l10n = context.l10n;
    final pauseStatus = !this.pauseStatus.value;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.commonNotice),
        content: Text(
          pauseStatus ? l10n.historyPauseConfirm : l10n.historyResumeConfirm,
        ),
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
              SmartDialog.showLoading(msg: l10n.commonLoading);
              final res = await UserHttp.pauseHistory(
                pauseStatus,
                account: account,
              );
              SmartDialog.dismiss();
              if (res.isSuccess) {
                SmartDialog.showToast(
                  pauseStatus ? l10n.historyPaused : l10n.historyResumed,
                );
                this.pauseStatus.value = pauseStatus;
                GStorage.localCache.put(
                  LocalCacheKey.historyPause,
                  pauseStatus,
                );
              } else {
                res.toast();
              }
              Get.back();
            },
            child: Text(
              pauseStatus
                  ? l10n.historyConfirmPause
                  : l10n.historyConfirmResume,
            ),
          ),
        ],
      ),
    );
  }
}
