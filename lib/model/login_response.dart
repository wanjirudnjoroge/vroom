import 'dart:convert';
import 'user.dart';

class LoginResponse {
  final User user;
  final String accessToken;
  final String refreshToken;

  LoginResponse({
    required this.user,
    required this.accessToken,
    required this.refreshToken,
  });

  factory LoginResponse.fromResponse(dynamic response) {
    var json = jsonDecode(response.body);
    return LoginResponse(
      user: User.fromJson(json),
      accessToken: json['accessToken'] ,
      refreshToken: json['refreshToken'] ,
    );
  }
}
