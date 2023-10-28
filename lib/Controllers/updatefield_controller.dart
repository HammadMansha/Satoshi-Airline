import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:satoshi/Controllers/landingpage_controller.dart';
import 'package:http/http.dart' as http;
import 'package:satoshi/Utils/commonSnackbar.dart';

import '../Utils/api.dart';

class UpdateFieldController extends GetxController {
  bool isLoading = true;

  final storage = GetStorage();

  String assetImage = '';

  LandingPageController landingPageController =
      Get.find<LandingPageController>();

  TextEditingController username = TextEditingController();

  final formKey2 = GlobalKey<FormState>();

  NumberFormat myFormat = NumberFormat.decimalPattern('en_us');

  @override
  void onInit() {
    username.text = landingPageController.user['name'] ?? '';
    update();
    super.onInit();
  }

  @override
  void onReady() {
    isLoading = false;
    update();
    super.onReady();
  }

  Future<void> updateName() async {
    try {
      isLoading = true;
      update();
      String id = await storage.read("userId");
      String token = await storage.read('token');
      var res = await http.patch(
        Uri.parse(ApiData.baseUrl + ApiData.updateUser),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': token,
        },
        body: json.encode(
          {
            "userId": id,
            "name": username.text,
          },
        ),
      );
      var data = json.decode(res.body);
      print("check update Data $data");
      if (res.statusCode >= 200 && res.statusCode <= 300) {
        landingPageController.isLoading = true;
        landingPageController.update();
        await landingPageController.getUser();
        landingPageController.isLoading = false;
        landingPageController.update();
        isLoading = false;
        update();
        Get.back();
        // Get.back();
        // Get.back();
        CommonToast.getToast(
          'Profile updated successfully',
        );
        // CommonSnackbar.getSnackbar(
        //   "Success",
        //   "Profile updated successfully",
        //   Colors.green,
        // );
      } else {
        isLoading = false;
        update();
        CommonToast.getToast(
          '${data['showableMessage'].toString()}',
        );
        // CommonSnackbar.getSnackbar(
        //   "Warning",
        //   data['showableMessage'].toString(),
        //   Colors.blue,
        // );
      }
    } catch (e) {
      isLoading = false;
      update();
    }
  }
}
