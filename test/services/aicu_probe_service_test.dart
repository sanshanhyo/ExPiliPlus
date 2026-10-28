import 'dart:async';

import 'package:dio/dio.dart';
import 'package:ex_piliplus/models/common/aicu_probe_status.dart';
import 'package:ex_piliplus/services/aicu_probe_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('only a successful status and code zero mean reachable', () async {
    final service = AicuProbeService(
      request: () async => const AicuProbeResponse(
        statusCode: 200,
        body: '{"code":0,"data":{}}',
      ),
    );
    expect(await service.check(), AicuProbeStatus.reachable);

    for (final code in [1, '0', null]) {
      final bad = AicuProbeService(
        request: () async => AicuProbeResponse(
          statusCode: 200,
          body: '{"code":${code is String ? '"$code"' : code}}',
        ),
      );
      expect(await bad.check(), AicuProbeStatus.unexpectedResponse);
    }
    final malformed = AicuProbeService(
      request: () async => const AicuProbeResponse(
        statusCode: 200,
        body: '<html>challenge</html>',
      ),
    );
    expect(await malformed.check(), AicuProbeStatus.unexpectedResponse);
  });

  test('respects 403, 429 and 468 as limited without retrying', () async {
    for (final status in [403, 429, 468]) {
      var requests = 0;
      final service = AicuProbeService(
        request: () async {
          requests++;
          return AicuProbeResponse(statusCode: status, body: 'limited');
        },
      );
      expect(await service.check(), AicuProbeStatus.limited);
      expect(requests, 1);
    }
  });

  test('honors Retry-After before allowing another manual probe', () async {
    var requests = 0;
    var now = DateTime.utc(2026, 10, 28, 12);
    final service = AicuProbeService(
      request: () async {
        requests++;
        return requests == 1
            ? const AicuProbeResponse(
                statusCode: 429,
                body: 'limited',
                retryAfter: '60',
              )
            : const AicuProbeResponse(statusCode: 200, body: '{"code":0}');
      },
      minimumInterval: const Duration(seconds: 30),
      now: () => now,
    );

    expect(await service.check(), AicuProbeStatus.limited);
    now = now.add(const Duration(seconds: 31));
    expect(await service.check(), AicuProbeStatus.limited);
    expect(requests, 1);

    now = now.add(const Duration(seconds: 30));
    expect(await service.check(), AicuProbeStatus.reachable);
    expect(requests, 2);
  });

  test('parses HTTP-date Retry-After values', () async {
    var requests = 0;
    var now = DateTime.utc(2026, 10, 28, 12);
    final service = AicuProbeService(
      request: () async {
        requests++;
        return requests == 1
            ? const AicuProbeResponse(
                statusCode: 429,
                body: 'limited',
                retryAfter: 'Wed, 28 Oct 2026 12:01:00 GMT',
              )
            : const AicuProbeResponse(statusCode: 200, body: '{"code":0}');
      },
      minimumInterval: const Duration(seconds: 30),
      now: () => now,
    );

    expect(await service.check(), AicuProbeStatus.limited);
    now = now.add(const Duration(seconds: 31));
    expect(await service.check(), AicuProbeStatus.limited);
    expect(requests, 1);
    now = DateTime.utc(2026, 10, 28, 12, 1, 1);
    expect(await service.check(), AicuProbeStatus.reachable);
    expect(requests, 2);
  });

  test('manual probe requests are throttled between checks', () async {
    var requests = 0;
    var now = DateTime.utc(2026, 10, 28);
    final service = AicuProbeService(
      request: () async {
        requests++;
        return const AicuProbeResponse(statusCode: 200, body: '{"code":0}');
      },
      minimumInterval: const Duration(seconds: 30),
      now: () => now,
    );

    expect(await service.check(), AicuProbeStatus.reachable);
    expect(await service.check(), AicuProbeStatus.reachable);
    expect(requests, 1);

    now = now.add(const Duration(seconds: 31));
    expect(await service.check(), AicuProbeStatus.reachable);
    expect(requests, 2);
  });

  test('classifies other HTTP errors and connection failures accurately', () async {
    final serverError = AicuProbeService(
      request: () async => const AicuProbeResponse(statusCode: 503, body: ''),
    );
    expect(await serverError.check(), AicuProbeStatus.unexpectedResponse);

    final noNetwork = AicuProbeService(
      request: () async => throw StateError('offline'),
    );
    expect(await noNetwork.check(), AicuProbeStatus.unavailable);
  });

  test('bounds checks by timeout and updates the visible state', () async {
    final pending = Completer<AicuProbeResponse>();
    final service = AicuProbeService(
      request: () => pending.future,
      timeout: const Duration(milliseconds: 10),
    );
    final result = service.check();
    expect(service.status.value, AicuProbeStatus.checking);
    expect(await result, AicuProbeStatus.timedOut);
    expect(service.status.value, AicuProbeStatus.timedOut);
  });

  test('classifies Dio connection timeouts as timed out', () async {
    final service = AicuProbeService(
      request: () async => throw DioException(
        requestOptions: RequestOptions(path: '/api/v4/home/getnotice'),
        type: DioExceptionType.connectionTimeout,
      ),
    );
    expect(await service.check(), AicuProbeStatus.timedOut);
  });
}
