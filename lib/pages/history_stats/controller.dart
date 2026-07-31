import 'dart:async';

import 'package:ex_piliplus/http/loading_state.dart';
import 'package:ex_piliplus/http/member.dart';
import 'package:ex_piliplus/http/user.dart';
import 'package:ex_piliplus/models_new/history/data.dart';
import 'package:ex_piliplus/models_new/history/list.dart';
import 'package:ex_piliplus/pages/history_stats/statistics.dart';
import 'package:ex_piliplus/utils/accounts.dart';
import 'package:get/get.dart';

typedef HistoryStatisticsPageLoader =
    Future<LoadingState<HistoryData>> Function({int? max, int? viewAt});
typedef HistoryStatisticsAvatarLoader = Future<String?> Function(int mid);

class HistoryStatisticsController extends GetxController {
  static const _maxPages = 150;

  HistoryStatisticsController({
    HistoryStatisticsPageLoader? pageLoader,
    HistoryStatisticsAvatarLoader? avatarLoader,
  }) : _pageLoader = pageLoader ?? _defaultPageLoader,
       _avatarLoader = avatarLoader ?? _defaultAvatarLoader;

  final HistoryStatisticsPageLoader _pageLoader;
  final HistoryStatisticsAvatarLoader _avatarLoader;

  final loadingState = Rx<LoadingState<HistoryStatistics>>(
    LoadingState.loading(),
  );
  final loadedContentCount = 0.obs;

  var _requestSerial = 0;

  @override
  void onInit() {
    super.onInit();
    load();
  }

  Future<void> load() async {
    final requestSerial = ++_requestSerial;
    final now = DateTime.now();
    final collected = <HistoryItemModel>[];

    loadedContentCount.value = 0;
    loadingState.value = LoadingState.loading();

    int? max;
    int? viewAt;
    var isPartial = false;
    var reachedRecordLimit = false;

    for (var page = 0; page < _maxPages; page++) {
      final result = await _pageLoader(max: max, viewAt: viewAt);
      if (requestSerial != _requestSerial) return;

      if (result case Success<HistoryData>(:final response)) {
        final pageItems = response.list;
        if (pageItems == null || pageItems.isEmpty) break;

        final remaining = HistoryStatistics.recordLimit - collected.length;
        collected.addAll(pageItems.take(remaining));
        loadedContentCount.value = collected.length;

        if (collected.length >= HistoryStatistics.recordLimit) {
          reachedRecordLimit = true;
          break;
        }

        final lastItem = pageItems.last;
        final nextMax = lastItem.history.oid;
        final nextViewAt = lastItem.viewAt;
        final repeatedCursor = nextMax == max && nextViewAt == viewAt;
        if (repeatedCursor) break;

        max = nextMax;
        viewAt = nextViewAt;

        if (page == _maxPages - 1) isPartial = true;
      } else if (result case Error(:final errMsg)) {
        if (collected.isEmpty) {
          loadingState.value = Error(errMsg);
          return;
        }
        isPartial = true;
        break;
      }
    }

    if (requestSerial != _requestSerial) return;
    final statistics = HistoryStatisticsCalculator.calculate(
      source: collected,
      sourceRecordCount: collected.length,
      reachedRecordLimit: reachedRecordLimit,
      now: now,
      isPartial: isPartial,
    );
    loadingState.value = Success(statistics);
    unawaited(_loadUploaderAvatars(requestSerial, statistics));
  }

  Future<void> _loadUploaderAvatars(
    int requestSerial,
    HistoryStatistics statistics,
  ) async {
    final uploaders = statistics.topUploaders
        .where((uploader) => uploader.mid != null)
        .take(5)
        .toList(growable: false);
    if (uploaders.isEmpty) return;

    final entries = await Future.wait(
      uploaders.map((uploader) async {
        final mid = uploader.mid!;
        try {
          return MapEntry(mid, await _avatarLoader(mid));
        } catch (_) {
          return MapEntry<int, String?>(mid, null);
        }
      }),
    );
    if (requestSerial != _requestSerial) return;

    final avatars = <int, String>{
      for (final entry in entries)
        if (entry.value?.isNotEmpty == true) entry.key: entry.value!,
    };
    if (avatars.isEmpty) return;

    final state = loadingState.value;
    if (state case Success<HistoryStatistics>(:final response)) {
      loadingState.value = Success(response.withUploaderAvatars(avatars));
    }
  }

  static Future<LoadingState<HistoryData>> _defaultPageLoader({
    int? max,
    int? viewAt,
  }) {
    return UserHttp.historyList(
      type: 'all',
      max: max,
      viewAt: viewAt,
      account: Accounts.history,
    );
  }

  static Future<String?> _defaultAvatarLoader(int mid) async {
    final result = await MemberHttp.memberCardInfo(mid: mid);
    return result.dataOrNull?.card?.face;
  }

  @override
  void onClose() {
    _requestSerial++;
    super.onClose();
  }
}
