import 'dart:io';

import 'package:ex_piliplus/plugin/pl_player/widgets/darwin_gif_converter.dart';
import 'package:ex_piliplus/plugin/pl_player/widgets/gif_converter_base.dart';
import 'package:ex_piliplus/plugin/pl_player/widgets/mpv_convert_gif.dart';
import 'package:get/get_rx/get_rx.dart';

GifConverter createGifConverter(
  String url,
  String outFile,
  double start,
  double end, {
  required int width,
  required int fps,
  RxDouble? progress,
}) {
  if (Platform.isIOS || Platform.isMacOS) {
    return DarwinGifConverter(
      url,
      outFile,
      start,
      end,
      width: width,
      fps: fps,
      progress: progress,
    );
  }
  return MpvConvertGif(
    url,
    outFile,
    start,
    end,
    width: width,
    fps: fps,
    progress: progress,
  );
}
