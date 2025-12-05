// Project imports:
import '../../../../../core/paging/cubit/paging_cubit.dart';
import '../../../domain/usecases/get_user_list_use_case.dart';

class UserListCubit extends PagingCubit<String> {
  static const limit = 20;
  final GetUserList getUserListUseCase;

  UserListCubit(this.getUserListUseCase)
    : super(
        fetchPage: (page) async {
          return await getUserListUseCase(
            UserListParams(page: page, limit: limit),
          );
        },
      );
}
