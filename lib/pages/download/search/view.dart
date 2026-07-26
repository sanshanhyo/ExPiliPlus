import 'package:ex_piliplus/common/widgets/loading_widget/http_error.dart';
import 'package:ex_piliplus/http/loading_state.dart';
import 'package:ex_piliplus/models_new/download/bili_download_entry_info.dart';
import 'package:ex_piliplus/pages/common/search/common_search_page.dart';
import 'package:ex_piliplus/pages/download/detail/widgets/item.dart';
import 'package:ex_piliplus/pages/download/search/controller.dart';
import 'package:ex_piliplus/services/download/download_service.dart';
import 'package:ex_piliplus/utils/extension/l10n_ext.dart';
import 'package:ex_piliplus/utils/grid.dart';
import 'package:flutter/material.dart'
    hide SliverGridDelegateWithMaxCrossAxisExtent;
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';

class DownloadSearchPage extends StatefulWidget {
  const DownloadSearchPage({
    super.key,
    required this.progress,
  });

  final ChangeNotifier progress;

  @override
  State<DownloadSearchPage> createState() => _DownloadSearchPageState();
}

class _DownloadSearchPageState
    extends
        CommonSearchPageState<
          DownloadSearchPage,
          List<BiliDownloadEntryInfo>,
          BiliDownloadEntryInfo
        >
    with GridMixin {
  @override
  DownloadSearchController controller = Get.put(DownloadSearchController());
  final _downloadService = Get.find<DownloadService>();

  @override
  List<Widget>? get extraActions => [
    IconButton(
      tooltip: context.l10n.commonMultiSelect,
      onPressed: () {
        if (controller.loadingState.value is! Success) {
          return;
        }
        if (controller.enableMultiSelect.value) {
          controller.handleSelect();
        } else {
          controller.enableMultiSelect.value = true;
        }
      },
      icon: const Icon(Icons.edit_note),
    ),
  ];

  @override
  List<Widget>? get multiSelectActions {
    final l10n = context.l10n;
    return [
      TextButton(
        style: TextButton.styleFrom(visualDensity: VisualDensity.compact),
        onPressed: () async {
          final future = controller.allChecked
              .map(
                (e) => _downloadService.downloadDanmaku(
                  entry: e,
                  isUpdate: true,
                ),
              )
              .toList();
          controller.handleSelect();
          final res = await Future.wait(future);
          if (res.every((e) => e)) {
            SmartDialog.showToast(l10n.commonUpdateSucceeded);
          } else {
            SmartDialog.showToast(l10n.commonUpdateFailed);
          }
        },
        child: Text(
          l10n.commonUpdate,
          style: TextStyle(color: ColorScheme.of(context).onSurface),
        ),
      ),
    ];
  }

  @override
  Widget buildList(List<BiliDownloadEntryInfo> list) {
    if (list.isNotEmpty) {
      return SliverGrid.builder(
        gridDelegate: gridDelegate,
        itemBuilder: (context, index) {
          final entry = list[index];
          return DetailItem(
            entry: entry,
            progress: widget.progress,
            downloadService: _downloadService,
            showTitle: true,
            onDelete: () => controller.onRemoveSingle(index, entry),
            controller: controller,
          );
        },
        itemCount: list.length,
      );
    }
    return const HttpError();
  }
}
