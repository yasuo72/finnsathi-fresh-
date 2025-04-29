import 'dart:convert';
import 'package:http/http.dart' as http;
import '../app_config.dart';

class AuthService {
  static Future<http.Response> signup({
    required String name,
    required String dob,
    required String email,
    required String password,
    String? mobile,
  }) async {
    final url = Uri.parse('${AppConfig.backendBaseUrl}/api/signup');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'name': name,
        'dob': dob,
        'email': email,
        'password': password,
        'mobile': mobile,
      }),
    );
    return response;
  }

  static Future<http.Response> signin({
    String? email,
    String? mobile,
    required String password,
  }) async {
    final url = Uri.parse('${AppConfig.backendBaseUrl}/api/signin');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'mobile': mobile,
        'password': password,
      }),
    );
    return response;
  }

  static Future<http.Response> verifyOtp({
    String? email,
    String? mobile,
    required String otp,
  }) async {
    final url = Uri.parse('${AppConfig.backendBaseUrl}/api/verify');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'mobile': mobile,
        'otp': otp,
      }),
    );
    return response;
  }

  static Future<http.Response> forgotPassword({
    String? email,
    String? mobile,
  }) async {
    final url = Uri.parse('${AppConfig.backendBaseUrl}/api/forgot-password');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'mobile': mobile,
      }),
    );
    return response;
  }

  static Future<http.Response> resetPassword({
    String? email,
    String? mobile,
    required String otp,
    required String newPassword,
  }) async {
    final url = Uri.parse('${AppConfig.backendBaseUrl}/api/reset-password');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'mobile': mobile,
        'otp': otp,
        'newPassword': newPassword,
      }),
    );
    return response;
  }

  static Future<http.Response> getProfile(String token) async {
    final url = Uri.parse('${AppConfig.backendBaseUrl}/api/profile');
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    return response;
  }

  static Future<http.Response> updateProfile({
    required String token,
    String? name,
    String? dob,
  }) async {
    final url = Uri.parse('${AppConfig.backendBaseUrl}/api/profile');
    final response = await http.put(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        if (name != null) 'name': name,
        if (dob != null) 'dob': dob,
      }),
    );
    return response;
  }

  static Future<http.Response> changePassword({
    required String token,
    required String oldPassword,
    required String newPassword,
  }) async {
    final url = Uri.parse('${AppConfig.backendBaseUrl}/api/change-password');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'oldPassword': oldPassword,
        'newPassword': newPassword,
      }),
    );
    return response;
  }
}
