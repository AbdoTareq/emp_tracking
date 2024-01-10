import '../../data/models/user.dart';

abstract class AuthRepository {
  Future<User> login(Map user);
}