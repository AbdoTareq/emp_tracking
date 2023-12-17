import '../export.dart' hide ar;

abstract class AuthRepository {
  Future<Either<Failure, ServerResponse>> login(Map<String, dynamic> user);
  Future<Either<Failure, ServerResponse>> register(Map<String, dynamic> user);
  Future<Either<Failure, dynamic>> registerSocial(Map<String, dynamic> user);
  Future<Either<Failure, dynamic>> connect(Map<String, dynamic> user);
  Future<Either<Failure, ServerResponse>> setRoleTaxCommercial(
      Map<String, dynamic> data);
  Future<Either<Failure, ServerResponse>> setEmailPass(
      Map<String, dynamic> data);
  Future<Either<Failure, ServerResponse>> verify(String email, String code);
  Future<Either<Failure, ServerResponse>> forgetPass(String email);
  Future<Either<Failure, ServerResponse>> resendEmail(String email);
  Future<Either<Failure, ServerResponse>> resetPassword(
      String email, String password, String token);
  Future<Either<Failure, ServerResponse>> changePass(
      String oldPass, String newPass);
  Future<Either<Failure, ServerResponse>> changeProfile(FormData formData);
  Future<Either<Failure, ServerResponse>> deleteAccount();
  Future<Either<Failure, ServerResponse>> logout();
}

class AuthRepositoryImp with BaseRequests implements AuthRepository {
  AuthRepositoryImp._privateConstructor();

  static final AuthRepositoryImp _instance =
      AuthRepositoryImp._privateConstructor();

  factory AuthRepositoryImp() {
    return _instance;
  }

  Future<Either<Failure, ServerResponse>> login(
          Map<String, dynamic> user) async =>
      basePost('/login', user);

  Future<Either<Failure, ServerResponse>> register(
          Map<String, dynamic> user) async =>
      basePost('/register', user);

  Future<Either<Failure, dynamic>> registerSocial(
          Map<String, dynamic> user) async =>
      basePost('/login_with_socail', user);

  Future<Either<Failure, dynamic>> connect(Map<String, dynamic> user) async =>
      basePost('/connect', user);

  Future<Either<Failure, ServerResponse>> setRoleTaxCommercial(
          Map<String, dynamic> data) async =>
      basePost('/set_role_tax_commercial_data', data);

  Future<Either<Failure, ServerResponse>> setEmailPass(
          Map<String, dynamic> data) async =>
      basePost('/set_email_and_password', data);

  Future<Either<Failure, ServerResponse>> forgetPass(String email) async =>
      basePost('/password/email', {"email": email});

  Future<Either<Failure, ServerResponse>> resendEmail(String email) async =>
      basePost('/re-request-verification', {"email": email});

  Future<Either<Failure, ServerResponse>> verify(
          String email, String code) async =>
      basePost(
          Get.previousRoute == Routes.SIGNUP
              ? '/verify'
              : '/forgot-password-verify',
          {"email": email, "token": code});

  Future<Either<Failure, ServerResponse>> resetPassword(
          String email, String password, String code) async =>
      basePost('/password/reset', {
        "email": email,
        "password": password,
        "password_confirmation": password,
        "reset_code": code
      });

  Future<Either<Failure, ServerResponse>> changePass(
          String oldPass, String newPass) async =>
      basePost('/update_password', {
        "password": oldPass,
        "new_password": newPass,
        'new_password_confirmation': newPass
      });

  Future<Either<Failure, ServerResponse>> changeProfile(
          FormData formData) async =>
      baseUpload('/user_profile', formData);

  Future<Either<Failure, ServerResponse>> logout() async =>
      await basePost('/logout', {});

  Future<Either<Failure, ServerResponse>> deleteAccount() async =>
      await basePost('/block', {});
}
