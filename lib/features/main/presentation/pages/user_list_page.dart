// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import '../../../../core/paging/widgets/paging_list_view.dart';
import '../../../../core/utils/mixin/lifecycle_logger.dart';
import '../blocs/user_list_cubit/user_list_cubit.dart';

class UserListPage extends StatefulWidget {
  const UserListPage({super.key});

  @override
  State<UserListPage> createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage>
    with StatefulLifecycleLogger {
  late final UserListCubit cubit;

  @override
  void initState() {
    cubit = context.read<UserListCubit>()..refresh();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Users")),
      body: PagingListView<String>(
        cubit: cubit,
        itemBuilder: (item) => ListTile(title: Text(item)),
        emptyWidget: const Center(child: Text("List is empty")),
        endWidget: const Center(child: Text("🎉 You've reached the end")),
      ),
    );
  }
}
