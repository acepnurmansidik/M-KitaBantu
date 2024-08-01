import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kitabantu/pages/detail_page.dart';
import 'package:kitabantu/theme.dart';

class HorizontalSlideItem extends StatefulWidget {
  final String title;
  final String bgAnimateImg;
  final double startAtMargin;

  const HorizontalSlideItem({
    super.key,
    this.title = "",
    this.bgAnimateImg = "",
    this.startAtMargin = 20,
  });

  @override
  State<HorizontalSlideItem> createState() => _HorizontalSlideItemState();
}

class _HorizontalSlideItemState extends State<HorizontalSlideItem> {
  double _scrollHorzOpacity = 1;
  double _scrollMargin = 10;

  @override
  Widget build(BuildContext context) {
    Widget slideItem(EdgeInsets margin) {
      return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const DetailPage(),
            ),
          );
        },
        child: Container(
          height: 210,
          width: 190,
          margin: margin,
          decoration: BoxDecoration(
            color: kWhitekColor,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: kGreyColor.withOpacity(.2), // Warna bayangan
                spreadRadius: 5, // Seberapa besar bayangan menyebar
                blurRadius: 5, // Seberapa blur bayangan
                offset: const Offset(0, 3), // Posisi bayangan
              ),
            ],
          ),
          child: Column(
            children: [
              Container(
                height: 115,
                decoration: BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.circular(10)),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Kebahagiaan berbagi sesama untuk yang membutuhkan uluran tangan",
                      style: blackTextStyle.copyWith(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text.rich(
                      TextSpan(
                          text: "Terkumpul ",
                          style: blackTextStyle.copyWith(
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                          ),
                          children: [
                            TextSpan(
                              text: NumberFormat.currency(
                                      symbol: "", decimalDigits: 0)
                                  .format(4000000),
                              style: primaryTextStyle.copyWith(
                                fontSize: 12,
                                fontWeight: FontWeight.w800,
                              ),
                            )
                          ]),
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
                                  (2 * defaultPadding + 180)) *
                              (70 / 100),
                          margin: const EdgeInsets.only(top: 10),
                          decoration: BoxDecoration(
                            color: kPrimaryColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      );
    }

    return Container(
      alignment: Alignment.centerLeft,
      width: double.infinity,
      height: 230,
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          colors: [
            kSecondaryColor.withOpacity(
                widget.bgAnimateImg != "" ? _scrollHorzOpacity : 0),
            kWhitekColor
                .withOpacity(widget.bgAnimateImg != "" ? _scrollHorzOpacity : 0)
          ],
        ),
      ),
      margin: const EdgeInsets.only(top: 20),
      child: Stack(
        children: [
          widget.bgAnimateImg != ""
              ? Container(
                  height: 140,
                  width: 140,
                  margin:
                      EdgeInsets.only(top: 35, bottom: 35, left: _scrollMargin),
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/img_prayer.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              : const SizedBox(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              widget.title != ""
                  ? Container(
                      margin: const EdgeInsets.only(left: 20, bottom: 10),
                      child: Text(
                        widget.title,
                        style: blackTextStyle.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    )
                  : const SizedBox(),
              NotificationListener<ScrollNotification>(
                onNotification: (notification) {
                  if (notification.metrics.pixels / 100 <= .6) {
                    setState(() {
                      _scrollHorzOpacity =
                          1 - notification.metrics.pixels / 100;

                      _scrollMargin = 10 - notification.metrics.pixels / 10;
                    });
                  }
                  return true;
                },
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      slideItem(EdgeInsets.only(left: widget.startAtMargin)),
                      slideItem(EdgeInsets.only(left: 20)),
                      slideItem(EdgeInsets.only(left: 20)),
                      slideItem(EdgeInsets.only(left: 20, right: 20)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
