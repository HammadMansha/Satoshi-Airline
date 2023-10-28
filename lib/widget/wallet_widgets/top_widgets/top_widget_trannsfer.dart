import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Utils/app_asset_wallet.dart';


class TopTransfer extends StatelessWidget {
  const TopTransfer(this.text, {super.key});

  final String text;

  // final String Text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width,
      height: Get.height / 9,
      // color: Colors.red,

      child: Padding(
        padding: const EdgeInsets.only(left: 12, top: 10),
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                Get.back();

                // Get.off(const WalletScreenOne());
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 5),
                child: SizedBox(
                  height: 42,
                  width: 42,
                  child: Image.asset(AppAssets.backButton),
                ),
              ),
            ),
            const SizedBox(
              width: 17,
            ),
            SizedBox(
                height: Get.height / 9,
                width: Get.width / 1.3,
                child: Stack(
                  children: [
                    Positioned(
                      top: 23,
                      left: 2,
                      child: Transform(
                        transform: Matrix4.identity(),
                        child: Container(
                          width: Get.width / 1.4,
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
                    ),
                    Positioned(
                      top: 20,
                      // left: 67,
                      child: Transform(
                        transform: Matrix4.identity(),
                        child: Container(
                            width: Get.width / 1.4,
                            height: 39,
                            decoration: BoxDecoration(
                                // color: const Color(0xffFFFDFD),
                                //   color: AppColor.buttonColor,
                                color: Colors.white,
                                border: Border.all(
                                  color: Colors.black,
                                  width: 1.5, // <-- set border width here
                                ),
                                borderRadius: BorderRadius.circular(10)),
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
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
