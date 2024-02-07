import 'package:employee_management/core/feature/data/models/attendance_model.dart';

import '../../../../core/feature/domain/usecases/usecases.dart';

class AttendanceUseCase extends UseCase<AttendanceModel> {
  AttendanceUseCase(
      {required super.repository,
      required super.instance,
      required super.collectionName});
}
