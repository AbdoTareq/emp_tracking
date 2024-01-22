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
import 'package:employee_management/features/feature/data/datasources/firebase_data_source.dart';
import 'package:employee_management/features/feature/data/repositories/repository_imp.dart';
import 'package:employee_management/features/feature/domain/repositories/repositories.dart';
import 'package:employee_management/features/feature/domain/usecases/usecases.dart';
import 'package:employee_management/features/materials/data/datasources/material_firebase_data_source.dart';
import 'package:employee_management/features/materials/data/models/material_model.dart';
import 'package:employee_management/features/materials/data/repositories/material_repository_impl.dart';
import 'package:employee_management/features/materials/domain/repositories/repositories.dart';
import 'package:employee_management/features/materials/domain/usecases/usecases.dart';
import 'package:employee_management/features/materials/presentation/material_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'network/network_info.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Bloc
  sl.registerFactory(() => AuthCubit(authUseCase: sl()));
  sl.registerFactory(() => EmployeeCubit(employeeUseCase: sl()));
  sl.registerFactory(() => MaterialCubit(usecase: sl()));

  // Usecases
  sl.registerLazySingleton(() => AuthUseCase(repository: sl()));
  sl.registerLazySingleton(() => EmployeeUseCase(repository: sl()));
  sl.registerLazySingleton(() => MaterialUseCase(repository: sl()));
  sl.registerLazySingleton(() => UseCase(repository: sl()));

  // Repository
  sl.registerLazySingleton<AuthRepository>(
      () => AuthRepoImp(remoteDataSource: sl()));
  sl.registerLazySingleton<EmpRepository>(
      () => EmpRepoImp(remoteDataSource: sl()));
  sl.registerLazySingleton<MaterialRepository>(
      () => MaterialRepoImp(remoteDataSource: sl()));
  sl.registerLazySingleton<Repository>(() => RepoImp(remoteDataSource: sl()));

  // Datasources
  sl.registerLazySingleton<AuthFirebaseDataSource>(
      () => AuthFirebaseDataSourceImp(auth: sl()));
  sl.registerLazySingleton<EmpFirebaseDataSource>(
      () => EmpFirebaseDataSourceImp(auth: sl(), firebase: sl()));
  sl.registerLazySingleton<MaterialFirebaseDataSource>(
      () => MaterialFirebaseDataSourceImp(auth: sl(), firestore: sl()));
  sl.registerLazySingleton<FirebaseDataSource>(() => FirebaseDataSourceImp(
      auth: sl(), firestore: sl(), collectionName: materialCollection));

  //! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImp(sl()));

  //! External
  sl.registerLazySingleton(() => GetStorage());
  sl.registerLazySingleton(() => FirebaseAuth.instance);
  sl.registerLazySingleton(() => FirebaseFirestore.instance);
  sl.registerLazySingleton(() => AppRouter());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
