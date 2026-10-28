import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:ex_piliplus/models/common/aicu_probe_status.dart';
import 'package:flutter/foundation.dart';

typedef AicuProbeRequest = Future<AicuProbeResponse> Function();

class AicuProbeResponse {
  const AicuProbeResponse({
    required this.statusCode,
    required this.body,
    this.retryAfter,
  });

  final int statusCode;
  final String body;
  final String? retryAfter;
}

/// Checks only the public AICU notice endpoint. This client has no app
/// interceptors, cookie jar, Bilibili account headers, or retry policy.
class AicuProbeService {
  AicuProbeService({
    AicuProbeRequest? request,
    this.timeout = const Duration(seconds: 5),
    this.minimumInterval = const Duration(seconds: 30),
    DateTime Function()? now,
  }) : _request = request ?? _requestOfficialEndpoint,
       _now = now ?? DateTime.now;

  static final instance = AicuProbeService();
  static const endpoint = 'https://api.aicu.cc/api/v4/home/getnotice';

  final AicuProbeRequest _request;
  final Duration timeout;
  final Duration minimumInterval;
  final DateTime Function() _now;
  DateTime? _lastCheckAt;
  DateTime? _notBefore;
  final ValueNotifier<AicuProbeStatus> status = ValueNotifier(
    AicuProbeStatus.notChecked,
  );

  Future<AicuProbeStatus> check() async {
    if (status.value == AicuProbeStatus.checking) return status.value;
    final now = _now();
    final lastCheckAt = _lastCheckAt;
    final notBefore = _notBefore;
    if ((notBefore != null && now.isBefore(notBefore)) ||
        (lastCheckAt != null && now.difference(lastCheckAt) < minimumInterval)) {
      return status.value;
    }
    _lastCheckAt = now;
    status.value = AicuProbeStatus.checking;

    AicuProbeStatus result;
    try {
      final response = await _request().timeout(timeout);
      result = _classify(response);
      if (result == AicuProbeStatus.limited) {
        final retryAfter = _parseRetryAfter(response.retryAfter, _now());
        if (retryAfter != null && retryAfter > minimumInterval) {
          _notBefore = _now().add(retryAfter);
        }
      }
    } on TimeoutException {
      result = AicuProbeStatus.timedOut;
    } on DioException catch (error) {
      result = switch (error.type) {
        DioExceptionType.connectionTimeout ||
        DioExceptionType.sendTimeout ||
        DioExceptionType.receiveTimeout => AicuProbeStatus.timedOut,
        _ => AicuProbeStatus.unavailable,
      };
    } catch (_) {
      result = AicuProbeStatus.unavailable;
    }

    status.value = result;
    return result;
  }

  static AicuProbeStatus _classify(AicuProbeResponse response) {
    if (response.statusCode == 403 ||
        response.statusCode == 429 ||
        response.statusCode == 468) {
      return AicuProbeStatus.limited;
    }
    if (response.statusCode < 200 || response.statusCode >= 300) {
      return AicuProbeStatus.unexpectedResponse;
    }

    try {
      final body = jsonDecode(response.body);
      if (body is Map && body['code'] == 0) {
        return AicuProbeStatus.reachable;
      }
    } on FormatException {
      return AicuProbeStatus.unexpectedResponse;
    }
    return AicuProbeStatus.unexpectedResponse;
  }

  static Duration? _parseRetryAfter(String? value, DateTime now) {
    if (value == null) return null;
    final raw = value.trim();
    final seconds = int.tryParse(raw);
    if (seconds != null) {
      return seconds <= 0 ? Duration.zero : Duration(seconds: seconds);
    }

    final match = RegExp(
      r'^(?:Mon|Tue|Wed|Thu|Fri|Sat|Sun), (\d{1,2}) '
      r'(Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec) '
      r'(\d{4}) (\d{2}):(\d{2}):(\d{2}) GMT$',
    ).firstMatch(raw);
    if (match == null) return null;
    const months = {
      'Jan': 1,
      'Feb': 2,
      'Mar': 3,
      'Apr': 4,
      'May': 5,
      'Jun': 6,
      'Jul': 7,
      'Aug': 8,
      'Sep': 9,
      'Oct': 10,
      'Nov': 11,
      'Dec': 12,
    };
    final target = DateTime.utc(
      int.parse(match[3]!),
      months[match[2]!]!,
      int.parse(match[1]!),
      int.parse(match[4]!),
      int.parse(match[5]!),
      int.parse(match[6]!),
    );
    final difference = target.difference(now.toUtc());
    return difference.isNegative ? Duration.zero : difference;
  }

  static Future<AicuProbeResponse> _requestOfficialEndpoint() async {
    final client = Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 4),
        receiveTimeout: const Duration(seconds: 4),
        sendTimeout: const Duration(seconds: 4),
        headers: const {
          'Accept': 'application/json',
          'Cache-Control': 'no-store',
        },
      ),
    );
    try {
      final response = await client.get<String>(
        endpoint,
        options: Options(
          responseType: ResponseType.plain,
          followRedirects: false,
          validateStatus: (_) => true,
        ),
      );
      return AicuProbeResponse(
        statusCode: response.statusCode ?? 0,
        body: response.data ?? '',
        retryAfter: response.headers.value('retry-after'),
      );
    } finally {
      client.close(force: true);
    }
  }
}
