// ignore: file_names
import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:satoshi/Controllers/landingpage_controller.dart';

import '../../../utils/app_constants.dart';



class RedeemSuccessFerryController extends GetxController {
  bool isLoading = true;
  bool showPic = true;

  String assetImage = '';

  String price = '';

  LandingPageController landingPageController =
  Get.find<LandingPageController>();
  // AssetsPageController assetsPageController = Get.find<AssetsPageController>();

  final storage = GetStorage();

  @override
  void onInit() {
    storage.remove('session_lat');
    storage.remove('session_lng');
    storage.remove('session_tolat');
    storage.remove('session_tolng');
    if (Get.arguments != null) {
      price = Get.arguments;
      update();
    }
    super.onInit();
  }

  @override
  void onReady() async {
    showPic;
    update();
    landingPageController.isLoading = true;
    landingPageController.update();
    await landingPageController.getBalance();
    landingPageController.isLoading = false;
    landingPageController.update();
    isLoading = false;
    update();
    if(landingPageController.isSound)
    {
      playSoundEffect();
    }
    super.onReady();
  }
  void playSoundEffect() async {
    final player = AudioPlayer();
    await player.play(AssetSource(AppConstants.redeemSound));
  }
}
