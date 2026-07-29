import 'dart:math' as math;

import 'package:ex_piliplus/common/widgets/image/network_img_layer.dart';
import 'package:ex_piliplus/common/widgets/loading_widget/http_error.dart';
import 'package:ex_piliplus/http/loading_state.dart';
import 'package:ex_piliplus/l10n/generated/app_localizations.dart';
import 'package:ex_piliplus/models_new/history/list.dart';
import 'package:ex_piliplus/pages/history/open_item.dart';
import 'package:ex_piliplus/pages/history_stats/controller.dart';
import 'package:ex_piliplus/pages/history_stats/statistics.dart';
import 'package:ex_piliplus/utils/duration_utils.dart';
import 'package:ex_piliplus/utils/extension/l10n_ext.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HistoryStatisticsPage extends StatefulWidget {
  const HistoryStatisticsPage({super.key});

  @override
  State<HistoryStatisticsPage> createState() => _HistoryStatisticsPageState();
}

class _HistoryStatisticsPageState extends State<HistoryStatisticsPage> {
  static const _controllerTag = 'history-statistics';

  late final HistoryStatisticsController _controller;

  @override
  void initState() {
    super.initState();
    _controller = Get.put(
      HistoryStatisticsController(),
      tag: _controllerTag,
    );
  }

  @override
  void dispose() {
    Get.delete<HistoryStatisticsController>(tag: _controllerTag);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.statisticsTitle),
        actions: [
          IconButton(
            tooltip: context.l10n.commonRefresh,
            onPressed: _controller.load,
            icon: const Icon(Icons.refresh_outlined),
          ),
          const SizedBox(width: 6),
        ],
      ),
      body: Obx(() => _buildState(_controller.loadingState.value)),
    );
  }

  Widget _buildState(LoadingState<HistoryStatistics> state) {
    return switch (state) {
      Loading() => _LoadingStatistics(
        loadedCount: _controller.loadedContentCount.value,
      ),
      Error(:final errMsg) => HttpError(
        isSliver: false,
        errMsg: errMsg,
        onReload: _controller.load,
      ),
      Success(:final response) => HistoryStatisticsContent(
        statistics: response,
        selectedRange: _controller.range.value,
        onRangeSelected: _controller.selectRange,
        onRefresh: _controller.load,
      ),
    };
  }
}

class _LoadingStatistics extends StatelessWidget {
  const _LoadingStatistics({required this.loadedCount});

  final int loadedCount;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircularProgressIndicator(),
          const SizedBox(height: 18),
          Text(
            loadedCount == 0
                ? context.l10n.statisticsLoading
                : context.l10n.statisticsLoadingCount(loadedCount),
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}

class HistoryStatisticsContent extends StatelessWidget {
  const HistoryStatisticsContent({
    super.key,
    required this.statistics,
    required this.selectedRange,
    required this.onRangeSelected,
    required this.onRefresh,
  });

