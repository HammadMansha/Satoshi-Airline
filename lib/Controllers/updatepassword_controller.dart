import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:satoshi/Controllers/landingpage_controller.dart';
import 'package:http/http.dart' as http;
import '../Utils/api.dart';
import '../Utils/commonSnackbar.dart';
import '../Views/AuthScreens/signup.dart';

class UpdatePasswordController extends GetxController {
  RxBool isLoading = true.obs;
  bool isPasswordNotVisible = true;
  bool isClock = false;

  final storage = GetStorage();

  final formKey3 = GlobalKey<FormState>();
  final formKey2 = GlobalKey<FormState>();
  final formKey = GlobalKey<FormState>();

  var regExp;
  int seconds = 59;
  var timer;

  LandingPageController landingPageController =
      Get.find<LandingPageController>();

  TextEditingController email = TextEditingController();
  TextEditingController code = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  void onInit() {
    email.text = landingPageController.user['email'] ?? '';
    super.onInit();
  }

  @override
  void onReady() {
    isLoading.value = false;
    update();
    super.onReady();
  }

  startTimer() {
    timer = Timer.periodic(
      const Duration(seconds: 1),
      (_) {
        if (seconds > 0) {
          seconds--;
          update();
        } else {
          isClock = false;
          // startTimer();
          update();
        }
      },
    );
  }

  Future<void> getOTP() async {
    try {
      print("FUnction OTP Call");
      isLoading.value = true;
      update();
      var res = await http.post(
        Uri.parse(ApiData.baseUrl + ApiData.loginSignupCode),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          "email": email.text,
          "reason": "updatePassword",
        }),
      );
      var data = await json.decode(res.body);
      print("check data otp $data");
      if (data['message'].toString() == 'Email code sent') {
        isClock = true;
        startTimer();
        isLoading.value = false;
        update();
        CommonToast.getToast(
          'Please check your email',
        );
        // CommonSnackbar.getSnackbar(
        //   "Success",
        //   "Please check your email",
        //   Colors.green,
        // );
      } else {
        isLoading.value = true;
        update();
        print("Api Error $data");
      }
    } catch (e) {
      isLoading.value = false;
      update();
      print("Error  throw ${e.toString()}");
    }
  }

  Future<void> updatePassword() async {
    try {
      print("FUnction OTP Call");
      isLoading.value = true;
      String token = await storage.read('token');
      var res = await http.post(
        Uri.parse(ApiData.baseUrl + ApiData.updatePassword),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': token,
        },
        body: json.encode({
          "email": email.text,
          "emailCode": code.text,
          "password": password.text
        }),
      );
      var data = await json.decode(res.body);
      print("check data otp $data");
      if (data['showableMessage'] ==
          'Your password has been updated successfully') {
        await storage.erase();
        isLoading.value = false;
        Get.offAll(() => const SignUp());
        CommonToast.getToast(
          'Password change successfully',
        );
        // CommonSnackbar.getSnackbar(
        //   "Success",
        //   "Password change successfully",
        //   Colors.green,
        // );
      } else {
        isLoading.value = false;
        CommonToast.getToast(
          '${data['showableMessage'].toString()}',
        );
        // CommonSnackbar.getSnackbar(
        //   "Success",
        //   data['showableMessage'].toString(),
        //   Colors.green,
        // );
      }
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      print("Error  throw ${e.toString()}");
    }
  }

}
