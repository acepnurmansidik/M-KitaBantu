// ignore_for_file: unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kitabantu/models/campaign_model.dart';
import 'package:kitabantu/pages/detail_page.dart';
import 'package:kitabantu/theme.dart';

class HorizontalSlideItem extends StatefulWidget {
  final List campaigns;
  final String title;
  final String bgAnimateImg;
  final double startAtMargin;

  const HorizontalSlideItem({
    super.key,
    required this.campaigns,
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
    Widget slideItem(CampaignModel dataCampaign, EdgeInsets margin) {
      return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailPage(
                dataCampaign: dataCampaign,
              ),
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
                  borderRadius: BorderRadius.circular(10),
                  image: dataCampaign.images.isNotEmpty
                      ? DecorationImage(
                          image: NetworkImage(
                              '${dataCampaign.images.first.linkUrl}'),
                        )
                      : const DecorationImage(
                          image: AssetImage('assets/icon_blank_picture.png'),
                        ),
                ),
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
                      dataCampaign.campaignName,
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
                                  .format(dataCampaign.totalDonate),
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
                              (dataCampaign.totalDonate /
                                  dataCampaign.amountRequire),
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
      margin: const EdgeInsets.only(top: 20),
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
                    children: widget.campaigns.asMap().entries.map((campaign) {
                      return slideItem(
                        campaign.value,
                        EdgeInsets.only(
                            left: campaign.key == 0 ? widget.startAtMargin : 20,
                            right: campaign.key == widget.campaigns.length - 1
                                ? 20
                                : 0),
                      );
                    }).toList(),
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
