import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:satoshi/Controllers/profile_controller.dart';
import 'package:satoshi/widget/wallet_widgets/common_toast_message.dart';
import '../../Utils/api.dart';
import '../../Utils/commonSnackbar.dart';
import '../../Views/Profile/profile.dart';

class DisableAuthController extends GetxController {
  bool isLoading = false;

  final formKey1 = GlobalKey<FormState>();

  int seconds = 180;
  bool isClock = false;
  Timer? countdownTimer;
  TextEditingController emailVerifyCode = TextEditingController();
  TextEditingController googleAuthCode = TextEditingController();

  ProfileController controller = Get.find<ProfileController>();

  final storage = GetStorage();

  Future<void> sendEmailCode() async {
    try {
      String token = await storage.read('token');
      isLoading = true;
      update();
      var res = await http.post(
        Uri.parse(ApiData.verify2FAEmailCode),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': token,
        },
        body: json.encode(
          {"userId": storage.read('userId'), "reason": "verified2fa"},
        ),
      );
      print("hellllllllllllllllooooooooooooooooooooooooooooooo");
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
        // isClock = true;
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

  //-----------------Verify 2FA----------------
  Future<void> delete2FA() async {
    try {
      print('hello g');
      String token = await storage.read('token');
      // isLoading = true;
      // update();
      print('${emailVerifyCode.text}');
      print('${storage.read('userId')}');

      var res = await http.post(
        Uri.parse(ApiData.disableGoogleAuth),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': token,
        },
        body: json.encode({
          "emailCode": emailVerifyCode.text,
          "userId": storage.read('userId'),
        }),
      );
      print("update google auth ");
      var data = json.decode(res.body);
      print("status code---------------${res.statusCode}");
      print("response of api---------------$data");

      if (res.statusCode == 200) {

        controller.onInit();
        controller.update();
        ShowToastMessage('Authentication Successfully Disable');

        Get.back();
      } else if (res.statusCode == 400) {
        ShowToastMessage('Invalid code');
      }
    } catch (e) {
      print("Error: ${e.toString()}");
    } finally {
      isLoading = false;
      update();
    }
  }

  @override
  void onReady() async {
    // TODO: implement onReady
    super.onReady();
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
