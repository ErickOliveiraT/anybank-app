import "package:flutter/material.dart";
import "../actions/login_action.dart";

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkToken();
  }

  Future<void> _checkToken() async {
    bool isUserAuthenticated = await checkSession("user");
    if (isUserAuthenticated) {
      bool isAccountAuthenticated = await checkSession("account");
      if (isAccountAuthenticated) {
        Navigator.of(context).pushReplacementNamed('/home');
      } else {
        Navigator.of(context).pushReplacementNamed('/account-selection');
      }
    } else {
      Navigator.of(context).pushReplacementNamed('/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child:
            CircularProgressIndicator(), // Exibe uma animação de carregamento enquanto verifica o token
      ),
    );
  }
}
