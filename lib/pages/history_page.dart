import 'package:flutter/material.dart';
import 'package:kitabantu/theme.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    Widget message(String title, String imgUrl, String city, String date,
        String countDate) {
      return Container(
        width: double.infinity,
        height: 100,
        padding: EdgeInsets.symmetric(horizontal: defaultPadding, vertical: 10),
        decoration: BoxDecoration(
            border: Border(
          top: BorderSide(
            width: 0.5,
            color: kGreyColor,
          ),
        )),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 40,
                  width: 40,
                  margin: const EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: kPrimaryColor,
                  ),
                ),
                SizedBox(
                  width: 230,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        title,
                        style: blackTextStyle.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                      Text(
                        city,
                        style: blackTextStyle.copyWith(
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                      Text(
                        'Donasi di $date',
                        style: blackTextStyle.copyWith(
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Text(
              '$countDate lalu',
              style: blackTextStyle.copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            )
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: kWhitekColor,
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, 55),
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: kWhitekColor,
          shadowColor: kWhitekColor,
          surfaceTintColor: kWhitekColor,
          elevation: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.arrow_back,
                  color: kBlackColor,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                'History',
                style: blackTextStyle.copyWith(fontSize: 20),
              )
            ],
          ),
        ),
      ),
      body: ListView(
        children: [
          message(
            "Wakaf tanah untuk anak-anak pelosok negeri demi meraih mimpi",
            "https://img.com",
            "Jombang",
            "14 July 2023",
            "12 Jam",
          ),
        ],
      ),
    );
  }
}
