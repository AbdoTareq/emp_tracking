import 'package:dartz/dartz.dart';
import 'package:employee_management/core/feature/domain/repositories/repositories.dart';

import '../../../../core/error/failures.dart';
import '../datasources/firebase_data_source.dart';

class RepoImp implements Repository {
  final FirebaseDataSource remoteDataSource;

  RepoImp({required this.remoteDataSource});

  @override
  Future<Either<Object, Stream<List<Map>>>> getAll(
    String collectionName,
  ) async {
    try {
      final res = await remoteDataSource.getAll(
        collectionName,
      );
      return right(res);
    } on Exception catch (e) {
      return left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Object, Map?>> getById(String collectionName, String id) async {
    try {
      final res = await remoteDataSource.getById(collectionName, id);
      return right(res!);
    } on Exception catch (e) {
      return left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Object, Map?>> create(String collectionName, Map item) async {
    try {
      final res = await remoteDataSource.create(collectionName, item);
      return right(res);
    } on Exception catch (e) {
      return left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Object, void>> delete(
      String collectionName, String itemId) async {
    try {
      final res = await remoteDataSource.delete(collectionName, itemId);
      return right(res);
    } on Exception catch (e) {
      return left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Object, void>> update(String collectionName, Map item) async {
    try {
      final res = await remoteDataSource.update(collectionName, item);
      return right(res);
    } on Exception catch (e) {
      return left(ServerFailure(message: e.toString()));
    }
  }
}
