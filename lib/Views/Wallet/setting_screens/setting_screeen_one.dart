import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:satoshi/Views/Profile/profile.dart';
import 'package:satoshi/Views/Profile/update_password.dart';
import 'package:satoshi/Views/Wallet/lock_screens/create_password_screen.dart';
import 'package:satoshi/Views/Wallet/lock_screens/lock_screen.dart';
import 'package:satoshi/Views/Wallet/setting_screens/seed_recover_screen.dart';

import '../../../Utils/app_asset_wallet.dart';
import '../../../Utils/app_colors.dart';
import '../../../Utils/app_constants.dart';
import '../../../Utils/appcolor_wallet.dart';
import '../../../widget/wallet_widgets/containers/short_containor.dart';
import '../../../widget/wallet_widgets/dialod_box/setting_dialog.dart';
import '../../../widget/wallet_widgets/text_widget/text_widget.dart';
import '../../AuthScreens/2factor_auth/link_google.dart';
import '../creat_and_import/import_wallet/import_wallet_screen.dart';

class SettingScreenMain extends StatelessWidget {
  const SettingScreenMain({super.key});

  @override
  Widget build(BuildContext context) {
    final mqData = MediaQuery.of(context);
    final mqDataNew = mqData.copyWith(
        textScaleFactor:
            mqData.textScaleFactor > 1.0 ? 1.0 : mqData.textScaleFactor);
    return MediaQuery(
      data: mqDataNew,
      child: Scaffold(
        backgroundColor: AppColor.primary,
        body: SafeArea(
          child: Column(children: [
            topBar(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    InkWell(
                        onTap: () {
                          Get.to(() => SeedPhaseRecover());
                        },
                        child: backUp(context)),
                    const SizedBox(
                      height: 30,
                    ),
                    InkWell(
                        onTap: () {
                          Get.to((CreateLOckScreen()));

                          // Get.to((CreateLOckScreen()));
                        },
                        child: reSet()),
                    const SizedBox(
                      height: 30,
                    ),
                    InkWell(
                        onTap: () {
                          Get.to(() => ImportWalletScreen());
                        },
                        child: reStore()),
                    const SizedBox(
                      height: 30,
                    ),
                    const SingleChildScrollView(
                        child: MyText(
                      'Powered by Satoshi Airline',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ))
                  ],
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  Widget backUp(BuildContext context) {
    return ShortContainer(
      height: Get.height / 5,
      width: Get.width,
      color: Colors.white,
      child: Column(
        children: [
          Container(
            // color: Colors.red,
            height: Get.height / 10,
            width: Get.width / 1,

            decoration: const BoxDecoration(
                // color: Colors.red,
                borderRadius: BorderRadius.all(Radius.circular(5))),
            child: Stack(
              children: [
                Positioned(
                  // top: 4,
                  // right: 1,
                  // left: Get.height/6.11,
                  child: Container(
                    width: Get.width,
                    height: Get.height / 11.4,
                    decoration: const BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                  ),
                ),
                Positioned(
                  // top: 16,
                  // left: Get.height/6.3,
                  child: Container(
                      width: Get.width,
                      height: Get.height / 12,
                      decoration: const BoxDecoration(
                          // color: const Color(0xffFFFDFD),
                          color: Color(0xffDDFFF4),
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      child: Center(
                          child: Row(
                        children: [
                          Image.asset(
                            AppAssets.backUpIcon,
                            height: 19,
                            width: 19,
                          ).marginOnly(left: 12, right: 12),
                          const MyText(
                            'Backup',
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                          Spacer(),
                          const Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 15,
                          ).marginOnly(right: 20)
                        ],
                      ))),
                ),
              ],
            ),
          ),
          const MyText(
            'Your 12-word/24-word Seed Pharse is the ONLY way to recover your funds if you lose access to your wallet.',
            fontWeight: FontWeight.w600,
            fontSize: 9,
            color: Color(0xff858585),
          ).marginOnly(top: 20, left: 12)
        ],
      ),
    ).marginOnly(left: 12, right: 12);
  }

  Widget reSet() {
    return ShortContainer(
      height: Get.height / 5,
      width: Get.width,
      color: Colors.white,
      child: Column(
        children: [
          Container(
            // color: Colors.red,
            height: Get.height / 10,
            width: Get.width / 1,

            decoration: const BoxDecoration(
                // color: Colors.red,
                borderRadius: BorderRadius.all(Radius.circular(5))),
            child: Stack(
              children: [
                Positioned(
                  // top: 4,
                  // right: 1,
                  // left: Get.height/6.11,
                  child: Container(
                    width: Get.width,
                    height: Get.height / 11.4,
                    decoration: const BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                  ),
                ),
                Positioned(
                  // top: 16,
                  // left: Get.height/6.3,
                  child: Container(
                      width: Get.width,
                      height: Get.height / 12,
                      decoration: const BoxDecoration(
                          // color: const Color(0xffFFFDFD),
                          color: Color(0xffDDFFF4),
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      child: Center(
                          child: Row(
                        children: [
                          Image.asset(
                            AppAssets.resetIcon,
                            height: 19,
                            width: 19,
                          ).marginOnly(left: 12, right: 12),
                          const MyText(
                            'Reset with Passcode',
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                          Spacer(),
                          const Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 15,
                          ).marginOnly(right: 20)
                        ],
                      ))),
                ),
              ],
            ),
          ),
          const MyText(
            'Keep your assets safe by enabling passcode protection.',
            fontWeight: FontWeight.w600,
            fontSize: 9,
            color: Color(0xff858585),
          ).marginOnly(top: 20, left: 12)
        ],
      ),
    ).marginOnly(left: 12, right: 12);
  }

  Widget reStore() {
    return ShortContainer(
      height: Get.height / 5,
      width: Get.width,
      color: Colors.white,
      child: Column(
        children: [
          Container(
            // color: Colors.red,
            height: Get.height / 10,
            width: Get.width / 1,

            decoration: const BoxDecoration(
                // color: Colors.red,
                borderRadius: BorderRadius.all(Radius.circular(5))),
            child: Stack(
              children: [
                Positioned(
                  // top: 4,
                  // right: 1,
                  // left: Get.height/6.11,
                  child: Container(
                    width: Get.width,
                    height: Get.height / 11.4,
                    decoration: const BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                  ),
                ),
                Positioned(
                  // top: 16,
                  // left: Get.height/6.3,
                  child: Container(
                      width: Get.width,
                      height: Get.height / 12,
                      decoration: const BoxDecoration(
                          // color: const Color(0xffFFFDFD),
                          color: Color(0xffDDFFF4),
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      child: Center(
                          child: Row(
                        children: [
                          Image.asset(
                            AppAssets.restoreIcon,
                            height: 19,
                            width: 19,
                          ).marginOnly(left: 12, right: 12),
                          const MyText(
                            'Restore Wallet',
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                          Spacer(),
                          const Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 15,
                          ).marginOnly(right: 20)
                        ],
                      ))),
                ),
              ],
            ),
          ),
          const MyText(
            'Overtime your current Mobile wallet using a Seed Phrase.',
            fontWeight: FontWeight.w600,
            fontSize: 9,
            color: Color(0xff858585),
          ).marginOnly(top: 20, left: 12)
        ],
      ),
    ).marginOnly(left: 12, right: 12);
  }

  Widget topBar() {
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
                            child: const Center(
                              child: Text(
                                'SETTING',
                                style: TextStyle(
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

  void alertDialogAuth() {
    Get.dialog(
      AlertDialog(
        shape: const RoundedRectangleBorder(
            side: BorderSide(color: AppColors.black, width: 2.0),
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        insetPadding: const EdgeInsets.symmetric(horizontal: 15),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(
              width: 50,
            ),
            const Text(
              AppConstants.alertTitleGoogleAuth,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
            InkWell(
              onTap: () {
                Get.back();
              },
              child: Image.asset(
                AppConstants.cancelBtn,
                height: 42,
              ),
            )
          ],
        ),
        content: const Text(
          'You must have Google AUTHENTICATION turned on in order to perform this action',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Color(0xff858585),
              fontSize: 13,
              fontWeight: FontWeight.w600),
        ),
        actions: [
          InkWell(
            onTap: () {
              Get.to(() => Profile());
            },
            child: Container(
              padding: const EdgeInsets.only(right: 20, left: 20),
              child: Image.asset(
                AppConstants.googleAuthBtn,
                height: 54,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
