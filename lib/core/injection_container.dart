import 'package:flutter_new_template/core/app_router.dart';
import 'package:flutter_new_template/export.dart';
import 'package:flutter_new_template/features/auth/domain/repositories/repositories.dart';
import 'package:flutter_new_template/features/auth/domain/usecases/usecases.dart';
import 'package:flutter_new_template/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:flutter_new_template/features/post/domain/usecases/post.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../features/auth/data/implements/implements.dart';
import '../features/post/data/datasources/post_local_data_source.dart';
import '../features/post/data/repositories/post_repository_impl.dart';
import '../features/post/domain/repositories/posts_repository.dart';
import '../features/post/presentation/bloc/add_delete_update_post/add_delete_update_post_bloc.dart';
import '../features/post/presentation/bloc/posts/posts_bloc.dart';
import 'network/network_info.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features - posts
  // Bloc
  sl.registerFactory(() => PostsBloc(postUseCases: sl()));
  sl.registerFactory(() => AddDeleteUpdatePostBloc(postUseCases: sl()));
  sl.registerFactory(() => AuthCubit(authUseCase: sl()));

  // Usecases
  sl.registerLazySingleton(() => PostUsecases(sl()));
  sl.registerLazySingleton(() => AuthUseCase(repository: sl()));

  // Repository
  sl.registerLazySingleton<PostsRepository>(
      () => PostsRepositoryImpl(remoteDataSource: sl(), localDataSource: sl()));
  sl.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImp(remoteDataSource: sl()));

  // Datasources
  sl.registerLazySingleton<BaseRequests>(
      () => BaseRequests(network: sl(), networkInfo: sl()));
  sl.registerLazySingleton<PostLocalDataSource>(
      () => PostLocalDataSourceImpl(sharedPreferences: sl()));

  //! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  sl.registerLazySingleton<Network>(() => Network());

  //! External
  sl.registerLazySingleton(() => GetStorage());
  sl.registerLazySingleton(() => AppRouter());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
