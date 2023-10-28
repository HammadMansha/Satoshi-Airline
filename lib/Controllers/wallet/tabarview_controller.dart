import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:satoshi/Services/sqflite_services.dart';
import 'package:satoshi/Views/Wallet/lock_screens/create_password_screen.dart';
import '../../Services/storage_services.dart';
import '../../Views/Wallet/lock_screens/lock_screen.dart';
import '../../Views/Wallet/setting_screens/setting_screeen_one.dart';

class TabbarViewController extends GetxController
    with GetTickerProviderStateMixin {
  final storage = GetStorage();
  bool isLoading = true;
  TabController? tabController;
  List userDataList = [];

  @override
  void onInit() {
    tabController = TabController(length: 2, vsync: this);
    update();
    super.onInit();
  }

  @override
  void onReady() async {
    isLoading = false;
    await checkPasswordOnDB();
    update();
    super.onReady();
  }

  void checkPassword() async {
    if (userDataList.isEmpty) {
      Get.to(() => const CreateLOckScreen());
    } else {
      // Get.to(() => const SettingScreenMain());
      Get.to(() => LockScreen());
    }

    // final storedPassword = await PasswordStorage().getPassword();
    // if (storedPassword != null && storedPassword.isNotEmpty) {

    // } else {
    //   // Password is not stored, navigate to the lock screen
    //   Get.to(() => const LockScreen())?.then((value) async {
    //     // After returning from the lock screen, check if the password was entered correctly
    //     if (value == true) {
    //       await PasswordStorage().savePassword('000000');
    //       Get.off(() => const SettingScreenMain());
    //     } else {
    //       // _.passwordStorage.clearPassword();
    //     }
    //   });
    // }
  }

  Future<void> checkPasswordOnDB() async {
    try {
      var data = await SQLHelper.getInfoById(storage.read('userId'));
      userDataList = data;
      update();
      print("Check Data $data");
    } catch (e) {
      print("Error ${e.toString()}");
    }
  }
}
