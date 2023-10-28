

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:satoshi/Controllers/splash_controller.dart';
import 'package:satoshi/Utils/app_constants.dart';
// import 'package:get/get.dart';

import '../Utils/utils.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    final mqData = MediaQuery.of(context);
    final mqDataNew = mqData.copyWith(
        textScaleFactor:
        mqData.textScaleFactor > 1.0 ? 1.0 : mqData.textScaleFactor);
    return GetBuilder<SplashController>(
      init: SplashController(),
      builder: (_) {
        return MediaQuery(
          data: mqDataNew,
          child: Scaffold(
            body: Container(
              padding: const EdgeInsets.only(top: 100),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AppConstants.onBoardImage),
                  fit: BoxFit.cover,
                  // alignment: Alignment.topLeft
                ),
              ),
              // child: Align(
              //   alignment: Alignment.topCenter,
              //   child: Image.asset(
              //     AppConstants.newLogo,
              //     height: 82,
              //     width: 123,
              //   ).marginOnly(top: 30)
              // ),
            ),
          ),
        );
      },
    );
  }
}
