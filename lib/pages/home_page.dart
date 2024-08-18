import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kitabantu/cubit/campaign_cubit.dart';
import 'package:kitabantu/cubit/categories_cubit.dart';
import 'package:kitabantu/pages/detail_page.dart';
import 'package:kitabantu/theme.dart';
import 'package:kitabantu/widgets/horizontal_slide_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;
  int currentIndexCategory = 0;
  CarouselController controller = CarouselController();

  @override
  void initState() {
    context.read<CategoriesCubit>().fetchCategories();
    context.read<CampaignCubit>().fetchCampaigns();
    super.initState();
  }

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

    Widget slideWithOptions(EdgeInsets marginVer) {
      List categories = [
        {"title": "Pendidikan", "icon": Icons.school},
        {"title": "Kemanusiaan", "icon": Icons.bloodtype},
        {"title": "Panti Asuhan", "icon": Icons.home},
      ];
      Map iconCategories = {
        "Pendidikan": Icons.school,
        "Kemanusiaan": Icons.bloodtype,
        "Panti Asuhan": Icons.home,
        "Lingkungan": Icons.nature,
      };

      Widget itemSlide(
        String title,
        IconData icon,
        int index,
        EdgeInsets marginHorizontal,
        Function() onSelectPressed,
      ) {
        return Container(
          height: 40,
          margin: marginHorizontal,
          child: TextButton(
            onPressed: onSelectPressed,
            style: TextButton.styleFrom(
              side: BorderSide(
                width: 1,
                color:
                    index == currentIndexCategory ? kPrimaryColor : kGreyColor,
              ),
            ),
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
              child: BlocBuilder<CategoriesCubit, CategoriesState>(
                builder: (context, state) {
                  if (state is CategoriesSuccess) {
                    return Row(
                        children:
                            state.categories.asMap().entries.map((category) {
                      return itemSlide(
                        category.value.title,
                        iconCategories[category.value.title],
                        category.key,
                        EdgeInsets.only(
                            left: category.key == 0
                                ? defaultPadding
                                : defaultPadding / 2,
                            right: category.key == state.categories.length - 1
                                ? defaultPadding
                                : 0),
                        () {
                          context
                              .read<CampaignCubit>()
                              .fetchFilterCampaigns(category.value.slugName);
                          setState(() {
                            currentIndexCategory = category.key;
                          });
                        },
                      );
                    }).toList());
                  }

                  return Row(
                    children: categories.asMap().entries.map((category) {
                      return itemSlide(
                        "           ",
                        Icons.dangerous_rounded,
                        0,
                        EdgeInsets.only(
                            left: category.key == 0
                                ? defaultPadding
                                : defaultPadding / 2,
                            right: category.key == categories.length - 1
                                ? defaultPadding
                                : 0),
                        () {},
                      );
                    }).toList(),
                  );
                },
              ),
            ),
            BlocBuilder<CampaignCubit, CampaignState>(
              builder: (context, state) {
                if (state is CampaignSuccess) {
                  return HorizontalSlideItem(
                    campaigns: state.filterCampaigns,
                    bgAnimateImg: "",
                  );
                }
                return const HorizontalSlideItem(
                  campaigns: [],
                  bgAnimateImg: "",
                );
              },
            ),
          ],
        ),
      );
    }

    Widget carouselSection(EdgeInsets margin, Function() onDirect) {
      return GestureDetector(
        onTap: onDirect,
        child: Container(
          width: double.infinity,
          margin: margin,
          child: BlocBuilder<CampaignCubit, CampaignState>(
            builder: (context, state) {
              if (state is CampaignSuccess) {
                return Stack(
                  children: [
                    CarouselSlider(
                      options: CarouselOptions(
                        height: 180,
                        viewportFraction: 1,
                        onPageChanged: (index, reason) {
                          setState(() {
                            currentIndex = index;
                          });
                        },
                      ),
                      items: state.campaignsCarousel.map((item) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    DetailPage(dataCampaign: item),
                              ),
                            );
                          },
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(item.images.first.linkUrl),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    Container(
                      alignment: Alignment.bottomLeft,
                      height: 180,
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: defaultPadding,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:
                            state.campaignsCarousel.asMap().entries.map((item) {
                          return AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            height: 7,
                            width: currentIndex == item.key ? 15 : 7,
                            margin: const EdgeInsets.only(left: 3),
                            decoration: BoxDecoration(
                              color: currentIndex == item.key
                                  ? kWhitekColor
                                  : kSecondaryColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          );
                        }).toList(),
                      ),
                    )
                  ],
                );
              }

              return Stack(
                children: [
                  CarouselSlider(
                      options: CarouselOptions(
                        height: 180,
                        viewportFraction: 1,
                        onPageChanged: (index, reason) {
                          setState(() {
                            currentIndex = index;
                          });
                        },
                      ),
                      items: const []),
                  Container(
                    alignment: Alignment.bottomLeft,
                    height: 180,
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: defaultPadding,
                    ),
                  )
                ],
              );
            },
          ),
        ),
      );
    }

    return ListView(
      children: [
        profileSection(
          const EdgeInsets.only(top: 20),
        ),
        BlocBuilder<CampaignCubit, CampaignState>(
          builder: (context, state) {
            if (state is CampaignSuccess) {
              return GestureDetector(
                onTap: () {},
                child: Container(
                  height: 170,
                  width: double.infinity,
                  margin: const EdgeInsets.only(top: 20),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image:
                          NetworkImage(state.banner.first.images.first.linkUrl),
                    ),
                  ),
                ),
              );
            }
            return GestureDetector(
              onTap: () {},
              child: Container(
                height: 170,
                width: double.infinity,
                margin: const EdgeInsets.only(top: 30),
                color: kSecondaryColor,
              ),
            );
          },
        ),
        slideWithOptions(const EdgeInsets.only(top: 20)),
        carouselSection(const EdgeInsets.only(top: 20), () {}),
        BlocBuilder<CampaignCubit, CampaignState>(
          builder: (context, state) {
            if (state is CampaignSuccess) {
              return HorizontalSlideItem(
                campaigns: state.campaigns,
                startAtMargin: 150,
                bgAnimateImg: "assets/img_prayer.png",
              );
            }
            return const HorizontalSlideItem(
              campaigns: [],
              startAtMargin: 150,
              bgAnimateImg: "assets/img_prayer.png",
            );
          },
        ),
      ],
    );
  }
}
