import 'package:get/get.dart';

import '../landingpage_controller.dart';

class PlaneController extends GetxController {

  bool isLoading = true;
  String assetImage = '';
  int selectedIndex = 0;
  
  LandingPageController landingPageController =
      Get.find<LandingPageController>();

  @override
  void onReady() {
    isLoading = false;
    update();
    super.onReady();
  }



}
