// Package imports:
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

// Project imports:
import '../../models/sign_in_response.dart';

part 'auth_remote_data_source.g.dart';

@RestApi()
abstract class AuthRemoteDataSource {
  factory AuthRemoteDataSource(Dio dio, {String baseUrl}) =
      _AuthRemoteDataSource;

  @POST("/auth/login")
  Future<SignInResponse> login(@Body() Map<String, dynamic> body);

  @POST("/auth/refresh")
  Future<SignInResponse> refresh(@Body() Map<String, dynamic> body);
}
