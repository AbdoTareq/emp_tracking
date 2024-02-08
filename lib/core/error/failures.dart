// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String? message;

  const Failure({this.message});
}

class OfflineFailure extends Failure {
  const OfflineFailure({super.message});

  @override
  List<Object?> get props => [];
}

class ServerFailure extends Failure {
  const ServerFailure({super.message});

  @override
  List<Object?> get props => [];
}

class EmptyCacheFailure extends Failure {
  const EmptyCacheFailure({super.message});

  @override
  List<Object?> get props => [];
}

/// exception in fromMap or fromJson
class SerializeFailure extends Failure {
  const SerializeFailure({super.message});

  @override
  List<Object?> get props => [];
}
