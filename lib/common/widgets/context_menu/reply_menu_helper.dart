part of 'package:ex_piliplus/pages/video/reply/widgets/reply_item_grpc.dart';

void showReplyCopyDialog(
  BuildContext context,
  String message,
  Map<String, Emote> emotes,
) {
  bool showEmote = false;
  showDialog(
    context: context,
    builder: (context) => Dialog(
      constraints: const BoxConstraints.tightFor(width: 380),
      child: Padding(
        padding: const .symmetric(horizontal: 20, vertical: 16),
        child: SingleChildScrollView(
          child: SelectionText.rich(
            showEmote
                ? TextSpan(
                    children: emotes.entries.mapIndexed(
                      (i, e) {
                        final emote = e.value;
                        final size = emote.size.toInt() * 25.0;
                        return TextSpan(
                          children: [
                            if (i != 0) const TextSpan(text: '\n\n'),
                            EmoteSpan(
                              rawText: Style.placeHolder,
                              child: NetworkImgLayer(
                                src: emote.url,
                                type: .emote,
                                width: size,
                                height: size,
                              ),
                            ),
                            TextSpan(text: '\n${e.key}\n${emote.url}'),
                          ],
                        );
                      },
                    ).toList(),
                  )
                : TextSpan(text: message),
            contextMenuBuilder: (_, state) {
              final buttonItems = state.contextMenuButtonItems;
              if (emotes.isNotEmpty) {
                buttonItems.insertOrAdd(
                  3,
                  ContextMenuButtonItem(
                    label: showEmote
                        ? context.l10n.replyContentText
                        : context.l10n.replyContentEmoji,
                    onPressed: () {
                      state.hideAndClear();
                      showEmote = !showEmote;
                      (context as Element).markNeedsBuild();
                    },
                  ),
                );
                if (showEmote) {
                  state.addLaunchMenuIfNeeded(buttonItems, index: 4);
                }
              }
              if (state.isUncollapsed) {
                buttonItems.add(
                  ContextMenuButtonItem(
                    onPressed: () {
                      String text = RegExp.escape(state.selectedText!);
                      if (ReplyGrpc.enableFilter) text = '|$text';

                      showConfirmDialog(
                        context: context,
                        title: Text(
                          context.l10n.replyFilterChangeConfirm,
                        ),
                        content: Text.rich(
                          TextSpan(
                            text: ReplyGrpc.replyRegExp.pattern,
                            children: [
                              TextSpan(
                                text: text,
                                style: const TextStyle(
                                  color: Colors.green,
                                  fontWeight: .bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        onConfirm: () {
                          final filter = ReplyGrpc.replyRegExp.pattern + text;
                          ReplyGrpc.replyRegExp = RegExp(
                            filter,
                            caseSensitive: true,
                          );
                          ReplyGrpc.enableFilter = true;
                          GStorage.setting.put(
                            SettingBoxKey.banWordForReply,
                            filter,
                          );
                          SmartDialog.showToast(context.l10n.commonSaved);
                        },
                      );
                    },
                    label: context.l10n.replyAddToFilter,
                  ),
                );
              }
              return AdaptiveTextSelectionToolbar.buttonItems(
                buttonItems: buttonItems,
                anchors: state.contextMenuAnchors,
              );
            },
            style: const TextStyle(fontSize: 15, height: 1.7),
          ),
        ),
      ),
    ),
  );
}
