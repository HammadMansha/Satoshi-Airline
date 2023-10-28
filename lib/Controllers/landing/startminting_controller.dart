import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../../Utils/api.dart';
import '../../Utils/app_constants.dart';
import '../../Utils/commonSnackbar.dart';
import '../../Views/AuthScreens/signup.dart';
import '../landingpage_controller.dart';

class StartMintingController extends GetxController {
  bool isLoading = true;

  Rx<TextEditingController> avalue = TextEditingController().obs;

  LandingPageController landingPageController =
      Get.find<LandingPageController>();

  final storage = GetStorage();
  Map nftData = {};
  String imagePath = '';
  var id;

  List<Tab> myTabs = [];

  int indexing = 0;

  @override
  void onInit() async {
    myTabs = [
      const Tab(text: 'Basic'),
      const Tab(text: 'Pro'),
      Tab(
          icon: Image.asset(
        AppConstants.helpIcon,
        height: 17,
      )),
    ];
    update();
    if (Get.arguments != null) {
      imagePath = Get.arguments['path'];
      id = await Get.arguments['id'];
      update();
      await getAttributes(storage.read('session_token_id'));
    }
    super.onInit();
  }

  @override
  void onReady() {
    isLoading = false;
    super.onReady();
  }

  Future<void> getAttributes(var v) async {
    try {
      String token = await storage.read('token');
      var res = await http.get(
        Uri.parse(ApiData.baseUrl + ApiData.getAttributes + v.toString()),
        headers: {
          'Authorization': token,
          'Content-Type': 'application/json',
        },
      );
      var data = json.decode(res.body);
      if (kDebugMode) {
        print("Check data $data");
      }
      if (res.statusCode >= 200 && res.statusCode <= 300) {
        nftData.addAll(data["data"]);
        isLoading = false;
        update();
      } else {
        if (data['message'] == 'Invalid authentication token') {
          await storage.erase();
          Get.offAll(() => const SignUp());
          CommonToast.getToast(
            'Your token is expire please login again',
          );
          // CommonSnackbar.getSnackbar(
          //   "Info",
          //   "your token is expire please login again",
          //   Colors.amber,
          // );
        }
        isLoading = false;
        update();
      }
    } catch (e) {
      print("check error ${e.toString()}");
      isLoading = false;
      update();
    }
  }

  Future<void> updateAttribute(String a) async {
    try {
      isLoading = true;
      update();
      String token = await storage.read('token');
      String uid = await storage.read("userId");
      String address = await storage.read('wallet');
      if (kDebugMode) {
        print("Wallet Address $address");
        print("User id $uid");
      }
      var b = {
        "userId": uid,
        "tokenId": id.toString(),
        "attribute": a.toLowerCase(),
        "upgradeValue": avalue.value.text,
      };
      int c = int.parse(avalue.value.text);
      print("check Data $b");
      var res = await http.post(
        Uri.parse(ApiData.baseUrl + ApiData.buyAttributes),
        headers: {
          'Authorization': token,
          'Content-Type': 'application/json',
        },
        body: json.encode({
          "userId": uid,
          "tokenId": id.toString(),
          "attribute": a.toLowerCase(),
          "upgradeValue": c,
        }),
      );
      var data = await json.decode(res.body);
      if (res.statusCode >= 200 && res.statusCode < 300) {
        await getAttributes(id);
        isLoading = false;
        update();
        CommonToast.getToast(
          '${data['showableMessage']}',
        );
        // CommonSnackbar.getSnackbar(
        //     "Success", data['showableMessage'], Colors.green);
      } else {
        isLoading = false;
        update();
        CommonToast.getToast(
          '${data['showableMessage']}',
        );
        //   CommonSnackbar.getSnackbar(
        //       "ERROR", data['showableMessage'], Colors.red);
      }
    } catch (E) {
      isLoading = false;
      update();
    }
  }
}
