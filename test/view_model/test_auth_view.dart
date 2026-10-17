import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:vroom/view_model/auth_view.dart';
import 'package:vroom/services/auth_api.dart';
import 'package:vroom/model/login_response.dart';
import 'package:vroom/model/user.dart';
import 'package:vroom/model/auth-exception.dart';

class MockAuthApi extends Mock implements AuthApi {}

void main() {
  late MockAuthApi mockApi;
  late AuthView vm;

  final mockUser = User(
    id: 1,
    username: 'student',
    email: 'andy@gmail.com',
    firstname: 'Andy',
    lastname: 'laique',
    gender: 'female',
    image: 'https://dummyjson.com',
  );

  setUpAll(() {
    SharedPreferences.setMockInitialValues({});
  });

  setUp(() {
    mockApi = MockAuthApi();
    vm = AuthView(authApi: mockApi);
  });

  group('AuthView login', () {
    test('successful login saves tokens and sets authenticated', () async {
      when(() => mockApi.login(any(), any())).thenAnswer(
        (_) async => LoginResponse(
          user: mockUser,
          accessToken: 'access123',
          refreshToken: 'refresh123',
        ),
      );

      final success = await vm.login('andy', 'andyspassword');

      expect(success, isTrue);
      expect(vm.authStatus, AuthStatus.authenticated);
      expect(vm.result?.user.firstname, 'Andy');

      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getString(AuthView.accessTokenKey), 'access123');
      expect(prefs.getString(AuthView.refreshTokenKey), 'refresh123');
    });

    test('failed login ', () async {
      SharedPreferences.setMockInitialValues({}); 

      when(
        () => mockApi.login(any(), any()),
      ).thenThrow(AuthException('Invalid credentials'));

      final success = await vm.login('wrong_user', 'wrong_pass');

      expect(success, isFalse);
      expect(vm.authStatus, AuthStatus.unauthenticated);
      expect(vm.errorMessage, contains('Invalid credentials'));
    });
  });
}
