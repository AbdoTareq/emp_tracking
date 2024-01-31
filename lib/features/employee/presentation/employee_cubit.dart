import '../../../export.dart';
import '../data/models/employee_model.dart';
import '../domain/usecases/usecases.dart';
import 'employee_state.dart';

class EmployeeCubit extends Cubit<EmployeeState> {
  final EmployeeUseCase employeeUseCase;

  EmployeeCubit({required this.employeeUseCase})
      : super(const EmployeeState(isLoading: true));

  Future<void> getAll() async {
    final stableState = state;
    try {
      emit(state.copyWith(isLoading: true));
      final res = await employeeUseCase.getAll();
      res.fold(
          (l) => logger.i(l),
          (r) => r.listen((event) {
                emit(state.copyWith(isLoading: false, data: event));
              }));
    } catch (error) {
      emit(state.copyWith(error: error.toString()));
      emit(stableState.copyWith(isLoading: false));
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
