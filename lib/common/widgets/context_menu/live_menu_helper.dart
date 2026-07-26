part of 'package:ex_piliplus/pages/live_room/superchat/superchat_card.dart';

Widget scMenuBuilder(
  BuildContext context,
  SelectableRegionState state,
) {
  final buttonItems = state.contextMenuButtonItems;
  if (state.isUncollapsed) {
    buttonItems
      ..insertOrAdd(
        3,
        ContextMenuButtonItem(
          label: context.l10n.commonVideo,
          onPressed: () {
            state.onMenuPressed(
              (text) => PiliScheme.videoPush(null, text),
            );
          },
        ),
      )
      ..insertOrAdd(
        4,
        ContextMenuButtonItem(
          label: context.l10n.commonSearch,
          onPressed: () {
            state.onMenuPressed(
              (text) => Get.toNamed(
                '/searchResult',
                parameters: {'keyword': text},
              ),
            );
          },
        ),
      );
  }
  return AdaptiveTextSelectionToolbar.buttonItems(
    buttonItems: buttonItems,
    anchors: state.contextMenuAnchors,
  );
}
