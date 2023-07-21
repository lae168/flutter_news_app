import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesManager {
  Future<void> saveFirstName(
      {required String key, required String value}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value).catchError((error) {
      print(error.message);
    });
  }

  Future<void> saveLastName(
      {required String key, required dynamic value}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value).catchError((error) {
      print(error.message);
    });
  }

  Future<void> saveEmailorNumber(
      {required String key, required dynamic value}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value).catchError((error) {
      print(error.message);
    });
  }

  Future<void> savePassword(
      {required String key, required dynamic value}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value).catchError((error) {
      print(error.message);
    });
  }

  Future<String?> readFirstName({required String key}) async {
    //every key must be String
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? result = prefs.getString(key);
    return result;
  }

  Future<String?> readLastName({required String key}) async {
    //every key must be String
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? result = prefs.getString(key);
    return result;
  }

  Future<String?> readEmailOrPhone({required String key}) async {
    //every key must be String
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? result = prefs.getString(key);
    return result;
  }

  Future<String?> readPassword({required String key}) async {
    //every key must be String
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? result = prefs.getString(key);
    return result;
  }

  Future<bool> remove({required String key}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.remove(key);
  }

  Future<bool> existData({required String key}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(key);
  }

  Future<bool> clear() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.clear();
  }

  static const String THEME_STATUS = "THEMESTATUS";
  
  setDarkTheme(bool value) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(THEME_STATUS, value);
  }

  Future<bool> getDarkTheme() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(THEME_STATUS) ?? false;
  }


}
