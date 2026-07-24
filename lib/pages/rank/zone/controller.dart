import 'package:ex_piliplus/http/loading_state.dart';
import 'package:ex_piliplus/http/video.dart';
import 'package:ex_piliplus/pages/common/common_list_controller.dart';

class ZoneController extends CommonListController {
  ZoneController({this.rid, this.seasonType});

  int? rid;
  int? seasonType;

  @override
  void onInit() {
    super.onInit();
    queryData();
  }

  @override
  Future<LoadingState> customGetData() {
    if (rid != null) {
      return VideoHttp.getRankVideoList(rid!);
    }
    if (seasonType == 1) {
      return VideoHttp.pgcRankList(seasonType: seasonType!);
    }
    return VideoHttp.pgcSeasonRankList(seasonType: seasonType!);
  }
}
