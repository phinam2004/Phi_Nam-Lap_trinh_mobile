import 'package:app_phi_nam/home_screen.dart';
import 'package:app_phi_nam/service/auth_service.dart';
import 'package:flutter/material.dart';

class DangkyScreen extends StatefulWidget {
  const DangkyScreen({Key? key}) : super(key: key);

  @override
  State<DangkyScreen> createState() => _DangkyScreenState();
}

class _DangkyScreenState extends State<DangkyScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();
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
          content: Text('Vui lòng nhập đầy đủ thông tin'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // If valid, call register endpoint
    FocusScope.of(context).unfocus();
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    final name = _usernameController.text.trim();
    final username = _loginController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Đang gửi yêu cầu đăng ký...'),
        duration: Duration(seconds: 2),
      ),
    );

    AuthService.register(
      name: name,
      email: email,
      password: password,
      username: username,
    ).then((result) {
      final (ok, errorMsg) = result;
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      if (ok) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Đăng ký thành công'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 2),
          ),
        );
        // TODO: navigate to login or auto-login
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Đăng ký thất bại: ${errorMsg ?? 'Lỗi không xác định'}',
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
    _loginController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Form Đăng ký tài khoản'),
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
                          labelText: 'Họ Tên',
                          prefixIcon: const Icon(Icons.person),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Vui lòng nhập họ tên';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          prefixIcon: const Icon(Icons.email),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Vui lòng nhập email';
                          }
                          final emailReg = RegExp(
                            r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}",
                          );
                          if (!emailReg.hasMatch(value.trim())) {
                            return 'Email không hợp lệ';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: TextFormField(
                        controller: _loginController,
                        decoration: InputDecoration(
                          labelText: 'Tên đăng nhập',
                          prefixIcon: const Icon(Icons.person),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Vui lòng nhập tên đăng nhập';
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
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: TextFormField(
                        controller: _confirmController,
                        obscureText: _obscurePassword,
                        decoration: InputDecoration(
                          labelText: 'Xác nhận mật khẩu',
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
                            return 'Vui lòng nhập xác nhận mật khẩu';
                          }
                          if (value.trim().length < 6) {
                            return 'Mật khẩu phải có ít nhất 6 ký tự';
                          }
                          if (value.trim() != _passwordController.text.trim()) {
                            return 'Xác nhận mật khẩu không khớp';
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
                        'Đăng ký',
                        style: TextStyle(fontSize: 18, color: Colors.white),
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
