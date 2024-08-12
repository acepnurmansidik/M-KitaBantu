// ignore_for_file: use_build_context_synchronously

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kitabantu/cubit/users_cubit.dart';
import 'package:kitabantu/models/users_model.dart';
import 'package:kitabantu/theme.dart';
import 'package:kitabantu/widgets/custom_button.dart';
import 'package:kitabantu/widgets/custom_input_item.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({super.key});

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  TextEditingController emailController = TextEditingController(text: "");
  TextEditingController passwordController = TextEditingController(text: "");

  void _forgotPassword() {}
  void _login() async {
    final fcmToken = await FirebaseMessaging.instance.getToken();
    context.read<UsersCubit>().signIn(LoginModel(
          email: emailController.text,
          password: passwordController.text,
          deviceToken: fcmToken.toString(),
        ));
  }

  void _directToSignUp() {
    Navigator.pushNamedAndRemoveUntil(context, '/sign-up', (context) => false);
  }

  void _appleAccount() {}
  void _googleAccount() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            height: 280,
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage("assets/img_gotongroyong.jpg"),
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(
                top: 30, right: defaultPadding, left: defaultPadding),
            child: Text(
              "Let's Connect With Us",
              style: blackTextStyle.copyWith(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          CustomInputItem(
            controller: emailController,
            hintText: "Email",
            margin: EdgeInsets.only(
                top: 30, right: defaultPadding, left: defaultPadding),
            isPassword: false,
          ),
          CustomInputItem(
            controller: passwordController,
            hintText: "Password",
            margin: EdgeInsets.only(
                top: 10, right: defaultPadding, left: defaultPadding),
            showIcon: true,
          ),
          GestureDetector(
            onTap: _forgotPassword,
            child: Container(
              alignment: Alignment.centerRight,
              margin: EdgeInsets.only(
                  top: 8, right: defaultPadding, left: defaultPadding),
              child: Text(
                "Forgot Password?",
                style: blackTextStyle.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          BlocConsumer<UsersCubit, UsersState>(
            listener: (context, state) {
              if (state is UsersLoginSuccess) {
                Navigator.pushNamedAndRemoveUntil(
                    context, '/main', (context) => false);
              }
            },
            builder: (context, state) {
              if (state is UsersLoading) {
                return Container(
                  height: 62,
                  padding: EdgeInsets.symmetric(
                      horizontal: defaultPadding, vertical: 5),
                  margin: const EdgeInsets.only(top: 30),
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              return CustomButton(
                title: 'Login',
                onPressed: _login,
                height: 62,
                bgColor: kPrimaryColor,
                margin: const EdgeInsets.only(top: 30),
              );
            },
          ),
          Container(
            margin: const EdgeInsets.only(top: 20),
            padding: EdgeInsets.symmetric(horizontal: defaultPadding),
            child: Center(
              child: Row(
                children: [
                  Expanded(
                    child: Divider(
                      color: kGreyColor,
                      thickness: 1,
                      endIndent: 10, // Jarak akhir sebelum teks
                    ),
                  ),
                  Text(
                    "or",
                    style: TextStyle(
                        color: kGreyColor, fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                    child: Divider(
                      color: kGreyColor,
                      thickness: 1,
                      indent: 10, // Jarak awal setelah teks
                    ),
                  ),
                ],
              ),
            ),
          ),
          CustomButton(
            title: 'Sign In With Apple',
            onPressed: _appleAccount,
            height: 62,
            bgColor: const Color(0xff3C3C3C),
            icon: Icons.apple_rounded,
            showIcon: true,
            margin: const EdgeInsets.only(top: 20),
          ),
          CustomButton(
            title: 'Sign In With Google',
            onPressed: _googleAccount,
            height: 62,
            bgColor: const Color(0xffffffff),
            textColor: const Color(0xff3C3C3C),
            imgIcon: 'assets/icon_google.png',
            showIcon: true,
          ),
          GestureDetector(
            onTap: _directToSignUp,
            child: Container(
              margin: const EdgeInsets.only(bottom: 25),
              height: 50,
              alignment: Alignment.center,
              child: Text.rich(
                TextSpan(
                    text: "Don't have an account, ",
                    style: blackTextStyle.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                    children: [
                      TextSpan(
                        text: "Sign Up?",
                        style: blackTextStyle.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                          color: kPrimaryColor,
                        ),
                      )
                    ]),
              ),
            ),
          )
        ],
      ),
    );
  }
}
