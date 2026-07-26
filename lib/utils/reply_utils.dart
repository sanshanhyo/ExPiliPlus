import 'dart:io' show Platform;

import 'package:ex_piliplus/common/widgets/selection_text.dart';
import 'package:ex_piliplus/grpc/bilibili/main/community/reply/v1.pb.dart'
    show ReplyInfo;
import 'package:ex_piliplus/http/loading_state.dart';
import 'package:ex_piliplus/http/reply.dart';
import 'package:ex_piliplus/models/common/reply/reply_sort_type.dart';
import 'package:ex_piliplus/utils/accounts.dart';
import 'package:ex_piliplus/utils/accounts/account.dart';
import 'package:ex_piliplus/utils/android/android_helper.dart';
import 'package:ex_piliplus/utils/extension/iterable_ext.dart';
import 'package:ex_piliplus/utils/extension/l10n_ext.dart';
import 'package:ex_piliplus/utils/extension/theme_ext.dart';
import 'package:ex_piliplus/utils/id_utils.dart';
import 'package:ex_piliplus/utils/theme_utils.dart';
import 'package:ex_piliplus/utils/utils.dart';
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';

abstract final class ReplyUtils {
  static void onCheckReply({
    required ReplyInfo replyInfo,
    required bool biliSendCommAntifraud,
    required sourceId,
    required bool isManual,
  }) {
    try {
      _checkReply(
        oid: replyInfo.oid.toInt(),
        type: replyInfo.type.toInt(),
        id: replyInfo.id.toInt(),
        message: replyInfo.content.message,
        //
        root: replyInfo.root.toInt(),
        parent: replyInfo.parent.toInt(),
        ctime: replyInfo.ctime.toInt(),
        pictures: replyInfo.content.pictures
            .map((item) => item.toProto3Json())
            .toList(),
        mid: replyInfo.mid.toInt(),
        //
        isManual: isManual,
        biliSendCommAntifraud: biliSendCommAntifraud,
        sourceId: sourceId,
      );
    } catch (e) {
      SmartDialog.showToast(e.toString());
    }
  }

  // ref https://github.com/freedom-introvert/biliSendCommAntifraud
  static Future<void> _checkReply({
    required int oid,
    required int type,
    required int id,
    required String message,
    required int root,
    required int parent,
    required int ctime,
    required List pictures,
    required int mid,
    bool isManual = false,
    required bool biliSendCommAntifraud,
    required sourceId,
  }) async {
    final l10n = Get.context!.l10n;
    // biliSendCommAntifraud
    if (Platform.isAndroid && biliSendCommAntifraud) {
      try {
        final cookieString = Accounts.main.cookieJar
            .toJson()
            .entries
            .map((i) => '${i.key}=${i.value}')
            .join(';');
        PiliAndroidHelper.biliSendCommAntifraud(
          0,
          oid,
          type,
          id,
          root,
          parent,
          ctime,
          message,
          pictures,
          sourceId,
          mid,
          cookieString,
        );
      } catch (e) {
        if (kDebugMode) debugPrint('biliSendCommAntifraud: $e');
      }
      return;
    }

    // CommAntifraud
    if (!isManual) {
      await Future.delayed(const Duration(seconds: 8));
    }
    void showReplyCheckResult(String message, {bool isBan = false}) {
      final theme = ThemeUtils.theme;
      final actions = [
        if (isBan)
          TextButton(
            onPressed: () {
              Get.back();
              String? uri;
              switch (type) {
                case 1:
                  uri = IdUtils.av2bv(oid);
                case 17:
                  uri = 'https://www.bilibili.com/opus/$oid';
              }
              if (uri != null) {
                Utils.copyText(uri);
              }
              Get.toNamed(
                '/webview',
                parameters: {
                  'url':
                      'https://www.bilibili.com/h5/comment/appeal?${ThemeUtils.themeUrl(theme.isDark)}',
                },
              );
            },
            child: Text(l10n.replyAppeal),
          ),
        if (!isManual)
          TextButton(
            onPressed: Get.back,
            child: Text(
              l10n.commonClose,
              style: TextStyle(color: theme.colorScheme.outline),
            ),
          ),
      ];
      showDialog(
        context: Get.context!,
        barrierDismissible: isManual,
        builder: (context) => AlertDialog(
          title: Text(l10n.replyCheckResult),
          content: SelectionText(message),
          actions: actions.isEmpty ? null : actions,
        ),
      );
    }

    // root reply
    if (root == 0) {
      // no cookie check
      final res = await ReplyHttp.replyList(
        isLogin: false,
        oid: oid,
        nextOffset: '',
        type: type,
        sort: ReplySortType.time.index,
        page: 1,
      );

      if (res case Error(:final errMsg)) {
        SmartDialog.showToast(l10n.replyMainListError(errMsg ?? ''));
        return;
      } else if (res case Success(:final response)) {
        final index =
            response.replies?.indexWhere((item) => item.rpid == id) ?? -1;
        if (index != -1) {
          // found
          showReplyCheckResult(l10n.replyCheckNormal(message));
        } else {
          // not found

          // cookie check
          final res1 = await ReplyHttp.replyReplyList(
            isLogin: true,
            oid: oid,
            root: id,
            pageNum: 1,
            type: type,
          );

          if (res1 is Error) {
            // not found
            showReplyCheckResult(
              l10n.replyCheckNotFound(message),
              isBan: true,
            );
          } else {
            // found

            // no cookie check
            final res2 = await ReplyHttp.replyReplyList(
              isLogin: false,
              oid: oid,
              root: id,
              pageNum: 1,
              type: type,
              isCheck: true,
            );

            if (res2 is Error) {
              // not found
              showReplyCheckResult(
                res2.errMsg?.startsWith('12022') == true
                    ? l10n.replyCheckShadowBanned(message)
                    : l10n.replyCheckInvisible(res2.errMsg ?? '', message),
                isBan: true,
              );
            } else {
              // found
              showReplyCheckResult(
                isManual
                    ? l10n.replyCheckNormal(message)
                    : l10n.replyCheckSuspicious(
                        'https://api.bilibili.com/x/v2/reply/reply?oid=$oid&pn=1&ps=20&root=$id&type=$type',
                        message,
                      ),
              );
            }
          }
        }
      }
    } else {
      for (int i = 1; ; i++) {
        final res3 = await ReplyHttp.replyReplyList(
          isLogin: false,
          oid: oid,
          root: root,
          pageNum: i,
          type: type,
          isCheck: true,
        );
        if (res3 is Error) {
          break;
        } else {
          final data = res3.data;
          if (data.replies.isNullOrEmpty) {
            break;
          }
          int index = data.replies?.indexWhere((item) => item.rpid == id) ?? -1;
          if (index == -1) {
            // not found
          } else {
            // found
            showReplyCheckResult(l10n.replyCheckNormal(message));
            return;
          }
        }
      }

      for (int i = 1; ; i++) {
        final res4 = await ReplyHttp.replyReplyList(
          isLogin: true,
          oid: oid,
          root: root,
          pageNum: i,
          type: type,
          isCheck: true,
        );
        if (res4 is Error) {
          break;
        } else {
          final data = res4.data;
          if (data.replies.isNullOrEmpty) {
            break;
          }
          int index = data.replies?.indexWhere((item) => item.rpid == id) ?? -1;
          if (index == -1) {
            // not found
          } else {
            // found
            showReplyCheckResult(
              l10n.replyCheckShadowBanned(message),
              isBan: true,
            );
            return;
          }
        }
      }

      showReplyCheckResult(
        l10n.replyCheckInvisibleSimple(message),
        isBan: true,
      );
    }
  }
}
