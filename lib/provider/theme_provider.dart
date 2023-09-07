import 'package:flutter/material.dart';
import '../storage/shared_preference_manager.dart';

class ThemeProvider extends ChangeNotifier {
  SharedPreferencesManager darkThemePrefs = SharedPreferencesManager();
  bool _darkTheme = true;
  bool get getDarkTheme => _darkTheme;

  set setDarkTheme(bool value) {
    _darkTheme = value;
    darkThemePrefs.setDarkTheme(value);
    notifyListeners();
  }

 
}
