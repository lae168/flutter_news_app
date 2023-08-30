import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePictureProvider extends ChangeNotifier {
  String? _selectedPictureUri;

  String? get selectedPictureUri => _selectedPictureUri;
  
  ProfilePictureProvider() {
    loadProfilePicture();
  }
  Future<void> loadProfilePicture() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _selectedPictureUri = prefs.getString('profilePicture');
    notifyListeners();
  }

  Future<void> setProfilePicture(String uri) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('profilePicture', uri);
    _selectedPictureUri = uri;
    notifyListeners();
  }
}
