// Package imports:
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import '../../error/failure.dart';
import 'paging_state.dart';

typedef FetchPage<T> = Future<Either<Failure, List<T>>> Function(int page);

class PagingCubit<T> extends Cubit<PagingState<T>> {
  final FetchPage<T> fetchPage;

  PagingCubit({required this.fetchPage}) : super(PagingState<T>());

  Future<void> refresh() async {
    emit(state.copyWith(status: LoadStatus.loading, page: 1));

    final result = await fetchPage(1);
    result.fold(
      (fail) => emit(state.copyWith(status: LoadStatus.failure)),
      (items) => emit(
        state.copyWith(
          items: items,
          hasMore: items.isNotEmpty,
          page: 2,
          status: LoadStatus.success,
        ),
      ),
    );
  }

  Future<void> loadMore() async {
    if (!state.hasMore || state.status == LoadStatus.loading) return;

    emit(state.copyWith(status: LoadStatus.loading));

    final result = await fetchPage(state.page);
    result.fold(
      (fail) => emit(state.copyWith(status: LoadStatus.failure)),
      (items) => emit(
        state.copyWith(
          items: [...state.items, ...items],
          hasMore: items.isNotEmpty,
          page: state.page + 1,
          status: LoadStatus.success,
        ),
      ),
    );
  }
}
