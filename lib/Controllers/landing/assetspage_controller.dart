import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../Utils/app_constants.dart';
import '../../Utils/commonSnackbar.dart';
import '../landingpage_controller.dart';
import 'miniting_globle.dart';

class AssetsPageController extends GetxController {
  bool isLoading = true;
  String assetImage = '';
  int selectedIndex = 0;

  MinitingGlobleController minitingGlobleController =
      Get.put(MinitingGlobleController(), permanent: true);
  MinitingGlobleController mgc = Get.find<MinitingGlobleController>();

  LandingPageController landingPageController =
      Get.find<LandingPageController>();

  final storage = GetStorage();

  int indexing = 0;
  List<Tab> myTabs = [];
  RxList nftDaTA = [].obs;

  @override
  void onInit() {
    landingPageController.tokenBalance;
    print(
        'landingPageController.tokenBalance ${landingPageController.tokenBalance.toString()}');
    landingPageController.balanceInBNB;
    print(
        'landingPageController.balanceInBNB ${landingPageController.balanceInBNB.toString()}');
    minitingGlobleController.getUserNftData();
    myTabs = const [
      Tab(text: 'Plane'),
      Tab(text: 'Node'),
      Tab(text: 'Runes'),
      Tab(text: 'Items'),
    ];
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

  Future<void> pullRefresh() async {
    // landingPageController.isLoading.obs();
    landingPageController.minitingGlobleController.assetsData.clear();
    landingPageController.minitingGlobleController.update();
    await landingPageController.minitingGlobleController
        .getUserNftData(recall: true);
    CommonToast.getToast('Wait, data fetching...');
  }
}
