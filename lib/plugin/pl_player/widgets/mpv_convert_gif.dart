// ignore_for_file: implementation_imports

import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:ex_piliplus/http/browser_ua.dart';
import 'package:ex_piliplus/http/constants.dart';
import 'package:ex_piliplus/plugin/pl_player/widgets/gif_converter_base.dart';
import 'package:flutter/foundation.dart' show debugPrint, kDebugMode;
import 'package:get/get_rx/get_rx.dart';
import 'package:media_kit/ffi/src/allocation.dart';
import 'package:media_kit/ffi/src/utf8.dart';
import 'package:media_kit/generated/libmpv/bindings.dart' as generated;
import 'package:media_kit/media_kit.dart';
import 'package:media_kit/src/player/native/core/initializer.dart';

class MpvConvertGif implements GifConverter {
  final _mpv = NativePlayer.mpv;
  late final Pointer<generated.mpv_handle> _ctx;
  final _completer = Completer<bool>();

  bool _loaded = false;
  bool _disposed = false;
  bool _initialized = false;
  bool _succeeded = false;
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
    final output = File(outFile);
    await output.parent.create(recursive: true);
    if (output.existsSync()) await output.delete();

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
        // GIF encoding runs in a headless mpv instance. Do not inherit the
        // player's GPU renderer or hardware decoder configuration here.
        'vo': 'null',
      },
    );
    _initialized = true;
    if (_disposed) {
      _disposeNative();
      return;
    }
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
    final result = _mpv.mpv_request_log_messages(_ctx, level);
    calloc.free(level);
    if (result < 0) {
      _recordError('mpv_request_log_messages failed: ${_errorText(result)}');
    }

    debugPrint(
      'GifConvert: start input=${_describeUrl(url)} output=$outFile '
      'range=${start.toStringAsFixed(3)}-${(start + duration).toStringAsFixed(3)} '
      'width=$width fps=$fps',
    );
  }

  @override
  void dispose() {
    if (_disposed) return;
    _disposed = true;
    _disposeNative();
    if (!_succeeded) _removeOutputIfPresent();
    if (!_completer.isCompleted) _completer.complete(false);
  }

  void _disposeNative() {
    if (!_initialized) return;
    Initializer.dispose(_ctx);
    _mpv.mpv_terminate_destroy(_ctx);
    _initialized = false;
  }

  @override
  Future<bool> convert() async {
    try {
      await _init();
      if (_disposed) return false;
      final result = _command(['loadfile', url]);
      if (result < 0) {
        _complete(false);
        return false;
      }
      return _completer.future;
    } catch (error, stackTrace) {
      _recordError('initialization failed: $error');
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
        debugPrint('GifConvert: input loaded');
        break;
      case generated.mpv_event_id.MPV_EVENT_LOG_MESSAGE:
        final log = event.ref.data.cast<generated.mpv_event_log_message>().ref;
        final prefix = log.prefix.toDartString().trim();
        final level = log.level.toDartString().trim();
        final text = log.text.toDartString().trim();
        debugPrint('GifConvert: $level $prefix : $text');
        if (level == 'error' || level == 'fatal') {
          _recordError(text);
        }
        break;
      case generated.mpv_event_id.MPV_EVENT_END_FILE:
        final end = event.ref.data.cast<generated.mpv_event_end_file>().ref;
        final reason = end.reason;
        final error = end.error;
        final output = File(outFile);
        final exists = output.existsSync();
        final size = exists ? output.lengthSync() : 0;
        final header = exists ? _readHeader(output) : '';
        final errorText = error == 0 ? '' : _errorText(error);
        final validHeader = header == 'GIF87a' || header == 'GIF89a';
        final success =
            reason == generated.mpv_end_file_reason.MPV_END_FILE_REASON_EOF &&
            error == 0 &&
            _lastError == null &&
            exists &&
            size > 0 &&
            validHeader;
        debugPrint(
          'GifConvert: end reason=$reason error=$error'
          '${errorText.isEmpty ? '' : ' ($errorText)'} '
          'loaded=$_loaded output=$exists size=$size header=$header '
          'lastError=$_lastError success=$success',
        );
        _complete(success);
        break;
      case generated.mpv_event_id.MPV_EVENT_SHUTDOWN:
        _recordError('mpv shutdown before GIF conversion completed');
        _complete(false);
        break;
    }
    return null;
  }

  void _complete(bool success) {
    if (_completer.isCompleted) return;
    _succeeded = success;
    progress?.value = 1;
    _completer.complete(success);
    dispose();
  }

  void _removeOutputIfPresent() {
    try {
      final output = File(outFile);
      if (output.existsSync()) output.deleteSync();
    } catch (error) {
      debugPrint('GifConvert: cannot remove temporary output: $error');
    }
  }

  int _command(List<String> args) {
    final pointers = args.map((e) => e.toNativeUtf8()).toList();
    final arr = calloc<Pointer<Uint8>>(pointers.length + 1);
    for (int i = 0; i < args.length; i++) {
      arr[i] = pointers[i];
    }

    final result = _mpv.mpv_command(_ctx, arr);

    calloc.free(arr);
    pointers.forEach(calloc.free);
    if (result < 0) {
      _recordError(
        'mpv_command(${args.join(' ')}) failed: ${_errorText(result)}',
      );
    }
    return result;
  }

  void _observeProperty(String property) {
    final name = property.toNativeUtf8();
    final result = _mpv.mpv_observe_property(
      _ctx,
      property.hashCode,
      name,
      generated.mpv_format.MPV_FORMAT_DOUBLE,
    );

    calloc.free(name);
    if (result < 0) {
      _recordError(
        'mpv_observe_property($property) failed: ${_errorText(result)}',
      );
    }
  }

  void _recordError(String error) {
    if (error.trim().isEmpty) return;
    _lastError ??= error.trim();
    debugPrint('GifConvert: error $_lastError');
  }

  String _errorText(int error) {
    final text = _mpv.mpv_error_string(error);
    return text == nullptr ? 'code $error' : text.toDartString();
  }

  String _readHeader(File output) {
    RandomAccessFile? file;
    try {
      file = output.openSync();
      return latin1.decode(file.readSync(6));
    } catch (error) {
      debugPrint('GifConvert: cannot read output header: $error');
      return '';
    } finally {
      file?.closeSync();
    }
  }

  String _describeUrl(String value) {
    final uri = Uri.tryParse(value);
    if (uri == null) return '<invalid-url>';
    return '${uri.scheme}://${uri.host}${uri.path}';
  }
}
