import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:employee_management/core/app_router.dart';
import 'package:employee_management/export.dart';
import 'package:employee_management/features/auth/data/datasources/auth_data_source.dart';
import 'package:employee_management/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:employee_management/features/auth/domain/repositories/repositories.dart';
import 'package:employee_management/features/auth/domain/usecases/usecases.dart';
import 'package:employee_management/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:employee_management/features/employee/data/datasources/emp_firebase_data_source.dart';
import 'package:employee_management/features/employee/data/repositories/emp_repository_impl.dart';
import 'package:employee_management/features/employee/domain/repositories/repositories.dart';
import 'package:employee_management/features/employee/domain/usecases/usecases.dart';
import 'package:employee_management/features/employee/presentation/employee_cubit.dart';
import 'package:employee_management/features/post/domain/usecases/post.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

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
  sl.registerFactory(() => EmployeeCubit(employeeUseCase: sl()));

  // Usecases
  sl.registerLazySingleton(() => PostUsecases(sl()));
  sl.registerLazySingleton(() => AuthUseCase(repository: sl()));
  sl.registerLazySingleton(() => EmployeeUseCase(repository: sl()));

  // Repository
  sl.registerLazySingleton<PostsRepository>(
      () => PostsRepositoryImp(remoteDataSource: sl(), localDataSource: sl()));
  sl.registerLazySingleton<AuthRepository>(
      () => AuthRepoImp(remoteDataSource: sl()));
  sl.registerLazySingleton<EmpRepository>(
      () => EmpRepoImp(remoteDataSource: sl()));

  // Datasources
  sl.registerLazySingleton<BaseRequests>(
      () => BaseRequests(network: sl(), networkInfo: sl()));
  sl.registerLazySingleton<PostLocalDataSource>(
      () => PostLocalDataSourceImp(sharedPreferences: sl()));
  sl.registerLazySingleton<AuthFirebaseDataSource>(
      () => AuthFirebaseDataSourceImp(auth: sl()));
  sl.registerLazySingleton<EmpFirebaseDataSource>(
      () => EmpFirebaseDataSourceImp(auth: sl(), employeesCollection: sl()));

  //! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImp(sl()));
  sl.registerLazySingleton<Network>(() => Network());

  //! External
  sl.registerLazySingleton(() => GetStorage());
  sl.registerLazySingleton(() => FirebaseAuth.instance);
  sl.registerLazySingleton(
      () => FirebaseFirestore.instance.collection(employeeCollection));
  sl.registerLazySingleton(() => AppRouter());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
