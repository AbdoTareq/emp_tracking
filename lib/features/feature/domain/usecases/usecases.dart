import 'package:dartz/dartz.dart';
import 'package:employee_management/features/materials/data/models/material_model.dart';

import '../repositories/repositories.dart';

class UseCase {
  final Repository repository;

  UseCase({required this.repository});

  Future<Either<Object, Stream<List<MaterialModel>>>> getAll() async {
    return repository.getAll().then((value) => value.map((r) =>
        r.map((event) => event.map((e) => MaterialModel.fromMap(e)).toList())));
  }

  Future<Either<Object, MaterialModel?>> getById(String id) async {
    return repository
        .getById(id)
        .then((value) => value.map((r) => MaterialModel.fromMap(r!)));
  }

  Future<Either<Object, MaterialModel?>> create(MaterialModel item) async {
    return repository
        .create(item.toMap())
        .then((value) => value.map((r) => MaterialModel.fromMap(r!)));
  }

  Future<Either<Object, void>> update(MaterialModel item) async {
    return repository.update(item.toMap(), item.id);
  }

  Future<Either<Object, void>> delete(String id) async {
    return repository.delete(id);
  }
}
