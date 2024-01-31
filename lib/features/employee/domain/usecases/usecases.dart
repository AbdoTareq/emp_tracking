import 'package:employee_management/core/feature/data/models/employee_model.dart';

import '../../../../core/feature/domain/usecases/usecases.dart';

class EmployeeUseCase extends UseCase<EmployeeModel> {
  EmployeeUseCase(
      {required super.repository,
      required super.instance,
      required super.collectionName});
}
