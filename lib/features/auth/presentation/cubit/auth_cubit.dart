import '../../../../core/base_state.dart';
import '../../../../export.dart';
import '../../domain/usecases/usecases.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({required this.useCase}) : super(AuthState());
  final AuthUseCase useCase;
  final GlobalKey<FormState> formKey = GlobalKey();

  Future login(String email, String password) async {
    if (formKey.currentState!.validate()) {
      return await handleError(() async {
        final response = await useCase.login(email, password);
        return response.fold((_) {}, (r) => r.toString());
      });
    }
  }
}
