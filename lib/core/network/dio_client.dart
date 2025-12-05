// Flutter imports:
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:dio/dio.dart';

// Project imports:
import 'auth_provider.dart';
import 'interceptors/auth_interceptor.dart';
import 'interceptors/debug_interceptor.dart';
import 'interceptors/error_interceptor.dart';

class DioClient {
  static Dio create(String baseUrl, AuthProvider authProvider) {
    final dio = Dio(BaseOptions(baseUrl: baseUrl));

    dio.interceptors.addAll([
      ErrorInterceptor(),
      AuthInterceptor(authProvider),
      if (kDebugMode) DebugInterceptor(),
    ]);
    return dio;
  }

  static Dio createAuthDio(String baseUrl) {
    final dio = Dio(BaseOptions(baseUrl: baseUrl));

    dio.interceptors.addAll([
      ErrorInterceptor(),
      if (kDebugMode) DebugInterceptor(),
    ]);
    return dio;
  }
}
