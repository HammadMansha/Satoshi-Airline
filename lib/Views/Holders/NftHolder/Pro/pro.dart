import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../Controllers/landing/pro_controller.dart';
import '../../../../Utils/utils.dart';

class ProAccount extends StatelessWidget {
  const ProAccount({Key? key, this.takeBool = true}) : super(key: key);

  final bool takeBool;

  @override
  Widget build(BuildContext context) {
    final mqData = MediaQuery.of(context);
    final mqDataNew = mqData.copyWith(
        textScaleFactor:
        mqData.textScaleFactor > 1.0 ? 1.0 : mqData.textScaleFactor);
    return GetBuilder<ProController>(
      init: ProController(),
      builder: (_) {
        return MediaQuery(
          data: mqDataNew,
          child: Scaffold(
            backgroundColor: const Color(0xffFFFAEC),
            body: Container(
              width: Get.width,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: AppColors.black),
                borderRadius: BorderRadius.circular(
                  10,
                ),
              ),
              child: Column(
                children: [
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 40,
                        ),
                        Container(
                          width: Get.width,
                          height: 176,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                AppConstants.deleteLater,
                              ),
                            ),
                          ),
                          child: Center(
                            child: IconButton(
                              icon: Image.asset(
                                AppConstants.addIconWhite,
                                height: 176,
                              ),
                              onPressed: () {
                                // <------- When press button go to index 2 on landing page ---------->

                                // _.landingPageController.currentIndex = 2;
                                // _.landingPageController.update();
                              },
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                          onTap: () {
                            // _.landingPageController.currentIndex = 2;
                            // _.landingPageController.update();
                          },
                          child: SizedBox(
                            child: Column(
                              children: [
                                Image.asset(AppConstants.appAttributes),
                                Container(
                                    padding: const EdgeInsets.only(top: 20),
                                    child: btnStack(
                                        AppConstants.start, false, context, _)),
                                const SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  AppConstants.tutTextBtn,
                                  style: attributesValueStyle,
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ).marginOnly(left: 20, right: 20),
                  )
                ],
              ),
            ).marginOnly(left: 10, right: 10),
          ),
        );
      },
    );
  }

  Widget btnStack(btnText, boolean, BuildContext context, ProController _) {
    return GestureDetector(
      onTap: () {
        // takeBool ? returnDialog(context, _) : Container();
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
}
