import 'package:app_phi_nam/bai1/bai1.dart';
import 'package:app_phi_nam/bai2/BAITAP2.dart';
import 'package:app_phi_nam/bai3/BAITAP3.dart';
import 'package:app_phi_nam/bai4/change_color_app.dart';
import 'package:app_phi_nam/bai5/dem_so_app.dart';
import 'package:app_phi_nam/bai6/Bo_dem_thoi_gian_app.dart';
import 'package:app_phi_nam/bai7/bai7.dart';
import 'package:app_phi_nam/bai8/my-product.dart';
import 'package:app_phi_nam/screen/dangky_screen.dart';
import 'package:app_phi_nam/screen/login_screen.dart';
import 'package:app_phi_nam/tintuc/screens/news_list_screen.dart';
import 'package:flutter/material.dart';

// Helper class để tạo drawer menu có thể tái sử dụng
class MenuDrawer {
  static Widget buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(Icons.menu_book, size: 48, color: Colors.white),
                SizedBox(height: 10),
                Text(
                  'Danh sách bài học',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          _buildMenuItem(context, 'Bài 1', 1, const BAI1()),
          _buildMenuItem(context, 'Bài 2', 2, const BAITAP2()),
          _buildMenuItem(context, 'Bài 3', 3, const BAITAP3()),
          _buildMenuItem(context, 'Bài 4', 4, ChangeColorApp()),
          _buildMenuItem(context, 'Bài 5', 5, const DemSoApp()),
          _buildMenuItem(context, 'Bài 6', 6, const BoDemThoiGianApp()),
          _buildMenuItem(context, 'Bài 7', 7, const BAI7()),
          _buildMenuItem(context, 'Bài 8', 8, const MyProducts()),
          _buildMenuItem(
            context,
            'Đăng nhập',
            9,
            const LoginScreen(),
            Icons.login,
          ),
          _buildMenuItem(
            context,
            'Đăng ký',
            10,
            const DangkyScreen(),
            Icons.person_add,
          ),
          _buildMenuItem(
            context,
            'Tin tức',
            11,
            const NewsListScreen(),
            Icons.newspaper,
          ),
        ],
      ),
    );
  }

  static Widget _buildMenuItem(
    BuildContext context,
    String title,
    int lessonNumber, [
    Widget? screen,
    IconData? icon,
  ]) {
    return ListTile(
      leading: Icon(icon ?? Icons.book),
      title: Text(title),
      onTap: () {
        Navigator.pop(context); // Đóng drawer
        if (screen != null) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => screen),
          );
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LessonScreen(lessonNumber: lessonNumber),
            ),
          );
        }
      },
    );
  }
}

class Myhomepage extends StatefulWidget {
  const Myhomepage({super.key});

  @override
  State<Myhomepage> createState() => _MyhomepageState();
}

class _MyhomepageState extends State<Myhomepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trang chủ'),
        backgroundColor: Colors.blue[700],
        foregroundColor: Colors.white,
      ),
      drawer: MenuDrawer.buildDrawer(context),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.home, size: 80, color: Colors.blue),
            SizedBox(height: 20),
            Text(
              'Chào mừng đến với ứng dụng',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Vui lòng chọn bài học từ menu',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}

// Widget màn hình bài học có drawer menu
class LessonScreen extends StatelessWidget {
  final int lessonNumber;

  const LessonScreen({super.key, required this.lessonNumber});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bài $lessonNumber'),
        backgroundColor: Colors.blue[700],
        foregroundColor: Colors.white,
      ),
      drawer: MenuDrawer.buildDrawer(context),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.book, size: 80, color: Colors.blue),
            const SizedBox(height: 20),
            Text(
              'Nội dung Bài $lessonNumber',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'Giao diện bài học sẽ được cập nhật sau',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
