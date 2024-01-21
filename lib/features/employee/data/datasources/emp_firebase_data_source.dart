import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:employee_management/core/constants.dart';
import 'package:employee_management/features/employee/data/models/employee_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

// company id is the adminId which is the logged in user
abstract class EmpFirebaseDataSource {
  Future<Stream<QuerySnapshot<Map<String, dynamic>>>> getAllByCompanyId();
  Future<Map<String, dynamic>?> getById(String id);
  Future<Map<String, dynamic>?> create(EmployeeModel emp);
  Future<void> update(EmployeeModel emp, String? empId);
  Future<void> delete(String empId);
}

class EmpFirebaseDataSourceImp implements EmpFirebaseDataSource {
  final FirebaseFirestore firebase;
  final FirebaseAuth auth;

  EmpFirebaseDataSourceImp({required this.auth, required this.firebase});

  @override
  Future<Stream<QuerySnapshot<Map<String, dynamic>>>>
      getAllByCompanyId() async {
    try {
      final snapshots = await firebase
          .collection(employeeCollection)
          .where("companyId", isEqualTo: auth.currentUser!.uid)
          .snapshots();
      return snapshots;
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<Map<String, dynamic>?> getById(String? empId) async {
    try {
      final res =
          await firebase.collection(employeeCollection).doc(empId).get();
      return res.data();
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<Map<String, dynamic>?> create(EmployeeModel emp) async {
    try {
      final res = await firebase
          .collection(employeeCollection)
          .add({...emp.toMap(), 'companyId': auth.currentUser!.uid});
      return (await res.get()).data();
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<void> delete(String empId) async {
    try {
      final res =
          await firebase.collection(employeeCollection).doc(empId).delete();
      return res;
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<void> update(EmployeeModel emp, String? empId) async {
    try {
      final res = await firebase
          .collection(employeeCollection)
          .doc(empId)
          .update(emp.toMap());
      return res;
    } catch (e) {
      throw e;
    }
  }
}
