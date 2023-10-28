import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:satoshi/widget/reuse_iconbutton.dart';

// import '../Controllers/landingpage_controller.dart';
import '../Utils/app_colors.dart';
import '../Utils/app_constants.dart';

class BottomNavbarWidget extends StatelessWidget {
  const BottomNavbarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // LandingPageController landingPageController =
    //     Get.find<LandingPageController>();
    final storage = GetStorage();
    return Container(
      decoration: BoxDecoration(
        color: AppColors.btmNavColor,
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: BottomAppBar(
        clipBehavior: Clip.antiAlias,
        color: AppColors.btmNavColor,
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              ReusableIconButton(
                icon: Image.asset(
                  AppConstants.flyNavIcon,
                  height: 30,
                ),
                btntxt: const Text(
                  "Fly",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 10,
                  ),
                ),
                onPressed: () {
                  print("check ${storage.hasData('from')}");
                  if (storage.hasData('from') == false) {
                    Get.back();
                    Get.back();
                    Get.back();
                    Get.back();
                    Get.back();
                    Get.back();
                    Get.back();
                    Get.back();
                  }
                  // landingPageController.currentIndex = 0;
                  // landingPageController.update();
                },
              ),
              ReusableIconButton(
                icon: Image.asset(
                  AppConstants.assetsNavIcon,
                  height: 30,
                ),
                btntxt: const Text(
                  "Asset",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 10,
                  ),
                ),
                onPressed: () {
                  if (storage.hasData('from') == false) {
                    Get.back();
                    Get.back();
                    Get.back();
                    Get.back();
                    Get.back();
                    Get.back();
                    Get.back();
                  }
                  // landingPageController.currentIndex = 1;
                  // landingPageController.update();
                },
              ),
              ReusableIconButton(
                icon: Image.asset(
                  AppConstants.boardNavIcon,
                  height: 30,
                ),
                btntxt: const Text(
                  "Board",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 10,
                  ),
                ),
                onPressed: () {
                  if (storage.hasData('from') == false) {
                    Get.back();
                    Get.back();
                    Get.back();
                    Get.back();
                    Get.back();
                    Get.back();
                    Get.back();
                  }
                  // landingPageController.currentIndex = 2;
                  // landingPageController.update();
                },
              ),
              ReusableIconButton(
                icon: Image.asset(
                  AppConstants.marketNavIcon,
                  height: 30,
                ),
                btntxt: const Text(
                  "Market",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 10,
                  ),
                ),
                onPressed: () {
                  if (storage.hasData('from') == false) {
                    Get.back();
                    Get.back();
                    Get.back();
                    Get.back();
                    Get.back();
                    Get.back();
                    Get.back();
                  }
                  // landingPageController.currentIndex = 3;
                  // landingPageController.update();
                },
              ),
            ],
          ).marginOnly(left: 35, right: 35),
        ),
      ),
    ).marginOnly(left: 10, right: 10);
  }
}

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:satoshi/widget/common_toast.dart';
// import 'package:satoshi/widget/reuse_iconbutton.dart';

// import '../Controllers/landingpage_controller.dart';
// import '../Utils/app_colors.dart';
// import '../Utils/app_constants.dart';

// class BottomNavbarWidget extends StatelessWidget {
//   const BottomNavbarWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     LandingPageController landingPageController =
//         Get.find<LandingPageController>();
//     return Container(
//       decoration: BoxDecoration(
//         color: AppColors.btmNavColor,
//         border: Border.all(color: Colors.black),
//         borderRadius: BorderRadius.circular(5.0),
//       ),
//       child: BottomAppBar(
//         clipBehavior: Clip.antiAlias,
//         color: AppColors.btmNavColor,
//         child: SizedBox(
//           height: 60,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: <Widget>[
//               ReusableIconButton(
//                 icon: Image.asset(
//                   AppConstants.levelUpLogo,
//                   height: 30,
//                 ),
//                 btntxt: const Text(
//                   "Level up",
//                   style: TextStyle(
//                     color: Colors.black,
//                     fontSize: 10,
//                   ),
//                 ),
//                 onPressed: () {
//                   Get.back();
//                   Get.back();
//                   Get.back();
//                   Get.back();
//                   Get.back();
//                   Get.back();
//                   Get.back();
//                   landingPageController.currentIndex = 0;
//                   landingPageController.update();
//                 },
//               ),
//               ReusableIconButton(
//                 icon: Image.asset(
//                   AppConstants.sellLogo,
//                   height: 30,
//                 ),
//                 btntxt: const Text(
//                   "Sell",
//                   style: TextStyle(
//                     color: Colors.black,
//                     fontSize: 10,
//                   ),
//                 ),
//                 onPressed: () {
//                   landingPageController.playSoundEffect();
//                   CustomToast.showToast(
//                     context: context,
//                     message: 'Coming soon',
//                     imagePath: AppConstants.logo,
//                   );
//                   // Get.back();
//                   // Get.back();
//                   // Get.back();
//                   // Get.back();
//                   // Get.back();
//                   // Get.back();
//                   // Get.back();
//                   // landingPageController.currentIndex = 1;
//                   // landingPageController.update();
//                 },
//               ),
//               ReusableIconButton(
//                 icon: Image.asset(
//                   AppConstants.breedLogo,
//                   height: 30,
//                 ),
//                 btntxt: const Text(
//                   "Breed",
//                   style: TextStyle(
//                     color: Colors.black,
//                     fontSize: 10,
//                   ),
//                 ),
//                 onPressed: () {
//                   landingPageController.playSoundEffect();
//                   CustomToast.showToast(
//                     context: context,
//                     message: 'Coming soon',
//                     imagePath: AppConstants.logo,
//                   );
//                   // Get.back();
//                   // Get.back();
//                   // Get.back();
//                   // Get.back();
//                   // Get.back();
//                   // Get.back();
//                   // Get.back();
//                   // landingPageController.currentIndex = 2;
//                   // landingPageController.update();
//                 },
//               ),
//               ReusableIconButton(
//                 icon: Image.asset(
//                   AppConstants.leaseLogo,
//                   height: 30,
//                 ),
//                 btntxt: const Text(
//                   "Lease",
//                   style: TextStyle(
//                     color: Colors.black,
//                     fontSize: 10,
//                   ),
//                 ),
//                 onPressed: () {
//                   landingPageController.playSoundEffect();
//                   CustomToast.showToast(
//                     context: context,
//                     message: 'Coming soon',
//                     imagePath: AppConstants.logo,
//                   );
//                   // Get.back();
//                   // Get.back();
//                   // Get.back();
//                   // Get.back();
//                   // Get.back();
//                   // Get.back();
//                   // Get.back();
//                   // landingPageController.currentIndex = 2;
//                   // landingPageController.update();
//                 },
//               ),
//               ReusableIconButton(
//                 icon: Image.asset(
//                   AppConstants.transferLogo,
//                   height: 30,
//                 ),
//                 btntxt: const Text(
//                   "Transfer",
//                   style: TextStyle(
//                     color: Colors.black,
//                     fontSize: 10,
//                   ),
//                 ),
//                 onPressed: () {
//                   landingPageController.playSoundEffect();
//                   CustomToast.showToast(
//                     context: context,
//                     message: 'Coming soon',
//                     imagePath: AppConstants.logo,
//                   );
//                   // Get.back();
//                   // Get.back();
//                   // Get.back();
//                   // Get.back();
//                   // Get.back();
//                   // Get.back();
//                   // Get.back();
//                   // landingPageController.currentIndex = 3;
//                   // landingPageController.update();
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     ).marginOnly(left: 10, right: 10);
//   }
// }
