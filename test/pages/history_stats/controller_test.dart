import 'package:ex_piliplus/http/loading_state.dart';
import 'package:ex_piliplus/models_new/history/data.dart';
import 'package:ex_piliplus/models_new/history/history.dart';
import 'package:ex_piliplus/models_new/history/list.dart';
import 'package:ex_piliplus/pages/history_stats/controller.dart';
import 'package:ex_piliplus/pages/history_stats/statistics.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('controller stops at 1200 records and enriches five avatars', () async {
    var pageCalls = 0;
    final avatarMids = <int>{};
    final controller = HistoryStatisticsController(
      pageLoader: ({max, viewAt}) async {
        final page = pageCalls++;
        final start = page * 20;
        return Success(
          HistoryData(
            list: List.generate(20, (offset) {
              final index = start + offset;
              final author = index % 5;
              return HistoryItemModel(
                title: 'Item $index',
                history: History(
                  oid: index + 1,
                  bvid: 'BV$index',
                  business: 'archive',
                ),
                authorName: 'Uploader $author',
                authorMid: author + 1,
                viewAt: 2000000000 - index,
                progress: -1,
                duration: 600,
                kid: index + 1,
              );
            }),
          ),
        );
      },
      avatarLoader: (mid) async {
        avatarMids.add(mid);
        return 'https://example.com/$mid.jpg';
      },
    );
    addTearDown(controller.onClose);

    await controller.load();
    await Future<void>.delayed(Duration.zero);
    await Future<void>.delayed(Duration.zero);

    expect(pageCalls, 60);
    expect(controller.loadedContentCount.value, 1200);
    final state = controller.loadingState.value;
    expect(state, isA<Success<HistoryStatistics>>());
    final statistics = state.data;
    expect(statistics.sourceRecordCount, 1200);
    expect(statistics.reachedRecordLimit, isTrue);
    expect(statistics.totalContentCount, 1200);
    expect(avatarMids, {1, 2, 3, 4, 5});
    expect(
      statistics.topUploaders
          .take(5)
          .every(
            (uploader) => uploader.avatarUrl?.isNotEmpty == true,
          ),
      isTrue,
    );
  });
}
