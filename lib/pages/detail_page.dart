import 'package:flutter/material.dart';
import 'package:kitabantu/theme.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  double heightScroll = 0;

  @override
  Widget build(BuildContext context) {
    Widget itemInfo(String title, int total, IconData icon, Color color) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        margin: const EdgeInsets.only(top: 15),
        child: Column(
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  size: 18,
                  color: color,
                ),
                const SizedBox(
                  width: 3,
                ),
                Text(
                  '$total',
                  style: blackTextStyle.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            Text(
              title,
              style: blackTextStyle.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      );
    }

    Widget directItem(
        String title, bool bottomBorder, int badgeInfo, Function() onDirectTo) {
      return GestureDetector(
        onTap: onDirectTo,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            border: bottomBorder
                ? Border(
                    bottom: BorderSide(
                      width: 0.5,
                      color: kGreyColor,
                    ),
                  )
                : const Border.symmetric(),
          ),
          child: Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Text(
                      title,
                      style: blackTextStyle.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    badgeInfo != 0
                        ? Container(
                            alignment: Alignment.center,
                            height: 30,
                            padding: EdgeInsets.symmetric(
                              horizontal: defaultPadding / 2,
                              vertical: 5,
                            ),
                            margin: const EdgeInsets.only(left: 10),
                            decoration: BoxDecoration(
                              color: kBaseColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              "$badgeInfo",
                              style: primaryTextStyle.copyWith(
                                fontSize: 14,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          )
                        : const SizedBox(
                            height: 30,
                          )
                  ],
                ),
              ),
              const Icon(Icons.chevron_right)
            ],
          ),
        ),
      );
    }

    Widget titleSection() {
      return Container(
        padding: EdgeInsets.all(defaultPadding),
        width: double.infinity,
        color: kWhitekColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Bantu sesama kemanusiaan',
              style: blackTextStyle.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 5),
                      child: Text(
                        'Rp. 20.000.000',
                        style: primaryTextStyle.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 5),
                      child: Text.rich(
                        TextSpan(
                          text: 'Terkumpul dari: ',
                          style: blackTextStyle.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                          children: [
                            TextSpan(
                              text: 'Rp. 2.000.000',
                              style: blackTextStyle.copyWith(
                                fontSize: 14,
                                fontWeight: FontWeight.w800,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(top: 5),
                  child: Text(
                    '15 Hari lagi',
                    style: primaryTextStyle.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ],
            ),
            Stack(
              children: [
                Container(
                  height: 5,
                  width: double.infinity,
                  margin: const EdgeInsets.only(top: 10),
                  decoration: BoxDecoration(
                    color: kGreyColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                Container(
                  height: 5,
                  width: (MediaQuery.of(context).size.width -
                          (2 * defaultPadding)) *
                      (50 / 100),
                  margin: const EdgeInsets.only(top: 10),
                  decoration: BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                itemInfo(
                  "Donasi",
                  4000,
                  Icons.favorite_rounded,
                  kRedColor,
                ),
                itemInfo(
                  "Kabar Terbaru",
                  4000,
                  Icons.newspaper_rounded,
                  kPrimaryColor,
                ),
              ],
            )
          ],
        ),
      );
    }

    Widget contentInfoSection() {
      return Container(
        padding: EdgeInsets.all(defaultPadding),
        margin: const EdgeInsets.only(top: 10),
        width: double.infinity,
        color: kWhitekColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Informasi Penggalangan Dana",
              style: blackTextStyle.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w800,
              ),
            ),
            Container(
              padding: EdgeInsets.all(defaultPadding),
              margin: const EdgeInsets.only(top: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(width: 0.5, color: kGreyColor),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Penggalang dana",
                    style: blackTextStyle,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: kSecondaryColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Sahabat oerang baik',
                            style: blackTextStyle.copyWith(
                              fontSize: 14,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                          Text(
                            'Identitas lembaga terverifikasi',
                            style: blackTextStyle.copyWith(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(defaultPadding / 2),
              margin: const EdgeInsets.only(top: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(width: 0.5, color: kGreyColor),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        const Icon(Icons.pending_outlined),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Rincian pengguanaan dana",
                          style: blackTextStyle,
                        ),
                      ],
                    ),
                  ),
                  const Icon(Icons.chevron_right)
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(defaultPadding / 2),
              margin: const EdgeInsets.only(top: 20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Cerita Penggalangan Dana',
                              style: blackTextStyle.copyWith(
                                fontSize: 14,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              '27 Maret 20234',
                              style: greyTextStyle.copyWith(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Icon(Icons.chevron_right)
                    ],
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10),
              child: Column(
                children: [
                  Stack(
                    children: [
                      SizedBox(
                        height: 200,
                        child: const Text(
                          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
                          textAlign: TextAlign.justify,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 10,
                        ),
                      ),
                      Container(
                        height: 70,
                        margin: const EdgeInsets.only(top: 130),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              const Color.fromRGBO(255, 255, 255, 0.2),
                              kWhitekColor
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    alignment: Alignment.bottomLeft,
                    margin: const EdgeInsets.only(top: 10),
                    child: Text(
                      "Baca selengkapnya",
                      style: primaryTextStyle.copyWith(
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      );
    }

    Widget contentDetailSection() {
      Widget personItem(int amount, String dateTime) {
        return Container(
          margin: const EdgeInsets.only(top: 10),
          padding: EdgeInsets.symmetric(
            vertical: 20,
            horizontal: defaultPadding,
          ),
          color: kLightGreyColor,
          child: Row(
            children: [
              Container(
                height: 60,
                width: 60,
                margin: const EdgeInsets.only(right: 20),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: kWhitekColor,
                ),
                child: Icon(
                  Icons.person,
                  color: kGreyColor,
                  size: 40,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Orang Baik',
                    style: blackTextStyle.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text.rich(
                    TextSpan(
                      text: 'Berdonasi sebesar ',
                      style: blackTextStyle.copyWith(fontSize: 14),
                      children: [
                        TextSpan(
                          text: 'Rp. $amount',
                          style: blackTextStyle.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w800,
                          ),
                        )
                      ],
                    ),
                  ),
                  Text(
                    '$dateTime menit lalu',
                    style: blackTextStyle.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      }

      return Container(
        padding: EdgeInsets.all(defaultPadding),
        margin: const EdgeInsets.symmetric(vertical: 10),
        width: double.infinity,
        color: kWhitekColor,
        child: Column(
          children: [
            directItem("Kabar Terbaru", true, 0, () {}),
            directItem("Pencairan Dana", true, 0, () {}),
            directItem("Funddraiser", true, 0, () {}),
            directItem("Donasi", true, 0, () {}),
            personItem(5000, "14"),
            personItem(5000, "14"),
            personItem(5000, "14"),
          ],
        ),
      );
    }

    Widget peoplsPrayersSection() {
      Widget btnAction(
          String title, IconData icon, Color color, Function() onPressed) {
        return GestureDetector(
          onTap: onPressed,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            margin: const EdgeInsets.only(top: 15),
            child: Row(
              children: [
                Icon(
                  icon,
                  size: 18,
                  color: color,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  title,
                  style: blackTextStyle.copyWith(
                      fontSize: 14, fontWeight: FontWeight.w500, color: color),
                ),
              ],
            ),
          ),
        );
      }

      Widget personPrayer(Function() onPressed) {
        return Container(
          padding: EdgeInsets.all(defaultPadding),
          margin: const EdgeInsets.only(top: 15),
          decoration: BoxDecoration(
            border: Border.all(width: 0.5, color: kGreyColor),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 35,
                    width: 35,
                    margin: const EdgeInsets.only(right: 20),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: kLightGreyColor,
                    ),
                    child: Icon(
                      Icons.person,
                      color: kGreyColor,
                      size: 20,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Orang Baik',
                          style: blackTextStyle.copyWith(
                            fontSize: 12,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        Text(
                          '14 menit lalu',
                          style: blackTextStyle.copyWith(
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(Icons.more_horiz)
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
                style: blackTextStyle.copyWith(
                  fontSize: 12,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text.rich(
                TextSpan(
                  text: "5 orang ",
                  style: blackTextStyle.copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                  children: [
                    TextSpan(
                      text: "mengirimkan doa ini",
                      style: blackTextStyle.copyWith(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 1,
                color: kGreyColor,
                margin: const EdgeInsets.only(top: 5),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  btnAction("Like", Icons.favorite, kGreyColor, onPressed),
                  btnAction("Bagikan", Icons.share, kGreyColor, () {}),
                ],
              )
            ],
          ),
        );
      }

      return Container(
        padding: EdgeInsets.all(defaultPadding),
        margin: const EdgeInsets.only(top: 10, bottom: 20),
        width: double.infinity,
        color: kWhitekColor,
        child: Column(
          children: [
            directItem('Doa-doa #Orang Baik', false, 58, () => null),
            personPrayer(() {}),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: kLightGreyColor,
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: 255 - heightScroll,
            decoration: BoxDecoration(color: kWhitekColor),
          ),
          Container(
            width: double.infinity,
            height: 250 - heightScroll,
            decoration: BoxDecoration(
              color: kSecondaryColor,
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(100),
              ),
            ),
          ),
          NotificationListener<ScrollNotification>(
            onNotification: (notification) {
              if (notification.metrics.pixels / 10 >= 0 &&
                  notification.metrics.pixels / 10 <= 24) {
                setState(() {
                  heightScroll =
                      (notification.metrics.pixels / 10).ceilToDouble() * 6;
                });
              } else {
                setState(() {
                  heightScroll = 250;
                });
              }

              return true;
            },
            child: ListView(
              padding: const EdgeInsets.only(top: 250),
              children: [
                titleSection(),
                contentInfoSection(),
                contentDetailSection(),
                peoplsPrayersSection(),
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: Container(
        height: 70,
        width: double.infinity,
        color: kWhitekColor,
        padding: EdgeInsets.symmetric(horizontal: defaultPadding, vertical: 15),
        child: TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          style: TextButton.styleFrom(backgroundColor: kDarkRedColor),
          child: Text(
            "Donasi sekarang",
            style: whiteTextStyle.copyWith(
              fontSize: 14,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ),
    );
  }
}
