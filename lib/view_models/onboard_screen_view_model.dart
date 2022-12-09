import 'package:cryptocurrency/models/firebase_service.dart';
import 'package:flutter/cupertino.dart';
import '../views/bottom_nav_bar/bottom_nav_bar_screen.dart';
import '../views/error_screen.dart';
import '../views/login_screen.dart';

class OnBoardScreenViewModel{
  AuthService authService=AuthService();

  StreamBuilder<dynamic> buildStreamBuilder() {
    return StreamBuilder(
        stream: authService.authStateChanges(),
        builder: (context, AsyncSnapshot snapshot) {
          //print("snapshotdaki data durum ${snapshot.data}");
          if (snapshot.hasError) {
            return ErrorScreen();
          } else {
            if (snapshot.data == null) {
              return LoginScreen();
            } else {
              return BottomNavBarScreen();
            }
          }
        });
  }
}