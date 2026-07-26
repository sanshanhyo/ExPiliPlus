import 'package:ex_piliplus/utils/extension/l10n_ext.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<bool> showConfirmDialog({
  required BuildContext context,
  required Widget title,
  Widget? content,
  // @Deprecated('use `bool result = await showConfirmDialog()` instead')
  VoidCallback? onConfirm,
}) async {
  return await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: title,
          content: content,
          actions: [
            TextButton(
              onPressed: Get.back,
              child: Text(
                context.l10n.commonCancel,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.outline,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Get.back(result: true);
                onConfirm?.call();
              },
              child: Text(context.l10n.commonConfirm),
            ),
          ],
        ),
      ) ??
      false;
}

void showPgcFollowDialog({
  required BuildContext context,
  required String type,
  required int followStatus,
  required ValueChanged<int> onUpdateStatus,
}) {
  final l10n = context.l10n;
  Widget statusItem({
    required bool enabled,
    required String text,
    required VoidCallback onTap,
  }) {
    return ListTile(
      dense: true,
      enabled: enabled,
      title: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Text(
          l10n.videoMarkAs(text),
          style: const TextStyle(fontSize: 14),
        ),
      ),
      trailing: !enabled ? const Icon(size: 22, Icons.check) : null,
      onTap: onTap,
    );
  }

  showDialog(
    context: context,
    builder: (context) => SimpleDialog(
      clipBehavior: Clip.hardEdge,
      contentPadding: const EdgeInsets.symmetric(vertical: 12),
      children: [
        ...[
          (followStatus: 3, title: l10n.videoStatusWatched),
          (followStatus: 2, title: l10n.videoStatusWatching),
          (followStatus: 1, title: l10n.videoStatusWantToWatch),
        ].map(
          (item) => statusItem(
            enabled: followStatus != item.followStatus,
            text: item.title,
            onTap: () {
              Get.back();
              onUpdateStatus(item.followStatus);
            },
          ),
        ),
        ListTile(
          dense: true,
          title: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              l10n.videoCancelFollowingType(type),
              style: const TextStyle(fontSize: 14),
            ),
          ),
          onTap: () {
            Get.back();
            onUpdateStatus(-1);
          },
        ),
      ],
    ),
  );
}
