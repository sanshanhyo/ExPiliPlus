import 'dart:math' show max;

import 'package:ex_piliplus/common/style.dart';
import 'package:ex_piliplus/common/widgets/button/icon_button.dart';
import 'package:ex_piliplus/common/widgets/button/toolbar_icon_button.dart';
import 'package:ex_piliplus/common/widgets/custom_icon.dart';
import 'package:ex_piliplus/common/widgets/flutter/draggable_scrollable_sheet.dart';
import 'package:ex_piliplus/common/widgets/flutter/text_field/controller.dart';
import 'package:ex_piliplus/common/widgets/flutter/text_field/text_field.dart';
import 'package:ex_piliplus/common/widgets/pair.dart';
import 'package:ex_piliplus/common/widgets/scroll_physics.dart'
    show platformClampingPhysics;
import 'package:ex_piliplus/common/widgets/time_picker.dart';
import 'package:ex_piliplus/http/dynamics.dart';
import 'package:ex_piliplus/http/loading_state.dart';
import 'package:ex_piliplus/models/common/publish_panel_type.dart';
import 'package:ex_piliplus/models/common/reply/reply_option_type.dart';
import 'package:ex_piliplus/models/dynamics/result.dart' show PicModel;
import 'package:ex_piliplus/models/dynamics/vote_model.dart';
import 'package:ex_piliplus/models_new/dynamic/dyn_reserve_info/data.dart';
import 'package:ex_piliplus/models_new/dynamic/dyn_topic_top/topic_item.dart';
import 'package:ex_piliplus/pages/common/publish/common_rich_text_pub_page.dart';
import 'package:ex_piliplus/pages/dynamics_create_reserve/view.dart';
import 'package:ex_piliplus/pages/dynamics_create_vote/view.dart';
import 'package:ex_piliplus/pages/dynamics_mention/controller.dart';
import 'package:ex_piliplus/pages/dynamics_select_topic/controller.dart';
import 'package:ex_piliplus/pages/dynamics_select_topic/view.dart';
import 'package:ex_piliplus/pages/emote/controller.dart';
import 'package:ex_piliplus/pages/emote/view.dart';
import 'package:ex_piliplus/utils/accounts.dart';
import 'package:ex_piliplus/utils/date_utils.dart';
import 'package:ex_piliplus/utils/extension/context_ext.dart';
import 'package:ex_piliplus/utils/extension/l10n_ext.dart';
import 'package:ex_piliplus/utils/grid.dart';
import 'package:ex_piliplus/utils/request_utils.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart' hide showTimePicker;
import 'package:flutter/services.dart' show LengthLimitingTextInputFormatter;
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';

class CreateDynPanel extends CommonRichTextPubPage {
  const CreateDynPanel({
    super.key,
    super.imageLengthLimit = 18,
    super.items,
    super.pics,
    this.scrollController,
    this.topic,
    this.editConfig,
    this.title,
    this.isPrivate = false,
    this.replyOption = .allow,
    this.onSuccess,
  });

  final ScrollController? scrollController;
  final String? title;
  final Pair<int, String>? topic;
  final bool isPrivate;
  final ReplyOptionType replyOption;
  final ({Object dynId, Object? repostDynId})? editConfig;
  final VoidCallback? onSuccess;

  @override
  State<CreateDynPanel> createState() => _CreateDynPanelState();

  static void onCreateDyn(
    BuildContext context, {
    String? title,
    bool isPrivate = false,
    ReplyOptionType replyOption = .allow,
    List<RichTextItem>? items,
    List<PicModel>? pics,
    Pair<int, String>? topic,
    ({Object dynId, Object? repostDynId})? editConfig,
    VoidCallback? onSuccess,
  }) => showModalBottomSheet(
    context: context,
    useSafeArea: true,
    isScrollControlled: true,
    builder: (context) => DynDraggableScrollableSheet(
      snap: true,
      expand: false,
      initialChildSize: 1,
      minChildSize: 0,
      maxChildSize: 1,
      snapSizes: const [1],
      builder: (context, scrollController) => CreateDynPanel(
        scrollController: scrollController,
        title: title,
        items: items,
        pics: pics,
        topic: topic,
        isPrivate: isPrivate,
        editConfig: editConfig,
        replyOption: replyOption,
        onSuccess: onSuccess,
      ),
    ),
  );
}

