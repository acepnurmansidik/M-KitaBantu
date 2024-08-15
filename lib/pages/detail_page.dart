import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:kitabantu/cubit/banks_cubit.dart';
import 'package:kitabantu/cubit/campaign_cubit.dart';
import 'package:kitabantu/models/bank_model.dart';
import 'package:kitabantu/models/campaign_model.dart';
import 'package:kitabantu/theme.dart';
import 'package:kitabantu/widgets/custom_button.dart';
import 'package:kitabantu/widgets/loading_animation.dart';
import 'package:share_plus/share_plus.dart';

class DetailPage extends StatefulWidget {
  final CampaignModel? dataCampaign;
  const DetailPage({super.key, this.dataCampaign});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  double heightScroll = 0;
  double _scrollOffset = 0.2;
  bool _isVisiblePayment = false;
  int _selectedItem = 0;
  int _selectedBank = -1;
  String _nominalSelected = "";
  String _bankNameSelect = "";
  String _codeBankSelect = "";

  Color changeColor = kWhitekColor;
  TextEditingController nameController = TextEditingController(text: "");
  TextEditingController commentController = TextEditingController(text: "");
  TextEditingController bankAccountNumberController =
      TextEditingController(text: "");
  TextEditingController amountController = TextEditingController(text: "");
  DraggableScrollableController dragScrollController =
      DraggableScrollableController();

  @override
  void initState() {
    context.read<BanksCubit>().fectBanks();
    super.initState();
  }

