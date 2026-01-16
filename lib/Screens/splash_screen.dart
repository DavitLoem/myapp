import 'package:exercise/data/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void checkLogin() async {
    var pref = await SharedPreferences.getInstance();
    var isLogin = pref.getBool("isLogin") ?? false;

    if (isLogin) {
      Navigator.pushReplacementNamed(context, AppRoutes.homeScreen);
    } else {
      Navigator.pushReplacementNamed(context, AppRoutes.loginScreen);
    }
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      // ignore: use_build_context_synchronously
      checkLogin();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/backgound.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Hero(
            tag: 'logo',
            child: Image.asset(
              'assets/logo.png',
              height: 90,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
