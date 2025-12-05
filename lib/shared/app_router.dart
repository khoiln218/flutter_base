// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

// Project imports:
import '../features/auth/presentation/blocs/auth_bloc/auth_bloc.dart';
import '../features/auth/presentation/blocs/login_bloc/login_bloc.dart';
import '../features/auth/presentation/blocs/password_visibility_cubit/password_visibility_cubit.dart';
import '../features/auth/presentation/pages/login_page.dart';
import '../features/main/presentation/blocs/main_bloc/main_bloc.dart';
import '../features/main/presentation/blocs/user_list_cubit/user_list_cubit.dart';
import '../features/main/presentation/pages/main_page.dart';
import '../features/main/presentation/pages/user_list_page.dart';
import '../features/splash/splash_page.dart';
import 'injection.dart';

// Project imports:

abstract class Routes {
  static const splash = '/';
  static const loginPage = '/login_page';
  static const mainPage = '/main_page';
  static const userListPage = '/user_list_page';
}

class AppRouter {
  final GoRouter router = GoRouter(
    initialLocation: Routes.splash,
    debugLogDiagnostics: true,
    refreshListenable: GoRouterRefreshStream(sl<AuthBloc>().stream),
    redirect: (context, state) {
      final authState = context.read<AuthBloc>().state;
      if (authState is AuthInitial) {
        return Routes.splash;
      } else if (authState is! Authenticated) {
        if (state.fullPath != Routes.loginPage) {
          return Routes.loginPage;
        }
      } else {
        if (state.fullPath == Routes.loginPage ||
            state.fullPath == Routes.splash) {
          return Routes.mainPage;
        }
      }
      return null;
    },
    routes: [
      GoRoute(
        name: Routes.splash,
        path: Routes.splash,
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        name: Routes.loginPage,
        path: Routes.loginPage,
        builder: (context, state) => buildRouteLogin(),
      ),
      GoRoute(
        name: Routes.mainPage,
        path: Routes.mainPage,
        builder: (context, state) {
          return buildRouteMain(context);
        },
      ),
      GoRoute(
        name: Routes.userListPage,
        path: Routes.userListPage,
        builder: (context, state) => buildRouteUserList(),
      ),
    ],
    errorBuilder: (context, state) {
      return Scaffold(
        body: Center(child: Text("Page not found: ${state.uri}")),
      );
    },
  );

  static Widget buildRouteMain(BuildContext context) {
    final authState = context.read<AuthBloc>().state;
    if (authState is Authenticated) {
      return BlocProvider(
        create: (_) => sl<MainBloc>(),
        child: MainPage(user: authState.user),
      );
    }
    return buildRouteLogin();
  }

  static Widget buildRouteUserList() {
    return BlocProvider(
      create: (_) => sl<UserListCubit>(),
      child: const UserListPage(),
    );
  }

  static Widget buildRouteLogin() {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<LoginBloc>()),
        BlocProvider(create: (_) => sl<PasswordVisibilityCubit>()),
      ],
      child: const LoginPage(),
    );
  }
}

class GoRouterRefreshStream extends ChangeNotifier {
  /// Creates a [GoRouterRefreshStream].
  ///
  /// Every time the [stream] receives an event the [GoRouter] will refresh its
  /// current route.
  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen(
      (dynamic _) => notifyListeners(),
    );
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
