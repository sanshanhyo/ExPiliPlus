import 'package:ex_piliplus/http/fan.dart';
import 'package:ex_piliplus/http/loading_state.dart';
import 'package:ex_piliplus/http/video.dart';
import 'package:ex_piliplus/models_new/follow/data.dart';
import 'package:ex_piliplus/pages/follow_type/controller.dart';
import 'package:ex_piliplus/utils/accounts.dart';
import 'package:ex_piliplus/utils/extension/l10n_ext.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';

class FansController extends FollowTypeController {
  FansController(this.showName);
  final bool showName;
  late final bool isOwner;

  @override
  void init() {
    final Map? args = Get.arguments;
    final ownerMid = Accounts.main.mid;
    final int? mid = args?['mid'];
    this.mid = mid ?? ownerMid;
    isOwner = ownerMid == this.mid;
    if (showName && !isOwner) {
      final String? name = args?['name'];
      this.name = RxnString(name);
      if (name == null) {
        queryUserName();
      }
    }
    queryData();
  }

  @override
  Future<LoadingState<FollowData>> customGetData() => FanHttp.fans(
    vmid: mid,
    pn: page,
    orderType: 'attention',
  );

  Future<void> onRemoveFan(int index, int mid) async {
    final res = await VideoHttp.relationMod(
      mid: mid,
      act: 7,
      reSrc: 11,
    );
    if (res.isSuccess) {
      loadingState
        ..value.data!.removeAt(index)
        ..refresh();
      SmartDialog.showToast(Get.context!.l10n.followFollowerRemoved);
    } else {
      res.toast();
    }
  }
}
