import 'package:equatable/equatable.dart';

enum RxStatus { Loading, Success, Empty, Error }

class BaseState<T> extends Equatable {
  final RxStatus status;
  final T? data;
  final String? errorMessage;

  const BaseState({
    this.status = RxStatus.Loading,
    this.data,
    this.errorMessage,
  });

  BaseState copyWith({
    RxStatus? status,
    T? data,
    String? errorMessage,
  }) {
    return new BaseState(
      status: status ?? this.status,
      data: data ?? this.data,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, data, errorMessage];
}
