import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/profile_model.dart';

class ProfileProvider extends ChangeNotifier {
  ProfileModel _profile = ProfileModel(name: '', phone: '');

  ProfileModel get profile => _profile;

  Future<void> loadProfileData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? name = prefs.getString('name');
    String? phone = prefs.getString('phone');

    if (name != null && phone != null) {
      _profile = ProfileModel(name: name, phone: phone);
    }

    notifyListeners();
  }

  Future<void> saveProfileData(ProfileModel profile) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', profile.name);
    await prefs.setString('phone', profile.phone);

    _profile = profile;
    notifyListeners();
  }

  Future<void> updateProfileData(ProfileModel profile) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', profile.name);
    await prefs.setString('phone', profile.phone);

    notifyListeners();
  }
}
