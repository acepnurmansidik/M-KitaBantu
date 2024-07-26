import 'package:flutter/material.dart';
import 'package:kitabantu/theme.dart';

class Indocator extends StatelessWidget {
  final List onboardingItems;
  final int index;
  const Indocator({
    super.key,
    required this.onboardingItems,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 43),
      child: Row(
        children: onboardingItems.asMap().entries.map((item) {
          return Container(
            height: 12,
            width: index == item.key ? 22 : 12,
            margin: const EdgeInsets.only(left: 5),
            decoration: BoxDecoration(
              color: index == item.key ? kPrimaryColor : kGreyColor,
              borderRadius: BorderRadius.circular(10),
            ),
          );
        }).toList(),
      ),
    );
  }
}
