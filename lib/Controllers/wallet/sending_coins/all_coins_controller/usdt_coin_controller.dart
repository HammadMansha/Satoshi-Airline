import 'dart:async';

import 'package:get/get.dart';

import '../../../../Utils/app_asset_wallet.dart';

class UsdtCoinController extends GetxController {
  bool isLoading = true;
  var isButtonClicked = false.obs;

  List image = [];
  List b = [];
  List c = [];

  @override
  void onInit() {
    image = [
      AppAssets.sapLogo,
      AppAssets.satLogo,
      AppAssets.arbLogo,
      AppAssets.usdtLogo,
    ];
    b = ['SAP', 'SAT', 'ARB', 'USDT'];
    c = [
      '0.00',
      '0.00',
      '0.00',
      '0.00',
    ];
    update();
    Timer(const Duration(seconds: 20), () {
      isButtonClicked.value = false;
      update();
    });
    super.onInit();
  }

  @override
  void onReady() {
    isLoading = false;
    update();
    super.onReady();
  }

  void handleButtonClick() {
    isButtonClicked.value = true;
  }
}
