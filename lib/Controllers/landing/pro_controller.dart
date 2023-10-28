import 'package:get/get.dart';
import 'package:satoshi/Controllers/landing/miniting_globle.dart';

import '../landingpage_controller.dart';

class ProController extends GetxController {
  bool isLoading = true;

  List items = [];
  List<String> itemsCur = [];
  List<String> itemsUpg = [];
  List imageItems = [];

  String dropdownvalue = ' Fuel';
  String dropdownCur = ' 90';
  String dropdownUpg = ' 60';

  MinitingGlobleController minitingGlobleController =
      Get.find<MinitingGlobleController>();

  LandingPageController landingPageController = Get.find<LandingPageController>();

  @override
  void onInit() {
    items = [
      ' Fuel',
      ' Mine',
      ' Durability',
      ' Luck',
    ];
    itemsCur = [
      ' 90',
      ' 80',
      ' 30',
      ' 50',
    ];
    itemsUpg = [
      ' 60',
      ' 70',
      ' 71',
      ' 72',
    ];
    imageItems = [
      "assets/icons/fuelIcon.png",
      "assets/icons/mineIcon.png",
      "assets/icons/durabilityIcon.png",
      "assets/icons/luckyIcon.png",
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