class _CreateDynPanelState extends CommonRichTextPubPageState<CreateDynPanel> {
  late final bool _isEdit;
  late final RxBool _isPrivate;
  late final Rx<Pair<int, String>?> _topic;
  late final Rx<ReplyOptionType> _replyOption;
  late final TextEditingController _titleEditCtr;
  late final _publishTime = Rxn<DateTime>();
  final _reserveCard = Rxn<ReserveInfoData>();

  @override
  void initState() {
    super.initState();
    _isEdit = widget.editConfig != null;
    _isPrivate = widget.isPrivate.obs;
    _replyOption = widget.replyOption.obs;
    _topic = Rx<Pair<int, String>?>(widget.topic);
    _titleEditCtr = TextEditingController(text: widget.title);
  }

  @override
  void dispose() {
    _titleEditCtr.dispose();
    Get
      ..delete<EmotePanelController>()
      ..delete<SelectTopicController>()
      ..delete<DynMentionController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildAppBar(theme),
        Expanded(
          child: ListView(
            padding: EdgeInsets.zero,
            controller: widget.scrollController,
            physics: platformClampingPhysics,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Obx(
                  () {
                    final hasTopic = _topic.value != null;
                    return Row(
                      spacing: 10,
                      children: [
                        TextButton(
                          style: TextButton.styleFrom(
                            overlayColor: hasTopic ? Colors.transparent : null,
                            splashFactory: hasTopic
                                ? NoSplash.splashFactory
                                : null,
                            shape: hasTopic
                                ? null
                                : RoundedRectangleBorder(
                                    side: BorderSide(
                                      color: hasTopic
                                          ? Colors.transparent
                                          : theme.colorScheme.outline
                                                .withValues(alpha: 0.2),
                                    ),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(25),
                                    ),
                                  ),
                            minimumSize: Size.zero,
                            padding: hasTopic
                                ? const EdgeInsets.symmetric(vertical: 12)
                                : const EdgeInsets.all(12),
                            visualDensity: VisualDensity.compact,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          onPressed: _onSelectTopic,
                          child: Text.rich(
                            TextSpan(
                              children: [
                                WidgetSpan(
                                  alignment: .middle,
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 5),
                                    child: Icon(
                                      CustomIcons.topic_tag,
                                      size: 18,
                                      color: hasTopic
                                          ? null
                                          : theme.colorScheme.outline,
                                    ),
                                  ),
                                ),
                                TextSpan(
                                  text: hasTopic
                                      ? _topic.value!.second
                                      : context.l10n.feedSelectTopic,
                                  style: TextStyle(
                                    color: hasTopic
                                        ? null
                                        : theme.colorScheme.outline,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        if (hasTopic)
                          iconButton(
                            size: 22,
                            iconSize: 16,
                            icon: const Icon(Icons.clear),
                            bgColor: theme.colorScheme.onInverseSurface,
                            iconColor: theme.colorScheme.onSurfaceVariant,
                            onPressed: () => _topic.value = null,
                          ),
                      ],
                    );
                  },
                ),
              ),
              const SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextField(
                  controller: _titleEditCtr,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  decoration: InputDecoration(
                    hintText: context.l10n.feedOptionalTitleHint,
                    isDense: true,
                    visualDensity: .standard,
                    contentPadding: EdgeInsets.zero,
                    border: const OutlineInputBorder(
                      gapPadding: 0,
                      borderSide: BorderSide.none,
                    ),
                    hintStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.outline.withValues(alpha: 0.7),
                    ),
                  ),
                  inputFormatters: [LengthLimitingTextInputFormatter(20)],
                ),
              ),
              const SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: _buildEditWidget(theme),
              ),
              const SizedBox(height: 16),
              _buildReserveItem(theme),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Obx(() => _buildPubTimeWidget),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Obx(() => _buildReplyOptionWidget(theme)),
                        const SizedBox(height: 5),
                        Obx(() => _buildPrivateWidget(theme)),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              _buildImageList(theme),
            ],
          ),
        ),
        _buildToolbar,
        buildPanelContainer(theme, Colors.transparent),
      ],
    );
  }

  Widget _buildImageList(ThemeData theme) => SizedBox(
    height: 100,
    child: Obx(
      () => CustomScrollView(
        scrollDirection: Axis.horizontal,
        slivers: [
          const SliverToBoxAdapter(child: SizedBox(width: 16)),
          if (imageList.isNotEmpty)
            SliverPadding(
              padding: const .only(right: 10),
              sliver: SliverList.separated(
                itemCount: imageList.length,
                itemBuilder: (context, index) => buildImage(index, 100),
                separatorBuilder: (_, _) => const SizedBox(width: 10),
              ),
            ),
          if (imageList.length != limit)
            SliverToBoxAdapter(
              child: Material(
                borderRadius: Style.mdRadius,
                child: InkWell(
                  borderRadius: Style.mdRadius,
                  onTap: () => onPickImage(() {
                    if (imageList.isNotEmpty && !enablePublish.value) {
                      enablePublish.value = true;
                    }
                  }),
                  child: Ink(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: Style.mdRadius,
                      color: theme.colorScheme.secondaryContainer,
                    ),
                    child: const Center(child: Icon(Icons.add, size: 35)),
                  ),
                ),
              ),
            ),
          const SliverToBoxAdapter(child: SizedBox(width: 16)),
        ],
      ),
    ),
  );

  Widget _buildAppBar(ThemeData theme) => Container(
    height: 66,
    padding: const EdgeInsets.all(16),
    child: Stack(
      clipBehavior: Clip.none,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: SizedBox(
            width: 34,
            height: 34,
            child: IconButton(
              tooltip: context.l10n.commonBack,
              style: ButtonStyle(
                padding: const WidgetStatePropertyAll(EdgeInsets.zero),
                backgroundColor: WidgetStatePropertyAll(
                  theme.colorScheme.secondaryContainer,
                ),
              ),
              onPressed: Get.back,
              icon: Icon(
                Icons.arrow_back_outlined,
                size: 18,
                color: theme.colorScheme.onSecondaryContainer,
              ),
            ),
          ),
        ),
        Center(
          child: Text(
            _isEdit
                ? context.l10n.feedEditPostTitle
                : context.l10n.feedCreatePostTitle,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Obx(
            () => FilledButton.tonal(
              onPressed: enablePublish.value ? onPublishThrottle : null,
              style: FilledButton.styleFrom(
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                visualDensity: VisualDensity.compact,
              ),
              child: Text(
                _publishTime.value == null
                    ? context.l10n.feedPublish
                    : context.l10n.feedScheduledPost,
              ),
            ),
          ),
        ),
      ],
    ),
  );

  Widget _buildPrivateWidget(ThemeData theme) {
    final color = _isPrivate.value
        ? theme.colorScheme.error
        : theme.colorScheme.secondary;
    return PopupMenuButton<bool>(
      requestFocus: false,
      initialValue: _isPrivate.value,
      onSelected: _isPrivate.call,
      itemBuilder: (context) => List.generate(
        2,
        (index) => PopupMenuItem<bool>(
          enabled: _publishTime.value != null && index == 1 ? false : true,
          value: index == 0 ? false : true,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                size: 19,
                index == 0 ? Icons.visibility : Icons.visibility_off,
              ),
              const SizedBox(width: 4),
              Text(
                index == 0
                    ? context.l10n.feedVisibleToEveryone
                    : context.l10n.feedVisibleOnlyToMe,
              ),
            ],
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              size: 19,
              _isPrivate.value ? Icons.visibility_off : Icons.visibility,
              color: color,
            ),
            const SizedBox(width: 4),
            Text(
              _isPrivate.value
                  ? context.l10n.feedVisibleOnlyToMe
                  : context.l10n.feedVisibleToEveryone,
              style: TextStyle(
                height: 1,
                color: color,
              ),
              strutStyle: const StrutStyle(leading: 0, height: 1),
            ),
            Icon(
              size: 20,
              Icons.keyboard_arrow_right,
              color: color,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReplyOptionWidget(ThemeData theme) {
    final color = _replyOption.value == ReplyOptionType.close
        ? theme.colorScheme.error
        : theme.colorScheme.secondary;
    return PopupMenuButton<ReplyOptionType>(
      requestFocus: false,
      initialValue: _replyOption.value,
      onSelected: (item) => _replyOption.value = item,
      itemBuilder: (context) => ReplyOptionType.values
          .map(
            (item) => PopupMenuItem<ReplyOptionType>(
              value: item,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    size: 19,
                    item.iconData,
                  ),
                  const SizedBox(width: 4),
                  Text(item.localizedTitle(context.l10n)),
                ],
              ),
            ),
          )
          .toList(),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              size: 19,
              _replyOption.value.iconData,
              color: color,
            ),
            const SizedBox(width: 4),
            Text(
              _replyOption.value.localizedTitle(context.l10n),
              style: TextStyle(
                height: 1,
                color: color,
              ),
              strutStyle: const StrutStyle(leading: 0, height: 1),
            ),
            Icon(
              size: 20,
              Icons.keyboard_arrow_right,
              color: color,
            ),
          ],
        ),
      ),
    );
  }

  Widget get _buildPubTimeWidget => _publishTime.value == null
      ? FilledButton.tonal(
          style: FilledButton.styleFrom(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 10,
            ),
            visualDensity: VisualDensity.compact,
          ),
          onPressed: _isEdit || _isPrivate.value
              ? null
              : () async {
                  DateTime nowDate = DateTime.now();
                  final selectedDate = await showDatePicker(
                    context: context,
                    initialDate: nowDate,
                    firstDate: nowDate,
                    lastDate: DateTime(
                      nowDate.year,
                      nowDate.month,
                      nowDate.day + 7,
                    ),
                  );
                  if (selectedDate != null && mounted) {
                    TimeOfDay nowTime = TimeOfDay.now();
                    final selectedTime = await showTimePicker(
                      context: context,
                      initialTime: nowTime.replacing(
                        hour: nowTime.minute + 6 >= 60
                            ? (nowTime.hour + 1) % 24
                            : nowTime.hour,
                        minute: (nowTime.minute + 6) % 60,
                      ),
                    );
                    if (selectedTime != null) {
                      if (selectedDate.day == nowDate.day) {
                        if (selectedTime.hour < nowTime.hour) {
                          SmartDialog.showToast(
                            Get.context!.l10n.feedScheduleAtLeastMinutes(6),
                          );
                          return;
                        } else if (selectedTime.hour == nowTime.hour) {
                          if (selectedTime.minute < nowTime.minute + 6) {
                            if (selectedDate.day == nowDate.day) {
                              SmartDialog.showToast(
                                Get.context!.l10n.feedScheduleAtLeastMinutes(6),
                              );
                            }
                            return;
                          }
                        }
                      }
                      _publishTime.value = DateTime(
                        selectedDate.year,
                        selectedDate.month,
                        selectedDate.day,
                        selectedTime.hour,
                        selectedTime.minute,
                      );
                    }
                  }
                },
          child: Text(context.l10n.feedScheduledPost),
        )
      : OutlinedButton.icon(
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 10,
            ),
            visualDensity: VisualDensity.compact,
          ),
          onPressed: () => _publishTime.value = null,
          label: Text(DateFormatUtils.longFormatD.format(_publishTime.value!)),
          icon: const Icon(Icons.clear, size: 20),
          iconAlignment: IconAlignment.end,
        );

  Widget get _buildToolbar => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    child: Row(
      spacing: 16,
      children: [
        emojiBtn,
        atBtn,
        if (!_isEdit) ...[
          voteBtn,
          moreBtn,
        ],
        // if (kDebugMode)
        //   ToolbarIconButton(
        //     onPressed: editController.clear,
        //     icon: const Icon(Icons.clear, size: 22),
        //     selected: false,
        //   ),
      ],
    ),
  );

  @override
  Widget buildMorePanel(ThemeData theme) {
    double height = context.isTablet ? 300 : 170;
    final keyboardHeight = controller.keyboardHeight;
    if (keyboardHeight != 0) {
      height = max(height, keyboardHeight);
    }

    Widget item({
      required VoidCallback onTap,
      required Icon icon,
      required String title,
    }) {
      return GestureDetector(
        onTap: onTap,
        child: Column(
          spacing: 5,
          mainAxisSize: MainAxisSize.min,
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: Container(
                decoration: BoxDecoration(
                  color: theme.colorScheme.onInverseSurface,
                  borderRadius: const BorderRadius.all(Radius.circular(6)),
                ),
                alignment: Alignment.center,
                child: icon,
              ),
            ),
            Text(
              title,
              maxLines: 1,
              style: const TextStyle(fontSize: 13),
            ),
          ],
        ),
      );
    }

    final color = theme.colorScheme.onSurfaceVariant;

    return SizedBox(
      height: height,
      child: GridView(
        physics: platformClampingPhysics,
        padding: const EdgeInsets.only(left: 12, bottom: 12, right: 12),
        gridDelegate: SliverGridDelegateWithExtentAndRatio(
          maxCrossAxisExtent: 65,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          mainAxisExtent: 25,
        ),
        children: [
          item(
            onTap: _onReserve,
            icon: Icon(CustomIcons.live_reserve, size: 28, color: color),
            title: context.l10n.feedLiveReservation,
          ),
        ],
      ),
    );
  }

  Widget get voteBtn => ToolbarIconButton(
    onPressed: () async {
      final l10n = context.l10n;
      final voteItem = editController.items.firstWhereOrNull(
        (e) => e.type == RichTextType.vote,
      );
      final voteInfo = await Navigator.of(context).push<VoteInfo>(
        GetPageRoute(
          page: () => CreateVotePage(
            voteId: voteItem?.id == null ? null : int.parse(voteItem!.id!),
          ),
        ),
      );
      if (voteInfo != null) {
        if (voteItem != null) {
          final range = voteItem.range;
          final text = ' ${voteInfo.title} ';
          final selection = TextSelection.collapsed(
            offset: range.start + text.length,
          );
          final delta = RichTextEditingDeltaReplacement(
            oldText: editController.text,
            replacementText: text,
            replacedRange: range,
            selection: selection,
            composing: TextRange.empty,
            type: RichTextType.vote,
            id: voteInfo.voteId.toString(),
            rawText: voteInfo.title,
          );
          final newValue = delta.apply(editController.value);
          editController
            ..syncRichText(delta)
            ..value = newValue;
        } else {
          onInsertText(
            l10n.feedStartedPoll,
            RichTextType.text,
          );
          onInsertText(
            ' ${voteInfo.title} ',
            RichTextType.vote,
            rawText: voteInfo.title,
            id: voteInfo.voteId.toString(),
          );
        }
      }
    },
    icon: const Icon(Icons.bar_chart_rounded, size: 24),
    tooltip: context.l10n.feedPoll,
    selected: false,
  );

  Widget _buildEditWidget(ThemeData theme) => Listener(
    onPointerUp: (event) {
      if (readOnly.value) {
        updatePanelType(PanelType.keyboard);
      }
    },
    child: Obx(
      () => RichTextField(
        key: key,
        controller: editController,
        minLines: 4,
        maxLines: null,
        focusNode: focusNode,
        readOnly: readOnly.value,
        onChanged: onChanged,
        onSubmitted: onSubmitted,
        decoration: InputDecoration(
          hintText: context.l10n.feedSaySomething,
          visualDensity: .standard,
          hintStyle: TextStyle(color: theme.colorScheme.outline),
          border: const OutlineInputBorder(
            borderSide: BorderSide.none,
            gapPadding: 0,
          ),
          contentPadding: EdgeInsets.zero,
        ),
        // inputFormatters: [LengthLimitingTextInputFormatter(1000)],
      ),
    ),
  );

  @override
  Widget? get customPanel => EmotePanel(onChoose: onChooseEmote);

  @override
  Future<void> onCustomPublish({List? pictures}) async {
    final l10n = context.l10n;
    SmartDialog.showLoading(msg: l10n.feedPosting);
    List<Map<String, dynamic>>? extraContent = getRichContent();
    final hasRichText = extraContent != null;

    if (_isEdit) {
      final editConfig = widget.editConfig!;
      final res = await DynamicsHttp.editDyn(
        dynId: editConfig.dynId,
        repostDynId: editConfig.repostDynId,
        rawText: hasRichText ? null : editController.text,
        pics: pictures,
        replyOption: _replyOption.value,
        privatePub: _isPrivate.value ? 1 : null,
        title: _titleEditCtr.text,
        topic: _topic.value,
        extraContent: extraContent,
      );
      SmartDialog.dismiss();
      if (res.isSuccess) {
        hasPub = true;
        Get.back();
        SmartDialog.showToast(l10n.feedPosted);
        widget.onSuccess?.call();
      } else {
        res.toast();
      }
      return;
    }

    final reserveCard = _reserveCard.value;
    final res = await DynamicsHttp.createDynamic(
      mid: Accounts.main.mid,
      rawText: hasRichText ? null : editController.text,
      pics: pictures,
      publishTime: _publishTime.value != null
          ? _publishTime.value!.millisecondsSinceEpoch ~/ 1000
          : null,
      replyOption: _replyOption.value,
      privatePub: _isPrivate.value ? 1 : null,
      title: _titleEditCtr.text,
      topic: _topic.value,
      extraContent: extraContent,
      attachCard: reserveCard == null
          ? null
          : {
              "common_card": {
                "type": 14,
                "biz_id": reserveCard.id,
                "reserve_source": 0,
                "reserve_lottery": 0,
              },
            },
    );
    SmartDialog.dismiss();
    if (res case Success(:final response)) {
      hasPub = true;
      Get.back();
      SmartDialog.showToast(l10n.feedPosted);
      final id = response?['dyn_id'];
      RequestUtils.insertCreatedDyn(id);
      if (!_isPrivate.value && _publishTime.value == null) {
        RequestUtils.checkCreatedDyn(
          id: id,
          dynText: editController.rawText,
        );
      }
    } else {
      res.toast();
    }
  }

  double _topicOffset = 0;
  Future<void> _onSelectTopic() async {
    TopicItem? res = await SelectTopicPanel.onSelectTopic(
      context,
      offset: _topicOffset,
      onCachePos: (offset) => _topicOffset = offset,
    );
    if (res != null) {
      _topic.value = Pair(first: res.id, second: res.name);
    }
  }

  @override
  void onSave() {}

  Widget _buildReserveItem(ThemeData theme) {
    return Obx(
      () {
        final reserveCard = _reserveCard.value;
        if (reserveCard == null) {
          return const SizedBox.shrink();
        }
        return Stack(
          clipBehavior: Clip.none,
          children: [
            GestureDetector(
              onTap: _onReserve,
              behavior: HitTestBehavior.opaque,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  color: theme.colorScheme.onInverseSurface,
                ),
                margin: const EdgeInsets.only(left: 16, right: 16, bottom: 10),
                padding: const EdgeInsets.fromLTRB(12, 12, 30, 12),
                child: Column(
                  spacing: 3,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      context.l10n.feedLiveReservationTitle(
                        reserveCard.title ?? '',
                      ),
                    ),
                    Text(
                      context.l10n.feedLiveStartsAt(
                        DateFormatUtils.longFormatD.format(
                          DateTime.fromMillisecondsSinceEpoch(
                            reserveCard.livePlanStartTime! * 1000,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              right: 18,
              top: 2,
              child: iconButton(
                size: 30,
                iconSize: 18,
                icon: const Icon(Icons.clear),
                onPressed: () => _reserveCard.value = null,
                iconColor: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _onReserve() async {
    final ReserveInfoData? reserveInfo = await Navigator.of(context).push(
      GetPageRoute(
        page: () => CreateReservePage(sid: _reserveCard.value?.id),
      ),
    );
    if (reserveInfo != null) {
      _reserveCard.value = reserveInfo;
    }
  }
}