  final HistoryStatistics statistics;
  final HistoryStatisticsRange selectedRange;
  final ValueChanged<HistoryStatisticsRange> onRangeSelected;
  final RefreshCallback onRefresh;

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.viewPaddingOf(context).bottom;
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.fromLTRB(16, 12, 16, bottomPadding + 32),
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 920),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _RangeSelector(
                    value: selectedRange,
                    onSelected: onRangeSelected,
                  ),
                  const SizedBox(height: 16),
                  if (statistics.isPartial) ...[
                    _PartialDataBanner(),
                    const SizedBox(height: 12),
                  ],
                  if (statistics.totalContentCount == 0)
                    _EmptyStatistics()
                  else ...[
                    _OverviewHeader(statistics: statistics),
                    const SizedBox(height: 12),
                    _MetricGrid(statistics: statistics),
                    const SizedBox(height: 12),
                    _ActivitySection(statistics: statistics),
                    const SizedBox(height: 12),
                    _HourDistributionSection(statistics: statistics),
                    const SizedBox(height: 12),
                    _ContentTypeSection(statistics: statistics),
                    if (statistics.topUploaders.isNotEmpty) ...[
                      const SizedBox(height: 12),
                      _UploaderSection(statistics: statistics),
                    ],
                    if (statistics.unfinishedItems.isNotEmpty) ...[
                      const SizedBox(height: 12),
                      _UnfinishedSection(statistics: statistics),
                    ],
                  ],
                  const SizedBox(height: 12),
                  _DataSourceNotice(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RangeSelector extends StatelessWidget {
  const _RangeSelector({required this.value, required this.onSelected});

  final HistoryStatisticsRange value;
  final ValueChanged<HistoryStatisticsRange> onSelected;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return SegmentedButton<HistoryStatisticsRange>(
      segments: [
        ButtonSegment(
          value: HistoryStatisticsRange.sevenDays,
          label: Text(l10n.statisticsRange7Days),
        ),
        ButtonSegment(
          value: HistoryStatisticsRange.thirtyDays,
          label: Text(l10n.statisticsRange30Days),
        ),
        ButtonSegment(
          value: HistoryStatisticsRange.ninetyDays,
          label: Text(l10n.statisticsRange90Days),
        ),
      ],
      selected: {value},
      showSelectedIcon: false,
      onSelectionChanged: (selection) => onSelected(selection.first),
    );
  }
}

class _PartialDataBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Material(
      color: colors.tertiaryContainer,
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            Icon(Icons.info_outline, color: colors.onTertiaryContainer),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                context.l10n.statisticsPartialData,
                style: TextStyle(color: colors.onTertiaryContainer),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyStatistics extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return _SectionCard(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 36),
        child: Column(
          children: [
            Icon(
              Icons.query_stats_outlined,
              size: 48,
              color: theme.colorScheme.outline,
            ),
            const SizedBox(height: 14),
            Text(
              context.l10n.statisticsEmpty,
              style: theme.textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _OverviewHeader extends StatelessWidget {
  const _OverviewHeader({required this.statistics});

  final HistoryStatistics statistics;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final locale = Localizations.localeOf(context).toLanguageTag();
    final dateFormat = DateFormat.yMMMd(locale);
    final dateRange = context.l10n.statisticsDateRange(
      dateFormat.format(statistics.periodStart),
      dateFormat.format(statistics.periodEnd),
    );

    return Material(
      color: colors.primaryContainer,
      borderRadius: BorderRadius.circular(24),
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.all(22),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    context.l10n.statisticsOverview,
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: colors.onPrimaryContainer,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    '${statistics.totalContentCount}',
                    style: theme.textTheme.displaySmall?.copyWith(
                      color: colors.onPrimaryContainer,
                      fontWeight: FontWeight.w700,
                      height: 1,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    context.l10n.statisticsDistinctContent,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: colors.onPrimaryContainer,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    dateRange,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: colors.onPrimaryContainer.withValues(alpha: 0.75),
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.insights_outlined,
              size: 64,
              color: colors.onPrimaryContainer.withValues(alpha: 0.2),
            ),
          ],
        ),
      ),
    );
  }
}

class _MetricGrid extends StatelessWidget {
  const _MetricGrid({required this.statistics});

  final HistoryStatistics statistics;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final metrics = [
      _MetricData(
        icon: Icons.task_alt_outlined,
        label: context.l10n.statisticsCompleted,
        value: statistics.completedCount,
        color: colors.primary,
      ),
      _MetricData(
        icon: Icons.timelapse_outlined,
        label: context.l10n.statisticsUnfinished,
        value: statistics.unfinishedCount,
        color: colors.tertiary,
      ),
      _MetricData(
        icon: Icons.calendar_today_outlined,
        label: context.l10n.statisticsActiveDays,
        value: statistics.activeDayCount,
        color: colors.secondary,
      ),
      _MetricData(
        icon: Icons.favorite_outline,
        label: context.l10n.statisticsFavorited,
        value: statistics.favoritedCount,
        color: colors.error,
      ),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final crossAxisCount = constraints.maxWidth >= 700 ? 4 : 2;
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: metrics.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            mainAxisExtent: 106,
          ),
          itemBuilder: (_, index) => _MetricCard(data: metrics[index]),
        );
      },
    );
  }
}

