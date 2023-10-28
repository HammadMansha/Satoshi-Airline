import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:satoshi/Utils/api.dart';
import 'package:satoshi/Utils/commonSnackbar.dart';
import '../../widget/wallet_widgets/common_toast_message.dart';
import '../tabview_controller.dart';
import 'create_waller_controller.dart';
import 'package:http/http.dart' as http;

class VerifyWalletController extends GetxController {
  bool isLoading = false;
  bool isClock = false;
  CreateWalletController walletController = Get.find<CreateWalletController>();
  TabviewController tabviewController = Get.put(TabviewController());
  final formKey = GlobalKey<FormState>();
  final formKey2 = GlobalKey<FormState>();
  var regExp;
  TextEditingController emailCode = TextEditingController();
  int seconds = 180;
  Timer? countdownTimer;
  final storage = GetStorage();

  List<String> button = [
    "Button 1",
    "Button 2",
    "Button 3"
  ]; // Your button titles
  List<String> a = [];
  List<String> mnemonicData = [];

  VerifyWalletController(this.mnemonicData);

  void handleButtonPressed(String title) {
    print('Button pressed: $title');
    toggleData(title);
  }

  @override
  void onReady() {
    verifyMnemonic();
    update();
    areAllButtonsPressed();
    update();
    super.onReady();
  }


  void toggleData(String c) {
    if (a.contains(c)) {
      a.remove(c);
    } else {
      a.add(c);
    }
    update();
  }

  bool isData(String c) {
    return a.contains(c);
  }

  String listValue() {
    return a.join(' ');
  }

  bool areAllButtonsPressed() {
    for (String title in button) {
      if (!isData(title)) {
        return false;
      }
    }
    return true;
  }

  Future<void> verifyMnemonic() async {
    bool areEqual = true;

    // Check if the lengths of a and mnemonicData are equal
    if (a.length != mnemonicData.length) {
      areEqual = false;
    } else {
      // Check each element of a against mnemonicData
      for (int i = 0; i < a.length; i++) {
        if (a[i] != mnemonicData[i]) {
          areEqual = false;
          break;
        }
      }
    }

    if (areEqual) {
      // Proceed with email code verification
      bool emailVerificationSuccessful = await verifysendEmailCode();

      if (emailVerificationSuccessful) {
        await storage.write('public_key', walletController.publicKey.value);
        await storage.write('private_key', walletController.private.value);
        print("Private Key: ${walletController.private.value}");
        print("Public Key: ${walletController.publicKey.value}");
        tabviewController.isLoading = true;
        tabviewController.update();
        tabviewController.isLoading = false;
        tabviewController.update();
        // ShowToastMessage('Very Good! Account Created');
        Get.back();
        Get.back();
        Get.back();
        // Get.back();
        // // Get.back();
        // Get.offAll(() => TababarView());
      } else {
        // ShowToastMessage('Email Code Verification Failed');
      }
    } else {
      // ShowToastMessage('Please Enter Correct Phrase');
    }
  }


  Future<void> sendEmailCode() async {
    try {
      String token = await storage.read('token');
      isLoading = true;
      update();
      var res = await http.post(
        Uri.parse(ApiData.baseUrl + ApiData.sendEmailCodeWallet),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': token,
        },
        body: json.encode(
          {"userId": storage.read('userId'), "reason": "create_wallet"},
        ),
      );
      var data = json.decode(res.body);
      if (res.statusCode >= 200 && res.statusCode <= 300) {
        isLoading = false;
        update();
        print("Data is $data");
        startTimer(); // Start the countdown timer
        isLoading = false;
        CommonToast.getToast("Please check your email");
        isClock = true;
        update();
      } else {
        isLoading = false;
        update();
        print("Data is $data");
        CommonToast.getToast("Something went wrong");
      }
    } catch (e) {
      isLoading = false;
      update();
      print("Errror is ${e.toString()}");
    }
  }

  Future<bool> verifysendEmailCode() async {
    try {
      String token = await storage.read('token');
      isLoading = true;
      update();
      var res = await http.post(
        Uri.parse(ApiData.baseUrl + ApiData.verifysendEmailCodeWallet),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': token,
        },
        body: json.encode(
          {
            "userId": storage.read('userId'),
            "reason": "create_wallet",
            'emailCode': emailCode.text
          },
        ),
      );
      var data = json.decode(res.body);
      if (res.statusCode >= 200 && res.statusCode <= 300) {
        isLoading = false;
        update();
        print("Data is $data");
        CommonToast.getToast("Account Created Successfully");
        return true; // Verification successful
      } else {
        isLoading = false;
        update();
        print("Data is $data");
        CommonToast.getToast("Something went wrong");
        return false; // Verification failed
      }
    } catch (e) {
      isLoading = false;
      update();
      print("Error is ${e.toString()}");
      return false; // Verification failed due to an error
    }
  }
  startTimer() {
    seconds = 180;
    isClock = true;
    update();

    countdownTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (seconds > 0) {
        seconds--;
        update();
      } else {
        stopTimer();
      }
    });
  }
  stopTimer() {
    countdownTimer?.cancel();
    isClock = false;
    update();
  }
}
