import 'package:employee_management/features/materials/data/models/material_model.dart';

import '../../../../export.dart';

abstract class MaterialRepository {
  Future<Either<Object, Stream<List<MaterialModel>>>> getAll();
  Future<Either<Object, MaterialModel?>> create(MaterialModel item);
  Future<Either<Object, MaterialModel?>> getById(String id);
  Future<Either<Object, void>> update(MaterialModel item, String? itemId);
  Future<Either<Object, void>> delete(String itemId);
}
