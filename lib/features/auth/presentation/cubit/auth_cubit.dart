import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/base_state.dart';
import '../../../../export.dart';
import '../../domain/usecases/usecases.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({required this.useCase}) : super(AuthState());
  final AuthUseCase useCase;

  Future login(String email, String password) async {
    return await handleError(() async {
      final response = await useCase.login(email, password);
      return response.fold((_) => _.message, (r) => r.toString());
    });
  }

  Future<bool> logout() async {
    try {
      await sl<FirebaseAuth>().signOut();
      return true;
    } catch (e) {
      logger.i(e);
      return false;
    }
  }

  bool isLoggedIn() => sl<FirebaseAuth>().currentUser?.uid != null;
}
