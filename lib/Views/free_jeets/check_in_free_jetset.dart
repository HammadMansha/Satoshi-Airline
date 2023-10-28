import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:satoshi/routes/app_routes.dart';
import 'package:satoshi/shimmer/checkin_effect.dart';
import 'package:satoshi/widget/appbar/commonAppbar.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../../../../Controllers/landing/checkin_controller.dart';
import '../../../../Utils/commonSnackbar.dart';
import '../../../../Utils/utils.dart';
import '../../../../widget/bottom_navbar.dart';
import '../../../../widget/cached_networkImage.dart';
import '../../../../widget/common_button.dart';
import '../../Controllers/free_jetset_controllers/check_in_freejet_controller.dart';
import '../Holders/HolderCommon/basictab_screen.dart';
import '../qr/qr_screen.dart';

// import '../../NonNftHolder/fly_to_earn.dart';

class CheckInFreeJet extends StatelessWidget {
  const CheckInFreeJet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mqData = MediaQuery.of(context);
    final mqDataNew = mqData.copyWith(
        textScaleFactor:
        mqData.textScaleFactor > 1.0 ? 1.0 : mqData.textScaleFactor);

    return GetBuilder<CheckInFreeJetController>(
      init: CheckInFreeJetController(),
      builder: (_) {
        return MediaQuery(
          data: mqDataNew,
          child: Scaffold(
            backgroundColor: const Color(0xffFFFAEC),
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
                  totalsap:
                  _.landingPageController.balanceData['totalSap'] == null
                      ? ''
                      : _.landingPageController.balanceData['totalSap']
                      .toString(),
                  bnb: _.landingPageController.balanceData['bnbBalance'] == null
                      ? 0.0
                      : double.parse(_
                      .landingPageController.balanceData['bnbBalance']
                      .toString()),
                  travel:
                  _.landingPageController.balanceData['distance'] == null
                      ? '0'
                      : _.landingPageController.balanceData['distance']
                      .toString(),
                ),
              ),
            ),
            bottomNavigationBar: const BottomNavbarWidget(),
            body: _.isLoading ? CheckinEffect() : checkIn(_, context),
          ),
        );
      },
    );
  }

  List<Widget> bodyPages(CheckInFreeJetController _, BuildContext context) {
    return [testFlightTab(_, context), const BasicTabScreen(), QrScreen()];
  }

  Widget testFlightTab(CheckInFreeJetController _, BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: AppColors.black),
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        width: 15,
                      ),
                      Column(
                        children: [
                          // const SizedBox(
                          //   height: 20,
                          // ),
                          Container(
                            decoration: BoxDecoration(
                                color: const Color(0xffFFFF00),
                                border: Border.all(
                                    color: AppColors.black, width: 1.0),
                                borderRadius: BorderRadius.circular(5)),
                            height: 31,
                            width: 31,
                            child: IconButton(
                              icon: Image.asset(AppConstants.addIcon),
                              onPressed: () {},
                            ),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
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
                              onPressed: () {},
                            ),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: const Color(0xffB1F9E2),
                              border: Border.all(
                                  color: AppColors.black, width: 1.0),
                              borderRadius: BorderRadius.circular(
                                5,
                              ),
                            ),
                            height: 31,
                            width: 31,
                            child: IconButton(
                              icon: Image.asset(AppConstants.addIcon),
                              onPressed: () {},
                            ),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
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
                              onPressed: () {},
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.only(left: 10),
                                child: const Icon(Icons.arrow_back_ios),
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
                                          borderRadius: const BorderRadius.only(
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
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15,
                                            ),
                                          ).marginOnly(top: 5),
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                              color: Colors.black,
                                            ),
                                            borderRadius:
                                            BorderRadius.circular(5.0)),
                                        child: CircularCachedNetworkImage(
                                          height: Get.height / 3.9,
                                          width: Get.width / 1.9,
                                          imageURL: _.levelController.imagePath,
                                          borderColor: Colors.black,
                                          radius: 5.0,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.only(left: 10),
                                child: const Icon(
                                  Icons.arrow_forward_ios,
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
                                    "#${_.levelController.id}",
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
                              Container(
                                height: 20,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.black,
                                    ),
                                    borderRadius: BorderRadius.circular(7)),
                                child: Center(
                                  child: Text(
                                    "Lv${_.nftData['cardLevel']}",
                                    style: GoogleFonts.sora(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12),
                                  ),
                                ).marginOnly(left: 15, right: 15),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ).marginOnly(left: 15, right: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(
                            top: 10, right: 10, bottom: 10),
                        child: Row(
                          children: [
                            Container(
                                height: 17,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 2, color: AppColors.redLight),
                                    borderRadius: BorderRadius.circular(2)),
                                child: Image.asset(
                                  AppConstants.addIcon,
                                  color: AppColors.redLight,
                                  height: 15,
                                )
                              // Icon(Icons.add, color: Color(0xffCE1E2E), size: 17,),
                            ),
                            const SizedBox(
                              width: 10,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 1),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            height: 34,
                            width: 81,
                            decoration: BoxDecoration(
                              border: Border.all(width: 1, color: Colors.black),
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(9),
                                topRight: Radius.circular(10),
                              ),
                            ),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    AppConstants.fuelIcon,
                                    height: 19,
                                    width: 16,
                                  ),
                                  Text(
                                    ' ${double.parse(_.nftData['attribuets']['fuel'].toString()).toStringAsFixed(2)}',
                                    style: GoogleFonts.sora(
                                      color: AppColors.black,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ).marginOnly(left: 3, top: 2)
                                ],
                              ),
                            ).marginOnly(left: 15)
                          // Icon(Icons.add, color: Color(0xffCE1E2E), size: 17,),
                        ),
                        Container(
                            height: 34,
                            width: 81,
                            decoration: BoxDecoration(
                              border: Border.all(width: 1, color: Colors.black),
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                              ),
                            ),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    AppConstants.mineIcon,
                                    height: 17.6,
                                  ),
                                  Text(
                                    ' ${double.parse((_.nftData['attribuets']['mine']).toString()).toStringAsFixed(2)}',
                                    style: GoogleFonts.sora(
                                      color: AppColors.black,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ).marginOnly(left: 3, top: 2)
                                ],
                              ),
                            ).marginOnly(left: 15)
                          // Icon(Icons.add, color: Color(0xffCE1E2E), size: 17,),
                        ),
                        Container(
                            height: 34,
                            width: 81,
                            decoration: BoxDecoration(
                              border: Border.all(width: 1, color: Colors.black),
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                              ),
                            ),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    AppConstants.durabilityIcon,
                                    height: 19,
                                  ),
                                  Text(
                                    '${double.parse(_.nftData['attribuets']['durability'].toString()).toStringAsFixed(2)}',
                                    style: GoogleFonts.sora(
                                      color: AppColors.black,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ).marginOnly(left: 3, top: 2)
                                ],
                              ),
                            ).marginOnly(left: 15)
                          // Icon(Icons.add, color: Color(0xffCE1E2E), size: 17,),
                        ),
                        Container(
                            height: 34,
                            width: 81,
                            decoration: BoxDecoration(
                              border: Border.all(width: 1, color: Colors.black),
                              borderRadius: const BorderRadius.only(
                                bottomRight: Radius.circular(9),
                                // topRight: Radius.circular(10),
                                topLeft: Radius.circular(10),
                              ),
                            ),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    AppConstants.luckyIcon,
                                    height: 20.26,
                                  ),
                                  Text(
                                    ' ${double.parse(_.nftData['attribuets']['luck'].toString()).toStringAsFixed(2)}',
                                    // ' ${_.nftData['attribuets']['luck']}',

                                    style: GoogleFonts.sora(
                                      color: AppColors.black,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ).marginOnly(left: 3, top: 2),
                                ],
                              ),
                            ).marginOnly(left: 15)
                          // Icon(Icons.add, color: Color(0xffCE1E2E), size: 17,),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ).marginOnly(left: 10, right: 10),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: Get.width / 5.5,
                padding: const EdgeInsets.only(top: 20),
                child: Column(
                  children: [
                    Text(
                      AppConstants.from,
                      style: attributesValueStyle,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      _.fromCountry,
                      // maxLines: 1,
                      // overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.sora(
                        textStyle: TextStyle(
                          color: AppColors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.only(bottom: 10),
                child: Image.asset(
                  AppConstants.flyFromTo,
                  height: 55,
                ),
              ),
              const Spacer(),
              Container(
                width: Get.width / 5.0,
                padding: const EdgeInsets.only(top: 20),
                child: Column(
                  children: [
                    Text(
                      AppConstants.to,
                      style: attributesValueStyle,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      _.toCountry,
                      // maxLines: 2,
                      // overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.sora(
                        textStyle: TextStyle(
                          color: AppColors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ],
          ).marginOnly(left: 20, right: 20),
          Container(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: Get.height * 0.042,
                  width: Get.width * 0.46,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    border: Border.all(
                      color: AppColors.black, //color of border
                      width: 1, //width of border
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Text(
                          AppConstants.time,
                          style: GoogleFonts.sora(
                              textStyle: TextStyle(
                                color: AppColors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              )),
                        ),
                      ).marginOnly(right: 10),
                      Flexible(
                        child: Text(
                          '${_.getTimeStringFromDouble(_.time())}',
                          style: GoogleFonts.sora(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: AppColors.black,
                          ),
                        ).marginOnly(right: 5),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: Get.height * 0.042,
                  width: Get.width * 0.46,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    border: Border.all(
                      color: AppColors.black, //color of border
                      width: 1, //width of border
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Text(
                          AppConstants.distance,
                          style: GoogleFonts.sora(
                              textStyle: TextStyle(
                                color: AppColors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              )),
                        ),
                      ).marginOnly(right: 10),
                      Flexible(
                        child: Text(
                          '${_.myFormat.format(int.parse(_.totalDistance.round().toString()))}.00 Km',
                          // '${_.totalDistance.round().toStringAsFixed(2)}KM',
                          maxLines: 1,
                          style: GoogleFonts.sora(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: AppColors.black,
                          ),
                        ).marginOnly(right: 5),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                AppConstants.sapIcon,
                height: 43,
              ),
              Text(
                ' ${_.nftData['sapReward'].toStringAsFixed(2)} SAP',
                style: sAPStyle,
              )
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          btnStack(AppConstants.checkIn, true, _).marginOnly(bottom: 20),
        ],
      ).marginOnly(top: 20),
    );
  }

  Widget checkIn(CheckInFreeJetController _, BuildContext context) {
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

  Widget tabbarCustom(CheckInFreeJetController _, BuildContext context) {
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
              // _.landingPageController.currentIndex = 1;
              // _.landingPageController.update();
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

  Widget btnStack(btnText, boolean, CheckInFreeJetController _) {
    return btn(
      onTap: () {
        _.destinationController.isStopped = true;
        _.destinationController.update();
        _.storage.write("session_time", _.time());
        _.storage.write("sapReward", _.nftData['sapReward'].toStringAsFixed(2));
        _.storage.write("toCountry", _.toCountry);
        _.storage.write("fromCountry", _.fromCountry);
        Get.toNamed(Routes.flytoearnRoutes);
        // _.playSoundEffect();
        // Get.to(() => const FlyToEarn());
      },
      color: Color(0xffffbb42),
      firstcolor: Colors.black,
      title: "CHECK IN",
      width: Get.width / 3,
      firstwidth: Get.width / 3.1,
      secondwidth: Get.width / 3.1,
    );
  }

  Widget btn({
    Color? color,
    Color? firstcolor,
    String? title,
    void Function()? onTap,
    double? width,
    double? firstwidth,
    double? secondwidth,
  }) {
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
                  color: firstcolor ?? const Color(0xff62C8A9),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.black)),
              child: Center(
                child: Text(
                  title!,
                  style: GoogleFonts.sora(
                    fontSize: 20,
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
                    fontSize: 20,
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
}
