import 'package:ex_piliplus/http/fav.dart';
import 'package:ex_piliplus/http/loading_state.dart';
import 'package:ex_piliplus/models_new/fav/fav_article/data.dart';
import 'package:ex_piliplus/models_new/fav/fav_article/item.dart';
import 'package:ex_piliplus/pages/common/common_list_controller.dart';
import 'package:ex_piliplus/utils/extension/l10n_ext.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';

class FavArticleController
    extends CommonListController<FavArticleData, FavArticleItemModel> {
  @override
  void onInit() {
    super.onInit();
    queryData();
  }

  @override
  List<FavArticleItemModel>? getDataList(FavArticleData response) {
    if (response.hasMore == false) {
      isEnd = true;
    }
    return response.items;
  }

  @override
  Future<LoadingState<FavArticleData>> customGetData() =>
      FavHttp.favArticle(page: page);

  Future<void> onRemove(int index, String id) async {
    final res = await FavHttp.communityAction(opusId: id, action: 4);
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
