import 'package:ex_piliplus/common/widgets/radio_widget.dart';
import 'package:ex_piliplus/http/loading_state.dart';
import 'package:ex_piliplus/l10n/generated/app_localizations.dart';
import 'package:ex_piliplus/utils/extension/l10n_ext.dart';
import 'package:ex_piliplus/utils/extension/string_ext.dart';
import 'package:ex_piliplus/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';

Future<void> autoWrapReportDialog(
  BuildContext context,
  Map<String, Map<int, String>> options,
  Future<LoadingState> Function(int reasonType, String? reasonDesc, bool banUid)
  onSuccess, {
  bool ban = true,
}) {
  int? reasonType;
  String? reasonDesc;
  bool banUid = false;
  late final key = GlobalKey<FormFieldState<String>>();
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(context.l10n.commonReport),
      titlePadding: const .only(left: 22, top: 16, right: 22),
      contentPadding: const .symmetric(vertical: 5),
      actionsPadding: const .only(left: 16, right: 16, bottom: 10),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            child: SingleChildScrollView(
              child: AnimatedSize(
                duration: const Duration(milliseconds: 200),
                child: Builder(
                  builder: (context) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const .only(
                          left: 22,
                          right: 22,
                          bottom: 5,
                        ),
                        child: Text(context.l10n.reportChooseReason),
                      ),
                      RadioGroup(
                        onChanged: (value) {
                          reasonType = value;
                          (context as Element).markNeedsBuild();
                        },
                        groupValue: reasonType,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: options.entries.map((entry) {
                            return WrapRadioOptionsGroup<int>(
                              groupTitle: ReportOptions.localizedLabel(
                                context.l10n,
                                entry.key,
                              ),
                              options: {
                                for (final option in entry.value.entries)
                                  option.key: ReportOptions.localizedLabel(
                                    context.l10n,
                                    option.value,
                                  ),
                              },
                            );
                          }).toList(),
                        ),
                      ),
                      if (reasonType == 0)
                        Padding(
                          padding: const .only(left: 22, top: 5, right: 22),
                          child: TextFormField(
                            key: key,
                            autofocus: true,
                            minLines: 2,
                            maxLines: 4,
                            initialValue: reasonDesc,
                            decoration: InputDecoration(
                              labelText: context.l10n.reportDetailsHint,
                              border: const OutlineInputBorder(),
                              contentPadding: const .all(10),
                              labelStyle: const TextStyle(fontSize: 14),
                              floatingLabelStyle: const TextStyle(fontSize: 14),
                            ),
                            onChanged: (value) => reasonDesc = value,
                            validator: (value) => value.isNullOrEmpty
                                ? context.l10n.reportReasonRequired
                                : null,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          if (ban)
            Padding(
              padding: const EdgeInsets.only(left: 14, top: 6),
              child: CheckBoxText(
                text: context.l10n.reportBlockUser,
                onChanged: (value) => banUid = value,
              ),
            ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: Get.back,
          child: Text(
            context.l10n.commonCancel,
            style: TextStyle(color: ColorScheme.of(context).outline),
          ),
        ),
        TextButton(
          onPressed: () async {
            if (reasonType == null ||
                (reasonType == 0 && key.currentState?.validate() != true)) {
              return;
            }
            SmartDialog.showLoading();
            try {
              final res = await onSuccess(reasonType!, reasonDesc, banUid);
              SmartDialog.dismiss();
              if (res.isSuccess) {
                Get.back();
                SmartDialog.showToast(context.l10n.reportSucceeded);
              } else {
                res.toast();
              }
            } catch (e, s) {
              SmartDialog.dismiss();
              SmartDialog.showToast(
                context.l10n.commonSubmitFailed(e.toString()),
              );
              Utils.reportError(e, s);
            }
          },
          child: Text(context.l10n.commonConfirm),
        ),
      ],
    ),
  );
}

class CheckBoxText extends StatefulWidget {
  final String text;
  final ValueChanged<bool> onChanged;
  final bool selected;

  const CheckBoxText({
    super.key,
    required this.text,
    required this.onChanged,
    this.selected = false,
  });

  @override
  State<CheckBoxText> createState() => _CheckBoxTextState();
}

class _CheckBoxTextState extends State<CheckBoxText> {
  late bool _selected;

