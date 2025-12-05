// Package imports:
import 'package:dartz/dartz.dart';

// Project imports:
import '../../../../core/error/failure.dart';
import '../../../main/domain/repo/main_repo.dart';
import '../entities/user_entity.dart';

class GetProfile {
  final MainRepo _repo;

  GetProfile(this._repo);

  Future<Either<Failure, User>> call() => _repo.getUserMe();
}
