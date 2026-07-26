import 'dart:async';

import 'package:ex_piliplus/common/style.dart';
import 'package:ex_piliplus/common/widgets/appbar/appbar.dart';
import 'package:ex_piliplus/common/widgets/badge.dart';
import 'package:ex_piliplus/common/widgets/dialog/dialog.dart';
import 'package:ex_piliplus/common/widgets/dialog/simple_dialog_option.dart';
import 'package:ex_piliplus/common/widgets/flutter/pop_scope.dart';
import 'package:ex_piliplus/common/widgets/image/network_img_layer.dart';
import 'package:ex_piliplus/common/widgets/loading_widget/http_error.dart';
import 'package:ex_piliplus/common/widgets/select_mask.dart';
import 'package:ex_piliplus/models/common/badge_type.dart';
import 'package:ex_piliplus/models_new/download/download_info.dart';
import 'package:ex_piliplus/pages/download/controller.dart';
import 'package:ex_piliplus/pages/download/detail/view.dart';
import 'package:ex_piliplus/pages/download/detail/widgets/item.dart';
import 'package:ex_piliplus/pages/download/search/view.dart';
import 'package:ex_piliplus/services/download/download_service.dart';
import 'package:ex_piliplus/utils/cache_manager.dart';
import 'package:ex_piliplus/utils/extension/l10n_ext.dart';
import 'package:ex_piliplus/utils/grid.dart';
import 'package:ex_piliplus/utils/platform_utils.dart';
import 'package:ex_piliplus/utils/storage.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart'
    hide SliverGridDelegateWithMaxCrossAxisExtent;
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';

class DownloadPage extends StatefulWidget {
  const DownloadPage({super.key});

  @override
  State<DownloadPage> createState() => _DownloadPageState();
}

class _DownloadPageState extends State<DownloadPage> with GridMixin {
  final _downloadService = Get.find<DownloadService>();
  final _controller = Get.put(DownloadPageController());
  final _progress = ChangeNotifier();

