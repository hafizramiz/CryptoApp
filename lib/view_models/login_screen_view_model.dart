import 'package:cryptocurrency/models/firebase_service.dart';
import 'package:cryptocurrency/models/user_or_error_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';

class LoginScreenViewModel {
  AuthService authService = AuthService();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<UserOrError> signInWithEmailAndPassword() async {
    User? user;
    String? error;
    try {
      UserCredential credential = await authService.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      user = credential.user;
      print("Giris yapildi");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        error = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        error = 'Wrong password provided for that user.';
      }
    } catch (e) {
      error = "Unkown Error: ${e.hashCode}";
    }
    UserOrError userOrError = UserOrError(user: user, error: error);
    return userOrError;
  }

  Future<void>signOut()async{
    await FirebaseAuth.instance.signOut();
  }


}
