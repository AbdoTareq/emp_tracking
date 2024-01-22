import 'package:dartz/dartz.dart';
import 'package:employee_management/core/utils/utils.dart';
import 'package:employee_management/features/feature/domain/repositories/repositories.dart';

import '../../../../core/error/failures.dart';
import '../datasources/firebase_data_source.dart';

class RepoImp implements Repository {
  final FirebaseDataSource remoteDataSource;

  RepoImp({required this.remoteDataSource});

  @override
  Future<Either<Object, Stream<List<Map>>>> getAll() async {
    try {
      final res = await remoteDataSource.getAll();
      return right(transformStream<Map>(res, Map()));
    } on Exception catch (e) {
      return left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Object, Map?>> getById(String id) async {
    try {
      final res = await remoteDataSource.getById(id);
      return right(res!);
    } on Exception catch (e) {
      return left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Object, Map?>> create(Map item) async {
    try {
      final res = await remoteDataSource.create(item);
      return right(res);
    } on Exception catch (e) {
      return left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Object, void>> delete(String itemId) async {
    try {
      final res = await remoteDataSource.delete(itemId);
      return right(res);
    } on Exception catch (e) {
      return left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Object, void>> update(Map item, String? itemId) async {
    try {
      final res = await remoteDataSource.update(item, itemId);
      return right(res);
    } on Exception catch (e) {
      return left(ServerFailure(message: e.toString()));
    }
  }
}
