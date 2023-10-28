import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AssetsScreenController extends GetxController {
  bool isLoading = true;

  List<Tab> myTabs = [];
  bool isPressed = false;
  double value = 0.5;

  String assetImage = '';

  @override
  void onInit() {
    myTabs = const [
      Tab(text: 'plane'),
      Tab(text: 'Node'),
      Tab(text: 'Runs'),
      Tab(text: 'items'),
    ];
    super.onInit();
  }

  @override
  void onReady() {
    isLoading = false;
    update();
    super.onReady();
  }
}
