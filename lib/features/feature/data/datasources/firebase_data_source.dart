import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:employee_management/core/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';

// company id is the adminId which is the logged in user
abstract class FirebaseDataSource<DataModel> {
  Future<Stream<QuerySnapshot<Map<String, dynamic>>>> getAll();
  Future<Map<String, dynamic>?> getById(String id);
  Future<Map<String, dynamic>?> create(DataModel item);
  Future<void> update(DataModel item, String? itemId);
  Future<void> delete(String itemId);
}

class FirebaseDataSourceImp<DataModel>
    implements FirebaseDataSource<DataModel> {
  final FirebaseFirestore firestore;
  final String collectionName;
  final FirebaseAuth auth;

  FirebaseDataSourceImp({
    required this.auth,
    required this.firestore,
    required this.collectionName,
  });

  @override
  Future<Stream<QuerySnapshot<Map<String, dynamic>>>> getAll() async {
    try {
      final snapshots = await firestore
          .collection(collectionName)
          .where("companyId", isEqualTo: auth.currentUser!.uid)
          .snapshots();
      return snapshots;
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<Map<String, dynamic>?> getById(String? itemId) async {
    try {
      final res = await firestore.collection(collectionName).doc(itemId).get();
      return res.data();
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<Map<String, dynamic>?> create(DataModel item) async {
    try {
      final res = await firestore
          .collection(collectionName)
          .add({...getJson(item), 'companyId': auth.currentUser!.uid});
      return (await res.get()).data();
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<void> delete(String itemId) async {
    try {
      final res =
          await firestore.collection(collectionName).doc(itemId).delete();
      return res;
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<void> update(DataModel item, String? itemId) async {
    try {
      final res = await firestore
          .collection(collectionName)
          .doc(itemId)
          .update(getJson(item));
      return res;
    } catch (e) {
      throw e;
    }
  }
}
