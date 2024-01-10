import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_new_template/core/base_state.dart';
import 'package:flutter_new_template/features/auth/domain/usecases/usecases.dart';

import '../../../../export.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({required this.authUseCase}) : super(AuthState());
  final GetAuthUseCase authUseCase;
  final storage = GetStorage();
  final GlobalKey<FormState> formKey = GlobalKey();

  final mailTextController = useTextEditingController();
  final passTextController = useTextEditingController();

  Future<void> login() async {
    if (formKey.currentState!.validate()) {
      var user = {
        "email": mailTextController.text,
        "password": passTextController.text,
      };
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
