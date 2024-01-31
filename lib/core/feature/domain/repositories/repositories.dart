import '../../../../export.dart';

abstract class Repository {
  Future<Either<Object, Stream<List<Map>>>> getAll(
    String collectionName,
  );
  Future<Either<Object, Map?>> create(String collectionName, Map item);
  Future<Either<Object, Map?>> getById(String collectionName, String id);
  Future<Either<Object, void>> update(String collectionName, Map item);
  Future<Either<Object, void>> delete(String collectionName, String itemId);
}
