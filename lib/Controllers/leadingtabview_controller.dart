import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:satoshi/Controllers/landingpage_controller.dart';

import '../Utils/app_constants.dart';

class LeadingTabViewController extends GetxController {
  bool isLoading = true;
  double value = 0.5;
  List<Tab> myTabs = [];

  int indexing = 1;
  String assetImage = '';

  LandingPageController landingPageController =
      Get.find<LandingPageController>();

  @override
  void onInit() {
    myTabs = const [
      Tab(text: AppConstants.rank),
      Tab(text: AppConstants.record),
    ];
    update();
    super.onInit();
  }

  @override
  void onReady() {
    isLoading = false;
    update();
    super.onReady();
  }
}