class _MetricData {
  const _MetricData({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  final IconData icon;
  final String label;
  final int value;
  final Color color;
}

class _MetricCard extends StatelessWidget {
  const _MetricCard({required this.data});

  final _MetricData data;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return _SectionCard(
      padding: const EdgeInsets.all(15),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: data.color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(data.icon, color: data.color, size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${data.value}',
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                    height: 1,
                  ),
                ),
                const SizedBox(height: 7),
                Text(
                  data.label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ActivitySection extends StatelessWidget {
  const _ActivitySection({required this.statistics});

  final HistoryStatistics statistics;

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionTitle(
            icon: Icons.calendar_month_outlined,
            title: context.l10n.statisticsActivity,
            subtitle: context.l10n.statisticsActivityDescription,
          ),
          const SizedBox(height: 18),
          _ActivityHeatmap(statistics: statistics),
        ],
      ),
    );
  }
}

class _ActivityHeatmap extends StatelessWidget {
  const _ActivityHeatmap({required this.statistics});

  final HistoryStatistics statistics;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final start = statistics.periodStart;
    final end = DateTime(
      statistics.periodEnd.year,
      statistics.periodEnd.month,
      statistics.periodEnd.day,
    );
    final dates = <DateTime?>[
      ...List<DateTime?>.filled(start.weekday - 1, null),
      for (
        var day = start;
        !day.isAfter(end);
        day = day.add(const Duration(days: 1))
      )
        day,
    ];
    while (dates.length % 7 != 0) {
      dates.add(null);
    }

    final maxCount = math.max(
      1,
      statistics.activityByDay.values.fold<int>(0, math.max),
    );
    final locale = Localizations.localeOf(context).toLanguageTag();
    final dateFormat = DateFormat.MMMd(locale);

    return LayoutBuilder(
      builder: (context, constraints) {
        final weekCount = dates.length ~/ 7;
        final gap = weekCount > 1 ? 4.0 : 0.0;
        final desiredCell = math.min(
          18.0,
          (constraints.maxWidth - gap * (weekCount - 1)) / weekCount,
        );
        final cellSize = math.max(9.0, desiredCell);

        return Align(
          alignment: Alignment.centerLeft,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (var week = 0; week < weekCount; week++) ...[
                if (week > 0) SizedBox(width: gap),
                Column(
                  children: [
                    for (var weekday = 0; weekday < 7; weekday++) ...[
                      if (weekday > 0) const SizedBox(height: 4),
                      _ActivityCell(
                        date: dates[week * 7 + weekday],
                        count: dates[week * 7 + weekday] == null
                            ? 0
                            : statistics.activityByDay[dates[week * 7 +
                                      weekday]] ??
                                  0,
                        maxCount: maxCount,
                        size: cellSize,
                        dateFormat: dateFormat,
                        emptyColor: colors.surfaceContainerHighest,
                        activeColor: colors.primary,
                      ),
                    ],
                  ],
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}

class _ActivityCell extends StatelessWidget {
  const _ActivityCell({
    required this.date,
    required this.count,
    required this.maxCount,
    required this.size,
    required this.dateFormat,
    required this.emptyColor,
    required this.activeColor,
  });

  final DateTime? date;
  final int count;
  final int maxCount;
  final double size;
  final DateFormat dateFormat;
  final Color emptyColor;
  final Color activeColor;

  @override
  Widget build(BuildContext context) {
    if (date == null) return SizedBox.square(dimension: size);
    final ratio = count / maxCount;
    final color = count == 0
        ? emptyColor
        : activeColor.withValues(alpha: 0.22 + ratio * 0.78);
    return Tooltip(
      message: context.l10n.statisticsActivityTooltip(
        dateFormat.format(date!),
        count,
      ),
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(math.max(2, size * 0.22)),
        ),
      ),
    );
  }
}

class _HourDistributionSection extends StatelessWidget {
  const _HourDistributionSection({required this.statistics});

  final HistoryStatistics statistics;

  @override
  Widget build(BuildContext context) {
    final counts = statistics.hourBucketCounts;
    final maxCount = math.max(1, counts.fold<int>(0, math.max));
    return _SectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionTitle(
            icon: Icons.schedule_outlined,
            title: context.l10n.statisticsRecordTime,
            subtitle: context.l10n.statisticsRecordTimeDescription,
          ),
          const SizedBox(height: 18),
          for (var index = 0; index < counts.length; index++) ...[
            if (index > 0) const SizedBox(height: 12),
            _DistributionRow(
              label:
                  '${(index * 4).toString().padLeft(2, '0')}:00–'
                  '${((index + 1) * 4).toString().padLeft(2, '0')}:00',
              value: counts[index],
              maxValue: maxCount,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ],
        ],
      ),
    );
  }
}

class _ContentTypeSection extends StatelessWidget {
  const _ContentTypeSection({required this.statistics});

