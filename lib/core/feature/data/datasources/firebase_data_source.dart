import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class FirebaseDataSource {
  Future<Stream<List<Map<String, dynamic>>>> getAll(String collectionName);
  Future<Map<String, dynamic>?> getById(String collectionName, String id);
  Future<Map<String, dynamic>?> create(String collectionName, Map item);
  Future<void> update(String collectionName, Map item);
  Future<void> delete(String collectionName, String itemId);
}

class FirebaseDataSourceImp implements FirebaseDataSource {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;

  FirebaseDataSourceImp({
    required this.auth,
    required this.firestore,
  });

  @override
  Future<Stream<List<Map<String, dynamic>>>> getAll(
      String collectionName) async {
    try {
      final snapshots = (firestore.collection(collectionName).snapshots()).map(
          (event) => event.docs.map((e) => {...e.data(), 'id': e.id}).toList());
      return snapshots;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>?> getById(
      String collectionName, String? itemId) async {
    try {
      final res = await firestore.collection(collectionName).doc(itemId).get();
      return res.data();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>?> create(String collectionName, Map item) async {
    try {
      final res = await firestore
          .collection(collectionName)
          .add({...item, 'companyId': auth.currentUser!.uid});
      return (await res.get()).data();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> delete(String collectionName, String itemId) async {
    try {
      final res =
          await firestore.collection(collectionName).doc(itemId).delete();
      return res;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> update(String collectionName, Map item) async {
    try {
      final res = await firestore
          .collection(collectionName)
          .doc(item['id'])
          .update({...item});
      return res;
    } catch (e) {
      rethrow;
    }
  }
}
