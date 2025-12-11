import 'package:hive/hive.dart';
import '../models/news.dart';

class BookmarkService {
  static Box box = Hive.box("bookmarks");

  static List<News> getAll() {
    return box.values.cast<News>().toList();
  }

  static void toggle(News news) {
    if (isSaved(news.url)) {
      box.delete(news.url);
    } else {
      box.put(news.url, news);
    }
  }

  static bool isSaved(String url) {
    return box.containsKey(url);
  }
}
