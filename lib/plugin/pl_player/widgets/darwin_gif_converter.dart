import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:ex_piliplus/http/browser_ua.dart';
import 'package:ex_piliplus/http/constants.dart';
import 'package:ex_piliplus/utils/extension/string_ext.dart';
import 'package:ex_piliplus/plugin/pl_player/widgets/gif_converter_base.dart';
import 'package:ex_piliplus/plugin/pl_player/widgets/gif_source_cache.dart';
import 'package:flutter/foundation.dart' show debugPrint;
import 'package:flutter/services.dart';
import 'package:get/get_rx/get_rx.dart';

class DarwinGifConverter implements GifConverter, GifConversionDiagnostics {
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
  final bool _localSourceFallback;
  final GifSourceCache Function() _sourceCacheFactory;
  GifSourceCache? _sourceCache;

  @override
  String? failureCode;

  final _preparingSource = false.obs;

  @override
  bool get preparingSource => _preparingSource.value;

  bool _disposed = false;
  bool _converting = false;

  DarwinGifConverter(
    this.url,
    this.outFile,
    this.start,
    double end, {
    required this.width,
    required this.fps,
    this.progress,
    MethodChannel? channel,
    bool? localSourceFallback,
    GifSourceCache Function()? sourceCacheFactory,
  }) : duration = end - start,
       _channel = channel ?? _defaultChannel,
       _localSourceFallback = localSourceFallback ?? Platform.isIOS,
       _sourceCacheFactory = sourceCacheFactory ?? GifSourceCache.new;

  @override
  Future<bool> convert() async {
    if (_disposed || _converting) return false;
    failureCode = null;
    _converting = true;
    _channel.setMethodCallHandler(_handleNativeCall);
    var success = false;
    try {
      final arguments = <String, Object>{
        // AVURLAsset uses ATS on iOS, unlike the playback engine. CDN
        // responses may contain HTTP or protocol-relative URLs.
        'url': url.http2https,
        'outputPath': outFile,
        'start': start,
        'duration': duration,
        'width': width,
        'fps': fps,
        'userAgent': BrowserUa.pc,
        'referer': HttpString.baseUrl,
      };
      final result = await _generate(arguments);
      if (_disposed) return false;
      if (result != outFile) {
        failureCode = 'output_path_mismatch';
        return false;
      }
      success = _hasGifHeader(File(outFile));
      if (!success) failureCode = 'invalid_gif_output';
      return success;
    } on PlatformException catch (error, stackTrace) {
      if (error.code != 'cancelled' && !_disposed) {
        failureCode = switch (error.code) {
          'busy' ||
          'invalid_arguments' ||
          'asset_unreadable' ||
          'output_creation_failed' ||
          'frame_generation_failed' ||
          'output_finalize_failed' => error.code,
          _ => 'native_export_failed',
        };
        if (error.code == 'asset_unreadable') {
          failureCode = _assetFailureCode(error.details);
        }
        debugPrint('DarwinGifConvert: $failureCode\n$stackTrace');
      }
      return false;
    } on GifSourceException catch (error) {
      if (!_disposed && error.code != 'source_cancelled') {
        failureCode = error.code;
      }
      return false;
    } on MissingPluginException {
      if (!_disposed) failureCode = 'native_export_unavailable';
      return false;
    } catch (error, stackTrace) {
      if (!_disposed) failureCode = 'export_failed';
      debugPrint('DarwinGifConvert: $error\n$stackTrace');
      return false;
    } finally {
      await _sourceCache?.dispose();
      _sourceCache = null;
      if (!success) _removeOutputIfPresent();
      progress?.value = 1;
      _converting = false;
      _channel.setMethodCallHandler(null);
    }
  }

  Future<String?> _generate(Map<String, Object> arguments) async {
    try {
      return await _channel.invokeMethod<String>('generate', arguments);
    } on PlatformException catch (error) {
      // AVFoundation's remote DASH loading can fail before any video track is
      // available. Retry from a bounded local MP4 using explicit HTTP headers,
      // rather than depending on the undocumented AVURLAsset header option.
      final source = Uri.parse(arguments['url']! as String);
      if (!_localSourceFallback ||
          _disposed ||
          error.code != 'asset_unreadable' ||
          source.scheme == 'file') {
        rethrow;
      }
      debugPrint(
        'DarwinGifConvert: ${_assetFailureCode(error.details)}; retrying locally',
      );
      final cache = _sourceCache = _sourceCacheFactory();
      _preparingSource.value = true;
      progress?.value = 0;
      late final File file;
      try {
        file = await cache.download(
          source,
          userAgent: BrowserUa.pc,
          referer: HttpString.baseUrl,
          onProgress: (received, total) {
            if (!_disposed && total != null && total > 0) {
              progress?.value = (received / total).clamp(0, 1);
            }
          },
        );
      } finally {
        _preparingSource.value = false;
        progress?.value = 0;
      }
      if (_disposed) return null;
      return _channel.invokeMethod<String>('generate', {
        ...arguments,
        'url': file.uri.toString(),
      });
    }
  }

  static String _assetFailureCode(dynamic details) {
    const base = 'asset_unreadable';
    if (details is! Map) return base;
    const stages = {'tracks', 'timeout', 'no_video', 'dimensions'};
    const domains = {
      'NSURLErrorDomain',
      'AVFoundationErrorDomain',
      'NSOSStatusErrorDomain',
      'NSCocoaErrorDomain',
      'Other',
    };
    final stage = details['stage'];
    if (!stages.contains(stage)) return base;
    final parts = <String>[base, stage as String];
    for (final prefix in ['', 'underlying']) {
      final domain = details[prefix.isEmpty ? 'domain' : 'underlyingDomain'];
      final code = details[prefix.isEmpty ? 'code' : 'underlyingCode'];
      if (domains.contains(domain) && code is int) {
        parts.add('$domain:$code');
      }
    }
    return parts.join('/');
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
    _sourceCache?.cancel();
    if (_converting) {
      unawaited(_cancel());
    }
  }

  Future<void> _cancel() async {
    try {
      await _channel.invokeMethod<void>('cancel');
    } catch (_) {
      // Cancellation is best effort, including when the native plugin is absent.
      // convert() still owns cleanup after the outstanding generate call settles.
    }
  }

  void _removeOutputIfPresent() {
    try {
      final output = File(outFile);
      if (output.existsSync()) output.deleteSync();
    } catch (error) {
      debugPrint('DarwinGifConvert: cannot remove temporary output: $error');
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
      debugPrint('DarwinGifConvert: cannot validate output: $error');
      return false;
    } finally {
      input?.closeSync();
    }
  }
}
