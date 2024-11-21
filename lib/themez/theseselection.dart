import 'package:esssentioo/themez/darkmod.dart';
import 'package:esssentioo/themez/lightmod.dart';
import 'package:flutter/material.dart';
class ThemeProvider with ChangeNotifier {
  ThemeData _themeData = lightMode;
  ThemeData get themeData => _themeData;
  bool get isDarkMode => _themeData == darkmod;
  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }
  void toggleTheme() {
    if (_themeData == lightMode) {
      themeData = darkmod;
    } else {
      themeData = lightMode;
    }
  }
}