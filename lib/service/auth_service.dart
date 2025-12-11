import 'package:app_phi_nam/service/api.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  // For dummyjson test: use username 'emilys' and password 'emilyspass'
  // Register - adjust endpoint path to match your backend/Postman mock
  static Future<(bool, String?)> register({
    required String name,
    required String email,
    required String password,
    required String username,
  }) async {
    try {
      final resp = await dio.post(
        '/users/add',
        data: {
          'firstName': name,
          'email': email,
          'password': password,
          'username': username,
        },
      );

      return (resp.statusCode == 200 || resp.statusCode == 201, null);
    } on DioException catch (e) {
      // Detailed logging for easier debugging (status, body, request URL)
      final status = e.response?.statusCode;
      final data = e.response?.data;
      final uri = e.requestOptions.uri;
      print('Register DioException: status=$status, uri=$uri');
      print('Response data: $data');
      String errMsg = 'Đăng ký thất bại';
      if (data is Map && data.containsKey('message')) {
        errMsg = data['message'].toString();
      }
      return (false, errMsg);
    } catch (e) {
      print('Register error: $e');
      return (false, e.toString());
    }
  }

  // Login - adjust request/response parsing for your backend
  static Future<(bool, String?)> login({
    required String emailOrUsername,
    required String password,
  }) async {
    try {
      final resp = await dio.post(
        '/user/login',
        data: {'username': emailOrUsername, 'password': password},
      );

      if (resp.statusCode == 200) {
        // dummyjson returns 'accessToken', generic APIs may use 'token'
        final token = resp.data['accessToken'] ?? resp.data['token'];
        if (token != null) {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('auth_token', token.toString());
          // Add header for subsequent requests
          dio.options.headers['Authorization'] = 'Bearer $token';
          return (true, null);
        }
      }
      return (false, 'Không nhận được token từ server');
    } on DioException catch (e) {
      // Detailed logging for easier debugging (status, body, request URL)
      final status = e.response?.statusCode;
      final data = e.response?.data;
      final uri = e.requestOptions.uri;
      print('Login DioException: status=$status, uri=$uri');
      print('Response data: $data');
      String errMsg = 'Đăng nhập thất bại';
      if (data is Map && data.containsKey('message')) {
        errMsg = data['message'].toString();
      }
      return (false, errMsg);
    } catch (e) {
      print('Login error: $e');
      return (false, e.toString());
    }
  }

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
    dio.options.headers.remove('Authorization');
  }
}
