import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:satoshi/Controllers/landingpage_controller.dart';
import 'package:http/http.dart' as http;

import '../Utils/api.dart';
import '../Utils/app_constants.dart';
import '../Utils/commonSnackbar.dart';

class EditProfileController extends GetxController {
  bool isLoading = true;

  String assetImage = '';
  RxString gender = ''.obs;

  LandingPageController landingPageController =
      Get.find<LandingPageController>();

  final storage = GetStorage();

  List avatarList = [];
  List genderList = [];

  RxString selectedAvatar = ''.obs;
  RxString selectedGender = ''.obs;

  NumberFormat myFormat = NumberFormat.decimalPattern('en_us');

  @override
  void onInit() {
    genderList = [
      {
        "name": "male",
        "imagePath": AppConstants.avatarMale,
      },
      {
        "name": "female",
        "imagePath": AppConstants.avatarFemale,
      },
      {
        "name": "other",
        "imagePath": AppConstants.avatarOther,
      },
      {
        "name": "secret",
        "imagePath": AppConstants.avatarSecret,
      },
    ];
    gender.value = landingPageController.user['gender'] ?? '';
    update();
    selectedGender.value = landingPageController.user['gender'] ?? '';
    selectedAvatar.value = landingPageController.user['avatar'].toString() == 'null' ? '' : landingPageController.user['avatar']['_id'];
    super.onInit();
  }

  @override
  void onReady() async {
    await getAvatar();
    isLoading = false;
    update();
    super.onReady();
  }

  Future<void> getAvatar() async {
    try {
      avatarList.clear();
      update();
      String token = await storage.read('token');
      var res = await http.get(
        Uri.parse(ApiData.baseUrl + ApiData.getAvatar),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': token,
        },
      );
      var data = await json.decode(res.body);
      if (data['status'].toString() == "true") {
        data['avatars'].forEach((e) {
          avatarList.add(e);
        });
        isLoading = false;
        update();
      } else {
        isLoading = false;
        update();
      }
      Get.log("Check Data is $data");
    } catch (e) {
      isLoading = false;
      update();
    }
  }

  Future<void> setAvatar() async {
    try {
      isLoading = true;
      update();
      String id = await storage.read("userId");
      String token = await storage.read('token');
      var res = await http.patch(
        Uri.parse(ApiData.baseUrl + ApiData.setAvatar),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': token,
        },
        body: json.encode(
          {
            "userId": id,
            "avatarId": selectedAvatar.value,
          },
        ),
      );
      var data = await json.decode(res.body);
      if (kDebugMode) {
        print("check data $data");
      }
      if (res.statusCode >= 200 && res.statusCode <= 300) {
        landingPageController.isLoading = true;
        landingPageController.update();
        await landingPageController.getUser();
        landingPageController.isLoading = false;
        landingPageController.update();
        isLoading = false;
        update();
        // Get.back();
        // Get.back();
        CommonToast.getToast(
          'You have successfully set your avatar',
        );
      } else {
        isLoading = false;
        update();
      }
      Get.log("Check Data is $data");
    } catch (e) {
      print("check error ${e.toString()}");
      isLoading = false;
      update();
    }
  }

  Future<void> updateGender() async {
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
            "gender": selectedGender.value,
          },
        ),
      );
      var data = json.decode(res.body);
      if (data['showableMessage'].toString() ==
          'Profile updated successfully') {
        gender.value = selectedGender.value;
        landingPageController.isLoading = true;
        landingPageController.update();
        await landingPageController.getUser();
        landingPageController.isLoading = false;
        landingPageController.update();
        isLoading = false;
        update();
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
