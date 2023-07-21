import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../storage/shared_preference_manager.dart';

class FontProvider extends ChangeNotifier {
  late SharedPreferences _preferences;

  double _fontSize = 20.0;
  double get fontSize => _fontSize;

  FontProvider() {
    _loadFontSize();
  }

  Future<void> _loadFontSize() async {
    _preferences = await SharedPreferences.getInstance();
    _fontSize = _preferences.getDouble('font_size') ?? 10.0;
    notifyListeners();
  }

  Future<void> setFontSize(double fontSize) async {
    _fontSize = fontSize;
    notifyListeners();
    await _preferences.setDouble('font_size', fontSize);
  }
}
