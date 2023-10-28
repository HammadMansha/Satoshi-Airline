import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:satoshi/Controllers/wallet/tabarview_controller.dart';
import 'package:satoshi/Services/sqflite_services.dart';
import 'package:satoshi/Utils/commonSnackbar.dart';

class CreateLockScreenController extends GetxController {
  bool isLoading = true;

  String enteredPin = '';
  bool isFirstTime = true;
  bool isCreatingPassword = true;
  bool isConfirming = false;

  final storage = GetStorage();

  TabbarViewController tabbarViewController = Get.find<TabbarViewController>();

  @override
  void onReady() async {
    // await createPassword();
    isLoading = false;
    update();
    super.onReady();
  }

  void onDigitPress(String digit) async {
    if (isConfirming) {
      enteredPin += digit;
    } else {
      enteredPin += digit;
    }
    update();

    print("Password ${enteredPin}");
    if (enteredPin.length == 6) {
      await createPassword();
    }

    if (enteredPin.length == 6) {
      if (isFirstTime) {
        if (isConfirming) {
          // if (enteredPin == box.read('password')) {
          //   // Password confirmed
          //   Get.to(() => const SettingScreenMain());
          // } else {
          //   enteredPin = '';
          //   showErrorDialog(
          //     'Password Mismatch',
          //     'Passwords do not match. Please try again.',
          //   );
          // }
        } else {
          isConfirming = true;
          enteredPin = '';
          isCreatingPassword = false;
          // Save the password when it's first created
          // box.write('password', enteredPin);
        }
      } else {
        // if (enteredPin == box.read('password')) {
        //   // Correct password, navigate to the setting screen
        //   // Get.to(() => const SettingScreenMain());
        // } else {
        //   enteredPin = '';
        //   showErrorDialog('Incorrect PIN', 'Please try again.');
        // }
      }
    }
  }

  void onBackspacePress() {
    if (enteredPin.isNotEmpty) {
      enteredPin = enteredPin.substring(0, enteredPin.length - 1);
      update();
    }
  }

  Future<void> createPassword() async {
    try {
      isLoading = true;
      update();
      if(tabbarViewController.userDataList.length==0) {
        await SQLHelper.createInfo(storage.read('userId'), enteredPin)
            .then((value) async {
          await tabbarViewController.checkPasswordOnDB();
          Get.back();
          CommonToast.getToast("Password Created Successfully");
        });
      }
      else{
        await SQLHelper.updateInfo(storage.read('userId'), enteredPin).then((value) async {
          await tabbarViewController.checkPasswordOnDB();
          Get.back();
          Get.back();
          CommonToast.getToast("Password Changed Successfully");
        });
      }


    } catch (e) {
      isLoading = false;
      update();
      print("error");
    }
  }

  // Get Data in Db
  // Future<void> createPassword() async {
  //   String userId = await storage.read('key');
  //   var data = await SQLHelper.getInfoById(userId);
  //   print("data is $data");
  // }
}
