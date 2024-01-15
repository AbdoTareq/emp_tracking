import 'package:firebase_auth/firebase_auth.dart';

import '../../../../export.dart';

abstract class AuthRepository {
  Future<Either<Failure, User>> login(String email, String password);
}
