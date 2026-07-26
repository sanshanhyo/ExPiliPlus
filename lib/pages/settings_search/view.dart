import 'package:ex_piliplus/common/widgets/loading_widget/http_error.dart';
import 'package:ex_piliplus/common/widgets/view_sliver_safe_area.dart';
import 'package:ex_piliplus/pages/search/controller.dart'
    show DebounceStreamState;
import 'package:ex_piliplus/pages/setting/models/extra_settings.dart';
import 'package:ex_piliplus/pages/setting/models/ex_features_settings.dart';
import 'package:ex_piliplus/pages/setting/models/model.dart';
import 'package:ex_piliplus/pages/setting/models/play_settings.dart';
import 'package:ex_piliplus/pages/setting/models/privacy_settings.dart';
import 'package:ex_piliplus/pages/setting/models/recommend_settings.dart';
import 'package:ex_piliplus/pages/setting/models/style_settings.dart';
import 'package:ex_piliplus/pages/setting/models/video_settings.dart';
import 'package:ex_piliplus/utils/extension/l10n_ext.dart';
import 'package:ex_piliplus/utils/grid.dart';
import 'package:ex_piliplus/utils/waterfall.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waterfall_flow/waterfall_flow.dart'
    hide SliverWaterfallFlowDelegateWithMaxCrossAxisExtent;

class SettingsSearchPage extends StatefulWidget {
  const SettingsSearchPage({super.key});

  @override
  State<SettingsSearchPage> createState() => _SettingsSearchPageState();
}

class _SettingsSearchPageState
    extends DebounceStreamState<SettingsSearchPage, String> {
  final _textEditingController = TextEditingController();
  final RxList<SettingsModel> _list = <SettingsModel>[].obs;
  List<SettingsModel> get _settings => [
    ...extraSettings(context),
    ...privacySettings(context),
    ...recommendSettings(context),
    ...videoSettings(context),
    ...playSettings(context),
    ...styleSettings(context),
    ...exFeatureSettings(context),
  ];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_textEditingController.text.isNotEmpty) {
      onValueChanged(_textEditingController.text);
    }
  }

  @override
  void onValueChanged(String value) {
    if (value.isEmpty) {
      _list.clear();
    } else {
      value = value.toLowerCase();
      _list.value = _settings
          .where(
            (item) =>
                item.effectiveTitle.toLowerCase().contains(value) ||
                item.effectiveSubtitle?.toLowerCase().contains(value) == true,
          )
          .toList();
    }
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              if (_textEditingController.text.isNotEmpty) {
                _textEditingController.clear();
                _list.clear();
              } else {
                Get.back();
              }
            },
            icon: const Icon(Icons.clear),
          ),
          const SizedBox(width: 10),
        ],
        title: TextField(
          autofocus: true,
          controller: _textEditingController,
          textAlignVertical: TextAlignVertical.center,
          onChanged: ctr!.add,
          decoration: InputDecoration(
            isDense: true,
            hintText: context.l10n.settingsSearch,
            visualDensity: .standard,
            border: InputBorder.none,
          ),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          ViewSliverSafeArea(
            sliver: Obx(
              () => _list.isEmpty
                  ? const HttpError()
                  : SliverWaterfallFlow(
                      gridDelegate:
                          SliverWaterfallFlowDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: Grid.smallCardWidth * 2,
                          ),
                      delegate: SliverChildBuilderDelegate(
                        (_, index) => _list[index].widget,
                        childCount: _list.length,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
