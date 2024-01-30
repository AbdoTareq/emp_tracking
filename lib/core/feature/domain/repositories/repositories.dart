import '../../../../export.dart';

abstract class Repository {
  Future<Either<Object, Stream<List<Map>>>> getAll();
  Future<Either<Object, Map?>> create(Map item);
  Future<Either<Object, Map?>> getById(String id);
  Future<Either<Object, void>> update(Map item, String? itemId);
  Future<Either<Object, void>> delete(String itemId);
}
