import 'package:ex_piliplus/plugin/pl_player/widgets/darwin_gif_converter.dart';

/// Backward-compatible name for callers and existing iOS tests.
class IosGifConverter extends DarwinGifConverter {
  IosGifConverter(
    super.url,
    super.outFile,
    super.start,
    super.end, {
    required super.width,
    required super.fps,
    super.progress,
    super.channel,
  });
}
