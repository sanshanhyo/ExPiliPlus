import 'package:ex_piliplus/http/loading_state.dart';
import 'package:ex_piliplus/http/member.dart';
import 'package:ex_piliplus/models_new/space/space/tab2.dart';
import 'package:ex_piliplus/models_new/space/space_opus/data.dart';
import 'package:ex_piliplus/models_new/space/space_opus/item.dart';
import 'package:ex_piliplus/pages/common/common_list_controller.dart';
import 'package:ex_piliplus/pages/member/controller.dart';
import 'package:ex_piliplus/utils/extension/l10n_ext.dart';
import 'package:collection/collection.dart';
import 'package:get/get.dart';

class MemberOpusController
    extends CommonListController<SpaceOpusData, SpaceOpusItemModel> {
  MemberOpusController({
    required this.heroTag,
    required this.mid,
  });

  final String? heroTag;
  final int mid;

  String offset = '';
  late Rx<SpaceTabFilter> type;
  List<SpaceTabFilter>? filter;

  @override
  void onInit() {
    super.onInit();
    type = SpaceTabFilter(
      text: Get.context!.l10n.memberAllPosts,
      meta: 'all',
      tabName: Get.context!.l10n.memberPosts,
    ).obs;
    filter = Get.find<MemberController>(tag: heroTag).tab2
        ?.firstWhereOrNull((e) => e.param == 'contribute')
        ?.items
        ?.firstWhereOrNull((e) => e.param == 'opus')
        ?.filter;
    queryData();
  }

  @override
  Future<void> onRefresh() {
    offset = '';
    return super.onRefresh();
  }

  @override
  List<SpaceOpusItemModel>? getDataList(SpaceOpusData response) {
    offset = response.offset ?? '';
    if (response.hasMore == false) {
      isEnd = true;
    }
    return response.items;
  }

  @override
  Future<LoadingState<SpaceOpusData>> customGetData() => MemberHttp.spaceOpus(
    hostMid: mid,
    page: page,
    offset: offset,
    type: type.value.meta,
  );
}
