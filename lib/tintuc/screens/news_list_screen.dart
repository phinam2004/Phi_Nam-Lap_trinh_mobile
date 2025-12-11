import 'package:app_phi_nam/home_screen.dart';
import 'package:flutter/material.dart';
import '../models/article.dart';
import '../services/news_service.dart';
import 'news_detail_screen.dart';

class NewsListScreen extends StatefulWidget {
  const NewsListScreen({super.key});

  @override
  State<NewsListScreen> createState() => _NewsListScreenState();
}

class _NewsListScreenState extends State<NewsListScreen> {
  final NewsService _service = NewsService();
  late Future<List<Article>> futureNews;

  @override
  void initState() {
    super.initState();
    futureNews = _service.fetchNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tin tức mới nhất"),
        centerTitle: true,
        backgroundColor: Colors.blue[700],
        foregroundColor: Colors.white,
      ),
      drawer: MenuDrawer.buildDrawer(context),
      body: FutureBuilder<List<Article>>(
        future: futureNews,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text("Lỗi tải dữ liệu"));
          }

          final articles = snapshot.data!;

          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: articles.length,
            itemBuilder: (context, index) {
              final a = articles[index];

              return Card(
                elevation: 3,
                margin: const EdgeInsets.only(bottom: 12),
                clipBehavior: Clip.hardEdge,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: InkWell(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => NewsDetailScreen(article: a),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      a.urlToImage != ""
                          ? Image.network(
                              a.urlToImage,
                              height: 180,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            )
                          : Container(height: 180, color: Colors.grey),
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              a.title,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              a.description,
                              style: const TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