  final HistoryStatistics statistics;

  @override
  Widget build(BuildContext context) {
    final entries =
        statistics.contentTypeCounts.entries
            .where((entry) => entry.value > 0)
            .toList()
          ..sort((a, b) => b.value.compareTo(a.value));
    final maxCount = entries.fold<int>(
      1,
      (current, entry) => math.max(current, entry.value),
    );
    return _SectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionTitle(
            icon: Icons.category_outlined,
            title: context.l10n.statisticsContentTypes,
            subtitle: context.l10n.statisticsContentTypesDescription,
          ),
          const SizedBox(height: 18),
          for (var index = 0; index < entries.length; index++) ...[
            if (index > 0) const SizedBox(height: 12),
            _DistributionRow(
              label: entries[index].key.localizedLabel(context.l10n),
              value: entries[index].value,
              maxValue: maxCount,
              color: Theme.of(context).colorScheme.primary,
            ),
          ],
        ],
      ),
    );
  }
}

class _DistributionRow extends StatelessWidget {
  const _DistributionRow({
    required this.label,
    required this.value,
    required this.maxValue,
    required this.color,
  });

  final String label;
  final int value;
  final int maxValue;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        SizedBox(
          width: 82,
          child: Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.bodySmall,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(99),
            child: LinearProgressIndicator(
              value: value / maxValue,
              minHeight: 9,
              color: color,
              backgroundColor: color.withValues(alpha: 0.12),
            ),
          ),
        ),
        const SizedBox(width: 10),
        SizedBox(
          width: 34,
          child: Text(
            '$value',
            textAlign: TextAlign.end,
            style: theme.textTheme.labelMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
              fontFeatures: const [FontFeature.tabularFigures()],
            ),
          ),
        ),
      ],
    );
  }
}

class _UploaderSection extends StatelessWidget {
  const _UploaderSection({required this.statistics});

  final HistoryStatistics statistics;

  @override
  Widget build(BuildContext context) {
    final uploaders = statistics.topUploaders.take(5).toList();
    return _SectionCard(
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 18, 18, 8),
            child: _SectionTitle(
              icon: Icons.people_outline,
              title: context.l10n.statisticsTopUploaders,
              subtitle: context.l10n.statisticsTopUploadersDescription,
            ),
          ),
          for (var index = 0; index < uploaders.length; index++) ...[
            if (index > 0) const Divider(height: 1, indent: 72, endIndent: 18),
            _UploaderRow(rank: index + 1, uploader: uploaders[index]),
          ],
          const SizedBox(height: 6),
        ],
      ),
    );
  }
}

class _UploaderRow extends StatelessWidget {
  const _UploaderRow({required this.rank, required this.uploader});

