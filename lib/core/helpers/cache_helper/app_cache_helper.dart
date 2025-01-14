import 'package:shared_preferences/shared_preferences.dart';

import 'cache_helper.dart';

class AppCacheHelper extends CacheHelper {
  @override
  Future<void> saveData({required String key, required String value}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  @override
  Future<String?> getData(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  @override
  Future<void> clearData(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }

// save as list
  @override
  Future<void> saveList(String storageKey, List<dynamic> storageValue) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
        storageKey, storageValue.map((item) => item.toString()).toList());
  }
}
