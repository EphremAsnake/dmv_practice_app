import 'dart:convert';

import 'package:get/get.dart';
import 'package:hive/hive.dart';

class CacheStorageService {
  CacheStorageService();

  static final _storage = Hive.box('driving_exam');

  //Get permanently saved objects
  Future<Map<String, dynamic>?> getSavedData(String key) async {
    try {
      if (key.isEmpty) return null;
      var response = await _storage.get(key);
      if (response != null) {
        return json.decode(response);
      } else {
        return null;
      }
    } catch (ex) {
      Get.snackbar(
        'Error',
        "Error Occured while caching data",
        duration: const Duration(seconds: 3),
        snackPosition: SnackPosition.BOTTOM,
      );
      return null;
    }
  }

  //Save permanently
  Future saveData(String key, Map<String, dynamic> value) async {
    try {
      if (key.isEmpty) return null;
      var a = json.encode(value);
      await _storage.put(key, a);
    } catch (ex) {
      Get.snackbar(
        'Error',
        "Error Occured while reading cache data",
        duration: const Duration(seconds: 3),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
