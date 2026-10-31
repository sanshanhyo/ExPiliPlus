import 'dart:async';
import 'dart:io';

import 'package:ex_piliplus/plugin/pl_player/widgets/gif_source_cache.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late Directory temp;
  late _Client client;
  late GifSourceCache cache;
  final source = Uri.parse('https://cdn.example/video.m4s?token=unchanged');

  setUp(() async {
    temp = await Directory.systemTemp.createTemp('gif-source-test-');
    client = _Client();
    cache = GifSourceCache(
      clientFactory: () => client,
      temporaryDirectory: temp,
      maxBytes: 8,
      timeout: const Duration(seconds: 1),
    );
  });

  tearDown(() async {
    await cache.dispose();
    await temp.delete(recursive: true);
  });

  Future<File> download() => cache.download(
    source,
    userAgent: 'test-agent',
    referer: 'https://www.bilibili.com',
  );

  Matcher code(String value) => isA<GifSourceException>().having(
    (error) => error.code,
    'code',
    value,
  );

  test('streams bytes with explicit headers and preserves signed query', () async {
    client.responses.add(_Response([[1, 2], [3, 4]], length: 4));
    final updates = <int>[];
    final file = await cache.download(
      source,
      userAgent: 'test-agent',
      referer: 'https://www.bilibili.com',
      onProgress: (received, total) {
        updates.add(received);
        expect(total, 4);
      },
    );
    expect(await file.readAsBytes(), [1, 2, 3, 4]);
    expect(file.path.endsWith('/source.mp4'), isTrue);
    expect(client.urls, [source]);
    expect(client.requests.single.followRedirects, isFalse);
    expect(client.requests.single.headers.values, {
      'user-agent': 'test-agent',
      'referer': 'https://www.bilibili.com',
      'accept-encoding': 'identity',
    });
    expect(updates, [2, 4]);
    await cache.dispose();
    expect(await file.exists(), isFalse);
  });

  test('accepts secure redirects and preserves explicit headers', () async {
    client.responses.addAll([
      _Response([], status: 302, location: '/new.m4s?token=redirect'),
      _Response([[1]], length: 1),
    ]);
    await download();
    expect(client.urls.last.toString(), 'https://cdn.example/new.m4s?token=redirect');
    expect(client.requests.last.headers.values['user-agent'], 'test-agent');
  });

  test('rejects insecure redirect before sending the second request', () async {
    client.responses.add(_Response([], status: 302, location: 'http://cdn.example/file'));
    await expectLater(download(), throwsA(code('source_invalid_url')));
    expect(client.urls, hasLength(1));
    expect(await temp.list().toList(), isEmpty);
  });

  test('rejects non-HTTPS input without opening a connection', () async {
    await expectLater(
      cache.download(Uri.parse('http://cdn.example/file'), userAgent: 'ua', referer: 'ref'),
      throwsA(code('source_invalid_url')),
    );
    expect(client.urls, isEmpty);
  });

  test('rejects declared oversized response without writing any file', () async {
    client.responses.add(_Response([[1]], length: 9));
    await expectLater(download(), throwsA(code('source_too_large')));
    expect(await temp.list().toList(), isEmpty);
  });

  test('caps actual bytes for chunked responses and removes partial files', () async {
    client.responses.add(_Response([[1, 2, 3, 4], [5, 6, 7, 8, 9]]));
    await expectLater(download(), throwsA(code('source_too_large')));
    expect(await temp.list().toList(), isEmpty);
  });

  test('rejects empty input', () async {
    client.responses.add(_Response([], length: 0));
    await expectLater(download(), throwsA(code('source_empty')));
    expect(await temp.list().toList(), isEmpty);
  });

  test('rejects a truncated response', () async {
    client.responses.add(_Response([[1]], length: 2));
    await expectLater(download(), throwsA(code('source_download_failed')));
    expect(await temp.list().toList(), isEmpty);
  });

  test('rejects HTTP errors without exposing the source URL', () async {
    client.responses.add(_Response([], status: 403));
    await expectLater(download(), throwsA(code('source_download_failed')));
    expect(await temp.list().toList(), isEmpty);
  });

  test('cancels a stalled body and waits before deleting partial files', () async {
    final body = StreamController<List<int>>();
    client.responses.add(_Response.stream(body.stream));
    final result = download();
    final expectation = expectLater(result, throwsA(code('source_cancelled')));
    body.add([1, 2]);
    await Future<void>.delayed(const Duration(milliseconds: 10));
    cache.cancel();
    await expectation;
    expect(client.closed, isTrue);
    expect(await temp.list().toList(), isEmpty);
    await body.close();
  });

  test('deadline terminates a stalled body and removes partial files', () async {
    cache = GifSourceCache(
      clientFactory: () => client,
      temporaryDirectory: temp,
      timeout: const Duration(milliseconds: 20),
    );
    final body = StreamController<List<int>>();
    client.responses.add(_Response.stream(body.stream));
    await expectLater(download(), throwsA(code('source_download_timeout')));
    expect(client.closed, isTrue);
    expect(await temp.list().toList(), isEmpty);
    await body.close();
  });

  test('cancellation before start does not create temporary files', () async {
    cache.cancel();
    await expectLater(download(), throwsA(code('source_cancelled')));
    expect(client.urls, isEmpty);
    expect(await temp.list().toList(), isEmpty);
  });

  test('bounds redirect chains', () async {
    client.responses.addAll(List.generate(
      6,
      (_) => _Response([], status: 302, location: '/again'),
    ));
    await expectLater(download(), throwsA(code('source_download_failed')));
    expect(client.urls, hasLength(6));
    expect(await temp.list().toList(), isEmpty);
  });

  test('dispose cancels a pending connection without waiting for its response', () async {
    final pending = Completer<HttpClientRequest>();
    client.pendingRequest = pending;
    final result = download();
    final expectation = expectLater(result, throwsA(code('source_cancelled')));
    await Future<void>.delayed(Duration.zero);
    await cache.dispose();
    await expectation;
    expect(client.closed, isTrue);
    expect(await temp.list().toList(), isEmpty);
    pending.completeError(const SocketException('fixture cancelled'));
    await Future<void>.delayed(Duration.zero);
  });

  test('filesystem failures are safe and bounded', () async {
    final missing = Directory('${temp.path}/missing/parent');
    cache = GifSourceCache(clientFactory: () => client, temporaryDirectory: missing);
    client.responses.add(_Response([[1]], length: 1));
    await expectLater(download(), throwsA(code('source_download_failed')));
    expect(client.closed, isTrue);
  });
}

