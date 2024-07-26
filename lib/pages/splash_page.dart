import 'package:flutter/material.dart';
import 'package:kitabantu/theme.dart';

class SplashScreenPage extends StatelessWidget {
  const SplashScreenPage({super.key});

  @override
  Widget build(BuildContext context) {
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
                fontWeight: bold,
              ),
            )
          ],
        ),
      ),
    );
  }
}
