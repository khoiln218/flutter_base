// Package imports:
import 'package:dartz/dartz.dart';

// Project imports:
import '../../../../core/error/failure.dart';
import '../../../auth/domain/entities/user_entity.dart';

abstract class MainRepo {
  Future<Either<Failure, User>> getUserMe();
  Future<Either<Failure, List<String>>> getUserList({
    required int page,
    required int limit,
  });
}
