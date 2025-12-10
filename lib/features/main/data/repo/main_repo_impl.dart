// Package imports:
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

// Project imports:
import '../../../../core/error/all.dart';
import '../../../auth/domain/entities/user_entity.dart';
import '../../domain/repo/main_repo.dart';
import '../datasources/remote/main_remote_data_source.dart';

class MainRepoImpl implements MainRepo {
  final MainRemoteDataSource remote;
  MainRepoImpl(this.remote);

  @override
  Future<Either<Failure, User>> getUserMe() async {
    try {
      final user = await remote.getUserMe();
      return Right(user.toEntity());
    } catch (e) {
      if (e is DioException && e.error is Failure) {
        return Left(e.error as Failure);
      }
      return Left(UnexpectedFailure(e));
    }
  }

  @override
  Future<Either<Failure, List<String>>> getUserList({
    required int page,
    required int limit,
  }) async {
    await Future.delayed(const Duration(seconds: 1));
    if (page > 3) return const Right([]);
    return Right(
      List.generate(limit, (i) => "Item ${(page - 1) * limit + i + 1}"),
    );
  }
}
