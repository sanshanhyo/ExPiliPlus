import 'package:ex_piliplus/http/loading_state.dart';
import 'package:ex_piliplus/http/user.dart';
import 'package:ex_piliplus/models_new/follow/data.dart';
import 'package:ex_piliplus/pages/follow_type/controller.dart';

class FollowedController extends FollowTypeController {
  @override
  Future<LoadingState<FollowData>> customGetData() =>
      UserHttp.followedUp(mid: mid, pn: page);
}
