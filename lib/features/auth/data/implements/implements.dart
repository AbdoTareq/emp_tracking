import 'package:flutter_new_template/features/auth/data/models/user.dart';

import '../sources/sources.dart';
import '../../domain/repositories/repositories.dart';

class AuthRepositoryImp implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  AuthRepositoryImp({required this.remoteDataSource});

  @override
  Future<User> login(Map user) {
    throw UnimplementedError();
  }

  // ... example ...
  //
  // Future<User> getUser(String userId) async {
  //     return remoteDataSource.getUser(userId);
  //   }
  // ...
}
