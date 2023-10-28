import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:satoshi/Controllers/extrapage_controller.dart';
import 'package:satoshi/Utils/app_colors.dart';
import 'package:satoshi/Utils/app_constants.dart';
import 'package:satoshi/Utils/app_text_styles.dart';
import 'package:satoshi/Utils/commonSnackbar.dart';
import 'package:satoshi/routes/app_routes.dart';

import '../../../../widget/appbar/commonAppbar.dart';
import '../../../../widget/bottom_navbar.dart';
// import '../../NonNftHolder/LeadingBoard/leading_tab_view.dart';

class ExtraPage extends StatelessWidget {
  const ExtraPage({super.key});

  @override
  Widget build(BuildContext context) {
    return bodyData(context);
  }

  // --------------------- Main Widget of the screen --------------------

  Widget bodyData(BuildContext context) {
    final mqData = MediaQuery.of(context);
    final mqDataNew = mqData.copyWith(
        textScaleFactor:
            mqData.textScaleFactor > 1.0 ? 1.0 : mqData.textScaleFactor);
    return GetBuilder<ExtraPageController>(
      init: ExtraPageController(),
      builder: (_) {
        return MediaQuery(
          data: mqDataNew,
          child: Scaffold(
            // bottomNavigationBar: LandingPage(),
            backgroundColor: AppColors.appBgColor,
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(90),
              child: SafeArea(
                child: _.landingPageController.internetConnection
                    ? CommonAppbar(
                        isNetwork: false.obs,
                        imagePath: AppConstants.profileImg,
                        totalsap: '0',
                        bnb: 0,
                        travel: '0',
                      )
                    : CommonAppbar(
                        isNetwork:
                            _.landingPageController.assetImage.value.isEmpty
                                ? false.obs
                                : true.obs,
                        imagePath:
                            _.landingPageController.assetImage.value.isEmpty
                                ? AppConstants.profileImg
                                : _.landingPageController.assetImage.value.obs,
                        totalsap: _.landingPageController
                                    .balanceData['totalSap'] ==
                                null
                            ? ''
                            : _.landingPageController.balanceData['totalSap']
                                .toString(),
                        bnb:
                            _.landingPageController.balanceData['bnbBalance'] ==
                                    null
                                ? 0.0
                                : double.parse(_.landingPageController
                                    .balanceData['bnbBalance']
                                    .toString()),
                        travel: _.landingPageController
                                    .balanceData['distance'] ==
                                null
                            ? '0'
                            : _.landingPageController.balanceData['distance']
                                .toString(),
                      ),
              ),
            ),
            bottomNavigationBar: const BottomNavbarWidget(),
            body: Column(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: AppColors.black),
                      borderRadius: BorderRadius.circular(
                        10,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.info,
                              color: Colors.black,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Flexible(
                              child: Text(
                                "To do test minting, you need to acquire SAP and TBNB.\n \nYou'll get TBNB and SAP as faucet for GAS fee once in 24 hours",
                                textAlign: TextAlign.center,
                                style: extrapageTitleStyle,
                              ),
                            ),
                          ],
                        ).marginOnly(left: 15, right: 15),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                _.selectedValue.value = 1;
                                _.type = 'Token';
                                _.update();
                              },
                              child: buildCheckBox(
                                  1, "SAP", _, AppConstants.sapIcon),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            // const SizedBox(width: 40.0),
                            GestureDetector(
                              onTap: () {
                                _.selectedValue.value = 2;
                                _.type = 'BNB';
                                _.update();
                              },
                              child: buildCheckBox(
                                  2, "TBNB", _, AppConstants.btcIcon),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          controller: _.amount,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'this field is required';
                            } else {
                              return null;
                            }
                          },
                          readOnly: true,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: AppColors.black,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                width: 1,
                                color: Colors.black,
                              ),
                            ),
                            hintText: "0x000000000000000",
                            hintStyle: hintTextStyle,
                          ),
                        ).marginOnly(left: 15, right: 15),
                        const SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                          onTap: () async {
                            if (_.type.isEmpty) {
                              CommonToast.getToast(
                                'Please select type',
                              );
                              // CommonSnackbar.getSnackbar(
                              //     "Warning", "please select type", Colors.blue);
                            } else {
                              await _.transferMint();
                            }
                          },
                          child: Container(
                            height: 39,
                            width: 110,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(AppConstants.startBtn),
                              ),
                            ),
                            child: _.isLoading
                                ? SpinKitThreeBounce(
                                    color: AppColors.primaryColor1,
                                    size: 20.0,
                                  )
                                : Center(
                                    child: Text(
                                      'Confirm',
                                      style: updateTxtStyle,
                                    ),
                                  ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                          onTap: () async {
                            if (_.landingPageController.internetConnection) {
                              CommonToast.getToast(
                                  "Please check your internet connection and restart your app again");
                            } else {
                              Get.toNamed(Routes.travelHistoryRoutes);
                              // Get.to(() => const LeadingTabView());
                            }
                          },
                          child: Container(
                            height: 39,
                            width: Get.width / 2.5,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: Colors.black,
                                ),
                                borderRadius: BorderRadius.circular(5)),
                            child: Center(
                              child: Text(
                                'Check Travel History',
                                style: updateTxtStyle,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ).marginOnly(bottom: 10, left: 10, right: 10),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // -------------------- Coins selection ---------------------------

  Widget buildCheckBox(
      int value, String text, ExtraPageController _, String iconData) {
    return Column(
      children: [
        Image.asset(
          iconData,
          height: 65,
        ),
        Text(
          text,
          style: congratulateTextStyle,
        ).marginOnly(top: 5, bottom: 20),
        Container(
          width: 20.0,
          height: 20.0,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            // ignore: unrelated_type_equality_checks
            color: _.selectedValue == value
                ? AppColors.btnBgColor
                : AppColors.grey86,
            shape: BoxShape.circle,
          ),
        ),
      ],
    );
  }
}
