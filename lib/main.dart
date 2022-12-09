import 'package:cryptocurrency/view_models/theme_setting_view_model.dart';
import 'package:cryptocurrency/views/onboard_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'view_models/theme_setting_view_model.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ThemeSettings>(create: (context)=>ThemeSettings.Named(),
      child: Consumer<ThemeSettings>(builder: (context,ThemeSettings themeSetting,child){
       return MaterialApp(
          theme: themeSetting.themeStatus?ThemeData.dark():ThemeData.light(),
          home: OnBoardScreen(),
        );
      }
      ),
    );
  }
}
