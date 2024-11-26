import 'package:shared_preferences/shared_preferences.dart';
class SharedPrefUtils {

  static late final SharedPreferences preferences;
  static bool _init = false;
  static Future init() async {
    if (_init) return;
    preferences = await SharedPreferences.getInstance();
    _init = true;
    return preferences;
  }

  static saveStr(String key, String message) async {
    preferences.setString(key, message);
  }

  static readPrefStr(String key) async {
    return preferences.getString(key);
  }

}