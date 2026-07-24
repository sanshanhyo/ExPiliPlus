import 'package:ex_piliplus/http/loading_state.dart';
import 'package:ex_piliplus/http/search.dart';
import 'package:ex_piliplus/models_new/search/search_trending/data.dart';
import 'package:ex_piliplus/models_new/search/search_trending/list.dart';
import 'package:ex_piliplus/pages/common/common_list_controller.dart';

class SearchTrendingController
    extends CommonListController<SearchTrendingData, SearchTrendingItemModel> {
  int topCount = 0;

  @override
  void onInit() {
    super.onInit();
    queryData();
  }

  @override
  List<SearchTrendingItemModel>? getDataList(SearchTrendingData response) {
    topCount = response.topCount;
    return response.list;
  }

  @override
  Future<LoadingState<SearchTrendingData>> customGetData() =>
      SearchHttp.searchTrending(needsTop: true);
}
