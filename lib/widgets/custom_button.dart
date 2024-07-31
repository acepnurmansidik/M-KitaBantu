import 'package:flutter/material.dart';
import 'package:kitabantu/theme.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final EdgeInsets margin;
  final Function() onPressed;

  const CustomButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.margin = EdgeInsets.zero,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: double.infinity,
      color: kWhitekColor,
      margin: margin,
      padding: EdgeInsets.symmetric(horizontal: defaultPadding, vertical: 15),
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(backgroundColor: kDarkRedColor),
        child: Text(
          title,
          style: whiteTextStyle.copyWith(
            fontSize: 14,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }
}
