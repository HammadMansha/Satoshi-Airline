import 'package:get/get.dart';
import 'package:satoshi/Controllers/level/level_controller.dart';

import '../landingpage_controller.dart';

class FreeJetSetStartScreenController extends GetxController{

  LandingPageController landingPageController =
  Get.find<LandingPageController>();
  LevelController levelController = Get.find<LevelController>();



  bool isLoading = true;



  @override
  void onReady() {
    isLoading = false;
    update();
    // TODO: implement onReady
    super.onReady();
  }

}