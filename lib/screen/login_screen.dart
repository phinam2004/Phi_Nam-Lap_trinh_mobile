import 'package:app_phi_nam/home_screen.dart';
import 'package:app_phi_nam/screen/dangky_screen.dart';
import 'package:app_phi_nam/screen/profile_screen.dart';
import 'package:app_phi_nam/service/auth_service.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;

  void _togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  void _submit() {
    // Validate form fields
    final isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid) {
      // Show warning if any field is empty/invalid
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Vui lòng nhập email/tên đăng nhập và mật khẩu'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // If valid, attempt login
    FocusScope.of(context).unfocus();
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    final emailOrUsername = _usernameController.text.trim();
    final password = _passwordController.text.trim();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Đang đăng nhập...'),
        duration: Duration(seconds: 2),
      ),
    );

    AuthService.login(
      emailOrUsername: emailOrUsername,
      password: password,
    ).then((result) {
      final (ok, errorMsg) = result;
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      if (ok) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Đăng nhập thành công'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 2),
          ),
        );
        // Navigate to ProfileScreen and replace login route
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const ProfileScreen()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Đăng nhập thất bại: ${errorMsg ?? 'Lỗi không xác định'}',
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Form đăng nhập'),
        backgroundColor: Colors.blue[700],
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      drawer: MenuDrawer.buildDrawer(context),
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height - kToolbarHeight,
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 32),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: TextFormField(
                        controller: _usernameController,
                        decoration: InputDecoration(
                          labelText: 'Email hoặc Tên đăng nhập',
                          prefixIcon: const Icon(Icons.person),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Vui lòng nhập email hoặc tên đăng nhập';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: TextFormField(
                        controller: _passwordController,
                        obscureText: _obscurePassword,
                        decoration: InputDecoration(
                          labelText: 'Mật khẩu',
                          prefixIcon: const Icon(Icons.lock),
                          suffixIcon: IconButton(
                            onPressed: _togglePasswordVisibility,
                            icon: Icon(
                              _obscurePassword
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Vui lòng nhập mật khẩu';
                          }
                          if (value.trim().length < 6) {
                            return 'Mật khẩu phải có ít nhất 6 ký tự';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: _submit,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 80,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: const Text(
                        'Đăng nhập',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextButton(
                      onPressed: () {
                        // Navigate to registration screen
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const DangkyScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        'Chưa có tài khoản? Đăng ký',
                        style: TextStyle(fontSize: 16, color: Colors.blue),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

//tên đăng nhập:emilys
//mật khẩu:emilyspass
