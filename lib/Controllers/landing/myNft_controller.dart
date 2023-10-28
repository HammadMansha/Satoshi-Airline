// ignore_for_file: file_names

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:satoshi/Controllers/landing/miniting_globle.dart';
import 'package:satoshi/Controllers/landing/minitng_controller.dart';
import 'package:http/http.dart' as http;
import 'package:satoshi/Utils/commonSnackbar.dart';
import '../../Utils/api.dart';

class MyNftController extends GetxController {
  bool isLoading = true;

  MinitingGlobleController minitingGlobleController =
      Get.find<MinitingGlobleController>();
  MintingController mintingController = Get.find<MintingController>();

  TextEditingController transferController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  // ignore: prefer_typing_uninitialized_variables
  var regExp;
  bool validator = false;

  final storage = GetStorage();

  @override
  void onReady() async {
    isLoading = false;
    update();
    super.onReady();
  }

  // Future<void> transferMint(var tokenID) async {
  //   try {
  //     print("Function call");
  //     isLoading = true;
  //     update();
  //     await minitingGlobleController
  //         .transfer(mintingController.connector, storage.read("wallet"),
  //             transferController.text, tokenID)
  //         .then((value) async {
  //       print("check Data is $value");
  //       if (value != null) {
  //         minitingGlobleController.assetsData.clear();
  //         minitingGlobleController.update();
  //         await minitingGlobleController
  //             .getWalletOfOwner(storage.read("wallet"));
  // Get.back();
  // Get.back();
  //         CommonSnackbar.getSnackbar("Success", "Mint transfer successfully", Colors.green);
  //         isLoading = false;
  //         update();
  //       } else {
  //         CommonSnackbar.getSnackbar("Warning", "something went wrong please try again", Colors.blue);
  //         isLoading = false;
  //         update();
  //       }
  //     });
  //     isLoading = false;
  //     update();
  //   } catch (e) {
  //     isLoading = false;
  //     update();
  //   }
  // }
}
