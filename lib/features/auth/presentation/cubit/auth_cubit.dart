import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_new_template/core/base_state.dart';
import 'package:flutter_new_template/features/auth/domain/usecases/usecases.dart';

import '../../../../export.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({required this.authUseCase}) : super(AuthState());
  final AuthUseCase authUseCase;
  final storage = GetStorage();
  final GlobalKey<FormState> formKey = GlobalKey();

  Future<void> login(Map<String, String> user) async {
    if (formKey.currentState!.validate()) {
      await handleError(() async {
        final response = await authUseCase.login(user);
        // response.fold((_) {}, (r) {
        // logger.i(r.data["token"]);
        // storage.write('token', r.data["token"]);
        // Get.offAllNamed(Routes.NAV);
        // });
      });
    }
  }
}
