import 'package:flutter/material.dart';
class ThemeSettings extends ChangeNotifier{
late bool themeStatus;

ThemeSettings.Named(){
  themeStatus=true;
}


setThemeStatus(bool value){
  themeStatus=value;
  notifyListeners();
}
}