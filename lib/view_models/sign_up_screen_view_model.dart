import 'package:cryptocurrency/models/firebase_service.dart';
import 'package:cryptocurrency/models/user_or_error_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';

class SignUpScreenViewModel {
  AuthService authService = AuthService();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController againPasswordController = TextEditingController();

  ///Creating Sign Up method
  Future<UserOrError> createUserWithEmailAndPassword() async {
    User? user;
    String? error;
    try {
      UserCredential credential =
          await authService.createUserWithEmailAndPassword(
              email: emailController.text, password: passwordController.text);
      user = credential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        error = "The account already exists for that email.";
      } else {
        error = e.code;
      }
    } catch (e) {
      error = "Unkown Error: ${e.hashCode}";
    }
    UserOrError signUpReslut = UserOrError(user: user, error: error);
    return signUpReslut;
  }

  Future<UserOrError> createAndVerifyEmailAndPassword() async {
    UserOrError userOrError = await createUserWithEmailAndPassword();
    if (userOrError.user != null &&
        userOrError.user?.emailVerified == false) {
      await authService.sendEmailVerification(userOrError.user);
    }
    return userOrError;
  }
}
