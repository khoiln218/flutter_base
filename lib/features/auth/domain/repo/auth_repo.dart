// Package imports:
import 'package:dartz/dartz.dart';

// Project imports:
import '../../../../core/error/failure.dart';
import '../../data/models/sign_in_response.dart';
import '../entities/user_entity.dart';

abstract class AuthRepo {
  Future<Either<Failure, User>> login(String username, String password);
  Future<Either<Failure, SignInResponse>> refreshToken();

  Future<Either<Failure, bool>> saveSession(SignInResponse session);
  Future<Either<Failure, SignInResponse>> getSession();
  Future<Either<Failure, bool>> logout();
}
