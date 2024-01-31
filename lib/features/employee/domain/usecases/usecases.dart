import '../../data/models/employee_model.dart';
import '../../../feature/domain/usecases/usecases.dart';

class EmployeeUseCase extends UseCase<EmployeeModel> {
  EmployeeUseCase(
      {required super.repository,
      required super.instance,
      required super.collectionName});
}
