import 'package:employee_management/features/employee/data/models/employee_model.dart';
import 'package:employee_management/features/feature/domain/usecases/usecases.dart';

class EmployeeUseCase extends UseCase<EmployeeModel> {
  EmployeeUseCase(
      {required super.repository,
      required super.instance,
      required super.collectionName});
}
