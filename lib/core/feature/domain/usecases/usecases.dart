// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import 'package:employee_management/core/feature/domain/repositories/repositories.dart';
import 'package:employee_management/core/utils/utils.dart';

/// T must has .fromMap factory & toMap
class UseCase<T> {
  final Repository repository;
  final T instance;
  final String collectionName;

  UseCase({
    required this.repository,
    required this.instance,
    required this.collectionName,
  });

  Future<Either<Object, Stream<List<T>>>> getAll() async {
    return repository
        .getAll(
          collectionName,
        )
        .then((value) => value.map((r) => r.map(
            (event) => event.map((e) => getModel<T>(instance, e)).toList())));
  }

  Future<Either<Object, T?>> getById(String id) async {
    return repository
        .getById(collectionName, id)
        .then((value) => value.map((r) => getModel<T>(instance, r)));
  }

  Future<Either<Object, T?>> create(T item) async {
    return repository
        .create(collectionName, getJson(item))
        .then((value) => value.map((r) => getModel<T>(instance, r)));
  }

  Future<Either<Object, void>> update(T item) async {
    return repository.update(collectionName, getJson(item));
  }

  Future<Either<Object, void>> delete(String id) async {
    return repository.delete(collectionName, id);
  }
}
