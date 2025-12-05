// Package imports:
import 'package:dio/dio.dart';

// Project imports:
import '../core/network/auth_provider.dart';
import '../features/auth/domain/repo/auth_repo.dart';
import '../features/auth/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'injection.dart';

class AuthProviderImpl implements AuthProvider {
  final Dio _dio;
  AuthProviderImpl(this._dio);

  @override
  Future<Response> retryRequest(
    RequestOptions requestOptions,
    String accessToken,
  ) {
    final options = Options(
      method: requestOptions.method,
      headers: {
        ...requestOptions.headers,
        "Authorization": "Bearer $accessToken",
      },
      contentType: requestOptions.contentType,
      responseType: requestOptions.responseType,
      followRedirects: requestOptions.followRedirects,
      validateStatus: requestOptions.validateStatus,
      extra: requestOptions.extra,
    );

    return _dio.request<dynamic>(
      requestOptions.path,
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
      options: options,
    );
  }

  @override
  Future<String?> getAccessToken() async {
    final result = await sl<AuthRepo>().getSession();
    return result.fold((_) => null, (s) => s.accessToken);
  }

  @override
  Future<String?> refreshToken() async {
    final result = await sl<AuthRepo>().refreshToken();
    return result.fold((_) => null, (auth) => auth.accessToken);
  }

  @override
  void logout() {
    sl<AuthBloc>().add(LogoutRequested());
  }
}
