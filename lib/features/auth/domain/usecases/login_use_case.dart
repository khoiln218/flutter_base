// Package imports:
import 'package:dartz/dartz.dart';

// Project imports:
import '../../../../core/error/failure.dart';
import '../entities/user_entity.dart';
import '../repo/auth_repo.dart';

class Login {
  final AuthRepo _repo;

  Login(this._repo);

  Future<Either<Failure, User>> call(LoginParams params) async {
    return await _repo.login(params.username, params.password);
  }
}

class LoginParams {
  final String username;
  final String password;
  LoginParams(this.username, this.password);
}
