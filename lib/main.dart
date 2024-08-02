import 'package:flutter/material.dart';
import 'package:kitabantu/pages/get_startred_page.dart';
import 'package:kitabantu/pages/main_page.dart';
import 'package:kitabantu/pages/signin_page.dart';
import 'package:kitabantu/pages/signup_page.dart';
import 'package:kitabantu/pages/splash_page.dart';
import 'package:kitabantu/pages/success_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => const SplashScreenPage(),
        '/get-started': (context) => const GetStartedPage(),
        '/main': (context) => const MainPage(),
        '/success': (context) => const SuccessPage(),
        '/sign-in': (context) => const SigninPage(),
        '/sign-up': (context) => const SignupPage(),
      },
    );
  }
}
