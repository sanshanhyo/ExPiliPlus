import 'package:ex_piliplus/common/widgets/appbar/appbar.dart';
import 'package:ex_piliplus/common/widgets/dialog/dialog.dart';
import 'package:ex_piliplus/common/widgets/flutter/pop_scope.dart';
import 'package:ex_piliplus/common/widgets/loading_widget/http_error.dart';
import 'package:ex_piliplus/common/widgets/view_sliver_safe_area.dart';
import 'package:ex_piliplus/models_new/download/bili_download_entry_info.dart';
import 'package:ex_piliplus/pages/common/multi_select/base.dart'
    show BaseMultiSelectMixin;
import 'package:ex_piliplus/pages/download/detail/widgets/item.dart';
import 'package:ex_piliplus/services/download/download_service.dart';
import 'package:ex_piliplus/utils/extension/l10n_ext.dart';
import 'package:ex_piliplus/utils/grid.dart';
import 'package:flutter/material.dart'
    hide SliverGridDelegateWithMaxCrossAxisExtent;
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';

class DownloadingPage extends StatefulWidget {
  const DownloadingPage({super.key});

  @override
  State<DownloadingPage> createState() => _DownloadingPageState();
}

class _DownloadingPageState extends State<DownloadingPage>
    with BaseMultiSelectMixin<BiliDownloadEntryInfo>, GridMixin {
  final _downloadService = Get.find<DownloadService>();
  late final _waitDownloadQueue = _downloadService.waitDownloadQueue;
  @override
  RxList<BiliDownloadEntryInfo> get list => _waitDownloadQueue;
  @override
  RxList<BiliDownloadEntryInfo> get state => _waitDownloadQueue;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final enableMultiSelect = this.enableMultiSelect.value;
      return popScope(
        canPop: !enableMultiSelect,
        onPopInvokedWithResult: (didPop, result) {
          if (enableMultiSelect) {
            handleSelect();
          }
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: MultiSelectAppBarWidget(
            ctr: this,
            child: AppBar(
              title: Text(context.l10n.downloadQueueTitle),
              actions: [
                IconButton(
                  tooltip: context.l10n.commonMultiSelect,
                  onPressed: () {
                    if (enableMultiSelect) {
                      handleSelect();
                    } else {
                      this.enableMultiSelect.value = true;
                    }
                  },
                  icon: const Icon(Icons.edit_note),
                ),
                const SizedBox(width: 6),
              ],
            ),
          ),
          body: CustomScrollView(
            slivers: [
              ViewSliverSafeArea(
                sliver: Obx(() {
                  if (_waitDownloadQueue.isNotEmpty) {
                    return SliverGrid.builder(
                      gridDelegate: gridDelegate,
                      itemCount: _waitDownloadQueue.length,
                      itemBuilder: (context, index) {
                        final entry = _waitDownloadQueue[index];
                        final isCurr = entry.cid == _downloadService.curCid;
                        return DetailItem(
                          entry: entry,
                          downloadService: _downloadService,
                          showTitle: true,
                          isCurr: isCurr,
                          onDelete: () => _downloadService.deleteDownload(
                            entry: entry,
                            removeQueue: true,
                            downloadNext:
                                isCurr &&
                                entry.status == DownloadStatus.downloading,
                          ),
                          controller: this,
                        );
                      },
                    );
                  }
                  return const HttpError();
                }),
              ),
            ],
          ),
        ),
      );
    });
  }

  @override
  void onRemove() {
    showConfirmDialog(
      context: context,
      title: Text(context.l10n.downloadDeleteSelectedConfirm),
      onConfirm: () async {
        SmartDialog.showLoading();
        final allChecked = this.allChecked.toSet();
        final isDownloading =
            _downloadService.curDownload.value?.status ==
            DownloadStatus.downloading;
        for (final entry in allChecked) {
          await _downloadService.deleteDownload(
            entry: entry,
            refresh: false,
            downloadNext: false,
          );
        }
        _downloadService.waitDownloadQueue.removeWhere(allChecked.contains);
        if (isDownloading && _downloadService.curDownload.value == null) {
          _downloadService.nextDownload();
        }
        if (enableMultiSelect.value) {
          rxCount.value = 0;
          enableMultiSelect.value = false;
        }
        SmartDialog.dismiss();
      },
    );
  }
}
