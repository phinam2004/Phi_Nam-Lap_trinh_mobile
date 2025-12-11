import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/article.dart';

class NewsService {
  final String apiKey = "0cca5fe60e964a84bb31151876dd877a";

  Future<List<Article>> fetchNews() async {
    final url = Uri.parse(
      "https://newsapi.org/v2/top-headlines?country=us&apiKey=$apiKey",
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List articlesJson = data['articles'];

      return articlesJson.map((json) => Article.fromJson(json)).toList();
    } else {
      throw Exception("Failed to load news");
    }
  }
}
