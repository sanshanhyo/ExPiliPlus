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
import 'package:fl_chart/fl_chart.dart';
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
    required this.onRefresh,
  });

  final HistoryStatistics statistics;
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
              constraints: const BoxConstraints(maxWidth: 1180),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
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
                    _AnalyticsSection(statistics: statistics),
                    if (statistics.topUploaders.isNotEmpty) ...[
                      const SizedBox(height: 12),
                      _UploaderSection(statistics: statistics),
                    ],
                    if (statistics.continueWatchingItems.isNotEmpty) ...[
                      const SizedBox(height: 12),
                      _ContinueWatchingSection(statistics: statistics),
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
    final coverage = context.l10n.statisticsRecordCoverage(
      statistics.sourceRecordCount,
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
          crossAxisAlignment: CrossAxisAlignment.start,
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
                  const SizedBox(height: 12),
                  Text(
                    coverage,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: colors.onPrimaryContainer.withValues(alpha: 0.78),
                    ),
                  ),
                  if (statistics.reachedRecordLimit) ...[
                    const SizedBox(height: 10),
                    DecoratedBox(
                      decoration: BoxDecoration(
                        color: colors.onPrimaryContainer.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(99),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.storage_outlined,
                              size: 16,
                              color: colors.onPrimaryContainer,
                            ),
                            const SizedBox(width: 6),
                            Flexible(
                              child: Text(
                                context.l10n.statisticsRecordLimitReached,
                                style: theme.textTheme.labelMedium?.copyWith(
                                  color: colors.onPrimaryContainer,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(width: 12),
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
        icon: Icons.play_circle_outline,
        label: context.l10n.statisticsContinueWatchingMetric,
        value: statistics.continueWatchingCount,
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
        final crossAxisCount = constraints.maxWidth >= 900 ? 4 : 2;
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

class _AnalyticsSection extends StatelessWidget {
  const _AnalyticsSection({required this.statistics});

  final HistoryStatistics statistics;

  @override
  Widget build(BuildContext context) {
    final cards = <Widget>[
      _ActivitySection(statistics: statistics),
      _HourlyLineChartSection(statistics: statistics),
      _ContentTypePieSection(statistics: statistics),
    ];
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= 900) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (var index = 0; index < cards.length; index++) ...[
                if (index > 0) const SizedBox(width: 12),
                Expanded(
                  child: SizedBox(height: 390, child: cards[index]),
                ),
              ],
            ],
          );
        }
        return Column(
          children: [
            for (var index = 0; index < cards.length; index++) ...[
              if (index > 0) const SizedBox(height: 12),
              SizedBox(height: 370, child: cards[index]),
            ],
          ],
        );
      },
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
          Expanded(child: _ActivityHeatmap(statistics: statistics)),
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
        const gap = 4.0;
        final desiredCell =
            (constraints.maxWidth - gap * (weekCount - 1)) / weekCount;
        final cellSize = desiredCell.clamp(14.0, 28.0);
        final contentWidth = weekCount * cellSize + gap * (weekCount - 1);

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          reverse: true,
          child: SizedBox(
            width: math.max(contentWidth, constraints.maxWidth),
            child: Align(
              alignment: contentWidth < constraints.maxWidth
                  ? Alignment.center
                  : Alignment.centerLeft,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (var week = 0; week < weekCount; week++) ...[
                    if (week > 0) const SizedBox(width: gap),
                    Column(
                      children: [
                        for (var weekday = 0; weekday < 7; weekday++) ...[
                          if (weekday > 0) const SizedBox(height: gap),
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
            ),
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
    final label = context.l10n.statisticsActivityTooltip(
      dateFormat.format(date!),
      count,
    );
    return Tooltip(
      message: label,
      child: Semantics(
        label: label,
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(math.max(2, size * 0.22)),
          ),
        ),
      ),
    );
  }
}

class _HourlyLineChartSection extends StatelessWidget {
  const _HourlyLineChartSection({required this.statistics});

  final HistoryStatistics statistics;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final counts = statistics.hourlyCounts;
    final maxCount = math.max(1, counts.fold<int>(0, math.max));
    final maxY = maxCount * 1.12;
    return _SectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionTitle(
            icon: Icons.show_chart_outlined,
            title: context.l10n.statisticsRecordTime,
            subtitle: context.l10n.statisticsRecordTimeDescription,
          ),
          const SizedBox(height: 18),
          Expanded(
            child: Semantics(
              label: context.l10n.statisticsRecordTime,
              child: LineChart(
                LineChartData(
                  minX: 0,
                  maxX: 23,
                  minY: 0,
                  maxY: maxY,
                  clipData: const FlClipData.all(),
                  borderData: FlBorderData(show: false),
                  gridData: FlGridData(
                    drawVerticalLine: false,
                    horizontalInterval: maxY / 3,
                    getDrawingHorizontalLine: (_) => FlLine(
                      color: colors.outlineVariant.withValues(alpha: 0.35),
                      strokeWidth: 1,
                    ),
                  ),
                  titlesData: FlTitlesData(
                    topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    leftTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        interval: 1,
                        reservedSize: 28,
                        getTitlesWidget: (value, meta) {
                          final hour = value.toInt();
                          if (hour != 0 &&
                              hour != 6 &&
                              hour != 12 &&
                              hour != 18 &&
                              hour != 23) {
                            return const SizedBox.shrink();
                          }
                          return SideTitleWidget(
                            meta: meta,
                            child: Text(
                              hour.toString().padLeft(2, '0'),
                              style: theme.textTheme.labelSmall?.copyWith(
                                color: colors.onSurfaceVariant,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  lineTouchData: LineTouchData(
                    touchTooltipData: LineTouchTooltipData(
                      fitInsideHorizontally: true,
                      fitInsideVertically: true,
                      getTooltipColor: (_) => colors.inverseSurface,
                      getTooltipItems: (spots) => spots
                          .map(
                            (spot) => LineTooltipItem(
                              context.l10n.statisticsHourTooltip(
                                spot.x.round(),
                                spot.y.round(),
                              ),
                              theme.textTheme.labelMedium!.copyWith(
                                color: colors.onInverseSurface,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  lineBarsData: [
                    LineChartBarData(
                      spots: List.generate(
                        counts.length,
                        (index) => FlSpot(
                          index.toDouble(),
                          counts[index].toDouble(),
                        ),
                      ),
                      color: colors.secondary,
                      barWidth: 3,
                      isCurved: true,
                      curveSmoothness: 0.22,
                      preventCurveOverShooting: true,
                      dotData: const FlDotData(show: false),
                      belowBarData: BarAreaData(
                        show: true,
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            colors.secondary.withValues(alpha: 0.34),
                            colors.secondary.withValues(alpha: 0.02),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ContentTypePieSection extends StatelessWidget {
  const _ContentTypePieSection({required this.statistics});

  final HistoryStatistics statistics;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final entries =
        statistics.contentTypeCounts.entries
            .where((entry) => entry.value > 0)
            .toList()
          ..sort((a, b) => b.value.compareTo(a.value));
    final palette = [
      colors.primary,
      colors.tertiary,
      colors.secondary,
      colors.error,
      const Color(0xFFD69E2E),
      colors.outline,
    ];
    final total = entries.fold<int>(0, (sum, entry) => sum + entry.value);

    return _SectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionTitle(
            icon: Icons.donut_large_outlined,
            title: context.l10n.statisticsContentTypes,
            subtitle: context.l10n.statisticsContentTypesDescription,
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 165,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Semantics(
                  label: context.l10n.statisticsContentTypes,
                  child: PieChart(
                    PieChartData(
                      startDegreeOffset: -90,
                      sectionsSpace: 2,
                      centerSpaceRadius: 48,
                      centerSpaceColor: colors.surfaceContainerLow,
                      sections: [
                        for (var index = 0; index < entries.length; index++)
                          PieChartSectionData(
                            value: entries[index].value.toDouble(),
                            color: palette[index % palette.length],
                            radius: 27,
                            showTitle: false,
                            cornerRadius: 3,
                          ),
                      ],
                    ),
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '$total',
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      context.l10n.statisticsDistinctContent,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: colors.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final itemWidth = math.max(
                  100.0,
                  (constraints.maxWidth - 12) / 2,
                );
                return Align(
                  alignment: Alignment.topCenter,
                  child: Wrap(
                    spacing: 12,
                    runSpacing: 8,
                    children: [
                      for (var index = 0; index < entries.length; index++)
                        SizedBox(
                          width: itemWidth,
                          child: _PieLegendItem(
                            color: palette[index % palette.length],
                            label: entries[index].key.localizedLabel(
                              context.l10n,
                            ),
                            value: entries[index].value,
                            percentage: total == 0
                                ? 0
                                : entries[index].value / total * 100,
                          ),
                        ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _PieLegendItem extends StatelessWidget {
  const _PieLegendItem({
    required this.color,
    required this.label,
    required this.value,
    required this.percentage,
  });

  final Color color;
  final String label;
  final int value;
  final double percentage;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final percentageText = percentage >= 10
        ? percentage.toStringAsFixed(0)
        : percentage.toStringAsFixed(1);
    return Row(
      children: [
        Container(
          width: 9,
          height: 9,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 7),
        Expanded(
          child: Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.labelMedium,
          ),
        ),
        const SizedBox(width: 6),
        Text(
          '$value · $percentageText%',
          style: theme.textTheme.labelSmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
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
    final uploaders = statistics.topUploaders.take(5).toList(growable: false);
    final topThree = uploaders.take(3).toList(growable: false);
    final podiumOrder = topThree.length == 3
        ? const [1, 0, 2]
        : [
            for (var index = 0; index < topThree.length; index++) index,
          ];

    return _SectionCard(
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 18, 18, 4),
            child: _SectionTitle(
              icon: Icons.emoji_events_outlined,
              title: context.l10n.statisticsTopUploaders,
              subtitle: context.l10n.statisticsTopUploadersDescription,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 8, 12, 0),
            child: SizedBox(
              height: 250,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  for (final uploaderIndex in podiumOrder)
                    Expanded(
                      child: _PodiumPlace(
                        rank: uploaderIndex + 1,
                        uploader: topThree[uploaderIndex],
                      ),
                    ),
                ],
              ),
            ),
          ),
          if (uploaders.length > 3) ...[
            const Divider(height: 1),
            for (var index = 3; index < uploaders.length; index++) ...[
              if (index > 3)
                const Divider(height: 1, indent: 76, endIndent: 18),
              _UploaderListRow(rank: index + 1, uploader: uploaders[index]),
            ],
          ],
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

class _PodiumPlace extends StatelessWidget {
  const _PodiumPlace({required this.rank, required this.uploader});

  final int rank;
  final HistoryUploaderStatistics uploader;

  static const _medalColors = {
    1: Color(0xFFFFC857),
    2: Color(0xFFB9C2CC),
    3: Color(0xFFC98B5B),
  };

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final medalColor = _medalColors[rank]!;
    final avatarSize = rank == 1 ? 82.0 : 68.0;
    final topSpace = switch (rank) {
      1 => 0.0,
      2 => 26.0,
      _ => 38.0,
    };
    final pedestalHeight = switch (rank) {
      1 => 64.0,
      2 => 50.0,
      _ => 42.0,
    };

    return Semantics(
      button: uploader.mid != null,
      label:
          '${uploader.name}, ${context.l10n.statisticsUploaderSummary(uploader.contentCount, uploader.completedCount)}',
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: uploader.mid == null
            ? null
            : () => Get.toNamed('/member?mid=${uploader.mid}'),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Column(
            children: [
              SizedBox(height: topSpace),
              _RankedAvatar(
                uploader: uploader,
                rank: rank,
                size: avatarSize,
                medalColor: medalColor,
              ),
              const SizedBox(height: 8),
              Text(
                uploader.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: rank == 1 ? FontWeight.w700 : FontWeight.w600,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                context.l10n.statisticsUploaderSummary(
                  uploader.contentCount,
                  uploader.completedCount,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: theme.textTheme.labelSmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              const Spacer(),
              Container(
                height: pedestalHeight,
                width: double.infinity,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: medalColor.withValues(alpha: 0.18),
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(16),
                  ),
                  border: Border(
                    top: BorderSide(color: medalColor, width: 3),
                  ),
                ),
                child: Text(
                  '#$rank',
                  style: theme.textTheme.titleLarge?.copyWith(
                    color: medalColor,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RankedAvatar extends StatelessWidget {
  const _RankedAvatar({
    required this.uploader,
    required this.rank,
    required this.size,
    required this.medalColor,
  });

  final HistoryUploaderStatistics uploader;
  final int rank;
  final double size;
  final Color medalColor;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: size + 8,
          height: size + 8,
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: medalColor,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: medalColor.withValues(alpha: 0.32),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: _UploaderAvatar(uploader: uploader, size: size),
        ),
        Positioned(
          right: -2,
          bottom: 0,
          child: Container(
            width: 28,
            height: 28,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: medalColor,
              shape: BoxShape.circle,
              border: Border.all(
                color: Theme.of(context).colorScheme.surfaceContainerLow,
                width: 3,
              ),
            ),
            child: Text(
              '$rank',
              style: const TextStyle(
                color: Color(0xFF352611),
                fontSize: 12,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _UploaderListRow extends StatelessWidget {
  const _UploaderListRow({required this.rank, required this.uploader});

  final int rank;
  final HistoryUploaderStatistics uploader;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Semantics(
      button: uploader.mid != null,
      child: InkWell(
        onTap: uploader.mid == null
            ? null
            : () => Get.toNamed('/member?mid=${uploader.mid}'),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          child: Row(
            children: [
              _UploaderAvatar(uploader: uploader, size: 46),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      uploader.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 3),
                    Text(
                      context.l10n.statisticsUploaderSummary(
                        uploader.contentCount,
                        uploader.completedCount,
                      ),
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Text(
                '#$rank',
                style: theme.textTheme.titleMedium?.copyWith(
                  color: theme.colorScheme.outline,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _UploaderAvatar extends StatelessWidget {
  const _UploaderAvatar({required this.uploader, required this.size});

  final HistoryUploaderStatistics uploader;
  final double size;

  @override
  Widget build(BuildContext context) {
    final initial = uploader.name.trim().characters.firstOrNull ?? '?';
    return NetworkImgLayer(
      src: uploader.avatarUrl,
      width: size,
      height: size,
      type: .avatar,
      getPlaceHolder: () => Container(
        width: size,
        height: size,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondaryContainer,
          shape: BoxShape.circle,
        ),
        child: Text(
          initial,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: Theme.of(context).colorScheme.onSecondaryContainer,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

class _ContinueWatchingSection extends StatelessWidget {
  const _ContinueWatchingSection({required this.statistics});

  final HistoryStatistics statistics;

  @override
  Widget build(BuildContext context) {
    final items = statistics.continueWatchingItems.take(5).toList();
    final formattedRemaining = DurationUtils.formatTimeDuration(
      Duration(seconds: statistics.remainingSeconds),
      context.l10n,
    );
    final fallbackRemaining = DurationUtils.formatDuration(
      statistics.remainingSeconds,
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
                statistics.continueWatchingCount,
                formattedRemaining.isEmpty
                    ? fallbackRemaining
                    : formattedRemaining,
              ),
            ),
          ),
          for (var index = 0; index < items.length; index++) ...[
            if (index > 0) const Divider(height: 1, indent: 154, endIndent: 18),
            _ContinueWatchingItem(item: items[index]),
          ],
          const SizedBox(height: 6),
        ],
      ),
    );
  }
}

class _ContinueWatchingItem extends StatelessWidget {
  const _ContinueWatchingItem({required this.item});

  final HistoryItemModel item;

  @override
  Widget build(BuildContext context) {
    final progress = item.progress ?? 0;
    final duration = item.duration ?? 0;
    final remaining = math.max(0, duration - progress);
    final progressRatio = duration == 0 ? 0.0 : progress / duration;
    final label =
        '${item.title ?? ''}, ${context.l10n.statisticsRemaining(DurationUtils.formatDuration(remaining))}';

    return Semantics(
      button: true,
      label: label,
      child: InkWell(
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
