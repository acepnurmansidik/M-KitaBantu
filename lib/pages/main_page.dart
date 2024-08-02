import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kitabantu/cubit/page_cubit.dart';
import 'package:kitabantu/pages/account_page.dart';
import 'package:kitabantu/pages/history_page.dart';
import 'package:kitabantu/pages/home_page.dart';
import 'package:kitabantu/pages/inbox_page.dart';
import 'package:kitabantu/widgets/custom_bottom_nav.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: switch (context.watch<PageCubit>().state) {
        0 => const HomePage(),
        1 => const HistoryPage(),
        2 => const InboxPage(),
        3 => const AccountPage(),
        int() => throw UnimplementedError(),
      },
      bottomNavigationBar: const CustomButtomNavigationBar(),
    );
  }
}
