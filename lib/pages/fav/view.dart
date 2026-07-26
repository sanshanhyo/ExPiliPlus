import 'package:ex_piliplus/common/widgets/scroll_physics.dart';
import 'package:ex_piliplus/common/widgets/view_safe_area.dart';
import 'package:ex_piliplus/http/loading_state.dart';
import 'package:ex_piliplus/models/common/fav_type.dart';
import 'package:ex_piliplus/pages/fav/article/controller.dart';
import 'package:ex_piliplus/pages/fav/cheese/controller.dart';
import 'package:ex_piliplus/pages/fav/topic/controller.dart';
import 'package:ex_piliplus/pages/fav/video/controller.dart';
import 'package:ex_piliplus/pages/fav_folder_sort/view.dart';
import 'package:ex_piliplus/utils/extension/scroll_controller_ext.dart';
import 'package:ex_piliplus/utils/extension/l10n_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';

class FavPage extends StatefulWidget {
  const FavPage({super.key});

  @override
  State<FavPage> createState() => _FavPageState();
}

class _FavPageState extends State<FavPage> with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  final FavController _favController = Get.put(FavController());
  late final RxBool _showVideoFavMenu;

  void listener() {
    _showVideoFavMenu.value = _tabController.index == 0;
  }

  @override
  void initState() {
    super.initState();
    int initialIndex = Get.arguments is int ? Get.arguments as int : 0;
    _showVideoFavMenu = (initialIndex == 0).obs;
    _tabController = TabController(
      length: FavTabType.values.length,
      vsync: this,
      initialIndex: initialIndex,
    );
    _tabController.addListener(listener);
  }

  @override
  void dispose() {
    _tabController
      ..removeListener(listener)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(l10n.favoriteTitle),
        actions: [
          Obx(
            () => _showVideoFavMenu.value
                ? IconButton(
                    onPressed: () => Get.toNamed('/createFav')?.then(
                      (data) {
                        if (data != null) {
                          final list =
                              _favController.loadingState.value.dataOrNull;
                          if (list != null && list.isNotEmpty) {
                            list.insert(1, data);
                            _favController.loadingState.refresh();
                          } else {
                            _favController.loadingState.value = Success([data]);
                          }
                        }
                      },
                    ),
                    icon: const Icon(Icons.add),
                    tooltip: l10n.favoriteNewFolder,
                  )
                : const SizedBox.shrink(),
          ),
          Obx(
            () => _showVideoFavMenu.value
                ? IconButton(
                    onPressed: () {
                      if (_favController.loadingState.value.isSuccess) {
                        if (!_favController.isEnd) {
                          SmartDialog.showToast(
                            l10n.favoriteLoadAllBeforeSorting,
                          );
                          return;
                        }
                        Get.to(
                          FavFolderSortPage(favController: _favController),
                        );
                      }
                    },
                    icon: const Icon(Icons.sort),
                    tooltip: l10n.favoriteFolderSort,
                  )
                : const SizedBox.shrink(),
          ),
          Obx(
            () => _showVideoFavMenu.value
                ? IconButton(
                    onPressed: () {
                      if (_favController.loadingState.value case Success(
                        :final response,
                      )) {
                        try {
                          final item = response!.first;
                          Get.toNamed(
                            '/favSearch',
                            arguments: {
                              'type': 1,
                              'mediaId': item.id,
                              'title': item.title,
                              'count': item.mediaCount,
                              'isOwner': true,
                            },
                          );
                        } catch (_) {}
                      }
                    },
                    icon: const Icon(Icons.search_outlined),
                    tooltip: l10n.commonSearch,
                  )
                : const SizedBox.shrink(),
          ),
          const SizedBox(width: 6),
        ],
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabAlignment: TabAlignment.start,
          tabs: FavTabType.values
              .map((item) => Tab(text: item.localizedTitle(l10n)))
              .toList(),
          onTap: (index) {
            try {
              if (!_tabController.indexIsChanging) {
                switch (FavTabType.values[index]) {
                  case FavTabType.video:
                    _favController.scrollController.animToTop();
                  case FavTabType.article:
                    Get.find<FavArticleController>().scrollController
                        .animToTop();
                  case FavTabType.topic:
                    Get.find<FavTopicController>().scrollController.animToTop();
                  case FavTabType.cheese:
                    Get.find<FavCheeseController>().scrollController
                        .animToTop();
                  default:
                }
              }
            } catch (_) {}
          },
        ),
      ),
      body: ViewSafeArea(
        child: tabBarView(
          controller: _tabController,
          children: FavTabType.values.map((item) => item.page).toList(),
        ),
      ),
    );
  }
}
