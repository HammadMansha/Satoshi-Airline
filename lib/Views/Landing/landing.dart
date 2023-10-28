import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:satoshi/Controllers/landingpage_controller.dart';
import 'package:satoshi/Utils/app_constants.dart';
import 'package:satoshi/Views/Holders/NonNftHolder/LeadingBoard/leading_tab_view.dart';
import 'package:satoshi/Views/Landing/assetspage_screen.dart';
import '../../Utils/app_colors.dart';
import '../../Utils/commonSnackbar.dart';
import '../../widget/loading/loading_screen.dart';
import '../Holders/HolderCommon/tab_view.dart';
import '../Holders/NonNftHolder/market_place.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final mqData = MediaQuery.of(context);
    final mqDataNew = mqData.copyWith(
        textScaleFactor:
            mqData.textScaleFactor > 1.0 ? 1.0 : mqData.textScaleFactor);
    return GetBuilder<LandingPageController>(
      init: LandingPageController(),
      builder: (_) {
        return WillPopScope(
          onWillPop: () async {
            if (_.currentIndex != 0) {
              _.currentIndex--;
              _.update();
              return false;
            }
            return true;
          },
          child: MediaQuery(
            data: mqDataNew,
            child: Scaffold(
              backgroundColor: const Color(0xffFFFAEC),
              body: _.isLoading
                  ? Loading()
                  // : _.internetConnection
                  //     ? SafeArea(
                  //       child: Column(
                  //         mainAxisAlignment: MainAxisAlignment.center,
                  //         children: [
                  //           Center(
                  //             child: Lottie.asset(
                  //               AppConstants.nointernet,
                  //               repeat: true,
                  //               height: Get.height / 3,
                  //             ),
                  //           ),
                  //           const SizedBox(
                  //             height: 20,
                  //           ),
                  //           Text(
                  //             "No Internet Connection",
                  //             style: GoogleFonts.sora(
                  //               fontWeight: FontWeight.w600,
                  //               fontSize: 20,
                  //             ),
                  //           ),
                  //           const SizedBox(
                  //             height: 10,
                  //           ),
                  //           Text(
                  //             "Please connect with internet and restart the app.",
                  //             style: GoogleFonts.sora(
                  //               fontWeight: FontWeight.w600,
                  //               fontSize: 15,
                  //             ),
                  //           ),
                  //         ],
                  //       ).marginOnly(left: 20, right: 20)
                  //     )
                      :
                       bodyPages()[_.currentIndex],
              bottomNavigationBar: Container(
                decoration: BoxDecoration(
                  color: AppColors.btmNavColor,
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5.0),
                  child: BottomNavigationBar(
                    selectedItemColor: const Color(0xff000000),
                    selectedFontSize: 12.0,
                    backgroundColor: AppColors.btmNavColor,
                    unselectedItemColor: const Color(0xff000000),
                    type: BottomNavigationBarType.fixed,
                    showSelectedLabels: true,
                    showUnselectedLabels: true,
                    elevation: 0,
                    currentIndex: _.currentIndex,
                    unselectedLabelStyle:
                        const TextStyle(color: Colors.black, fontSize: 10),
                    selectedLabelStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 10,
                    ),
                    items: [
                      BottomNavigationBarItem(
                        label: 'Fly',
                        backgroundColor: AppColors.btmNavColor,



                        icon: Image.asset(
                          AppConstants.flyNavIcon,
                          height: 30,
                        ).marginOnly(bottom: 8.0),
                      ),
                      BottomNavigationBarItem(
                        backgroundColor: AppColors.btmNavColor,
                        label: 'Asset',

                        icon: Image.asset(
                          AppConstants.assetsNavIcon,

                          height: 30,
                        ),
                      ),
                      BottomNavigationBarItem(
                        backgroundColor: AppColors.btmNavColor,
                        label: 'Board',
                        icon: Image.asset(
                          AppConstants.boardNavIcon,
                          height: 30,
                        ),
                      ),
                      BottomNavigationBarItem(
                        backgroundColor: AppColors.btmNavColor,
                        label: 'Market',
                        icon: Image.asset(
                          AppConstants.marketNavIcon,
                          height: 30,
                        ),
                      ),
                    ],
                    onTap: (value) {
                      if (value == 3) {
                        if (_.isSound) {
                          _.playSoundEffect();
                        }
                        CommonToast.getToast(
                          'Coming Soon',
                        );
                        // CustomToast.showToast(
                        //   context: context,
                        //   message: 'Coming soon',
                        //   // imagePath: AppConstants.logo,
                        // );
                        _.currentIndex = value;
                        _.update();
                      } else {
                        _.currentIndex = value;
                        _.update();
                      }
                    },
                  ).marginOnly(left: 45, right: 45),
                ),
              ).marginOnly(left: 10, right: 10),
            ),
          ),
        );
      },
    );
  }

  List<Widget> bodyPages() {
    return [
      const TabView(),
      const AssetsPageScreen(),
      const LeadingTabView(),
      const MarketPlace(),
    ];
  }
}
