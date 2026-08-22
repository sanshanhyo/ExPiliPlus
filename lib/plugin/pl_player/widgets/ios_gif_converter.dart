import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:ex_piliplus/http/browser_ua.dart';
import 'package:ex_piliplus/http/constants.dart';
import 'package:ex_piliplus/plugin/pl_player/widgets/gif_converter_base.dart';
import 'package:flutter/foundation.dart' show debugPrint;
import 'package:flutter/services.dart';
import 'package:get/get_rx/get_rx.dart';

class IosGifConverter implements GifConverter {
  static const MethodChannel _defaultChannel = MethodChannel(
    'io.github.sanshanhyo.expiliplus/gif_export',
  );

  final String url;
  final String outFile;
  final double start;
  final double duration;
  final int width;
  final int fps;
  final RxDouble? progress;
  final MethodChannel _channel;

  bool _disposed = false;
  bool _converting = false;

  IosGifConverter(
    this.url,
    this.outFile,
    this.start,
    double end, {
    required this.width,
    required this.fps,
    this.progress,
    MethodChannel? channel,
  }) : duration = end - start,
       _channel = channel ?? _defaultChannel;

  @override
  Future<bool> convert() async {
    if (_disposed || _converting) return false;
    _converting = true;
    _channel.setMethodCallHandler(_handleNativeCall);
    var success = false;
    try {
      final result = await _channel.invokeMethod<String>('generate', {
        'url': url,
        'outputPath': outFile,
        'start': start,
        'duration': duration,
        'width': width,
        'fps': fps,
        'userAgent': BrowserUa.pc,
        'referer': HttpString.baseUrl,
      });
      if (_disposed || result != outFile) return false;
      success = _hasGifHeader(File(outFile));
      return success;
    } on PlatformException catch (error, stackTrace) {
      if (error.code != 'cancelled') {
        debugPrint(
          'IosGifConvert: ${error.code}: ${error.message}; '
          'details=${error.details}\n$stackTrace',
        );
      }
      return false;
    } catch (error, stackTrace) {
      debugPrint('IosGifConvert: $error\n$stackTrace');
      return false;
    } finally {
      if (!success) _removeOutputIfPresent();
      progress?.value = 1;
      _converting = false;
      _channel.setMethodCallHandler(null);
    }
  }

  Future<void> _handleNativeCall(MethodCall call) async {
    if (call.method != 'progress' || _disposed) return;
    final value = call.arguments;
    if (value is num) {
      progress?.value = value.toDouble().clamp(0, 1);
    }
  }

  @override
  void dispose() {
    if (_disposed) return;
    _disposed = true;
    if (_converting) {
      unawaited(_channel.invokeMethod<void>('cancel'));
    }
  }

  void _removeOutputIfPresent() {
    try {
      final output = File(outFile);
      if (output.existsSync()) output.deleteSync();
    } catch (error) {
      debugPrint('IosGifConvert: cannot remove temporary output: $error');
    }
  }

  bool _hasGifHeader(File file) {
    RandomAccessFile? input;
    try {
      if (!file.existsSync() || file.lengthSync() <= 6) return false;
      input = file.openSync();
      final header = latin1.decode(input.readSync(6));
      return header == 'GIF87a' || header == 'GIF89a';
    } catch (error) {
      debugPrint('IosGifConvert: cannot validate output: $error');
      return false;
    } finally {
      input?.closeSync();
    }
  }
}
