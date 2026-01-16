import 'package:exercise/Screens/checkout_screen.dart';
import 'package:exercise/Screens/detail_screen.dart';
import 'package:exercise/Screens/home_screen.dart';
import 'package:exercise/Screens/login_screen.dart';
import 'package:exercise/Screens/splash_screen.dart';
import 'package:exercise/Simple_E-commers/first_screen.dart';
import 'package:exercise/data/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        textTheme: GoogleFonts.spaceGroteskTextTheme(
          Theme.of(context).textTheme,
        ),
      ),

      // home: SqliteDemo(),
      initialRoute: AppRoutes.splashScreen,
      // initialRoute: AppRoutes.homeScreen,
      routes: {
        AppRoutes.homeScreen: (context) => HomeScreen(),
        AppRoutes.splashScreen: (context) => SplashScreen(),
        AppRoutes.loginScreen: (context) => LoginScreen(),
        AppRoutes.detailScreen: (context) => DetailScreen(),
        AppRoutes.checkoutScreen: (context) => CheckoutScreen(),
        AppRoutes.firstScreen: (context) => FirstScreen(),
      },
      // initialRoute: "/radioButtonEx",
      // routes: {
      //   "/radioButtonEx": (context) => RadioButtonEx(),
      //   "/dateTimeExample": (context) => DateTimeExample(),
      //   "/homescreen": (context) => SqliteDemo(),
      //   "/addDataScreen": (context) {
      //     final args = ModalRoute.of(context)?.settings.arguments;
      //     return AddDataScreen(data: args as Map<String, dynamic>?);
      //   },
      // },
    );
  }
}
