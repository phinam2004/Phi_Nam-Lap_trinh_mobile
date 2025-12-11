import 'package:app_phi_nam/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/article.dart';

class NewsDetailScreen extends StatelessWidget {
  final Article article;

  const NewsDetailScreen({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          article.title,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
        backgroundColor: Colors.blue[700],
        foregroundColor: Colors.white,
      ),
      drawer: MenuDrawer.buildDrawer(context),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (article.urlToImage != "")
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(article.urlToImage),
              ),
            const SizedBox(height: 16),
            Text(
              article.title,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(article.content, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () async {
                final Uri url = Uri.parse(article.url);
                if (await canLaunchUrl(url)) {
                  await launchUrl(url, mode: LaunchMode.externalApplication);
                }
              },
              icon: const Icon(Icons.open_in_browser),
              label: const Text("Mở bài viết gốc"),
            ),
          ],
        ),
      ),
    );
  }
}
