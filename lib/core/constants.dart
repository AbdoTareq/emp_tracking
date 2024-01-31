import 'package:employee_management/features/employee/data/models/attendance_model.dart';
import 'package:employee_management/features/employee/data/models/client_model.dart';
import 'package:employee_management/features/employee/data/models/employee_model.dart';
import 'package:employee_management/features/materials/data/models/material_model.dart';
import 'package:logger/logger.dart';

final logger = Logger();

const double baseHeight = 867.0;
const double baseWidth = 375.0;
const String employeeCollection = 'employees';
const String materialCollection = 'materials';
const String clientCollection = 'clients';
const String attendanceCollection = 'attendance';
const String employeeId = 'employeeId';

final collectionNames = [
  CollectionNameAndInstance(
      name: employeeCollection, instance: EmployeeModel()),
  CollectionNameAndInstance(
      name: materialCollection, instance: MaterialModel()),
  CollectionNameAndInstance(name: clientCollection, instance: ClientModel()),
  CollectionNameAndInstance(
      name: attendanceCollection, instance: AttendanceModel())
];

class CollectionNameAndInstance {
  final String name;
  final Object instance;

  CollectionNameAndInstance({required this.name, required this.instance});
}
