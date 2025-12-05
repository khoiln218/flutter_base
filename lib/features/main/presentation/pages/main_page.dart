// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

// Project imports:
import '../../../../core/utils/mixin/lifecycle_logger.dart';
import '../../../../shared/app_router.dart';
import '../../../../shared/injection.dart';
import '../../../../shared/widgets/app_version.dart';
import '../../../auth/domain/entities/user_entity.dart';
import '../../../auth/presentation/blocs/auth_bloc/auth_bloc.dart';
import '../blocs/main_bloc/main_bloc.dart';

// Project imports:

class MainPage extends StatefulWidget {
  final User user;
  const MainPage({super.key, required this.user});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with StatefulLifecycleLogger {
  @override
  void initState() {
    context.read<MainBloc>().add(MainRequested());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home")),
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Xin chào ${widget.user.name}!"),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () {
                    context.pushNamed(Routes.userListPage);
                  },
                  child: Text('User Page List'),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () => sl<AuthBloc>().add(LogoutRequested()),
                  child: Text('Đăng xuất'),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Align(
              alignment: AlignmentGeometry.bottomCenter,
              child: AppVersion(),
            ),
          ),
        ],
      ),
    );
  }
}
