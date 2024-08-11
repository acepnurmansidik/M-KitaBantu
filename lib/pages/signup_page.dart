// ignore_for_file: use_build_context_synchronously

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kitabantu/cubit/users_cubit.dart';
import 'package:kitabantu/models/users_model.dart';
import 'package:kitabantu/theme.dart';
import 'package:kitabantu/widgets/custom_button.dart';
import 'package:kitabantu/widgets/custom_input_item.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  TextEditingController usernameController = TextEditingController(text: "");
  TextEditingController emailController = TextEditingController(text: "");
  TextEditingController passwordController = TextEditingController(text: "");
  TextEditingController confirmPasswordController =
      TextEditingController(text: "");

  void _directToSignIn() {
    Navigator.pushNamedAndRemoveUntil(context, '/sign-in', (context) => false);
  }

  void _register() async {
    if (passwordController.text == confirmPasswordController.text) {
      final fcmToken = await FirebaseMessaging.instance.getToken();
      context.read<UsersCubit>().signUp(
            RegisterModel(
              email: emailController.text,
              password: passwordController.text,
              deviceToken: fcmToken.toString(),
              username: usernameController.text,
            ),
          );
    }
  }

  void _appleAccount() {}
  void _googleAccount() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            alignment: Alignment.topLeft,
            margin: EdgeInsets.only(
                top: 30, right: defaultPadding, left: defaultPadding),
            child: Text(
              "Sign Up",
              style: blackTextStyle.copyWith(
                fontSize: 28,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          Container(
            alignment: Alignment.topLeft,
            margin: EdgeInsets.only(
                top: 5, right: defaultPadding, left: defaultPadding),
            child: Text(
              "Let's help more people",
              style: blackTextStyle.copyWith(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          CustomInputItem(
            controller: usernameController,
            hintText: "Username",
            margin: EdgeInsets.only(
                top: 30, right: defaultPadding, left: defaultPadding),
            isPassword: false,
          ),
          CustomInputItem(
            controller: emailController,
            hintText: "Email",
            margin: EdgeInsets.only(
                top: 10, right: defaultPadding, left: defaultPadding),
            isPassword: false,
          ),
          CustomInputItem(
            controller: passwordController,
            hintText: "Password",
            margin: EdgeInsets.only(
                top: 10, right: defaultPadding, left: defaultPadding),
            showIcon: true,
          ),
          CustomInputItem(
            controller: confirmPasswordController,
            hintText: "Confirm Password",
            margin: EdgeInsets.only(
                top: 10, right: defaultPadding, left: defaultPadding),
            showIcon: true,
          ),
          BlocConsumer<UsersCubit, UsersState>(
            listener: (context, state) {
              if (state is UsersFailed) {
              } else if (state is UsersRegisterSuccess) {
                Navigator.pushNamedAndRemoveUntil(
                    context, '/main', (route) => false);
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
                title: 'Register',
                onPressed: _register,
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
            title: 'Sign Up With Apple',
            onPressed: _appleAccount,
            height: 62,
            bgColor: const Color(0xff3C3C3C),
            icon: Icons.apple_rounded,
            showIcon: true,
            margin: const EdgeInsets.only(top: 20),
          ),
          CustomButton(
            title: 'Sign Up With Google',
            onPressed: _googleAccount,
            height: 62,
            bgColor: const Color(0xffffffff),
            textColor: const Color(0xff3C3C3C),
            imgIcon: 'assets/icon_google.png',
            showIcon: true,
          ),
          GestureDetector(
            onTap: _directToSignIn,
            child: Container(
              margin: const EdgeInsets.only(bottom: 25),
              height: 50,
              alignment: Alignment.center,
              child: Text.rich(
                TextSpan(
                    text: "Do you have account? ",
                    style: blackTextStyle.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                    children: [
                      TextSpan(
                        text: "Sign In",
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
