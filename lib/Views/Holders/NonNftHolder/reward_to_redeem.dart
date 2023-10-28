import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:satoshi/Utils/app_asset_wallet.dart';
import 'package:satoshi/routes/app_routes.dart';
import 'package:satoshi/widget/appbar/commonAppbar.dart';
import '../../../Controllers/rewardToRedeem_controller.dart';
import '../../../Utils/utils.dart';
import '../../../shimmer/rewardto_redeem_effect.dart';
import '../../../widget/bottom_navbar.dart';

class RewardToRedeem extends StatelessWidget {
  const RewardToRedeem({super.key});

  @override
  Widget build(BuildContext context) {
    final mqData = MediaQuery.of(context);
    final mqDataNew = mqData.copyWith(
        textScaleFactor:
            mqData.textScaleFactor > 1.0 ? 1.0 : mqData.textScaleFactor);
    return GetBuilder<RewardToRedeemController>(
      init: RewardToRedeemController(),
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
                            totalsap:
                                _.landingPageController.tokenBalance == null
                                    ? '0.00'
                                    : _.landingPageController.tokenBalance
                                        .toStringAsFixed(2),
                            bnb: _.landingPageController.balanceInBNB == null
                                ? 0.0
                                : double.parse(_
                                    .landingPageController.balanceInBNB
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
              bottomNavigationBar: const BottomNavbarWidget(),
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
                                    Text(
                                      AppConstants.congratulateText,
                                      style: congratulateTextStyle,
                                    ),
                                    const SizedBox(
                                      height: 29,
                                    ),
                                    _.rewardData['RewrdToken']
                                                ['\u0024numberDecimal'] ==
                                            null
                                        ? Text('0', style: noOfSAPStyle)
                                        : Text(
                                            double.parse((_.rewardData[
                                                            'RewrdToken']
                                                        ['\u0024numberDecimal'])
                                                    .toString())
                                                .toStringAsFixed(2),
                                            style: noOfSAPStyle),
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
                                                  child: _.rewardData['travelRecord']
                                                                  ['distance'][
                                                              '\u0024numberDecimal'] ==
                                                          null
                                                      ? Text(
                                                          "0",
                                                          style:
                                                              GoogleFonts.sora(
                                                            textStyle:
                                                                const TextStyle(
                                                              color: AppColors
                                                                  .black,
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                            ),
                                                          ),
                                                        )
                                                      : Text(
                                                          _.myFormat
                                                              .format(double.parse(
                                                                      _.rewardData['travelRecord']
                                                                              [
                                                                              'distance']
                                                                          [
                                                                          '\u0024numberDecimal'])
                                                                  .round())
                                                              .toString(),
                                                          style:
                                                              GoogleFonts.sora(
                                                            textStyle:
                                                                const TextStyle(
                                                              color: AppColors
                                                                  .black,
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                            ),
                                                          ),
                                                        ),
                                                ).marginOnly(top: 35),
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
                                                    _.myFormat
                                                        .format(double.parse(_
                                                                            .rewardData[
                                                                        'travelRecord']
                                                                    [
                                                                    'redeem_km']
                                                                [
                                                                '\u0024numberDecimal'])
                                                            .round())
                                                        .toString(),
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
                                                    double.parse(_.rewardData[
                                                                'BurnedToken'][
                                                            '\u0024numberDecimal'])
                                                        .toStringAsFixed(3),
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
                                      height: 30,
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
                                      height: 10,
                                    ),

                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Stack(
                                            children: [
                                              Align(
                                                  alignment:
                                                      Alignment.bottomCenter,
                                                  child: btnStack(
                                                      'REDEEM',
                                                      true,
                                                      double.parse((_.rewardData[
                                                                      'RewrdToken']
                                                                  [
                                                                  '\u0024numberDecimal'])
                                                              .toString())
                                                          .toStringAsFixed(2),
                                                      _)),
                                              // Align(
                                              //   alignment: Alignment.bottomRight,
                                              //   child: GestureDetector(
                                              //     onTap: () async {
                                              //       await launchUrlString(
                                              //           'https://www.google.com/maps/search/?api=1&query=${_.storage.read('session_tolat')},${_.storage.read('session_tolng')}',
                                              //           mode: LaunchMode
                                              //               .externalApplication);
                                              //     },
                                              //     child: Image.asset(
                                              //       AppConstants.googleicom,
                                              //       height: 50,
                                              //     ).marginOnly(bottom: 100, right: 20),
                                              //   ),
                                              //   // btnStack(
                                              //   //   'REDEEM',
                                              //   //   true,
                                              //   //   double.parse((_.rewardData['RewrdToken']
                                              //   //               ['\u0024numberDecimal'])
                                              //   //           .toString())
                                              //   //       .toStringAsFixed(2),
                                              //   // ).marginOnly(bottom: 60),
                                              // ),
                                            ],
                                          ),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Image.asset(
                                            AppAssets.boostLogo,
                                            width: 115,
                                            height: 39,
                                          )
                                        ]),
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

  Widget btnStack(btnText, boolean, sap, RewardToRedeemController _) {
    return GestureDetector(
        onTap: () {
          _.showScreen = false;
          _.update();

          // _.playSoundEffect();
          Get.toNamed(Routes.redeemSuccessRoutes, arguments: sap);

          // Get.to(() => const RedeemSuccess(), arguments: sap);
        },
        child: Image.asset(
          AppAssets.redeemImage,
          width: 115,
          height: 39,
        )

        // Stack(
        //   children: [
        //     Image.asset(
        //       AppConstants.startBtn,
        //       height: 50,
        //     ),
        //     Container(
        //       padding: EdgeInsets.only(
        //           top: 10, right: boolean ? 20 : 30, left: boolean ? 20 : 30),
        //       child: Text(
        //         btnText,
        //         style: congratulateTextStyle,
        //       ),
        //     )
        //   ],
        // ),
        );
  }
}

