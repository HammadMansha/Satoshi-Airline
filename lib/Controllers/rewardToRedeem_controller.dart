import 'dart:convert';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:satoshi/Controllers/landingpage_controller.dart';

import '../Utils/api.dart';
import '../Utils/app_constants.dart';

class RewardToRedeemController extends GetxController {
  bool isLoading = true;
  bool showScreen = true;

  String assetImage = '';
  Map rewardData = {};

  final storage = GetStorage();
  LandingPageController landingPageController =
      Get.find<LandingPageController>();

  NumberFormat myFormat = NumberFormat.decimalPattern('en_us');

  @override
  void onInit() async {
    // landingPageController.isStopped = true;
    // landingPageController.update();
    storage.remove('checkout_complete');
    if (Get.arguments != null) {
      print("check Value from ${Get.arguments['from']}");
      print("check Value to ${Get.arguments['to']}");
      print("check Value distance ${Get.arguments['distance']}");
      print("check Value tokenId ${Get.arguments['tokenId']}");
      print("check Value time ${Get.arguments['time']}");
      await reward(
        Get.arguments['from'],
        Get.arguments['to'],
        Get.arguments['distance'],
        Get.arguments['tokenId'],
        Get.arguments['time'],
      );
    }
    super.onInit();
  }

  @override
  void onReady() {
    showScreen;
    update();
    isLoading = false;
    update();
    super.onReady();
  }

  Future<void> reward(String f, String t, var d, String id, String time) async {
    try {
      if (kDebugMode) {
        print("function Call");
      }
      rewardData.clear();
      update();
      String token = await storage.read('token');
      var res = await http.post(Uri.parse(ApiData.baseUrl + ApiData.record),
          headers: {
            'Authorization': token,
            'Content-Type': 'application/json',
          },
          body: json.encode({
            "from": f,
            "to": t,
            "distance": d,
            "tokenId": id,
            "wallet": storage.read("wallet"),
            "time": time,
            "userId": storage.read('userId'),
            "referralCode": storage.hasData("invite_code")
                ? storage.read("invite_code")
                : '',
          }));
      var data = json.decode(res.body);
      if (kDebugMode) {
        print("Check data $data");
      }
      if (res.statusCode >= 200 && res.statusCode <= 300) {
        rewardData.addAll(data);
        storage.remove('invite_code');
        isLoading = false;
        update();
        if (landingPageController.isSound) {
          playSoundEffect();
        }
        // print(nftData);
      } else {
        isLoading = false;
        update();
      }
    } catch (e) {
      if (kDebugMode) {
        print("check Data ${e.toString()}");
      }
      isLoading = false;
      update();
    }
  }

  // void playSoundEffect() async {
  //   final player = AudioPlayer();
  //   await player.play(AssetSource(AppConstants.redeemSound));
  // }
  void playSoundEffect() async {
    final player = AudioPlayer();
    await player.play(AssetSource(AppConstants.checkInSound));
  }
}
