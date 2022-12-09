import 'package:firebase_auth/firebase_auth.dart';

class UserOrError{
  User? user;
  String? error;

  UserOrError({required this.user, required this.error});
}