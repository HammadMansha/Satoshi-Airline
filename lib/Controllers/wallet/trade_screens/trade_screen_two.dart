
import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../../../Utils/app_asset_wallet.dart';


class TradeScreenTwoController extends GetxController {

  List dropdownList = [];

  TextEditingController selected = TextEditingController();
  TextEditingController selectedTwo = TextEditingController();

  @override
  void onInit() {
    dropdownList = [
      {
        "logo" : AppAssets.arbLogo,
        "name" : 'ARB',
      },
      {
        "logo" : AppAssets.sapLogo,
        "name" : 'SAP',
      },
      {
        "logo" : AppAssets.satLogo,
        "name" : 'SAT',
      },
      {
        "logo" : AppAssets.usdtLogo,
        "name" : 'USDT',
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

  final List<CustomDropdownItem> dropdownItems = [
    CustomDropdownItem(AppAssets.arbLogo, 'ARB'),
    CustomDropdownItem(AppAssets.sapLogo, 'SAP'),
    CustomDropdownItem(AppAssets.satLogo, 'SAT'),
    CustomDropdownItem(AppAssets.usdtLogo, 'USDT'),
  ];

  final Rx<CustomDropdownItem> selectedItem =
      CustomDropdownItem(AppAssets.arbLogo, 'ARB').obs;

  void selectItem(CustomDropdownItem? newValue) {
    selectedItem.value = newValue!;
    update();
  }
}

class CustomDropdownItem {
  final String text;
  final String imagePath;

  CustomDropdownItem(this.text, this.imagePath);
}


// items: <AssetImage>[
// const AssetImage(AppAssets.arbLogo),
// const AssetImage(AppAssets.sapLogo),
// const AssetImage(AppAssets.satLogo),
// const AssetImage(AppAssets.usdtLogo),
//
//
// ].map<DropdownMenuItem<AssetImage>>((value)