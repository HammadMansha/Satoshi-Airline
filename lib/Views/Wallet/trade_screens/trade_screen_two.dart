import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:satoshi/Views/Wallet/wallet_to_spending/wallet_to_spending.dart';

import '../../../Controllers/wallet/trade_screens/trade_screen_two.dart';
import '../../../Utils/app_asset_wallet.dart';
import '../../../Utils/appcolor_wallet.dart';
import '../../../widget/wallet_widgets/containers/custom_container.dart';
import '../../../widget/wallet_widgets/containers/short_containor.dart';
import '../../../widget/wallet_widgets/text_widget/text_widget.dart';
import '../../../widget/wallet_widgets/top_widgets/top_widgets_full.dart';


class TradeScreenTwo extends StatelessWidget {
  const TradeScreenTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TradeScreenTwoController>(
        init: TradeScreenTwoController(),
        builder: (_) {
          return Scaffold(
            backgroundColor: AppColor.primary,
            body: Column(children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 40,
                    ),
                    const TopWidget('Trade'),
                    const SizedBox(
                      height: 10,
                    ),
                    _arbBox(context, _),
                    const SizedBox(
                      height: 8,
                    ),
                    SizedBox(
                        height: 34,
                        width: 34,
                        child: InkWell(
                          onTap: _.swapDropdownValues,
                          child: Image.asset(
                            AppAssets.tradeTransfer,
                          ),
                        )),
                    const SizedBox(
                      height: 8,
                    ),
                    _satBox(context, _),
                    const SizedBox(
                      height: 14,
                    ),
                  ],
                ),
              ),
              CustomContainer(
                color: AppColor.cntrColor,
                child: _lastContainer(context, _),
              )
            ]),
          );
        });
  }

  Widget _arbBox(BuildContext context, TradeScreenTwoController _) {
    return ShortContainer(
      height: Get.height / 9,
      width: Get.width,
      color: AppColor.white,
      child: Column(
        children: [
          const Row(
            children: [
              Padding(
                  padding: EdgeInsets.only(left: 22, top: 10),
                  child: MyText('From',
                      color: Color(0xff858585),
                      fontSize: 9,
                      fontWeight: FontWeight.w400)),
              Padding(
                  padding: EdgeInsets.only(top: 10, left: 226),
                  child: MyText('Balance : 0',
                      color: Color(0xff858585),
                      fontSize: 9,
                      fontWeight: FontWeight.w400))
            ],
          ),
          Row(
            children: [
              const Padding(
                  padding: EdgeInsets.only(top: 19, left: 22),
                  child: MyText('O.OO',
                      color: Color(0xff858585),
                      fontSize: 14,
                      fontWeight: FontWeight.w400)),
              const Padding(
                  padding: EdgeInsets.only(left: 100, top: 19),
                  child: MyText(
                    'Max',
                    color: Color(0xff0EA375),
                    fontSize: 9,
                    fontWeight: FontWeight.w700,
                  )),
              Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: SizedBox(
                    height: Get.height / 20,
                    width: Get.width / 2.5,
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        borderRadius: BorderRadius.circular(4),
                        dropdownColor: Colors.white,
                        icon: const Padding(
                          padding: EdgeInsets.only(right: 15),
                          child: Icon(
                            Icons.keyboard_arrow_down,
                            size: 25.0,
                            color: Colors.black,
                          ),
                        ),
                        style: const TextStyle(
                            fontSize: 10,
                            color: Colors.black,
                            fontWeight: FontWeight.w400),
                        value: _.selected.text != ''
                            ? _.selected.text
                            : _.dropdownList[0]['name'].toString(),
                        isDense: true,
                        isExpanded: true,
                        items: _.dropdownList.map((list) {
                          return DropdownMenuItem(
                            value: list['name'].toString(),
                            child: list['name'] != ''
                                ? Row(
                                    // mainAxisAlignment:
                                    // MainAxisAlignment.start,
                                    children: [
                                      Image.asset(
                                        list['logo'],
                                        height: 32,
                                      ),
                                      const SizedBox(
                                        width: 6,
                                      ),
                                      Flexible(
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(top: 5),
                                          child: MyText(
                                            '${list['name']}',
                                            fontWeight: FontWeight.w600,
                                            fontSize: 20,
                                          ),
                                        ),
                                      )
                                    ],
                                  )
                                : const Text('notfound'),
                          );
                        }).toList(),
                        onChanged: (value) {
                          _.selected.text = value!;
                          _.update();
                        },
                      ),
                    ),
                  ))
            ],
          )
        ],
      ),
    ).marginOnly(left: 12, right: 12);
  }

  Widget _satBox(BuildContext context, TradeScreenTwoController _) {
    return ShortContainer(
      height: Get.height / 9,
      width: Get.width,
      color: AppColor.white,
      child: Column(
        children: [
          const Row(
            children: [
              Padding(
                  padding: EdgeInsets.only(left: 22, top: 10),
                  child: MyText('To (Estimate)',
                      color: Color(0xff858585),
                      fontSize: 9,
                      fontWeight: FontWeight.w400)),
            ],
          ),
          Row(
            children: [
              Padding(
                  padding: const EdgeInsets.only(left: 180, top: 15),
                  child: SizedBox(
                    height: Get.height / 20,
                    width: Get.width / 2.5,
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        borderRadius: BorderRadius.circular(4),
                        dropdownColor: Colors.white,
                        icon: const Padding(
                          padding: EdgeInsets.only(right: 15),
                          child: Icon(
                            Icons.keyboard_arrow_down,
                            size: 25.0,
                            color: Colors.black,
                          ),
                        ),
                        style: const TextStyle(
                            fontSize: 10,
                            color: Colors.black,
                            fontWeight: FontWeight.w400),
                        value: _.selectedTwo.text != ''
                            ? _.selectedTwo.text
                            : _.dropdownList[0]['name'].toString(),
                        isDense: true,
                        isExpanded: true,
                        items: _.dropdownList.map((list) {
                          return DropdownMenuItem(
                            value: list['name'].toString(),
                            child: list['name'] != ''
                                ? Row(
                                    // mainAxisAlignment:
                                    // MainAxisAlignment.start,
                                    children: [
                                      Image.asset(
                                        list['logo'],
                                        height: 32,
                                      ),
                                      const SizedBox(
                                        width: 6,
                                      ),
                                      Flexible(
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(top: 5),
                                          child: MyText(
                                            '${list['name']}',
                                            fontWeight: FontWeight.w600,
                                            fontSize: 20,
                                          ),
                                        ),
                                      )
                                    ],
                                  )
                                : const Text('notfound'),
                          );
                        }).toList(),
                        onChanged: (value) {
                          _.selectedTwo.text = value!;
                          _.update();
                        },
                      ),
                    ),
                  ))
            ],
          )
        ],
      ),
    ).marginOnly(left: 12, right: 12);
  }
}

