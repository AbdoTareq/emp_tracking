import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:employee_management/core/base_state.dart';
import 'package:employee_management/export.dart' hide MaterialState;
import 'package:employee_management/features/materials/data/models/material_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../domain/usecases/usecases.dart';

class MaterialCubit extends Cubit<BaseState<List<MaterialModel>>> {
  final MaterialUseCase usecase;
  final GetStorage box = GetStorage();

  MaterialCubit({required this.usecase})
      : super(BaseState<List<MaterialModel>>(status: RxStatus.Loading));

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

  save(MaterialModel? item, List<String> textControllers) async {
    /// add all item properties as not to reset any property
    final isCreate = item?.id == null;
    final savedItem = MaterialModel(
      id: item?.id,
      companyId: item?.companyId ?? FirebaseAuth.instance.currentUser?.uid,
      employeeId: item?.employeeId ?? box.read(employeeId),
      createdAt: isCreate
          ? (FieldValue.serverTimestamp() as DateTime)
          : item?.createdAt,
      updatedAt: isCreate ? null : FieldValue.serverTimestamp() as DateTime,
      name: textControllers[0],
      description: textControllers[1],
      stock: int.parse(textControllers[2]),
      used: int.parse(textControllers[3]),
    );
    final res = await (isCreate ? _create(savedItem) : _update(savedItem));
    return res.fold((l) => showSimpleDialog(text: l),
        (r) => r is MaterialModel ? r : 'Success');
  }

  _create(MaterialModel item) async => usecase.create(item);

  _update(MaterialModel item) async => usecase.update(item);

  // TODO employee should delete his items only
  delete(String? id) async =>
      handleRequest(() async => await usecase.delete(id ?? ''));
}
