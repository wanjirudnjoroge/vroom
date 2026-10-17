import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vroom/model/auth-exception.dart';
import 'package:vroom/model/login_response.dart';
import 'package:vroom/services/auth_api.dart';

enum AuthStatus { authenticated, unauthenticated }

class AuthView extends ChangeNotifier {
  late AuthApi _authApi;
  String? errorMessage;
  LoginResponse? result;
  bool isLoading = false;

  static const String accessTokenKey = 'ACCESSTOKEN';
  static const String refreshTokenKey = 'REFRESHTOKEN';

  AuthStatus _authStatus = AuthStatus.unauthenticated;

  AuthStatus get authStatus => _authStatus;

  AuthView({AuthApi? authApi}) {
    _authApi = authApi ?? AuthApi(http.Client());
  }

  Future<bool> login(String username, String password) async {
    bool success = false;
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      result = await _authApi.login(username, password);
      await saveTokens(result!.accessToken, result!.refreshToken);
      _authStatus = AuthStatus.authenticated;
      success = true;
    } on AuthException catch (e) {
      errorMessage = e.message;
      _authStatus = AuthStatus.unauthenticated;
      success = false;
    } catch (e) {
      errorMessage = e.toString();
      _authStatus = AuthStatus.unauthenticated;
      success = false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
    return success;
  }

  Future<void> saveTokens(String accessToken, String refreshToken) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(accessTokenKey, accessToken);
    await prefs.setString(refreshTokenKey, refreshToken);
  }

  Future<void> autologin() async {
    final prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString(accessTokenKey);
    String? refreshToken = prefs.getString(refreshTokenKey);

    if (accessToken != null && accessToken.isNotEmpty) {
      try {
        await _authApi.fetchCurrentUser(accessToken);
        _authStatus = AuthStatus.authenticated;
      } catch (e) {
        if (refreshToken != null && refreshToken.isNotEmpty) {
          try {
            final tokens = await _authApi.refresh(refreshToken);
            accessToken = tokens.accessToken;
            refreshToken = tokens.refreshToken;
            await saveTokens(accessToken, refreshToken);
            _authStatus = AuthStatus.authenticated;
          } catch (refreshError) {
            _authStatus = AuthStatus.unauthenticated;
          }
        } else {
          _authStatus = AuthStatus.unauthenticated;
        }
      }
    } else {
      _authStatus = AuthStatus.unauthenticated;
    }
    notifyListeners();
  }

  Future<void> logout() async {
    await _authApi.logout();
    _authStatus = AuthStatus.unauthenticated;
    result = null;
    notifyListeners();
  }
}
