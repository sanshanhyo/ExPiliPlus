import 'dart:math';

import 'package:ex_piliplus/models_new/space/space/tab2.dart';
import 'package:ex_piliplus/pages/member/controller.dart';
import 'package:ex_piliplus/utils/extension/iterable_ext.dart';
import 'package:ex_piliplus/utils/extension/l10n_ext.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MemberContributeCtr extends GetxController
    with GetSingleTickerProviderStateMixin {
  MemberContributeCtr({
    required this.heroTag,
    required this.initialIndex,
  });
  final String? heroTag;
  final int? initialIndex;

  TabController? tabController;
  List<Tab>? tabs;
  late final _ctr = Get.find<MemberController>(tag: heroTag);
  List<SpaceTab2Item>? items;

  @override
  void onInit() {
    super.onInit();
    SpaceTab2 contribute = _ctr.tab2!.firstWhere(
      (item) => item.param == 'contribute',
    );
    if (contribute.items?.isNullOrEmpty == false) {
      items = contribute.items;
      if (contribute.items!.length > 1) {
        // show if exist
        if (_ctr.hasSeasonOrSeries == true) {
          items!.add(
            SpaceTab2Item(
              param: 'ugcSeason',
              title: Get.context!.l10n.memberAllCollectionsAndLists,
            ),
          );
        }
        tabs = items!.map((item) => Tab(text: item.title)).toList();
        tabController = TabController(
          vsync: this,
          length: items!.length,
          initialIndex: max(0, initialIndex ?? 0),
        );
      }
    }
  }

  @override
  void onClose() {
    tabController?.dispose();
    super.onClose();
  }
}
