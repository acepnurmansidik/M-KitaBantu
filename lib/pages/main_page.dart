import 'package:flutter/material.dart';
import 'package:kitabantu/pages/home_page.dart';
import 'package:kitabantu/widgets/custom_bottom_nav.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HomePage(),
      bottomNavigationBar: CustomButtomNavigationBar(),
    );
  }
}
