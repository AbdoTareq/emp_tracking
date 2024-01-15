import 'package:employee_management/core/base_state.dart';
import 'package:employee_management/features/auth/domain/usecases/usecases.dart';

import '../../../../export.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({required this.authUseCase}) : super(AuthState());
  final AuthUseCase authUseCase;
  final GlobalKey<FormState> formKey = GlobalKey();

  Future login(String email, String password) async {
    if (formKey.currentState!.validate()) {
      return await handleError(() async {
        final response = await authUseCase.login(email, password);
        response.fold((_) {}, (r) {
          logger.i(r.toString());
          return r.toString();
        });
      });
    }
  }
}