class _Client extends Fake implements HttpClient {
  final responses = <_Response>[];
  final urls = <Uri>[];
  final requests = <_Request>[];
  bool closed = false;
  Completer<HttpClientRequest>? pendingRequest;

  @override
  set autoUncompress(bool value) {}

  @override
  set connectionTimeout(Duration? value) {}

  @override
  Future<HttpClientRequest> getUrl(Uri url) async {
    urls.add(url);
    if (pendingRequest case final pending?) return pending.future;
    final request = _Request(responses.removeAt(0));
    requests.add(request);
    return request;
  }

  @override
  void close({bool force = false}) {
    closed = true;
  }
}

class _Headers extends Fake implements HttpHeaders {
  final values = <String, String>{};

  @override
  void set(String name, Object value, {bool preserveHeaderCase = false}) {
    values[name.toLowerCase()] = '$value';
  }

  @override
  String? value(String name) => values[name.toLowerCase()];
}

class _Request extends Fake implements HttpClientRequest {
  _Request(this.response);

  final _Response response;
  @override
  final _Headers headers = _Headers();
  @override
  bool followRedirects = true;

  @override
  Future<HttpClientResponse> close() async => response;
}

class _Response extends Stream<List<int>> implements HttpClientResponse {
  _Response(List<List<int>> chunks, {int status = 200, int length = -1, String? location})
    : this.stream(Stream.fromIterable(chunks), status: status, length: length, location: location);

  _Response.stream(this.body, {int status = 200, int length = -1, String? location})
    : statusCode = status,
      contentLength = length {
    if (location != null) headers.values['location'] = location;
  }

  final Stream<List<int>> body;
  @override
  final int statusCode;
  @override
  final int contentLength;
  @override
  final _Headers headers = _Headers();

  @override
  StreamSubscription<List<int>> listen(
    void Function(List<int>)? onData, {
    Function? onError,
    void Function()? onDone,
    bool? cancelOnError,
  }) => body.listen(onData, onError: onError, onDone: onDone, cancelOnError: cancelOnError);

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
