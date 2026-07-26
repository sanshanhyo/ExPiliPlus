import 'dart:math';

import 'package:ex_piliplus/http/loading_state.dart';
import 'package:ex_piliplus/http/member.dart';
import 'package:ex_piliplus/http/search.dart';
import 'package:ex_piliplus/http/user.dart';
import 'package:ex_piliplus/http/video.dart';
import 'package:ex_piliplus/models/common/member/tab_type.dart';
import 'package:ex_piliplus/models/model_owner.dart';
import 'package:ex_piliplus/models_new/space/space/data.dart';
import 'package:ex_piliplus/models_new/space/space/elec.dart';
import 'package:ex_piliplus/models_new/space/space/live.dart';
import 'package:ex_piliplus/models_new/space/space/reservation_card_list.dart';
import 'package:ex_piliplus/models_new/space/space/setting.dart';
import 'package:ex_piliplus/models_new/space/space/tab2.dart';
import 'package:ex_piliplus/pages/common/common_data_controller.dart';
import 'package:ex_piliplus/utils/accounts.dart';
import 'package:ex_piliplus/utils/extension/l10n_ext.dart';
import 'package:ex_piliplus/utils/extension/nested_scroll_ext.dart';
import 'package:ex_piliplus/utils/page_utils.dart';
import 'package:ex_piliplus/utils/request_utils.dart';
import 'package:ex_piliplus/utils/share_utils.dart';
import 'package:ex_piliplus/utils/storage_pref.dart';
import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart'
    show ExtendedNestedScrollViewState;
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';

