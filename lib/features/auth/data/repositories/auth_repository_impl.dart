import 'package:dartz/dartz.dart';
import 'package:employee_management/features/auth/domain/repositories/repositories.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/error/failures.dart';
import '../datasources/auth_data_source.dart';

class AuthRepoImp implements AuthRepository {
  final AuthFirebaseDataSource remoteDataSource;

  AuthRepoImp({required this.remoteDataSource});

  @override
  Future<Either<Failure, User>> login(String email, String password) async {
    try {
      final res = await remoteDataSource.login(email, password);
      return res == null ? left(ServerFailure(message: 'no user')) : right(res);
    } on Exception catch (e) {
      return left(ServerFailure(message: e.toString()));
    }
  }
}
