import 'package:flutter/material.dart';
import 'package:kitabantu/theme.dart';
import 'package:kitabantu/widgets/custom_button.dart';

class SuccessPage extends StatelessWidget {
  const SuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: defaultPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 200,
                height: 200,
                margin: const EdgeInsets.only(bottom: 10),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/icon_success.png")),
                ),
              ),
              Text(
                "Donasi mu berhasil tersampaikan\nsemoga jadi berkah 🙏",
                style: blackTextStyle.copyWith(
                    fontSize: 20, fontWeight: FontWeight.w800),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 30,
              ),
              CustomButton(
                title: "Home",
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/main', (context) => false);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
