// ignore_for_file: dead_code

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kitabantu/cubit/page_cubit.dart';
import 'package:kitabantu/theme.dart';

class CustomButtomNavigationBar extends StatefulWidget {
  const CustomButtomNavigationBar({super.key});

  @override
  State<CustomButtomNavigationBar> createState() =>
      _CustomButtomNavigationBarState();
}

class _CustomButtomNavigationBarState extends State<CustomButtomNavigationBar> {
  List icons = [
    "assets/icon_home",
    "assets/icon_time",
    "assets/icon_notif",
    "assets/icon_user"
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kWhitekColor,
      height: 67,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: icons.asMap().entries.map((item) {
          return GestureDetector(
            onTap: () {
              setState(() {
                context.read<PageCubit>().setPage(item.key);
              });
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  height: 25,
                  width: 25,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        '${item.value}${context.watch<PageCubit>().state == item.key ? '_rouded.png' : '.png'}',
                      ),
                    ),
                  ),
                ),
                context.watch<PageCubit>().state == item.key
                    ? Container(
                        height: 4,
                        width: 25,
                        margin: const EdgeInsets.only(top: 7),
                        decoration: BoxDecoration(
                          color: kPrimaryColor,
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(10),
                          ),
                        ),
                      )
                    : const SizedBox(
                        height: 7,
                      )
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
