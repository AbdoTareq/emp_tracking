import '../../../../core/feature/domain/usecases/usecases.dart';
import '../../../../core/feature/data/models/material_model.dart';

class MaterialUseCase extends UseCase<MaterialModel> {
  MaterialUseCase(
      {required super.repository,
      required super.instance,
      required super.collectionName});
}
