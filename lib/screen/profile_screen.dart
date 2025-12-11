import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Cá nhân'),
        backgroundColor: Colors.blue,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 32),
            CircleAvatar(
              radius: 56,
              backgroundImage: NetworkImage(
                'https://randomuser.me/api/portraits/men/32.jpg',
              ),
              backgroundColor: Colors.blue[100],
            ),
            const SizedBox(height: 16),
            Text(
              'Nguyễn Văn A',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'user@email.com',
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),
            const SizedBox(height: 24),
            Card(
              margin: const EdgeInsets.symmetric(horizontal: 24),
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.edit, color: Colors.blue),
                      title: Text('Chỉnh sửa thông tin'),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.blue,
                      ),
                      onTap: () {},
                    ),
                    Divider(),
                    ListTile(
                      leading: Icon(Icons.lock, color: Colors.orange),
                      title: Text('Đổi mật khẩu'),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.orange,
                      ),
                      onTap: () {},
                    ),
                    Divider(),
                    ListTile(
                      leading: Icon(Icons.logout, color: Colors.red),
                      title: Text('Đăng xuất'),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.red,
                      ),
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
