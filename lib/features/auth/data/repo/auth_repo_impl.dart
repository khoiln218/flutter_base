// Package imports:
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

// Project imports:
import '../../../../core/error/all.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repo/auth_repo.dart';
import '../datasources/local/auth_local_data_source.dart';
import '../datasources/remote/auth_remote_data_source.dart';
import '../models/sign_in_response.dart';

class AuthRepoImpl implements AuthRepo {
  final AuthRemoteDataSource remote;
  final AuthLocalDataSource local;

  AuthRepoImpl(this.remote, this.local);

  @override
  Future<Either<Failure, User>> login(String username, String password) async {
    try {
      final signInResponse = await remote.login({
        "username": username,
        "password": password,
        "expiresInMins": 5,
      });
      saveSession(signInResponse);
      return Right(signInResponse.toEntity());
    } catch (e) {
      if (e is DioException && e.error is Failure) {
        return Left(e.error as Failure);
      }
      return Left(UnexpectedFailure(e));
    }
  }

  @override
  Future<Either<Failure, SignInResponse>> refreshToken() async {
    try {
      final sessionEither = await getSession();

      return await sessionEither.fold((failure) async => Left(failure), (
        session,
      ) async {
        final newSession = await remote.refresh({
          "refreshToken": session.refreshToken,
        });

        await local.saveSession(newSession);
        return Right(newSession);
      });
    } catch (e) {
      if (e is DioException && e.error is Failure) {
        return Left(e.error as Failure);
      }
      return Left(UnexpectedFailure(e));
    }
  }

  @override
  Future<Either<Failure, SignInResponse>> getSession() => local.getSession();

  @override
  Future<Either<Failure, bool>> saveSession(SignInResponse session) =>
      local.saveSession(session);

  @override
  Future<Either<Failure, bool>> logout() => local.clearSession();
}
