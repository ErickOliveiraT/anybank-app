import 'package:anybank_app/pages/account_selection.dart';
import 'package:anybank_app/pages/splash_screen.dart';
import 'package:flutter/material.dart';
import 'pages/login_page.dart';
import 'pages/home.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => SplashScreen(),
      '/home': (context) => const HomePage(),
      '/login': (context) => const LoginPage(),
      '/account-selection': (context) => AccountSelection(),
    },
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
