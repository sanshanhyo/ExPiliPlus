import 'dart:math' as math;

import 'package:ex_piliplus/l10n/generated/app_localizations.dart';
import 'package:ex_piliplus/utils/duration_utils.dart';
import 'package:ex_piliplus/utils/extension/l10n_ext.dart';
import 'package:flutter/material.dart';
import 'package:media_kit_video/media_kit_video.dart';

class GifRecordOptions {
  const GifRecordOptions({
    required this.start,
    required this.end,
    required this.resolution,
    required this.fps,
    required this.url,
  });

  final double start;
  final double end;
  final GifResolution resolution;
  final int fps;
  final String url;
}

enum GifResolution {
  p480(480),
  p720(720);

  const GifResolution(this.width);

  final int width;
}

class GifRecordDialog extends StatefulWidget {
  const GifRecordDialog({
    required this.videoController,
    required this.duration,
    required this.initialPosition,
    required this.sourceUrls,
    this.videoAspectRatio = 16 / 9,
    this.videoPreview,
    super.key,
  });

  final VideoController videoController;
  final double duration;
  final double initialPosition;
  final Map<GifResolution, String> sourceUrls;
  final double videoAspectRatio;
  final Widget? videoPreview;

  @override
  State<GifRecordDialog> createState() => _GifRecordDialogState();
}

class _GifRecordDialogState extends State<GifRecordDialog> {
  static const _maxLength = 10.0;
  static const _defaultLength = 5.0;
  static const _wideLayoutMinWidth = 680.0;

  late RangeValues _range;
  GifResolution _resolution = GifResolution.p720;
  int _fps = 12;

  double get _max => math.max(widget.duration, 0.001);
  double get _maxGifLength => math.min(_maxLength, _max);

  @override
  void initState() {
    super.initState();
    final length = math.min(_defaultLength, _maxGifLength);
    final start = widget.initialPosition.clamp(0, math.max(0, _max - length));
    _range = RangeValues(start.toDouble(), start.toDouble() + length);
    if (!widget.sourceUrls.containsKey(_resolution)) {
      _resolution = widget.sourceUrls.keys.first;
    }
  }

  void _updateRange(RangeValues value) {
    var start = value.start;
    var end = value.end;
    if (end - start > _maxGifLength) {
      if (value.start != _range.start) {
        end = start + _maxGifLength;
      } else {
        start = end - _maxGifLength;
      }
    }
    if (end > _max) {
      end = _max;
      start = math.max(0, end - _maxGifLength);
    }
    if (start < 0) {
      start = 0;
      end = math.min(_max, start + _maxGifLength);
    }
    final shouldSeek = (value.start - _range.start).abs() > 0.01;
    setState(() => _range = RangeValues(start, end));
    if (shouldSeek) {
      widget.videoController.player.seek(
        Duration(milliseconds: (start * 1000).round()),
      );
    }
  }

