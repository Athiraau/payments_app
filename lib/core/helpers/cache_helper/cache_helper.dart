abstract class CacheHelper {
  Future<void> saveData({required String key, required String value});
  Future<String?> getData(String key);
  Future<void> clearData(String key);
  Future<void> saveList(String storageKey, List<dynamic> storageValue);
}