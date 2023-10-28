import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:satoshi/Controllers/tabview_controller.dart';
import 'package:satoshi/Views/Holders/HolderCommon/basictab_screen.dart';
import 'package:satoshi/Views/qr/qr_screen.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../../../Utils/commonSnackbar.dart';
import '../../../Utils/utils.dart';

// import '../../../widget/common_toast.dart';
import '../../../widget/appbar/commonAppbar.dart';
import '../../../widget/common_button.dart';
import '../NonNftHolder/basic.dart';

class TabView extends StatelessWidget {
  const TabView({super.key, this.takeBool = false});

  final bool takeBool;

  @override
  Widget build(BuildContext context) {
    final mqData = MediaQuery.of(context);
    final mqDataNew = mqData.copyWith(
        textScaleFactor:
            mqData.textScaleFactor > 1.0 ? 1.0 : mqData.textScaleFactor);
    return GetBuilder<TabviewController>(
      init: TabviewController(),
      builder: (_) {
        return MediaQuery(
          data: mqDataNew,
          child: Scaffold(
            // bottomNavigationBar:BottomNavigationBar(items: [],) ,
            backgroundColor: const Color(0xffFFFAEC),
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(80),
              child: SafeArea(
                child: _.landingPageController.internetConnection
                    ? CommonAppbar(
                        isNetwork: false.obs,
                        imagePath: AppConstants.profileImg,
                        totalsap: '0',
                        bnb: 0.00,
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
                        totalsap: _.landingPageController.tokenBalance == null
                            ? '0.00'
                            : _.landingPageController.tokenBalance
                                .toStringAsFixed(2),
                        bnb: _.landingPageController.balanceInBNB == null
                            ? 0.0
                            : double.parse(_.landingPageController.balanceInBNB
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
            body: DefaultTabController(
              length: _.myTabs.length,
              initialIndex: 0,
              child: Column(
                children: [
                  tabbarCustom(_, context),
                  Expanded(child: bodyPages()[_.indexing]),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget tabbarCustom(TabviewController _, BuildContext context) {
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
            onTap: () async {
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
                _.playSoundEffect();
              }
              // CommonToast.showToast(
              //   message: 'Coming soon',
              //   // imagePath: AppConstants.logo,
              // );
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
                ),
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

  List<Widget> bodyPages() {
    return [const BasicAccount(), const BasicTabScreen(), QrScreen()];
  }

  Widget noDataFound() {
    return Container(
      height: Get.size.height * 0.73,
      width: Get.size.width * 0.94,
      // padding: EdgeInsets.only(top:150),
      decoration: BoxDecoration(
          border: Border.all(color: AppColors.black),
          borderRadius: BorderRadius.circular(10)),
      child: Align(
        // alignment: Alignment.topLeft,
        child: Container(
          padding: const EdgeInsets.only(left: 10, top: 10),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  // Get.to(() => const TabView());
                },
                child: Container(
                    padding: const EdgeInsets.only(top: 200),
                    // height: MediaQuery.of(context).size.height*0.3,
                    // width:
                    //     MediaQuery.of(context).size.width * 0.3,
                    child: Image.asset(
                      AppConstants.noItems,
                      height: 150,
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
