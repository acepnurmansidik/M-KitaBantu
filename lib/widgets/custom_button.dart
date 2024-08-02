import 'package:flutter/material.dart';
import 'package:kitabantu/theme.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final EdgeInsets margin;
  final Function() onPressed;
  final double height;
  final Color bgColor;
  final Color textColor;
  final IconData icon;
  final bool showIcon;
  final Color iconColor;
  final String imgIcon;

  const CustomButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.margin = EdgeInsets.zero,
    this.height = 50,
    this.bgColor = const Color(0xffe04c4c),
    this.textColor = const Color(0xffffffff),
    this.iconColor = const Color(0xffffffff),
    this.icon = Icons.abc_rounded,
    this.showIcon = false,
    this.imgIcon = "",
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: double.infinity,
      margin: margin,
      padding: EdgeInsets.symmetric(horizontal: defaultPadding, vertical: 5),
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
            backgroundColor: bgColor,
            side: BorderSide(
              color: kGreyColor,
            )),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (showIcon)
              Container(
                margin: const EdgeInsets.only(right: 5),
                child: Icon(
                  icon,
                  color: iconColor,
                  size: 21,
                ),
              ),
            if (imgIcon != "")
              Container(
                margin: const EdgeInsets.only(right: 5),
                width: 25,
                height: 25,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(imgIcon),
                  ),
                ),
              ),
            Text(
              title,
              style: whiteTextStyle.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w800,
                color: textColor,
                letterSpacing: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
