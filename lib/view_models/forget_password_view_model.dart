import 'package:cryptocurrency/models/firebase_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
enum AuthState{
  successful,
  unkownError,
  userNotFound,
}
AuthState authState=AuthState.successful;
class ForgetPasswordScreenViewModel{
  AuthService authService=AuthService();
  TextEditingController emailContoller=TextEditingController();

  Future<AuthState>sendPasswordResetEmail()async{
try{
  await authService.sendPasswordResetEmail(emailContoller.text);
  authState=AuthState.successful;
}on FirebaseAuthException catch(e){
  if (e.code == 'user-not-found') {
  authState=AuthState.userNotFound;
}
  }catch(errors){
  authState=AuthState.unkownError;
  }
return authState;
}
}