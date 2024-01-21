import 'package:dartz/dartz.dart';
import 'package:employee_management/features/materials/data/models/material_model.dart';

import '../repositories/repositories.dart';

class MaterialUseCase {
  final MaterialRepository repository;

  MaterialUseCase({required this.repository});

  Future<Either<Object, Stream<List<MaterialModel>>>> getAll() async {
    return repository.getAll();
  }

  Future<Either<Object, MaterialModel?>> getById(String id) async {
    return repository.getById(id);
  }

  Future<Either<Object, MaterialModel?>> create(MaterialModel item) async {
    return repository.create(item);
  }

  Future<Either<Object, void>> update(MaterialModel item) async {
    return repository.update(item, item.id);
  }

  Future<Either<Object, void>> delete(String id) async {
    return repository.delete(id);
  }
}