  final int rank;
  final HistoryUploaderStatistics uploader;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return ListTile(
      onTap: uploader.mid == null
          ? null
          : () => Get.toNamed('/member?mid=${uploader.mid}'),
      contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 3),
      leading: CircleAvatar(
        backgroundColor: colors.secondaryContainer,
        foregroundColor: colors.onSecondaryContainer,
        child: Text(uploader.name.characters.first.toUpperCase()),
      ),
      title: Text(
        uploader.name,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        context.l10n.statisticsUploaderSummary(
          uploader.contentCount,
          uploader.completedCount,
        ),
      ),
      trailing: Text(
        '#$rank',
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
          color: colors.outline,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _UnfinishedSection extends StatelessWidget {
  const _UnfinishedSection({required this.statistics});

  final HistoryStatistics statistics;

  @override
  Widget build(BuildContext context) {
    final items = statistics.unfinishedItems.take(5).toList();
    final formattedRemaining = DurationUtils.formatTimeDuration(
      Duration(seconds: statistics.remainingSeconds),
      context.l10n,
    );
    return _SectionCard(
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 18, 18, 8),
            child: _SectionTitle(
              icon: Icons.playlist_play_outlined,
              title: context.l10n.statisticsContinueWatching,
              subtitle: context.l10n.statisticsRemainingTotal(
                formattedRemaining.isEmpty
                    ? DurationUtils.formatDuration(statistics.remainingSeconds)
                    : formattedRemaining,
              ),
            ),
          ),
          for (var index = 0; index < items.length; index++) ...[
            if (index > 0) const Divider(height: 1, indent: 154, endIndent: 18),
            _UnfinishedItem(item: items[index]),
          ],
          const SizedBox(height: 6),
        ],
      ),
    );
  }
}

class _UnfinishedItem extends StatelessWidget {
  const _UnfinishedItem({required this.item});

  final HistoryItemModel item;

  @override
  Widget build(BuildContext context) {
    final progress = item.progress ?? 0;
    final duration = item.duration ?? 0;
    final remaining = math.max(0, duration - progress);
    final progressRatio = duration == 0 ? 0.0 : progress / duration;

    return InkWell(
      onTap: () => HistoryItemNavigation.open(context, item),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: NetworkImgLayer(
                src: item.cover?.isNotEmpty == true
                    ? item.cover
                    : item.covers?.firstOrNull ?? '',
                width: 124,
                height: 70,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title ?? '',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 7),
                  LinearProgressIndicator(
                    value: progressRatio.clamp(0, 1),
                    minHeight: 4,
                    borderRadius: BorderRadius.circular(99),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    context.l10n.statisticsRemaining(
                      DurationUtils.formatDuration(remaining),
                    ),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 4),
            const Icon(Icons.chevron_right),
          ],
        ),
      ),
    );
  }
}

class _DataSourceNotice extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.shield_outlined,
            size: 18,
            color: theme.colorScheme.outline,
          ),
          const SizedBox(width: 9),
          Expanded(
            child: Text(
              context.l10n.statisticsDataSourceNotice,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.outline,
                height: 1.45,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 22, color: theme.colorScheme.primary),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: theme.textTheme.titleMedium),
              const SizedBox(height: 3),
              Text(
                subtitle,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SectionCard extends StatelessWidget {
  const _SectionCard({
    required this.child,
    this.padding = const EdgeInsets.all(18),
  });

  final Widget child;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).colorScheme.surfaceContainerLow,
      borderRadius: BorderRadius.circular(20),
      clipBehavior: Clip.antiAlias,
      child: Padding(padding: padding, child: child),
    );
  }
}

extension on HistoryStatisticsContentType {
  String localizedLabel(AppLocalizations l10n) {
    return switch (this) {
      HistoryStatisticsContentType.video => l10n.statisticsTypeVideo,
      HistoryStatisticsContentType.pgc => l10n.statisticsTypePgc,
      HistoryStatisticsContentType.live => l10n.statisticsTypeLive,
      HistoryStatisticsContentType.article => l10n.statisticsTypeArticle,
      HistoryStatisticsContentType.course => l10n.statisticsTypeCourse,
      HistoryStatisticsContentType.other => l10n.statisticsTypeOther,
    };
  }
}
