import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:kitabantu/theme.dart';

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

    Widget slideItem({title = "", margin, onDirect}) {
      return GestureDetector(
        onTap: onDirect,
        child: Container(
          alignment: Alignment.center,
          width: double.infinity,
          color: Colors.amber,
          margin: margin,
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              title != ""
                  ? Container(
                      margin: const EdgeInsets.only(left: 20, bottom: 10),
                      child: Text(
                        title,
                        style: blackTextStyle.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    )
                  : const SizedBox(),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Container(
                      height: 160,
                      width: 180,
                      margin: EdgeInsets.only(left: defaultPadding),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    Container(
                      height: 160,
                      width: 180,
                      margin: EdgeInsets.only(left: defaultPadding),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    Container(
                      height: 160,
                      width: 180,
                      margin: EdgeInsets.only(
                        left: defaultPadding,
                        right: defaultPadding,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }

    Widget slideWithOptions(
        EdgeInsets marginVer, Function() onPressed, Function() onDirect) {
      Widget itemSlide(EdgeInsets marginHorizontal) {
        return GestureDetector(
          onTap: onPressed,
          child: Container(
            height: 60,
            width: 60,
            padding: const EdgeInsets.all(5),
            margin: marginHorizontal,
            decoration: BoxDecoration(
              color: kSecondaryColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.food_bank_outlined,
                  color: kPrimaryColor,
                  size: 30,
                ),
                Text(
                  'foods',
                  style: primaryTextStyle.copyWith(fontSize: 12),
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
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  itemSlide(EdgeInsets.only(left: defaultPadding)),
                  itemSlide(EdgeInsets.only(left: defaultPadding)),
                  itemSlide(EdgeInsets.only(left: defaultPadding)),
                  itemSlide(EdgeInsets.only(left: defaultPadding)),
                  itemSlide(EdgeInsets.only(left: defaultPadding)),
                  itemSlide(EdgeInsets.symmetric(horizontal: defaultPadding)),
                ],
              ),
            ),
            slideItem(
                margin: const EdgeInsets.only(top: 10), onDirect: onDirect)
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
                    // margin: const EdgeInsets.symmetric(horizontal: 20),
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
        slideItem(margin: const EdgeInsets.only(top: 30), onDirect: () {}),
      ],
    );
  }
}
