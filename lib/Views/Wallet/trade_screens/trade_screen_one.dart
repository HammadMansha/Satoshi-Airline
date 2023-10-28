import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:satoshi/Views/Wallet/trade_screens/trade_screen_two.dart';

import '../../../Controllers/wallet/trade_screens/trade_screen_one_controller.dart';
import '../../../Utils/app_asset_wallet.dart';
import '../../../Utils/appcolor_wallet.dart';
import '../../../widget/wallet_widgets/buttons/trade_button.dart';
import '../../../widget/wallet_widgets/containers/short_containor.dart';
import '../../../widget/wallet_widgets/text_widget/text_widget.dart';
import '../../../widget/wallet_widgets/top_widgets/top_widgets_full.dart';


class TradeScreenOne extends StatelessWidget {
  const TradeScreenOne({super.key});

  @override
  Widget build(BuildContext context) {
    final mqData = MediaQuery.of(context);
    final mqDataNew = mqData.copyWith(
        textScaleFactor:
            mqData.textScaleFactor > 1.0 ? 1.0 : mqData.textScaleFactor);
    return GetBuilder<TradeScreenOneController>(
        init: TradeScreenOneController(),
        builder: (_) {
          return MediaQuery(
            data: mqDataNew,
            child: Scaffold(
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
                        height: 37,
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
                Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      decoration: const BoxDecoration(
                          // border: Border.all(),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(40),
                              topRight: Radius.circular(40))),
                      child: _lastContainer(context, _),
                    ),
                  ),
                )
              ]),
            ),
          );
        });
  }

  Widget _arbBox(BuildContext context, TradeScreenOneController _) {
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
                    // color: Colors.red,
                    height: Get.height / 20,
                    width: Get.width / 2.5,
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        elevation: 2,

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

  Widget _satBox(BuildContext context, TradeScreenOneController _) {
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
                    // color: Colors.red,
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        elevation: 2,


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

Widget _lastContainer(BuildContext context, TradeScreenOneController _) {
  return Column(
    children: [
      const Row(
        children: [
          Padding(
              padding: EdgeInsets.only(left: 12),
              child: MyText(
                'Slippage Tolerance',
                fontSize: 9,
                fontWeight: FontWeight.w400,
                color: Color(0xff858585),
              )),
          Padding(
              padding: EdgeInsets.only(left: 200),
              child: MyText(
                '0.5%',
                fontSize: 9,
                color: Colors.black,
                fontWeight: FontWeight.w400,
              )),
          Icon(
            Icons.arrow_forward_ios_rounded,
            size: 15,
          )
        ],
      ),
      Padding(
          padding: EdgeInsets.only(top: Get.height / 3),
          child: InkWell(
              onTap: () {
                Get.to(() => const TradeScreenTwo());
              },
              child: const TradeButton()))
    ],
  );
}
