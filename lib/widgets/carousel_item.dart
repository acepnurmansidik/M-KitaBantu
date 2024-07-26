import 'package:flutter/material.dart';
import 'package:kitabantu/theme.dart';

class CarouselItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imgUrl;

  const CarouselItem({
    super.key,
    required this.title,
    required this.imgUrl,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 321,
            height: 283,
            margin: const EdgeInsets.only(top: 70),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(imgUrl),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 47),
            child: Text(
              title,
              style: primaryTextStyle.copyWith(
                fontSize: 28,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 22),
            child: Text(
              subtitle,
              style: greyTextStyle.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
