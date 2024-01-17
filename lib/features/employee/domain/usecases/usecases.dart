import 'package:dartz/dartz.dart';
import 'package:employee_management/features/employee/data/models/employee_model.dart';

import '../repositories/repositories.dart';

class EmployeeUseCase {
  final EmpRepository repository;

  EmployeeUseCase({required this.repository});

  Future<Either<Object, Stream<List<EmployeeModel>>>> execute() async {
    return repository.getAll();
  }
}
