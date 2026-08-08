// ignore_for_file: implementation_imports

import 'dart:async';
import 'dart:ffi';
import 'dart:io';

import 'package:ex_piliplus/http/browser_ua.dart';
import 'package:ex_piliplus/http/constants.dart';
import 'package:ex_piliplus/utils/storage_pref.dart';
import 'package:flutter/foundation.dart' show debugPrint, kDebugMode;
import 'package:get/get_rx/get_rx.dart';
import 'package:media_kit/ffi/src/allocation.dart';
import 'package:media_kit/ffi/src/utf8.dart';
import 'package:media_kit/generated/libmpv/bindings.dart' as generated;
import 'package:media_kit/media_kit.dart';
import 'package:media_kit/src/player/native/core/initializer.dart';

class MpvConvertGif {
  final _mpv = NativePlayer.mpv;
  late final Pointer<generated.mpv_handle> _ctx;
  final _completer = Completer<bool>();

  bool _loaded = false;
  bool _disposed = false;
  bool _initialized = false;
  String? _lastError;

  final String url;
  final String outFile;
  final double start;
  final double duration;
  final int width;
  final int fps;
  final RxDouble? progress;

  MpvConvertGif(
    this.url,
    this.outFile,
    this.start,
    double end, {
    required this.width,
    required this.fps,
    this.progress,
  }) : duration = end - start;

  Future<void> _init() async {
    final enableHA = Pref.enableHA;
    _ctx = await Initializer.create(
      _mpv,
      _onEvent,
      options: {
        'o': outFile,
        'start': start.toStringAsFixed(3),
        'end': (start + duration).toStringAsFixed(3),
        'of': 'gif',
        'ofopts': 'loop=0',
        'ovc': 'lavc',
        'ovcopts': 'codec=gif',
        'vf': 'fps=$fps,scale=$width:-2:flags=lanczos',
        'audio': 'no',
        if (enableHA) 'vo': 'gpu',
        if (enableHA) 'hwdec': '${Pref.hardwareDecoding},auto-copy',
      },
    );
    _initialized = true;
    NativePlayer.setHeader(
      _mpv,
      _ctx,
      userAgent: BrowserUa.pc,
      referer: HttpString.baseUrl,
    );
    if (progress != null) {
      _observeProperty('time-pos');
    }
    final level = (kDebugMode ? 'info' : 'error').toNativeUtf8();
    _mpv.mpv_request_log_messages(_ctx, level);
    calloc.free(level);
  }

  void dispose() {
    if (_disposed) return;
    _disposed = true;
    if (_initialized) {
      Initializer.dispose(_ctx);
      _mpv.mpv_terminate_destroy(_ctx);
    }
    if (!_completer.isCompleted) _completer.complete(false);
  }

  Future<bool> convert() async {
    try {
      await _init();
      if (_disposed) return false;
      _command(['loadfile', url]);
      return _completer.future;
    } catch (error, stackTrace) {
      debugPrint('GifConvert: initialization failed: $error\n$stackTrace');
      _complete(false);
      return false;
    }
  }

  Future<void>? _onEvent(Pointer<generated.mpv_event> event) {
    if (_disposed) return null;

    switch (event.ref.event_id) {
      case generated.mpv_event_id.MPV_EVENT_PROPERTY_CHANGE:
        final prop = event.ref.data.cast<generated.mpv_event_property>().ref;
        if (prop.name.toDartString() == 'time-pos' &&
            prop.format == generated.mpv_format.MPV_FORMAT_DOUBLE &&
            progress != null) {
          progress!.value =
              ((prop.data.cast<Double>().value - start) / duration).clamp(0, 1);
        }
        break;
      case generated.mpv_event_id.MPV_EVENT_FILE_LOADED:
        _loaded = true;
        break;
      case generated.mpv_event_id.MPV_EVENT_LOG_MESSAGE:
        final log = event.ref.data.cast<generated.mpv_event_log_message>().ref;
        final prefix = log.prefix.toDartString().trim();
        final level = log.level.toDartString().trim();
        final text = log.text.toDartString().trim();
        debugPrint('GifConvert: $level $prefix : $text');
        if (level == 'error' || level == 'fatal') {
          _lastError = text;
        }
        break;
      case generated.mpv_event_id.MPV_EVENT_END_FILE:
        final end = event.ref.data.cast<generated.mpv_event_end_file>().ref;
        final reason = end.reason;
        final error = end.error;
        final output = File(outFile);
        final success =
            reason == generated.mpv_end_file_reason.MPV_END_FILE_REASON_EOF &&
            _loaded &&
            _lastError == null &&
            output.existsSync() &&
            output.lengthSync() > 0;
        debugPrint(
          'GifConvert: end reason=$reason error=$error '
          'loaded=$_loaded output=${output.existsSync()} '
          'size=${output.existsSync() ? output.lengthSync() : 0} '
          'lastError=$_lastError',
        );
        _complete(success);
        break;
      case generated.mpv_event_id.MPV_EVENT_SHUTDOWN:
        _complete(false);
        break;
    }
    return null;
  }

  void _complete(bool success) {
    if (_completer.isCompleted) return;
    progress?.value = 1;
    _completer.complete(success);
    dispose();
  }

  void _command(List<String> args) {
    final pointers = args.map((e) => e.toNativeUtf8()).toList();
    final arr = calloc<Pointer<Uint8>>(pointers.length + 1);
    for (int i = 0; i < args.length; i++) {
      arr[i] = pointers[i];
    }

    _mpv.mpv_command(_ctx, arr);

    calloc.free(arr);
    pointers.forEach(calloc.free);
  }

  void _observeProperty(String property) {
    final name = property.toNativeUtf8();
    _mpv.mpv_observe_property(
      _ctx,
      property.hashCode,
      name,
      generated.mpv_format.MPV_FORMAT_DOUBLE,
    );

    calloc.free(name);
  }
}
