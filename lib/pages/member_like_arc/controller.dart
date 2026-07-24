import 'package:ex_piliplus/http/loading_state.dart';
import 'package:ex_piliplus/http/member.dart';
import 'package:ex_piliplus/models_new/member/coin_like_arc/data.dart';
import 'package:ex_piliplus/models_new/member/coin_like_arc/item.dart';
import 'package:ex_piliplus/pages/common/common_list_controller.dart';

class MemberLikeArcController
    extends CommonListController<CoinLikeArcData, CoinLikeArcItem> {
  final dynamic mid;
  MemberLikeArcController({this.mid});

  @override
  void onInit() {
    super.onInit();
    queryData();
  }

  @override
  List<CoinLikeArcItem>? getDataList(CoinLikeArcData response) {
    return response.item;
  }

  @override
  Future<LoadingState<CoinLikeArcData>> customGetData() =>
      MemberHttp.likeArc(mid: mid, page: page);
}
