import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:satoshi/Views/Holders/NftHolder/arrival.dart';
import '../../../Controllers/flytoearn_controller.dart';
import '../../../Utils/utils.dart';
import '../../../widget/appbar/commonAppbar.dart';
import '../../../widget/bottom_navbar.dart';

class FlyToEarn extends StatelessWidget {
  const FlyToEarn({super.key});

  @override
  Widget build(BuildContext context) {
    final mqData = MediaQuery.of(context);
    final mqDataNew = mqData.copyWith(
        textScaleFactor:
        mqData.textScaleFactor > 1.0 ? 1.0 : mqData.textScaleFactor);
    return MediaQuery(
      data: mqDataNew,
      child: GetBuilder<FlyToEarnController>(
        init: FlyToEarnController(),
        builder: (_) {
          return WillPopScope(
            onWillPop: () async {
              return true;
            },
            child: Scaffold(
              backgroundColor: const Color(0xffFFFAEC),
              appBar: PreferredSize(
                preferredSize: const Size.fromHeight(90),
                child: SafeArea(
                  child: CommonAppbar(
                    isViewProfile: false,
                    isNetwork: _.landingPageController.assetImage.value.isEmpty
                        ? false.obs
                        : true.obs,
                    imagePath: _.landingPageController.assetImage.value.isEmpty
                        ? AppConstants.profileImg
                        : _.landingPageController.assetImage.value.obs,
                    travel:
                    _.landingPageController.balanceData['distance'] == null
                        ? '0'
                        : double.parse(_.landingPageController
                        .balanceData['distance']
                        .toString())
                        .round()
                        .toString(),
                    isTextOnly: true,
                    body: 'MINING',
                  ),
                ),
              ),
              body: _.isLoading ? Center(child: Image.asset(AppConstants.boarding)) :
                  body(_),
              bottomNavigationBar: const BottomNavbarWidget(),
            ),
          );
        },
      ),
    );
  }

  Widget body(FlyToEarnController _) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              AppConstants.flytoearn,
              height: 42,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            child: Image.asset(AppConstants.mintNotStarted),
          ),
          const SizedBox(
            height: 35,
          ),
          Container(
            child: Text(
              AppConstants.amountOfMinting,
              style: amountEarnedStyle,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Container(
            padding: EdgeInsets.only(left: 20, right: 20),
            height: Get.height * 0.077,
            width: Get.width * 0.7,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: AppColors.black),
                borderRadius: BorderRadius.circular(10)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  AppConstants.sapIcon,
                  height: 46,
                ),
                Spacer(),
                Obx(() => Text(
                    "${_.minitingValue.value.toStringAsFixed(2)}${AppConstants.sapTxt}",
                    style: earnedRatio)),
                Text("/${_.storage.read('sapReward')} SAP", style: earned),
              ],
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          Container(
            child: Text(
              AppConstants.tutMsg,
              textAlign: TextAlign.center,
              style: tutMsgStyle,
            ),
          ).marginOnly(left: 10, right: 10),
          const SizedBox(
            height: 24,
          ),
          GestureDetector(
            onTap: () {
              Get.to(() => const Arrival());
            },
            child: Container(
              height: 40,
              width: 100,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.yellow.withOpacity(0.3)),
              child: const Center(
                child: Text(
                  "Next",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
