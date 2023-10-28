// ignore: file_names
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:satoshi/Controllers/landingpage_controller.dart';
import 'package:satoshi/Utils/commonSnackbar.dart';
import 'package:satoshi/routes/app_routes.dart';

import '../../Utils/app_colors.dart';
import '../../Utils/app_constants.dart';

class CommonAppbar extends StatelessWidget {
  const CommonAppbar({
    super.key,
    required this.imagePath,
    this.isNetwork,
    this.isDialog = false,
    this.isTextOnly = false,
    this.bnb = 0.0,
    this.totalsap = '',
    this.body = '',
    this.travel = '',
    this.isViewProfile = true,
  });

  final RxString? imagePath;
  final RxBool? isNetwork;
  final bool isDialog;
  final double bnb;
  final String totalsap;
  final bool isTextOnly;
  final String body;
  final String travel;
  final bool isViewProfile;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        leadingWidget(
          isNetwork: isNetwork,
          imageName: imagePath,
        ).marginOnly(left: 10),
        titleWidget(),
      ],
    );
  }

  Widget leadingWidget({RxBool? isNetwork, RxString? imageName}) {
    NumberFormat myFormat = NumberFormat.decimalPattern('en_us');
    LandingPageController landingPageController =
        Get.find<LandingPageController>();
    return GestureDetector(
      onTap: () {
        if (isDialog) {
          Get.back();
          // Get.dialog(
          //   Dialog(
          //     insetPadding: const EdgeInsets.all(0),
          //     backgroundColor: Colors.transparent,
          //     child: SizedBox(
          //       height: Get.height / 1.4,
          //       width: Get.width,
          //       child: Column(
          //         mainAxisAlignment: MainAxisAlignment.center,
          //         children: [
          //           CommonButton(
          //               text: "HOW TO PLAY",
          //               onPressed: () async {
          //                 await launchUrlString('https://youtu.be/V4A4cklChnU',
          //                     mode: LaunchMode.externalApplication);
          //               },
          //               color: const Color(0xffFFF7AF)),
          //           CommonButton(
          //                   text: "WHITEPAPER",
          //                   onPressed: () async {
          //                     await launchUrlString(
          //                         'https://satoshiair.gitbook.io/docs/',
          //                         mode: LaunchMode.externalApplication);
          //                   },
          //                   color: const Color(0xffFFFFFF))
          //               .marginSymmetric(vertical: 25),
          //           CommonButton(
          //               text: "LINKTREE",
          //               onPressed: () async {
          //                 await launchUrlString(
          //                     'https://linktr.ee/satoshiairline',
          //                     mode: LaunchMode.externalApplication);
          //               },
          //               color: const Color(0xffFFFFFF)),
          //         ],
          //       ).marginSymmetric(horizontal: 32),
          //     ),
          //   ),
          // );
        } else {
          if (isViewProfile) {
            if (landingPageController.internetConnection == false) {
              Get.toNamed(Routes.profileRoutes);
              // Get.to(() => const Profile());
            } else {
              CommonToast.getToast(
                  "Please check your internet connection and restart your app again");
            }
          }
        }
      },
      child: SizedBox(
        height: 70,
        width: 80,
        child: Column(
          children: [
            SizedBox(
              height: 28,
              width: 45,
              child: Stack(
                children: [
                  Container(
                    width: 50,
                    decoration: BoxDecoration(
                      color: const Color(0xff62c8a9),
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Container(
                    width: 40,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: Colors.black,
                      ),
                    ),
                    child: Center(
                      child: Obx(
                        () => isNetwork!.value
                            ? Image.network(
                                imageName!.value,
                                height: 30,
                                width: 30,
                              )
                            : Image.asset(
                                imageName!.value,
                                height: 30,
                                width: 30,
                              ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
              width: 70,
              child: Stack(
                children: [
                  Container(
                    height: 30,
                    width: 80,
                    decoration: BoxDecoration(
                      color: const Color(0xff62c8a9),
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: Colors.black,
                      ),
                    ),
                  ).marginOnly(left: 5, top: 6),
                  Container(
                    height: 17,
                    width: 80,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: Colors.black,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        "${myFormat.format(double.parse(double.parse(travel).toStringAsFixed(2)))}km",
                        // travel,
                        // '${double.parse(myFormat.format(int.parse(travel))).toStringAsFixed(2)} Km',
                        maxLines: 1,
                        style: GoogleFonts.sora(
                            fontSize: 8, fontWeight: FontWeight.w600),
                      ),
                    ).marginOnly(left: 5, right: 5),
                  ),
                ],
              ),
            ),
          ],
        ).marginOnly(top: 10),
      ),
    );
  }

  Widget titleWidget() {
    NumberFormat myFormat = NumberFormat.decimalPattern('en_us');
    return Flexible(
      child: SizedBox(
        height: 70,
        child: Column(
          children: [
            SizedBox(
              height: 55,
              child: Stack(
                children: [
                  Container(
                    height: 40,
                    decoration: BoxDecoration(
                      color: const Color(0xff62c8a9),
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: Colors.black,
                      ),
                    ),
                  ).marginOnly(left: 5, bottom: 10, top: 6),
                  Container(
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: Colors.black,
                      ),
                    ),
                    child: isTextOnly
                        ? Center(
                            child: Text(
                              body,
                              style: GoogleFonts.sora(
                                  fontSize: 15, fontWeight: FontWeight.w600),
                            ),
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                AppConstants.usdIcon,
                                height: 20,
                              ),
                              SizedBox(
                                width: Get.width / 10,
                                child: Text(
                                  ' 0.00',
                                  maxLines: 1,
                                  overflow: TextOverflow.visible,
                                  style: GoogleFonts.sora(
                                    textStyle: TextStyle(
                                      color: AppColors.black,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              const Spacer(),
                              Image.asset(
                                AppConstants.sapIcon,
                                height: 20,
                              ).marginOnly(
                                left: 5,
                              ),
                              SizedBox(
                                width: Get.width / 8,
                                child: Text(
                                  totalsap,
                                  // ' ${myFormat.format(int.parse(totalsap))}',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.sora(
                                    textStyle: TextStyle(
                                      color: AppColors.black,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              const Spacer(),
                              Image.asset(
                                AppConstants.binanceIcon,
                                height: 20,
                              ),
                              SizedBox(
                                width: Get.width / 9,
                                child: Text(
                                  bnb.toStringAsFixed(6),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.sora(
                                    textStyle: TextStyle(
                                      color: AppColors.black,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              const Spacer(),
                              InkWell(
                                onTap: () {
                                  Get.toNamed(Routes.tabbarviewRoutes);
                                },
                                child: Container(
                                  height: 39,
                                  width: 39,
                                  decoration: BoxDecoration(
                                    color: AppColors.offWhite,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Center(
                                    child: Stack(
                                      children: [
                                        Image.asset(
                                          AppConstants.walletIcon,
                                          height: 25,
                                          width: 25,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ).marginOnly(left: 10),
                  ).marginOnly(right: 5),
                ],
              ),
            ),
          ],
        ).marginOnly(top: 10),
      ).marginOnly(right: 10),
    );
  }
}
