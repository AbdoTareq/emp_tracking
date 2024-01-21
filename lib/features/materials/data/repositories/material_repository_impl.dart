import 'package:dartz/dartz.dart';
import 'package:employee_management/core/utils/utils.dart';
import 'package:employee_management/features/employee/domain/repositories/repositories.dart';
import 'package:employee_management/features/materials/data/models/material_model.dart';

import '../../../../core/error/failures.dart';
import '../datasources/material_firebase_data_source.dart';

class MaterialRepoImp implements MaterialRepository {
  final MaterialFirebaseDataSource remoteDataSource;

  MaterialRepoImp({required this.remoteDataSource});

  @override
  Future<Either<Object, Stream<List<MaterialModel>>>> getAll() async {
    try {
      final res = await remoteDataSource.getAllByCompanyId();
      return right(transformStream<MaterialModel>(res, MaterialModel()));
    } on Exception catch (e) {
      return left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Object, MaterialModel?>> getById(String id) async {
    try {
      final res = await remoteDataSource.getById(id);
      return right(MaterialModel.fromMap(res!));
    } on Exception catch (e) {
      return left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Object, MaterialModel?>> create(MaterialModel item) async {
    try {
      final res = await remoteDataSource.create(item);
      return right(MaterialModel.fromMap(res!));
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
  Future<Either<Object, void>> update(
      MaterialModel item, String? itemId) async {
    try {
      final res = await remoteDataSource.update(item, itemId);
      return right(res);
    } on Exception catch (e) {
      return left(ServerFailure(message: e.toString()));
    }
  }
}
