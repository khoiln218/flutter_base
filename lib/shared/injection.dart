// Package imports:
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Project imports:
import '../core/network/dio_client.dart';
import '../features/auth/data/datasources/local/auth_local_data_source.dart';
import '../features/auth/data/datasources/local/auth_local_data_source_impl.dart';
import '../features/auth/data/datasources/remote/auth_remote_data_source.dart';
import '../features/auth/data/repo/auth_repo_impl.dart';
import '../features/auth/domain/repo/auth_repo.dart';
import '../features/auth/domain/usecases/get_profile_use_case.dart';
import '../features/auth/domain/usecases/login_use_case.dart';
import '../features/auth/domain/usecases/logout_use_case.dart';
import '../features/auth/domain/usecases/refresh_token_use_case.dart';
import '../features/auth/presentation/blocs/auth_bloc/auth_bloc.dart';
import '../features/auth/presentation/blocs/login_bloc/login_bloc.dart';
import '../features/auth/presentation/blocs/password_visibility_cubit/password_visibility_cubit.dart';
import '../features/main/data/datasources/remote/main_remote_data_source.dart';
import '../features/main/data/repo/main_repo_impl.dart';
import '../features/main/domain/repo/main_repo.dart';
import '../features/main/domain/usecases/get_user_list_use_case.dart';
import '../features/main/presentation/blocs/main_bloc/main_bloc.dart';
import '../features/main/presentation/blocs/user_list_cubit/user_list_cubit.dart';
import '../resources/app_config.dart';
import 'app_router.dart';
import 'auth_provider_impl.dart';

final sl = GetIt.instance;

Future<void> init({required Flavor flavor}) async {
  // Register Environment
  sl.registerSingleton<Environment>(AppConfig.load(flavor));

  // App Router
  sl.registerLazySingleton(() => AppRouter());

  // Dio
  final dioAuth = DioClient.createAuthDio(sl<Environment>().baseUrl);
  sl.registerLazySingleton(
    () =>
        DioClient.create(sl<Environment>().baseUrl, AuthProviderImpl(dioAuth)),
  );

  // SharedPreferences
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);

  // Data sources
  sl.registerLazySingleton(() => AuthRemoteDataSource(dioAuth));
  sl.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(sl()),
  );
  sl.registerLazySingleton(() => MainRemoteDataSource(sl()));

  // Repository
  sl.registerLazySingleton<AuthRepo>(() => AuthRepoImpl(sl(), sl()));
  sl.registerLazySingleton<MainRepo>(() => MainRepoImpl(sl()));

  // Usecases
  sl.registerLazySingleton(() => Login(sl()));
  sl.registerLazySingleton(() => Logout(sl()));
  sl.registerLazySingleton(() => RefreshToken(sl()));
  sl.registerLazySingleton(() => GetProfile(sl()));
  sl.registerLazySingleton(() => GetUserList(sl()));

  // Bloc
  sl.registerLazySingleton(() => AuthBloc(sl(), sl()));
  sl.registerFactory(() => LoginBloc(sl()));
  sl.registerFactory(() => PasswordVisibilityCubit());
  sl.registerFactory(() => MainBloc());
  sl.registerFactory(() => UserListCubit(sl()));
}
