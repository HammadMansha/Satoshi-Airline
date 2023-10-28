import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:satoshi/Services/sqflite_services.dart';
import 'package:satoshi/Utils/commonSnackbar.dart';
import 'package:satoshi/Views/Wallet/setting_screens/setting_screeen_one.dart';
import '../../Services/storage_services.dart';

class LockScreenController extends GetxController {
  final PasswordStorage passwordStorage = PasswordStorage();
  String enteredPin = '';
  bool isFirstTime = true;

  final storage = GetStorage();
  List userDataList = [];

  @override
  void onReady() async {
    await checkPasswordOnDB();
    super.onReady();
  }

  void onDigitPress(String digit, BuildContext context) async {
    if (enteredPin.length < 6) {
      enteredPin += digit;
      update();
      print("Digits $enteredPin");
    }

    if (enteredPin.length == 6) {
      if (enteredPin == userDataList[0]['userPassword']) {
        Get.off(() => const SettingScreenMain());
      } else {
        CommonToast.getToast("Password does not match");
      }
    }
  }


  void onBackspacePress() {
    if (enteredPin.isNotEmpty) {
      enteredPin = enteredPin.substring(0, enteredPin.length - 1);
      update();
    }
  }

  Widget buildPinDisplay() {
    const int pinLength = 6; // Specify the length of your PIN
    const double boxSize = 17.0;
    // Specify the desired size of each box

    return SizedBox(
      // color: Colors.red,
      height: Get.height / 11,
      width: Get.width,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: pinLength,

          mainAxisSpacing: 16.0,
          crossAxisSpacing: 16.0,
          // childAspectRatio: 1.0,
        ),
        physics: const AlwaysScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: pinLength,
        itemBuilder: (context, index) {
          return Container(
            width: boxSize,
            height: boxSize,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(),
            ),
            child: Center(
              child: Text(
                (index < enteredPin.length) ? '*' : '',
                style: const TextStyle(fontSize: 10.0),
              ),
            ),
          );
        },
      ),
    ).marginOnly(left: 100, right: 100);
  }

  Widget buildBackspaceButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(side: BorderSide.none),
        foregroundColor: Colors.white,
        backgroundColor: const Color(0xff62C8A9), // Set the text color to black
      ),
      onPressed: onBackspacePress,
      child: Icon(Icons.backspace),
    );
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
