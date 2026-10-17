import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vroom/model/auth-exception.dart';
import 'package:vroom/model/login_response.dart';
import 'package:vroom/model/token_response.dart';
import 'package:vroom/model/user.dart';

class AuthApi {
  final String baseUrl = "https://dummyjson.com";
  final http.Client _client;

  AuthApi(this._client);

  Future<LoginResponse> login(String username, String password) async {
    final url = Uri.parse('$baseUrl/auth/login');

    final response = await _client.post(
      url,
      headers: {"Content-type": "application/json"},
      body: jsonEncode({'username': username, 'password': password}),
    );

    if (response.statusCode != 200) {
      var body = jsonDecode(response.body);
      throw AuthException(body['message'] ?? 'Login Error');
    } else {
      var json = jsonDecode(response.body);
      return LoginResponse(
        user: User.fromJson(json),
        accessToken: json['accessToken'],
        refreshToken: json['refreshToken'],
      );
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('ACCESSTOKEN');
    await prefs.remove('REFRESHTOKEN');
  }

  Future<User> fetchCurrentUser(String accessToken) async {
    final url = Uri.parse("$baseUrl/auth/me");

    final response = await _client.get(
      url,
      headers: {
        "Content-type": "application/json",
        "Authorization": "Bearer $accessToken",
      },
    );

    if (response.statusCode != 200) {
      var body = jsonDecode(response.body);
      throw AuthException(body['message'] ?? 'Token Error');
    } else {
      var json = jsonDecode(response.body);
      return User.fromJson(json);
    }
  }

  Future<TokenResponse> refresh(String refreshToken) async {
    final url = Uri.parse("$baseUrl/auth/refresh");

    final response = await _client.post(
      url,
      headers: {"Content-type": "application/json"},
      body: jsonEncode({'refreshToken': refreshToken}),
    );

    if (response.statusCode != 200) {
      var body = jsonDecode(response.body);
      throw AuthException(body['message'] ?? 'Refresh Error');
    } else {
      var json = jsonDecode(response.body);
      return TokenResponse(
        accessToken: json['accessToken'],
        refreshToken: json['refreshToken'],
      );
    }
  }
}