  @override
  void dispose() {
    _progress.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final padding = MediaQuery.viewPaddingOf(context);
    return Obx(() {
      final enableMultiSelect = _controller.enableMultiSelect.value;
      return popScope(
        canPop: !enableMultiSelect,
        onPopInvokedWithResult: (didPop, result) {
          if (enableMultiSelect) {
            _controller.handleSelect();
          }
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: MultiSelectAppBarWidget(
            ctr: _controller,
            actions: [
              TextButton(
                style: TextButton.styleFrom(
                  visualDensity: VisualDensity.compact,
                ),
                onPressed: () async {
                  final future = [
                    for (final page in _controller.allChecked)
                      for (final e in page.entries)
                        _downloadService.downloadDanmaku(
                          entry: e,
                          isUpdate: true,
                        ),
                  ];
                  _controller.handleSelect();
                  final res = await Future.wait(future);
                  if (res.every((e) => e)) {
                    SmartDialog.showToast(l10n.commonUpdateSucceeded);
                  } else {
                    SmartDialog.showToast(l10n.commonUpdateFailed);
                  }
                },
                child: Text(
                  l10n.commonUpdate,
                  style: TextStyle(color: theme.colorScheme.onSurface),
                ),
              ),
            ],
            child: AppBar(
              title: Text(l10n.downloadOfflineTitle),
              actions: [
                IconButton(
                  tooltip: l10n.commonSearch,
                  onPressed: () async {
                    await _downloadService.waitForInitialization;
                    if (!mounted) return;
                    Get.to(DownloadSearchPage(progress: _progress));
                  },
                  icon: const Icon(Icons.search),
                ),
                IconButton(
                  tooltip: l10n.commonMultiSelect,
                  onPressed: () {
                    if (enableMultiSelect) {
                      _controller.handleSelect();
                    } else {
                      _controller.enableMultiSelect.value = true;
                    }
                  },
                  icon: const Icon(Icons.edit_note),
                ),
                const SizedBox(width: 6),
              ],
            ),
          ),
          body: Padding(
            padding: EdgeInsets.only(left: padding.left, right: padding.right),
            child: CustomScrollView(
              slivers: [
                Obx(() {
                  final entry =
                      _downloadService.waitDownloadQueue.firstWhereOrNull(
                        (e) => e.cid == _downloadService.curCid,
                      ) ??
                      _downloadService.waitDownloadQueue.firstOrNull;
                  if (entry != null) {
                    return SliverMainAxisGroup(
                      slivers: [
                        SliverPadding(
                          padding: const EdgeInsets.only(left: 12, bottom: 7),
                          sliver: SliverToBoxAdapter(
                            child: Text(
                              l10n.downloadDownloadingCount(
                                _downloadService.waitDownloadQueue.length
                                    .toString(),
                              ),
                            ),
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: SizedBox(
                            height: 110,
                            child: DetailItem(
                              entry: entry,
                              progress: _progress,
                              downloadService: _downloadService,
                              showTitle: true,
                              isCurr: true,
                              controller: _controller,
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                  return const SliverToBoxAdapter();
                }),
                Obx(() {
                  if (_controller.pages.isNotEmpty) {
                    return SliverMainAxisGroup(
                      slivers: [
                        SliverPadding(
                          padding: EdgeInsets.only(
                            left: 12,
                            bottom: 7,
                            top: _downloadService.waitDownloadQueue.isEmpty
                                ? 0
                                : 7,
                          ),
                          sliver: SliverToBoxAdapter(
                            child: Text(l10n.downloadDownloadedVideos),
                          ),
                        ),
                        SliverGrid.builder(
                          gridDelegate: gridDelegate,
                          itemBuilder: (context, index) {
                            final item = _controller.pages[index];
                            if (item.entries.length == 1) {
                              final entry = item.entries.first;
                              return DetailItem(
                                entry: entry,
                                progress: _progress,
                                downloadService: _downloadService,
                                showTitle: true,
                                onDelete: () {
                                  _downloadService.deleteDownload(
                                    entry: entry,
                                    removeList: true,
                                  );
                                  GStorage.watchProgress.delete(
                                    entry.cid.toString(),
                                  );
                                },
                                checked: item.checked,
                                onSelect: (_) => _controller.onSelect(item),
                                controller: _controller,
                              );
                            }
                            return _buildItem(theme, item, enableMultiSelect);
                          },
                          itemCount: _controller.pages.length,
                        ),
                      ],
                    );
                  }
                  if (_downloadService.waitDownloadQueue.isNotEmpty) {
                    return const SliverToBoxAdapter();
                  }
                  return const HttpError();
                }),
                SliverToBoxAdapter(
                  child: SizedBox(height: padding.bottom + 100),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _buildItem(
    ThemeData theme,
    DownloadPageInfo pageInfo,
    bool enableMultiSelect,
  ) {
    void onLongPress() => enableMultiSelect
        ? null
        : showDialog(
            context: context,
            builder: (context) => SimpleDialog(
              clipBehavior: Clip.hardEdge,
              contentPadding: const EdgeInsets.symmetric(vertical: 12),
              children: [
                DialogOption(
                  onPressed: () {
                    Get.back();
                    showConfirmDialog(
                      context: context,
                      title: Text(context.l10n.downloadConfirmDelete),
                      onConfirm: () async {
                        await GStorage.watchProgress.deleteAll(
                          pageInfo.entries.map((e) => e.cid.toString()),
                        );
                        _downloadService.deletePage(
                          pageDirPath: pageInfo.dirPath,
                        );
                      },
                    );
                  },
                  child: Text(
                    context.l10n.commonDelete,
                    style: const TextStyle(fontSize: 14),
                  ),
                ),
                DialogOption(
                  onPressed: () async {
                    Get.back();
                    final res = await Future.wait(
                      pageInfo.entries.map(
                        (e) => _downloadService.downloadDanmaku(
                          entry: e,
                          isUpdate: true,
                        ),
                      ),
                    );
                    if (res.every((e) => e)) {
                      SmartDialog.showToast(
                        context.l10n.commonUpdateSucceeded,
                      );
                    } else {
                      SmartDialog.showToast(context.l10n.commonUpdateFailed);
                    }
                  },
                  child: Text(
                    context.l10n.downloadUpdateDanmaku,
                    style: const TextStyle(fontSize: 14),
                  ),
                ),
              ],
            ),
          );
    final first = pageInfo.entries.first;
    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        onTap: () {
          if (_controller.enableMultiSelect.value) {
            _controller.onSelect(pageInfo);
            return;
          }
          Get.to(
            DownloadDetailPage(
              pageId: pageInfo.pageId,
              title: pageInfo.title,
              progress: _progress,
            ),
          );
        },
        onLongPress: onLongPress,
        onSecondaryTap: PlatformUtils.isMobile ? null : onLongPress,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Style.safeSpace,
            vertical: 5,
          ),
          child: Row(
            spacing: 10,
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  AspectRatio(
                    aspectRatio: Style.aspectRatio,
                    child: LayoutBuilder(
                      builder: (context, constraints) => NetworkImgLayer(
                        src: pageInfo.cover,
                        width: constraints.maxWidth,
                        height: constraints.maxHeight,
                      ),
                    ),
                  ),
                  PBadge(
                    text: context.l10n.downloadVideoCount(
                      pageInfo.entries.length.toString(),
                    ),
                    right: 6.0,
                    bottom: 6.0,
                    isBold: false,
                    type: PBadgeType.gray,
                  ),
                  if (pageInfo.seasonType case final pgcType?)
                    PBadge(
                      text: switch (pgcType) {
                        -1 => context.l10n.downloadCourse,
                        1 => context.l10n.downloadAnime,
                        2 => context.l10n.downloadMovie,
                        3 => context.l10n.downloadDocumentary,
                        4 => context.l10n.downloadChineseAnimation,
                        5 => context.l10n.downloadTvSeries,
                        7 => context.l10n.downloadVarietyShow,
                        _ => null,
                      },
                      right: 6.0,
                      top: 6.0,
                    ),
                  Positioned.fill(
                    child: selectMask(theme.colorScheme, pageInfo.checked),
                  ),
                ],
              ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        pageInfo.title,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: theme.textTheme.bodyMedium!.fontSize,
                          height: 1.42,
                          letterSpacing: 0.3,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Row(
                      crossAxisAlignment: .end,
                      mainAxisAlignment: .spaceBetween,
                      children: [
                        Text(
                          '${CacheManager.formatSize(pageInfo.entries.fold(0, (p, n) => p + n.totalBytes))}  ${first.ownerName ?? ""}',
                          style: TextStyle(
                            fontSize: 12,
                            height: 1.6,
                            color: theme.colorScheme.outline,
                          ),
                        ),
                        pageInfo.entries.first.moreBtn(theme.colorScheme),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
