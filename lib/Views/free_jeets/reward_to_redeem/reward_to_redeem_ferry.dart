import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:satoshi/Utils/app_asset_wallet.dart';
import 'package:satoshi/Views/free_jeets/reward_to_redeem/reward_to_redeem_ferry_controller.dart';
import 'package:satoshi/widget/appbar/commonAppbar.dart';
import 'package:satoshi/widget/wallet_widgets/text_widget/text_widget.dart';
import '../../../Utils/utils.dart';
import '../../../shimmer/rewardto_redeem_effect.dart';
import '../redeem_success_ferry/redeem_success_ferry.dart';

class RewardToRedeemFerry extends StatelessWidget {
  const RewardToRedeemFerry({super.key});

  @override
  Widget build(BuildContext context) {
    final mqData = MediaQuery.of(context);
    final mqDataNew = mqData.copyWith(
        textScaleFactor:
            mqData.textScaleFactor > 1.0 ? 1.0 : mqData.textScaleFactor);
    return GetBuilder<RewardToRedeemFerryController>(
      init: RewardToRedeemFerryController(),
      builder: (_) {
        return WillPopScope(
          onWillPop: () async => false,
          child: MediaQuery(
            data: mqDataNew,
            child: Scaffold(
              backgroundColor: const Color(0xffFFFAEC),
              appBar: PreferredSize(
                preferredSize: const Size.fromHeight(90),
                child: SafeArea(
                    child: _.isLoading
                        ? SizedBox()
                        : CommonAppbar(
                            isNetwork:
                                _.landingPageController.assetImage.value.isEmpty
                                    ? false.obs
                                    : true.obs,
                            imagePath: _.landingPageController.assetImage.value
                                    .isEmpty
                                ? AppConstants.profileImg
                                : _.landingPageController.assetImage.value.obs,
                            totalsap: _
                                .landingPageController.balanceData['totalSap']
                                .toString(),
                            bnb: double.parse(_
                                .landingPageController.balanceData['bnbBalance']
                                .toString()),
                            travel: _.landingPageController
                                        .balanceData['distance'] ==
                                    null
                                ? '0'
                                : _.landingPageController
                                    .balanceData['distance']
                                    .toString(),
                          )),
              ),
              body: _.isLoading
                  ? const RewardToRedeemEffect()
                  : SingleChildScrollView(
                      child: Visibility(
                        visible: _.showScreen == true,
                        child: Column(
                          children: [
                            // Builder(
                            //   builder: (context) {
                            //     _.playSoundEffect();
                            //     return Container();},),
                            const SizedBox(
                              height: 20,
                            ),
                            Align(
                              alignment: Alignment.topCenter,
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.78,
                                width: MediaQuery.of(context).size.width * 0.94,
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const SizedBox(
                                      height: 10,
                                    ),

                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text('0.00', style: noOfSAPStyle),
                                    Text(
                                      'SAP',
                                      style: sAPStyle,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          width: Get.width / 4.0,
                                          height: Get.height / 6.5,
                                          child: Column(
                                            children: [
                                              Container(
                                                width: Get.width / 3.8,
                                                height: Get.height / 8,
                                                decoration: const BoxDecoration(
                                                  image: DecorationImage(
                                                    image: AssetImage(
                                                      AppConstants.travelKM,
                                                    ),
                                                  ),
                                                ),
                                                child: Center(
                                                    child: Text(
                                                  "0",
                                                  style: GoogleFonts.sora(
                                                    textStyle: const TextStyle(
                                                      color: AppColors.black,
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                )).marginOnly(top: 35),
                                              ),
                                              const Spacer(),
                                              Text(
                                                "TRAVEL KM",
                                                style: GoogleFonts.sora(
                                                  textStyle: const TextStyle(
                                                    color: AppColors.black,
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        SizedBox(
                                          width: Get.width / 4.0,
                                          height: Get.height / 6.5,
                                          child: Column(
                                            children: [
                                              Container(
                                                width: Get.width / 3.8,
                                                height: Get.height / 8,
                                                decoration: const BoxDecoration(
                                                  image: DecorationImage(
                                                    image: AssetImage(
                                                      AppConstants.redeemKM,
                                                    ),
                                                  ),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    '0.00',
                                                    // _.myFormat
                                                    //     .format(double.parse(_
                                                    //     .rewardData[
                                                    // 'travelRecord']
                                                    // ['redeem_km'][
                                                    // '\u0024numberDecimal'])
                                                    //     .round())
                                                    //     .toString(),
                                                    style: GoogleFonts.sora(
                                                      textStyle:
                                                          const TextStyle(
                                                        color: AppColors.black,
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                  ),
                                                ).marginOnly(top: 35),
                                              ),
                                              const Spacer(),
                                              Text(
                                                "REDEEM KM",
                                                style: GoogleFonts.sora(
                                                  textStyle: const TextStyle(
                                                    color: AppColors.black,
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        SizedBox(
                                          width: Get.width / 4.0,
                                          height: Get.height / 6.5,
                                          child: Column(
                                            children: [
                                              Container(
                                                width: Get.width / 3.8,
                                                height: Get.height / 8,
                                                decoration: const BoxDecoration(
                                                  image: DecorationImage(
                                                    image: AssetImage(
                                                      AppConstants.burnSAP,
                                                    ),
                                                  ),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    '0.00',
                                                    // double.parse(_.rewardData[
                                                    // 'BurnedToken'][
                                                    // '\u0024numberDecimal'])
                                                    //     .toStringAsFixed(3),
                                                    style: GoogleFonts.sora(
                                                      textStyle:
                                                          const TextStyle(
                                                        color: AppColors.black,
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                  ),
                                                ).marginOnly(top: 35),
                                              ),
                                              const Spacer(),
                                              Text(
                                                "SAP BURNED",
                                                style: GoogleFonts.sora(
                                                  textStyle: const TextStyle(
                                                    color: AppColors.black,
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        ferryDialogBox();
                                      },
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Image.asset(
                                              AppConstants.ferryDialogBox,
                                              width: 28,
                                              height: 28,
                                            ),
                                            MyText(
                                              '15.0 SAP',
                                              fontSize: 8,
                                              fontWeight: FontWeight.w400,
                                            )
                                          ]).marginOnly(right: 10, bottom: 10),
                                    ),
                                    Text('AIRDROP',
                                        style: GoogleFonts.sora(
                                          textStyle: TextStyle(
                                            color: AppColors.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        )),
                                    // SizedBox(height: 5,),
                                    Image.asset(
                                      AppConstants.reward,
                                      height: 170.618,
                                      width: 145.771,
                                    ),
                                    // Spacer(),
                                    SizedBox(
                                      height: 30,
                                    ),

                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          btnStack('REDEEM', true, _)
                                              .marginOnly(left: 30),
                                          SizedBox(
                                            width: 18,
                                          ),
                                          Image.asset(
                                            AppAssets.boostLogo,
                                            width: 118,
                                            height: 42,
                                          ).marginOnly(right: 12)
                                        ]),

                                    Align(
                                        alignment: Alignment.topRight,
                                        child: MyText(
                                          '*Watch AD, Boost reward !',
                                          fontWeight: FontWeight.w400,
                                          fontSize: 8,
                                        ).marginOnly(right: 25, top: 5))
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
            ),
          ),
        );
      },
    );
  }

  Widget btnStack(btnText, boolean, RewardToRedeemFerryController _) {
    return GestureDetector(
        onTap: () {
          _.showScreen = false;
          _.update();

          // _.playSoundEffect();
          Get.to((RedeemSuccessFerry()));

          // Get.to(() => const RedeemSuccess(), arguments: sap);
        },
        child: Image.asset(
          AppAssets.redeemImage,
          height: 42,
          width: 118,
        ));
  }

  void ferryDialogBox() {
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(10), // Adjust the border radius as needed
        ),
        backgroundColor: Colors.white,
        contentPadding: EdgeInsets.zero,
        content: Container(
          width: Get.width, // Set the width of the dialog
          height: 128, // Set the height of the dialog
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Image.asset(
                    AppAssets.telephoneLogo,
                    height: 19,
                  ).marginOnly(left: 40),
                  MyText(
                    '6/25/23',
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                  Spacer(),
                  Image.asset(
                    AppAssets.daysLogo,
                    height: 19,
                  ),
                  MyText(
                    '58 Days',
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ).marginOnly(right: 40),
                ],
              ),
              Row(
                children: [
                  MyText(
                    'Checked in Date',
                    fontSize: 13,
                  ).marginOnly(left: 40),
                  Spacer(),
                  MyText(
                    'D Day',
                    fontSize: 13,
                  ).marginOnly(right: 65),
                ],
              ),
              Row(children: [
                Image.asset(
                  AppAssets.heartLogo,
                  width: 38,
                ).marginOnly(left: 40, top: 12),
                Column(
                  children: [
                    Row(children: [
                      SizedBox(
                        width: 5,
                      ),
                      MyText(
                        'Advance check in',
                        fontSize: 13,
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      MyText(
                        '10 Sap',
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      )
                    ]).marginOnly(top: 20),
                    SizedBox(
                      width: 5,
                    ),
                    Row(children: [
                      SizedBox(
                        width: 10,
                      ),
                      MyText(
                        'Flight Book Reward',
                        fontSize: 13,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      MyText(
                        '10 Sap',
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      )
                    ]),
                  ],
                )
              ])
            ],
          ).marginOnly(top: 15),
        ),
      ),
    );
  }
}
