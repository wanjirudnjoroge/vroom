import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vroom/model/cart.dart';
import 'package:vroom/screens/redirect.dart';
import 'package:vroom/view_model/auth_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CartModel()),
        ChangeNotifierProvider(create: (context) => AuthView()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: 'OpenSans'),
        home: const Redirect(),
      ),
    );
  }
}
