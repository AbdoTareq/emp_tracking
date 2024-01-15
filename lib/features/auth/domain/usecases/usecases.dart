import 'package:firebase_auth/firebase_auth.dart';

import '../../../../export.dart';
import '../repositories/repositories.dart';

class AuthUseCase {
  final AuthRepository repository;

  AuthUseCase({required this.repository});

  Future<Either<Failure, User>> login(String email, String password) async {
    return repository.login(email, password);
  }
}
