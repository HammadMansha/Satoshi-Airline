import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:satoshi/Views/Wallet/send_coins_screens/SendUsdtCoins.dart';

import '../../../Utils/app_asset_wallet.dart';
import '../../../Utils/appcolor_wallet.dart';

import '../../../Views/Wallet/send_coins_screens/send_arb.dart';
import '../../../Views/Wallet/send_coins_screens/send_sap.dart';
import '../../../Views/Wallet/send_coins_screens/send_sat.dart';
import '../text_widget/text_widget.dart';

class CoinsBottomSheet extends StatelessWidget {
  const CoinsBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
          children: [
            Container(
              height: Get.height / 1.8,
              decoration: const BoxDecoration(
                color: AppColor.cntrColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40), topRight: Radius.circular(40)),
                // border: Border.all()
              ),
              child: Column(
                children: [
                  Container(
                    height: Get.height/10,
                    width: Get.width,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black,width: 3),
                      // color: Colors.red,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20), topRight: Radius.circular(20),bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20)),
                    ),
                    child: InkWell(
                      onTap: () {
                        // Get.to(() => SendARBCoins());
                      },
                      child: Row(
                        children: [
                          Image.asset(AppAssets.arbLogo,height: 40,).marginOnly(left: 15),
                          SizedBox(width: 30,),
                          MyText('BNB',fontSize: 20,)
                        ],
                      ),
                    ),
                  ).marginOnly(left: 20,right: 20,top: 20),
                  SizedBox(height: 13,),
                  Container(
                    height: Get.height/10,
                    width: Get.width,
                    // color: Colors.red,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black,width: 3),
                      // color: Colors.red,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20), topRight: Radius.circular(20),bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20)),
                    ),
                    child: InkWell(
                      onTap: () {
                        // Get.to(
                        //         () => const SendSatCoins());
                      },
                      child: Row(
                        children: [
                          Image.asset(AppAssets.satLogo,height: 40,).marginOnly(left: 15),
                          SizedBox(width: 30,),
                          MyText('SAT',fontSize: 20,)
                        ],
                      ),
                    ),
                  ).marginOnly(left: 20,right: 20,),
                  SizedBox(height: 13,),
                  Container(
                    height: Get.height/10,
                    width: Get.width,
                    // color: Colors.red,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black,width: 3),
                      // color: Colors.red,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20), topRight: Radius.circular(20),bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20)),
                    ),
                    child: InkWell(
                      onTap: () {
                        // Get.to(
                        //         () => const SendSapCoins());
                      },
                      child: Row(
                        children: [
                          Image.asset(AppAssets.sapLogo,height: 40,).marginOnly(left: 15),
                          SizedBox(width: 30,),
                          MyText('SAP',fontSize: 20,)
                        ],
                      ),
                    ),
                  ).marginOnly(left: 20,right: 20,),
                  SizedBox(height: 13,),
                  Container(
                    height: Get.height/10,
                    width: Get.width,
                    // color: Colors.red,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black,width: 3),
                      // color: Colors.red,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20), topRight: Radius.circular(20),bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20)),
                    ),
                    child: InkWell(
                      onTap: () {
                        // Get.to(
                        //         () => const SendToUsdtScreen());
                      },
                      child: Row(
                        children: [
                          Image.asset(AppAssets.usdtLogo,height: 40,).marginOnly(left: 15),
                          SizedBox(width: 30,),
                          MyText('USDT',fontSize: 20,)
                        ],
                      ),
                    ),
                  ).marginOnly(left: 20,right: 20,),





                ],
              ),
            ).marginOnly(top: 5),
          ]
      ),
    );
  }
}
