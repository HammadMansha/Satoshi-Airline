import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:satoshi/Controllers/landingpage_controller.dart';
import 'package:satoshi/routes/app_routes.dart';
import '../Utils/api.dart';
import '../Utils/commonSnackbar.dart';
// import '../Views/AuthScreens/signup.dart';

class DeleteAccountController extends GetxController {
  bool isLoading = true;

  bool isChecked = false;
  bool isClock = false;
  int seconds = 59;
  var timer;

  final formKey = GlobalKey<FormState>();

  final formKey2 = GlobalKey<FormState>();
  var regExp;

  TextEditingController email = TextEditingController();
  TextEditingController code = TextEditingController();

  LandingPageController landingPageController =
      Get.find<LandingPageController>();

  final storage = GetStorage();

  @override
  void onInit() {
    email.text = landingPageController.user['email'];
    update();
    super.onInit();
  }

  @override
  void onReady() {
    isLoading = false;
    update();
    super.onReady();
  }

  Future<void> getOTP() async {
    try {
      print("FUnction OTP Call");
      isLoading = true;
      update();
      var res = await http.post(
        Uri.parse(ApiData.baseUrl + ApiData.loginSignupCode),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          "email": email.text,
          "reason": "deleteAccount",
        }),
      );
      var data = await json.decode(res.body);
      print("check data otp $data");
      if (data['message'].toString() == 'Email code sent') {
        isClock = true;
        startTimer();
        isLoading = false;
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
        isLoading = true;
        update();
        print("Api Error $data");
      }
    } catch (e) {
      isLoading = false;
      update();
      print("Error  throw ${e.toString()}");
    }
  }

  Future<void> deleteAccount() async {
    try {
      print("FUnction OTP Call");
      isLoading = true;
      String token = await storage.read('token');
      var res = await http.post(
        Uri.parse(ApiData.baseUrl + ApiData.deleteAccount),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': token,
        },
        body: json.encode({
          "email": email.text,
          "emailCode": code.text,
        }),
      );
      var data = await json.decode(res.body);
      print("check data otp $data");
      if (data['showableMessage'] ==
          'Your account has been deleted successfully') {
        await storage.erase();
        isLoading = false;
        Get.offAllNamed(Routes.signupRoutes);
        // Get.offAll(() => const SignUp());
        CommonToast.getToast(
          'Account deleted successfully. please login again',
        );
        // CommonSnackbar.getSnackbar(
        //   "Success",
        //   "Account deleted successfully. please login again",
        //   Colors.green,
        // );
      } else {
        isLoading = false;
        CommonToast.getToast(
          '${data['showableMessage'].toString()}',
        );
        // CommonSnackbar.getSnackbar(
        //   "Success",
        //   data['showableMessage'].toString(),
        //   Colors.blue,
        // );
      }
      isLoading = false;
    } catch (e) {
      isLoading = false;
      print("Error  throw ${e.toString()}");
    }
  }

  startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (seconds > 0) {
        seconds--;
        update();
      } else {
        isClock = false;
        update();
      }
    });
  }
}
