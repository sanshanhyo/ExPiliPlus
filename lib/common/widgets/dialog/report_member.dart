import 'package:ex_piliplus/http/member.dart';
import 'package:ex_piliplus/utils/extension/l10n_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';

Future<void> showMemberReportDialog(
  BuildContext context, {
  required Object? name,
  required Object mid,
}) {
  final Set<int> reason = {};
  int? reasonV2;

  return showDialog(
    context: context,
    builder: (context) {
      final theme = Theme.of(context);
      final reasonLabels = [
        context.l10n.memberReportAvatar,
        context.l10n.memberReportNickname,
        context.l10n.memberReportBio,
      ];
      final detailReasonLabels = [
        context.l10n.reportPornographicOrVulgar,
        context.l10n.reportMisinformation,
        context.l10n.reportIllegalOrHarmful,
        context.l10n.reportPersonalAttack,
        context.l10n.reportGamblingOrScam,
        context.l10n.reportIllegalExternalLink,
      ];
      return AlertDialog(
        clipBehavior: Clip.hardEdge,
        contentPadding: const EdgeInsets.symmetric(vertical: 16),
        titleTextStyle: theme.textTheme.bodyMedium,
        title: Column(
          spacing: 4,
          crossAxisAlignment: .start,
          children: [
            Text(
              context.l10n.memberReportTitle(name ?? ''),
              style: const TextStyle(fontSize: 18),
            ),
            Text('uid: $mid'),
          ],
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: .min,
            crossAxisAlignment: .start,
            children: [
              Padding(
                padding: const .only(left: 18),
                child: Text(context.l10n.memberReportContentRequired),
              ),
              ...List.generate(
                3,
                (index) => Builder(
                  builder: (context) {
                    final checked = reason.contains(index + 1);
                    return ListTile(
                      dense: true,
                      minTileHeight: 40,
                      onTap: () {
                        if (!checked) {
                          reason.add(index + 1);
                        } else {
                          reason.remove(index + 1);
                        }
                        (context as Element).markNeedsBuild();
                      },
                      title: Row(
                        spacing: 8,
                        children: [
                          checked
                              ? Icon(
                                  size: 22,
                                  Icons.check_box,
                                  color: theme.colorScheme.primary,
                                )
                              : Icon(
                                  size: 22,
                                  Icons.check_box_outline_blank,
                                  color: theme.colorScheme.onSurfaceVariant,
                                ),
                          Expanded(
                            child: Text(
                              reasonLabels[index],
                              style: const TextStyle(fontSize: 14),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const .only(left: 18),
                child: Text(context.l10n.memberReportReasonOptional),
              ),
              Builder(
                builder: (context) => Column(
                  crossAxisAlignment: .start,
                  children: List.generate(
                    detailReasonLabels.length,
                    (index) {
                      final checked = index == reasonV2;
                      return ListTile(
                        dense: true,
                        minTileHeight: 40,
                        onTap: () {
                          if (checked) {
                            reasonV2 = null;
                          } else {
                            reasonV2 = index;
                          }
                          (context as Element).markNeedsBuild();
                        },
                        title: Row(
                          spacing: 8,
                          children: [
                            checked
                                ? Icon(
                                    size: 22,
                                    Icons.radio_button_checked,
                                    color: theme.colorScheme.primary,
                                  )
                                : Icon(
                                    size: 22,
                                    Icons.radio_button_off,
                                    color: theme.colorScheme.onSurfaceVariant,
                                  ),
                            Expanded(
                              child: Text(
                                detailReasonLabels[index],
                                style: const TextStyle(fontSize: 14),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: Get.back,
            child: Text(
              context.l10n.commonCancel,
              style: TextStyle(color: theme.colorScheme.outline),
            ),
          ),
          TextButton(
            onPressed: () {
              if (reason.isEmpty) {
                SmartDialog.showToast(
                  context.l10n.memberReportChooseContent,
                );
              } else {
                Get.back();
                MemberHttp.reportMember(
                  mid,
                  reason: reason.join(','),
                  reasonV2: reasonV2 != null ? reasonV2! + 1 : null,
                );
              }
            },
            child: Text(context.l10n.commonConfirm),
          ),
        ],
      );
    },
  );
}
