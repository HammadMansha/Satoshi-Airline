
import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../../../Utils/app_asset_wallet.dart';


class TradeScreenOneController extends GetxController {

  List dropdownList = [];

  TextEditingController selected = TextEditingController();
  TextEditingController selectedTwo = TextEditingController();

  @override
  void onInit() {
    dropdownList = [
      {
        "logo": AppAssets.arbLogo,
        "name": 'ARB',
      },
      {
        "logo": AppAssets.sapLogo,
        "name": 'SAP',
      },
      {
        "logo": AppAssets.satLogo,
        "name": 'SAT',
      },
      {
        "logo": AppAssets.usdtLogo,
        "name": 'USDT',
      },
    ];



    update();
    super.onInit();
  }
  void swapDropdownValues() {
    String temp = selected.text;
    selected.text = selectedTwo.text;
    selectedTwo.text = temp;
    update();
  }


}

// items: <AssetImage>[
// const AssetImage(AppAssets.arbLogo),
// const AssetImage(AppAssets.sapLogo),
// const AssetImage(AppAssets.satLogo),
// const AssetImage(AppAssets.usdtLogo),
//
//
// ].map<DropdownMenuItem<AssetImage>>((value)