  void _paymentDonate() {
    context.read<CampaignCubit>().createUserDonateCampaign(
          DonateCampaignModel(
            campaignName: widget.dataCampaign!.campaignName,
            slugName: widget.dataCampaign!.slugName,
            amount: widget.dataCampaign!.amountRequire.toString(),
            nominal: _nominalSelected,
            description: widget.dataCampaign!.description,
            organizerId: widget.dataCampaign!.organizer["id"],
            campaignId: widget.dataCampaign!.id,
            bank: PostBankModel(
              bankName: _bankNameSelect,
              bankCode: _codeBankSelect,
              accountName: nameController.text,
              accountNumber: bankAccountNumberController.text,
            ),
            comment: CommentarModel(
              comment: commentController.text,
              name: nameController.text,
            ),
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    Widget customAppBar() {
      return Container(
        height: 60,
        width: double.infinity,
        color: Color.fromRGBO(255, 255, 255, _scrollOffset),
        padding: EdgeInsets.symmetric(horizontal: defaultPadding),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back,
                color: changeColor,
              ),
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Share.share('check out my website https://example.com');
                  },
                  child: Icon(
                    Icons.share,
                    color: changeColor,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Icon(
                  Icons.more_vert,
                  color: changeColor,
                ),
              ],
            )
          ],
        ),
      );
    }

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
                  NumberFormat.currency(symbol: "", decimalDigits: 0)
                      .format(total),
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
              widget.dataCampaign!.campaignName,
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
                        NumberFormat.currency(symbol: "Rp. ", decimalDigits: 0)
                            .format(widget.dataCampaign!.amountRequire),
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
                              text: NumberFormat.currency(
                                      symbol: "Rp. ", decimalDigits: 0)
                                  .format(widget.dataCampaign!.totalDonate),
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
                    '${widget.dataCampaign!.deadlines} Hari lagi',
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
                      (widget.dataCampaign!.totalDonate /
                          widget.dataCampaign!.amountRequire),
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
                  widget.dataCampaign!.donateCampaign.length,
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
                            widget.dataCampaign!.organizer["name"],
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
                              widget.dataCampaign!.startDate.toString(),
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
                        child: Text(
                          widget.dataCampaign!.description,
                          textAlign: TextAlign.justify,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 10,
                        ),
                      ),
                      Container(
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
                          text: NumberFormat.currency(
                                  symbol: "Rp. ", decimalDigits: 0)
                              .format(amount),
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

      Widget personPrayer(
          CampaignCommentsModel personComment, Function() onPressed) {
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
                          personComment.name,
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
                personComment.comment,
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
        margin: const EdgeInsets.only(top: 10, bottom: 80),
        width: double.infinity,
        color: kWhitekColor,
        child: Column(
          children: [
            directItem('Doa-doa #Orang Baik', false,
                widget.dataCampaign!.campaignComments.length, () => null),
            Column(
              children: widget.dataCampaign!.campaignComments
                  .map(
                    (comment) => personPrayer(comment, () {}),
                  )
                  .toList(),
            )
          ],
        ),
      );
    }

    Widget modalPayment(Function() onSubmit) {
      List itemSelected = [
        {"emot": "😘", "value": 1000},
        {"emot": "😉", "value": 2000},
        {"emot": "🥰", "value": 5000},
        {"emot": "🥳", "value": 10000},
        {"emot": "🤩", "value": 50000},
        {"emot": "😇", "value": 100000},
      ];
      Widget selectedItem(
          int amount, String emot, int index, Function() onSelect) {
        return GestureDetector(
          onTap: onSelect,
          child: Container(
            height: 75,
            width: 106,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                  width: 1.5,
                  color: index == _selectedItem ? kPrimaryColor : kGreyColor),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  emot,
                  style: blackTextStyle.copyWith(
                    fontSize: 30,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Text(
                  NumberFormat.currency(symbol: "", decimalDigits: 0)
                      .format(amount),
                  style: blackTextStyle.copyWith(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
        );
      }

      Widget textInput({controller, hint}) {
        return Container(
          margin: const EdgeInsets.only(top: 10),
          child: TextFormField(
            controller: controller,
            cursorColor: kBlackColor,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(
                right: 45,
                left: 15,
                top: 10,
                bottom: 10,
              ),
              hintText: hint,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: kLightGreyColor),
              ),
            ),
          ),
        );
      }

      return SizedBox.expand(
        child: NotificationListener<ScrollNotification>(
          onNotification: (notification) {
            if (notification.metrics.extentAfter >= 250) {
              setState(() {
                _isVisiblePayment = false;
                _selectedItem = 0;
              });
            }
            return true;
          },
          child: DraggableScrollableSheet(
            initialChildSize: 0.79,
            minChildSize: 0,
            maxChildSize: 0.79,
            shouldCloseOnMinExtent: false,
            builder: (context, scrollController) {
              return Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  horizontal: defaultPadding,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                    color: kWhitekColor,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(18),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: kGreyColor,
                        offset: const Offset(0, -0.5),
                        blurRadius: 10,
                      )
                    ]),
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Column(
                    children: [
                      Container(
                        height: 3,
                        width: 30,
                        margin: const EdgeInsets.only(top: 5, bottom: 30),
                        decoration: BoxDecoration(
                          color: kGreyColor,
                          borderRadius: BorderRadius.circular(18),
                        ),
                      ),
                      Wrap(
                          spacing: 17,
                          runSpacing: 17,
                          children: itemSelected.asMap().entries.map((item) {
                            return selectedItem(item.value["value"],
                                item.value["emot"], item.key + 1, () {
                              setState(() {
                                _selectedItem = item.key + 1;
                                _nominalSelected =
                                    item.value["value"].toString();
                              });
                            });
                          }).toList()),
                      Container(
                        margin: const EdgeInsets.only(top: 20),
                        alignment: Alignment.centerLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Payment method",
                              style: blackTextStyle.copyWith(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            BlocBuilder<BanksCubit, BanksState>(
                              builder: (context, state) {
                                if (state is BanksSuccess) {
                                  return Wrap(
                                    alignment: WrapAlignment.start,
                                    runAlignment: WrapAlignment.end,
                                    spacing: 15,
                                    runSpacing: 15,
                                    children:
                                        state.banks.asMap().entries.map((bank) {
                                      return GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _selectedBank = bank.key;
                                            _bankNameSelect = bank.value.name;
                                            _codeBankSelect =
                                                bank.value.bankCode;
                                          });
                                        },
                                        child: Container(
                                          alignment: Alignment.center,
                                          width: 110,
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 10),
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                width: 1.5,
                                                color: _selectedBank == bank.key
                                                    ? kPrimaryColor
                                                    : kGreyColor),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Text(
                                            bank.value.name,
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  );
                                }
                                return const Wrap(
                                  spacing: 15,
                                  runSpacing: 15,
                                  children: [],
                                );
                              },
                            ),
                            textInput(
                                controller: bankAccountNumberController,
                                hint: 'Bank Account Number')
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 20),
                        alignment: Alignment.centerLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Payment method",
                              style: blackTextStyle.copyWith(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            textInput(controller: nameController, hint: 'name'),
                            textInput(
                                controller: commentController, hint: 'comment')
                          ],
                        ),
                      ),
                      CustomButton(
                        title: "Lanjutkan pembayaran",
                        margin: const EdgeInsets.only(top: 20),
                        onPressed: onSubmit,
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: kLightGreyColor,
      body: BlocConsumer<CampaignCubit, CampaignState>(
        listener: (context, state) {
          if (state is CampaignILoading) {
            const LoadingAnimation();
          } else if (state is CampaignSuccess) {
            Navigator.pushNamedAndRemoveUntil(
                context, '/success', (contect) => false);
          }
        },
        builder: (context, state) {
          return Stack(
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
                  image: widget.dataCampaign!.images.isNotEmpty
                      ? DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                            widget.dataCampaign!.images.first.linkUrl,
                          ),
                        )
                      : const DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage('assets/icon_blank_picture.png'),
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

                  if (notification.metrics.axis.name == "vertical" &&
                      notification.metrics.pixels / 100 <= 1) {
                    setState(() {
                      _scrollOffset = notification.metrics.pixels / 100;
                      changeColor = kWhitekColor;
                    });
                  } else {
                    setState(() {
                      changeColor = kBlackColor;
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
              ),
              customAppBar(),
              Align(
                alignment: Alignment.bottomCenter,
                child: CustomButton(
                  title: "Donasi sekarang",
                  onPressed: () {
                    setState(() {
                      _isVisiblePayment = true;
                    });
                  },
                ),
              ),
              if (_isVisiblePayment) modalPayment(_paymentDonate)
            ],
          );
        },
      ),
    );
  }
}
