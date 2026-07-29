import 'package:ex_piliplus/http/loading_state.dart';
import 'package:ex_piliplus/http/user.dart';
import 'package:ex_piliplus/models_new/history/data.dart';
import 'package:ex_piliplus/models_new/history/list.dart';
import 'package:ex_piliplus/pages/history_stats/statistics.dart';
import 'package:ex_piliplus/utils/accounts.dart';
import 'package:get/get.dart';

class HistoryStatisticsController extends GetxController {
  static const _maxPages = 150;

  final range = HistoryStatisticsRange.thirtyDays.obs;
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

  Future<void> selectRange(HistoryStatisticsRange value) async {
    if (range.value == value && loadingState.value.isSuccess) return;
    range.value = value;
    await load();
  }

  Future<void> load() async {
    final requestSerial = ++_requestSerial;
    final selectedRange = range.value;
    final now = DateTime.now();
    final cutoff =
        selectedRange.startOfPeriod(now).millisecondsSinceEpoch ~/ 1000;
    final collected = <HistoryItemModel>[];

    loadedContentCount.value = 0;
    loadingState.value = LoadingState.loading();

    int? max;
    int? viewAt;
    var isPartial = false;

    for (var page = 0; page < _maxPages; page++) {
      final result = await UserHttp.historyList(
        type: 'all',
        max: max,
        viewAt: viewAt,
        account: Accounts.history,
      );
      if (requestSerial != _requestSerial) return;

      if (result case Success<HistoryData>(:final response)) {
        final pageItems = response.list;
        if (pageItems == null || pageItems.isEmpty) break;

        collected.addAll(
          pageItems.where((item) => (item.viewAt ?? 0) >= cutoff),
        );
        loadedContentCount.value = collected.length;

        final lastItem = pageItems.last;
        final nextMax = lastItem.history.oid;
        final nextViewAt = lastItem.viewAt;
        final reachedCutoff = pageItems.any(
          (item) => (item.viewAt ?? 0) < cutoff,
        );
        final repeatedCursor = nextMax == max && nextViewAt == viewAt;

        if (reachedCutoff || repeatedCursor) break;
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
    loadingState.value = Success(
      HistoryStatisticsCalculator.calculate(
        source: collected,
        range: selectedRange,
        now: now,
        isPartial: isPartial,
      ),
    );
  }

  @override
  void onClose() {
    _requestSerial++;
    super.onClose();
  }
}
