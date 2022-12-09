import 'package:firebase_auth/firebase_auth.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;


  Stream<dynamic> authStateChanges() {
    Stream authStream = _auth.authStateChanges();
    return authStream;
  }


  ///Sign Out Method
  Future<void> signOut() async {
    await _auth.signOut();
    // User? user=_auth.currentUser;
    // return user;
  }

  ///createUserWithEmailAndPassword method
  Future<UserCredential> createUserWithEmailAndPassword(
      {required String email, required String password}) async {
    UserCredential credential = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    return credential;
  }

  ///Creating send Email Verification Method
  Future<void> sendEmailVerification(User? user) async {
    await user?.sendEmailVerification();
  }

  ///Creating signInWithEmailAndPassword method
  Future<UserCredential>signInWithEmailAndPassword({required String email, required String password})async{
   UserCredential credential=await _auth.signInWithEmailAndPassword(email: email, password: password);
   return credential;
  }

  ///Creating Password Reset Link
  Future<void>sendPasswordResetEmail(String email)async{
    await _auth.sendPasswordResetEmail(email: email);
  }
}
