// Dart imports:
import 'dart:async';

// Package imports:
import 'package:dio/dio.dart';

// Project imports:
import '../../error/all.dart';
import '../auth_provider.dart';
import '../response_code.dart';

class AuthInterceptor extends Interceptor {
  final AuthProvider authProvider;

  bool _isRefreshing = false;
  Completer<String?>? _refreshCompleter;

  AuthInterceptor(this.authProvider);

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await authProvider.getAccessToken();
    if (token == null) {
      return handler.reject(
        DioException(
          requestOptions: options,
          error: const MessageFailure('Missing token'),
        ),
      );
    }

    options.headers["Authorization"] = "Bearer $token";
    return handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final statusCode = ResponseCodeX.from(err.response?.statusCode);

    if (statusCode != ResponseCode.unauthorized) {
      return handler.next(err);
    }

    if (_isRefreshing) {
      try {
        final newToken = await _refreshCompleter?.future;
        if (newToken != null) {
          final retryRequest = await authProvider.retryRequest(
            err.requestOptions,
            newToken,
          );
          return handler.resolve(retryRequest);
        } else {
          authProvider.logout();
          return handler.next(
            err.copyWith(error: UnexpectedFailure('Missing token')),
          );
        }
      } catch (error) {
        authProvider.logout();
        return handler.next(err.copyWith(error: UnexpectedFailure(error)));
      }
    }

    _isRefreshing = true;
    _refreshCompleter = Completer();

    try {
      final newToken = await authProvider.refreshToken();

      if (!(_refreshCompleter?.isCompleted ?? true)) {
        _refreshCompleter?.complete(newToken);
      }

      if (newToken != null) {
        try {
          final retryRequest = await authProvider.retryRequest(
            err.requestOptions,
            newToken,
          );
          return handler.resolve(retryRequest);
        } catch (retryError) {
          authProvider.logout();
          return handler.next(
            err.copyWith(error: UnexpectedFailure(retryError)),
          );
        }
      } else {
        authProvider.logout();
        return handler.next(
          err.copyWith(error: UnexpectedFailure('Missing token')),
        );
      }
    } catch (error) {
      if (!(_refreshCompleter?.isCompleted ?? true)) {
        _refreshCompleter?.completeError(error);
      }
      authProvider.logout();
      return handler.next(err.copyWith(error: UnexpectedFailure(error)));
    } finally {
      _isRefreshing = false;
      _refreshCompleter = null;
    }
  }
}
