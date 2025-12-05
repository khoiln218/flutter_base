// Package imports:
import 'package:dio/dio.dart';

// Project imports:
import '../../error/server_failure.dart';

class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final statusCode = err.response?.statusCode;
    final message = err.response?.statusMessage;
    final responseData = err.response?.data;

    final appException = ServerFailure(
      message,
      code: statusCode,
      response: responseData,
    );

    return handler.next(err.copyWith(error: appException));
  }
}
