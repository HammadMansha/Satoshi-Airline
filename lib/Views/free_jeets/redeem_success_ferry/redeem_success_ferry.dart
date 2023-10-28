import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:satoshi/Utils/app_asset_wallet.dart';
import 'package:satoshi/Views/free_jeets/redeem_success_ferry/redeem_success_controller.dart';
import '../../../Utils/utils.dart';
import '../../../widget/appbar/commonAppbar.dart';
import '../../../widget/bottom_navbar.dart';


class RedeemSuccessFerry extends StatelessWidget {
  const RedeemSuccessFerry({super.key});

  @override
  Widget build(BuildContext context) {
    final mqData = MediaQuery.of(context);
    final mqDataNew = mqData.copyWith(
        textScaleFactor:
        mqData.textScaleFactor > 1.0 ? 1.0 : mqData.textScaleFactor);
    return GetBuilder<RedeemSuccessFerryController>(
      init: RedeemSuccessFerryController(),
      builder: (_) {
        return WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: MediaQuery(
            data: mqDataNew,
            child: Scaffold(
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
                    bnb: _.landingPageController.balanceData['bnbBalance'] ==
                        null
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
              body: body(context, _),
            ),
          ),
        );
      },
    );
  }

  Widget body(BuildContext context, RedeemSuccessFerryController _) {
    return Container(
      // padding: EdgeInsets.only(left: 10,right: 10),
      decoration: BoxDecoration(
          border: Border.all(color: AppColors.black),
          borderRadius: BorderRadius.circular(10)),
      child: _.isLoading
          ? Center(
        child: CircularProgressIndicator(
          color: Color(0xff62c8a9),
        ),
      )
          : Visibility(
        visible: _.showPic,
        child: Column(
          children: [
            // Builder(
            //   builder: (context) {
            //     _.playSoundEffect();
            //     return Container();},
            // ),
            const SizedBox(
              height: 52,
            ),
            Image.asset(
              AppConstants.redeemSuccess,
              height: 88,
            ),
            const SizedBox(
              height: 37,
            ),
            Image.asset(
              AppAssets.redeemBannerFerry,
              height: 141,
              width: 211,
            ),
            const SizedBox(height: 37),
            Text('${_.price}${AppConstants.redeemSucMsg}'),
            Container(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppConstants.amountTxt,
                    style: conAlertStyle,
                  ),
                  GestureDetector(
                    onTap: () async {
                      _.isLoading = true;
                      _.update();
                      _.landingPageController.minitingGlobleController
                          .assetsData
                          .clear();
                      _.showPic = false;
                      _.update();
                      _.landingPageController.minitingGlobleController
                          .update();
                      await _.landingPageController.minitingGlobleController
                          .getUserNftData();
                      // await _.landingPageController.minitingGlobleController
                      //     .getWalletOfOwner(_.storage.read("wallet"));
                      await _.storage.remove('from');
                      await _.storage.remove('to');
                      await _.storage.remove('distance');
                      await _.storage.remove('tokenId');
                      await _.storage.remove('time');
                      await _.storage.remove('session_from');
                      await _.storage.remove('session_to');
                      await _.storage.remove('session_totalDistance');
                      await _.storage.remove('session_tokenId');
                      await _.storage.remove('session_time');
                      await _.storage.remove('sapReward');
                      await _.storage.remove('fromCountry');
                      await _.storage.remove('toCountry');
                      await _.storage.remove('session_fromCountry');
                      await _.storage.remove('session_toCountry');
                      Get.back();
                      Get.back();
                      Get.back();
                      Get.back();
                      Get.back();
                      Get.back();
                      Get.back();
                      Get.back();
                      Get.back();
                      Get.back();
                      _.showPic = false;
                      _.update();
                      _.isLoading = false;
                      _.update();
                    },
                    child: Row(
                      children: [
                        Image.asset(
                          AppConstants.sapIcon,
                          height: 24,
                        ),
                        Text(
                          ' ${_.price} ${AppConstants.sapTxt}',
                          style: earnedSap,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            const Divider(
              endIndent: 20,
              indent: 20,
            ),
            const Spacer(),
            GestureDetector(
              onTap: () async {
                _.showPic = false;
                _.update();
                _.isLoading = true;
                _.update();
                _.landingPageController.minitingGlobleController.assetsData
                    .clear();
                _.landingPageController.minitingGlobleController.update();
                await _.landingPageController.minitingGlobleController
                    .getUserNftData();
                // await _.landingPageController.minitingGlobleController
                //     .getWalletOfOwner(_.storage.read("wallet"));

                // Get.back();
                // Get.back();
                // Get.back();
                // Get.back();
                // Get.back();
                // Get.back();
                // Get.back();
                // Get.back();
                await _.storage.remove('from');
                await _.storage.remove('to');
                await _.storage.remove('distance');
                await _.storage.remove('tokenId');
                await _.storage.remove('time');
                await _.storage.remove('session_from');
                await _.storage.remove('session_to');
                await _.storage.remove('session_totalDistance');
                await _.storage.remove('session_tokenId');
                await _.storage.remove('session_time');
                await _.storage.remove('sapReward');
                await _.storage.remove('fromCountry');
                await _.storage.remove('toCountry');
                await _.storage.remove('session_fromCountry');
                await _.storage.remove('session_toCountry');
                Get.back();
                Get.back();
                Get.back();
                Get.back();
                Get.back();
                Get.back();
                Get.back();
                Get.back();
                Get.back();
                Get.back();
                _.showPic = false;
                _.update();
                _.isLoading = false;
                _.update();

              },
              child: Container(
                height: 40,
                width: 130,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.yellow.withOpacity(0.3)),
                child: const Center(
                  child: Text(
                    "Return home",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ).marginOnly(bottom: 20),
          ],
        ),
      ),
    ).marginOnly(bottom: 20, left: 10, right: 10);
  }
}
