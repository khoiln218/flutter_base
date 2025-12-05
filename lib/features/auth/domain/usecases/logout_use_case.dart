// Package imports:
import 'package:dartz/dartz.dart';

// Project imports:
import '../../../../core/error/failure.dart';
import '../repo/auth_repo.dart';

class Logout {
  final AuthRepo _repo;

  Logout(this._repo);

  Future<Either<Failure, bool>> call() async => await _repo.logout();
}
