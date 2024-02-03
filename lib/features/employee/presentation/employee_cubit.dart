import 'package:employee_management/core/base_state.dart';
import 'package:employee_management/core/feature/data/models/employee_model.dart';

import '../../../export.dart';
import '../domain/usecases/usecases.dart';

class EmployeeCubit extends Cubit<BaseState<List<EmployeeModel>>> {
  final EmployeeUseCase employeeUseCase;

  EmployeeCubit({required this.employeeUseCase})
      : super(const BaseState<List<EmployeeModel>>(status: RxStatus.Loading));

  Future<void> getAll() async {
    try {
      emit(state.copyWith(status: RxStatus.Loading));
      final res = await employeeUseCase.getAll();
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

  save(EmployeeModel? employee, List<String> textControllers) async {
    /// add all item properties as not to reset any property
    final item = EmployeeModel(
      id: employee?.id,
      companyId: employee?.companyId,
      isDeleted: employee?.isDeleted,
      lastSeen: employee?.lastSeen,
      createdAt: employee?.createdAt,
      isOnline: employee?.isOnline,
      name: textControllers[0],
      jobTitle: textControllers[1],
      email: textControllers[2],
    );
    final res = await (item.id == null ? _create(item) : _update(item));
    return res.fold((l) => showSimpleDialog(text: l),
        (r) => r is EmployeeModel ? r : 'Success');
  }

  _create(EmployeeModel item) async => employeeUseCase.create(item);

  _update(EmployeeModel item) async => employeeUseCase.update(item);

  delete(String? id) async =>
      handleRequest(() async => await employeeUseCase.delete(id ?? ''));
}
