import 'package:ex_piliplus/http/fav.dart';
import 'package:ex_piliplus/http/loading_state.dart';
import 'package:ex_piliplus/models_new/space/space_cheese/data.dart';
import 'package:ex_piliplus/models_new/space/space_cheese/item.dart';
import 'package:ex_piliplus/pages/common/common_list_controller.dart';
import 'package:ex_piliplus/utils/accounts.dart';
import 'package:ex_piliplus/utils/extension/l10n_ext.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';

class FavCheeseController
    extends CommonListController<SpaceCheeseData, SpaceCheeseItem> {
  final mid = Accounts.main.mid;

  @override
  void onInit() {
    super.onInit();
    queryData();
  }

  @override
  List<SpaceCheeseItem>? getDataList(SpaceCheeseData response) {
    isEnd = response.page?.next == false;
    return response.items;
  }

  @override
  Future<LoadingState<SpaceCheeseData>> customGetData() =>
      FavHttp.favPugv(mid: mid, page: page);

  Future<void> onRemove(int index, int sid) async {
    final res = await FavHttp.delFavPugv(sid);
    if (res.isSuccess) {
      loadingState
        ..value.data!.removeAt(index)
        ..refresh();
      SmartDialog.showToast(Get.context!.l10n.favoriteRemoved);
    } else {
      res.toast();
    }
  }
}