class MemberController extends CommonDataController<SpaceData, SpaceData?>
    with GetTickerProviderStateMixin {
  MemberController({required this.mid});
  int mid;
  String? username;
  String? userAvatar;

  late final account = Accounts.main;

  Live? live;
  int? silence;

  int? isFollowed; // 被关注
  RxInt relation = 0.obs;
  bool get isFollow {
    final relation = this.relation.value;
    return relation != 0 && relation != 128 && relation != -1;
  }

  SpaceSetting? spaceSetting;
  List<SpaceTab2>? tab2;
  late List<Tab> tabs;
  TabController? tabController;
  RxInt contributeInitialIndex = 0.obs;

  bool? hasSeasonOrSeries;

  List<ElecItem>? charges;
  int? chargeCount;
  bool get hasCharge => chargeCount != null && chargeCount! > 0;

  List<Owner>? guards;
  Object? guardCount;
  bool get hasGuard => guards?.isNotEmpty ?? false;

  List<ReservationCardItem>? reserves;

  final fromViewAid = Get.parameters['from_view_aid'];

  final scrollKey = GlobalKey<ExtendedNestedScrollViewState>();
  final randomVideoLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    queryData();
  }

  @override
  bool customHandleResponse(bool isRefresh, Success<SpaceData> response) {
    final data = response.response;
    final card = data.card;
    username = card?.name ?? '';
    userAvatar = card?.face;

    isFollowed = card?.relation?.isFollowed;

    // charge
    final elec = data.elec;
    charges = elec?.list;
    chargeCount = elec?.total;
    // guard
    final guard = data.guard;
    guards = guard?.item;
    guardCount = guard?.count;

    reserves = data.reservationCardList;

    switch (data.relation) {
      case -1:
        relation.value = 128;
      case -999:
        if (data.guestRelation == -1) {
          relation.value = -1;
        }
      default:
        relation.value = card?.relation?.isFollow == 1
            ? data.relSpecial == 1
                  ? -10
                  : card?.relation?.status ?? 2
            : data.relation ?? 0;
    }
    tab2 = data.tab2;
    live = data.live;
    silence = card?.silence;
    if ((data.ugcSeason?.count != null && data.ugcSeason?.count != 0) ||
        data.series?.item?.isNotEmpty == true) {
      hasSeasonOrSeries = true;
    }
    tab2?.retainWhere((item) => MemberTabType.contains(item.param!));
    if (tab2?.isNotEmpty == true) {
      if (data.hasItem != true && tab2!.first.param == 'home') {
        // remove empty home tab
        tab2!.removeAt(0);
      }
      if (tab2!.isNotEmpty) {
        int initialIndex = -1;
        MemberTabType memberTab = Pref.memberTab;
        if (memberTab != MemberTabType.def) {
          initialIndex = tab2!.indexWhere((item) {
            return item.param == memberTab.name;
          });
        }
        if (initialIndex == -1) {
          if (data.defaultTab == 'video') {
            data.defaultTab = 'contribute';
          }
          initialIndex = tab2!.indexWhere((item) {
            return item.param == data.defaultTab;
          });
        }
        final l10n = Get.context!.l10n;
        tabs = tab2!
            .map(
              (item) => Tab(
                text: MemberTabType.values
                    .firstWhere((type) => type.name == item.param)
                    .localizedTitle(l10n),
              ),
            )
            .toList();
        tabController?.dispose();
        tabController = TabController(
          vsync: this,
          length: tabs.length,
          initialIndex: max(0, initialIndex),
        );
      }
    }
    if (mid == account.mid) {
      spaceSetting = data.setting;
    }
    loadingState.value = response;
    return true;
  }

  @override
  bool handleError(String? errMsg) {
    final l10n = Get.context!.l10n;
    tab2 = [
      SpaceTab2(title: l10n.memberTabFeed, param: 'dynamic'),
      SpaceTab2(
        title: l10n.memberTabUploads,
        param: 'contribute',
        items: [SpaceTab2Item(title: l10n.commonVideos, param: 'video')],
      ),
      SpaceTab2(title: l10n.memberTabFavorites, param: 'favorite'),
      SpaceTab2(title: l10n.memberTabAnime, param: 'bangumi'),
    ];
    tabs = tab2!.map((item) => Tab(text: item.title)).toList();
    tabController?.dispose();
    tabController = TabController(
      vsync: this,
      length: tabs.length,
    );
    username = errMsg;
    loadingState.value = const Success(null);
    return true;
  }

  @override
  Future<LoadingState<SpaceData>> customGetData() => MemberHttp.space(
    mid: mid,
    fromViewAid: fromViewAid,
  );

  void blockUser(BuildContext context) {
    if (!account.isLogin) {
      SmartDialog.showToast(context.l10n.accountPleaseSignIn);
      return;
    }
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(context.l10n.commonNotice),
        content: Text(
          relation.value != 128
              ? context.l10n.memberBlockConfirm
              : context.l10n.memberUnblockConfirm,
        ),
        actions: [
          TextButton(
            onPressed: Get.back,
            child: Text(
              context.l10n.commonCancel,
              style: TextStyle(color: Theme.of(context).colorScheme.outline),
            ),
          ),
          TextButton(
            onPressed: () {
              Get.back();
              _onBlock();
            },
            child: Text(context.l10n.commonConfirm),
          ),
        ],
      ),
    );
  }

  void shareUser() {
    ShareUtils.shareText('https://space.bilibili.com/$mid');
  }

  Future<void> _onBlock() async {
    final isBlocked = relation.value == 128;
    final res = await VideoHttp.relationMod(
      mid: mid,
      act: isBlocked ? 6 : 5,
      reSrc: 11,
    );
    if (res.isSuccess) {
      relation.value = isBlocked ? 0 : 128;
    }
  }

  void onFollow(BuildContext context) {
    if (mid == account.mid) {
      Get.toNamed('/editProfile');
    } else if (relation.value == 128) {
      _onBlock();
    } else {
      if (!account.isLogin) {
        SmartDialog.showToast(context.l10n.accountPleaseSignIn);
        return;
      }
      RequestUtils.actionRelationMod(
        context: context,
        mid: mid,
        isFollow: isFollow,
        afterMod: (attribute) => relation.value = attribute,
      );
    }
  }

  @override
  void onClose() {
    tabController?.dispose();
    super.onClose();
  }

  Future<void> onRemoveFan() async {
    final res = await VideoHttp.relationMod(mid: mid, act: 7, reSrc: 11);
    if (res.isSuccess) {
      isFollowed = null;
      if (relation.value == 4) {
        relation.value = 2;
      }
      SmartDialog.showToast(Get.context!.l10n.memberFollowerRemoved);
    } else {
      res.toast();
    }
  }

  void onTapTab(int value) {
    if (tabController?.indexIsChanging == false) {
      scrollKey.currentState?.animToTop();
    }
  }

  Future<void> vipExpAdd() async {
    final res = await UserHttp.vipExpAdd();
    if (res.isSuccess) {
      SmartDialog.showToast(Get.context!.l10n.memberPremiumRewardClaimed);
    } else {
      res.toast();
    }
  }

  Future<void> playRandomVideo() async {
    if (randomVideoLoading.value) return;
    randomVideoLoading.value = true;
    try {
      const pageSize = 30;
      var result = await MemberHttp.searchArchive(
        mid: mid,
        ps: pageSize,
        pn: 1,
      );
      final response = result.dataOrNull;
      if (response == null) {
        await result.toast();
        return;
      }

      final count = response.page?.count ?? 0;
      if (count == 0) {
        await SmartDialog.showToast(
          Get.context!.l10n.memberNoPlayableVideos,
        );
        return;
      }

      final randomIndex = Random().nextInt(count);
      final targetPage = randomIndex ~/ pageSize + 1;
      if (targetPage != 1) {
        result = await MemberHttp.searchArchive(
          mid: mid,
          ps: pageSize,
          pn: targetPage,
        );
        if (!result.isSuccess) {
          await result.toast();
          return;
        }
      }

      final videos = result.data.list?.vlist;
      if (videos == null || videos.isEmpty) {
        await SmartDialog.showToast(
          Get.context!.l10n.memberNoPlayableVideos,
        );
        return;
      }
      final video = videos[min(randomIndex % pageSize, videos.length - 1)];

      if (video.isPugv == true && video.seasonId != null) {
        PageUtils.viewPugv(seasonId: video.seasonId);
        return;
      }
      if (video.redirectUrl?.isNotEmpty == true &&
          PageUtils.viewPgcFromUri(video.redirectUrl!)) {
        return;
      }

      final playInfo = await SearchHttp.ab2cWithDimension(
        aid: video.aid,
        bvid: video.bvid,
      );
      if (playInfo?.cid case final cid?) {
        PageUtils.toVideoPage(
          aid: video.aid,
          bvid: video.bvid,
          cid: cid,
          cover: video.cover,
          title: video.title,
          dimension: playInfo?.dimension,
        );
      } else {
        await SmartDialog.showToast(
          Get.context!.l10n.memberVideoPlayInfoUnavailable,
        );
      }
    } catch (e) {
      await SmartDialog.showToast(
        Get.context!.l10n.memberRandomVideoFailed(e.toString()),
      );
    } finally {
      randomVideoLoading.value = false;
    }
  }
}
