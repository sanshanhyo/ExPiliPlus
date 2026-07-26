import 'package:ex_piliplus/common/widgets/dialog/dialog.dart';
import 'package:ex_piliplus/grpc/bilibili/app/im/v1.pb.dart'
    show ThreeDotItem, ThreeDotItemType, IMSettingType;
import 'package:ex_piliplus/pages/common/common_whisper_controller.dart';
import 'package:ex_piliplus/pages/contact/view.dart';
import 'package:ex_piliplus/pages/whisper_settings/view.dart';
import 'package:ex_piliplus/utils/extension/l10n_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

extension ThreeDotItemTypeExt on ThreeDotItemType {
  Icon get icon => switch (this) {
    ThreeDotItemType.THREE_DOT_ITEM_TYPE_MSG_SETTING => const Icon(
      Icons.settings,
      size: 20,
    ),
    ThreeDotItemType.THREE_DOT_ITEM_TYPE_READ_ALL => const Icon(
      Icons.cleaning_services,
      size: 20,
    ),
    ThreeDotItemType.THREE_DOT_ITEM_TYPE_CLEAR_LIST => const Icon(
      Icons.delete_forever_outlined,
      size: 20,
    ),
    ThreeDotItemType.THREE_DOT_ITEM_TYPE_UP_HELPER => const Icon(
      Icons.live_tv,
      size: 20,
    ),
    ThreeDotItemType.THREE_DOT_ITEM_TYPE_CONTACTS => const Icon(
      Icons.account_box_outlined,
      size: 20,
    ),
    ThreeDotItemType.THREE_DOT_ITEM_TYPE_FANS_GROUP_HELPER => const Icon(
      Icons.notifications_none,
      size: 20,
    ),
    _ => const Icon(MdiIcons.circleMedium, size: 20),
  };

  String localizedTitle(BuildContext context, ThreeDotItem item) =>
      switch (this) {
        ThreeDotItemType.THREE_DOT_ITEM_TYPE_MSG_SETTING =>
          context.l10n.messagesMenuSettings,
        ThreeDotItemType.THREE_DOT_ITEM_TYPE_READ_ALL =>
          context.l10n.messagesMarkAllRead,
        ThreeDotItemType.THREE_DOT_ITEM_TYPE_CLEAR_LIST =>
          context.l10n.messagesClearList,
        ThreeDotItemType.THREE_DOT_ITEM_TYPE_UP_HELPER =>
          context.l10n.messagesUploaderAssistant,
        ThreeDotItemType.THREE_DOT_ITEM_TYPE_CONTACTS =>
          context.l10n.messagesContacts,
        ThreeDotItemType.THREE_DOT_ITEM_TYPE_FANS_GROUP_HELPER =>
          context.l10n.messagesFanGroupAssistant,
        _ => item.title,
      };

  void action({
    required BuildContext context,
    required CommonWhisperController controller,
    required ThreeDotItem item,
  }) {
    switch (this) {
      case ThreeDotItemType.THREE_DOT_ITEM_TYPE_READ_ALL:
        showConfirmDialog(
          context: context,
          title: Text(context.l10n.messagesMarkAllRead),
          content: Text(context.l10n.messagesMarkAllReadConfirm),
          onConfirm: controller.onClearUnread,
        );
      case ThreeDotItemType.THREE_DOT_ITEM_TYPE_CLEAR_LIST:
        showConfirmDialog(
          context: context,
          title: Text(context.l10n.messagesClearList),
          content: Text(context.l10n.messagesClearListConfirm),
          onConfirm: controller.onDeleteList,
        );
      case ThreeDotItemType.THREE_DOT_ITEM_TYPE_MSG_SETTING:
        Get.to(
          const WhisperSettingsPage(
            imSettingType: IMSettingType.SETTING_TYPE_NEED_ALL,
          ),
        );
      case ThreeDotItemType.THREE_DOT_ITEM_TYPE_UP_HELPER:
        dynamic talkerId = RegExp(r'/(\d{3,})').firstMatch(item.url)?.group(1);
        if (talkerId != null) {
          talkerId = int.parse(talkerId);
          Get.toNamed(
            '/whisperDetail',
            arguments: {
              'talkerId': talkerId,
              'name': item.title,
              'face': switch (talkerId) {
                844424930131966 =>
                  'https://message.biliimg.com/bfs/im/489a63efadfb202366c2f88853d2217b5ddc7a13.png',
                844424930131964 =>
                  'https://i0.hdslb.com/bfs/im_new/58eda511672db078466e7ab8db22a95c1503684976.png',
                _ => item.icon,
              },
            },
          );
        }
      case ThreeDotItemType.THREE_DOT_ITEM_TYPE_CONTACTS:
        Get.to(const ContactPage(isFromSelect: false));
      default:
        SmartDialog.showToast('TODO: $name');
    }
  }
}
