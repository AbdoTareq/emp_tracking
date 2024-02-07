import 'package:employee_management/core/feature/data/models/attendance_model.dart';
import 'package:employee_management/core/location_manager.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../core/base_state.dart';
import '../../../export.dart' hide MaterialState;
import '../domain/usecases/usecases.dart';

class AttendanceCubit extends Cubit<BaseState<List<AttendanceModel>>> {
  final AttendanceUseCase usecase;
  final LocationManager locationManager;

  AttendanceCubit({required this.usecase, required this.locationManager})
      : super(const BaseState<List<AttendanceModel>>(status: RxStatus.Loading));

  Future<void> getAll() async {
    try {
      emit(state.copyWith(status: RxStatus.Loading));
      final res = await usecase.getAll();
      res.fold(
          (l) => logger.i(l),
          (r) => r.listen((event) {
                emit(
                  state.copyWith(
                    status: event.isEmpty ? RxStatus.Empty : RxStatus.Success,
                    data: event,
                  ),
                );
              }));
    } catch (error) {
      emit(state.copyWith(
          status: RxStatus.Error, errorMessage: error.toString()));
    }
  }

  save(AttendanceModel? item) async {
    /// add all item properties as not to reset any property
    final isCreate = item?.id == null;
    final savedItem = AttendanceModel(
      id: item?.id,
      companyId: item?.companyId ?? FirebaseAuth.instance.currentUser?.uid,
      date: item?.date,
    );
    final res = await (isCreate ? _create(savedItem) : _update(savedItem));
    return res.fold((l) => showSimpleDialog(text: l),
        (r) => r is AttendanceModel ? r : 'Success');
  }

  _create(AttendanceModel item) async => usecase.create(item);

  _update(AttendanceModel item) async => usecase.update(item);

  delete(String? id) async =>
      handleRequest(() async => await usecase.delete(id ?? ''));

  Future<bool> _checkUserLocation() async {
    try {
      final position = await locationManager.determinePosition();
      showSimpleDialog(text: position.toJson());
      final distance = await locationManager.getDistanceFromUser();
      showSimpleDialog(text: distance);
      return true;
    } catch (e) {
      showWarningDialog(text: e.toString());
      return false;
    }
  }

  checkIn() async {
    if ((await _checkUserLocation())) {
      save(AttendanceModel(
          date: DateTime.now(), name: 'Test', companyId: '123456'));
    }
  }
}
