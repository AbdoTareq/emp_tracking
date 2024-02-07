import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:employee_management/core/feature/data/models/attendance_model.dart';
import 'package:employee_management/core/feature/data/models/client_model.dart';
import 'package:employee_management/core/location_manager.dart';
import 'package:employee_management/core/permission_manager.dart';
import 'package:employee_management/features/attendance/domain/usecases/usecases.dart';
import 'package:employee_management/features/attendance/presentation/cubit.dart';
import 'package:employee_management/features/clients/domain/usecases/usecases.dart';
import 'package:employee_management/features/clients/presentation/cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../export.dart';
import '../features/auth/data/datasources/auth_data_source.dart';
import '../features/auth/data/repositories/auth_repository_impl.dart';
import '../features/auth/domain/repositories/repositories.dart';
import '../features/auth/domain/usecases/usecases.dart';
import '../features/auth/presentation/cubit/auth_cubit.dart';
import '../features/employee/domain/usecases/usecases.dart';
import '../features/employee/presentation/employee_cubit.dart';
import '../features/materials/domain/usecases/usecases.dart';
import '../features/materials/presentation/material_cubit.dart';
import 'app_router.dart';
import 'feature/data/datasources/firebase_data_source.dart';
import 'feature/data/models/employee_model.dart';
import 'feature/data/models/material_model.dart';
import 'feature/data/repositories/repository_imp.dart';
import 'feature/domain/repositories/repositories.dart';
import 'network/network_info.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Bloc
  sl.registerFactory(() => AuthCubit(useCase: sl()));
  sl.registerFactory(() => EmployeeCubit(useCase: sl()));
  sl.registerFactory(() => MaterialCubit(usecase: sl()));
  sl.registerFactory(() => ClientCubit(usecase: sl()));
  sl.registerFactory(
      () => AttendanceCubit(usecase: sl(), locationManager: sl()));

  // Usecases
  sl.registerLazySingleton(() => AuthUseCase(repository: sl()));
  sl.registerLazySingleton(() => EmployeeUseCase(
        repository: sl(),
        instance: EmployeeModel(),
        collectionName: employeeCollection,
      ));
  sl.registerLazySingleton(() => MaterialUseCase(
        repository: sl(),
        instance: MaterialModel(),
        collectionName: materialCollection,
      ));
  sl.registerLazySingleton(() => ClientUseCase(
        repository: sl(),
        instance: ClientModel(),
        collectionName: clientCollection,
      ));
  sl.registerLazySingleton(() => AttendanceUseCase(
        repository: sl(),
        instance: AttendanceModel(),
        collectionName: attendanceCollection,
      ));

  // Repository
  sl.registerLazySingleton<AuthRepository>(
      () => AuthRepoImp(remoteDataSource: sl()));
  sl.registerLazySingleton<Repository>(() => RepoImp(remoteDataSource: sl()));

  // Datasources
  sl.registerLazySingleton<AuthFirebaseDataSource>(
      () => AuthFirebaseDataSourceImp(auth: sl()));
  //register multi
  sl.registerFactory<FirebaseDataSource>(
      () => FirebaseDataSourceImp(auth: sl(), firestore: sl()));

  //! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImp(sl()));

  //! External
  sl.registerLazySingleton(() => GetStorage());
  sl.registerLazySingleton(() => FirebaseAuth.instance);
  sl.registerLazySingleton(() => FirebaseFirestore.instance);
  sl.registerLazySingleton(() => AppRouter());
  sl.registerLazySingleton(() => InternetConnectionChecker());
  sl.registerLazySingleton(() => LocationManager(permissionManager: sl()));
  sl.registerLazySingleton(() => PermissionManager());
}
