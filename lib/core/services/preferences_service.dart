import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  static Future<void> save(String key, List<String> values) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final jsonValue = jsonEncode(values);
    pref.setString(key, jsonValue);
  }

  static Future<List<String>> read(String key) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final jsonValue = pref.getString(key);

    if (jsonValue == null) {
      return [];
    }

    final List<String> values = (jsonDecode(jsonValue) as List).map((e) => e.toString()).toList();

    return values;
  }
}
