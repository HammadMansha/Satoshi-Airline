import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:satoshi/Controllers/landingpage_controller.dart';
import '../Utils/utils.dart';

class TabviewController extends GetxController {
  bool isLoading = true;

  bool isPressed = false;
  double value = 0.5;
  List<Tab> myTabs = [];

  int indexing = 0;

  LandingPageController landingPageController =
      Get.find<LandingPageController>();

  @override
  void onInit() {
    myTabs = [
      const Tab(text: 'Basic'),
      const Tab(text: 'Pro'),
      Tab(
          icon: Image.asset(
        AppConstants.helpIcon,
        height: 17,
      )),
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

  void playSoundEffect() async {
    final player = AudioPlayer();
    await player.play(AssetSource(AppConstants.comingSoonSound));
  }
}
