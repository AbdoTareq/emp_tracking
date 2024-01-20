import 'package:employee_management/features/employee/data/models/employee_model.dart';

import '../../../../export.dart';

abstract class EmpRepository {
  Future<Either<Object, Stream<List<EmployeeModel>>>> getAll();
  Future<Either<Object, EmployeeModel?>> create(EmployeeModel item);
  Future<Either<Object, EmployeeModel?>> getById(String id);
  Future<Either<Object, void>> update(EmployeeModel item, String? itemId);
  Future<Either<Object, void>> delete(String itemId);
}
