import 'package:anybank_app/pages/account_selection.dart';
import 'package:anybank_app/pages/splash_screen.dart';
import 'package:anybank_app/pages/transfer_1.dart';
import 'package:anybank_app/pages/transfer_2.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'pages/login_page.dart';
import 'config/provider.dart';
import 'pages/home.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
        create: (context) => UserData(),
        child: MaterialApp(
          initialRoute: '/',
          routes: {
            '/': (context) => SplashScreen(),
            '/home': (context) => const HomePage(),
            '/login': (context) => const LoginPage(),
            '/account-selection': (context) => AccountSelection(),
            '/transfer1': (context) => TransferScreen1(),
            '/transfer2': (context) => TransferScreen2(),
          },
        )),
  );
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
