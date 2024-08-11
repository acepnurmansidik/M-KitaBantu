// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kitabantu/services/auth_service.dart';
import 'package:kitabantu/theme.dart';

class SplashScreenPage extends StatelessWidget {
  const SplashScreenPage({super.key});

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 3), () async {
      final result = await AuthService().getToken();

      if (result.token != "" && result.onboard ||
          result.token == "" && result.onboard) {
        Navigator.pushNamedAndRemoveUntil(context, '/main', (route) => false);
      } else {
        Navigator.pushNamedAndRemoveUntil(
            context, '/get-started', (route) => false);
      }
    });
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              margin: const EdgeInsets.only(bottom: 10),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/icon_logo.png'),
                ),
              ),
            ),
            Text(
              "Kita Bantu",
              style: primaryTextStyle.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.w900,
              ),
            )
          ],
        ),
      ),
    );
  }
}
