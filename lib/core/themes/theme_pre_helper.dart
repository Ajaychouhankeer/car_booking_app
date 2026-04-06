import 'package:shared_preferences/shared_preferences.dart';

import '../constants/string_constants.dart';

class ThemePrefHelper {
  static const _key = "isDarkTheme";

  static Future<bool> getTheme() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getBool(_key) ?? false; // default false
  }

  static Future<void> setTheme(bool value) async {
    final pref = await SharedPreferences.getInstance();
    pragma("Set Theme:::::::----> $value");
    await pref.setBool(_key, value);

  }

  static Future<void> setSelectedTheme(String theme) async {
    final pref = await SharedPreferences.getInstance();
    pref.setString('selectedTheme', theme);
  }

  static Future<String> getSelectedTheme() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getString('selectedTheme') ?? StringConstants.light;
  }
}