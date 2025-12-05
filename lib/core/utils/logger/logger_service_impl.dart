// Dart imports:
import 'dart:developer' as developer;

// Flutter imports:
import 'package:flutter/foundation.dart';

// Project imports:
import 'logger_service.dart';

final logger = LogServiceImpl();

class LogColor {
  static const reset = '\x1B[0m';
  static const red = '\x1B[91m';
  static const green = '\x1B[92m';
  static const yellow = '\x1B[93m';
  static const blue = '\x1B[94m';
  static const magenta = '\x1B[95m';
  static const cyan = '\x1B[96m';
  static const white = '\x1B[97m';
}

class LogServiceImpl extends LogService {
  void _printLog(
    String level,
    dynamic data, {
    dynamic stackTrace,
    dynamic arguments,
    required showFile,
    required showMethod,
  }) {
    if (kDebugMode) {
      final traceString = StackTrace.current.toString().split('\n')[2];
      final pattern = RegExp(r'#\d+\s+(.+?)\.(.+?) \((.+?):(\d+):(\d+)\)');
      final match = pattern.firstMatch(traceString);

      String fileName = 'Unknown';
      String methodName = 'Unknown';
      String line = '0';
      if (match != null) {
        methodName = match.group(2) ?? methodName;
        final fullPath = match.group(3) ?? fileName;
        fileName = fullPath.split('/').last.replaceAll('.dart', '');
        line = match.group(4) ?? line;
      }

      final filename = showFile
          ? showMethod
                ? '[$fileName:$line] '
                : '[$fileName:$line]'
          : '';
      final method = showMethod ? methodName : '';
      final header = '$filename$method:';
      String color;
      switch (level) {
        case 'INFO':
          color = LogColor.magenta;
          break;
        case 'WARN':
          color = LogColor.yellow;
          break;
        case 'ERROR':
          color = LogColor.red;
          break;
        default:
          color = LogColor.green;
      }

      final rawMessage = '$data'.replaceAll('\n', '${LogColor.reset}\n$color');
      developer.log(
        '$header $color$rawMessage${LogColor.reset}',
        name: "flutter",
      );
    }
  }

  @override
  void d(
    dynamic data, {
    dynamic stackTrace,
    dynamic arguments,
    bool showFile = true,
    bool showMethod = true,
  }) {
    _printLog(
      'LOG',
      data,
      stackTrace: stackTrace,
      arguments: arguments,
      showFile: showFile,
      showMethod: showMethod,
    );
  }

  @override
  void i(
    dynamic data, {
    dynamic stackTrace,
    dynamic arguments,
    bool showFile = true,
    bool showMethod = true,
  }) {
    _printLog(
      'INFO',
      data,
      stackTrace: stackTrace,
      arguments: arguments,
      showFile: showFile,
      showMethod: showMethod,
    );
  }

  @override
  void w(
    dynamic data, {
    dynamic stackTrace,
    dynamic arguments,
    bool showFile = true,
    bool showMethod = true,
  }) {
    _printLog(
      'WARN',
      data,
      stackTrace: stackTrace,
      arguments: arguments,
      showFile: showFile,
      showMethod: showMethod,
    );
  }

  @override
  void e(
    Object error, {
    dynamic stackTrace,
    dynamic arguments,
    bool showFile = true,
    bool showMethod = true,
  }) {
    _printLog(
      'ERROR',
      error,
      stackTrace: stackTrace,
      arguments: arguments,
      showFile: showFile,
      showMethod: showMethod,
    );
  }
}
