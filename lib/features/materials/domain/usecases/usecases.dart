import 'package:employee_management/features/feature/domain/usecases/usecases.dart';
import 'package:employee_management/features/materials/data/models/material_model.dart';

class MaterialUseCase extends UseCase<MaterialModel> {
  MaterialUseCase(
      {required super.repository,
      required super.instance,
      required super.collectionName});
}
