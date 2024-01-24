import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/constants.dart';
import '../models/material_model.dart';

// company id is the adminId which is the logged in user
abstract class MaterialFirebaseDataSource {
  Future<Stream<QuerySnapshot<Map<String, dynamic>>>> getAll();
  Future<Map<String, dynamic>?> getById(String id);
  Future<Map<String, dynamic>?> create(MaterialModel item);
  Future<void> update(MaterialModel item, String? itemId);
  Future<void> delete(String itemId);
}

class MaterialFirebaseDataSourceImp implements MaterialFirebaseDataSource {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;

  MaterialFirebaseDataSourceImp({required this.auth, required this.firestore});

  @override
  Future<Stream<QuerySnapshot<Map<String, dynamic>>>> getAll() async {
    try {
      final snapshots = await firestore
          .collection(materialCollection)
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
      final res =
          await firestore.collection(materialCollection).doc(itemId).get();
      return res.data();
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<Map<String, dynamic>?> create(MaterialModel item) async {
    try {
      final res = await firestore
          .collection(materialCollection)
          .add({...item.toMap(), 'companyId': auth.currentUser!.uid});
      return (await res.get()).data();
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<void> delete(String itemId) async {
    try {
      final res =
          await firestore.collection(materialCollection).doc(itemId).delete();
      return res;
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<void> update(MaterialModel item, String? itemId) async {
    try {
      final res = await firestore
          .collection(materialCollection)
          .doc(itemId)
          .update(item.toMap());
      return res;
    } catch (e) {
      throw e;
    }
  }
}
