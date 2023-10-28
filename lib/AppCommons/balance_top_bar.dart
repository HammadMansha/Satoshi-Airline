import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:satoshi/Utils/utils.dart';
import 'package:satoshi/Views/Holders/NftHolder/Pro/extra_page.dart';
import 'package:satoshi/Views/Profile/profile.dart';

// ignore: non_constant_identifier_names
Widget BalanceTopBar(
  assetImage, {
  bool isNetwork = false,
  bool isBackButton = false,
  bool isBackArrowView = false,
  bool isBack = false,
  double bnb = 0.0,
  String totalsap = '',
}) {
  return SizedBox(
    height: 110,
    // color: Colors.yellow,
    child: Stack(
      children: [
        Container(
          padding: const EdgeInsets.only(top: 32, right: 12),
          child: Align(
            alignment: Alignment.centerRight,
            child: Container(
              width: Get.width / 1.3,
              height: 42,
              decoration: BoxDecoration(
                  color: AppColors.btnBgColor,
                  border: Border.all(
                    color: AppColors.black,
                    width: 1.5, // <-- set border width here
                  ),
                  borderRadius: BorderRadius.circular(10)),
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.only(top: 25, right: 15),
          child: Align(
            alignment: Alignment.centerRight,
            child: Container(
              width: Get.width / 1.3,
              height: 42,
              decoration: BoxDecoration(
                  color: const Color(0xffFFFDFD),
                  border: Border.all(
                    color: AppColors.black,
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  Row(
                    children: [
                      Image.asset(
                        AppConstants.usdIcon,
                        height: 27,
                      ),
                      Text(
                        ' 0',
                        style: cryptoValueStyle,
                      ),
                    ],
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Image.asset(
                        AppConstants.sapIcon,
                        height: 24,
                      ),
                      Text(
                        ' $totalsap',
                        style: cryptoValueStyle,
                      ),
                    ],
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Image.asset(
                        AppConstants.binanceIcon,
                        height: 24,
                      ),
                      Text(
                        ' ${bnb.toStringAsFixed(3)}',
                        style: cryptoValueStyle,
                      )
                    ],
                  ),
                  const Spacer(),
                  Stack(
                    children: [
                      InkWell(
                        onTap: () {
                          Get.to(() => const ExtraPage());
                        },
                        child: Container(
                          height: 39,
                          width: 39,
                          decoration: BoxDecoration(
                            color: AppColors.offWhite,
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 5, left: 10),
                        child: Image.asset(
                          AppConstants.walletIcon,
                          height: 23,
                          width: 23,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
        isBackArrowView
            ? Positioned(
                top: 46,
                left: 12,
                // right: 40,
                child: Transform(
                  transform: Matrix4.identity(),
                  child: InkWell(
                    onTap: () {
                      if (isBack) {
                        Get.back();
                      } else if (isBackButton) {
                        
                      } else {
                        Get.to(() => const Profile());
                      }
                    },
                    child: SizedBox(
                      height: 47,
                      width: 55,
                      child: Stack(
                        children: [
                          Positioned(
                            top: 3,
                            left: 3,
                            child: Transform(
                              transform: Matrix4.identity(),
                              child: Container(
                                height: 42,
                                width: 50,
                                decoration: BoxDecoration(
                                    color: AppColors.btnBgColor,
                                    border: Border.all(
                                      color: AppColors.black,
                                      width: 1.5,
                                    ),
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                            ),
                          ),
                          Positioned(
                            child: Transform(
                              transform: Matrix4.identity(),
                              child: Container(
                                height: 42,
                                width: 50,
                                decoration: BoxDecoration(
                                  color: const Color(0xffFFFDFD),
                                  border: Border.all(
                                    color: AppColors.black,
                                    width: 1.5,
                                  ),
                                  borderRadius: BorderRadius.circular(
                                    10,
                                  ),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    isNetwork == false
                                        ? Image.asset(
                                            assetImage,
                                            height: 24,
                                          )
                                        : Image.network(
                                            "$assetImage",
                                            height: 18,
                                          ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    isBackButton
                                        ? const SizedBox()
                                        : Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: const [
                                              Text(
                                                "    0",
                                                style: TextStyle(
                                                  fontSize: 8,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              Text(
                                                " km",
                                                style: TextStyle(
                                                  fontSize: 6,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ],
                                          )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            : Positioned(
                top: 46,
                left: 12,
                // right: 40,
                child: Transform(
                  transform: Matrix4.identity(),
                  child: InkWell(
                    onTap: () {
                      Get.to(() => const Profile());
                    },
                    child: SizedBox(
                      height: 47,
                      width: 55,
                      child: Stack(
                        children: [
                          Positioned(
                            top: 3,
                            left: 3,
                            child: Transform(
                              transform: Matrix4.identity(),
                              child: Container(
                                height: 42,
                                width: 50,
                                decoration: BoxDecoration(
                                    color: AppColors.btnBgColor,
                                    border: Border.all(
                                      color: AppColors.black,
                                      width: 1.5,
                                    ),
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                            ),
                          ),
                          Positioned(
                            child: Transform(
                              transform: Matrix4.identity(),
                              child: Container(
                                height: 42,
                                width: 50,
                                decoration: BoxDecoration(
                                  color: const Color(0xffFFFDFD),
                                  border: Border.all(
                                    color: AppColors.black,
                                    width: 1.5,
                                  ),
                                  borderRadius: BorderRadius.circular(
                                    10,
                                  ),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    isNetwork == false
                                        ? Image.asset(
                                            AppConstants.profileImg.value,
                                            height: 24,
                                          )
                                        : Image.network(
                                            "$assetImage",
                                            height: 18,
                                          ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    isBackButton
                                        ? const SizedBox()
                                        : Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: const [
                                              Text(
                                                "    0",
                                                style: TextStyle(
                                                  fontSize: 8,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              Text(
                                                " km",
                                                style: TextStyle(
                                                  fontSize: 6,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ],
                                          )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
      ],
    ),
  );
}
