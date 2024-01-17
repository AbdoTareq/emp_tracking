// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:employee_management/features/employee/data/models/employee_model.dart';

class EmployeeState {
  final bool isLoading;
  final List<EmployeeModel> data;
  final String? error;

  const EmployeeState({
    this.isLoading = false,
    this.data = const [],
    this.error,
  });

  EmployeeState copyWith({
    bool? isLoading,
    List<EmployeeModel>? data,
    String? error,
  }) {
    return EmployeeState(
      isLoading: isLoading ?? this.isLoading,
      data: data ?? this.data,
      error: error ?? this.error,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'isLoading': isLoading,
      'data': data.map((x) => x.toMap()).toList(),
      'error': error,
    };
  }

  factory EmployeeState.fromMap(Map<String, dynamic> map) {
    return EmployeeState(
      isLoading: map['isLoading'] as bool,
      data: List<EmployeeModel>.from(
        (map['data'] as List<int>).map<EmployeeModel>(
          (x) => EmployeeModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      error: map['error'] != null ? map['error'] as String : null,
    );
  }
}
