// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';

// import '../../Views/Wallet/setting_screens/setting_screeen_one.dart';

// class CreateLockScreenController extends GetxController {
//   final box = GetStorage();


//   @override
//   void onReady() {
//     isFirstTime = !box.hasData('password');
//     update();
//     super.onReady();
//   }

//   void onDigitPress(String digit) {
//     if (isConfirming) {
//       enteredPin += digit;
//     } else {
//       enteredPin += digit;
//     }
//     update();

//     if (enteredPin.length == 6) {
//       if (isFirstTime) {
//         if (isConfirming) {
//           if (enteredPin == box.read('password')) {
//             // Password confirmed
//             Get.to(() => const SettingScreenMain());
//           } else {
//             enteredPin = '';
//             showErrorDialog(
//               'Password Mismatch',
//               'Passwords do not match. Please try again.',
//             );
//           }
//         } else {
//           isConfirming = true;
//           enteredPin = '';
//           isCreatingPassword = false;
//           // Save the password when it's first created
//           box.write('password', enteredPin);
//         }
//       } else {
//         if (enteredPin == box.read('password')) {
//           // Correct password, navigate to the setting screen
//           Get.to(() => const SettingScreenMain());
//         } else {
//           enteredPin = '';
//           showErrorDialog('Incorrect PIN', 'Please try again.');
//         }
//       }
//     }
//   }


//   void onBackspacePress() {
//     if (enteredPin.isNotEmpty) {
//       enteredPin = enteredPin.substring(0, enteredPin.length - 1);
//       update();
//     }
//   }

//   void showErrorDialog(String title, String content) {
//     Get.defaultDialog(
//       title: title,
//       middleText: content,
//       backgroundColor: Colors.white,
//       actions: [
//         ElevatedButton(
//           onPressed: () {
//             Get.back();
//           },
//           child: const Text('OK'),
//         ),
//       ],
//     );
//   }
// }
