import 'package:cryptocurrency/models/firebase_service.dart';

class DrawerViewModel{
  AuthService authService=AuthService();

  Future<void> signOut() async {
    await authService.signOut();
    print("Cikis yapildi");
}
}