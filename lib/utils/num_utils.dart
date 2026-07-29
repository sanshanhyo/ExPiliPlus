import 'dart:ui' show Locale, PlatformDispatcher;

import 'package:ex_piliplus/utils/extension/num_ext.dart';
import 'package:flutter/foundation.dart' show kDebugMode, debugPrint;
import 'package:get/get.dart';

abstract final class NumUtils {
  static final _numRegExp = RegExp(
    r'([\d.]+)([千万萬亿億KMBT])?',
    caseSensitive: false,
  );

  static int _getUnit(String? unit) {
    switch (unit) {
      case '千':
        return 1000;
      case '万' || '萬':
        return 10000;
      case '亿' || '億':
        return 100000000;
      case 'K' || 'k':
        return 1000;
      case 'M' || 'm':
        return 1000000;
      case 'B' || 'b':
        return 1000000000;
      case 'T' || 't':
        return 1000000000000;
      default:
        return 1;
    }
  }

  static int parseNum(String numberStr) {
    if (numberStr == '-') return 0;
    try {
      final match = _numRegExp.firstMatch(numberStr)!;
      var number = double.parse(match.group(1)!);
      number *= _getUnit(match.group(2));
      return number.toInt();
    } catch (e) {
      if (kDebugMode) debugPrint('parse failed: "$numberStr" : $e');
      return 0;
    }
  }

  static String numFormat(dynamic number, {Locale? locale}) {
    if (number == null) {
      return '0';
    }
    if (number is String) {
      number = int.tryParse(number) ?? number;
      if (number is String) {
        return number;
      }
    }

    String format(first, second) {
      double result = ((number / first) as double).toPrecision(1);
      int intRes = result.toInt();
      if (result == intRes) {
        return '$intRes$second';
      } else {
        return '$result$second';
      }
    }

    final effectiveLocale =
        locale ?? Get.locale ?? PlatformDispatcher.instance.locale;
    if (effectiveLocale.languageCode != 'en') {
      final isTraditional =
          effectiveLocale.scriptCode == 'Hant' ||
          const {'HK', 'MO', 'TW'}.contains(effectiveLocale.countryCode);
      if (number >= 100000000) {
        return format(100000000, isTraditional ? '億' : '亿');
      } else if (number >= 10000) {
        return format(10000, isTraditional ? '萬' : '万');
      }
    } else if (number >= 1000000000000) {
      return format(1000000000000, 'T');
    } else if (number >= 1000000000) {
      return format(1000000000, 'B');
    } else if (number >= 1000000) {
      return format(1000000, 'M');
    } else if (number >= 1000) {
      return format(1000, 'K');
    } else {
      return number.toString();
    }

    return number.toString();
  }

  static String formatPositiveDecimal(int number) {
    if (number < 1000) return number.toString();

    final numStr = number.toString();
    final length = numStr.length;
    final sb = StringBuffer();

    int firstLength = length % 3;
    if (firstLength == 0) firstLength = 3;

    sb.write(numStr.substring(0, firstLength));
    for (int i = firstLength; i < length; i += 3) {
      sb
        ..write(',')
        ..write(numStr.substring(i, i + 3));
    }

    return sb.toString();
  }
}