Widget _lastContainer(BuildContext context, TradeScreenTwoController _) {
  return Column(
    children: [
      Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 119),
            child: ShortContainer(
                height: Get.height / 16,
                width: Get.width,
                color: Colors.white,
                child: Row(
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(left: 32),
                        child: Image.asset(AppAssets.sapLogo, height: 32)),
                    const SizedBox(
                      width: 20,
                    ),
                    const MyText(
                      'SAP',
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    )
                  ],
                )).marginOnly(left: 12, right: 12),
          ),
          const SizedBox(
            height: 27,
          ),
          ShortContainer(
              height: Get.height / 16,
              width: Get.width,
              color: Colors.white,
              child: Row(
                children: [
                  Padding(
                      padding: const EdgeInsets.only(left: 32),
                      child: Image.asset(AppAssets.satLogo, height: 32)),
                  const SizedBox(
                    width: 20,
                  ),
                  const MyText(
                    'SAT',
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  )
                ],
              )).marginOnly(left: 12, right: 12),
          const SizedBox(
            height: 27,
          ),
          InkWell(
            onTap: () {
              Get.to(() => const WalletToSpending());
            },
            child: ShortContainer(
                height: Get.height / 16,
                width: Get.width,
                color: Colors.white,
                child: Row(
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(left: 32),
                        child: Image.asset(AppAssets.usdtLogo, height: 32)),
                    const SizedBox(
                      width: 20,
                    ),
                    const MyText(
                      'USDT',
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    )
                  ],
                )).marginOnly(left: 12, right: 12),
          ),
        ],
      ),
    ],
  );
}
