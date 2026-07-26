import 'package:ex_piliplus/http/loading_state.dart';
import 'package:ex_piliplus/http/user.dart';
import 'package:ex_piliplus/models_new/coin_log/data.dart';
import 'package:ex_piliplus/models_new/coin_log/list.dart';
import 'package:ex_piliplus/pages/log_table/controller.dart';
import 'package:ex_piliplus/utils/extension/l10n_ext.dart';
import 'package:get/get.dart';

class CoinLogController extends LogController<CoinLogData, CoinLogItem> {
  @override
  List<CoinLogItem>? getDataList(CoinLogData response) {
    return response.list;
  }

  @override
  Future<LoadingState<CoinLogData>> customGetData() => UserHttp.coinLog();

  @override
  List<(int, String)> getFlexAndText(CoinLogItem item) {
    return [(3, item.time), (1, item.delta), (4, item.reason)];
  }

  @override
  CoinLogItem get header => CoinLogItem(
    time: Get.context!.l10n.commonTime,
    delta: Get.context!.l10n.logChange,
    reason: Get.context!.l10n.commonReason,
  );

  @override
  String get title => Get.context!.l10n.memberCoinHistory;
}
