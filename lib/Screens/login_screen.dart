import 'package:exercise/data/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  void login() async {
    var pref = await SharedPreferences.getInstance();
    pref.setBool("isLogin", true);
    // ignore: use_build_context_synchronously
    Navigator.pushReplacementNamed(context, AppRoutes.homeScreen);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Hero(
                tag: 'logo',
                child: Image.asset(
                  'assets/logo.png',
                  height: 50,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 50),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    login();
                  },
                  child: const Text('LOG IN'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
