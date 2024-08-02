import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:kitabantu/theme.dart';
import 'package:kitabantu/widgets/carousel_item.dart';

class GetStartedPage extends StatefulWidget {
  const GetStartedPage({super.key});

  @override
  State<GetStartedPage> createState() => _GetStartedPageState();
}

class _GetStartedPageState extends State<GetStartedPage> {
  int currentIndex = 0;
  CarouselController controllerCarousel = CarouselController();

  List<Map<String, dynamic>> onboardingItems = [
    {
      "title": 'Effective Strategies for Raising Funds in the Digital Era',
      "imgUrl": 'assets/img_phone.png',
      "subtitle":
          'In the digital era, raising funds from the community utilizes social media, crowdfunding, and email to reach a wider audience and strengthen relationships with donors.',
    },
    {
      "title": 'Innovative Collaboration in Modern Fundraising Campaigns',
      "imgUrl": 'assets/img_wallet.png',
      "subtitle":
          'Collaboration in modern fundraising campaigns combines resources from various parties to create stronger and more effective synergies.',
    },
    {
      "title": 'Relationship Building Techniques for Fundraising Success',
      "imgUrl": 'assets/img_colab.png',
      "subtitle":
          'Building strong relationships with donors through effective communication and transparency is the key to achieving success in fundraising.',
    },
  ];
  void _directToPage() {
    Navigator.pushNamedAndRemoveUntil(context, '/sign-up', (route) => false);
  }

  void _skipCarousel() {
    controllerCarousel.animateToPage(
      onboardingItems.length - 1,
      duration: const Duration(seconds: 1),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CarouselSlider(
              carouselController: controllerCarousel,
              options: CarouselOptions(
                enableInfiniteScroll: false,
                height: 650,
                viewportFraction: 1,
                onPageChanged: (index, reason) {
                  setState(() {
                    currentIndex = index;
                  });
                },
              ),
              items: onboardingItems.map((item) {
                return CarouselItem(
                  title: item["title"],
                  imgUrl: item["imgUrl"],
                  subtitle: item["subtitle"],
                );
              }).toList(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                currentIndex == 0
                    ? Container(
                        width: 90,
                        height: 55,
                        margin: const EdgeInsets.only(bottom: 33),
                        child: TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: kWhitekColor,
                            side: BorderSide(color: kPrimaryColor),
                          ),
                          onPressed: _skipCarousel,
                          child: Text(
                            'Skip',
                            style: primaryTextStyle.copyWith(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      )
                    : currentIndex == onboardingItems.length - 1
                        ? Container(
                            width: 180,
                            height: 55,
                            margin: const EdgeInsets.only(bottom: 33),
                            child: TextButton(
                              style: TextButton.styleFrom(
                                backgroundColor: kPrimaryColor,
                              ),
                              onPressed: _directToPage,
                              child: Text(
                                'Get Started',
                                style: whiteTextStyle.copyWith(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          )
                        : const SizedBox(),
                Container(
                  margin: const EdgeInsets.only(bottom: 43),
                  child: Row(
                    children: onboardingItems.asMap().entries.map((item) {
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        height: 12,
                        width: currentIndex == item.key ? 22 : 12,
                        margin: const EdgeInsets.only(left: 5),
                        decoration: BoxDecoration(
                          color: currentIndex == item.key
                              ? kPrimaryColor
                              : kGreyColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      );
                    }).toList(),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
