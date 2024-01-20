import 'package:dartz/dartz.dart';
import 'package:employee_management/core/utils/utils.dart';
import 'package:employee_management/features/employee/data/models/employee_model.dart';
import 'package:employee_management/features/employee/domain/repositories/repositories.dart';

import '../../../../core/error/failures.dart';
import '../datasources/emp_firebase_data_source.dart';

class EmpRepoImp implements EmpRepository {
  final EmpFirebaseDataSource remoteDataSource;

  EmpRepoImp({required this.remoteDataSource});

  @override
  Future<Either<Object, Stream<List<EmployeeModel>>>> getAll() async {
    try {
      final res = await remoteDataSource.getAllByCompanyId();
      return right(transformStream<EmployeeModel>(res, EmployeeModel()));
    } on Exception catch (e) {
      return left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Object, EmployeeModel?>> getById(String id) async {
    try {
      final res = await remoteDataSource.getById(id);
      return right(EmployeeModel.fromMap(res!));
    } on Exception catch (e) {
      return left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Object, EmployeeModel?>> create(EmployeeModel item) async {
    try {
      final res = await remoteDataSource.create(item);
      return right(EmployeeModel.fromMap(res!));
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
      EmployeeModel item, String? itemId) async {
    try {
      final res = await remoteDataSource.update(item, itemId);
      return right(res);
    } on Exception catch (e) {
      return left(ServerFailure(message: e.toString()));
    }
  }
}
