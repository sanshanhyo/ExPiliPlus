import 'package:ex_piliplus/common/widgets/dialog/dialog.dart';
import 'package:ex_piliplus/common/widgets/dialog/simple_dialog_option.dart';
import 'package:ex_piliplus/common/widgets/loading_widget/loading_widget.dart';
import 'package:ex_piliplus/common/widgets/scroll_physics.dart';
import 'package:ex_piliplus/common/widgets/view_safe_area.dart';
import 'package:ex_piliplus/http/loading_state.dart';
import 'package:ex_piliplus/models/member/tags.dart';
import 'package:ex_piliplus/pages/follow/child/child_controller.dart';
import 'package:ex_piliplus/pages/follow/child/child_view.dart';
import 'package:ex_piliplus/pages/follow/controller.dart';
import 'package:ex_piliplus/pages/follow_tag_sort/view.dart';
import 'package:ex_piliplus/utils/bili_utils.dart';
import 'package:ex_piliplus/utils/parse_int.dart';
import 'package:ex_piliplus/utils/platform_utils.dart';
import 'package:ex_piliplus/utils/request_utils.dart';
import 'package:ex_piliplus/utils/utils.dart';
import 'package:ex_piliplus/utils/extension/l10n_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show LengthLimitingTextInputFormatter;
import 'package:get/get.dart';

class FollowPage extends StatefulWidget {
  const FollowPage({super.key});

  @override
  State<FollowPage> createState() => _FollowPageState();

  static void toFollowPage({dynamic mid, String? name}) {
    if (mid == null) return;
    Get.toNamed(
      '/follow',
      arguments: {
        'mid': safeToInt(mid),
        'name': name,
      },
    );
  }
}

class _FollowPageState extends State<FollowPage> {
  final _tag = Utils.generateRandomString(8);
  late final FollowController _followController;

  @override
  void initState() {
    super.initState();
    _followController = Get.put(FollowController(), tag: _tag);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: _buildAppBar,
      body: _followController.isOwner
          ? Obx(() => _buildBody(_followController.followState.value))
          : _childPage(),
    );
  }

  PreferredSizeWidget get _buildAppBar => AppBar(
    title: _followController.isOwner
        ? Text(context.l10n.followMyFollowing)
        : Obx(() {
            final name = _followController.name.value;
            if (name != null) {
              return Text(context.l10n.followUserFollowing(name));
            }
            return const SizedBox.shrink();
          }),
    actions: _followController.isOwner
        ? [
            IconButton(
              onPressed: () => RequestUtils.createFavTag(
                context,
                _followController.onCreateFavTag,
              ),
              icon: const Icon(Icons.add),
              tooltip: context.l10n.followNewGroup,
            ),
            IconButton(
              onPressed: () {
                if (_followController.followState.value is! Success) {
                  return;
                }
                Get.to(FollowTagSortPage(controller: _followController));
              },
              icon: const Icon(Icons.sort),
              tooltip: context.l10n.followSortGroups,
            ),
            IconButton(
              onPressed: () => Get.toNamed(
                '/followSearch',
                arguments: {
                  'mid': _followController.mid,
                },
              ),
              icon: const Icon(Icons.search_outlined),
              tooltip: context.l10n.commonSearch,
            ),
            PopupMenuButton(
              icon: const Icon(Icons.more_vert),
              itemBuilder: (context) => [
                PopupMenuItem(
                  onTap: () => Get.toNamed('/blackListPage'),
                  child: Row(
                    spacing: 10,
                    mainAxisSize: .min,
                    children: [
                      const Icon(Icons.block, size: 19),
                      Text(context.l10n.followBlockedUsers),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(width: 6),
          ]
        : null,
  );

  Widget _childPage([MemberTagItemModel? item]) => FollowChildPage(
    tag: _tag,
    controller: _followController,
    mid: _followController.mid,
    tagid: item?.tagid,
  );

  Widget _buildBody(LoadingState loadingState) {
    return switch (loadingState) {
      Loading() => m3eLoading,
      Success() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ViewSafeArea(
            child: TabBar(
              isScrollable: true,
              tabAlignment: TabAlignment.start,
              controller: _followController.tabController,
              tabs: List.generate(_followController.tabs.length, (index) {
                return Obx(() {
                  final item = _followController.tabs[index];
                  int? count = item.count;
                  if (BiliUtils.isCustomFollowTag(item.tagid)) {
                    return GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onLongPress: () {
                        Feedback.forLongPress(context);
                        _onHandleTag(index, item);
                      },
                      onSecondaryTap: PlatformUtils.isMobile
                          ? null
                          : () => _onHandleTag(index, item),
                      child: Tab(
                        child: Row(
                          children: [
                            Text(
                              '${index == 0 ? context.l10n.followAll : item.name}${count != null ? '($count)' : ''} ',
                            ),
                            const Icon(Icons.menu, size: 18),
                          ],
                        ),
                      ),
                    );
                  }
                  return Tab(
                    text:
                        '${index == 0 ? context.l10n.followAll : item.name}${count != null ? '($count)' : ''}',
                  );
                });
              }),
              onTap: (value) {
                if (!_followController.tabController!.indexIsChanging) {
                  final item = _followController.tabs[value];
                  // if (_isCustomTag(item.tagid)) {
                  //   _onHandleTag(value, item);
                  // }
                  try {
                    Get.find<FollowChildController>(
                      tag: '$_tag${item.tagid}',
                    ).animateToTop();
                  } catch (_) {}
                }
              },
            ),
          ),
          Expanded(
            child: tabBarView(
              controller: _followController.tabController,
              children: _followController.tabs.map(_childPage).toList(),
            ),
          ),
        ],
      ),
      Error() => _childPage(),
    };
  }

  void _onHandleTag(int index, MemberTagItemModel item) {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        clipBehavior: Clip.hardEdge,
        contentPadding: const EdgeInsets.symmetric(vertical: 12),
        children: [
          DialogOption(
            onPressed: () {
              Get.back();
              String tagName = item.name!;
              showConfirmDialog(
                context: context,
                title: Text(context.l10n.followEditGroupName),
                content: TextFormField(
                  autofocus: true,
                  initialValue: tagName,
                  onChanged: (value) => tagName = value,
                  inputFormatters: [LengthLimitingTextInputFormatter(16)],
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
                onConfirm: () {
                  if (tagName.isNotEmpty) {
                    _followController.onUpdateTag(item, tagName);
                  }
                },
              );
            },
            child: Text(
              context.l10n.followRenameGroup,
              style: const TextStyle(fontSize: 14),
            ),
          ),
          DialogOption(
            onPressed: () {
              Get.back();
              showConfirmDialog(
                context: context,
                title: Text(context.l10n.followDeleteGroup),
                content: Text(context.l10n.followDeleteGroupDescription),
                onConfirm: () => _followController.onDelTag(index, item.tagid!),
              );
            },
            child: Text(
              context.l10n.followDeleteGroup,
              style: const TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}
