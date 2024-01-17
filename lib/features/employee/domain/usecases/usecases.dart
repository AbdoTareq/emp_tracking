import 'package:dartz/dartz.dart';
import 'package:employee_management/features/employee/data/models/employee_model.dart';

import '../repositories/repositories.dart';

class EmployeeUseCase {
  final EmpRepository repository;

  EmployeeUseCase({required this.repository});

  Future<Either<Object, Stream<List<EmployeeModel>>>> getAll() async {
    return repository.getAll();
  }

  Future<Either<Object, EmployeeModel?>> create(EmployeeModel item) async {
    return repository.create(item);
  }

  Future<Either<Object, void>> update(EmployeeModel item) async {
    return repository.update(item, item.id);
  }

  Future<Either<Object, void>> delete(String id) async {
    return repository.delete(id);
  }
}
