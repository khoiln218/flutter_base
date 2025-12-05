// Package imports:
import 'package:dio/dio.dart';

abstract class AuthProvider {
  Future<Response<dynamic>> retryRequest(
    RequestOptions requestOptions,
    String accessToken,
  );

  Future<String?> getAccessToken();

  Future<String?> refreshToken();

  void logout();
}
