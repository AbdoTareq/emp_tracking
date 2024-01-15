import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthFirebaseDataSource {
  Future<User?> login(String email, String password);
  Future<User?> signup(String email, String password);
}

class AuthFirebaseDataSourceImp implements AuthFirebaseDataSource {
  final FirebaseAuth auth;

  AuthFirebaseDataSourceImp({required this.auth});

  @override
  Future<User?> login(String email, String password) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      throw e;
    }
  }

  @override
  Future<User?> signup(String email, String password) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      throw e;
    }
  }
}
