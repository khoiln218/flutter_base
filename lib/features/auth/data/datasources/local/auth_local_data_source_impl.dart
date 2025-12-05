// Dart imports:
import 'dart:convert';

// Package imports:
import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Project imports:
import '../../../../../core/error/all.dart';
import '../../models/sign_in_response.dart';
import 'auth_local_data_source.dart';

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final SharedPreferences prefs;
  static const _key = "user_session";

  AuthLocalDataSourceImpl(this.prefs);

  @override
  Future<Either<Failure, bool>> saveSession(SignInResponse session) async {
    try {
      final str = jsonEncode(session.toJson());
      final isSuccess = await prefs.setString(_key, str);
      if (isSuccess) {
        return Right(true);
      } else {
        return Left(UnknownFailure());
      }
    } catch (error) {
      return Left(UnexpectedFailure(error));
    }
  }

  @override
  Future<Either<Failure, SignInResponse>> getSession() async {
    try {
      final str = prefs.getString(_key);
      if (str == null) return Left(UnknownFailure());
      final map = jsonDecode(str) as Map<String, dynamic>;
      final session = SignInResponse.fromJson(map);
      return Right(session);
    } catch (error) {
      return Left(UnexpectedFailure(error));
    }
  }

  @override
  Future<Either<Failure, bool>> clearSession() async {
    try {
      final isSuccess = await prefs.remove(_key);
      if (isSuccess) return Right(true);
    } catch (error) {
      return Left(UnexpectedFailure(error));
    }
    return Left(UnknownFailure());
  }
}
