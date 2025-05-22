import 'package:firebase_auth/firebase_auth.dart';

class LoginUseCase {
  static void firebaseUserLogin(
      {required String email, required String password}) async {
    // add(LoggingUserEvent());
    final firebaseAuth = FirebaseAuth.instance;
    try {
      var dd = await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      dd.additionalUserInfo;
      // add(LoginSuccessEvent());
    } on FirebaseAuthException {
      // add(LoginFailedEvent(message: e.message ?? "Something went wrong!!"));
    }
  }
}
