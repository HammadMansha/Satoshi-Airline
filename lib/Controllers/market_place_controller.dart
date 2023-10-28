import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:satoshi/Controllers/landingpage_controller.dart';

import '../Utils/app_constants.dart';

class MarketPlaceController extends GetxController {
  bool isLoading = true;
  int indexing = 0;
  List<Tab> myTabs = [];
  bool isPressed = false;
  double value = 0.5;
  String dropdownValue = 'Lowest price';
  int segmentedControlValue = 0;

  String assetImage = '';

  LandingPageController landingPageController =
      Get.find<LandingPageController>();

  @override
  void onInit() {
    myTabs = const [
      Tab(text: 'Plane'),
      Tab(text: 'Node'),
      Tab(text: 'Runs'),
      Tab(text: 'Items'),
    ];
    super.onInit();
  }

  void playSoundEffect() async {
    final player = AudioPlayer();
    await player.play(AssetSource(AppConstants.comingSoonSound));
  }

  @override
  void onReady() {
    isLoading = false;
    update();
    super.onReady();
  }
}