  String _format(double seconds) => DurationUtils.formatDuration(seconds);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = context.l10n;
    final maxWidth = math.min(MediaQuery.sizeOf(context).width - 32, 1040.0);
    return Dialog(
      insetPadding: const EdgeInsets.all(16),
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth, maxHeight: 680),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 28, 20, 16),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final useWideLayout =
                  widget.videoAspectRatio > 1 &&
                  constraints.maxWidth >= _wideLayoutMinWidth;
              if (!useWideLayout) {
                return SingleChildScrollView(
                  child: _buildNarrowLayout(theme, l10n),
                );
              }
              return _buildWideLayout(theme, l10n);
            },
          ),
        ),
      ),
    );
  }

  Widget _buildWideLayout(ThemeData theme, AppLocalizations l10n) {
    return Row(
      key: const ValueKey('gif-wide-layout'),
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          flex: 5,
          child: _buildPreview(theme),
        ),
        const SizedBox(width: 24),
        Expanded(
          flex: 3,
          child: _buildOptions(theme, l10n),
        ),
        const SizedBox(width: 16),
        SizedBox(
          width: 56,
          child: _buildActions(theme, l10n, emphasizeExport: true),
        ),
      ],
    );
  }

  Widget _buildNarrowLayout(ThemeData theme, AppLocalizations l10n) {
    return Column(
      key: const ValueKey('gif-narrow-layout'),
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildPreview(theme),
        const SizedBox(height: 20),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _buildOptions(theme, l10n)),
            const SizedBox(width: 12),
            SizedBox(
              width: 56,
              height: 280,
              child: _buildActions(theme, l10n, emphasizeExport: false),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPreview(ThemeData theme) {
    return Column(
      key: const ValueKey('gif-preview'),
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: ColoredBox(
            color: Colors.black,
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child:
                  widget.videoPreview ??
                  Video(
                    controller: widget.videoController,
                    controls: NoVideoControls,
                  ),
            ),
          ),
        ),
        const SizedBox(height: 14),
        Text(
          '${_format(_range.start)} - ${_format(_range.end)}  ·  ${(_range.end - _range.start).toStringAsFixed(1)}s',
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyMedium,
        ),
        RangeSlider(
          min: 0,
          max: _max,
          values: _range,
          labels: RangeLabels(
            _format(_range.start),
            _format(_range.end),
          ),
          onChanged: _max <= 0 ? null : _updateRange,
        ),
      ],
    );
  }

  Widget _buildOptions(ThemeData theme, AppLocalizations l10n) {
    return Column(
      key: const ValueKey('gif-options'),
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          l10n.playerGifRecordLength,
          style: theme.textTheme.titleSmall,
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final length in [3, 5, 8, 10])
              ChoiceChip(
                label: Text('${length}s'),
                selected: (_range.end - _range.start - length).abs() < 0.05,
                onSelected: length > _max
                    ? null
                    : (_) {
                        final end = math.min(_max, _range.start + length);
                        final start = math.max(0, end - length).toDouble();
                        setState(
                          () => _range = RangeValues(start, end.toDouble()),
                        );
                        widget.videoController.player.seek(
                          Duration(milliseconds: (start * 1000).round()),
                        );
                      },
              ),
          ],
        ),
        const SizedBox(height: 20),
        _SelectField<GifResolution>(
          label: l10n.playerGifResolution,
          value: _resolution,
          values: widget.sourceUrls.keys,
          labelBuilder: (value) => '${value.width}p',
          onChanged: (value) => setState(() => _resolution = value),
        ),
        const SizedBox(height: 14),
        _SelectField<int>(
          label: l10n.playerGifFrameRate,
          value: _fps,
          values: const [10, 12, 15],
          labelBuilder: (value) => '$value FPS',
          onChanged: (value) => setState(() => _fps = value),
        ),
      ],
    );
  }

  Widget _buildActions(
    ThemeData theme,
    AppLocalizations l10n, {
    required bool emphasizeExport,
  }) {
    final canExport = _range.end > _range.start;
    void export() {
      Navigator.of(context).pop(
        GifRecordOptions(
          start: _range.start,
          end: _range.end,
          resolution: _resolution,
          fps: _fps,
          url: widget.sourceUrls[_resolution]!,
        ),
      );
    }

    final VoidCallback? onExport = canExport ? export : null;
    return Column(
      key: const ValueKey('gif-actions'),
      children: [
        const Spacer(),
        Semantics(
          button: true,
          label: l10n.playerGifExport,
          child: emphasizeExport
              ? IconButton.filled(
                  key: const ValueKey('gif-export-button'),
                  tooltip: l10n.playerGifExport,
                  style: IconButton.styleFrom(
                    backgroundColor: theme.colorScheme.primary,
                    foregroundColor: theme.colorScheme.onPrimary,
                  ),
                  onPressed: onExport,
                  icon: const Icon(Icons.file_download_outlined),
                )
              : IconButton(
                  key: const ValueKey('gif-export-button'),
                  tooltip: l10n.playerGifExport,
                  onPressed: onExport,
                  icon: const Icon(Icons.file_download_outlined),
                ),
        ),
        const Spacer(),
        Semantics(
          button: true,
          label: l10n.commonCancel,
          child: IconButton(
            key: const ValueKey('gif-cancel-button'),
            tooltip: l10n.commonCancel,
            onPressed: Navigator.of(context).pop,
            icon: const Icon(Icons.close),
          ),
        ),
      ],
    );
  }
}

class _SelectField<T> extends StatelessWidget {
  const _SelectField({
    required this.label,
    required this.value,
    required this.values,
    required this.labelBuilder,
    required this.onChanged,
  });

  final String label;
  final T value;
  final Iterable<T> values;
  final String Function(T value) labelBuilder;
  final ValueChanged<T> onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      initialValue: value,
      isExpanded: true,
      decoration: InputDecoration(labelText: label),
      items: [
        for (final item in values)
          DropdownMenuItem<T>(
            value: item,
            child: Text(labelBuilder(item)),
          ),
      ],
      onChanged: (value) {
        if (value != null) onChanged(value);
      },
    );
  }
}
