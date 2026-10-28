import 'package:ex_piliplus/grpc/bilibili/main/community/reply/v1.pb.dart'
    show ReplyInfo;
import 'package:ex_piliplus/http/loading_state.dart';
import 'package:ex_piliplus/models/common/comment_plus_one_request.dart';
import 'package:ex_piliplus/pages/common/reply_controller.dart';
import 'package:ex_piliplus/services/comment_plus_one_service.dart';
import 'package:ex_piliplus/utils/accounts.dart';
import 'package:ex_piliplus/utils/extension/l10n_ext.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';

mixin CommentPlusOneReplyMixin<R> on ReplyController<R> {
  Future<void> onCommentPlusOne(ReplyInfo replyItem) async {
    final (inputDisabled, _) = replyHint;
    if (inputDisabled) return;

    final context = Get.context;
    if (context == null) return;
    final l10n = context.l10n;
    if (!Accounts.main.isLogin) {
      SmartDialog.showToast(l10n.accountPleaseSignIn);
      return;
    }

    final request = CommentPlusOneRequest.fromReply(replyItem);
    if (request == null) {
      SmartDialog.showToast(l10n.commentPlusOneUnsupported);
      return;
    }

    LoadingState<ReplyInfo?>? result;
    try {
      result = await CommentPlusOneService.instance.send(request);
    } catch (_) {
      // The request may have reached the server even if the response was lost.
      // Never retry automatically; the user should check the thread first.
      SmartDialog.showToast(l10n.commentPlusOneUnconfirmed);
      return;
    }

    if (result == null) return;
    if (result is Success) {
      SmartDialog.showToast(l10n.commentPlusOneSent);
      try {
        await onReload();
      } catch (_) {
        // Sending succeeded; a failed list refresh must not imply otherwise.
      }
    } else {
      await result.toast();
    }
  }
}