  @override
  void initState() {
    super.initState();
    _selected = widget.selected;
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.of(context);
    return InkWell(
      onTap: () {
        setState(() {
          _selected = !_selected;
          widget.onChanged(_selected);
        });
      },
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              size: 22,
              _selected
                  ? Icons.check_box_outlined
                  : Icons.check_box_outline_blank,
              color: _selected
                  ? colorScheme.primary
                  : colorScheme.onSurfaceVariant,
            ),
            Text(
              ' ${widget.text}',
              style: TextStyle(color: _selected ? colorScheme.primary : null),
            ),
          ],
        ),
      ),
    );
  }
}

abstract final class ReportOptions {
  static String localizedLabel(AppLocalizations l10n, String label) =>
      switch (label) {
        '' => '',
        '违反法律法规' => l10n.reportGroupIllegal,
        '谣言类不实信息' => l10n.reportGroupMisinformation,
        '侵犯个人权益' => l10n.reportGroupPersonalRights,
        '有害社区环境' => l10n.reportGroupCommunity,
        '违法违规' || '违法违禁' => l10n.reportIllegal,
        '色情' => l10n.reportPornography,
        '低俗' => l10n.reportVulgar,
        '赌博诈骗' => l10n.reportGamblingOrScam,
        '违法信息外链' => l10n.reportIllegalExternalLink,
        '涉政谣言' => l10n.reportPoliticalRumor,
        '虚假不实信息' => l10n.reportMisinformation,
        '涉社会事件谣言' => l10n.reportSocialEventRumor,
        '人身攻击' => l10n.reportPersonalAttack,
        '侵犯隐私' => l10n.reportPrivacyViolation,
        '垃圾广告' => l10n.reportSpam,
        '引战' => l10n.reportProvocation,
        '剧透' => l10n.reportSpoiler,
        '刷屏' || '恶意刷屏' => l10n.reportFlooding,
        '视频不相关' || '视频无关' => l10n.reportIrrelevant,
        '违规抽奖' => l10n.reportIllegalLottery,
        '青少年不良信息' => l10n.reportHarmfulToMinors,
        '其他' || '其它' || '其他问题' => l10n.commonOther,
        '违法信息' || '违法有害' => l10n.reportIllegalOrHarmful,
        '色情低俗' || '低俗色情' => l10n.reportPornographicOrVulgar,
        '辱骂引战' => l10n.reportAbuseOrProvocation,
        '政治敏感' => l10n.reportPoliticallySensitive,
        '广告骚扰' => l10n.reportAdHarassment,
        '诈骗' => l10n.reportScam,
        _ => label,
      };

  // from https://s1.hdslb.com/bfs/seed/jinkela/comment-h5/static/js/605.chunks.js
  static Map<String, Map<int, String>> get commentReport => const {
    '违反法律法规': {9: '违法违规', 2: '色情', 10: '低俗', 12: '赌博诈骗', 23: '违法信息外链'},
    '谣言类不实信息': {19: '涉政谣言', 22: '虚假不实信息', 20: '涉社会事件谣言'},
    '侵犯个人权益': {7: '人身攻击', 15: '侵犯隐私'},
    '有害社区环境': {
      1: '垃圾广告',
      4: '引战',
      5: '剧透',
      3: '刷屏',
      8: '视频不相关',
      18: '违规抽奖',
      17: '青少年不良信息',
    },
    '其他': {0: '其他'},
  };

  static Map<String, Map<int, String>> get dynamicReport => const {
    '': {
      4: '垃圾广告',
      8: '引战',
      1: '色情',
      5: '人身攻击',
      3: '违法信息',
      9: '涉政谣言',
      10: '涉社会事件谣言',
      12: '虚假不实信息',
      13: '违法信息外链',
      0: '其他',
    },
  };

  static Map<String, Map<int, String>> get danmakuReport => const {
    '': {
      1: '违法违禁',
      2: '色情低俗',
      3: '赌博诈骗',
      4: '人身攻击',
      5: '侵犯隐私',
      6: '垃圾广告',
      7: '引战',
      8: '剧透',
      9: '恶意刷屏',
      10: '视频无关',
      12: '青少年不良信息',
      13: '违法信息外链',
      0: '其它', // 11
    },
  };

  static Map<String, Map<int, String>> get liveDanmakuReport => const {
    '': {
      1: '违法违规',
      2: '低俗色情',
      3: '垃圾广告',
      4: '辱骂引战',
      5: '政治敏感',
      6: '青少年不良信息',
      7: '其他', // avoid show form
    },
  };

  static Map<String, Map<int, String>> get imMsgReport => const {
    '': {
      1: '色情低俗',
      2: '政治敏感',
      3: '违法有害',
      4: '广告骚扰',
      5: '人身攻击',
      6: '诈骗',
      0: '其他问题',
    },
  };
}
