import 'package:flutter_new_template/features/auth/data/models/user.dart';

import '../../../../export.dart';
import '../../domain/repositories/repositories.dart';

class AuthRepositoryImp implements AuthRepository {
  final BaseRequests remoteDataSource;
  AuthRepositoryImp({required this.remoteDataSource});

  @override
  Future<Either<Failure, User>> login(Map mailPass) async {
    final res = await remoteDataSource.post('login', mailPass);
    return res.fold(
      (failure) => left(failure),
      (serverResponse) {
        final user = User.fromMap(serverResponse.data);
        return right(user);
      },
    );
  }
}
