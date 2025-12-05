// Package imports:
import 'package:equatable/equatable.dart';

enum LoadStatus { initial, loading, success, failure }

class PagingState<T> extends Equatable {
  final List<T> items;
  final int page;
  final bool hasMore;
  final LoadStatus status;

  const PagingState({
    this.items = const [],
    this.page = 1,
    this.hasMore = true,
    this.status = LoadStatus.initial,
  });

  PagingState<T> copyWith({
    List<T>? items,
    int? page,
    bool? hasMore,
    LoadStatus? status,
  }) {
    return PagingState<T>(
      items: items ?? this.items,
      page: page ?? this.page,
      hasMore: hasMore ?? this.hasMore,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [items, page, hasMore, status];
}
