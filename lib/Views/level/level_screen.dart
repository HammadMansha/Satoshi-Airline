import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

// import 'package:satoshi/Views/Holders/NftHolder/destination.dart';
import 'package:satoshi/routes/app_routes.dart';
import 'package:satoshi/widget/wallet_widgets/common_toast_message.dart';
import 'package:slide_countdown/slide_countdown.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../../Utils/app_colors.dart';
import '../../../../Utils/app_constants.dart';
import '../../../../Utils/app_text_styles.dart';
import '../../Controllers/level/level_controller.dart';
import '../../Utils/commonSnackbar.dart';
import '../../widget/appbar/commonAppbar.dart';
import '../../widget/bottom_navbar2.dart';
import '../../widget/cached_networkImage.dart';
import '../../widget/common_button.dart';
import '../Holders/HolderCommon/basictab_screen.dart';
import '../qr/qr_screen.dart';

class LevelScreen extends StatelessWidget {
  const LevelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mqData = MediaQuery.of(context);
    final mqDataNew = mqData.copyWith(
        textScaleFactor:
            mqData.textScaleFactor > 1.0 ? 1.0 : mqData.textScaleFactor);
    return GetBuilder<LevelController>(
      init: LevelController(),
      builder: (_) {
        return Obx(
           () {
            return MediaQuery(
              data: mqDataNew,
              child: Scaffold(
                resizeToAvoidBottomInset: false,
                bottomNavigationBar: _.isArrgument
                    ? BottomNavbarWidget2(
                        onPressed: () {
                          if (_.storage.hasData('from') == false) {
                            if (_.levelInfo['minutes'] != null) {
                              if (_.levelInfo['minutes'] > 0 ||
                                  _.checkData(_.levelInfo['expiry']) <= 0) {
                                levelDialogBox(
                                  _,
                                  _.nftData['cardType'],
                                  _.nftData['cardLevel'],
                                );
                              } else {
                                print("check ${_.levelInfo['expiry']}");
                                print(
                                    "checl ${_.checkData(_.levelInfo['expiry'])}");
                                _.timer.value = _.checkData(_.levelInfo['expiry']);
                                // _.voidtimmer(_.checkData(
                                //     _.levelInfo['expiry']));
                                _.isBoost = false;
                                _.update();
                                levelBoosterDialogBox(
                                  _,
                                  'booster',
                                  _.nftData['cardLevel'],
                                  _.checkData(_.levelInfo['expiry']),
                                );
                              }
                            } else {
                              _.timer.value = _.checkData(_.levelInfo['expiry']);
                              // _.voidtimmer(_.checkData(
                              //     _.levelInfo['expiry']));
                              _.isBoost = false;
                              _.update();
                              levelBoosterDialogBox(
                                _,
                                'booster',
                                _.nftData['cardLevel'],
                                _.checkData(_.levelInfo['expiry']),
                              );
                            }
                          } else {
                            CommonToast.getToast(
                              'Please complete your pending process',
                            );
                          }
                        },
                      )
                    : null,
                appBar: PreferredSize(
                  preferredSize: const Size.fromHeight(90),
                  child: SafeArea(
                    child: CommonAppbar(
                      isNetwork: _.landingPageController.assetImage.value.isEmpty
                          ? false.obs
                          : true.obs,
                      imagePath: _.landingPageController.assetImage.value.isEmpty
                          ? AppConstants.profileImg
                          : _.landingPageController.assetImage.value.obs,
                      totalsap: _.landingPageController.tokenBalance == null
                          ? '0.00'
                          : _.landingPageController.tokenBalance.toStringAsFixed(2),
                      bnb: _.landingPageController.balanceInBNB == null
                          ? 0.0
                          : double.parse(
                              _.landingPageController.balanceInBNB.toString()),
                      travel:
                          _.landingPageController.balanceData['distance'] == null
                              ? '0'
                              : _.landingPageController.balanceData['distance']
                                  .toString(),
                    ),
                  ),
                ),
                body: _.isLoading
                    ? Center(child: Image.asset(AppConstants.boarding))
                    : startMinting(_, context),
              ),
            );
          }
        );
      },
    );
  }

  Widget startMinting(LevelController _, BuildContext context) {
    return DefaultTabController(
      length: _.myTabs.length,
      initialIndex: 0,
      child: Column(
        children: [
          tabbarCustom(_, context),
          Expanded(child: bodyPages(_, context)[_.indexing]),
        ],
      ),
    );
  }

  List<Widget> bodyPages(LevelController _, BuildContext context) {
    return [testFlight(_, context), const BasicTabScreen(), QrScreen()];
  }

  Widget testFlight(LevelController _, BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
            width: Get.width,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: AppColors.black),
              borderRadius: BorderRadius.circular(
                10,
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // const SizedBox(
                          //   width: 15,
                          // ),
                          Column(
                            children: [

                              //------------------------Check wing purchase--------------------
                              _.wingPurchase.value==true?Image.asset(AppConstants.wingIcon,height:31,width:40):
                              Container(
                                decoration: BoxDecoration(
                                    color: const Color(0xffffff00),
                                    border: Border.all(
                                        color: AppColors.black, width: 1.0),
                                    borderRadius: BorderRadius.circular(5)),
                                height: 31,
                                width: 31,
                                child:   IconButton(
                                  icon: Image.asset(AppConstants.addIcon),
                                  onPressed: () {
                                    upgradeRuins(_);

                                    // _.avalue.value.clear();
                                    // _.update();
                                    // buyAttribute(
                                    //   _,
                                    // );
                                  },
                                ),
                              ).marginOnly(left: 15),
                              const SizedBox(
                                height: 25,
                              ),

                              //------------------------Check engine purchase--------------------


                              _.enginePurchase.value==true?Image.asset(AppConstants.engineIcon,height:31,width:40):

                              Container(
                                decoration: BoxDecoration(
                                    color: const Color(0xffFF98BD),
                                    border: Border.all(
                                        color: AppColors.black, width: 1.0),
                                    borderRadius: BorderRadius.circular(5)),
                                height: 31,
                                width: 31,
                                child: IconButton(
                                  icon: Image.asset(AppConstants.addIcon),
                                  onPressed: () {
                                    upgradeRuins(_);
                                    // _.avalue.value.clear();
                                    // _.update();
                                    // buyAttribute(
                                    //   _,
                                    // );
                                  },
                                ),
                              ).marginOnly(left: 15),
                              const SizedBox(
                                height: 25,
                              ),

                              //-----------------------------Check for radio purchase-------------------------
                              _.radioPurchase.value==true?Image.asset(AppConstants.radioIcon,height:31,width:40):

                              Container(
                                decoration: BoxDecoration(
                                    color: const Color(0xffB1F9E2),
                                    border: Border.all(
                                        color: AppColors.black, width: 1.0),
                                    borderRadius: BorderRadius.circular(5)),
                                height: 31,
                                width: 31,
                                child: IconButton(
                                  icon: Image.asset(AppConstants.addIcon),
                                  onPressed: () {
                                    upgradeRuins(_);
                                    // _.avalue.value.clear();
                                    // _.update();
                                    // buyAttribute(
                                    //   _,1122Rbsolutions..
                                    // );
                                  },
                                ),
                              ).marginOnly(left: 15),
                              const SizedBox(
                                height: 25,
                              ),

                              //------------------------Check for black box purchase----------------------
                              _.blackBoxPurchase.value==true?Image.asset(AppConstants.blackBoxIcon,height:31,width:40):

                              Container(
                                decoration: BoxDecoration(
                                    color: const Color(0xffF198FF),
                                    border: Border.all(
                                        color: AppColors.black, width: 1.0),
                                    borderRadius: BorderRadius.circular(5)),
                                height: 31,
                                width: 31,
                                child: IconButton(
                                  icon: Image.asset(AppConstants.addIcon),
                                  onPressed: () {
                                    upgradeRuins(_);
                                    // _.avalue.value.clear();
                                    // _.update();
                                    // buyAttribute(
                                    //   _,
                                    // );
                                  },
                                ),
                              ).marginOnly(left: 15),
                            ],
                          ),

                          const Spacer(),
                          Column(
                            children: [
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () async {
                                      if (_
                                          .landingPageController
                                          .minitingGlobleController
                                          .assetsData
                                          .isNotEmpty) {
                                        if (_.currentIndex != 0) {
                                          _.currentIndex--;
                                          _.update();
                                          await _.getData();
                                        }
                                      }
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: const Icon(Icons.arrow_back_ios),
                                    ),
                                  ),
                                  SizedBox(
                                    height: Get.height / 3.3,
                                    width: Get.width / 2.0,
                                    child: Stack(
                                      children: [
                                        Align(
                                          alignment: Alignment.topCenter,
                                          child: Container(
                                            height: 100,
                                            width: Get.width / 2.9,
                                            decoration: BoxDecoration(
                                              color: const Color(0xffddfff4),
                                              borderRadius:
                                                  const BorderRadius.only(
                                                topLeft: Radius.circular(10),
                                                topRight: Radius.circular(10),
                                              ),
                                              border: Border.all(
                                                color: Colors.black,
                                              ),
                                            ),
                                            child: Align(
                                              alignment: Alignment.topCenter,
                                              child: Text(
                                                _.nftData['cardType']
                                                    .toString()
                                                    .toUpperCase(),
                                                style: GoogleFonts.sora(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 13,
                                                ),
                                              ).marginOnly(top: 5),
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            // if (_.levelInfo['minutes'] !=
                                            //     null) {
                                            //   if (_.levelInfo['minutes'] > 0 ||
                                            //       _.checkData(_.levelInfo[
                                            //               'expiry']) <=
                                            //           0) {
                                            //     levelDialogBox(
                                            //       _,
                                            //       _.nftData['cardType'],
                                            //       _.nftData['cardLevel'],
                                            //     );
                                            //   } else {
                                            //     print(
                                            //         "check ${_.levelInfo['expiry']}");
                                            //     print(
                                            //         "checl ${_.checkData(_.levelInfo['expiry'])}");
                                            //     _.timer.value = _.checkData(
                                            //         _.levelInfo['expiry']);
                                            //     // _.voidtimmer(_.checkData(
                                            //     //     _.levelInfo['expiry']));
                                            //     _.isBoost = false;
                                            //     _.update();
                                            //     levelBoosterDialogBox(
                                            //       _,
                                            //       'booster',
                                            //       _.nftData['cardLevel'],
                                            //       _.checkData(
                                            //           _.levelInfo['expiry']),
                                            //     );
                                            //   }
                                            // } else {
                                            //   _.timer.value = _.checkData(
                                            //       _.levelInfo['expiry']);
                                            //   // _.voidtimmer(_.checkData(
                                            //   //     _.levelInfo['expiry']));
                                            //   _.isBoost = false;
                                            //   _.update();
                                            //   levelBoosterDialogBox(
                                            //     _,
                                            //     'booster',
                                            //     _.nftData['cardLevel'],
                                            //     _.checkData(
                                            //         _.levelInfo['expiry']),
                                            //   );
                                            // }
                                          },
                                          child: Align(
                                            alignment: Alignment.bottomCenter,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: Colors.black,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0)),
                                              child: CircularCachedNetworkImage(
                                                height: Get.height / 3.9,
                                                width: Get.width / 1.9,
                                                imageURL: _.imagePath,
                                                borderColor: Colors.black,
                                                radius: 5.0,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: GestureDetector(
                                      onTap: () async {
                                        if (_
                                            .landingPageController
                                            .minitingGlobleController
                                            .assetsData
                                            .isNotEmpty) {
                                          if (_.currentIndex <=
                                              _
                                                  .landingPageController
                                                  .minitingGlobleController
                                                  .assetsData
                                                  .length) {
                                            _.currentIndex++;
                                            _.update();
                                            await _.getData();
                                          }
                                        }
                                        print("Forward Arrow");
                                      },
                                      child: const Icon(
                                        Icons.arrow_forward_ios,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Container(
                                    height: 20,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.black,
                                        ),
                                        borderRadius: BorderRadius.circular(7)),
                                    child: Center(
                                      child: Text(
                                        "#${_.id.toString()}",
                                        style: GoogleFonts.sora(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12),
                                      ),
                                    ).marginOnly(left: 15, right: 15),
                                  ),
                                  const SizedBox(
                                    width: 10.0,
                                  ),
                                  Container(
                                    height: 20,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.black,
                                        ),
                                        borderRadius: BorderRadius.circular(7)),
                                    child: Center(
                                      child: Text(
                                        "0/3",
                                        style: GoogleFonts.sora(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12),
                                      ),
                                    ).marginOnly(left: 15, right: 15),
                                  ),
                                  const SizedBox(
                                    width: 10.0,
                                  ),
                                  GestureDetector(
                                    onTap: () {},
                                    child: Container(
                                      height: 20,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Colors.black,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(7)),
                                      child: Center(
                                        child: Text(
                                          "Lv${_.nftData['cardLevel']}",
                                          style: GoogleFonts.sora(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 12),
                                        ),
                                      ).marginOnly(left: 15, right: 15),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: () {
                          if (_.storage.hasData('from') == false) {
                            buyAttribute(_);
                          } else {
                            CommonToast.getToast(
                              'Please complete your pending process',
                            );
                          }
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: const EdgeInsets.only(top: 10),
                              child: Text(
                                AppConstants.attributes,
                                style: noOfSapStyle,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.only(top: 10),
                              child: Row(
                                children: [
                                  Container(
                                      height: 17,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 2,
                                              color: AppColors.redLight),
                                          borderRadius:
                                              BorderRadius.circular(2)),
                                      child: Image.asset(
                                        AppConstants.addIcon,
                                        color: AppColors.redLight,
                                        height: 15,
                                      )
                                      // Icon(Icons.add, color: Color(0xffCE1E2E), size: 17,),
                                      )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 24,
                            child: Image.asset(
                              AppConstants.fuelIcon,
                              height: 24,
                            ).marginOnly(top: 8),
                          ),
                          Container(
                            padding: const EdgeInsets.only(top: 5, left: 5),
                            child: Text(
                              'FUEL',
                              style: attributesTextStyle,
                            ),
                          ).marginOnly(top: 10),
                          const Spacer(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Container(
                                padding: EdgeInsets.zero,
                                margin: EdgeInsets.zero,
                                // padding: EdgeInsets.only(top: 5,left: 100),
                                child: Text(
                                  '${double.parse((_.nftData['attributes']['fuel']['value']).toString()).toStringAsFixed(2)}/${double.parse((_.nftData['attributes']['fuel']['maxValue']).toString()).toStringAsFixed(2)}',
                                  style: attributesValueStyle,
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black),
                                    borderRadius: BorderRadius.circular(5)),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(5.0),
                                  child: LinearPercentIndicator(
                                    lineHeight: 23.0,
                                    width: Get.width / 1.7,
                                    // barRadius: const Radius.circular(5.0),
                                    padding: const EdgeInsets.all(0.0),
                                    percent: _.nftData['attributes']['fuel']
                                                ['value'] <
                                            0
                                        ? 0.0
                                        : double.parse(
                                            (_.nftData['attributes']['fuel']
                                                        ['value'] /
                                                    _.nftData['attributes']
                                                        ['fuel']['maxValue'])
                                                .toString(),
                                          ),
                                    center: Text(double.parse(
                                            (_.nftData['attributes']['fuel']
                                                    ['value'])
                                                .toString())
                                        .toStringAsFixed(2)),
                                    animation: true,
                                    backgroundColor: Colors.transparent,
                                    progressColor: const Color(0xff62c8a9),
                                    fillColor: const Color(0xffd3d3d3),
                                  ),
                                ),
                              ),
                            ],
                          ).marginOnly(right: 5)
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 24,
                            child: Image.asset(
                              AppConstants.mineIcon,
                              height: 24,
                            ),
                          ).marginOnly(top: 10),
                          Container(
                              padding: const EdgeInsets.only(top: 5, left: 5),
                              child: Text(
                                'MINE',
                                style: attributesTextStyle,
                              )).marginOnly(top: 10),
                          const Spacer(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                '${double.parse((_.nftData['attributes']['mine']['value']).toString()).toStringAsFixed(2)}/${double.parse((_.nftData['attributes']['mine']['maxValue']).toString()).toStringAsFixed(2)}',
                                style: attributesValueStyle,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black),
                                    borderRadius: BorderRadius.circular(5)),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(5.0),
                                  child: LinearPercentIndicator(
                                    lineHeight: 23.0,
                                    width: Get.width / 1.7,
                                    // barRadius: const Radius.circular(5.0),
                                    padding: const EdgeInsets.all(0.0),
                                    // percent: 0.0,
                                    percent: _.nftData['attributes']['mine']
                                                ['value'] <
                                            0
                                        ? 0.0
                                        : _.nftData['attributes']['mine']
                                                ['value'] /
                                            _.nftData['attributes']['mine']
                                                ['maxValue'],
                                    animation: true,
                                    center: Text(
                                      "${double.parse((_.nftData['attributes']['mine']['value']).toString()).toStringAsFixed(2)}%",
                                    ),
                                    backgroundColor: Colors.transparent,
                                    progressColor: const Color(0xff62c8a9),
                                    fillColor: const Color(0xffd3d3d3),
                                  ),
                                ),
                              ),
                            ],
                          ).marginOnly(right: 5)
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 24,
                            child: Image.asset(
                              AppConstants.durabilityIcon,
                              height: 24,
                            ).marginOnly(top: 10),
                          ),
                          Container(
                              padding: const EdgeInsets.only(top: 5, left: 5),
                              child: Text(
                                'Durability'.toUpperCase(),
                                style: attributesTextStyle,
                              )).marginOnly(top: 10),
                          const Spacer(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                '${double.parse((_.nftData['attributes']['durability']['value']).toString()).toStringAsFixed(2)}/${double.parse((_.nftData['attributes']['durability']['maxValue']).toString()).toStringAsFixed(2)}',
                                style: attributesValueStyle,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black),
                                    borderRadius: BorderRadius.circular(5)),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(5.0),
                                  child: LinearPercentIndicator(
                                    lineHeight: 23.0,
                                    width: Get.width / 1.7,
                                    // barRadius: const Radius.circular(5.0),
                                    padding: const EdgeInsets.all(0.0),
                                    // percent: 0.0,
                                    percent: _.nftData['attributes']
                                                ['durability']['value'] <
                                            0
                                        ? 0.0
                                        : _.nftData['attributes']['durability']
                                                ['value'] /
                                            _.nftData['attributes']
                                                ['durability']['maxValue'],
                                    animation: true,
                                    center: Text(
                                      double.parse((_.nftData['attributes']
                                                  ['durability']['value'])
                                              .toString())
                                          .toStringAsFixed(2),
                                    ),
                                    backgroundColor: Colors.transparent,
                                    progressColor: const Color(0xff62c8a9),
                                    fillColor: const Color(0xffd3d3d3),
                                  ),
                                ),
                              )
                            ],
                          ).marginOnly(right: 5)
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 24,
                            child: Image.asset(
                              AppConstants.luckyIcon,
                              height: 24,
                            ).marginOnly(top: 12),
                          ),
                          Container(
                              padding: const EdgeInsets.only(top: 5, left: 5),
                              child: Text(
                                'Luck'.toUpperCase(),
                                style: attributesTextStyle,
                              )).marginOnly(top: 10),
                          const Spacer(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                '${double.parse((_.nftData['attributes']['luck']['value']).toString()).toStringAsFixed(2)}/${double.parse((_.nftData['attributes']['luck']['maxValue']).toString()).toStringAsFixed(2)}',
                                style: attributesValueStyle,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(5.0),
                                  child: LinearPercentIndicator(
                                    lineHeight: 23.0,
                                    width: Get.width / 1.7,
                                    padding: const EdgeInsets.all(0.0),
                                    // percent: 0.0,
                                    percent: _.nftData['attributes']['luck']
                                                ['value'] <
                                            0
                                        ? 0.0
                                        : _.nftData['attributes']['luck']
                                                ['value'] /
                                            _.nftData['attributes']['luck']
                                                ['maxValue'],
                                    center: Text(double.parse(
                                            (_.nftData['attributes']['luck']
                                                    ['value'])
                                                .toString())
                                        .toStringAsFixed(2)),
                                    animation: true,
                                    backgroundColor: Colors.transparent,
                                    progressColor: const Color(0xff62c8a9),
                                    fillColor: const Color(0xffd3d3d3),
                                  ),
                                ),
                              ),
                            ],
                          ).marginOnly(right: 5)
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      btnStack(AppConstants.start, false, context, _),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        AppConstants.tutTextBtn,
                        style: attributesValueStyle,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ).marginOnly(left: 20, right: 20),
                ],
              ),
            ),
          ).marginOnly(left: 10, right: 10),
        ),
      ],
    );
  }

  Widget tabbarCustom(LevelController _, BuildContext context) {
    return Container(
      height: 50,
      width: Get.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: AppColors.black,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              _.indexing = 0;
              _.update();
            },
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10)),
              child: Container(
                height: 50,
                width: Get.width / 2.8,
                decoration: BoxDecoration(
                    color: _.indexing == 0
                        ? const Color(0xff62C8A9)
                        : const Color(0xffCDCDCD),
                    border: const Border(
                      right: BorderSide(
                        color: Colors.black,
                      ),
                    )),
                child: const Center(
                  child: Text("Test Flight"),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              _.indexing = 1;
              _.update();

              CommonToast.getToast(
                'Coming soon',
              );
              if (_.landingPageController.isSound) {
                _.landingPageController.playSoundEffect();
              }
              // _.indexing = 1;
              // _.update();
            },
            child: Container(
              height: 50,
              width: Get.width / 2.8,
              decoration: BoxDecoration(
                  color: _.indexing == 1
                      ? const Color(0xff62C8A9)
                      : const Color(0xffCDCDCD),
                  // borderRadius: BorderRadius.circular(5),
                  border: const Border(
                    right: BorderSide(
                      color: Colors.black,
                    ),
                  )
                  // border: Border.all(
                  //   color: AppColors.black,
                  //   width: 1,
                  // ),
                  ),
              child: const Center(
                child: Text("Basic"),
              ),
            ),
          ),
          Flexible(
            child: GestureDetector(
              onTap: () {
                Get.dialog(
                  Dialog(
                    insetPadding: const EdgeInsets.all(0),
                    backgroundColor: Colors.transparent,
                    child: SizedBox(
                      height: Get.height / 1.4,
                      width: Get.width,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CommonButton(
                              text: "HOW TO PLAY",
                              onPressed: () async {
                                await launchUrlString(
                                    'https://www.youtube.com/watch?v=V4A4cklChnU&t=34s',
                                    mode: LaunchMode.externalApplication);
                              },
                              color: const Color(0xffFFF7AF)),
                          CommonButton(
                                  text: "WHITEPAPER",
                                  onPressed: () async {
                                    await launchUrlString(
                                        'https://satoshiair.gitbook.io/docs/',
                                        mode: LaunchMode.externalApplication);
                                  },
                                  color: const Color(0xffFFFFFF))
                              .marginSymmetric(vertical: 25),
                          CommonButton(
                              text: "LINKTREE",
                              onPressed: () async {
                                await launchUrlString(
                                    'https://linktr.ee/satoshiairline',
                                    mode: LaunchMode.externalApplication);
                              },
                              color: const Color(0xffFFFFFF)),
                          const SizedBox(
                            height: 20,
                          ),
                          QrScreen(),
                        ],
                      ).marginSymmetric(horizontal: 32),
                    ),
                  ),
                );
              },
              child: Container(
                height: 50,
                width: Get.width / 4.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                    child: Image.asset(
                  AppConstants.helpIcon,
                  height: 17,
                )),
              ),
            ),
          ),
        ],
      ),
    ).marginOnly(left: 10, right: 10);
  }

  Widget btnStack(btnText, boolean, BuildContext context, LevelController _) {
    return GestureDetector(
      onTap: () async {
        Get.toNamed(Routes.destinationRoutes, arguments: _.imagePath);
        // await _.storage.write("token_imagepath", _.imagePath);
        // Get.to(() => const Destination(), arguments: _.imagePath);
      },
      child: Container(
        height: 50,
        width: 125,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppConstants.startBtn),
            // fit: BoxFit.fill,
            // alignment: Alignment.topLeft
          ),
        ),
        child: Center(
          child: Text(
            btnText,
            style: congratulateTextStyle,
          ),
        ),
      ),
    );
  }

  buyAttribute(
    LevelController _,
  ) {
    Get.dialog(
      AlertDialog(
          elevation: 0.0,
          scrollable: true,
          contentPadding: const EdgeInsets.all(0.0),
          backgroundColor: Colors.transparent,
          content: StatefulBuilder(
            builder: (context, setState) {
              return Container(
                width: Get.width,
                decoration: BoxDecoration(
                  color: const Color(0xffDDFFF4),
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Colors.black),
                ),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Spacer(),
                        Text(
                          "IMPROVE ATTRIBUTE LIMIT",
                          style: GoogleFonts.sora(
                            fontWeight: FontWeight.w700,
                            fontSize: 13,
                          ),
                        ).marginOnly(left: 20),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: const Color(0xff62C8A9),
                              border: Border.all(color: Colors.black),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color.fromRGBO(27, 60, 71, 0.25),
                                  blurRadius: 4,
                                  spreadRadius: 2,
                                  offset: Offset(0, 3), // Shadow position
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.close,
                              color: Colors.white,
                              size: 18,
                            ),
                          ).marginOnly(right: 10, top: 10),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      width: Get.width,
                      decoration: BoxDecoration(
                        color: const Color(0xffFFFAEC),
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: Get.width / 4,
                                child: Text(
                                  "Attribute",
                                  style: GoogleFonts.sora(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Container(
                                width: Get.width / 3.0,
                                height: 50,
                                color: Color(0xffFFE9DD).withOpacity(0.1),
                                child: InputDecorator(
                                  baseStyle: TextStyle(
                                      fontSize: 2, color: Colors.black),
                                  decoration: InputDecoration(
                                    hintText: 'select',
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 0.0, horizontal: 10.0),
                                    focusColor: Colors.black,
                                    hoverColor: Colors.black,
                                    filled: true,
                                    fillColor: Colors.white,
                                    hintStyle: TextStyle(
                                      color: Colors.black,
                                      overflow: TextOverflow.ellipsis,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: 'Roboto',
                                      letterSpacing: 0.0,
                                    ),

                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.black, width: 1.0),
                                    ),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(5.0),
                                        ),
                                        borderSide: BorderSide(width: 1.0)),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(5.0),
                                      ),
                                      borderSide: BorderSide(
                                          color: Colors.black, width: 3.0),
                                    ),
                                    labelStyle: TextStyle(
                                        color: Color(0xff2B2B2B),
                                        fontSize: 15.0),
                                    // fillColor: Colors.white,
                                  ),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton(
                                      borderRadius: BorderRadius.circular(4),
                                      dropdownColor: Colors.white,
                                      icon: Icon(
                                        Icons.arrow_drop_down_rounded,
                                        size: 15.0,
                                        color: Colors.black,
                                      ),
                                      style: GoogleFonts.sora(
                                          fontSize: 10,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w400),
                                      value: _.selectedValue.value.text != ''
                                          ? _.selectedValue.value.text
                                          : _.attributesList[0]['id']
                                              .toString(),
                                      isDense: true,
                                      isExpanded: true,
                                      items: _.attributesList.map((list) {
                                        return DropdownMenuItem(
                                          child: list['name'] != ''
                                              ? Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      width: 20,
                                                      child: Image.asset(
                                                        list['iconPath'],
                                                        height: 25,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Flexible(
                                                      child: Text(
                                                        '${list['name']}',
                                                        style: GoogleFonts.sora(
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.w300,
                                                        ),
                                                        maxLines: 1,
                                                      ),
                                                    )
                                                  ],
                                                )
                                              : Text('notfound'),
                                          value: list['id'].toString(),
                                        );
                                      }).toList(),
                                      onChanged: (value) {
                                        setState(
                                          () {
                                            setState(
                                              () {
                                                _.avalue.value.clear();
                                                _.selectedValue.value.text =
                                                    value.toString();
                                                var c = _.attributesList
                                                    .firstWhere((element) =>
                                                        element['id'] == value);
                                                _.maxValaue = c['value'];
                                                _.minValue = c['minvalue'];
                                              },
                                            );
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: Get.width / 4,
                                child: Text(
                                  "Max Value",
                                  style: GoogleFonts.sora(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Container(
                                width: Get.width / 3.0,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(color: Colors.black),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Row(
                                  children: [
                                    const SizedBox(
                                      width: 2,
                                    ),
                                    Text(
                                      "${_.maxValaue}",
                                      style: GoogleFonts.sora(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    const Spacer(),
                                    const Icon(
                                      Icons.keyboard_arrow_down,
                                      size: 15,
                                    ).marginOnly(right: 5)
                                  ],
                                ).marginOnly(
                                    top: 5, bottom: 5, left: 10, right: 10),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: Get.width / 4,
                                child: Text(
                                  "Upgrade Value",
                                  style: GoogleFonts.sora(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              SizedBox(
                                width: Get.width / 3.0,
                                // height: 50,
                                child: Form(
                                  key: _.formKey,
                                  child: Obx(
                                    () => TextFormField(
                                      keyboardType: TextInputType.number,
                                      controller: _.avalue.value,
                                      onChanged: (value) {
                                        setState(() {
                                          _.avalue.value.text = value;
                                          _.avalue.value.selection =
                                              TextSelection.fromPosition(
                                            TextPosition(
                                              offset:
                                                  _.avalue.value.text.length,
                                            ),
                                          );
                                        });
                                      },
                                      autovalidateMode: AutovalidateMode.always,
                                      validator: (value) {
                                        if (value!.isNotEmpty) {
                                          print(
                                              "check c ${_.avalue.value.text.toString()}");
                                          if (double.parse(
                                                  _.maxValaue.toString()) <=
                                              double.parse(
                                                  _.avalue.value.text)) {
                                            CommonToast.getToast(
                                                "Purchase within the maximum energy range");
                                            return "";
                                          }
                                        }
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.white,
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: AppColors.black,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                          borderSide: BorderSide(
                                            width: 1,
                                            color: AppColors.black,
                                          ),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: AppColors.red,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: AppColors.red,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                        ),
                                        hintText: "Enter value",
                                        labelStyle: GoogleFonts.sora(
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        hintStyle: GoogleFonts.sora(
                                          color: AppColors.primaryColor2,
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                if (double.parse(_.maxValaue.toString()) -
                                        double.parse(_.minValue.toString()) ==
                                    0.0) {
                                  CommonToast.getToast("Already Max energy");
                                } else {
                                  var c = double.parse(_.maxValaue.toString()) -
                                      double.parse(_.minValue.toString());
                                  _.avalue.value.text = c.toString();
                                }
                              });
                            },
                            child: Text(
                              "Max",
                              style: GoogleFonts.sora(
                                color: Colors.red,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ).marginOnly(left: 190),
                          const SizedBox(
                            height: 30,
                          )
                        ],
                      ).marginOnly(left: 20, right: 20),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: Get.width,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.black,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Obx(
                        () => Row(
                          children: [
                            const Text(
                              "COST",
                              style: TextStyle(
                                color: Color(0xff858585),
                                fontSize: 12,
                              ),
                            ),
                            const Spacer(),
                            _.selectedValue.value.text == 'MINE'
                                ? Text(
                                    _.avalue.value.text.isEmpty
                                        ? ''
                                        : "${10 * double.parse(_.avalue.value.text) / 0.5} SAP",
                                    style: GoogleFonts.sora(
                                      color: Colors.black,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  )
                                : Text(
                                    "${_.maxValue()} SAP",
                                    style: GoogleFonts.sora(
                                      color: Colors.black,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                          ],
                        ).marginOnly(left: 15, right: 15),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        btn(
                          color: Colors.white,
                          title: "NEXT TIME",
                          onTap: () {
                            Get.back();
                          },
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        btn(
                          color: const Color(0xffffbb42),
                          title: "CONFIRM",
                          onTap: () async {
                            print(
                                "check Datatype ${_.avalue.value.text.runtimeType}");
                            if (_.formKey.currentState!.validate()) {
                              Get.back();
                              await _.updateAttribute(
                                  _.selectedValue.value.text.toLowerCase());
                            }
                          },
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                  ],
                ).marginOnly(left: 10, right: 10),
              );
            },
          )),
    );
  }

  upgradeRuins(
    LevelController _,
  ) {
    Get.dialog(

      AlertDialog(
          elevation: 0.0,
          scrollable: true,
          contentPadding: const EdgeInsets.all(0.0),
          backgroundColor: Colors.transparent,
          content: StatefulBuilder(
            builder: (context, setState) {
              return
                Container(
                  height: Get.height/2,
                width: Get.width,
                decoration: BoxDecoration(
                  color: const Color(0xffDDFFF4),
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Colors.black),
                ),
                child:_.transactionLoader==true?Center(child: CircularProgressIndicator()): Column(
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Spacer(),
                        Text(
                          "UPGRADE RUNES",
                          style: GoogleFonts.sora(
                            fontWeight: FontWeight.w700,
                            fontSize: 13,
                          ),
                        ).marginOnly(left: 20),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: const Color(0xff62C8A9),
                              border: Border.all(color: Colors.black),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color.fromRGBO(27, 60, 71, 0.25),
                                  blurRadius: 4,
                                  spreadRadius: 2,
                                  offset: Offset(0, 3), // Shadow position
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.close,
                              color: Colors.white,
                              size: 18,
                            ),
                          ).marginOnly(right: 10, top: 10),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      width: Get.width,
                      decoration: BoxDecoration(
                        color: const Color(0xffFFFAEC),
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: Get.width / 4,
                                child: Text(
                                  "Runes",
                                  style: GoogleFonts.sora(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Container(
                                width: Get.width / 3.0,
                                height: 50,
                                color: Color(0xffFFE9DD).withOpacity(0.1),
                                child: InputDecorator(
                                  baseStyle: TextStyle(
                                      fontSize: 2, color: Colors.black),
                                  decoration: InputDecoration(
                                    hintText: 'select',
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 0.0, horizontal: 10.0),
                                    focusColor: Colors.black,
                                    hoverColor: Colors.black,
                                    filled: true,
                                    fillColor: Colors.white,
                                    hintStyle: TextStyle(
                                      color: Colors.black,
                                      overflow: TextOverflow.ellipsis,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: 'Roboto',
                                      letterSpacing: 0.0,
                                    ),

                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.black, width: 1.0),
                                    ),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(5.0),
                                        ),
                                        borderSide: BorderSide(width: 1.0)),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(5.0),
                                      ),
                                      borderSide: BorderSide(
                                          color: Colors.black, width: 3.0),
                                    ),
                                    labelStyle: TextStyle(
                                        color: Color(0xff2B2B2B),
                                        fontSize: 15.0),
                                    // fillColor: Colors.white,
                                  ),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton(
                                      borderRadius: BorderRadius.circular(4),
                                      dropdownColor: Colors.white,
                                      icon: Icon(
                                        Icons.arrow_drop_down_rounded,
                                        size: 15.0,
                                        color: Colors.black,
                                      ),
                                      style: GoogleFonts.sora(
                                          fontSize: 10,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w400),
                                      value: _.selectedRunesValue.value.text != ''
                                          ? _.selectedRunesValue.value.text
                                          : _.runesList[0]['id']
                                              .toString(),
                                      isDense: true,
                                      isExpanded: true,
                                      items: _.runesList.map((list) {
                                        return DropdownMenuItem(
                                          child: list['name'] != ''
                                              ? Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      width: 20,
                                                      child: Image.asset(
                                                        list['iconPath'],
                                                        height: 25,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Flexible(
                                                      child: Text(
                                                        '${list['name']}',
                                                        style: GoogleFonts.sora(
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.w300,
                                                        ),
                                                        maxLines: 1,
                                                      ),
                                                    )
                                                  ],
                                                )
                                              : Text('notfound'),
                                          value: list['id'].toString(),
                                        );
                                      }).toList(),
                                      onChanged: (value) {
                                        setState(
                                          () {
                                            setState(
                                              () {
                                                _.selectedRunesValue.value.text =
                                                    value.toString();
                                                var c = _.runesList
                                                    .firstWhere((element) =>
                                                        element['id'] == value);

                                              },
                                            );
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),

                          //----------------------------Rarity drop down-----------------
                          Row(
                            children: [
                              SizedBox(
                                width: Get.width / 4,
                                child: Text(
                                  "Rarity",
                                  style: GoogleFonts.sora(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Container(
                                width: Get.width / 3.0,
                                height: 50,
                                color: Color(0xffFFE9DD).withOpacity(0.1),
                                child: InputDecorator(
                                  baseStyle: TextStyle(
                                      fontSize: 2, color: Colors.black),
                                  decoration: InputDecoration(
                                    hintText: 'select',
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 0.0, horizontal: 10.0),
                                    focusColor: Colors.black,
                                    hoverColor: Colors.black,
                                    filled: true,
                                    fillColor: Colors.white,
                                    hintStyle: TextStyle(
                                      color: Colors.black,
                                      overflow: TextOverflow.ellipsis,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: 'Roboto',
                                      letterSpacing: 0.0,
                                    ),

                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.black, width: 1.0),
                                    ),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(5.0),
                                        ),
                                        borderSide: BorderSide(width: 1.0)),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(5.0),
                                      ),
                                      borderSide: BorderSide(
                                          color: Colors.black, width: 3.0),
                                    ),
                                    labelStyle: TextStyle(
                                        color: Color(0xff2B2B2B),
                                        fontSize: 15.0),
                                    // fillColor: Colors.white,
                                  ),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton(
                                      borderRadius: BorderRadius.circular(4),
                                      dropdownColor: Colors.white,
                                      icon: Icon(
                                        Icons.arrow_drop_down_rounded,
                                        size: 15.0,
                                        color: Colors.black,
                                      ),
                                      style: GoogleFonts.sora(
                                          fontSize: 10,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w400),
                                      value: _.selectedRarityValue.value.text != ''
                                          ? _.selectedRarityValue.value.text
                                          : _.rarityList[0]['id']
                                          .toString(),
                                      isDense: true,
                                      isExpanded: true,
                                      items: _.rarityList.map((list) {
                                        return DropdownMenuItem(
                                          child: list['name'] != ''
                                              ? Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.start,
                                            children: [


                                              Flexible(
                                                child: Text(
                                                  '${list['name']}',
                                                  style: GoogleFonts.sora(
                                                    fontSize: 10,
                                                    fontWeight:
                                                    FontWeight.w300,
                                                  ),
                                                  maxLines: 1,
                                                ),
                                              )
                                            ],
                                          )
                                              : Text('notfound'),
                                          value: list['id'].toString(),
                                        );
                                      }).toList(),
                                      onChanged: (value) {

                                        setState(
                                              () {
                                            setState(
                                                  () {
                                                _.selectedRarityValue.value.text = value.toString();
                                                var c = _.rarityList
                                                    .firstWhere((element) =>
                                                element['id'] == value);

                                              },
                                            );
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 40,
                          ),


                        ],
                      ).marginOnly(left: 20, right: 20),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: Get.width,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.black,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Obx(
                        () => Row(
                          children: [
                            const Text(
                              "COST",
                              style: TextStyle(
                                color: Color(0xff858585),
                                fontSize: 12,
                              ),
                            ),
                            const Spacer(),
                             Text(
                                    "${_.runesValue()} SAP",
                                    style: GoogleFonts.sora(
                                      color: Colors.black,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                          ],
                        ).marginOnly(left: 15, right: 15),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        btn(
                          color: Colors.white,
                          title: "NEXT TIME",
                          onTap: () {
                            Get.back();
                          },
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        btn(
                          color: const Color(0xffffbb42),
                          title: "CONFIRM",
                          onTap: () async {
                            if(_.selectedRunesValue.value.text=="WING" && _.wingPurchase==false) {
                              setState((){
                                _.transactionLoader=true;
                              });
                              await _.purchaseRunes();
                              setState((){
                                _.transactionLoader=false;
                              });
                              Get.back();
                            }
                           else if(_.selectedRunesValue.value.text=="ENGINE" && _.enginePurchase==false) {
                              setState((){
                                _.transactionLoader=true;
                              });
                              await _.purchaseRunes();
                              setState((){
                                _.transactionLoader=false;
                              });
                              Get.back();
                            }
                            else if(_.selectedRunesValue.value.text=="RADIO" && _.radioPurchase==false) {
                              setState((){
                                _.transactionLoader=true;
                              });
                              await _.purchaseRunes();
                              setState((){
                                _.transactionLoader=false;
                              });
                              Get.back();
                            }
                            else if(_.selectedRunesValue.value.text=="BLACK BOX" && _.blackBoxPurchase==false) {
                              setState((){
                                _.transactionLoader=true;
                              });
                              await _.purchaseRunes();
                              setState((){
                                _.transactionLoader=false;
                              });
                              Get.back();
                            }
                            else{
                              ShowToastMessage("Already purchased this rune");
                            }


                          },
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                  ],
                ).marginOnly(left: 10, right: 10),
              );
            },
          )),
    );
  }

  Widget btn(
      {Color? color,
      String? title,
      void Function()? onTap,
      double? width,
      double? firstwidth,
      double? secondwidth}) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: 60,
        width: width ?? Get.width / 3.2,
        child: Stack(
          children: [
            Container(
              height: 50,
              width: firstwidth ?? Get.width / 3.4,
              decoration: BoxDecoration(
                  color: const Color(0xff62C8A9),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.black)),
              child: Center(
                child: Text(
                  title!,
                  style: GoogleFonts.sora(
                    fontSize: 12,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ).marginOnly(top: 5, left: 5),
            Container(
              height: 50,
              width: secondwidth ?? Get.width / 3.4,
              decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.black)),
              child: Center(
                child: Text(
                  title,
                  style: GoogleFonts.sora(
                    fontSize: 12,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void levelDialogBox(LevelController _, String cardType, int level) {
    Get.dialog(
      AlertDialog(
        elevation: 0.0,
        scrollable: true,
        contentPadding: const EdgeInsets.all(0.0),
        backgroundColor: Colors.transparent,
        content: SizedBox(
          // height: Get.height / 1.6,
          width: Get.width,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  height: 30,
                  width: Get.width / 2.9,
                  decoration: BoxDecoration(
                    color: const Color(0xffddfff4),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                    border: Border.all(
                      color: Colors.black,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      cardType.toUpperCase(),
                      style: GoogleFonts.sora(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  // height: Get.height / 1.68,
                  width: Get.width,
                  decoration: BoxDecoration(
                    color: const Color(0xffDDFFF4),
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      color: Colors.black,
                    ),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Spacer(),
                          Text(
                            "LEVEL UP",
                            style: GoogleFonts.sora(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ).marginOnly(left: 20),
                          const Spacer(),
                          GestureDetector(
                            onTap: () {
                              Get.back();
                            },
                            child: Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: const Color(0xff62C8A9),
                                border: Border.all(color: Colors.black),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color.fromRGBO(27, 60, 71, 0.25),
                                    blurRadius: 4,
                                    spreadRadius: 2,
                                    offset: Offset(0, 3), // Shadow position
                                  ),
                                ],
                              ),
                              child: const Icon(
                                Icons.close,
                                color: Colors.white,
                                size: 18,
                              ),
                            ).marginOnly(right: 10, top: 10),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        width: Get.width / 2.0,
                        height: 147,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                              image: NetworkImage(_.imagePath),
                              fit: BoxFit.cover),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Lv $level",
                        style: GoogleFonts.sora(
                          fontWeight: FontWeight.w600,
                          fontSize: 26,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: RichText(
                          text: TextSpan(
                            text: 'Level up to ',
                            style: GoogleFonts.sora(
                              fontWeight: FontWeight.w600,
                              fontSize: 10,
                              color: const Color(0xff858585),
                            ),
                            children: [
                              TextSpan(
                                text: 'Lv ${level + 1}',
                                style: GoogleFonts.sora(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 10,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ).marginOnly(left: 10),
                      const SizedBox(
                        height: 10,
                      ),
                      getContainer(
                          heading: 'Cost',
                          value: '${_.levelInfo['totalSap']} SAP'),
                      const SizedBox(
                        height: 10,
                      ),
                      getContainer(
                          heading: 'Time',
                          value: '${_.levelInfo['minutes']} mins'),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          btn(
                            color: Colors.white,
                            title: "CANCEL",
                            onTap: () {
                              Get.back();
                            },
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          btn(
                            color: const Color(0xffffbb42),
                            title: "CONFIRM",
                            onTap: () async {
                              await _.updateLevel(cardType, levelno: level);
                            },
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ).marginOnly(left: 20, right: 20),
                ),
              ).marginOnly(top: 25)
            ],
          ),
        ),
      ),
    );
  }

  void levelBoosterDialogBox(
      LevelController _, String cardType, int level, int time) {
    _.runTime();
    Get.dialog(
      AlertDialog(
          elevation: 0.0,
          scrollable: true,
          contentPadding: const EdgeInsets.all(0.0),
          backgroundColor: Colors.transparent,
          content: StatefulBuilder(
            builder: (context, setState) {
              return SizedBox(
                // height: Get.height / 1.8,
                width: Get.width,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        height: 30,
                        width: Get.width / 2.9,
                        decoration: BoxDecoration(
                          color: const Color(0xffddfff4),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                          border: Border.all(
                            color: Colors.black,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            "COMMON",
                            style: GoogleFonts.sora(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: Get.height / 1.88,
                        width: Get.width,
                        decoration: BoxDecoration(
                          color: const Color(0xffDDFFF4),
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            color: Colors.black,
                          ),
                        ),
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Spacer(),
                                Text(
                                  "LEVEL UP",
                                  style: GoogleFonts.sora(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 13,
                                  ),
                                ).marginOnly(left: 20),
                                const Spacer(),
                                GestureDetector(
                                  onTap: () {
                                    Get.back();
                                  },
                                  child: Container(
                                    width: 30,
                                    height: 30,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: const Color(0xff62C8A9),
                                      border: Border.all(color: Colors.black),
                                      boxShadow: const [
                                        BoxShadow(
                                          color:
                                              Color.fromRGBO(27, 60, 71, 0.25),
                                          blurRadius: 4,
                                          spreadRadius: 2,
                                          offset:
                                              Offset(0, 3), // Shadow position
                                        ),
                                      ],
                                    ),
                                    child: const Icon(
                                      Icons.close,
                                      color: Colors.white,
                                      size: 18,
                                    ),
                                  ).marginOnly(right: 10, top: 10),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Container(
                              width: Get.width / 2.0,
                              height: 147,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                    image: NetworkImage(_.imagePath),
                                    fit: BoxFit.cover),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Lv $level",
                              style: GoogleFonts.sora(
                                fontWeight: FontWeight.w600,
                                fontSize: 26,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: RichText(
                                text: TextSpan(
                                  text: 'Level up to ',
                                  style: GoogleFonts.sora(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 10,
                                    color: const Color(0xff858585),
                                  ),
                                  children: [
                                    TextSpan(
                                      text: 'Lv ${level + 1}',
                                      style: GoogleFonts.sora(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 10,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ).marginOnly(left: 10),
                            const SizedBox(
                              height: 10,
                            ),
                            _.isBoost
                                ? getContainer(
                                    heading: 'Cost',
                                    value: '${_.levelInfo['totalSap']} SAP')
                                : Container(
                                    height: 52,
                                    width: Get.width,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(color: Colors.black),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Remining Time",
                                          style: GoogleFonts.sora(
                                            fontWeight: FontWeight.w400,
                                            color: const Color(0xff858585),
                                            fontSize: 12,
                                          ),
                                        ),
                                        const Spacer(),
                                        SlideCountdown(
                                          duration:
                                              Duration(seconds: _.timer.value),
                                          decoration: BoxDecoration(
                                            color: Colors.transparent,
                                          ),
                                          separatorStyle: GoogleFonts.sora(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          textStyle: GoogleFonts.sora(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          // separatorType: SeparatorType.title,
                                          slideDirection: SlideDirection.up,
                                          // showZeroValue: true,
                                        ),
                                        // Obx(
                                        //   () => Text(
                                        //     "${_.timer.value ~/ 3600} : ${((_.timer.value % 3600) ~/ 60)} : ${_.timer.value % 60}",
                                        // style: GoogleFonts.sora(
                                        //   fontSize: 18,
                                        //   fontWeight: FontWeight.w600,
                                        // ),
                                        //   ),
                                        // ),
                                      ],
                                    ).marginOnly(left: 10, right: 10),
                                  ).marginOnly(left: 10, right: 10),
                            const SizedBox(
                              height: 10,
                            ),
                            _.isBoost
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      btn(
                                        color: Colors.white,
                                        title: "CANCEL",
                                        onTap: () {
                                          Get.back();
                                        },
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      btn(
                                        color: const Color(0xffffbb42),
                                        title: "CONFIRM",
                                        onTap: () async {
                                          await _.updateLevel(cardType);
                                        },
                                      )
                                    ],
                                  )
                                : btn(
                                    color: const Color(0xffffbb42),
                                    title: "BOOST",
                                    width: Get.width,
                                    firstwidth: Get.width - 2,
                                    secondwidth: Get.width - 2,
                                    onTap: () async {
                                      setState(() {
                                        _.isBoost = true;
                                      });
                                    },
                                  ).marginOnly(left: 15, right: 15)
                          ],
                        ),
                      ),
                    ).marginOnly(top: 25)
                  ],
                ),
              );
            },
          )),
    );
  }

  Widget getContainer({String? heading, String? value}) {
    return Container(
      height: 52,
      width: Get.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: Colors.black),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            heading!,
            style: GoogleFonts.sora(
              fontWeight: FontWeight.w400,
              color: const Color(0xff858585),
              fontSize: 9,
            ),
          ),
          const Spacer(),
          Text(
            value!,
            style: GoogleFonts.sora(
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
          ),
        ],
      ).marginOnly(left: 10, right: 10),
    ).marginOnly(left: 10, right: 10);
  }
}
