import '../../../../export.dart';
import '../../data/models/user.dart';
import '../repositories/repositories.dart';

class AuthUseCase {
  final AuthRepository repository;

  AuthUseCase({required this.repository});

  Future<Either<Failure, User>> login(Map user) async {
    return repository.login(user);
  }
}
