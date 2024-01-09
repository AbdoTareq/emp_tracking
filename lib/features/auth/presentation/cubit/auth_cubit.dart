import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_new_template/core/base_state.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthState());
}
