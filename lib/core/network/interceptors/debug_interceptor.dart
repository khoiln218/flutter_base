// Dart imports:
import 'dart:convert';

// Package imports:
import 'package:dio/dio.dart';

// Project imports:
import '../../utils/logger/logger_service_impl.dart';

class DebugInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    String msg = '${options.method} -> ${options.uri}';
    msg += '\nheader: ${jsonEncode(options.headers)}';
    try {
      if (options.data != null) {
        if (options.data is FormData) {
          msg += '\ndata: ${formDataToJson(options.data)}';
        } else {
          msg += '\ndata: ${jsonEncode(options.data)}';
        }
      }
    } catch (e) {
      msg += '\ndata: ${options.data}';
    }
    _logi(msg);
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    String msg =
        '🌍 ${response.statusCode} ${response.requestOptions.method} <- ${response.requestOptions.uri}';
    if (response.data != null) {
      msg += '\nResponse Text: ${response.toString()}';
    }
    _logi(msg);
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode != 304) {
      String msg =
          '🌍 ${err.response?.statusCode} ${err.response?.requestOptions.method} <- ${err.requestOptions.uri}';
      if (err.response != null) {
        msg += '\nResponse Text: ${err.response.toString()}';
      }
      _loge(msg);
    }
    handler.next(err);
  }

  void _logi(String message) {
    logger.i(message, showMethod: false, showFile: false);
  }

  void _loge(String message) {
    logger.e(message, showMethod: false, showFile: false);
  }

  String formDataToJson(FormData formData) {
    final Map<String, dynamic> data = {};

    for (final field in formData.fields) {
      final key = field.key;
      final value = field.value;

      if (data.containsKey(key)) {
        if (data[key] is List) {
          data[key].add(value);
        } else {
          data[key] = [data[key], value];
        }
      } else {
        data[key] = value;
      }
    }

    for (final fileEntry in formData.files) {
      final key = fileEntry.key;
      final filename = fileEntry.value.filename ?? 'file';

      if (data.containsKey(key)) {
        if (data[key] is List) {
          data[key].add(filename);
        } else {
          data[key] = [data[key], filename];
        }
      } else {
        data[key] = filename;
      }
    }

    return jsonEncode(data);
  }
}