// class RewardToRedeem extends StatefulWidget {
//   const RewardToRedeem({Key? key}) : super(key: key);

//   @override
//   State<RewardToRedeem> createState() => _RewardToRedeemState();
// }

// class _RewardToRedeemState extends State<RewardToRedeem> {
//   var assetImage;
//   getUserInfo() async {
//     SharedPreferences pref = await SharedPreferences.getInstance();
//     setState(() {
//       assetImage = pref.getString('assetImage');
//     });
//   }

//   @override
//   void initState() {
//     getUserInfo();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           BalanceTopBar(
//               assetImage == null ? AppConstants.profileImg : assetImage),
//           const SizedBox(
//             height: 50,
//           ),
//           Align(
//             alignment: Alignment.topCenter,
//             child: Container(
//               height: MediaQuery.of(context).size.height * 0.78,
//               width: MediaQuery.of(context).size.width * 0.94,

//               padding: const EdgeInsets.only(left: 10, right: 10),
//               // decoration: BoxDecoration(
//               //     border: Border.all(color: AppColors.black),
//               //     borderRadius: BorderRadius.circular(10)
//               // ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   const SizedBox(
//                     height: 10,
//                   ),
//                   Container(
//                     child: Text(
//                       AppConstants.congratulateText,
//                       style: congratulateTextStyle,
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 29,
//                   ),
//                   Container(
//                     child: Text('3.8', style: noOfSAPStyle),
//                   ),
//                   Container(
//                     child: Text(
//                       'SAP',
//                       style: sAPStyle,
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 10,
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Column(
//                         children: [
//                           Container(
//                               child: Stack(
//                             children: [
//                               Image.asset(
//                                 AppConstants.travelKM,
//                                 height: 100,
//                               ),
//                               Container(
//                                 padding: const EdgeInsets.only(
//                                   top: 55,
//                                   left: 32,
//                                 ),
//                                 child: const Text('3,120'),
//                               )
//                             ],
//                           )),
//                           const SizedBox(
//                             height: 7,
//                           ),
//                           Container(
//                             child: Text(
//                               'TRAVEL KM',
//                               style: rewardTextStyles,
//                             ),
//                           )
//                         ],
//                       ),
//                       Column(
//                         children: [
//                           Container(
//                               padding: const EdgeInsets.only(left: 7, right: 7),
//                               child: Stack(
//                                 children: [
//                                   Image.asset(
//                                     AppConstants.redeemKM,
//                                     height: 100,
//                                   ),
//                                   Container(
//                                     padding: const EdgeInsets.only(
//                                         top: 55, left: 32),
//                                     child: const Text('3,120'),
//                                   )
//                                 ],
//                               )),
//                           const SizedBox(
//                             height: 7,
//                           ),
//                           Container(
//                             child: Text(
//                               'REDEEM KM',
//                               style: rewardTextStyles,
//                             ),
//                           )
//                         ],
//                       ),
//                       Column(
//                         children: [
//                           Container(
//                               child: Stack(
//                             children: [
//                               Image.asset(
//                                 AppConstants.burnSAP,
//                                 height: 100,
//                               ),
//                               Container(
//                                 padding:
//                                     const EdgeInsets.only(top: 55, left: 35),
//                                 child: const Text('3,120'),
//                               )
//                             ],
//                           )),
//                           const SizedBox(
//                             height: 7,
//                           ),
//                           Container(
//                             child: Text(
//                               'SAP BURNED',
//                               style: rewardTextStyles,
//                             ),
//                           )
//                         ],
//                       ),
//                     ],
//                   ),
//                   const SizedBox(
//                     height: 62.36,
//                   ),
//                   Container(
//                     child: Image.asset(
//                       AppConstants.reward,
//                       height: 89,
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 30,
//                   ),
//                   // const SizedBox(
//                   //   height: 43,
//                   // ),
//                   // Container(
//                   //   width: 200,
//                   //   child: buildEmail(),
//                   // ),
//                   // const SizedBox(
//                   //   height: 10,
//                   // ),
//                   // Container(
//                   //   width: 200,
//                   //   child: buildEmail2(),
//                   // ),
//                   //
//                   // const SizedBox(
//                   //   height: 10,
//                   // ),

//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       const SizedBox(
//                         width: 50,
//                       ),
//                       Container(
//                           // width: 200,
//                           child: btnStack('REDEEM', true)),
//                       const SizedBox(
//                         width: 10,
//                       ),
//                       Container(
//                         child: Image.asset(
//                           AppConstants.map,
//                           height: 46,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
