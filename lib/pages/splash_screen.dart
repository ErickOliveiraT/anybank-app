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
      backgroundColor: Color(0xFF131212),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Logo
              Column(
                children: [
                  Icon(
                    Icons.receipt_long,
                    size: 80.0,
                    color: Color(0xFFFEFEFE),
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    'AnyBank',
                    style: TextStyle(
                      fontSize: 32.0,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFFEFEFE),
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'DO JEITO QUE VOCÊ QUISER',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Color(0xFFFEFEFE),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 50.0),
              // Loading
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFFEFEFE)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
