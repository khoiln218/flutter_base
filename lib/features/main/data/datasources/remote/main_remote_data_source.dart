// Package imports:
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

// Project imports:
import '../../../../auth/data/models/user_model.dart';

part 'main_remote_data_source.g.dart';

@RestApi()
abstract class MainRemoteDataSource {
  factory MainRemoteDataSource(Dio dio, {String baseUrl}) =
      _MainRemoteDataSource;

  @GET("/user/me")
  Future<UserModel> getUserMe();
}
