import 'package:ex_piliplus/http/fav.dart';
import 'package:ex_piliplus/http/loading_state.dart';
import 'package:ex_piliplus/models/common/fav_order_type.dart';
import 'package:ex_piliplus/models/common/video/source_type.dart';
import 'package:ex_piliplus/models_new/fav/fav_detail/data.dart';
import 'package:ex_piliplus/models_new/fav/fav_detail/media.dart';
import 'package:ex_piliplus/pages/common/multi_select/base.dart';
import 'package:ex_piliplus/pages/common/search/common_search_controller.dart';
import 'package:ex_piliplus/pages/fav_detail/controller.dart';
import 'package:ex_piliplus/utils/page_utils.dart';
import 'package:get/get.dart';

class FavSearchController
    extends CommonSearchController<FavDetailData, FavDetailItemModel>
    with
        CommonMultiSelectMixin<FavDetailItemModel>,
        DeleteItemMixin,
        BaseFavController {
  late int type;
  @override
  late int mediaId;
  @override
  late bool isOwner;
  late dynamic count;
  late dynamic title;

  @override
  void onInit() {
    final args = Get.arguments;
    type = args['type'];
    mediaId = args['mediaId'];
    isOwner = args['isOwner'];
    count = args['count'];
    title = args['title'];
    super.onInit();
  }

  final Rx<FavOrderType> order = FavOrderType.mtime.obs;

  @override
  Future<LoadingState<FavDetailData>> customGetData() =>
      FavHttp.userFavFolderDetail(
        pn: page,
        ps: 20,
        mediaId: mediaId,
        keyword: editController.text,
        type: type,
        order: order.value,
      );

  @override
  List<FavDetailItemModel>? getDataList(FavDetailData response) {
    if (response.hasMore == false) {
      isEnd = true;
    }
    return response.medias;
  }

  @override
  // TODO: dimension
  void onViewFav(FavDetailItemModel item, int? index) => PageUtils.toVideoPage(
    bvid: item.bvid,
    cid: item.ugc!.firstCid!,
    cover: item.cover,
    title: item.title,
    extraArguments: {
      'sourceType': SourceType.fav,
      'mediaId': mediaId,
      'oid': item.id,
      'favTitle': title,
      'count': count,
      'desc': true,
      'isContinuePlaying': true,
    },
  );
}
