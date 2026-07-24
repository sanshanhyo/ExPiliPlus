import 'package:ex_piliplus/http/loading_state.dart';
import 'package:ex_piliplus/http/user.dart';
import 'package:ex_piliplus/models_new/later/data.dart';
import 'package:ex_piliplus/models_new/later/list.dart';
import 'package:ex_piliplus/pages/common/multi_select/base.dart';
import 'package:ex_piliplus/pages/common/search/common_search_controller.dart';
import 'package:ex_piliplus/pages/later/controller.dart' show BaseLaterController;
import 'package:get/get.dart';

class LaterSearchController
    extends CommonSearchController<LaterData, LaterItemModel>
    with
        CommonMultiSelectMixin<LaterItemModel>,
        DeleteItemMixin,
        BaseLaterController {
  dynamic mid;
  dynamic count;

  @override
  void onInit() {
    final args = Get.arguments;
    mid = args['mid'];
    count = args['count'];
    super.onInit();
  }

  @override
  Future<LoadingState<LaterData>> customGetData() => UserHttp.seeYouLater(
    page: page,
    keyword: editController.value.text,
  );

  @override
  List<LaterItemModel>? getDataList(LaterData response) {
    return response.list;
  }
}
