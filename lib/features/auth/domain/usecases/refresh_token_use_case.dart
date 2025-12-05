// Package imports:
import 'package:dartz/dartz.dart';

// Project imports:
import '../../../../core/error/failure.dart';
import '../../data/models/sign_in_response.dart';
import '../repo/auth_repo.dart';

class RefreshToken {
  final AuthRepo _repo;

  RefreshToken(this._repo);

  Future<Either<Failure, SignInResponse>> call() async =>
      await _repo.refreshToken();
}
