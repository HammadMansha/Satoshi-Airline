import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:satoshi/Controllers/landingpage_controller.dart';
import 'package:satoshi/Utils/commonSnackbar.dart';

import '../Utils/api.dart';

class ExtraPageController extends GetxController {
  bool isLoading = true;
  RxInt selectedValue = 0.obs;
  String assetImage = '';

  TextEditingController amount = TextEditingController();

  String type = '';

  final storage = GetStorage();

  LandingPageController landingPageController =
      Get.find<LandingPageController>();

  @override
  void onInit() {
    amount.text = storage.read("wallet");
    update();
    super.onInit();
  }

  @override
  void onReady() {
    isLoading = false;
    update();
    super.onReady();
  }

  Future<void> transferMint() async {
    try {
      isLoading = true;
      update();
      var b = {"to": amount.text, "type": type.toLowerCase()};
      print("body $b");
      String token = await storage.read('token');
      var res = await http.post(
        Uri.parse(ApiData.baseUrl + ApiData.transferMint),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': token,
        },
        body: json.encode(
          {"to": amount.text, "type": type.toLowerCase()},
        ),
      );
      var data = json.decode(res.body);
      if (res.statusCode >= 200 && res.statusCode <= 300) {
        if (kDebugMode) {
          print("Check Result $data");
        }
        landingPageController.isLoading = true;
        landingPageController.update();
        await landingPageController.getBalance();
        landingPageController.isLoading = false;
        landingPageController.update();
        isLoading = false;
        update();
        Get.back();
        CommonToast.getToast(
          '${data['showableMessage']}',
        );
      } else {
        if (kDebugMode) {
          print("Check Result $data");
        }
        CommonToast.getToast(
          '${data['showableMessage']}',
        );
        isLoading = false;
        update();
      }
    } catch (e) {
      isLoading = false;
      update();
      if (kDebugMode) {
        print("Check Error ${e.toString()}");
      }
    }
  }
}
