import '../../../../core/error/failures.dart';
import '../../../../export.dart';
import '../../data/models/user.dart';

abstract class AuthRepository {
  Future<Either<Failure, User>> login(Map user);
}
