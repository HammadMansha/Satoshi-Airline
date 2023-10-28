import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:slide_switcher/slide_switcher.dart';

import '../../AppCommons/balance_top_bar.dart';
import '../../Controllers/landing/plane_controller.dart';
import '../../Utils/app_constants.dart';

class PlaneScreen extends StatelessWidget {
  const PlaneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mqData = MediaQuery.of(context);
    final mqDataNew = mqData.copyWith(
        textScaleFactor:
        mqData.textScaleFactor > 1.0 ? 1.0 : mqData.textScaleFactor);
    return GetBuilder<PlaneController>(
      init: PlaneController(),
      builder: (_) {
        return MediaQuery(
          data: mqDataNew,
          child: Scaffold(
            backgroundColor: const Color(0xffFFFAEC),
            body: Column(
              children: [
                BalanceTopBar(
                  _.landingPageController.assetImage.isEmpty
                      ? AppConstants.profileImg
                      : _.landingPageController.assetImage,
                  isNetwork:
                      _.landingPageController.assetImage.isEmpty ? false : true,
                ),
                const SizedBox(
                  height: 30,
                ),
                Center(
                  child: SlideSwitcher(
                    slidersBorder: Border.all(
                      width: 1,
                      color: const Color(0xff000000),
                    ),
                    containerBorder: Border.all(
                      width: 1,
                      color: const Color(0xff000000),
                    ),
                    containerColor: const Color(0xffFFFDFD),
                    slidersColors: const [Color(0xff62C8A9)],
                    onSelect: (index) {
                      _.selectedIndex = index;
                      _.update();
                    },
                    containerHeight: 40,
                    containerWight: Get.width * 0.9,
                    containerBorderRadius: 2,
                    children: [
                      Text(
                        "Pro",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: _.selectedIndex == 0
                              ? FontWeight.w600
                              : FontWeight.w300,
                          color: const Color(0xff000000),
                        ),
                      ),
                      Text(
                        "Basic",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: _.selectedIndex == 1
                              ? FontWeight.w600
                              : FontWeight.w300,
                          color: const Color(0xff000000),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: const Color(0xff000000),
                      ),
                      color: const Color(0xffFFFDFD),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ).marginOnly(
                    left: 10,
                    right: 10,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
