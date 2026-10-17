import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:vroom/screens/login_screen.dart';
import 'package:vroom/view_model/auth_view.dart';
import 'package:vroom/model/cart.dart';
import 'package:vroom/model/auth-exception.dart';

class MockAuthView extends Mock implements AuthView {}

void main() {
  late MockAuthView mockVm;

  setUp(() {
    mockVm = MockAuthView();

    when(() => mockVm.isLoading).thenReturn(false);

    when(
      () => mockVm.authStatus,
    ).thenReturn(AuthStatus.unauthenticated);

    when(
      () => mockVm.errorMessage,
    ).thenReturn(null);
  });

  Future<void> pumpLoginScreen(
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<CartModel>(
            create: (_) => CartModel(),
          ),
          ChangeNotifierProvider<AuthView>.value(
            value: mockVm,
          ),
        ],
        child: const MaterialApp(
          home: LoginScreen(),
        ),
      ),
    );

    await tester.pump();
  }

  testWidgets(
    'LoginScreen calls mockVm.login on successful login',
    (tester) async {
      SharedPreferences.setMockInitialValues({});

      when(
        () => mockVm.login(any(), any()),
      ).thenAnswer(
        (_) async => true,
      );

      await pumpLoginScreen(tester);

      final fields = find.byType(TextFormField);

      expect(fields, findsNWidgets(2));

      await tester.enterText(
        fields.at(0),
        'andy',
      );

      await tester.enterText(
        fields.at(1),
        'andyspassword',
      );

      final loginButton = find.text('Login');

      expect(loginButton, findsOneWidget);

      await tester.tap(loginButton);

      await tester.pump();
      await tester.pump();

      verify(
        () => mockVm.login(
          'andy',
          'andyspassword',
        ),
      ).called(1);
    },
  );

  testWidgets(
    'LoginScreen calls mockVm.login on failed login',
    (tester) async {
      SharedPreferences.setMockInitialValues({});

      when(
        () => mockVm.login(any(), any()),
      ).thenAnswer(
        (_) async => false,
      );

      await pumpLoginScreen(tester);

      final fields = find.byType(TextFormField);

      expect(fields, findsNWidgets(2));

      await tester.enterText(
        fields.at(0),
        'wrong',
      );

      await tester.enterText(
        fields.at(1),
        'wrongpass',
      );

      final loginButton = find.text('Login');

      expect(loginButton, findsOneWidget);

      await tester.tap(loginButton);

      await tester.pump();
      await tester.pump();

      verify(
        () => mockVm.login(
          'wrong',
          'wrongpass',
        ),
      ).called(1);
    },
  );
}

