// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import '../cubit/paging_cubit.dart';
import '../cubit/paging_state.dart';

class PagingListView<T> extends StatelessWidget {
  final PagingCubit<T> cubit;
  final Widget Function(T item) itemBuilder;
  final Widget? emptyWidget;
  final Widget? endWidget;

  const PagingListView({
    super.key,
    required this.cubit,
    required this.itemBuilder,
    this.emptyWidget,
    this.endWidget,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PagingCubit<T>, PagingState<T>>(
      bloc: cubit,
      builder: (context, state) {
        if (state.status == LoadStatus.loading && state.items.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.status == LoadStatus.failure && state.items.isEmpty) {
          return const Center(child: Text("Load failed"));
        }

        if (state.items.isEmpty) {
          return emptyWidget ?? const Center(child: Text("No data"));
        }

        return RefreshIndicator(
          onRefresh: () => cubit.refresh(),
          child: ListView.builder(
            itemCount: state.items.length + 1,
            itemBuilder: (context, index) {
              if (index < state.items.length) {
                return itemBuilder(state.items[index]);
              }

              // last item -> check trạng thái loadmore
              if (state.status == LoadStatus.loading) {
                return const Padding(
                  padding: EdgeInsets.all(16),
                  child: Center(child: CircularProgressIndicator()),
                );
              }

              if (!state.hasMore) {
                return endWidget ??
                    const Padding(
                      padding: EdgeInsets.all(16),
                      child: Center(child: Text("No more data")),
                    );
              }

              // trigger load more
              cubit.loadMore();
              return const Padding(
                padding: EdgeInsets.all(16),
                child: Center(child: CircularProgressIndicator()),
              );
            },
          ),
        );
      },
    );
  }
}
