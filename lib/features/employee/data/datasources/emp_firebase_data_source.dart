import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:employee_management/features/employee/data/models/employee_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

// company id is the adminId which is the logged in user
abstract class EmpFirebaseDataSource {
  Future<Stream<QuerySnapshot<Map<String, dynamic>>>> getAllByCompanyId();
  Future<Map<String, dynamic>?> create(EmployeeModel emp);
  Future<void> update(EmployeeModel emp, String? empId);
  Future<void> delete(String empId);
}

class EmpFirebaseDataSourceImp implements EmpFirebaseDataSource {
  final CollectionReference<Map<String, dynamic>> employeesCollection;
  final FirebaseAuth auth;

  EmpFirebaseDataSourceImp(
      {required this.auth, required this.employeesCollection});

  @override
  Future<Stream<QuerySnapshot<Map<String, dynamic>>>>
      getAllByCompanyId() async {
    try {
      final snapshots = await employeesCollection
          .where("companyId", isEqualTo: auth.currentUser!.uid)
          .snapshots();
      return snapshots;
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<Map<String, dynamic>?> create(EmployeeModel emp) async {
    try {
      final res = await employeesCollection
          .add({'companyId': auth.currentUser!.uid, ...emp.toMap()});
      return (await res.get()).data();
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<void> delete(String empId) async {
    try {
      final res = await employeesCollection.doc(empId).delete();
      return res;
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<void> update(EmployeeModel emp, String? empId) async {
    try {
      final res = await employeesCollection.doc(empId).update(emp.toMap());
      return res;
    } catch (e) {
      throw e;
    }
  }
}
