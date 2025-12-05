// Package imports:
import 'package:dartz/dartz.dart';

// Project imports:
import '../../../../core/error/failure.dart';
import '../repo/main_repo.dart';

class GetUserList {
  final MainRepo _repo;

  GetUserList(this._repo);

  Future<Either<Failure, List<String>>> call(UserListParams params) =>
      _repo.getUserList(page: params.page, limit: params.limit);
}

class UserListParams {
  final int page;
  final int limit;

  UserListParams({required this.page, required this.limit});
}
