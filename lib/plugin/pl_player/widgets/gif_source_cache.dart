import 'dart:async';
import 'dart:io';

/// Contains only a safe, stable code, never a signed URL or server response.
class GifSourceException implements Exception {
  const GifSourceException(this.code);

  final String code;

  @override
  String toString() => code;
}

/// A single-use, bounded cache for native GIF conversion fallback.
///
/// The caller owns [dispose], including after a successful download. Downloads
/// are streamed to disk, and neither credentials nor application cookies are
/// attached. The original URL query is preserved.
class GifSourceCache {
  GifSourceCache({
    HttpClient Function()? clientFactory,
    this.maxBytes = 128 * 1024 * 1024,
    Directory? temporaryDirectory,
    this.timeout = const Duration(seconds: 45),
  }) : _clientFactory = clientFactory ?? HttpClient.new,
       _temporaryDirectory = temporaryDirectory ?? Directory.systemTemp;

  final HttpClient Function() _clientFactory;
  final Directory _temporaryDirectory;
  final int maxBytes;
  final Duration timeout;
  final Completer<void> _stopped = Completer<void>();
  HttpClient? _client;
  Directory? _directory;
  Future<File>? _operation;
  String? _stopCode;
  bool _disposed = false;

  Future<File> download(
    Uri source, {
    required String userAgent,
    required String referer,
    void Function(int received, int? total)? onProgress,
  }) {
    if (_operation != null || _disposed) {
      return Future.error(const GifSourceException('source_download_failed'));
    }
    return _operation = _download(source, userAgent, referer, onProgress);
  }

  static bool _isSecure(Uri uri) =>
      uri.scheme == 'https' && uri.host.isNotEmpty && uri.userInfo.isEmpty;

  void _checkStopped() {
    final code = _stopCode;
    if (code != null) throw GifSourceException(code);
  }

  Future<T> _wait<T>(Future<T> future) => Future.any([
    future,
    _stopped.future.then<T>((_) => throw GifSourceException(_stopCode!)),
  ]);

  Future<File> _download(
    Uri source,
    String userAgent,
    String referer,
    void Function(int received, int? total)? onProgress,
  ) async {
    Timer? timer;
    RandomAccessFile? output;
    StreamIterator<List<int>>? input;
    var success = false;
    try {
      _checkStopped();
      if (!_isSecure(source)) {
        throw const GifSourceException('source_invalid_url');
      }
      timer = Timer(timeout, () => _stop('source_download_timeout'));
      final client = _client = _clientFactory();
      client.autoUncompress = false;
      client.connectionTimeout = timeout;
      var url = source;
      HttpClientResponse? response;
      for (var redirects = 0; redirects <= 5; redirects++) {
        _checkStopped();
        final request = await _wait(client.getUrl(url));
        _checkStopped();
        request.followRedirects = false;
        request.headers.set(HttpHeaders.userAgentHeader, userAgent);
        request.headers.set(HttpHeaders.refererHeader, referer);
        request.headers.set(HttpHeaders.acceptEncodingHeader, 'identity');
        response = await _wait(request.close());
        if (![301, 302, 303, 307, 308].contains(response.statusCode)) break;
        final location = response.headers.value(HttpHeaders.locationHeader);
        await response.listen((_) {}).cancel();
        if (location == null || redirects == 5) {
          throw const GifSourceException('source_download_failed');
        }
        url = url.resolve(location);
        if (!_isSecure(url)) {
          throw const GifSourceException('source_invalid_url');
        }
      }
      _checkStopped();
      if (response == null || response.statusCode != HttpStatus.ok) {
        throw const GifSourceException('source_download_failed');
      }
      if (response.contentLength > maxBytes) {
        throw const GifSourceException('source_too_large');
      }
      _directory = await _temporaryDirectory.createTemp('gif-source-');
      _checkStopped();
      final file = File('${_directory!.path}/source.mp4');
      output = await file.open(mode: FileMode.write);
      input = StreamIterator(response);
      var received = 0;
      while (await _wait(input.moveNext())) {
        _checkStopped();
        final chunk = input.current;
        received += chunk.length;
        if (received > maxBytes) {
          throw const GifSourceException('source_too_large');
        }
        // Never race a file write against timeout/cancel: settle it before
        // closing the handle and deleting its directory in finally.
        await output.writeFrom(chunk);
        onProgress?.call(
          received,
          response.contentLength >= 0 ? response.contentLength : null,
        );
      }
      _checkStopped();
      if (received == 0) throw const GifSourceException('source_empty');
      if (response.contentLength >= 0 && received != response.contentLength) {
        throw const GifSourceException('source_download_failed');
      }
      await output.flush();
      _checkStopped();
      success = true;
      return file;
    } on GifSourceException {
      rethrow;
    } catch (_) {
      throw GifSourceException(_stopCode ?? 'source_download_failed');
    } finally {
      timer?.cancel();
      _client?.close(force: true);
      _client = null;
      try {
        await input?.cancel();
      } finally {
        try {
          await output?.close();
        } finally {
          if (!success) await _removeDirectory();
        }
      }
    }
  }

  void _stop(String code) {
    if (_stopCode != null) return;
    _stopCode = code;
    _client?.close(force: true);
    _stopped.complete();
  }

  void cancel() => _stop('source_cancelled');

  Future<void> _removeDirectory() async {
    final directory = _directory;
    try {
      if (directory != null && await directory.exists()) {
        await directory.delete(recursive: true);
      }
      _directory = null;
    } on FileSystemException {
      // Do not mask the original conversion/download failure. Keep the path so
      // dispose can retry; the OS also reclaims this temporary cache.
    }
  }

  Future<void> dispose() async {
    _disposed = true;
    cancel();
    try {
      await _operation;
    } catch (_) {
      // The download caller receives the safe failure code.
    }
    await _removeDirectory();
  }
}
