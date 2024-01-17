import 'dart:developer';

import 'package:employee_management/core/constants.dart';
import 'package:employee_management/features/employee/data/models/employee_model.dart';
import 'package:employee_management/features/employee/domain/usecases/usecases.dart';
import 'package:employee_management/features/employee/presentation/employee_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmployeeCubit extends Cubit<EmployeeState> {
  final EmployeeUseCase employeeUseCase;

  EmployeeCubit({required this.employeeUseCase})
      : super(EmployeeState(isLoading: true));

  Future<void> getAll() async {
    logger.i('error');
    final stableState = state;
    try {
      emit(state.copyWith(isLoading: true));
      final res = await employeeUseCase.getAll();
      res.fold(
          (l) => logger.i(l),
          (r) => r.listen((event) {
                log('message');
                emit(state.copyWith(isLoading: false, data: event));
              }));
    } catch (error) {
      emit(state.copyWith(error: error.toString()));
      emit(stableState.copyWith(isLoading: false));
    }
  }

  create(List<String> textControllers) async {
    final res = await employeeUseCase.create(EmployeeModel(
      name: textControllers[0],
      jobTitle: textControllers[1],
      email: textControllers[2],
    ));
    return res.fold((l) => logger.i(l), (r) => r);
  }
}
