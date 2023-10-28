import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:satoshi/Views/Wallet/SpenderView/SpenderCommon/spender_tab_view.dart';

import '../../../Utils/app_asset_wallet.dart';
import '../../../Views/Wallet/lock_screens/lock_screen.dart';


class TopWidget extends StatelessWidget {
  const TopWidget(this.text, {super.key});

  final String text;

  // final String Text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width,
      height: Get.height / 11,
      // color: Colors.red,
      child: Row(
        children: [
          Row(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: SizedBox(
                  height: 42,
                  width: 42,
                  child: Image.asset(AppAssets.backButton),
                ),
              ).marginOnly(left: 12,bottom: 4),
              SizedBox(width: 10,),
              Container(
                  width: 255,
                  height: 45,
                  // color: Colors.pink,
                  child: Stack(
                    children: [
                      Positioned(
                        top: 3,
                        left: 3,
                        child: Container(
                          width: 250,
                          height: 39,
                          decoration: BoxDecoration(
                              color: const Color(0xff62C8A9),
                              border: Border.all(
                                color: Colors.black,
                                width: 1.5, // <-- set border width here
                              ),
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                      Positioned(
                        // top: 45,
                        // left: 67,
                        child: Container(
                            width: 250,
                            height: 39,
                            decoration: BoxDecoration(
                                // color: const Color(0xffFFFDFD),
                                //   color: AppColor.buttonColor,
                                color: Colors.white,
                                border: Border.all(
                                  color: Colors.black,
                                  width:
                                      1.5, // <-- set border width here
                                ),
                                borderRadius:
                                    BorderRadius.circular(10)),
                            child: Center(
                              child: Text(
                                text,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13,
                                    fontFamily: 'Sora'),
                              ),
                            )),
                      ),
                    ],
                  )),
              SizedBox(width: 10,),
              InkWell(
                onTap: () {
                  Get.to(() => const LockScreen());
                },
                child: const Icon(
                  Icons.settings,
                  size: 38,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
