import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vroom/view_model/auth_view.dart';
import 'home_screen.dart';
import 'login_screen.dart';

class Redirect extends StatelessWidget {
  const Redirect({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthView>(
      builder: (context, authView, child) {
        var status = authView.authStatus;
        switch (status) {
          case AuthStatus.authenticated:
            return const HomeScreen();
          case AuthStatus.unauthenticated:
            return const LoginScreen();
        }
      },
    );
  }
}
