import 'package:ex_piliplus/http/loading_state.dart';
import 'package:ex_piliplus/http/user.dart';
import 'package:ex_piliplus/models_new/login_log/data.dart';
import 'package:ex_piliplus/models_new/login_log/list.dart';
import 'package:ex_piliplus/pages/log_table/controller.dart';
import 'package:ex_piliplus/utils/extension/l10n_ext.dart';
import 'package:get/get.dart';

class LoginLogController extends LogController<LoginLogData, LoginLogItem> {
  @override
  List<LoginLogItem>? getDataList(LoginLogData response) {
    return response.list;
  }

  @override
  Future<LoadingState<LoginLogData>> customGetData() => UserHttp.loginLog();

  @override
  List<(int, String)> getFlexAndText(LoginLogItem item) {
    return [(3, item.timeAt), (2, item.ip), (3, item.geo)];
  }

  @override
  LoginLogItem get header => LoginLogItem(
    timeAt: Get.context!.l10n.commonTime,
    ip: Get.context!.l10n.logChange,
    geo: Get.context!.l10n.logLocation,
  );

  @override
  String get title => Get.context!.l10n.logLoginHistory;
}
