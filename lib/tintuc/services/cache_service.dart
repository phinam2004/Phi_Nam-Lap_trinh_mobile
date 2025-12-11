// CacheService - Commented out because Hive is not initialized
// Uncomment and initialize Hive in main.dart if you want to use caching
/*
import 'package:hive/hive.dart';
import '../models/article.dart';

class CacheService {
  static Box? box;

  static Future<void> init() async {
    if (box == null) {
      box = await Hive.openBox("cache");
    }
  }

  static void save(String key, List<Article> data) {
    if (box != null) {
      box!.put(key, data);
    }
  }

  static List<Article>? get(String key) {
    if (box != null) {
      return box!.get(key)?.cast<Article>();
    }
    return null;
  }
}
*/

class CacheService {
  // Placeholder class - Hive not initialized
  static void save(String key, dynamic data) {
    // Cache functionality disabled
  }

  static dynamic get(String key) {
    // Cache functionality disabled
    return null;
  }
}
