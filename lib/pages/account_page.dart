import 'package:flutter/material.dart';
import 'package:kitabantu/theme.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    Widget profileSection(EdgeInsets margin) {
      return Container(
        width: double.infinity,
        margin: margin,
        padding: EdgeInsets.symmetric(horizontal: defaultPadding, vertical: 15),
        color: kWhitekColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 57,
              width: 57,
              margin: const EdgeInsets.only(right: 20),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage('assets/img_avatar.png'),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Acep Nurman Sidik',
                  style: blackTextStyle.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.label_important_outline,
                      color: kPrimaryColor,
                    ),
                    Text(
                      'Guest',
                      style: blackTextStyle.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      );
    }

    Widget itemMenu(
        String title, IconData icon, bool isBorder, Function() onDirectTo) {
      return GestureDetector(
        onTap: onDirectTo,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 15),
          decoration: BoxDecoration(
            border: isBorder
                ? Border(
                    bottom: BorderSide(color: kGreyColor),
                  )
                : const Border(),
          ),
          child: Row(
            children: [
              Icon(
                icon,
                color: kPrimaryColor,
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Text(
                  title,
                  style: blackTextStyle.copyWith(fontSize: 14),
                ),
              ),
              const Icon(Icons.chevron_right),
            ],
          ),
        ),
      );
    }

    Widget menuList() {
      return Container(
        width: double.infinity,
        margin: const EdgeInsets.only(top: 10),
        padding: EdgeInsets.symmetric(horizontal: defaultPadding, vertical: 15),
        color: kWhitekColor,
        child: Column(
          children: [
            itemMenu("Account", Icons.person_rounded, true, () {}),
            itemMenu("Help", Icons.help_outline, false, () {}),
          ],
        ),
      );
    }

    Widget menuAccount() {
      return Container(
        width: double.infinity,
        margin: const EdgeInsets.only(top: 10),
        padding: EdgeInsets.symmetric(horizontal: defaultPadding, vertical: 15),
        color: kWhitekColor,
        child: Column(
          children: [
            itemMenu("Setting", Icons.settings_rounded, true, () {}),
            itemMenu(
              "Privacy & Policy",
              Icons.privacy_tip_rounded,
              true,
              () {},
            ),
            itemMenu("Exit", Icons.exit_to_app_rounded, false, () {}),
          ],
        ),
      );
    }

    Widget versionInfo() {
      return Container(
        width: double.infinity,
        margin: const EdgeInsets.only(top: 50),
        padding: EdgeInsets.symmetric(horizontal: defaultPadding, vertical: 15),
        child: Column(
          children: [
            Text(
              'KitaBantu',
              style: blackTextStyle.copyWith(fontSize: 12),
            ),
            Text(
              'v1.0.2',
              style: blackTextStyle.copyWith(fontSize: 12),
            )
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: kLightGreyColor,
      body: ListView(
        children: [
          profileSection(EdgeInsets.zero),
          menuList(),
          menuAccount(),
          versionInfo()
        ],
      ),
    );
  }
}
