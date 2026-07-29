import 'package:ex_piliplus/http/search.dart';
import 'package:ex_piliplus/models_new/history/list.dart';
import 'package:ex_piliplus/models_new/video/video_detail/dimension.dart';
import 'package:ex_piliplus/utils/extension/l10n_ext.dart';
import 'package:ex_piliplus/utils/id_utils.dart';
import 'package:ex_piliplus/utils/page_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

abstract final class HistoryItemNavigation {
  static Future<void> open(
    BuildContext context,
    HistoryItemModel item,
  ) async {
    final history = item.history;
    final business = history.business;
    final aid = history.oid!;
    final bvid = history.bvid ?? IdUtils.av2bv(aid);

    if (business?.contains('article') == true) {
      PageUtils.toDupNamed(
        '/articlePage',
        parameters: {
          'id': business == 'article-list'
              ? '${history.cid}'
              : '${history.oid}',
          'type': 'read',
        },
      );
      return;
    }
    if (business == 'live') {
      if (item.liveStatus == 1) {
        PageUtils.toLiveRoom(history.oid);
      } else {
        SmartDialog.showToast(context.l10n.liveNotStarted);
      }
      return;
    }
    if (business == 'pgc') {
      PageUtils.viewPgc(
        epId: history.epid,
        progress: item.playbackProgress,
      );
      return;
    }
    if (business == 'cheese') {
      if (item.uri?.isNotEmpty == true) {
        PageUtils.viewPgcFromUri(
          item.uri!,
          isPgc: false,
          aid: history.oid,
          progress: item.playbackProgress,
        );
      }
      return;
    }

    var cid = history.cid;
    Dimension? dimension;
    if (cid == null) {
      if (await SearchHttp.ab2cWithDimension(
            aid: aid,
            bvid: bvid,
            part: history.page,
          )
          case final result?) {
        cid = result.cid;
        dimension = result.dimension;
      }
    }
    if (cid != null) {
      PageUtils.toVideoPage(
        aid: aid,
        bvid: bvid,
        cid: cid,
        cover: item.cover,
        title: item.title,
        dimension: dimension,
        progress: item.playbackProgress,
      );
    }
  }
}
