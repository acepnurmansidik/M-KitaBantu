import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:kitabantu/theme.dart';
import 'package:kitabantu/widgets/horizontal_slide_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;
  CarouselController controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    Widget profileSection(EdgeInsets margin) {
      return Container(
        width: double.infinity,
        margin: margin,
        padding: EdgeInsets.symmetric(
          horizontal: defaultPadding,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
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
                      'Hello,',
                      style: greyTextStyle.copyWith(
                          fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                    Text(
                      'Acep Nurman Sidik',
                      style: blackTextStyle.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: kSecondaryColor,
              ),
              child: const Icon(
                Icons.search,
                size: 30,
              ),
            ),
          ],
        ),
      );
    }

    Widget bannerSection(EdgeInsets margin, Function() onDirect) {
      return GestureDetector(
        onTap: onDirect,
        child: Container(
          height: 170,
          width: double.infinity,
          margin: const EdgeInsets.only(top: 30),
          color: kSecondaryColor,
        ),
      );
    }

    Widget slideWithOptions(
        EdgeInsets marginVer, Function() onPressed, Function() onDirect) {
      List categories = [
        {"title": "Pendidikan", "icon": Icons.school},
        {"title": "Kemanusiaan", "icon": Icons.bloodtype},
        {"title": "Panti Asuhan", "icon": Icons.home},
        {"title": "Lingkungan", "icon": Icons.nature},
      ];
      Widget itemSlide(
          String title, IconData icon, EdgeInsets marginHorizontal) {
        return Container(
          height: 40,
          margin: marginHorizontal,
          child: TextButton(
            onPressed: onPressed,
            style: TextButton.styleFrom(
                side: BorderSide(width: 1, color: kPrimaryColor)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  color: kPrimaryColor,
                  size: 20,
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  title,
                  style: blackTextStyle.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                )
              ],
            ),
          ),
        );
      }

      return Container(
        width: double.infinity,
        margin: marginVer,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: categories.asMap().entries.map((category) {
                  return itemSlide(
                    category.value["title"],
                    category.value["icon"],
                    EdgeInsets.only(
                        left: category.key == 0
                            ? defaultPadding
                            : defaultPadding / 2,
                        right: category.key == categories.length - 1
                            ? defaultPadding
                            : 0),
                  );
                }).toList(),
              ),
            ),
            const HorizontalSlideItem(
              bgAnimateImg: "",
            ),
          ],
        ),
      );
    }

    Widget carouselSection(EdgeInsets margin, Function() onDirect) {
      List data = [
        {
          "title": "Disini kita",
          "imgUrl": "",
          "desc": "",
          "totalDonate": "",
          "currentDonate": "",
          "comments": [
            {
              "userId": "",
              "username": "",
              "date": "",
              "comment": "",
            }
          ],
        },
        {
          "title": "Disana kamu",
          "imgUrl": "",
          "desc": "",
          "totalDonate": "",
          "currentDonate": "",
          "comments": [
            {
              "userId": "",
              "username": "",
              "date": "",
              "comment": "",
            }
          ],
        },
        {
          "title": "Disini diriku",
          "imgUrl": "",
          "desc": "",
          "totalDonate": "",
          "currentDonate": "",
          "comments": [
            {
              "userId": "",
              "username": "",
              "date": "",
              "comment": "",
            }
          ],
        },
      ];
      return GestureDetector(
        onTap: onDirect,
        child: Container(
          width: double.infinity,
          margin: margin,
          child: Stack(
            children: [
              CarouselSlider(
                options: CarouselOptions(
                  height: 150,
                  viewportFraction: 1,
                  onPageChanged: (index, reason) {
                    setState(() {
                      currentIndex = index;
                    });
                  },
                ),
                items: data.map((item) {
                  return Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: kPrimaryColor,
                    ),
                    child: Text(item["title"]),
                  );
                }).toList(),
              ),
              Container(
                alignment: Alignment.bottomLeft,
                height: 150,
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: defaultPadding,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: data.asMap().entries.map((item) {
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      height: 7,
                      width: currentIndex == item.key ? 15 : 7,
                      margin: const EdgeInsets.only(left: 3),
                      decoration: BoxDecoration(
                        color: currentIndex == item.key
                            ? kWhitekColor
                            : kGreyColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    );
                  }).toList(),
                ),
              )
            ],
          ),
        ),
      );
    }

    return ListView(
      children: [
        profileSection(
          const EdgeInsets.only(top: 30),
        ),
        bannerSection(const EdgeInsets.only(top: 30), () {}),
        slideWithOptions(const EdgeInsets.only(top: 30), () {}, () {}),
        carouselSection(const EdgeInsets.only(top: 30), () {}),
        const HorizontalSlideItem(
          startAtMargin: 150,
          bgAnimateImg: "assets/img_prayer.png",
        ),
      ],
    );
  }
}
