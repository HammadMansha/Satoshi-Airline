import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:satoshi/Utils/commonSnackbar.dart';
import 'package:satoshi/routes/app_routes.dart';
import 'package:satoshi/shimmer/level_effect.dart';
import 'package:satoshi/widget/appbar/commonAppbar.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../../Controllers/totalminting_controller.dart';
import '../../../../Utils/app_colors.dart';
import '../../../../Utils/app_constants.dart';
import '../../../../Utils/app_text_styles.dart';
import '../../../../widget/bottom_navbar.dart';
import '../../../../widget/cached_networkImage.dart';
import '../../../../widget/common_button.dart';
import '../../../qr/qr_screen.dart';
import '../../HolderCommon/basictab_screen.dart';

class TotalMintingScreen extends StatelessWidget {
  const TotalMintingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mqData = MediaQuery.of(context);
    final mqDataNew = mqData.copyWith(
        textScaleFactor:
            mqData.textScaleFactor > 1.0 ? 1.0 : mqData.textScaleFactor);
    return GetBuilder<TotalMintingController>(
      init: TotalMintingController(),
      builder: (_) {
        return WillPopScope(
          onWillPop: () async => false,
          child: MediaQuery(
            data: mqDataNew,
            child: Scaffold(
              resizeToAvoidBottomInset: false,
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
              body: _.isLoading ? LevelEffect() : startMinting(_, context),
              bottomNavigationBar: const BottomNavbarWidget(),
            ),
          ),
        );
      },
    );
  }

  Widget startMinting(TotalMintingController _, BuildContext context) {
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

  List<Widget> bodyPages(TotalMintingController _, BuildContext context) {
    return [testFlightTab(_, context), const BasicTabScreen(), QrScreen()];
  }

  Widget testFlightTab(TotalMintingController _, BuildContext context) {
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
                        height: 35,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // const SizedBox(
                          //   width: 15,
                          // ),
                          Column(
                            children: [
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
                                  )).marginOnly(left: 15),
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
                              ).marginOnly(left: 15),
                              const SizedBox(
                                height: 25,
                              ),
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
                                  onPressed: () {},
                                ),
                              ).marginOnly(left: 15),
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
                              ).marginOnly(left: 15),
                            ],
                          ),
                          const Spacer(),
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
                                    width: Get.width / 1.9,
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
                                              width: Get.width / 2.0,
                                              imageURL:
                                                  _.levelController.imagePath,
                                              borderColor: Colors.black,
                                              radius: 5.0,
                                            ),
                                          ),
                                          // Container(
                                          //   height: Get.height / 3.9,
                                          //   width: Get.width / 1.9,
                                          //   decoration: BoxDecoration(
                                          //     border: Border.all(
                                          //       color: Colors.black,
                                          //     ),
                                          //     borderRadius:
                                          //           BorderRadius.circular(5),
                                          //     image: DecorationImage(
                                          //       image: NetworkImage(
                                          //         _.levelController.imagePath,
                                          //       ),
                                          //       fit: BoxFit.cover,
                                          //     ),
                                          //   ),
                                          // ),
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
                                      borderRadius: BorderRadius.circular(7),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "#${_.levelController.id.toString()}",
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
                                    onTap: () {
                                      // buyLevel(_);
                                    },
                                    child: Container(
                                      height: 20,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.black,
                                        ),
                                        borderRadius: BorderRadius.circular(7),
                                      ),
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
                          buyAttribute(
                            _,
                          );
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
                                      ).marginOnly(left: 15),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 24,
                            child: Image.asset(
                              AppConstants.fuelIcon,
                              height: 24,
                            ).marginOnly(top: 10),
                          ),
                          Container(
                              padding: const EdgeInsets.only(top: 5, left: 5),
                              child: Text(
                                'FUEL',
                                style: attributesTextStyle,
                              )).marginOnly(top: 10),
                          const Spacer(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Container(
                                padding: EdgeInsets.zero,
                                margin: EdgeInsets.zero,
                                // padding: EdgeInsets.only(top: 5,left: 100),
                                child: Text(
                                  '${double.parse((double.parse((_.nftData['attributes']['fuel']['value']).toString()) - double.parse((_.usernftData['attribuets']['fuel']).toString())).toString()).toStringAsFixed(2)}/${double.parse((_.nftData['attributes']['fuel']['maxValue']).toString()).toStringAsFixed(2)}',
                                  style: attributesValueStyle,
                                ),
                              ),
                              SizedBox(
                                height: 23.0,
                                width: Get.width / 1.68,
                                child: Stack(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.black),
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                        child: LinearPercentIndicator(
                                            lineHeight: 23.0,
                                            width: Get.width / 1.7,
                                            // barRadius: const Radius.circular(5.0),
                                            padding: const EdgeInsets.all(0.0),
                                            percent: _.calValue(_.usernftData['attribuets']['fuel'], _.nftData['attributes']['fuel']['value']) > 1.0 ||
                                                    _.calValue(
                                                            _.usernftData['attribuets']
                                                                ['fuel'],
                                                            _.nftData['attributes']
                                                                    ['fuel']
                                                                ['value']) <
                                                        0.0
                                                ? 1.0
                                                : _.calValue(
                                                    _.usernftData['attribuets']
                                                        ['fuel'],
                                                    _.nftData['attributes']
                                                        ['fuel']['value'],
                                                  ),
                                            animation: true,
                                            isRTL: true,
                                            center: _.calValue(_.usernftData['attribuets']['fuel'], _.nftData['attributes']['fuel']['value']) > 1.0 || _.calValue(_.usernftData['attribuets']['fuel'], _.nftData['attributes']['fuel']['value']) < 0.0
                                                ? Text(double.parse((double.parse((_.nftData['attributes']['fuel']['value']).toString()) - double.parse((_.usernftData['attribuets']['fuel']).toString())).toString())
                                                    .toStringAsFixed(2))
                                                : const SizedBox(),
                                            backgroundColor: Colors.transparent,
                                            fillColor: const Color(0xff62c8a9),
                                            progressColor: _.calValue(_.usernftData['attribuets']['fuel'], _.nftData['attributes']['fuel']['value']) > 1.0 ||
                                                    _.calValue(_.usernftData['attribuets']['fuel'], _.nftData['attributes']['fuel']['value']) < 0.0
                                                ? const Color(0xffffc000)
                                                : const Color(0xff0287e1)),
                                      ),
                                    ),
                                    _.calValue(
                                                    _.usernftData['attribuets']
                                                        ['fuel'],
                                                    _.nftData['attributes']
                                                        ['fuel']['value']) >
                                                1.0 ||
                                            _.calValue(
                                                    _.usernftData['attribuets']
                                                        ['fuel'],
                                                    _.nftData['attributes']
                                                        ['fuel']['value']) <
                                                0.0
                                        ? Icon(
                                            Icons.battery_1_bar_outlined,
                                            size: 21,
                                            color: Colors.red,
                                          ).marginOnly(left: 10)
                                        : const SizedBox(),
                                    _.calValue(
                                                    _.usernftData['attribuets']
                                                        ['fuel'],
                                                    _.nftData['attributes']
                                                        ['fuel']['value']) >
                                                1.0 ||
                                            _.calValue(
                                                    _.usernftData['attribuets']
                                                        ['fuel'],
                                                    _.nftData['attributes']
                                                        ['fuel']['value']) <
                                                0.0
                                        ? const SizedBox()
                                        : Row(
                                            children: [
                                              Text(
                                                double.parse((double.parse(
                                                                (_.nftData['attributes']
                                                                            [
                                                                            'fuel']
                                                                        [
                                                                        'value'])
                                                                    .toString()) -
                                                            double.parse(
                                                                (_.usernftData[
                                                                            'attribuets']
                                                                        [
                                                                        'fuel'])
                                                                    .toString()))
                                                        .toString())
                                                    .toStringAsFixed(2),
                                              ),
                                              const Spacer(),
                                              Text(
                                                double.parse((_.usernftData[
                                                                'attribuets']
                                                            ['fuel'])
                                                        .toString())
                                                    .toStringAsFixed(2),
                                              ),
                                              const Icon(
                                                Icons.flight_sharp,
                                                size: 12,
                                              ).marginOnly(left: 5.0)
                                            ],
                                          ).marginOnly(
                                            top: 5, left: 5, right: 5),
                                  ],
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
                            ).marginOnly(top: 10),
                          ),
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
                              Container(
                                padding: EdgeInsets.zero,
                                margin: EdgeInsets.zero,
                                // padding: EdgeInsets.only(top: 5,left: 100),
                                child: Text(
                                  '${double.parse((double.parse((_.nftData['attributes']['mine']['value']).toString()) - double.parse((_.usernftData['attribuets']['mine']).toString())).toString()).toStringAsFixed(2)}/${double.parse((_.nftData['attributes']['mine']['maxValue']).toString()).toStringAsFixed(2)}',
                                  style: attributesValueStyle,
                                ),
                              ),
                              SizedBox(
                                height: 23.0,
                                width: Get.width / 1.68,
                                child: Stack(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.black),
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                        child: LinearPercentIndicator(
                                            lineHeight: 23.0,
                                            width: Get.width / 1.7,
                                            // barRadius: const Radius.circular(5.0),
                                            padding: const EdgeInsets.all(0.0),
                                            percent: _.calValue(_.usernftData['attribuets']['mine'], _.nftData['attributes']['mine']['value']) > 1.0 ||
                                                    _.calValue(
                                                            _.usernftData['attribuets']
                                                                ['mine'],
                                                            _.nftData['attributes']
                                                                    ['mine']
                                                                ['value']) <
                                                        0.0
                                                ? 1.0
                                                : _.calValue(
                                                    _.usernftData['attribuets']
                                                        ['mine'],
                                                    _.nftData['attributes']
                                                        ['mine']['value'],
                                                  ),
                                            animation: true,
                                            isRTL: true,
                                            center: _.calValue(_.usernftData['attribuets']['mine'], _.nftData['attributes']['mine']['value']) > 1.0 || _.calValue(_.usernftData['attribuets']['mine'], _.nftData['attributes']['mine']['value']) < 0.0
                                                ? Text(double.parse((double.parse((_.nftData['attributes']['mine']['value']).toString()) - double.parse((_.usernftData['attribuets']['mine']).toString())).toString())
                                                    .toStringAsFixed(2))
                                                : const SizedBox(),
                                            backgroundColor: Colors.transparent,
                                            fillColor: const Color(0xff62c8a9),
                                            progressColor: _.calValue(_.usernftData['attribuets']['mine'], _.nftData['attributes']['mine']['value']) > 1.0 ||
                                                    _.calValue(_.usernftData['attribuets']['mine'], _.nftData['attributes']['mine']['value']) < 0.0
                                                ? const Color(0xffffc000)
                                                : const Color(0xff0287e1)),
                                      ),
                                    ),
                                    _.calValue(
                                                    _.usernftData['attribuets']
                                                        ['mine'],
                                                    _.nftData['attributes']
                                                        ['mine']['value']) >
                                                1.0 ||
                                            _.calValue(
                                                    _.usernftData['attribuets']
                                                        ['mine'],
                                                    _.nftData['attributes']
                                                        ['mine']['value']) <
                                                0.0
                                        ? const Icon(
                                            Icons.battery_1_bar_outlined,
                                            size: 21,
                                            color: Colors.red,
                                          ).marginOnly(left: 10)
                                        : const SizedBox(),
                                    _.calValue(
                                                    _.usernftData['attribuets']
                                                        ['mine'],
                                                    _.nftData['attributes']
                                                        ['mine']['value']) >
                                                1.0 ||
                                            _.calValue(
                                                    _.usernftData['attribuets']
                                                        ['mine'],
                                                    _.nftData['attributes']
                                                        ['mine']['value']) <
                                                0.0
                                        ? const SizedBox()
                                        : Row(
                                            children: [
                                              Text(
                                                double.parse((double.parse(
                                                                (_.nftData['attributes']
                                                                            [
                                                                            'mine']
                                                                        [
                                                                        'value'])
                                                                    .toString()) -
                                                            double.parse(
                                                                (_.usernftData[
                                                                            'attribuets']
                                                                        [
                                                                        'mine'])
                                                                    .toString()))
                                                        .toString())
                                                    .toStringAsFixed(2),
                                              ),
                                              const Spacer(),
                                              Text(
                                                double.parse((_.usernftData[
                                                                'attribuets']
                                                            ['mine'])
                                                        .toString())
                                                    .toStringAsFixed(2),
                                              ),
                                              const Icon(
                                                Icons.flight_sharp,
                                                size: 12,
                                              ).marginOnly(left: 5.0)
                                            ],
                                          ).marginOnly(
                                            top: 5,
                                            left: 5,
                                            right: 5,
                                          ),
                                  ],
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
                            ).marginOnly(top: 11),
                          ),
                          Container(
                            padding: const EdgeInsets.only(top: 5, left: 4),
                            child: Text(
                              ' Durability'.toUpperCase(),
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
                                  '${double.parse((double.parse((_.nftData['attributes']['durability']['value']).toString()) - double.parse((_.usernftData['attribuets']['durability']).toString())).toString()).toStringAsFixed(2)}/${double.parse((_.nftData['attributes']['durability']['maxValue']).toString()).toStringAsFixed(2)}',
                                  style: attributesValueStyle,
                                ),
                              ),
                              SizedBox(
                                height: 23.0,
                                width: Get.width / 1.68,
                                child: Stack(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.black),
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                        child: LinearPercentIndicator(
                                            lineHeight: 23.0,
                                            width: Get.width / 1.7,
                                            // barRadius: const Radius.circular(5.0),
                                            padding: const EdgeInsets.all(0.0),
                                            percent: _.calValue(_.usernftData['attribuets']['durability'], _.nftData['attributes']['durability']['value']) > 1.0 ||
                                                    _.calValue(
                                                            _.usernftData['attribuets']
                                                                ['durability'],
                                                            _.nftData['attributes']
                                                                    ['durability']
                                                                ['value']) <
                                                        0.0
                                                ? 1.0
                                                : _.calValue(
                                                    _.usernftData['attribuets']
                                                        ['durability'],
                                                    _.nftData['attributes']
                                                        ['durability']['value'],
                                                  ),
                                            animation: true,
                                            isRTL: true,
                                            center: _.calValue(_.usernftData['attribuets']['durability'], _.nftData['attributes']['durability']['value']) > 1.0 || _.calValue(_.usernftData['attribuets']['durability'], _.nftData['attributes']['durability']['value']) < 0.0
                                                ? Text(double.parse((double.parse((_.nftData['attributes']['durability']['value']).toString()) - double.parse((_.usernftData['attribuets']['durability']).toString())).toString())
                                                    .toStringAsFixed(2))
                                                : const SizedBox(),
                                            backgroundColor: Colors.transparent,
                                            fillColor: const Color(0xff62c8a9),
                                            progressColor:
                                                _.calValue(_.usernftData['attribuets']['durability'], _.nftData['attributes']['durability']['value']) > 1.0 ||
                                                        _.calValue(_.usernftData['attribuets']['durability'], _.nftData['attributes']['durability']['value']) < 0.0
                                                    ? const Color(0xffffc000)
                                                    : const Color(0xff0287e1)),
                                      ),
                                    ),
                                    _.calValue(
                                                    _.usernftData['attribuets']
                                                        ['durability'],
                                                    _.nftData['attributes']
                                                            ['durability']
                                                        ['value']) >
                                                1.0 ||
                                            _.calValue(
                                                    _.usernftData['attribuets']
                                                        ['durability'],
                                                    _.nftData['attributes']
                                                            ['durability']
                                                        ['value']) <
                                                0.0
                                        ? const Icon(
                                            Icons.battery_1_bar_outlined,
                                            size: 21,
                                            color: Colors.red,
                                          ).marginOnly(left: 10)
                                        : const SizedBox(),
                                    _.calValue(
                                                    _.usernftData['attribuets']
                                                        ['durability'],
                                                    _.nftData['attributes']
                                                            ['durability']
                                                        ['value']) >
                                                1.0 ||
                                            _.calValue(
                                                    _.usernftData['attribuets']
                                                        ['durability'],
                                                    _.nftData['attributes']
                                                            ['durability']
                                                        ['value']) <
                                                0.0
                                        ? const SizedBox()
                                        : Row(
                                            children: [
                                              Text(
                                                double.parse((double.parse((_.nftData[
                                                                            'attributes']
                                                                        [
                                                                        'durability']
                                                                    ['value'])
                                                                .toString()) -
                                                            double.parse((_.usernftData[
                                                                        'attribuets']
                                                                    [
                                                                    'durability'])
                                                                .toString()))
                                                        .toString())
                                                    .toStringAsFixed(2),
                                              ),
                                              const Spacer(),
                                              Text(
                                                double.parse((_.usernftData[
                                                                'attribuets']
                                                            ['durability'])
                                                        .toString())
                                                    .toStringAsFixed(2),
                                              ),
                                              const Icon(
                                                Icons.flight_sharp,
                                                size: 12,
                                              ).marginOnly(left: 5.0)
                                            ],
                                          ).marginOnly(
                                            top: 5,
                                            left: 5,
                                            right: 5,
                                          ),
                                  ],
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
                              AppConstants.luckyIcon,
                              height: 24,
                            ).marginOnly(top: 12),
                          ),
                          Container(
                            padding: const EdgeInsets.only(top: 5, left: 5),
                            child: Text(
                              'Luck'.toUpperCase(),
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
                                  '${double.parse((double.parse((_.nftData['attributes']['luck']['value']).toString()) - double.parse((_.usernftData['attribuets']['luck']).toString())).toString()).toStringAsFixed(2)}/${double.parse((_.nftData['attributes']['luck']['maxValue']).toString()).toStringAsFixed(2)}',
                                  style: attributesValueStyle,
                                ),
                              ),
                              SizedBox(
                                height: 23.0,
                                width: Get.width / 1.68,
                                child: Stack(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.black),
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                        child: LinearPercentIndicator(
                                            lineHeight: 23.0,
                                            width: Get.width / 1.7,
                                            // barRadius: const Radius.circular(5.0),
                                            padding: const EdgeInsets.all(0.0),
                                            percent: _.calValue(_.usernftData['attribuets']['luck'], _.nftData['attributes']['luck']['value']) > 1.0 ||
                                                    _.calValue(
                                                            _.usernftData['attribuets']
                                                                ['luck'],
                                                            _.nftData['attributes']
                                                                    ['luck']
                                                                ['value']) <
                                                        0.0
                                                ? 1.0
                                                : _.calValue(
                                                    _.usernftData['attribuets']
                                                        ['luck'],
                                                    _.nftData['attributes']
                                                        ['luck']['value'],
                                                  ),
                                            animation: true,
                                            isRTL: true,
                                            center: _.calValue(_.usernftData['attribuets']['luck'], _.nftData['attributes']['luck']['value']) > 1.0 || _.calValue(_.usernftData['attribuets']['luck'], _.nftData['attributes']['luck']['value']) < 0.0
                                                ? Text(double.parse((double.parse((_.nftData['attributes']['luck']['value']).toString()) - double.parse((_.usernftData['attribuets']['luck']).toString())).toString())
                                                    .toStringAsFixed(2))
                                                : const SizedBox(),
                                            // backgroundColor: Colors.transparent,
                                            fillColor: const Color(0xff62c8a9),
                                            progressColor: _.calValue(_.usernftData['attribuets']['luck'], _.nftData['attributes']['luck']['value']) > 1.0 ||
                                                    _.calValue(_.usernftData['attribuets']['luck'], _.nftData['attributes']['luck']['value']) < 0.0
                                                ? const Color(0xffffc000)
                                                : const Color(0xff0287e1)),
                                      ),
                                    ),
                                    _.calValue(
                                                    _.usernftData['attribuets']
                                                        ['luck'],
                                                    _.nftData['attributes']
                                                        ['luck']['value']) >
                                                1.0 ||
                                            _.calValue(
                                                    _.usernftData['attribuets']
                                                        ['luck'],
                                                    _.nftData['attributes']
                                                        ['luck']['value']) <
                                                0.0
                                        ? const Icon(
                                            Icons.battery_1_bar_outlined,
                                            size: 21,
                                            color: Colors.red,
                                          ).marginOnly(left: 10)
                                        : const SizedBox(),
                                    _.calValue(
                                                    _.usernftData['attribuets']
                                                        ['luck'],
                                                    _.nftData['attributes']
                                                        ['luck']['value']) >
                                                1.0 ||
                                            _.calValue(
                                                    _.usernftData['attribuets']
                                                        ['luck'],
                                                    _.nftData['attributes']
                                                        ['luck']['value']) <
                                                0.0
                                        ? const SizedBox()
                                        : Row(
                                            children: [
                                              Text(
                                                double.parse((double.parse(
                                                                (_.nftData['attributes']
                                                                            [
                                                                            'luck']
                                                                        [
                                                                        'value'])
                                                                    .toString()) -
                                                            double.parse(
                                                                (_.usernftData[
                                                                            'attribuets']
                                                                        [
                                                                        'luck'])
                                                                    .toString()))
                                                        .toString())
                                                    .toStringAsFixed(2),
                                              ),
                                              const Spacer(),
                                              Text(
                                                double.parse((_.usernftData[
                                                                'attribuets']
                                                            ['luck'])
                                                        .toString())
                                                    .toStringAsFixed(2),
                                              ),
                                              const Icon(
                                                Icons.flight_sharp,
                                                size: 12,
                                              ).marginOnly(left: 5.0)
                                            ],
                                          ).marginOnly(
                                            top: 5,
                                            left: 5,
                                            right: 5,
                                          ),
                                  ],
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

  Widget tabbarCustom(TotalMintingController _, BuildContext context) {
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

                // _.playSoundEffect();
                // CustomToast.showToast(
                //   context: context,
                //   message: 'Coming soon',
                //   imagePath: AppConstants.logo,
                // );
                // _.indexing = 2;
                // _.update();
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

  Widget btnStack(
      btnText, boolean, BuildContext context, TotalMintingController _) {
    return GestureDetector(
      onTap: () {
        if (_.calValue(_.usernftData['attribuets']['fuel'],
                    _.nftData['attributes']['fuel']['value']) >
                1.0 ||
            _.calValue(_.usernftData['attribuets']['fuel'],
                    _.nftData['attributes']['fuel']['value']) <=
                0.0 ||
            _.nftData['attributes']['fuel']['value'] <
                _.usernftData['attribuets']['fuel'] ||
            _.calValue(_.usernftData['attribuets']['mine'],
                    _.nftData['attributes']['mine']['value']) >
                1.0 ||
            _.calValue(_.usernftData['attribuets']['mine'],
                    _.nftData['attributes']['mine']['value']) <=
                0.0 ||
            _.nftData['attributes']['mine']['value'] <
                _.usernftData['attribuets']['mine'] ||
            _.calValue(_.usernftData['attribuets']['durability'],
                    _.nftData['attributes']['durability']['value']) >
                1.0 ||
            _.calValue(_.usernftData['attribuets']['durability'],
                    _.nftData['attributes']['durability']['value']) <=
                0.0 
                // ||
            // _.nftData['attributes']['luck']['value'] < _.usernftData['attribuets']['luck'] ||
            // _.calValue(_.usernftData['attribuets']['luck'], _.nftData['attributes']['luck']['value']) > 1.0 ||
            // _.calValue(_.usernftData['attribuets']['luck'], _.nftData['attributes']['luck']['value']) < 0.0 ||
            // _.nftData['attributes']['luck']['value'] < _.usernftData['attribuets']['luck']
            
            ) {
          CommonToast.getToast(
            'Please buy attributes first',
          );
          // CommonSnackbar.getSnackbar(
          //     "Warning", "please buy attributes first", Colors.blue);
        } else {
          if (_.storage.hasData('from')) {
            CommonToast.getToast(
              'Please complete your pending process',
            );
          } else {
            _.storage.write("token_imagepath", _.levelController.imagePath);
            Get.toNamed(
              Routes.checkInRoutes,
              arguments: {
                "lat": _.checkInLat,
                "lng": _.checkInLong,
                "fromCountry": _.fromCountry,
                "toCountry": _.toCountry,
                "totalDistance": _.totalDistance,
              },
            );
            // Get.to(
            //   () => const CheckIn(),
            //   arguments: {
            //     "lat": _.checkInLat,
            //     "lng": _.checkInLong,
            //     "fromCountry": _.fromCountry,
            //     "toCountry": _.toCountry,
            //     "totalDistance": _.totalDistance,
            //   },
            // );
          }
        }
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
    TotalMintingController _,
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

  // buyLevel(TotalMintingController _,
  //     {String? iconName, String? maxvalue, String? attributeName}) {
  //   Get.defaultDialog(
  //     radius: 10,
  //     content: Column(
  //       children: [
  //         Container(
  //           height: 40,
  //           width: Get.width / 4,
  //           decoration: const BoxDecoration(
  //               color: Color(0xffDDFFF4),
  //               borderRadius: BorderRadius.only(
  //                   topLeft: Radius.circular(5), topRight: Radius.circular(5))),
  //           child: Center(
  //             child: Text("Common"),
  //           ),
  //         ),
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: [
  //             btn(
  //               color: Colors.white,
  //               title: "NEXT TIME",
  //               onTap: () {
  //                 Get.back();
  //               },
  //             ),
  //             const SizedBox(
  //               width: 20,
  //             ),
  //             btn(
  //               color: const Color(0xffffbb42),
  //               title: "CONFIRM",
  //               onTap: () async {
  //                 if (double.parse(maxvalue!).round() <
  //                     int.parse(_.avalue.value.text).toDouble().round()) {
  //                   CommonSnackbar.getSnackbar(
  //                       "Warning", "Please enter smaller value", Colors.blue);
  //                 } else {
  //                   Get.back();
  //                   await _.updateAttribute(attributeName!);
  //                 }
  //               },
  //             )
  //           ],
  //         )
  //       ],
  //     ),
  //   );
  // }

  Widget btn({Color? color, String? title, void Function()? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        width: 120,
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.black)),
        child: Center(
          child: Text(
            title!,
            style: const TextStyle(
              fontSize: 15,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
