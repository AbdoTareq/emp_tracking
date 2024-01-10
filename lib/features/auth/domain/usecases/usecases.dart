import '../../data/models/user.dart';
import '../repositories/repositories.dart';

class GetAuthUseCase {
  final AuthRepository repository;

  GetAuthUseCase({required this.repository});

  Future<User> login(Map user) async {
    return repository.login(user);
  }
}
