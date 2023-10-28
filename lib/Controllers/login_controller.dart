import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:satoshi/routes/app_routes.dart';

import '../Utils/api.dart';
import '../Utils/commonSnackbar.dart';
// import '../Views/Landing/landing.dart';

class LoginController extends GetxController {
  bool isLoading = false;

  final formKey2 = GlobalKey<FormState>();
  final formKey = GlobalKey<FormState>();
  
  bool isPasswordNotVisible = true;
  bool isChecked = false;

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  final storage = GetStorage();

  @override
  void onReady() {
    isLoading = false;
    update();
    super.onReady();
  }

  Future<void> login() async {
    try {
      isLoading = true;
      update();
      var res = await http.post(
        Uri.parse(ApiData.baseUrl + ApiData.login),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(
          {"email": email.text, "password": password.text},
        ),
      );
      var data = json.decode(res.body);
      print("check data otp $data");
      if (data['showableMessage'] == 'You have successfully logged in') {
        await storage.write("userId", data['data']['userId']);
        await storage.write("token", data['data']['token']);
        isLoading = false;
        update();
        Get.offAllNamed(Routes.landingRoutes);
        // Get.offAll(() => const LandingPage());
        CommonToast.getToast(
          ' Account login successfully',
        );
        // CommonSnackbar.getSnackbar(
        //   "Success",
        //   "Account login successfully",
        //   Colors.green,
        // );
      } else {
        isLoading = false;
        update();
        print("Api Error $data");
      }
    } catch (e) {
      isLoading = false;
      update();
    }
  }
}
