// Package imports:
import 'package:dartz/dartz.dart';

// Project imports:
import '../../../../../core/error/failure.dart';
import '../../models/sign_in_response.dart';

abstract class AuthLocalDataSource {
  Future<Either<Failure, bool>> saveSession(SignInResponse session);
  Future<Either<Failure, SignInResponse>> getSession();
  Future<Either<Failure, bool>> clearSession();
}
