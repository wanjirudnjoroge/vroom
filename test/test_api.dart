import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

import 'package:vroom/model/auth-exception.dart';
import 'package:vroom/services/auth_api.dart';

class MockhttpClient extends Mock implements http.Client {}

void main() {
  late MockhttpClient mockClient;
  late AuthApi authApi;

  setUp(() {
    mockClient = MockhttpClient();
    authApi = AuthApi(mockClient);

    registerFallbackValue(Uri());
  });

  group('AuthApi Login Tests', () {
    test('login returns LoginResponse on 200 success', () async {
      final mockResponseData = {
        'id': 1,
        'username': 'student',
        'email': 'student@example.com',
        'firstName': 'John',
        'lastName': 'Doe',
        'gender': 'male',
        'image': 'https://dummyjson.com',
        'accessToken': 'access123',
        'refreshToken': 'refresh123',
      };

      when(
        () => mockClient.post(
          Uri.parse('https://dummyjson.com/auth/login'),
          headers: any(named: 'headers'),
          body: any(named: 'body'),
        ),
      ).thenAnswer(
        (_) async => http.Response(jsonEncode(mockResponseData), 200),
      );

      final result = await authApi.login('student', 'password123');

      expect(result.accessToken, 'access123');
      expect(result.refreshToken, 'refresh123');
      expect(result.user.username, 'student');
    });

    test('test failed login', () async {
      final mockErrorData = {'message': 'Invalid credentials'};

      when(
        () => mockClient.post(
          Uri.parse('https://dummyjson.com/auth/login'),
          headers: any(named: 'headers'),
          body: any(named: 'body'),
        ),
      ).thenAnswer((_) async => http.Response(jsonEncode(mockErrorData), 400));

      expect(
        () async => await authApi.login('wrong_user', 'wrong_pass'),
        throwsA(
          isA<AuthException>().having(
            (e) => e.toString(),
            'message',
            contains ('Invalid credentials'),
          ),
        ),
      );
    });
  });

  group('AuthApi Fetch User Tests', () {
    test('fetchCurrentUser returns User object on 200 success', () async {
      final dummyResponse = {
        'id': 1,
        'username': 'student',
        'email': 'student@example.com',
        'firstName': 'John',
        'lastName': 'Doe',
        'gender': 'male',
        'image': 'https://dummyjson.com',
        'accessToken': 'mock_access_token',
        'refreshToken': 'mock_refresh_token123',
      };

      when(
        () => mockClient.get(
          Uri.parse('https://dummyjson.com/auth/me'),
          headers: any(named: 'headers'),
        ),
      ).thenAnswer((_) async => http.Response(jsonEncode(dummyResponse), 200));

      final result = await authApi.fetchCurrentUser('mock_access_token');

      expect(result.username, 'student');
      expect(result.id, 1);
    });
  });
}
