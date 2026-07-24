import 'package:ex_piliplus/http/loading_state.dart';
import 'package:ex_piliplus/http/login.dart';
import 'package:ex_piliplus/models_new/login_devices/data.dart';
import 'package:ex_piliplus/models_new/login_devices/device.dart';
import 'package:ex_piliplus/pages/common/common_list_controller.dart';

class LoginDevicesController
    extends CommonListController<LoginDevicesData, LoginDevice> {
  @override
  void onInit() {
    super.onInit();
    queryData();
  }

  @override
  List<LoginDevice>? getDataList(LoginDevicesData response) {
    return response.devices;
  }

  @override
  Future<LoadingState<LoginDevicesData>> customGetData() =>
      LoginHttp.loginDevices();
}
